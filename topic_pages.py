# -*- coding: utf-8 -*-
"""Structured data, and landing pages for queries this site can realistically win.

You cannot make Google prefer a site. Ranking for "homeschooling" or "early
education" is not a switch - those are head terms held by Khan Academy, ABCmouse
and IXL, and a site with 13 families and one month of crawl history will not take
them. Chasing them wastes the effort.

What a small site CAN win is the long tail: specific phrases with real intent and
few good answers. This site has a genuine one that the big platforms do not serve
well - bilingual TK-6 material in Chinese, Hindi and Spanish, written by bilingual
teachers rather than machine-translated.

So: ten pages, each answering one specific question with real content, plus
schema.org markup so Google can tell what the site is.

    https://schema.org/LearningResource
    https://schema.org/Course
"""
import io, os, re, sys, datetime, json

ROOT = "/var/www/littlescholarhub/lsh.web"
PUBLIC = os.path.join(ROOT, "src/public")
SITE = "https://www.littlescholarhub.com"

# (slug, title, meta description, h1, body paragraphs, subject, grade band)
TOPICS = [
    ("chinese-worksheets-for-kids",
     "Chinese Worksheets for Kids (TK–6) — Pinyin, Hanzi & Tang Poems",
     "Free bilingual Chinese practice for children in TK through 6th grade: pinyin tones, "
     "the first hundred characters, and Tang poems. Written by bilingual teachers.",
     "Chinese worksheets for children, TK to 6th grade",
     ["Most Chinese practice for young children is either a character-tracing PDF with no "
      "sequence behind it, or an app that assumes the child already speaks Mandarin at home. "
      "Ours follows the order a Chinese primary reader actually uses: pinyin and the four "
      "tones first, then pictographs and numbers, then position and family words, then verbs "
      "and colours, and finally two-character words.",
      "Tang poetry is included from 2nd grade — 静夜思, 春晓, 咏鹅, 悯农, 相思, 江雪 and 早发白帝城 "
      "— with the original text, not a paraphrase. By 6th grade a child has met eight classical "
      "poems, which is the shared cultural memory of every Chinese family.",
      "Every sheet works two ways: tap through it on a tablet, or print it for a screen-free "
      "afternoon. One subscription covers up to four children."],
     "Chinese", "TK-6"),

    ("hindi-and-gita-worksheets-for-kids",
     "Hindi & Gita Worksheets for Kids (TK–6) — Values, Sanskrit & Stories",
     "Bilingual Indian-tradition practice for TK–6: Bhagavad Gita teachings framed as everyday "
     "choices, Sanskrit subhashitas, and Upanishad lines with plain-English glosses.",
     "Hindi and Gita worksheets for children, TK to 6th grade",
     ["The Indian track teaches values through situations a child recognises: a friend dares you "
      "to cheat, you lose a game and want to quit, someone is eating alone at lunch. Seventeen "
      "Gita teachings are covered — courage, steadiness, patience, self-control, humility, "
      "fairness, gratitude, forgiveness and more.",
      "Sanskrit appears in Devanagari with an English gloss written for parents, never a "
      "reproduced translation: कर्मण्येवाधिकारस्ते, विद्या ददाति विनयम्, सत्यमेव जयते. Lines come from the "
      "Gita, the Katha and Mundaka Upanishads, and traditional subhashitas.",
      "It sits alongside the ordinary TK-6 curriculum — reading, maths, logic, feelings and "
      "manners — rather than replacing it."],
     "Hindi", "TK-6"),

    ("spanish-worksheets-for-kids",
     "Spanish Worksheets for Kids (TK–6) — Vocabulary, Refranes & Fiestas",
     "Bilingual Spanish practice for TK–6: everyday vocabulary, classic refranes, and fourteen "
     "festivals from across Spain and Latin America.",
     "Spanish worksheets for children, TK to 6th grade",
     ["Vocabulary is banded by age — colours, numbers and family first, then school and food, "
      "then verbs and connectives like porque, aunque and todavía.",
      "The culture strand covers fourteen fiestas from across the Spanish-speaking world, not "
      "just Mexico: Día de los Muertos, Las Posadas, Inti Raymi in Cusco, Las Fallas in "
      "Valencia, La Tomatina, Semana Santa, Feria de Abril and Nochevieja. Cinco de Mayo is "
      "taught as the Battle of Puebla, which is what it actually commemorates.",
      "Refranes and Golden Age writers appear too — Cervantes, Sor Juana, Machado, Martí."],
     "Spanish", "TK-6"),

    ("tk-kindergarten-worksheets",
     "TK & Kindergarten Worksheets — Phonics, Counting and Feelings",
     "Free TK and kindergarten practice: beginning sounds, rhyming, counting to ten, shapes, "
     "and naming feelings. Every question is multiple choice, because TK children cannot write yet.",
     "TK and kindergarten worksheets",
     ["Everything for TK and kindergarten is multiple choice. A four-year-old cannot type an "
      "answer, and a text box is where a young child gives up — so there isn't one.",
      "The TK band covers beginning sounds, rhyming words, counting objects to ten, naming "
      "circles, squares and triangles, first/next/last sequencing, listening comprehension of "
      "two-sentence stories, and naming feelings from everyday situations.",
      "A two-minute assessment builds the weekly plan, which is deliberately small: about six "
      "ten-minute sessions across three days, not nine subjects every day."],
     "Early Learning", "TK-K"),

    ("homeschool-worksheets-printable",
     "Printable Homeschool Worksheets, TK–6 — Nine Subjects, One Plan",
     "Printable and on-screen worksheets for homeschooling families, TK through 6th grade. "
     "Nine subjects, four home languages, one weekly plan built from a 2-minute assessment.",
     "Printable homeschool worksheets for TK–6",
     ["Every worksheet downloads as a PDF and works on paper. Print-first families should not "
      "have to give up modern bilingual material to stay off screens, so both modes carry the "
      "same content.",
      "Nine subjects: reading, phonics, maths, logic, science, writing, feelings, manners and "
      "art — plus three culture tracks in Chinese, Hindi and Spanish.",
      "The weekly plan budgets real sessions rather than splitting a daily total across nine "
      "subjects. A TK child gets six ten-minute sessions a week and three subjects rotate in "
      "later; a 6th grader gets twenty fifteen-minute sessions."],
     "Homeschool", "TK-6"),

    ("afterschool-learning-activities",
     "Afterschool Learning Activities for TK–6 — 20 Minutes a Day",
     "Short afterschool activities for children in TK–6. Twenty focused minutes, tap or print, "
     "built around what your child already likes.",
     "Afterschool activities for TK–6",
     ["Afterschool time is short and the child is already tired, so the plan is built around "
      "twenty minutes rather than an hour. The assessment asks how many days a week you "
      "realistically have and sizes the plan to that.",
      "Worksheets are themed to what the child likes — animals, dinosaurs, space, ocean, "
      "fantasy, vehicles, holidays, sports and nature — so the maths sheet counts seashells "
      "rather than abstract counters.",
      "Progress is tracked per child, and a parent can switch a session to print on the days "
      "screens are not wanted."],
     "Afterschool", "TK-6"),
]

