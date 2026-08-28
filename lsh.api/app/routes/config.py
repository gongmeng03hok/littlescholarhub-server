"""
routes/config.py — /api/config
Public read of AppConfig. Admin writes go through /api/admin/config.

Language-aware: every config_key can have a row per language_id (1=en,
2=zh, 3=hi, 4=es). Callers pass ?language_id=N; any key without a
translation for that language falls back to the English (1) row.
"""

from flask import Blueprint, jsonify, request
from utils.db import qry

config_bp = Blueprint("config", __name__)

# Keys exposed publicly (safe to return without auth)
_PUBLIC_SECTIONS = {"hero", "pricing", "assessment", "community",
                    "features", "referral", "social", "school",
                    "worksheets", "whyUs", "testimonials", "progress",
                    "comparison", "footer", "dualMode", "culture",
                    "nav", "culturalTracks", "wisdomBanner", "subjects"}


def _cast(row: dict) -> tuple:
    """Return (key, typed_value)."""
    val = row["config_value"]
    t   = row.get("config_type", "text")
    if t == "boolean":
        val = val.strip().lower() == "true"
    elif t == "number":
        try:
            val = float(val) if "." in val else int(val)
        except ValueError:
            pass
    elif t == "json":
        import json
        try:
            val = json.loads(val)
        except Exception:
            pass
    return row["config_key"], val


def _lang_id() -> int:
    try:
        return int(request.args.get("language_id", 1))
    except (TypeError, ValueError):
        return 1


@config_bp.get("/")
def get_all_config():
    """Return all public config as a flat key→value dict, in the requested
    language with English fallback for any untranslated key."""
    lang = _lang_id()
    sections = tuple(_PUBLIC_SECTIONS)
    rows = qry(
        "SELECT config_key, config_value, config_type, language_id "
        "FROM dbo.AppConfig "
        f"WHERE section IN ({','.join('?' for _ in sections)}) AND language_id IN (1, ?)",
        (*sections, lang)
    ) or []

    # English rows first, then overlay the target language on top
    rows.sort(key=lambda r: 0 if r["language_id"] == 1 else 1)
    result = {}
    for row in rows:
        k, v = _cast(row)
        result[k] = v

    # Fallback defaults if DB is empty / not yet migrated
    if not result:
        result = _FALLBACK_CONFIG

    return jsonify(result)


@config_bp.get("/<path:key>")
def get_one_config(key: str):
    lang = _lang_id()
    row = qry(
        "SELECT config_key, config_value, config_type FROM dbo.AppConfig "
        "WHERE config_key=? AND language_id=?",
        (key, lang), fetch="one"
    )
    if not row and lang != 1:
        row = qry(
            "SELECT config_key, config_value, config_type FROM dbo.AppConfig "
            "WHERE config_key=? AND language_id=1",
            (key,), fetch="one"
        )
    if not row:
        # Return from fallback
        val = _FALLBACK_CONFIG.get(key)
        if val is None:
            return jsonify({"error": "Key not found"}), 404
        return jsonify({"key": key, "value": val})
    k, v = _cast(row)
    return jsonify({"key": k, "value": v})


# ── Hard-coded fallback (mirrors seed data) ──────────────────
# Used when DB is unreachable or migration hasn't run yet

