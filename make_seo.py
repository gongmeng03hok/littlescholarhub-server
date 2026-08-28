# -*- coding: utf-8 -*-
"""Writes robots.txt and sitemap.xml into lsh.web/src/public/.

Both URLs previously returned the 4 KB SPA shell as text/html — there was no
robots file and no sitemap at all, and nginx's catch-all meant every unknown
URL answered 200. Search engines had no crawl directives, nothing to enumerate,
and every typo looked like a real page.

Only genuinely public, genuinely distinct pages go in the sitemap. The 447
worksheets live behind /sample?id=N and all render the same client-side shell,
so listing them would be several hundred near-identical URLs — the shape of
thin/duplicate content, not a win. Better to have a small honest sitemap.
"""
import io, os, sys, datetime

PUBLIC = "/var/www/littlescholarhub/lsh.web/src/public"
SITE = "https://www.littlescholarhub.com"

# Public, crawlable, meaningfully distinct.
PAGES = [
    ("/",                 "1.0", "weekly"),
    ("/landing",          "0.9", "weekly"),
    ("/assessment",       "0.8", "monthly"),
    ("/register",         "0.6", "monthly"),
    ("/login",            "0.3", "yearly"),
]

# Everything behind a login, plus the API. No value to a crawler, and several
# would look like duplicate shells.
DISALLOW = [
    "/api/",
    "/plan", "/progress", "/settings", "/children", "/content", "/story",
    "/rewards", "/assignments", "/weekly-packets", "/storypacks", "/homework",
    "/math", "/community", "/leaderboard", "/customize", "/practice/",
    "/kid-select", "/gradebook", "/students", "/config", "/users",
    "/forgot-password", "/reset-password",
]


def main():
    os.makedirs(PUBLIC, exist_ok=True)
    today = datetime.date.today().isoformat()

    robots = ["# https://www.littlescholarhub.com/robots.txt",
              "# Public pages are crawlable; everything behind a family login is not.",
              "",
              "User-agent: *"]
    for d in DISALLOW:
        robots.append("Disallow: %s" % d)
    robots += ["",
               "# Generated art and worksheet PDFs are fine to fetch but not worth crawling.",
               "Disallow: /art/",
               "",
               "Sitemap: %s/sitemap.xml" % SITE,
               ""]
    io.open(os.path.join(PUBLIC, "robots.txt"), "w", encoding="utf-8").write("\n".join(robots))

    sm = ['<?xml version="1.0" encoding="UTF-8"?>',
          '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">']
    for loc, pri, freq in PAGES:
        sm += ["  <url>",
               "    <loc>%s%s</loc>" % (SITE, loc),
               "    <lastmod>%s</lastmod>" % today,
               "    <changefreq>%s</changefreq>" % freq,
               "    <priority>%s</priority>" % pri,
               "  </url>"]
    sm += ["</urlset>", ""]
    io.open(os.path.join(PUBLIC, "sitemap.xml"), "w", encoding="utf-8").write("\n".join(sm))

    print("wrote %s/robots.txt   (%d disallow rules)" % (PUBLIC, len(DISALLOW)))
    print("wrote %s/sitemap.xml  (%d urls)" % (PUBLIC, len(PAGES)))


if __name__ == "__main__":
    main()
