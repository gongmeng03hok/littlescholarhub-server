# -*- coding: utf-8 -*-
"""Generates robots.txt, sitemap.xml, and a distinct HTML shell per public route.

Why the per-route shells: `expo export` with output "single" emits ONE
index.html, and nginx handed that same file to every route. Measured against
Googlebot, /, /landing, /assessment, /register and /login were byte-identical -
same md5, same title, same description, 91 characters of visible text. Google
treats that as one page duplicated five times: it picks a canonical, drops the
rest, and has almost nothing to rank the survivor on.

Each route now gets its own title, description, canonical and Open Graph tags,
plus a <noscript> block of genuine copy. The JavaScript bundle is untouched and
still takes over on load, so the app behaves exactly as before - this only
changes what a crawler is handed before the app boots.

/login is deliberately noindex: a sign-in form has no business in search
results, and it was diluting the sitemap.
"""
import io, os, re, sys, datetime

ROOT = "/var/www/littlescholarhub/lsh.web"
PUBLIC = os.path.join(ROOT, "src/public")
SITE = "https://www.littlescholarhub.com"

# route -> (title, description, sitemap priority/changefreq or None to omit, noscript copy)
PAGES = {
    "/": (
        "Little Scholars Hub — one calm plan for TK–6",
        "A 2-minute assessment builds your child's weekly TK–6 plan — reading, math, logic, "
        "feelings, manners and art, plus 中文 · भारत · Español culture tracks. Written by real "
        "bilingual teachers, not an algorithm.",
        ("1.0", "weekly"),
        "Little Scholars Hub builds one calm weekly learning plan for children in "
        "transitional kindergarten through 6th grade. Nine subjects — reading, phonics, "
        "math, logic, feelings, manners, art, story and workbooks — plus three culture "
        "tracks in Chinese, Hindi and Spanish. Every worksheet works two ways: tap on a "
        "tablet, or print on paper for screen-free learning. One price covers up to four "
        "children. 14-day free trial, no credit card.",
    ),
    "/landing": (
        "Afterschool & homeschool worksheets for TK–6 | Little Scholars Hub",
        "Nine subjects, four home languages, and a weekly plan built from a 2-minute "
        "assessment. Tap on a tablet or print on paper — you decide the screen time.",
        ("0.9", "weekly"),
        "Worksheets and weekly plans for afterschool and homeschool families with children "
        "in TK through 6th grade. Reading and phonics, math, logic, science, writing, "
        "feelings, manners and art, with bilingual culture tracks in Chinese, Hindi and "
        "Spanish. Print every worksheet as a PDF or complete it on screen.",
    ),
    "/assessment": (
        "Free 2-minute learning assessment for TK–6 | Little Scholars Hub",
        "Answer 18 quick questions about your child's age, grade and interests, and get a "
        "personalised weekly learning plan. Free, no account needed to see your plan.",
        ("0.8", "monthly"),
        "A free 2-minute assessment for children in transitional kindergarten through 6th "
        "grade. Eighteen short questions about age, grade, reading and maths confidence, "
        "interests and how much time you have. It builds a weekly plan showing how many "
        "minutes to spend on each subject and which worksheets to start with. No account "
        "is needed to see the plan.",
    ),
    "/register": (
        "Start a free 14-day trial | Little Scholars Hub",
        "Create a free account to save your child's weekly plan. 14-day trial, no credit "
        "card, cancel any time. One price covers up to four children.",
        ("0.6", "monthly"),
        "Create a free Little Scholars Hub account to save your child's personalised weekly "
        "plan, track progress, and print unlimited worksheets. Fourteen-day free trial with "
        "no credit card required, and a 30-day money-back guarantee. One subscription covers "
        "up to four children.",
    ),
    "/chinese-worksheets-for-kids": ("", "", ("0.8", "monthly"), ""),
    "/hindi-and-gita-worksheets-for-kids": ("", "", ("0.8", "monthly"), ""),
    "/spanish-worksheets-for-kids": ("", "", ("0.8", "monthly"), ""),
    "/tk-kindergarten-worksheets": ("", "", ("0.8", "monthly"), ""),
    "/homeschool-worksheets-printable": ("", "", ("0.8", "monthly"), ""),
    "/afterschool-learning-activities": ("", "", ("0.8", "monthly"), ""),
    "/login": (
        "Sign in | Little Scholars Hub",
        "Sign in to your Little Scholars Hub family account.",
        None,                       # kept out of the sitemap and marked noindex
        "Sign in to your family account.",
    ),
}

DISALLOW = [
    "/api/", "/plan", "/progress", "/settings", "/children", "/content", "/story",
    "/rewards", "/assignments", "/weekly-packets", "/storypacks", "/homework",
    "/math", "/community", "/leaderboard", "/customize", "/practice/",
    "/kid-select", "/gradebook", "/students", "/config", "/users",
    "/forgot-password", "/reset-password",
]