DISALLOW = [
    "/api/", "/plan", "/progress", "/settings", "/children", "/content", "/story",
    "/rewards", "/assignments", "/weekly-packets", "/storypacks", "/homework",
    "/math", "/community", "/leaderboard", "/customize", "/practice/",
    "/kid-select", "/gradebook", "/students", "/config", "/users",
    "/forgot-password", "/reset-password",
]


def esc(t):
    return (t.replace("&", "&amp;").replace("<", "&lt;")
             .replace(">", "&gt;").replace('"', "&quot;"))


def org_jsonld():
    """Who this site is. Without it Google has to infer everything from prose."""
    return {
        "@context": "https://schema.org",
        "@graph": [
            {
                "@type": "EducationalOrganization",
                "@id": SITE + "/#org",
                "name": "Little Scholars Hub",
                "url": SITE,
                "logo": SITE + "/og-image.png",
                "description": ("Bilingual afterschool and homeschool worksheets and weekly "
                                "learning plans for children in TK through 6th grade, in "
                                "English, Chinese, Hindi and Spanish."),
                "areaServed": "US",
                "audience": {"@type": "EducationalAudience", "educationalRole": "parent"},
            },
            {
                "@type": "WebSite",
                "@id": SITE + "/#website",
                "url": SITE,
                "name": "Little Scholars Hub",
                "publisher": {"@id": SITE + "/#org"},
                "inLanguage": ["en", "zh", "hi", "es"],
            },
        ],
    }


def topic_jsonld(slug, title, desc, subject, band):
    return {
        "@context": "https://schema.org",
        "@type": "LearningResource",
        "@id": "%s/%s/" % (SITE, slug),
        "name": title,
        "description": desc,
        "url": "%s/%s/" % (SITE, slug),
        "learningResourceType": "worksheet",
        "educationalLevel": band,
        "about": subject,
        "isAccessibleForFree": True,
        "audience": {"@type": "EducationalAudience", "educationalRole": "student"},
        "provider": {"@id": SITE + "/#org"},
        "inLanguage": "en",
    }


def build(dist):
    base_path = os.path.join(dist, "index.html")
    if not os.path.exists(base_path):
        print("  no dist/index.html — run after the build"); return 0
    base = io.open(base_path, encoding="utf-8").read()

    # organisation markup on the homepage
    home = base
    if "EducationalOrganization" not in home:
        home = home.replace(
            "</head>",
            '    <script type="application/ld+json">%s</script>\n  </head>'
            % json.dumps(org_jsonld(), ensure_ascii=False), 1)
        io.open(base_path, "w", encoding="utf-8").write(home)

    made = 0
    for slug, title, desc, h1, paras, subject, band in TOPICS:
        h = base
        url = "%s/%s/" % (SITE, slug)
        h = re.sub(r"<title>.*?</title>", "<title>%s</title>" % esc(title), h, count=1, flags=re.S)
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

        h = h.replace("</head>",
                      '    <script type="application/ld+json">%s</script>\n  </head>'
                      % json.dumps(topic_jsonld(slug, title, desc, subject, band),
                                   ensure_ascii=False), 1)

        # Real content, not a shell. This is the whole point of the page.
        body = ["    <noscript>", "      <h1>%s</h1>" % esc(h1)]
        for p in paras:
            body.append("      <p>%s</p>" % esc(p))
        body += ['      <p><a href="%s/assessment">Start the free 2-minute assessment</a></p>' % SITE,
                 "    </noscript>"]
        h = re.sub(r"<noscript>.*?</noscript>", "", h, count=1, flags=re.S)
        h = h.replace('<div id="root">', "\n".join(body) + '\n    <div id="root">', 1)

        target = os.path.join(dist, slug)
        os.makedirs(target, exist_ok=True)
        io.open(os.path.join(target, "index.html"), "w", encoding="utf-8").write(h)
        made += 1
    return made


if __name__ == "__main__":
    dist = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, "src/dist")
    n = build(dist)
    print("topic pages written: %d" % n)
    print("organisation + website JSON-LD added to the homepage")
    for slug, _t, _d, _h, _p, _s, _b in TOPICS:
        print("   /%s" % slug)