_FALLBACK_CONFIG = {
    "hero.tagline":           "One calm plan.  Nine subjects.  Your family's language.",
    "hero.subtagline":        "A 2-minute assessment builds your child's weekly plan — tap on a tablet or print on paper, you decide the screen time. Reading, math, logic, feelings, manners, art, plus three culture tracks. Written by real bilingual teachers, not an algorithm. One price covers every child.",
    "hero.cta_primary":       "Build my child's plan →",
    "hero.cta_secondary":     "See pricing",
    "hero.badge_worksheets":  "100+",
    "hero.badge_languages":   "4",
    "hero.badge_price":       "1 price",
    "trust.item1":            "✓ 14-day free trial",
    "trust.item2":            "✓ 30-day money back",
    "trust.item3":            "✓ Cancel anytime",
    "trust.item4":            "✓ COPPA & kid-privacy-first",
    "dualMode.eyebrow":          "Built for busy parents",
    "dualMode.title":            "Two ways to learn.",
    "dualMode.title_highlight":  "You decide screen time.",
    "dualMode.subtitle":         "Every worksheet works two ways — tap on a tablet for game-style practice, or print on paper for screen-free learning. The same lesson, your choice. Less screen guilt on the days you need it most.",
    "dualMode.divider":          "or",
    "dualMode.cards": [
        {"icon": "📱", "title": "Digital · interactive", "body": "Kids tap to fill, drag, and paint with instant feedback and audio. Auto-saves progress so they can pick up after dinner.", "features": ["Game-style chimes & confetti for ages 4-8", "Voice-over in English, 中文, हिन्दी, Español", "Phone, tablet, or laptop — no app install"]},
        {"icon": "🖨️", "title": "Print · screen-free", "body": "One click downloads a PDF — every worksheet in our library. Pencil-and-paper learning that builds the fine motor skills tablets can't.", "features": ["Letter & A4 · black-and-white friendly (toner-light)", "Quarterly printed workbook on the Family plan · Shipped", "Works on the road, in the car, at grandma's house"]},
    ],
    "dualMode.stats": [
        {"num": "0 min", "label": "screen time required"},
        {"num": "100%", "label": "printable, every worksheet"},
        {"num": "4 langs", "label": "tap or print, your call"},
    ],
    "dualMode.disclaimer":       "Why both? AAP screen time guidance + 2026 state laws (Iowa, Oklahoma, Kansas) cap classroom screens for K–5. Print-first families shouldn't have to give up modern bilingual content. We built for both.",
    "culture.zh.detail": {
        "units": [
            {"name": "拼音 Pinyin foundations", "grade": "TK–K", "text": "Initials, finals, and the four tones, with mouth-position diagrams and daily 5-minute audio drills."},
            {"name": "汉字 First 100 characters", "grade": "K–2", "text": "Numbers, family, body, nature, action verbs. Stroke-order tracing and a character a day."},
            {"name": "唐诗 Tang poetry starters", "grade": "1–3", "text": "Five classic poems kids recite, each with a read-aloud audio and meaning card."},
            {"name": "唐诗 Capstone (20 poems)", "grade": "4–6", "text": "Recite 20 poems by 6th grade — to grandparents on a video call."},
        ],
        "festivals": [
            {"m": "Jan/Feb", "name": "农历新年 Lunar New Year", "doText": "Red envelopes, dumplings, zodiac craft"},
            {"m": "Feb", "name": "元宵节 Lantern Festival", "doText": "Make a paper lantern, eat tāngyuán"},
            {"m": "Jun", "name": "端午 Dragon Boat", "doText": "Eat zòngzi, fold a paper dragon boat"},
            {"m": "Sep", "name": "中秋 Mid-Autumn", "doText": "Mooncakes and the moon-goddess story"},
        ],
        "phrases": [
            {"t": "你好", "translit": "nǐ hǎo", "eng": "Hello"},
            {"t": "谢谢", "translit": "xiè xie", "eng": "Thank you"},
            {"t": "我爱你", "translit": "wǒ ài nǐ", "eng": "I love you"},
            {"t": "新年快乐", "translit": "xīn nián kuài lè", "eng": "Happy New Year"},
        ],
        "project": {
            "title": "Make a paper lantern for Lunar New Year",
            "desc": "Classic, calming, takes 20 minutes. Hang it in a window.",
            "steps": ["Cut red paper into a 6×9 rectangle.", "Fold in half, cut slits along the fold.", "Unfold and curl into a cylinder, tape the seam.", "Add a paper handle and write 福 (good fortune) on it."],
            "supplies": "Red paper · scissors · tape · gold marker",
        },
        "parentTip": "Read Pinyin aloud together — your voice matters more than perfect tones. Once a week, video-call grandparents and have your child recite one Tang poem.",
    },
    "culture.in.detail": {
        "units": [
            {"name": "वर्णमाला Hindi alphabet", "grade": "TK–K", "text": "Vowels first, then consonants, traced top-to-bottom."},
            {"name": "Gita stories for kids", "grade": "1–3", "text": "Arjuna's doubt, Krishna's guidance, Hanuman's strength — one gentle takeaway per story."},
            {"name": "Character building", "grade": "1–6", "text": "Steadiness, courage, kindness, doing your duty — one story plus one real-life challenge."},
            {"name": "Capstone journal", "grade": "5–6", "text": "Connect each Gita teaching to a moment from your own life, bound at year end."},
        ],
        "festivals": [
            {"m": "Mar", "name": "Holi", "doText": "Color powder craft, Krishna-Radha story"},
            {"m": "Aug", "name": "Raksha Bandhan", "doText": "Make a thread bracelet, video-call cousins"},
            {"m": "Sep", "name": "Ganesh Chaturthi", "doText": "Clay Ganesha, obstacle-remover reflection"},
            {"m": "Nov", "name": "Diwali", "doText": "Rangoli and diya craft, Lakshmi story"},
        ],
        "phrases": [
            {"t": "नमस्ते", "translit": "namaste", "eng": "Hello / I bow to you"},
            {"t": "धन्यवाद", "translit": "dhanyavād", "eng": "Thank you"},
            {"t": "मुझे भूख लगी है", "translit": "mujhe bhūkh lagī hai", "eng": "I'm hungry"},
            {"t": "शुभ दीपावली", "translit": "shubh dīpāvalī", "eng": "Happy Diwali"},
        ],
        "project": {
            "title": "Diwali rangoli on a paper plate",
            "desc": "A kid-friendly rangoli that keeps the symmetry without the floor-mess.",
            "steps": ["Mark the center of a paper plate.", "Draw 8 light pencil lines for equal slices.", "Place colored dot stickers along each line, same pattern per slice.", "Add a flower motif in the center and display it."],
            "supplies": "Paper plate · colored dot stickers or markers · pencil",
        },
        "parentTip": "Open Gita stories at bedtime, not as homework. Ask 'when did you feel like Arjuna today?' and let your child find the lesson themselves.",
    },
    "culture.es.detail": {
        "units": [
            {"name": "Letras y sonidos", "grade": "TK–K", "text": "The 27-letter alphabet including ñ, and the five vowel sounds."},
            {"name": "Acentos & sílaba fuerte", "grade": "K–1", "text": "When a word needs an accent — mastered in about 6 weeks."},
            {"name": "Cuentos & folk tales", "grade": "1–4", "text": "Stories from 12 Spanish-speaking countries, one per month."},
            {"name": "Capstone portfolio", "grade": "5–6", "text": "A family tree, a retold folk tale, and an art piece honoring a maestro."},
        ],
        "festivals": [
            {"m": "Jan 6", "name": "Día de los Reyes Magos", "doText": "Leave grass for the camels, Rosca de Reyes bread"},
            {"m": "May 5", "name": "Cinco de Mayo", "doText": "Papel picado banner, battle of Puebla story"},
            {"m": "Sep 15", "name": "Hispanic Heritage Month begins", "doText": "21-country map, one leader per week"},
            {"m": "Nov 1–2", "name": "Día de los Muertos", "doText": "Build an ofrenda, pan de muerto, marigold path"},
        ],
        "phrases": [
            {"t": "Hola", "translit": "OH-lah", "eng": "Hello"},
            {"t": "Gracias", "translit": "GRAH-syas", "eng": "Thank you"},
            {"t": "Tengo hambre", "translit": "TENG-go AHM-breh", "eng": "I'm hungry"},
            {"t": "Te quiero", "translit": "teh kee-EH-roh", "eng": "I love you"},
        ],
        "project": {
            "title": "Build an ofrenda for Día de los Muertos",
            "desc": "A small altar honoring someone your family loved — joyful, not sad.",
            "steps": ["Cover a small shelf with a colorful cloth.", "Add one photo and say the person's name together.", "Place a glass of water and a little bread.", "Add marigolds and light one candle on Nov 1."],
            "supplies": "Cloth · 1 photo · marigolds (paper or real) · 1 candle",
        },
        "parentTip": "Don't 'teach' culture — live it. Bake the food, sing the song, video-call abuela. Culture sticks when it tastes, smells, and sounds like something.",
    },
    "pricing.explorer_price": 0,
    "pricing.family_price":   14.99,
    "pricing.family_annual":  129,
    "pricing.family_save":    51,
    "pricing.shipped_price":  29.99,
    "pricing.shipped_annual": 299,
    "pricing.shipped_save":   61,
    "assessment.total_questions": 15,
    "assessment.subtitle":    "18 short questions · ~2 min · skip any",
    "community.officehours_day":   "Wednesday",
    "community.officehours_time":  "7:00 pm PT",
    "community.officehours_host":  "Ms. Chen · credentialed bilingual teacher",
    "community.officehours_topic": "How to introduce Tang Shi to a 1st grader without overwhelming them",
    "community.officehours_next":  "Wed 29",
    "community.discord_url":       "#",
    "community.discord_members":   "1,240",
    "community.wechat_members":    "860",
    "community.whatsapp_hindi_members":   "520",
    "community.whatsapp_espanol_members": "740",
    "community.groups": [
        {"flag": "🇺🇸", "label": "English-speaking parents", "platform": "Discord", "members": "1,240"},
        {"flag": "🏮", "label": "华人家长群 · Chinese-speaking parents", "platform": "WeChat", "members": "860"},
        {"flag": "🪔", "label": "हिन्दी parents & Gita circle", "platform": "WhatsApp", "members": "520"},
        {"flag": "🌻", "label": "Familias en español", "platform": "WhatsApp", "members": "740"}
    ],
    "feature.kid_mode_enabled":        True,
    "feature.audio_stories_enabled":   True,
    "feature.office_hours_enabled":    True,
    "feature.referral_enabled":        True,
    "feature.school_licensing_enabled":True,
    "referral.code_example":  "LSH-FAM-2026",
    "referral.description":   "Your referral gets their first month of Family free. When they subscribe, your next month is on us.",
    "social.tiktok_handle":       "@littlescholarshub",
    "social.instagram_handle":    "@littlescholarshub",
    "social.xiaohongshu_handle":  "小学霸中心 · LittleScholarsHub",
    "social.cards": [
        {"desc": "60-second phonics and math hooks. Moms and teachers, English + Spanish."},
        {"desc": "Weekly worksheet drops, flat-lays, reels. The aesthetic homeschool crowd."},
        {"desc": "双语拼音、阅读、数学练习册，给美国华人家庭的放学后学习方式。"}
    ],
    "school.classroom_price":     4,
    "school.afterschool_price":   3,
    "school.classroom_max":       30,
    "school.plans": [
        {"label": "Classroom", "price": "$4/student/month", "desc": "For a single classroom (up to 30 students).", "features": ["All 9 subjects + 3 culture tracks", "Teacher dashboard with per-student progress", "Printable class-set worksheets", "PD: 1 hr onboarding for the teacher"]},
        {"label": "Afterschool program", "price": "$3/student/month", "desc": "For community orgs & afterschool centers.", "features": ["Everything in Classroom", "Session-planning kits (60-min blocks)", "Mandarin, Spanish, or Hindi instructor guides", "Parent communication templates"]},
        {"label": "District", "price": "Custom", "desc": "100+ seats with admin console.", "features": ["Volume pricing (from $2/student/mo)", "District admin dashboard & reporting", "SSO (Clever / ClassLink / Google)", "COPPA & FERPA-aligned data agreements", "Dedicated partner success manager"]}
    ],
    "footer.links": ["Subjects", "Worksheets", "Pricing", "About", "For Teachers", "Contact", "TikTok", "Instagram", "Xiaohongshu", "YouTube"],
    "footer.company_links": ["About", "For Teachers", "Contact"],
    "footer.social_links": ["TikTok", "Instagram", "Xiaohongshu", "YouTube"],
    "footer.legal": ["Privacy", "Terms"],
    "footer.copy": "© 2026 Little Scholars Hub — all curriculum, code & content protected.",
    "footer.tagline": "Afterschool and homeschool learning for TK–6. Printable, bilingual, and built for busy families.",
    "hero.trust": ["✓ 14-day free trial", "✓ 30-day money back", "✓ Cancel anytime", "✓ COPPA & kid-privacy-first", "🖨️ Tap or print — your choice"],
    "hero.badges": [
        {"num": "100+", "label": "teacher-reviewed worksheets"},
        {"num": "4", "label": "home languages, done right"},
        {"num": "1 price", "label": "for up to 4 kids"}
    ],
    "hero.today_items": [
        {"icon": "📚", "label": "today's story", "sub": "Kai and the Dragon"},
        {"icon": "✏️", "label": "math practice", "sub": "2nd grade · 12 min"},
        {"icon": "🎨", "label": "art project", "sub": "Lunar lantern"}
    ],
    "worksheets.grades": ["TK","Kindergarten","1st","2nd","3rd","4th","5th","6th"],
    "worksheets.tags": ["Phonics","Reading","Writing","Math","Logic","Science","Art","Feelings","Manners","Story","Workbooks","Pinyin","汉字","唐诗","Gita","Letras","Fiestas","Maestros"],
    "whyUs.items": [
        {"n":"01", "title":"Heritage language, done right", "body":"Every core worksheet is also available in Mandarin, Hindi, and Spanish — translated by real bilingual teachers, not machines."},
        {"n":"02", "title":"Printable + interactive", "body":"Get the PDF to print for screen-free practice, and track progress with bite-size digital practice on phone or tablet."},
        {"n":"03", "title":"Story-first, not drill-first", "body":"Every week ties around one story. Kids learn vocabulary, math, and art connected to that world — so concepts stick."}
    ],
    "testimonials.items": [
        {"stars": 5, "badge": "✓ Verified family · 7-mo subscriber", "quote": "The Pinyin → 100字 → 唐诗 sequence is exactly what I've been trying to DIY for a year. My 2nd grader recited 静夜思 to her grandma on WeChat last weekend — 外婆 cried.", "name":"Lily J. · 贾莉", "location":"Bay Area · daughters, grades K & 2"},
        {"stars": 5, "badge": "✓ Verified family · 4-mo subscriber", "quote": "I finally have a homeschool plan that includes the Gita stories I grew up with — my son asks for the \"Words for Today\" at breakfast. Not one of the big platforms had anything like this.", "name":"Priya R. · प्रिया", "location":"New Jersey · homeschool, 1st & 4th"},
        {"stars": 5, "badge": "✓ Familia verificada · 5 meses", "quote": "Los cuentos de Día de los Muertos, el alfabeto con la ñ, los maestros como Frida — mi hija se siente orgullosa de las dos culturas. No es una simple traducción, está hecho con cariño.", "name":"María D.", "location":"Los Ángeles · hija de 3er grado"}
    ],
    "progress.cards": [
        {"subject":"Reading · 1st grade", "w1":"still guessing \"the\"", "w12":"reads 32 sight words ✨", "name":"Aanya's phonics climb", "desc":"Pre-reader → reading short chapter pages aloud", "quote":"We stopped doing worksheet drills and let the daily story pull her forward. 12 weeks."},
        {"subject":"Math · 3rd grade", "w1":"7 × ? = 🤷 times tables: foggy", "w12":"1–10 × fluent\nsolving 2-step word ✅", "name":"Noah's math fluency", "desc":"\"Foggy\" → 2-step word problems, unprompted", "quote":"Singapore bar models + 10 min/day. He asked for the workbook on our road trip."},
        {"subject":"汉字 · 2nd grade", "w1":"一二三 — 3 characters", "w12":"48 characters\nrecited 静夜思 to 外婆", "name":"Mei's 汉字 journey", "desc":"3 characters → 48 + first Tang poem", "quote":"外婆 on WeChat cried. That's a ROI I didn't know we were buying."}
    ],
    "comparison.items": [
        {"complaint":"\"Everyone uses AI — no real teacher ever sees my kid's work.\"", "answer":"Every worksheet in your weekly plan is written and reviewed by a credentialed bilingual teacher."},
        {"complaint":"\"The scoring system punishes mistakes and stresses my kid out.\"", "answer":"No red marks. Kids check their own work with answer keys; parents see effort & streak, not pass/fail."},
        {"complaint":"\"It feels like busywork with no rigor.\"", "answer":"Our assessment weights your child's actual level. The plan is a sequence with clear end goals."},
        {"complaint":"\"There's nothing for my bilingual kid.\"", "answer":"Three fully sequenced culture-infused programs — Chinese, Indian, Hispanic — translated by real educators."},
        {"complaint":"\"Per-child pricing adds up fast.\"", "answer":"One price covers up to four kids. Annual plans save an additional 17–28%."},
        {"complaint":"\"My kid's progress got wiped when the app updated.\"", "answer":"Weekly progress exports to a printable PDF. Cloud-backed account keeps their streak across devices."}
    ],
    "footer.colLearn": "LEARN",
    "footer.colCompany": "COMPANY",
    "footer.colFollow": "FOLLOW",
}