def write_robots(today):
    lines = ["# https://www.littlescholarhub.com/robots.txt",
             "# Public pages are crawlable; everything behind a family login is not.",
             "", "User-agent: *"]
    lines += ["Disallow: %s" % d for d in DISALLOW]
    lines += ["",
              "# Generated art and worksheet PDFs are fine to fetch but not worth crawling.",
              "Disallow: /art/", "",
              "Sitemap: %s/sitemap.xml" % SITE, ""]
    io.open(os.path.join(PUBLIC, "robots.txt"), "w", encoding="utf-8").write("\n".join(lines))
    return len(DISALLOW) + 1


def write_sitemap(today):
    out = ['<?xml version="1.0" encoding="UTF-8"?>',
           '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">']
    n = 0
    for path, (_t, _d, sm, _ns) in PAGES.items():
        if not sm:
            continue
        pri, freq = sm
        out += ["  <url>",
                # Directory-served pages answer on the trailing slash; listing the
        # un-slashed form makes every entry a redirect.
        "    <loc>%s%s</loc>" % (SITE, "" if path == "/" else
                                 (path + "/" if path.count("-") >= 2 else path)),
                "    <lastmod>%s</lastmod>" % today,
                "    <changefreq>%s</changefreq>" % freq,
                "    <priority>%s</priority>" % pri,
                "  </url>"]
        n += 1
    out += ["</urlset>", ""]
    io.open(os.path.join(PUBLIC, "sitemap.xml"), "w", encoding="utf-8").write("\n".join(out))
    return n


def esc(t):
    return (t.replace("&", "&amp;").replace("<", "&lt;")
             .replace(">", "&gt;").replace('"', "&quot;"))


#: Written by topic_pages.py, which owns their copy and schema markup.
TOPIC_SLUGS = ['chinese-worksheets-for-kids', 'hindi-and-gita-worksheets-for-kids', 'spanish-worksheets-for-kids', 'tk-kindergarten-worksheets', 'homeschool-worksheets-printable', 'afterschool-learning-activities']


def build_shells(dist):
    """Rewrite the built index.html once per route."""
    base_path = os.path.join(dist, "index.html")
    if not os.path.exists(base_path):
        print("  no dist/index.html yet — run after the build"); return 0
    base = io.open(base_path, encoding="utf-8").read()
    made = 0
    for path, (title, desc, sm, noscript) in PAGES.items():
        if path.strip('/') in TOPIC_SLUGS:
            continue
        h = base
        url = SITE + ("/" if path == "/" else path)

        h = re.sub(r"<title>.*?</title>", "<title>%s</title>" % esc(title), h, count=1, flags=re.S)
        h = re.sub(r'(<meta\s+name="description"\s+content=")[^"]*(")',
                   lambda m: m.group(1) + esc(desc) + m.group(2), h, count=1, flags=re.S)
        h = re.sub(r'(<meta\s+name="description"[^>]*?content=")[^"]*(")',
                   lambda m: m.group(1) + esc(desc) + m.group(2), h, count=1, flags=re.S)
        h = re.sub(r'(<link rel="canonical" href=")[^"]*(")',
                   lambda m: m.group(1) + url + m.group(2), h, count=1)
        h = re.sub(r'(<meta property="og:title" content=")[^"]*(")',
                   lambda m: m.group(1) + esc(title) + m.group(2), h, count=1)
        h = re.sub(r'(<meta property="og:url" content=")[^"]*(")',
                   lambda m: m.group(1) + url + m.group(2), h, count=1)
        h = re.sub(r'(<meta property="og:description"[^>]*?content=")[^"]*(")',
                   lambda m: m.group(1) + esc(desc) + m.group(2), h, count=1, flags=re.S)
        h = re.sub(r'(<meta name="twitter:title" content=")[^"]*(")',
                   lambda m: m.group(1) + esc(title) + m.group(2), h, count=1)

        if sm is None:
            h = h.replace("</head>", '    <meta name="robots" content="noindex,follow" />\n  </head>', 1)

        # Real copy for a crawler that has not run the JavaScript yet, and for
        # anyone with it switched off. The app replaces #root on boot, so this
        # is never seen by a normal visitor.
        block = ('    <noscript>\n      <h1>%s</h1>\n      <p>%s</p>\n    </noscript>\n'
                 % (esc(title), esc(noscript)))
        h = h.replace("<noscript>", "<!--ns-->", 1)
        h = re.sub(r"<!--ns-->.*?</noscript>", "", h, count=1, flags=re.S)
        h = h.replace('<div id="root">', block + '    <div id="root">', 1)

        target = dist if path == "/" else os.path.join(dist, path.strip("/"))
        os.makedirs(target, exist_ok=True)
        io.open(os.path.join(target, "index.html"), "w", encoding="utf-8").write(h)
        made += 1
    return made


if __name__ == "__main__":
    today = datetime.date.today().isoformat()
    os.makedirs(PUBLIC, exist_ok=True)
    nrobots = write_robots(today)
    nurls = write_sitemap(today)
    print("wrote robots.txt   (%d rules)" % nrobots)
    print("wrote sitemap.xml  (%d urls, /login excluded as noindex)" % nurls)
    dist = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, "src/dist")
    n = build_shells(dist)
    print("wrote %d per-route HTML shells into %s" % (n, dist))
