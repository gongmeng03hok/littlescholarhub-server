"""
services/worksheet_pdf_generator.py
Generates real, correct printable PDFs for catalog worksheets that don't
have a manually-uploaded PDF file. Each key below matches an actual math
problem set appropriate to the worksheet's title and grade — not filler.

Coloring pages, cursive tracing, story mini-books and cultural content
(Tang poems, Gita stories, Spanish culture) are NOT covered here — those
need real illustrated assets and should be uploaded via the admin panel.
"""

import json
import random
from datetime import date

_FONTS_REGISTERED = False


def _ensure_fonts_registered():
    """Registers the "Kalam" handwriting font (Google Fonts, OFL-licensed —
    see assets/fonts/OFL.txt) once per process, so every worksheet PDF reads
    like a friendly handwritten page instead of default sans-serif type."""
    global _FONTS_REGISTERED
    if _FONTS_REGISTERED:
        return
    import os
    from reportlab.pdfbase import pdfmetrics
    from reportlab.pdfbase.ttfonts import TTFont

    font_dir = os.path.normpath(os.path.join(os.path.dirname(__file__), "..", "assets", "fonts"))
    pdfmetrics.registerFont(TTFont("Kalam", os.path.join(font_dir, "Kalam-Regular.ttf")))
    pdfmetrics.registerFont(TTFont("Kalam-Bold", os.path.join(font_dir, "Kalam-Bold.ttf")))
    pdfmetrics.registerFontFamily("Kalam", normal="Kalam", bold="Kalam-Bold",
                                   italic="Kalam", boldItalic="Kalam-Bold")
    _FONTS_REGISTERED = True


def _doc(title: str, subtitle: str = ""):
    from reportlab.lib.pagesizes import letter
    from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, HRFlowable, Table, TableStyle
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    from reportlab.lib.enums import TA_CENTER
    import io

    _ensure_fonts_registered()

    buf = io.BytesIO()
    doc = SimpleDocTemplate(buf, pagesize=letter,
                             leftMargin=0.75*inch, rightMargin=0.75*inch,
                             topMargin=0.75*inch, bottomMargin=0.75*inch,
                             title=title, author="Little Scholars Hub")
    styles = getSampleStyleSheet()
    # Handwriting font, everywhere — every ParagraphStyle in this module
    # inherits from one of these four base styles.
    styles["Normal"].fontName = "Kalam"
    styles["Heading1"].fontName = "Kalam-Bold"
    styles["Heading2"].fontName = "Kalam-Bold"
    styles["Heading3"].fontName = "Kalam-Bold"
    PURPLE = colors.HexColor("#5b4fcf")
    GOLD   = colors.HexColor("#f5a623")

    # "Quest badge" — small game-show style pill above the title, on every
    # worksheet, so print worksheets read as a level/quest rather than a
    # plain school handout.
    badge = Table([["TODAY'S QUEST"]], colWidths=[1.9*inch])
    badge.setStyle(TableStyle([
        ("BACKGROUND",  (0, 0), (-1, -1), GOLD),
        ("TEXTCOLOR",   (0, 0), (-1, -1), colors.white),
        ("ALIGN",       (0, 0), (-1, -1), "CENTER"),
        ("VALIGN",      (0, 0), (-1, -1), "MIDDLE"),
        ("FONTSIZE",    (0, 0), (-1, -1), 9),
        ("FONTNAME",    (0, 0), (-1, -1), "Kalam-Bold"),
        ("TOPPADDING",  (0, 0), (-1, -1), 4),
        ("BOTTOMPADDING",(0, 0), (-1, -1), 4),
    ]))

    story = [
        badge,
        Spacer(1, 6),
        Paragraph(title, ParagraphStyle("t", parent=styles["Heading1"], fontSize=18,
                                         textColor=PURPLE, alignment=TA_CENTER)),
    ]
    if subtitle:
        story.append(Paragraph(subtitle, ParagraphStyle("s", parent=styles["Normal"],
                                                          fontSize=11, alignment=TA_CENTER,
                                                          textColor=colors.gray, spaceAfter=6)))
    story.append(Paragraph(
        f"Name: {'_'*26}   Date: {'_'*14}",
        ParagraphStyle("hl", parent=styles["Normal"], fontSize=10, alignment=TA_CENTER, spaceAfter=8)))
    story.append(HRFlowable(width="100%", thickness=1.5, color=PURPLE, spaceAfter=12))
    return buf, doc, story, styles


def _star_polygon(cx, cy, outer_r, inner_r):
    """A 5-point star outline built from real geometry (not a unicode glyph —
    ★ and similar symbols render as solid black boxes with the default PDF
    font in this project, so every 'star' on a worksheet is hand-drawn)."""
    import math
    from reportlab.graphics.shapes import Polygon
    from reportlab.lib import colors
    pts = []
    for i in range(10):
        r = outer_r if i % 2 == 0 else inner_r
        ang = -math.pi/2 + i * math.pi/5
        pts.extend([cx + r*math.cos(ang), cy + r*math.sin(ang)])
    return Polygon(points=pts, strokeColor=colors.HexColor("#f5a623"),
                    strokeWidth=1.5, fillColor=None)


def _reward_strip(story, styles, stars=5):
    """Universal 'collect the stars' reward row + self-score tracker,
    appended to every worksheet so completing it always feels like clearing
    a level, not just finishing a handout."""
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.graphics.shapes import Drawing
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    from reportlab.lib.enums import TA_CENTER

    story.append(Spacer(1, 10))
    story.append(Paragraph("Great job, Scholar! Color a star for every one you finish:",
        ParagraphStyle("rw", parent=styles["Normal"], fontSize=10, alignment=TA_CENTER,
                        textColor=colors.HexColor("#5b4fcf"), spaceAfter=4)))

    gap = 0.65*inch
    width = gap * stars
    d = Drawing(width, 0.5*inch)
    for i in range(stars):
        cx = gap*i + gap/2
        d.add(_star_polygon(cx, 0.25*inch, 0.22*inch, 0.09*inch))
    d.hAlign = "CENTER"
    story.append(d)

    story.append(Paragraph("MY SCORE:  _______  out of  _______",
        ParagraphStyle("sc", parent=styles["Normal"], fontSize=10, alignment=TA_CENTER,
                        textColor=colors.gray, spaceBefore=6)))


def _footer(story, styles, label: str, stars: int = 5):
    from reportlab.platypus import Paragraph, HRFlowable
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib import colors
    from reportlab.lib.enums import TA_CENTER
    _reward_strip(story, styles, stars=stars)
    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.lightgrey, spaceBefore=14))
    story.append(Paragraph(f"littlescholarshub.com  •  {label}",
        ParagraphStyle("ft", parent=styles["Normal"], fontSize=8,
                        textColor=colors.gray, alignment=TA_CENTER)))


def _problem_grid(story, styles, problems, cols=3, col_w=2.25):
    from reportlab.platypus import Table, TableStyle, Paragraph
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors

    rows = []
    for i in range(0, len(problems), cols):
        row = []
        for j in range(cols):
            idx = i + j
            if idx < len(problems):
                text = f"{idx+1:2d}.  {problems[idx]}"
                row.append(Paragraph(text, ParagraphStyle("dq", parent=styles["Normal"],
                                                            fontSize=13, leading=22)))
            else:
                row.append("")
        rows.append(row)

    t = Table(rows, colWidths=[col_w*inch]*cols)
    t.setStyle(TableStyle([
        ("VALIGN",        (0, 0), (-1, -1), "MIDDLE"),
        ("LEFTPADDING",   (0, 0), (-1, -1), 8),
        ("RIGHTPADDING",  (0, 0), (-1, -1), 8),
        ("TOPPADDING",    (0, 0), (-1, -1), 8),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 8),
        ("ROWBACKGROUNDS", (0, 0), (-1, -1), [colors.HexColor("#f9fafb"), colors.white]),
        ("GRID",          (0, 0), (-1, -1), 0.5, colors.HexColor("#e5e7eb")),
    ]))
    story.append(t)


def _build(title, subtitle, problems, footer_label, cols=3, col_w=2.25, answers=None):
    buf, doc, story, styles = _doc(title, subtitle)
    _problem_grid(story, styles, problems, cols=cols, col_w=col_w)
    if answers:
        from reportlab.platypus import Paragraph
        from reportlab.lib.styles import ParagraphStyle
        _packet_section(story, styles, "Answer Key", "For grown-ups — check your scholar's work against these answers.")
        ans_text = "&nbsp;&nbsp;&nbsp;&nbsp;".join(f"{i+1}. {a}" for i, a in enumerate(answers))
        story.append(Paragraph(ans_text, ParagraphStyle("aka", parent=styles["Normal"], fontSize=11, leading=19)))
    _footer(story, styles, footer_label, stars=min(max(len(problems), 3), 10))
    doc.build(story)
    return buf.getvalue()


# ── Problem generators — real, grade-appropriate, randomised each print ────

def _addition_to_10():
    probs, answers = [], []
    for _ in range(15):
        a, b = random.randint(0, 10), random.randint(0, 10)
        while a + b > 10:
            a, b = random.randint(0, 10), random.randint(0, 10)
        probs.append(f"{a} + {b} = ___")
        answers.append(str(a + b))
    return _build("Addition Hop 1–10", "Add the numbers up to 10.", probs, "Addition · Grade 1", answers=answers)


def _number_bonds_20():
    probs, answers = [], []
    for _ in range(15):
        total = random.randint(5, 20)
        a = random.randint(0, total)
        probs.append(f"{a} + ___ = {total}")
        answers.append(str(total - a))
    return _build("Number Bonds to 20", "Fill in the missing number.", probs, "Number Bonds · Grade 1", answers=answers)


def _subtract_2digit():
    probs, answers = [], []
    for _ in range(12):
        a = random.randint(10, 99)
        b = random.randint(0, a)
        probs.append(f"{a} − {b} = ___")
        answers.append(str(a - b))
    return _build("Two-Digit Subtraction", "Subtract carefully — borrow if you need to.", probs,
                  "Subtraction · Grade 2", cols=2, col_w=3.3, answers=answers)


def _drill_subtraction():
    probs, answers = [], []
    for _ in range(15):
        a = random.randint(1, 20)
        b = random.randint(0, a)
        probs.append(f"{a} − {b} = ___")
        answers.append(str(a - b))
    return _build("1-Minute Math: Subtraction", "Go as fast as you can — accuracy first!", probs,
                  "Timed Drill · Grade 2", answers=answers)


def _drill_multiplication():
    pairs = [(random.randint(1, 10), random.randint(1, 10)) for _ in range(15)]
    probs = [f"{a} × {b} = ___" for a, b in pairs]
    answers = [str(a * b) for a, b in pairs]
    return _build("1-Minute Math: Multiplication", "Go as fast as you can — accuracy first!", probs,
                  "Timed Drill · Grade 3", answers=answers)


def _long_multiplication():
    probs, answers = [], []
    for _ in range(9):
        a = random.randint(12, 99)
        b = random.randint(2, 9)
        probs.append(f"{a} × {b} = ___")
        answers.append(str(a * b))
    return _build("Long Multiplication Drill", "Show your work on scratch paper.", probs,
                  "Multiplication · Grade 4", cols=3, col_w=2.25, answers=answers)


def _long_division():
    probs, answers = [], []
    for _ in range(9):
        divisor = random.randint(2, 12)
        quotient = random.randint(4, 30)
        dividend = divisor * quotient
        probs.append(f"{dividend} ÷ {divisor} = ___")
        answers.append(str(quotient))
    return _build("Long Division Mastery", "Divide, then check by multiplying back.", probs,
                  "Division · Grade 5", cols=3, col_w=2.25, answers=answers)


def _bar_model_ratios():
    probs, answers = [], []
    templates = [
        "A ribbon is {a} cm long and is cut in a {r1}:{r2} ratio. How long is each piece?",
        "There are {a} marbles split {r1}:{r2} between Mia and Sam. How many does each get?",
        "A recipe uses flour and sugar in a {r1}:{r2} ratio. If there are {a} cups total, how much of each?",
    ]
    for _ in range(6):
        r1, r2 = random.randint(1, 5), random.randint(1, 5)
        k = random.randint(2, 8)
        a = (r1 + r2) * k
        tmpl = random.choice(templates)
        probs.append(tmpl.format(a=a, r1=r1, r2=r2))
        answers.append(f"{r1*k} and {r2*k}")
    return _build("Singapore Bar Model: Ratios", "Draw a bar model, then solve.", probs,
                  "Ratios · Grade 5", cols=1, col_w=6.5, answers=answers)


def _prealgebra_variables():
    probs, answers = [], []
    for _ in range(12):
        x = random.randint(1, 20)
        b = random.randint(1, 15)
        op = random.choice(["+", "-", "×"])
        if op == "+":
            probs.append(f"x + {b} = {x + b}.  x = ___")
        elif op == "-":
            probs.append(f"x − {b} = {x - b}.  x = ___")
        else:
            probs.append(f"{b} × x = {b * x}.  x = ___")
        answers.append(str(x))
    return _build("Pre-Algebra: Variables", "Solve for x.", probs, "Pre-Algebra · Grade 6", answers=answers)


def _ratios_proportions():
    probs, answers = [], []
    for _ in range(9):
        r1, r2 = random.randint(1, 9), random.randint(1, 9)
        mult = random.randint(2, 6)
        probs.append(f"{r1} : {r2}  =  ___ : {r2 * mult}")
        answers.append(str(r1 * mult))
    return _build("Ratios & Proportions", "Find the missing number in each proportion.", probs,
                  "Ratios & Proportions · Grade 6", cols=3, col_w=2.25, answers=answers)


def _trace_numbers_1_10():
    from reportlab.platypus import Paragraph
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Trace Numbers 1–10", "Trace each number, then write it once on your own.")
    for n in range(1, 11):
        story.append(Paragraph(
            f'<font size=28 color="#c7c3f0">{n} {n} {n}</font>&nbsp;&nbsp;&nbsp;'
            f'<font size=28>{"_"*10}</font>',
            ParagraphStyle("num", parent=styles["Normal"], spaceAfter=10)))
    _footer(story, styles, "Number Tracing · TK")
    doc.build(story)
    return buf.getvalue()


def _drill_addition_10():
    probs, answers = [], []
    for _ in range(12):
        a, b = random.randint(0, 5), random.randint(0, 5)
        probs.append(f"{a} + {b} = ___")
        answers.append(str(a + b))
    return _build("1-Minute Math: Addition to 10", "Go as fast as you can — accuracy first!", probs,
                  "Timed Drill · Kindergarten", answers=answers)


# ── Shared helpers for non-math content ─────────────────────────────────────

def _text_page(title, subtitle, blocks, footer_label, answers=None):
    """blocks: list of strings, or (heading, body) tuples.
    answers, if given: list of answer strings rendered on a final Answer Key page."""
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib import colors
    buf, doc, story, styles = _doc(title, subtitle)
    for b in blocks:
        if isinstance(b, (tuple, list)):
            heading, body = b
            story.append(Paragraph(heading, ParagraphStyle("h", parent=styles["Heading2"],
                                                             fontSize=13, textColor=colors.HexColor("#5b4fcf"),
                                                             spaceBefore=10, spaceAfter=4)))
            story.append(Paragraph(body, ParagraphStyle("bd", parent=styles["Normal"], fontSize=12, leading=18)))
        else:
            story.append(Paragraph(b, ParagraphStyle("bd", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=8)))
    if answers:
        _packet_section(story, styles, "Answer Key", "For grown-ups — check your scholar's work against these answers.")
        ans_text = "&nbsp;&nbsp;&nbsp;&nbsp;".join(f"{i+1}. {a}" for i, a in enumerate(answers))
        story.append(Paragraph(ans_text, ParagraphStyle("aka", parent=styles["Normal"], fontSize=11, leading=19)))
    _footer(story, styles, footer_label, stars=min(max(len(blocks), 3), 10))
    doc.build(story)
    return buf.getvalue()


def _tracing_items(title, subtitle, items, footer_label):
    from reportlab.platypus import Paragraph
    from reportlab.lib.styles import ParagraphStyle
    buf, doc, story, styles = _doc(title, subtitle)
    for it in items:
        story.append(Paragraph(
            f'<font size=24 color="#c7c3f0">{it} {it} {it}</font>&nbsp;&nbsp;&nbsp;'
            f'<font size=24>{"_"*14}</font>',
            ParagraphStyle("tr", parent=styles["Normal"], spaceAfter=8)))
    _footer(story, styles, footer_label, stars=min(max(len(items), 3), 10))
    doc.build(story)
    return buf.getvalue()


def _checklist(title, subtitle, items, footer_label):
    from reportlab.platypus import Paragraph
    from reportlab.lib.styles import ParagraphStyle
    buf, doc, story, styles = _doc(title, subtitle)
    for i, it in enumerate(items, 1):
        story.append(Paragraph(f"[ ]  {i}. {it}", ParagraphStyle("cl", parent=styles["Normal"],
                                                                   fontSize=12, leading=22)))
    _footer(story, styles, footer_label, stars=min(max(len(items), 3), 10))
    doc.build(story)
    return buf.getvalue()


def _word_match_table(title, subtitle, pairs, footer_label):
    """pairs: list of (word, hint) — printed as a trace/match table."""
    probs = [f"{w}  —  {hint}" for w, hint in pairs]
    return _build(title, subtitle, probs, footer_label, cols=1, col_w=6.5)


# ── TK ───────────────────────────────────────────────────────────────────────

def _trace_letters_az():
    import string
    return _tracing_items("Trace Letters A–Z", "Trace each letter, then write it once on your own.",
                           list(string.ascii_uppercase), "Letter Tracing · TK")


def _beginning_sounds_smt():
    items = [
        ("sun, moon, sock", "S"), ("milk, mouse, map", "M"),
        ("tree, turtle, table", "T"), ("sea, snake, star", "S"),
        ("moon, mango, mitten", "M"), ("top, tiger, ten", "T"),
    ]
    probs = [f"{words}  ->  circle the beginning sound:  S   M   T   (answer: {ans})" for words, ans in items]
    return _build("Beginning Sounds: S, M, T", "Say each word aloud, then circle its beginning sound.", probs,
                  "Phonics · TK", cols=1, col_w=6.5)


def _numbers_minibook():
    blocks = [f"Page {n}:  {n} — I see {n} cow{'s' if n!=1 else ''} on the farm. Draw {n} cow{'s' if n!=1 else ''}!"
              for n in range(1, 11)]
    return _text_page("My First Numbers Mini-Book", "An 8-page foldable counting book — fold, cut, and read!",
                       blocks, "Counting Mini-Book · TK")


def _draw_your_own(title, facts, footer_label):
    """Honest substitute for an illustrated coloring page: a blank drawing
    frame + real, correct facts — not a pre-drawn line-art page."""
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.graphics.shapes import Drawing, Rect, Ellipse
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc(title, "Draw, then color, your own!")

    PURPLE = colors.HexColor("#5b4fcf")
    d = Drawing(5.5*inch, 4*inch)
    d.add(Rect(0, 0, 5.5*inch, 4*inch, strokeColor=PURPLE,
               strokeWidth=2, fillColor=colors.HexColor("#faf9ff"), strokeDashArray=[6, 4]))
    # A soft starter-shape guide, not a finished illustration
    d.add(Ellipse(2.75*inch, 2*inch, 1.3*inch, 0.8*inch, strokeColor=PURPLE,
                   strokeWidth=1.5, strokeDashArray=[4, 3], fillColor=None))
    story.append(d)
    story.append(Spacer(1, 12))
    story.append(Paragraph("Fun facts to inspire your drawing:", ParagraphStyle("h", parent=styles["Heading3"],
                                                                                 fontSize=13, spaceAfter=6)))
    for f in facts:
        story.append(Paragraph(f"•  {f}", ParagraphStyle("f", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=4)))
    _footer(story, styles, footer_label)
    doc.build(story)
    return buf.getvalue()


def _draw_unicorn():
    return _draw_your_own("Draw the Magical Unicorn",
        ["Unicorns are legendary creatures shown as horses with a single spiral horn.",
         "The unicorn has been a symbol of purity and grace in folklore for over 2,000 years.",
         "Give yours a rainbow mane — real or magical, it's your choice!"],
        "Draw & Color · TK")


def _draw_trex():
    return _draw_your_own("Draw the T-Rex Friend",
        ["Tyrannosaurus rex means 'tyrant lizard king' in Latin.",
         "T-Rex lived about 66–68 million years ago, at the very end of the age of dinosaurs.",
         "A T-Rex tooth could be as long as a banana!"],
        "Draw & Color · TK")


def _draw_flower():
    return _draw_your_own("Draw the Garden Flower",
        ["Flowers use bright colors and scents to attract bees and butterflies.",
         "A flower's petals protect the pollen and seeds growing at its center.",
         "This is a lovely one to make for someone you love — try adding a stem and leaves!"],
        "Draw & Color · TK")


def _draw_shark():
    return _draw_your_own("Draw the Friendly Shark",
        ["Sharks have swum in Earth's oceans for over 400 million years — before trees existed!",
         "A shark's skeleton is made of cartilage, the same flexible material as your ears.",
         "Most sharks are shy around people and would rather swim away."],
        "Draw & Color · K")


def _draw_race_car():
    return _draw_your_own("Draw the Race Car",
        ["The fastest race cars can reach speeds over 200 miles per hour.",
         "Race cars have wide, smooth tires called slicks for extra grip on the track.",
         "Add racing stripes and a big number to your car!"],
        "Draw & Color · Grade 1")


def _draw_castle():
    return _draw_your_own("Draw the Fairy-Tale Castle",
        ["Real castles had thick stone walls and moats to keep everyone safe.",
         "Tall towers let guards see far across the land to spot visitors.",
         "Add flags, windows, and maybe a dragon flying nearby!"],
        "Draw & Color · Grade 2")


# ── K ────────────────────────────────────────────────────────────────────────

def _sight_words_1():
    return _tracing_items("Sight Words Set 1", "Trace, read, and write each word twice.",
                           ["the", "a", "I", "is", "it"], "Sight Words · Kindergarten")


def _pinyin_four_tones():
    # Numbered tone notation used instead of diacritics — see generator notes.
    rows = [
        "ma1  (mā)  — mother, said with a flat, high tone",
        "ma2  (má)  — hemp, said with a rising tone",
        "ma3  (mǎ)  — horse, said with a dipping tone",
        "ma4  (mà)  — scold, said with a sharp falling tone",
        "ba1 / ba2 / ba3 / ba4  — practice the same four tones on 'ba'",
        "yi1 / yi2 / yi3 / yi4  — practice the same four tones on 'yi'",
    ]
    return _checklist("Pinyin: Four Tones Drill", "Same letters, four meanings — practice each tone aloud.",
                       rows, "Pinyin · Kindergarten")


def _decodable_sam_cat():
    blocks = [
        "Sam is a cat. Sam is fat. Sam sat on a mat.",
        "\"Nap, Sam, nap!\" said Dad. Sam sat and had a nap on the mat.",
        "1. Who is fat?   2. Where did Sam sit?   3. What did Sam do on the mat?",
    ]
    answers = ["1. Sam", "2. On the mat", "3. Sam had a nap"]
    return _text_page("Decodable: Sam the Cat", "A short-a decodable reader with 3 comprehension questions.",
                       blocks, "Decodable Reader · Kindergarten", answers=answers)


def _minibook_i_see_cat():
    pages = ["I see a cat.", "I see a cat run.", "I see a cat jump.", "I see a cat nap.",
             "I see a cat play.", "I see a cat eat.", "I see a cat purr.", "I love my cat!"]
    blocks = [f"Page {i}:  {p}" for i, p in enumerate(pages, 1)]
    return _text_page("Mini-Book: I See a Cat", "An 8-page emergent reader — fold, cut, and read!",
                       blocks, "Mini-Book · Kindergarten")


# ── 1st ──────────────────────────────────────────────────────────────────────

def _letras_primeras_palabras():
    pairs = [("el gato", "the cat"), ("el perro", "the dog"), ("la casa", "the house"),
             ("el sol", "the sun"), ("el agua", "the water"), ("la flor", "the flower")]
    return _word_match_table("Mis Primeras Palabras", "Match the Spanish word to its English meaning.",
                              pairs, "Letras · Grade 1")


def _short_vowel_sounds():
    words = ["cat", "bed", "pig", "dog", "cup", "hat", "net", "sit", "log", "bug", "map", "hen"]
    probs = [f"{w}  —  vowel sound: ___" for w in words]
    answers = [next(ch for ch in w if ch in "aeiou") for w in words]
    return _build("Short Vowel Sounds", "Write the short vowel you hear (a, e, i, o, u).", probs,
                  "Phonics · Grade 1", cols=2, col_w=3.3, answers=answers)


def _sight_words_2():
    return _tracing_items("Sight Words Set 2", "Trace, read, and write each word twice.",
                           ["and", "for", "not", "with", "they"], "Sight Words · Grade 1")


def _pinyin_tone_practice():
    rows = [
        "li1 / li2 / li3 / li4 — match each to tone 1 (flat), 2 (rising), 3 (dip), 4 (falling)",
        "wo3  — means 'I / me', third tone (dipping)",
        "ni3  — means 'you', third tone (dipping)",
        "hao3 — means 'good', third tone (dipping)",
        "ni3 hao3 — \"Hello!\" — say the two third-tones together, gliding low then rising",
    ]
    return _checklist("Pinyin Tone Practice", "Match Pinyin syllables to the correct tone.",
                       rows, "Pinyin · Grade 1")


def _minibook_family_story():
    prompts = [
        "My family's name is ___________________.",
        "There are ___ people in my family.",
        "My favorite family tradition is ___________________.",
        "A story my family tells is ___________________.",
        "My family is from ___________________.",
        "My favorite family meal is ___________________.",
        "Something I love about my family: ___________________.",
        "In 10 years, my family might ___________________.",
    ]
    blocks = [f"Page {i}:  {p}" for i, p in enumerate(prompts, 1)]
    return _text_page("Mini-Book: My Family's Story", "An 8-page fill-in-the-blank keepsake book.",
                       blocks, "Mini-Book · Grade 1")


def _tangshi_quiet_night(title="Tang Shi: Jing Ye Si (Li Bai)",
                          subtitle='Trace and recite the classic "Quiet Night Thoughts."',
                          footer="Tang Poetry · Grade 1"):
    # Numbered-tone Pinyin + English only — the PDF engine can't render CJK glyphs.
    blocks = [
        ("Quiet Night Thoughts — by Li Bai",
         "One of the most famous poems in Chinese literature, written over 1,200 years ago."),
        ("Line 1", "chuang2 qian2 ming2 yue4 guang1 — Before my bed, the bright moonlight"),
        ("Line 2", "yi2 shi4 di4 shang4 shuang1 — I took it for frost on the ground"),
        ("Line 3", "ju3 tou2 wang4 ming2 yue4 — I raise my head to view the moon"),
        ("Line 4", "di1 tou2 si1 gu4 xiang1 — then bow my head, thinking of home"),
        ("Practice", "Read each line aloud three times, then try reciting all four lines from memory."),
    ]
    return _text_page(title, subtitle, blocks, footer)


def _tangshi_quiet_night_minibook():
    return _tangshi_quiet_night(title="Jing Ye Si — Quiet Night Thoughts (Mini-Book)",
                                 subtitle="A Tang poem mini-book with Pinyin and English, one line per page.",
                                 footer="Tang Poetry Mini-Book · Grade 2")


# ── 2nd ──────────────────────────────────────────────────────────────────────

def _rangoli_geometry():
    from reportlab.graphics.shapes import Drawing, Circle, Line
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Rangoli Geometry", "Connect the dots into a symmetrical pattern, then color it in.")

    size = 5.5*inch
    d = Drawing(size, size)
    cx = cy = size/2
    PURPLE = colors.HexColor("#5b4fcf")
    # Concentric rings of dots at 8-fold symmetry — a real dot-grid rangoli guide
    import math
    for ring, radius in enumerate([0.8*inch, 1.6*inch, 2.4*inch], start=1):
        n_dots = 8 * ring
        for i in range(n_dots):
            ang = 2*math.pi*i/n_dots
            x, y = cx + radius*math.cos(ang), cy + radius*math.sin(ang)
            d.add(Circle(x, y, 2.5, fillColor=PURPLE, strokeColor=PURPLE))
    d.add(Circle(cx, cy, 4, fillColor=PURPLE, strokeColor=PURPLE))
    story.append(d)
    story.append(Spacer(1, 10))
    story.append(Paragraph(
        "Rangoli is a traditional Indian floor art made with colored powder, rice, or flower petals. "
        "Use a pencil to connect the dots into loops and petals, then color your design.",
        ParagraphStyle("b", parent=styles["Normal"], fontSize=12, leading=18)))
    _footer(story, styles, "Cultural Art · Grade 2")
    doc.build(story)
    return buf.getvalue()


def _calm_down_cards():
    cards = [
        "Take 5 slow breaths — in through your nose, out through your mouth.",
        "Squeeze your hands into fists, then let go. Do it 5 times.",
        "Name 5 things you can see, 4 you can hear, 3 you can touch.",
        "Give yourself a big hug and count to 10.",
        "Get a drink of water and stretch your arms up high.",
        "Draw how you feel right now — no words needed.",
    ]
    blocks = [f"Card {i}: {c}" for i, c in enumerate(cards, 1)]
    return _text_page("Calm-Down Cards", "Six printable cards, one calming strategy on each. Cut them out!",
                       blocks, "SEL · Grade 2")


def _gita_values():
    blocks = [
        ("Courage", "Arjuna felt afraid before a great challenge, but Krishna reminded him to do his duty with a "
                     "calm heart. Draw a time you were brave even when you felt scared."),
        ("Kindness", "The Gita teaches that helping others without expecting anything back is true kindness. "
                      "Draw or write about one kind thing you can do today."),
        ("Duty", "Doing your best at your own responsibilities — schoolwork, chores, being a good friend — "
                  "is a value the Gita calls dharma. What is one duty you're proud of?"),
    ]
    return _text_page("Gita Values Journal", "Reflect on courage, kindness, and duty — draw or write your answer for each.",
                       blocks, "Gita Values · Grade 2")


def _cursive_az_trace():
    import string
    return _tracing_items("Cursive A–Z Trace", "Dashed-guide cursive practice for every letter.",
                           list(string.ascii_lowercase), "Cursive Practice · Grade 2")


# ── 3rd ──────────────────────────────────────────────────────────────────────

def _garden_mandala():
    from reportlab.graphics.shapes import Drawing, Circle, Line
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    import math
    buf, doc, story, styles = _doc("Color a Garden Mandala", "A calming symmetrical mandala — color each ring a different way.")

    size = 5.5*inch
    d = Drawing(size, size)
    cx = cy = size/2
    PURPLE = colors.HexColor("#5b4fcf")
    for r in [0.7*inch, 1.4*inch, 2.1*inch, 2.6*inch]:
        d.add(Circle(cx, cy, r, strokeColor=PURPLE, strokeWidth=1.5, fillColor=None))
    for i in range(12):
        ang = 2*math.pi*i/12
        x2, y2 = cx + 2.6*inch*math.cos(ang), cy + 2.6*inch*math.sin(ang)
        d.add(Line(cx, cy, x2, y2, strokeColor=PURPLE, strokeWidth=1))
        # petal dot at each ring intersection
        for r in [0.7*inch, 1.4*inch, 2.1*inch]:
            d.add(Circle(cx + r*math.cos(ang), cy + r*math.sin(ang), 3, fillColor=PURPLE))
    story.append(d)
    story.append(Spacer(1, 10))
    story.append(Paragraph(
        "Mandalas are circular designs found in gardens, art, and nature — even flowers and snowflakes "
        "are natural mandalas. Color each ring a different pattern for a calming focus activity.",
        ParagraphStyle("b", parent=styles["Normal"], fontSize=12, leading=18)))
    _footer(story, styles, "Garden Mandala · Grade 3")
    doc.build(story)
    return buf.getvalue()


def _flor_nochebuena(footer_label="Cuentos · Grade 3"):
    blocks = [
        ("La Flor de Nochebuena — The Poinsettia Legend",
         "A beloved Mexican Christmas legend, retold simply."),
        ("Español", "Hace muchos años, una niña llamada Pepita no tenía regalo para el Niño Jesús en la misa de "
                     "Nochebuena. Un ángel le dijo que cualquier regalo dado con amor era especial. Pepita recogió "
                     "unas ramitas verdes del camino. Al ponerlas en el altar, ¡las ramitas se convirtieron en "
                     "flores rojas brillantes! Así nació la flor de Nochebuena."),
        ("English", "Long ago, a girl named Pepita had no gift for baby Jesus at the Christmas Eve mass. An angel "
                     "told her that any gift given with love was special. Pepita gathered green weeds from the "
                     "roadside. When she placed them on the altar, the weeds burst into bright red flowers — "
                     "and the poinsettia was born."),
        ("Draw", "Draw the moment the green branches turned into red flowers."),
    ]
    return _text_page("La Flor de Nochebuena", "A bilingual Spanish/English mini-story for Cuentos time.",
                       blocks, footer_label)


def _pattern_power_3():
    probs = [
        "2, 4, 6, 8, ___, ___", "5, 10, 15, 20, ___, ___", "1, 3, 5, 7, ___, ___",
        "3, 6, 9, 12, ___, ___", "tri, circ, sq, tri, circ, sq, tri, circ, ___", "AA BB AA BB AA ___ ___",
        "100, 90, 80, 70, ___, ___", "1, 4, 9, 16, ___ (square numbers)",
    ]
    answers = ["10, 12", "25, 30", "9, 11", "15, 18", "sq", "BB, AA", "60, 50", "25"]
    return _build("Pattern Power - Level 3", "Identify and extend each number or shape pattern.", probs,
                  "Logic & Patterns · Grade 3", cols=2, col_w=3.3, answers=answers)


def _chess_pawns():
    blocks = [
        ("How pawns move", "A pawn moves straight forward one square — except on its very first move, when it "
                            "may move forward one OR two squares."),
        ("How pawns capture", "A pawn captures diagonally, one square forward-left or forward-right — never straight ahead."),
        ("Mini puzzle", "A white pawn starts on e2. Draw a small board and mark every square it could move to on "
                         "its very first move. (Answer: e3 and e4.)"),
        ("Bonus", "What is the only piece that captures differently than it moves? (Answer: the pawn!)"),
    ]
    return _text_page("Chess Mini-Lesson: Pawns", "Learn how pawns move and capture, then solve the mini puzzle.",
                       blocks, "Chess · Grade 3")


def _cursive_letter_pack():
    import string
    items = list(string.ascii_uppercase) + list(string.ascii_lowercase)
    return _tracing_items("Cursive Letter Pack", "Joined-up cursive practice, uppercase then lowercase.",
                           items, "Cursive Practice · Grade 3")


# ── 4th ──────────────────────────────────────────────────────────────────────

def _papel_picado():
    from reportlab.graphics.shapes import Drawing, Rect, Line, Circle, String
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Papel Picado Craft", "Fold-and-cut instructions for a traditional Mexican paper banner.")

    steps = [
        "1. Fold a rectangular sheet of tissue paper in half, then in half again (like a fan or a book).",
        "2. Along the folded edges, cut out small triangles and half-circles — follow the dashed guide below.",
        "3. Unfold carefully — you'll reveal a symmetrical cut-paper pattern!",
        "4. String several finished papers along a piece of twine to make a banner (papel picado).",
    ]
    from reportlab.platypus import Paragraph as P
    for s in steps:
        story.append(P(s, ParagraphStyle("s", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=6)))

    d = Drawing(5.5*inch, 3*inch)
    PURPLE = colors.HexColor("#5b4fcf")
    d.add(Rect(0, 0, 5.5*inch, 3*inch, strokeColor=PURPLE, strokeWidth=2, fillColor=colors.HexColor("#faf9ff")))
    d.add(Line(2.75*inch, 0, 2.75*inch, 3*inch, strokeColor=PURPLE, strokeDashArray=[4, 3]))
    for cx in [1.1*inch, 2.75*inch, 4.4*inch]:
        d.add(Circle(cx, 1.5*inch, 0.35*inch, strokeColor=PURPLE, strokeDashArray=[3, 2], fillColor=None))
    story.append(Spacer(1, 8))
    story.append(d)
    _footer(story, styles, "Craft Template · Grade 4")
    doc.build(story)
    return buf.getvalue()


def _empathy_scenarios():
    blocks = [
        ("Scenario 1", "A classmate drops their lunch tray in the cafeteria and everyone laughs. What's a kind response?"),
        ("Scenario 2", "Your friend seems quiet and sad at recess but says \"I'm fine.\" What's a kind response?"),
        ("Scenario 3", "A new student doesn't know anyone and is sitting alone at lunch. What's a kind response?"),
        ("Scenario 4", "Your sibling is upset because they lost a game. What's a kind response?"),
        ("Reflect", "Write about a time someone showed YOU empathy — how did it feel?"),
    ]
    return _text_page("Empathy Scenarios", "Read each scenario, then write the kind response.",
                       blocks, "SEL Workbook · Grade 4")


def _gita_little_lamp():
    blocks = [
        ("The Little Lamp", "A small oil lamp once worried, \"I am so tiny compared to the sun — what's the "
                             "point of my little light?\" An old teacher smiled and said, \"On the darkest night, "
                             "even a small lamp can guide someone home. Your purpose isn't to be the biggest "
                             "light — it's to shine where you are.\""),
        ("Reflect", "Write about one small, kind action you did that made a bigger difference than you expected."),
        ("Draw", "Draw the little lamp shining in the dark."),
    ]
    return _text_page("The Little Lamp (Gita)", "An inspirational Gita mini-story about a small light with big purpose.",
                       blocks, "Gita Story · Grade 4")


def _logic_grid_pets():
    blocks = [
        ("Clues",
         "1. Mia, Sam, and Priya each own exactly one pet: a dog, a cat, or a fish.<br/>"
         "2. Mia is allergic to fur, so she doesn't own the dog or the cat.<br/>"
         "3. Sam's pet doesn't live in water.<br/>"
         "4. Priya's pet has four legs."),
        ("Your grid — mark YES or NO in each box",
         "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dog&nbsp;&nbsp;&nbsp;&nbsp;Cat&nbsp;&nbsp;&nbsp;&nbsp;Fish<br/>"
         "Mia&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___<br/>"
         "Sam&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___<br/>"
         "Priya&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___"),
    ]
    answers = ["Mia -> Fish", "Sam -> Cat", "Priya -> Dog"]
    return _text_page("Logic Grid: Who Owns Which Pet?", "Use the clues to fill in the grid and solve the puzzle.",
                       blocks, "Logic Puzzle · Grade 4", answers=answers)


def _persuasive_essay_frame():
    blocks = [
        ("Hook", "Start with a question, surprising fact, or bold statement: _______________________"),
        ("Claim", "My opinion is: _______________________"),
        ("Reason 1", "One reason is _______________________ because _______________________"),
        ("Reason 2", "Another reason is _______________________ because _______________________"),
        ("Counter-argument", "Someone might disagree and say _______________________ but _______________________"),
        ("Closing line", "End with a strong final sentence: _______________________"),
    ]
    return _text_page("Persuasive Essay Frame", "Hook, claim, two reasons, counter-argument, and a closing line.",
                       blocks, "Writing · Grade 4")


# ── 5th ──────────────────────────────────────────────────────────────────────

def _one_point_perspective():
    from reportlab.graphics.shapes import Drawing, Line, Circle, Rect
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("One-Point Perspective", "Learn to draw a road, building, or tunnel using a single vanishing point.")

    steps = [
        "1. Mark a single dot in the middle of your page — this is the vanishing point.",
        "2. Draw a rectangle (a building or door) anywhere on the page.",
        "3. Lightly draw guide lines from each corner of the rectangle to the vanishing point.",
        "4. Draw a second, smaller rectangle along those guide lines — it will look farther away!",
        "5. Trace over your favorite lines in pen, then erase the extra guide lines.",
    ]
    from reportlab.platypus import Paragraph as P
    for s in steps:
        story.append(P(s, ParagraphStyle("s", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=6)))

    d = Drawing(5.5*inch, 3.5*inch)
    PURPLE = colors.HexColor("#5b4fcf")
    vx, vy = 2.75*inch, 1.75*inch
    d.add(Circle(vx, vy, 3, fillColor=PURPLE))
    d.add(Rect(0.5*inch, 0.5*inch, 1.5*inch, 2*inch, strokeColor=PURPLE, strokeWidth=2, fillColor=None))
    for corner in [(0.5*inch, 0.5*inch), (2*inch, 0.5*inch), (0.5*inch, 2.5*inch), (2*inch, 2.5*inch)]:
        d.add(Line(corner[0], corner[1], vx, vy, strokeColor=PURPLE, strokeDashArray=[3, 3]))
    story.append(Spacer(1, 8))
    story.append(d)
    _footer(story, styles, "Art Technique · Grade 5")
    doc.build(story)
    return buf.getvalue()


def _sudoku_6x6():
    from reportlab.platypus import Table, TableStyle, Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Sudoku 6×6", "Fill every row, column, and 2×3 box with the numbers 1–6, no repeats.")

    solution = [
        [1, 2, 3, 4, 5, 6], [4, 5, 6, 1, 2, 3],
        [2, 3, 1, 5, 6, 4], [5, 6, 4, 2, 3, 1],
        [3, 1, 2, 6, 4, 5], [6, 4, 5, 3, 1, 2],
    ]
    keep = set(random.sample([(r, c) for r in range(6) for c in range(6)], 18))
    grid = [[str(solution[r][c]) if (r, c) in keep else "" for c in range(6)] for r in range(6)]

    t = Table(grid, colWidths=[0.55*inch]*6, rowHeights=[0.55*inch]*6)
    style = [
        ("GRID", (0, 0), (-1, -1), 0.75, colors.HexColor("#999")),
        ("ALIGN", (0, 0), (-1, -1), "CENTER"), ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
        ("FONTSIZE", (0, 0), (-1, -1), 16),
        ("FONTNAME", (0, 0), (-1, -1), "Kalam-Bold"),
    ]
    for c in (0, 3):
        style.append(("LINEBEFORE", (c, 0), (c, -1), 2, colors.HexColor("#5b4fcf")))
    for r in (0, 2, 4):
        style.append(("LINEABOVE", (0, r), (-1, r), 2, colors.HexColor("#5b4fcf")))
    style.append(("BOX", (0, 0), (-1, -1), 2, colors.HexColor("#5b4fcf")))
    t.setStyle(TableStyle(style))
    story.append(t)
    story.append(Spacer(1, 12))
    story.append(Paragraph("Rule: every row, every column, and each 2×3 box must contain 1, 2, 3, 4, 5, 6 exactly once.",
                            ParagraphStyle("r", parent=styles["Normal"], fontSize=11, leading=16)))
    _footer(story, styles, "Sudoku · Grade 5")
    doc.build(story)
    return buf.getvalue()


def _theme_tone_reading():
    blocks = [
        ("The Old Oak Tree", "Every autumn, Maren's grandfather planted a new sapling beside the old oak in "
                              "their yard. \"Trees like this one weren't planted for me,\" he'd say, patting the "
                              "oak's rough bark. \"Someone planted it for you, long before you were born. So "
                              "we plant this one for someone we'll never meet.\" Maren didn't understand at "
                              "first — but years later, sitting in the shade of a tree her grandfather had "
                              "planted, she finally did."),
        ("Questions",
         "1. What is the theme (life lesson) of this passage?<br/>"
         "2. What is the tone (the writer's attitude)? Choose one: humorous, reflective, angry, silly.<br/>"
         "3. Find one sentence that best supports the theme, and explain why."),
    ]
    answers = ["1. Theme — example: we should do good for people we'll never meet, the way past generations did for us",
               "2. Tone — reflective", "3. Answers will vary — any sentence about planting for someone unseen works"]
    return _text_page("Theme & Tone Reading Pack", "Read the passage, then answer the theme and tone questions.",
                       blocks, "Reading Comprehension · Grade 5", answers=answers)


# ── 6th ──────────────────────────────────────────────────────────────────────

def _greek_latin_roots():
    roots = [
        ("bio", "life (Greek) -> biology, biography"), ("tele", "far (Greek) -> telephone, television"),
        ("port", "carry (Latin) -> transport, portable"), ("dict", "say/speak (Latin) -> dictionary, predict"),
        ("aqua", "water (Latin) -> aquarium, aquatic"), ("photo", "light (Greek) -> photograph, photosynthesis"),
        ("scrib/script", "write (Latin) -> describe, manuscript"), ("graph", "write/draw (Greek) -> paragraph, autograph"),
    ]
    probs = [f"{r}  =  {m}   ->  build a new word: ___________________" for r, m in roots]
    answers = [f"any word using '{r}' works — examples: {m.split('->')[-1].strip()}" for r, m in roots]
    return _build("Greek & Latin Roots", "Match each root to its meaning, then build a new word.", probs,
                  "Vocabulary · Grade 6", cols=1, col_w=6.5, answers=answers)


def _tangshi_capstone_20():
    # Numbered-tone Pinyin (no hanzi/diacritics — the PDF engine can't render them)
    poems = [
        "Jing4 Ye4 Si1 — Quiet Night Thoughts, by Li Bai", "Chun1 Xiao3 — Spring Dawn, by Meng Haoran",
        "Deng1 Guan4que4 Lou2 — On the Stork Tower, by Wang Zhihuan", "Min3 Nong2 — Sympathy for the Farmer, by Li Shen",
        "Yong3 E2 — Ode to the Goose, by Luo Binwang", "Xiang1 Si1 — Lovesickness, by Wang Wei",
        "Zao3 Fa1 Bai2di4 Cheng2 — Leaving Baidi at Dawn, by Li Bai", "Wang4 Lu2shan1 Pu4bu4 — Watching the Lushan Waterfall, by Li Bai",
        "Shan1 Xing2 — Mountain Journey, by Du Mu", "You2zi3 Yin2 — Song of the Wandering Son, by Meng Jiao",
    ]
    items = [f"{p}  —  memorized on: ___________" for p in poems] + [f"Poem {i} of your choice — memorized on: ___________" for i in range(11, 21)]
    return _checklist("Tang Shi Capstone: Recite 20 Poems", "A tracking sheet for the 20-poem recitation capstone.",
                       items, "Tang Poetry Capstone · Grade 6")


def _argument_essay_frame():
    blocks = [
        ("Claim", "My argument is: _______________________"),
        ("Evidence 1", "Supporting evidence: _______________________"),
        ("Evidence 2", "Supporting evidence: _______________________"),
        ("Counter-claim", "The opposing view is: _______________________"),
        ("Rebuttal", "Here's why the opposing view falls short: _______________________"),
        ("Conclusion", "Restate your claim and its importance: _______________________"),
    ]
    return _text_page("Argument Essay Frame", "Claim, two pieces of evidence, counter-claim, rebuttal, conclusion.",
                       blocks, "Writing · Grade 6")


# ── Coverage batch 1 — filling grade/subject gaps ───────────────────────────
# Added to bring every (subject, grade) combination toward at least 5
# worksheets. This is an incremental, multi-session effort — see
# lsh.database/30_worksheet_coverage_batch1.sql for exactly which
# combinations this batch targets and what's still outstanding.

def _subtraction_hop_10():
    probs, answers = [], []
    for _ in range(15):
        a = random.randint(0, 10)
        b = random.randint(0, a)
        probs.append(f"{a} - {b} = ___")
        answers.append(str(a - b))
    return _build("Subtraction Hop 1–10", "Subtract the numbers, staying between 0 and 10.", probs,
                  "Subtraction · Grade 1", answers=answers)


def _fraction_fundamentals():
    import math
    probs, answers = [], []
    denoms = [2, 3, 4, 5, 6, 8, 10, 12]
    for _ in range(12):
        d = random.choice(denoms)
        a, b = random.randint(1, d - 1), random.randint(1, d - 1)
        while a + b >= 2 * d:
            a, b = random.randint(1, d - 1), random.randint(1, d - 1)
        probs.append(f"{a}/{d}  +  {b}/{d}  =  ___  (simplify if you can)")
        num = a + b
        g = math.gcd(num, d)
        simp_num, simp_d = num // g, d // g
        answers.append(str(simp_num) if simp_d == 1 else f"{simp_num}/{simp_d}")
    return _build("Fraction Fundamentals", "Add the fractions — they already share a denominator.", probs,
                  "Fractions · Grade 5", answers=answers)


def _ratios_percents_6():
    probs, answers = [], []
    for _ in range(12):
        whole = random.choice([20, 25, 40, 50, 80, 100, 200])
        pct = random.choice([10, 20, 25, 50, 75])
        probs.append(f"What is {pct}% of {whole}?   ___")
        answers.append(str(int(whole * pct / 100)))
    return _build("Ratios & Percents", "Find each percentage of the total.", probs, "Ratios & Percents · Grade 6",
                  answers=answers)


def _rhyming_words_match():
    pairs = [
        ("cat", "rhymes with: hat, mat, bat"), ("dog", "rhymes with: log, fog, jog"),
        ("sun", "rhymes with: run, fun, bun"), ("bee", "rhymes with: tree, see, key"),
        ("pig", "rhymes with: dig, wig, big"), ("box", "rhymes with: fox, socks, rocks"),
    ]
    return _word_match_table("Rhyming Words Match", "Say each word, then circle the ones that rhyme.",
                              pairs, "Phonics · TK")


def _draw_happy_sun():
    return _draw_your_own("Draw the Happy Sun",
        ["The sun is a giant star — so big that about 1.3 million Earths could fit inside it.",
         "Sunlight takes about 8 minutes to travel from the sun to Earth.",
         "Give your sun a big smile and some warm, wiggly rays!"],
        "Draw & Color · TK")


def _draw_rocket_ship():
    return _draw_your_own("Draw the Rocket Ship",
        ["A rocket needs to reach about 25,000 miles per hour to escape Earth's gravity.",
         "Rockets carry their own oxygen so they can fly even where there's no air.",
         "Add fins, windows, and a trail of fire blasting out the bottom!"],
        "Draw & Color · Grade 2")


def _pattern_detective_3():
    blocks = [
        ("Puzzle 1", "2, 4, 6, 8, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 2", "1, 3, 5, 7, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 3", "5, 10, 15, 20, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 4", "🔴🔵🔴🔵🔴, ___, ___  ->  Draw the next two shapes."),
        ("Puzzle 5", "100, 90, 80, 70, ___, ___  ->  What's the rule? _______________"),
        ("Challenge", "Make up your own pattern of 5 numbers, then ask a family member to find the rule."),
    ]
    answers = [
        "1. 10, 12 — add 2 each time", "2. 9, 11 — add 2 each time", "3. 25, 30 — add 5 each time",
        "4. blue, red — the pattern alternates red, blue", "5. 60, 50 — subtract 10 each time",
        "Challenge — answers will vary",
    ]
    return _text_page("Pattern Detective", "Find the rule, then continue each pattern.",
                       blocks, "Logic Puzzle · Grade 3", answers=answers)


def _silent_e_magic():
    pairs = [
        ("cap -> cape", "the silent e makes the a say its name"), ("kit -> kite", "the silent e makes the i say its name"),
        ("hop -> hope", "the silent e makes the o say its name"), ("cut -> cute", "the silent e makes the u say its name"),
        ("pin -> pine", "the silent e makes the i say its name"), ("plan -> plane", "the silent e makes the a say its name"),
    ]
    return _word_match_table("Silent E Magic", "Add a silent e to the end — watch the vowel change its sound!",
                              pairs, "Phonics · Grade 2")


def _phonics_word_chunking_6():
    pairs = [
        ("un-der-stand", "3 chunks: un / der / stand"), ("ex-plan-a-tion", "4 chunks: ex / plan / a / tion"),
        ("in-de-pen-dent", "4 chunks: in / de / pen / dent"), ("com-mu-ni-ty", "4 chunks: com / mu / ni / ty"),
        ("ge-og-ra-phy", "4 chunks: ge / og / ra / phy"), ("re-spon-si-ble", "4 chunks: re / spon / si / ble"),
    ]
    return _word_match_table("Multisyllabic Word Chunking", "Clap out each chunk (syllable), then check your count.",
                              pairs, "Phonics · Grade 6")


def _write_your_own_fable():
    blocks = [
        ("What is a fable?", "A fable is a short story with animal characters that teaches a moral (a lesson about "
                              "life), like \"The Tortoise and the Hare\" teaches that slow and steady wins the race."),
        ("Pick your characters", "Choose two animals with opposite traits (e.g. a proud lion and a clever mouse): "
                                  "_______________________  and  _______________________"),
        ("The setup", "Where and when does your fable happen? _______________________"),
        ("The problem", "What challenge or conflict do your characters face? _______________________"),
        ("The moral", "What lesson will your fable teach? _______________________"),
        ("Write it", "Now write your fable in 6–10 sentences on a separate sheet, then read it aloud to someone."),
    ]
    return _text_page("Write Your Own Fable", "Plan and draft a short fable with a clear moral.",
                       blocks, "Creative Writing · Grade 6")


def _story_starters_mystery():
    blocks = [
        ("Starter 1", "The library was locked for the night, but the light in the third-floor window was on again..."),
        ("Starter 2", "Every clock in the house had stopped at exactly 3:17 — except the one in the attic..."),
        ("Starter 3", "The dog wouldn't stop digging in the same spot in the backyard, no matter how many times "
                       "we filled it back in..."),
        ("Your job", "Pick one starter (or write your own mystery opening), then answer: Who is your detective? "
                      "What's the first clue they find? Continue the story on a separate sheet."),
    ]
    return _text_page("Story Starters: Mystery Edition", "Pick a mysterious opening line and continue the story.",
                       blocks, "Creative Writing · Grade 5")


def _build_a_story_character():
    blocks = [
        ("Step 1: Choose your character", "Name: _______________  Age: _____  Special trait: _______________________"),
        ("Step 2: Choose the setting", "Where does your story take place, and when? _______________________"),
        ("Step 3: Choose the problem", "What goes wrong, or what does your character want? _______________________"),
        ("Step 4: Choose the turning point", "What does your character try, and does it work at first? _______________________"),
        ("Step 5: Choose the ending", "How is the problem solved, and what does your character learn? _______________________"),
        ("Write it", "Use your five steps to write a full story on a separate sheet."),
    ]
    return _text_page("Build-a-Story: Choose Your Character", "Fill in each story-building step, then write the full story.",
                       blocks, "Creative Writing · Grade 4")


def _compare_contrast_habitats():
    blocks = [
        ("Desert", "Deserts get less than 10 inches of rain a year. Animals like camels and kangaroo rats survive "
                    "by storing water and staying in shade during the hottest part of the day. Plants like cacti "
                    "store water in thick stems."),
        ("Rainforest", "Rainforests get over 100 inches of rain a year and stay warm year-round. Animals like "
                        "tree frogs and toucans live among tall, dense trees. Plants grow in layers, competing "
                        "for sunlight from the forest floor to the canopy."),
        ("Compare", "List 2 things the desert and rainforest have in common: _______________________"),
        ("Contrast", "List 2 ways the desert and rainforest are different: _______________________"),
        ("Think", "Which habitat would be harder for YOU to survive in, and why? _______________________"),
    ]
    return _text_page("Compare & Contrast: Two Habitats", "Read about both habitats, then compare and contrast.",
                       blocks, "Reading Comprehension · Grade 3")


def _main_idea_details_2():
    blocks = [
        ("Bees at Work", "A honeybee visits about 50 to 100 flowers on a single trip out of the hive. It collects "
                          "nectar to make honey and picks up pollen on its fuzzy legs along the way. When the bee "
                          "moves to the next flower, some of that pollen rubs off — helping the plant make seeds. "
                          "Without bees carrying pollen from flower to flower, many plants couldn't grow fruit at all."),
        ("Main idea", "What is this passage mostly about? Circle one: (a) how bees make honey  (b) how bees help "
                       "plants grow by moving pollen  (c) how many flowers bees like"),
        ("Details", "List 2 details from the passage that support the main idea: _______________________"),
    ]
    answers = [
        "Main idea — (b) how bees help plants grow by moving pollen",
        "Details — example: bees visit 50-100 flowers per trip; pollen rubs off onto the next flower",
    ]
    return _text_page("Main Idea & Details Practice", "Read the passage, then find the main idea and supporting details.",
                       blocks, "Reading Comprehension · Grade 2", answers=answers)


def _story_sequence_1():
    blocks = [
        ("The Lost Mitten", "Ben lost his blue mitten on the walk to school. First, he checked his backpack, but "
                             "it wasn't there. Next, he asked his friend Mia if she'd seen it. Then, Mia remembered "
                             "seeing it fall near the big oak tree. Finally, they walked back together and found "
                             "the mitten sitting right on a root, waiting for him."),
        ("Put it in order", "Number these events 1–4:\n"
                             "___ Mia remembers where she saw it\n"
                             "___ Ben checks his backpack\n"
                             "___ They find the mitten by the tree\n"
                             "___ Ben asks Mia if she's seen it"),
        ("Your turn", "Draw what happened FIRST, then what happened LAST, in two boxes on the back of this page."),
    ]
    answers = ["Ben checks his backpack = 1", "Ben asks Mia if she's seen it = 2",
               "Mia remembers where she saw it = 3", "They find the mitten by the tree = 4"]
    return _text_page("Story Sequence: What Happened First?", "Read the story, then put the events in order.",
                       blocks, "Reading Comprehension · Grade 1", answers=answers)


def _practice_pack_week1(grade_label: str, footer_grade: str):
    blocks = [
        ("Counting warm-up", "Count out loud from 1 to 20, then write the numbers 1–10 on the lines below: "
                              "_______________________"),
        ("Letter warm-up", "Write the first letter of your name 5 times, as neatly as you can: _______________________"),
        ("Shapes", "Draw a circle, a square, and a triangle. Color one of them your favorite color."),
        ("Listening", "Ask a grown-up to read you a short story. Draw your favorite part."),
        ("Kindness check-in", "Tell someone one nice thing that happened today."),
    ]
    return _text_page(f"{grade_label} Practice Pack: Week 1", "A short weekly mix of counting, letters, shapes, and listening.",
                       blocks, f"Practice Pack · {footer_grade}")


def _practice_pack_tk():
    return _practice_pack_week1("TK", "TK")


def _practice_pack_k():
    return _practice_pack_week1("Kindergarten", "Kindergarten")


def _practice_pack_1():
    blocks = [
        ("Math warm-up", "Solve: 4+3=___  7-2=___  5+5=___  9-4=___  6+2=___"),
        ("Reading warm-up", "Read one short book, then write its title: _______________________"),
        ("Writing", "Write 2 sentences about your favorite part of this week."),
        ("Spelling", "Write these words 3 times each: the, said, was, they, have"),
        ("Reflection", "What is one thing you got better at this week? _______________________"),
    ]
    answers = ["Math warm-up — 4+3=7, 7-2=5, 5+5=10, 9-4=5, 6+2=8"]
    return _text_page("1st Grade Practice Pack: Week 1", "A short weekly mix of math, reading, writing, and spelling.",
                       blocks, "Practice Pack · Grade 1", answers=answers)


def _practice_pack_5():
    blocks = [
        ("Math warm-up", "Solve: 3/4 + 1/8 = ___   12 x 15 = ___   144 ÷ 12 = ___   What is 30% of 90? ___"),
        ("Reading warm-up", "Read for 15 minutes, then summarize the main idea in 2 sentences."),
        ("Writing", "Write a paragraph (5+ sentences) about a goal you have for this month."),
        ("Vocabulary", "Look up and write the definitions of: perseverance, curious, analyze"),
        ("Reflection", "What is one thing you got better at this week? _______________________"),
    ]
    answers = ["Math warm-up — 3/4 + 1/8 = 7/8,  12 x 15 = 180,  144 ÷ 12 = 12,  30% of 90 = 27"]
    return _text_page("5th Grade Practice Pack: Week 1", "A short weekly mix of math, reading, writing, and vocabulary.",
                       blocks, "Practice Pack · Grade 5", answers=answers)


# ── Coverage batch 2 — filling grade/subject gaps ───────────────────────────
# Continues the batch-1 effort — see lsh.database/31_worksheet_coverage_batch2.sql
# for exactly which combinations this batch completes and what's still open.

def _cvc_word_building():
    pairs = [
        ("c-a-t", "cat — a short a sound in the middle"), ("d-o-g", "dog — a short o sound in the middle"),
        ("p-i-g", "pig — a short i sound in the middle"), ("s-u-n", "sun — a short u sound in the middle"),
        ("b-e-d", "bed — a short e sound in the middle"), ("h-o-p", "hop — a short o sound in the middle"),
    ]
    return _word_match_table("CVC Word Building", "Blend each consonant-vowel-consonant word, then read it aloud.",
                              pairs, "Phonics · Grade 1")


def _digraph_detectives():
    pairs = [
        ("ship", "sh — say 'shhh' like asking for quiet"), ("chip", "ch — say 'ch' like a train"),
        ("thin", "th — put your tongue between your teeth"), ("shell", "sh — say 'shhh'"),
        ("chop", "ch — say 'ch'"), ("that", "th — tongue between your teeth"),
    ]
    return _word_match_table("Digraph Detectives: sh, ch, th", "Circle the digraph (2 letters, 1 sound) in each word.",
                              pairs, "Phonics · Grade 1")


def _retell_beginning_middle_end():
    blocks = [
        ("The Lost Puppy", "A puppy named Rex wandered away from his yard chasing a butterfly. He got scared "
                            "when he couldn't find his way home. A kind girl named Ana saw him shivering by a "
                            "fence and brought him inside for a warm blanket and food. The next day, Ana found "
                            "Rex's owner using the tag on his collar, and Rex ran happily back into his family's arms."),
        ("Beginning", "Draw or write what happened at the START of the story: _______________________"),
        ("Middle", "Draw or write what happened in the MIDDLE of the story: _______________________"),
        ("End", "Draw or write what happened at the END of the story: _______________________"),
    ]
    answers = ["Beginning — example: Rex wandered away chasing a butterfly and got lost.",
               "Middle — example: Ana found shivering Rex and brought him inside for warmth and food.",
               "End — example: Ana used Rex's collar tag to find his owner, and Rex went home."]
    return _text_page("Retell the Story: Beginning, Middle, End", "Read the story, then retell it in three parts.",
                       blocks, "Reading Comprehension · Kindergarten", answers=answers)


def _picture_clue_riddles():
    blocks = [
        ("Riddle 1", "I am yellow and round. I rise in the morning and set at night. What am I? ___________"),
        ("Riddle 2", "I have four legs, a tail, and I say 'moo'. What am I? ___________"),
        ("Riddle 3", "I am cold, white, and fall from the sky in winter. What am I? ___________"),
        ("Riddle 4", "I have wings, I am small, and I buzz around flowers. What am I? ___________"),
        ("Your turn", "Write your own picture-clue riddle for someone else to guess!"),
    ]
    answers = ["1. The sun", "2. A cow", "3. Snow", "4. A bee"]
    return _text_page("Picture Clues: Guess the Word", "Use the clues to guess each word.",
                       blocks, "Reading Comprehension · Kindergarten", answers=answers)


def _cause_effect_storm():
    blocks = [
        ("The Big Storm", "Dark clouds rolled in fast, so the lifeguards blew their whistles and cleared the "
                           "beach. Because the wind grew so strong, the town's power lines snapped, leaving "
                           "thousands of homes without electricity. Since school was cancelled the next day, "
                           "Maya and her brother spent the morning helping their neighbor clear fallen branches "
                           "from her driveway instead."),
        ("Find the pairs", "1. Cause: dark clouds rolled in  ->  Effect: _______________________<br/>"
                            "2. Cause: wind grew strong  ->  Effect: _______________________<br/>"
                            "3. Cause: school was cancelled  ->  Effect: _______________________"),
        ("Think further", "What might have happened if the lifeguards hadn't cleared the beach in time? _______________________"),
    ]
    answers = ["1. Effect: lifeguards blew their whistles and cleared the beach",
               "2. Effect: power lines snapped, leaving homes without electricity",
               "3. Effect: Maya and her brother helped their neighbor clear fallen branches"]
    return _text_page("Cause & Effect: The Big Storm", "Find each cause-and-effect pair in the passage.",
                       blocks, "Reading Comprehension · Grade 5", answers=answers)


def _authors_purpose_practice():
    blocks = [
        ("Remember PIE", "Authors write to Persuade, Inform, or Entertain."),
        ("Passage A", "\"Studies show kids who read 20 minutes a day score higher on vocabulary tests.\" "
                       "Purpose? ___________ (Persuade / Inform / Entertain)"),
        ("Passage B", "\"Once upon a time, a dragon who was afraid of fire lived in a very cold cave...\" "
                       "Purpose? ___________ (Persuade / Inform / Entertain)"),
        ("Passage C", "\"You should recycle your cans and bottles — it's one of the easiest ways to help the planet!\" "
                       "Purpose? ___________ (Persuade / Inform / Entertain)"),
        ("Your turn", "Write one short sentence for each purpose: Persuade, Inform, Entertain."),
    ]
    answers = ["Passage A — Inform", "Passage B — Entertain", "Passage C — Persuade"]
    return _text_page("Author's Purpose Practice", "Decide whether each passage is meant to persuade, inform, or entertain.",
                       blocks, "Reading Comprehension · Grade 5", answers=answers)


def _inference_practice_6():
    blocks = [
        ("Passage", "Maria checked her watch for the third time, tapping her foot against the tile floor. "
                     "The suitcase beside her had a tag looped through the handle, and she kept glancing "
                     "toward the long hallway where a line of people were showing little blue booklets to "
                     "an officer at a desk."),
        ("Infer", "Where is Maria most likely waiting? What clues in the passage led you to that inference? "
                   "_______________________"),
        ("Infer more", "How is Maria probably feeling? What word or action shows this? _______________________"),
    ]
    return _text_page("Inference Practice: Reading Between the Lines", "Use clues from the text — not just what's stated outright — to make inferences.",
                       blocks, "Reading Comprehension · Grade 6")


def _summarizing_nonfiction_6():
    blocks = [
        ("Passage", "Octopuses have three hearts and blue blood. Two hearts pump blood to the gills, while "
                     "the third pumps it to the rest of the body — and that third heart actually stops beating "
                     "when the octopus swims, which is why they prefer crawling to save energy. Their blood is "
                     "blue because it uses a copper-based molecule called hemocyanin to carry oxygen, instead "
                     "of the iron-based hemoglobin that makes human blood red."),
        ("Summarize", "Write a 1–2 sentence summary that captures only the MOST important information: "
                       "_______________________"),
        ("Check yourself", "Did your summary avoid copying full sentences from the passage? Did you leave out "
                            "minor details? Revise if needed."),
    ]
    return _text_page("Summarizing Nonfiction", "Read the passage, then write a short, accurate summary.",
                       blocks, "Reading Comprehension · Grade 6")


def _shapes_and_counting_k():
    probs = [
        "How many sides does a triangle have? ___", "How many sides does a square have? ___",
        "Count the corners of a rectangle: ___", "Draw 3 circles, then write the number: ___",
        "Draw 5 triangles, then write the number: ___", "How many sides does a circle have? ___",
        "Count: 🔺🔺🔺🔺 = ___", "Count: ⬛⬛⬛⬛⬛⬛ = ___",
    ]
    answers = ["3", "4", "4", "3", "5", "0", "4", "6"]
    return _build("Shapes & Counting", "Answer each shape question, counting carefully.", probs,
                  "Shapes & Counting · Kindergarten", cols=1, col_w=6.5, answers=answers)


def _more_or_less_10():
    probs, answers = [], []
    for _ in range(12):
        n = random.randint(0, 10)
        while n == 5:
            n = random.randint(0, 10)
        probs.append(f"{n}   is this MORE or LESS than 5? ___")
        answers.append("MORE" if n > 5 else "LESS")
    return _build("More or Less Than 10", "Circle MORE or LESS to compare each number to 5.", probs,
                  "Number Sense · Kindergarten", answers=answers)


def _count_and_match_5():
    blocks = [
        ("Group A", "🍎🍎🍎  ->  How many apples? ___"),
        ("Group B", "🐶🐶  ->  How many dogs? ___"),
        ("Group C", "⭐⭐⭐⭐⭐  ->  How many stars? ___"),
        ("Group D", "🚗  ->  How many cars? ___"),
        ("Group E", "🎈🎈🎈🎈  ->  How many balloons? ___"),
        ("Draw", "Draw a group of 4 of your favorite thing."),
    ]
    answers = ["A. 3", "B. 2", "C. 5", "D. 1", "E. 4"]
    return _text_page("Count and Match 1–5", "Count each group, then write the number.", blocks, "Counting · TK",
                       answers=answers)


def _big_and_small_sorting():
    blocks = [
        ("Sort them out", "Look around your room and find 3 BIG things and 3 SMALL things."),
        ("Big things", "1. _______________  2. _______________  3. _______________"),
        ("Small things", "1. _______________  2. _______________  3. _______________"),
        ("Compare", "Which is bigger: an elephant or a mouse? _______________"),
        ("Compare", "Which is smaller: a ball or a house? _______________"),
        ("Draw", "Draw one big thing and one small thing side by side."),
    ]
    answers = ["Bigger — an elephant", "Smaller — a ball"]
    return _text_page("Big and Small Sorting", "Find, sort, and compare big and small things.", blocks,
                       "Comparing Sizes · TK", answers=answers)


def _skip_counting_2_5_10():
    probs = [
        "2, 4, 6, ___, ___, ___", "5, 10, 15, ___, ___, ___", "10, 20, 30, ___, ___, ___",
        "2, 4, ___, 8, ___, 12", "5, ___, 15, ___, 25, 30", "10, ___, 30, ___, 50, 60",
    ]
    answers = ["8, 10, 12", "20, 25, 30", "40, 50, 60", "6, 10", "10, 20", "20, 40"]
    return _build("Skip Counting by 2s, 5s, 10s", "Fill in the missing numbers in each skip-counting pattern.", probs,
                  "Skip Counting · Grade 2", cols=1, col_w=6.5, answers=answers)


def _telling_time_half_hour():
    blocks = [
        ("How it works", "When the minute hand points to the 6, that means '30 minutes' or 'half past' the hour."),
        ("Practice 1", "The hour hand is between 3 and 4, the minute hand is on the 6. What time is it? ___:___"),
        ("Practice 2", "The hour hand is on 9, the minute hand is on 12. What time is it? ___:___"),
        ("Practice 3", "The hour hand is between 7 and 8, the minute hand is on the 6. What time is it? ___:___"),
        ("Draw it", "Draw clock hands on a circle to show 2:30."),
    ]
    answers = ["Practice 1 — 3:30", "Practice 2 — 9:00", "Practice 3 — 7:30"]
    return _text_page("Telling Time to the Half Hour", "Read each clock description and write the time.",
                       blocks, "Telling Time · Grade 2", answers=answers)


def _draw_butterfly():
    return _draw_your_own("Draw the Butterfly",
        ["A butterfly tastes with its feet, not its tongue.",
         "Butterflies start life as caterpillars before transforming inside a chrysalis.",
         "Add colorful, symmetrical patterns to both wings — try making one side match the other!"],
        "Draw & Color · Kindergarten")


# ── Family figures ─────────────────────────────────────────────────────────
# Open outlines, no fill, drawn in a local 100x150 box so they can be placed
# and scaled anywhere. Stroke weight is deliberately heavy: a crayon held by a
# five-year-old is blunt, and thin guide lines disappear under it.

def _arc(cx, cy, rx, ry, a0, a1, steps=18):
    """Flat [x1,y1,x2,y2,...] along an ellipse arc, for PolyLine."""
    import math
    pts = []
    for i in range(steps + 1):
        t = math.radians(a0 + (a1 - a0) * i / float(steps))
        pts += [cx + rx * math.cos(t), cy + ry * math.sin(t)]
    return pts


def _figure(kind, ink, lw=2.4):
    """One family member as a reportlab Group in a 100x150 local box."""
    from reportlab.graphics.shapes import Group, Circle, Ellipse, Rect, Line, PolyLine, Polygon

    g = Group()
    O = dict(strokeColor=ink, strokeWidth=lw, fillColor=None)
    SOLID = dict(strokeColor=ink, strokeWidth=0, fillColor=ink)

    adult = kind in ("mommy", "daddy", "grandma", "grandpa")
    baby = kind == "baby"

    # scale: babies short, children mid, adults tall
    hy = 118 if adult else (108 if not baby else 96)      # head centre y
    hr = 20 if adult else (19 if not baby else 18)        # head radius
    body_top = hy - hr - 2
    body_h = 52 if adult else (42 if not baby else 30)
    body_w = 40 if adult else (34 if not baby else 32)

    # ── head ──
    g.add(Circle(50, hy, hr, **O))

    # ── hair, the thing that actually tells them apart ──
    if kind == "mommy":
        # One continuous arc from below the right ear, over the top, to below
        # the left. Two straight side strands read as headphones.
        g.add(PolyLine(_arc(50, hy, hr + 4, hr + 4, -35, 215, 28), **O))
    elif kind == "daddy":
        g.add(PolyLine(_arc(50, hy + 2, hr + 2, hr + 3, 15, 165), **O))
    elif kind == "grandma":
        g.add(PolyLine(_arc(50, hy, hr + 3, hr + 3, -10, 190, 24), **O))
        g.add(Circle(50, hy + hr + 9, 7, **O))                 # bun
    elif kind == "grandpa":
        g.add(PolyLine(_arc(50 - hr + 4, hy + 6, 7, 6, 30, 170), **O))
        g.add(PolyLine(_arc(50 + hr - 4, hy + 6, 7, 6, 10, 150), **O))
    elif kind == "sister":
        g.add(PolyLine(_arc(50, hy, hr + 3, hr + 3, -15, 195, 24), **O))
        # Bunches sit at temple height. At eye level they read as ear cups.
        g.add(Circle(50 - hr - 4, hy + hr * 0.62, 6.5, **O))
        g.add(Circle(50 + hr + 4, hy + hr * 0.62, 6.5, **O))
    elif kind == "brother":
        g.add(Polygon([50 - 14, hy + hr - 3, 50 - 7, hy + hr + 7,
                       50, hy + hr - 2, 50 + 7, hy + hr + 8,
                       50 + 14, hy + hr - 4], **O))            # spikes
    elif baby:
        g.add(PolyLine(_arc(50, hy + hr - 1, 5, 7, -20, 200), **O))   # one curl

    # ── face: eyes and a smile, left open to color ──
    g.add(Circle(50 - 7, hy + 3, 2.1, **SOLID))
    g.add(Circle(50 + 7, hy + 3, 2.1, **SOLID))
    g.add(PolyLine(_arc(50, hy + 2, 8, 7, 200, 340), **O))

    if kind in ("grandma", "grandpa"):
        # Wider apart and smaller than the first attempt, where two r=6 rings
        # around the eyes met in the middle and read as an owl.
        g.add(Circle(50 - 8, hy + 3, 5, **O))
        g.add(Circle(50 + 8, hy + 3, 5, **O))
        g.add(Line(50 - 3, hy + 3, 50 + 3, hy + 3, **O))

    # ── body ──
    if kind in ("mommy", "sister", "grandma"):                  # dress
        g.add(Polygon([50 - body_w * 0.32, body_top,
                       50 + body_w * 0.32, body_top,
                       50 + body_w * 0.60, body_top - body_h,
                       50 - body_w * 0.60, body_top - body_h], **O))
    elif baby:                                                  # romper
        g.add(Rect(50 - body_w / 2.0, body_top - body_h, body_w, body_h,
                   rx=12, ry=12, **O))
    else:
        g.add(Rect(50 - body_w / 2.0, body_top - body_h, body_w, body_h,
                   rx=7, ry=7, **O))

    # ── arms ──
    ay = body_top - body_h * 0.28
    g.add(PolyLine([50 - body_w / 2.0, ay, 50 - body_w / 2.0 - 13, ay - 11], **O))
    g.add(PolyLine([50 + body_w / 2.0, ay, 50 + body_w / 2.0 + 13, ay - 11], **O))

    # ── legs ──
    ly = body_top - body_h
    leg = 26 if adult else (20 if not baby else 12)
    g.add(PolyLine([50 - 9, ly, 50 - 9, ly - leg], **O))
    g.add(PolyLine([50 + 9, ly, 50 + 9, ly - leg], **O))
    g.add(PolyLine([50 - 9, ly - leg, 50 - 16, ly - leg], **O))   # feet
    g.add(PolyLine([50 + 9, ly - leg, 50 + 16, ly - leg], **O))

    return g


#: Local-box y of the very top of each figure (hair included). The box is 150
#: tall but nobody fills it: a baby tops out at 122, a grandmother's bun at 154.
#: Connectors need this, or they end inside a child's head.
_FIG_TOP = {"mommy": 146, "daddy": 144, "grandma": 154, "grandpa": 146,
            "sister": 140, "brother": 137, "baby": 122}


def _fig_top(kind, y, scale):
    """Absolute y of the top of this figure's head."""
    return y + _FIG_TOP.get(kind, 146) * scale


def _label_bottom(y, age_line=False):
    """Absolute y below the whole name / age / label stack."""
    return y - (35 if age_line else 22)


def _member(d, kind, label, x, y, scale, ink, name_line=True, age_line=False):
    """Place one figure at (x, y) with a writing line and its label."""
    from reportlab.graphics.shapes import Group, Line, String

    g = _figure(kind, ink, lw=2.6 if scale >= 0.9 else 2.2)
    g.transform = (scale, 0, 0, scale, x, y)
    d.add(g)

    w = 100 * scale
    cx = x + w / 2.0
    ty = y - 6
    if name_line:
        d.add(Line(cx - w * 0.52, ty, cx + w * 0.52, ty,
                   strokeColor=ink, strokeWidth=1.1, strokeDashArray=[3, 3]))
        ty -= 13
    if age_line:
        d.add(Line(cx - w * 0.36, ty, cx + w * 0.36, ty,
                   strokeColor=ink, strokeWidth=1.1, strokeDashArray=[3, 3]))
        ty -= 13
    d.add(String(cx, ty, label, fontName="Kalam", fontSize=10,
                 fillColor=ink, textAnchor="middle"))


def _draw_your_family(grade=None):
    """A family tree to trace, color and label - banded by age.

    Was a blank dashed box with an ellipse in it. A child asked to draw their
    family needs somewhere to start, and an outline they can color is the
    thing a 5-year-old can finish; the tree structure is what makes it a
    lesson rather than free drawing.
    """
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.graphics.shapes import Drawing, Line, String
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors

    g = 1 if grade is None else int(grade)
    INK = colors.HexColor("#4c46b8")

    if g <= 1:
        sub = "Trace each person, color them in, and write their name."
    elif g <= 3:
        sub = "Color your family tree, then write everyone's name."
    else:
        sub = "Complete your family tree: color it, then add each name and age."

    buf, doc, story, styles = _doc("My Family Tree", sub)

    W = 6.9 * inch

    # ── TK and K: three big figures in a row ──────────────────────────────
    if g <= 1:
        d = Drawing(W, 2.5 * inch)
        sc = 1.15
        slots = [("mommy", "Grown-up"), ("brother", "Me"), ("baby", "Baby")]
        gap = W / 3.0
        for i, (kind, label) in enumerate(slots):
            _member(d, kind, label, gap * i + (gap - 100 * sc) / 2.0,
                    0.42 * inch, sc, INK)
        story.append(d)

    # ── 1st-2nd: parents joined, children below ───────────────────────────
    elif g <= 3:
        H = 4.6 * inch
        d = Drawing(W, H)
        ps, ks = 0.78, 0.68
        kid_y, bar_y, par_y = 26, 150, 205

        for i, (kind, label) in enumerate([("mommy", "Mommy"), ("daddy", "Daddy")]):
            cx = W * (0.30 + 0.40 * i)
            _member(d, kind, label, cx - 100 * ps / 2.0, par_y, ps, INK)
            d.add(Line(cx, _label_bottom(par_y) - 5, cx, bar_y,
                       strokeColor=INK, strokeWidth=1.6))

        d.add(Line(W * 0.30, bar_y, W * 0.70, bar_y, strokeColor=INK, strokeWidth=1.6))

        for i, (kind, label) in enumerate([("sister", "Sister"), ("brother", "Brother"),
                                           ("baby", "Baby")]):
            cx = W * (0.18 + 0.32 * i)
            _member(d, kind, label, cx - 100 * ks / 2.0, kid_y, ks, INK)
            d.add(Line(cx, bar_y, cx, _fig_top(kind, kid_y, ks) + 5,
                       strokeColor=INK, strokeWidth=1.6))
        story.append(d)

    # ── 3rd and up: three generations, name and age ───────────────────────
    else:
        H = 6.3 * inch
        d = Drawing(W, H)
        sc = 0.60
        gp_y, gp_bar, par_y, sib_bar, kid_y = 348, 296, 200, 150, 42
        gx = [W * (0.12 + 0.253 * i) for i in range(4)]

        for i, (kind, label) in enumerate([("grandma", "Grandma"), ("grandpa", "Grandpa"),
                                           ("grandma", "Grandma"), ("grandpa", "Grandpa")]):
            _member(d, kind, label, gx[i] - 100 * sc / 2.0, gp_y, sc, INK, age_line=True)
            d.add(Line(gx[i], _label_bottom(gp_y, True) - 5, gx[i], gp_bar,
                       strokeColor=INK, strokeWidth=1.5))
        for pair in (0, 2):
            d.add(Line(gx[pair], gp_bar, gx[pair + 1], gp_bar,
                       strokeColor=INK, strokeWidth=1.5))

        px = [W * 0.315, W * 0.685]
        for i, (kind, label) in enumerate([("mommy", "Mommy"), ("daddy", "Daddy")]):
            _member(d, kind, label, px[i] - 100 * sc / 2.0, par_y, sc, INK, age_line=True)
            # down from the grandparents' bar to the top of this parent's head
            mid_x = (gx[2 * i] + gx[2 * i + 1]) / 2.0
            d.add(Line(mid_x, gp_bar, mid_x, gp_bar - 14, strokeColor=INK, strokeWidth=1.5))
            d.add(Line(mid_x, gp_bar - 14, px[i], gp_bar - 14, strokeColor=INK, strokeWidth=1.5))
            d.add(Line(px[i], gp_bar - 14, px[i], _fig_top(kind, par_y, sc) + 5,
                       strokeColor=INK, strokeWidth=1.5))
            d.add(Line(px[i], _label_bottom(par_y, True) - 5, px[i], sib_bar,
                       strokeColor=INK, strokeWidth=1.5))

        d.add(Line(px[0], sib_bar, px[1], sib_bar, strokeColor=INK, strokeWidth=1.5))

        for i, (kind, label) in enumerate([("sister", "Sister"), ("brother", "Me"),
                                           ("baby", "Baby")]):
            cx = W * (0.20 + 0.30 * i)
            _member(d, kind, label, cx - 100 * sc / 2.0, kid_y, sc, INK, age_line=True)
            d.add(Line(cx, sib_bar, cx, _fig_top(kind, kid_y, sc) + 5,
                       strokeColor=INK, strokeWidth=1.5))
        story.append(d)

    story.append(Spacer(1, 10))
    tips = {
        0: ["Color each person the way they really look.",
            "Write their name on the line.",
            "Families come in every shape and size - draw yours."],
        2: ["Color everyone in, then write each name on the dotted line.",
            "Not everyone has the same family - cross out anyone you do not have, and add anyone missing.",
            "Draw your pets in too!"],
        4: ["Write each person's name on the first line and their age on the second.",
            "Add anyone who is missing, and cross out any box you do not need.",
            "Ask a grown-up about the oldest person on your tree - where were they born?"],
    }
    key = 0 if g <= 1 else (2 if g <= 3 else 4)
    story.append(Paragraph("Things to try:", ParagraphStyle(
        "h", parent=styles["Heading3"], fontSize=13, spaceAfter=6)))
    for t in tips[key]:
        story.append(Paragraph("\u2022  " + t, ParagraphStyle(
            "f", parent=styles["Normal"], fontSize=11.5, leading=17, spaceAfter=3)))

    band = {0: "TK - Kindergarten", 2: "Grade 1-2", 4: "Grade 3 and up"}[key]
    _footer(story, styles, "Draw & Color \u00b7 " + band)
    doc.build(story)
    return buf.getvalue()


def _draw_rainbow():
    return _draw_your_own("Draw the Rainbow",
        ["A rainbow forms when sunlight passes through raindrops and bends into different colors.",
         "Rainbows always have the same color order: red, orange, yellow, green, blue, indigo, violet.",
         "Try coloring all 7 stripes in the correct order!"],
        "Draw & Color · Grade 1")


def _draw_spaceship():
    return _draw_your_own("Draw a Spaceship Adventure",
        ["The International Space Station orbits Earth about every 90 minutes.",
         "Astronauts float in space because they're in constant free-fall around Earth.",
         "Add stars, planets, and maybe a friendly alien to your scene!"],
        "Draw & Color · Grade 1")


def _silly_mad_libs():
    blocks = [
        ("How it works", "Fill in each blank with the type of word asked for — WITHOUT reading the story first!"),
        ("Word bank", "1. Adjective: _______  2. Animal: _______  3. Silly sound: _______  "
                       "4. Number: _______  5. Adjective: _______  6. Place: _______"),
        ("The story", "My (1)_______ pet (2)_______ went '(3)_______!' and jumped (4)_______ feet in the air "
                       "before landing in a (5)_______ puddle right outside the (6)_______."),
        ("Read it aloud", "Now read your finished silly story out loud to someone!"),
    ]
    return _text_page("Silly Sentence Mad-Libs", "Fill in the blanks first, then read your silly story.",
                       blocks, "Creative Writing · Grade 1")


def _my_weekend_story():
    blocks = [
        ("Saturday", "Write 2 sentences about something you did on Saturday: _______________________"),
        ("Sunday", "Write 2 sentences about something you did on Sunday: _______________________"),
        ("Best part", "What was the BEST part of your weekend, and why? _______________________"),
        ("Draw it", "Draw a picture of your favorite weekend moment."),
    ]
    return _text_page("My Weekend Story", "Write about your weekend, then draw your favorite part.",
                       blocks, "Creative Writing · Grade 1")


def _practice_pack_2(week: int):
    blocks = [
        ("Math warm-up", "Solve: 14+8=___  20-7=___  6x3=___  15+15=___"),
        ("Reading warm-up", "Read for 10 minutes, then write the title and one thing you learned."),
        ("Writing", "Write 3 sentences about something that made you laugh this week."),
        ("Spelling", "Write these words 3 times each: friend, because, again, could"),
        ("Reflection", "What is one thing you got better at this week? _______________________"),
    ]
    answers = ["Math warm-up — 14+8=22, 20-7=13, 6x3=18, 15+15=30"]
    return _text_page(f"2nd Grade Practice Pack: Week {week}", "A short weekly mix of math, reading, writing, and spelling.",
                       blocks, "Practice Pack · Grade 2", answers=answers)


def _practice_pack_2_week1():
    return _practice_pack_2(1)


def _practice_pack_2_week2():
    return _practice_pack_2(2)


def _odd_one_out_4():
    blocks = [
        ("Group 1", "apple, banana, carrot, orange  ->  which doesn't belong, and why? _______________________"),
        ("Group 2", "triangle, square, circle, red  ->  which doesn't belong, and why? _______________________"),
        ("Group 3", "swim, run, jump, happy  ->  which doesn't belong, and why? _______________________"),
        ("Group 4", "dog, cat, fish, chair  ->  which doesn't belong, and why? _______________________"),
        ("Group 5", "January, Monday, March, July  ->  which doesn't belong, and why? _______________________"),
        ("Your turn", "Make up your own group of 4 with one odd one out, for a friend to solve."),
    ]
    answers = ["Group 1 — carrot (the others are fruits)", "Group 2 — red (the others are shapes)",
               "Group 3 — happy (the others are actions)", "Group 4 — chair (the others are animals)",
               "Group 5 — Monday (the others are months)"]
    return _text_page("Odd One Out: Categorization", "Find the item that doesn't belong in each group, and explain your reasoning.",
                       blocks, "Logic Puzzle · Grade 4", answers=answers)


def _code_breaker_cipher():
    blocks = [
        ("The cipher", "A = 1, B = 2, C = 3 ... Z = 26. Each letter is just its position in the alphabet."),
        ("Decode this", "8-9  ->  ___  (2 letters)"),
        ("Decode this", "3-15-4-5  ->  ___  (4 letters)"),
        ("Decode this", "12-15-7-9-3  ->  ___  (5 letters)"),
        ("Now encode", "Write your own name in number code: _______________________"),
        ("Challenge", "Swap your coded name with a friend and see if they can decode it!"),
    ]
    answers = ["8-9 = HI", "3-15-4-5 = CODE", "12-15-7-9-3 = LOGIC"]
    return _text_page("Code Breaker: Simple Cipher", "Use A=1, B=2, C=3... to decode and encode secret messages.",
                       blocks, "Logic Puzzle · Grade 4", answers=answers)


def _good_manners_checklist_tk():
    items = [
        "Say 'please' when I ask for something",
        "Say 'thank you' when I get something",
        "Wait for my turn without pushing",
        "Use a kind, quiet voice indoors",
        "Say 'excuse me' if I need to get by",
    ]
    return _checklist("Good Manners Checklist", "Check off each good manner as you practice it today.",
                       items, "Manners · TK")


def _sharing_taking_turns():
    blocks = [
        ("Why it matters", "Sharing and taking turns helps everyone feel included and have fun together."),
        ("Practice", "Name one toy or game you can share with a friend or sibling today: _______________________"),
        ("Practice", "How do you know when it's someone else's turn? _______________________"),
        ("Role-play", "Ask a grown-up to practice this with you: one of you asks to share, the other says yes kindly."),
    ]
    return _text_page("Sharing & Taking Turns", "Learn and practice how to share and take turns kindly.",
                       blocks, "Manners · Kindergarten")


def _saying_sorry_right_way():
    blocks = [
        ("A real apology has 3 parts", "1) Say what you did wrong.  2) Say you're sorry.  3) Ask how to make it better."),
        ("Not a real apology", "\"Sorry you're upset\" — this doesn't take responsibility for what happened."),
        ("Practice", "Write an apology for accidentally knocking over a friend's block tower, using all 3 parts: "
                      "_______________________"),
        ("Reflect", "Think of a time someone apologized to you. How did it make you feel? _______________________"),
    ]
    return _text_page("Saying Sorry the Right Way", "Learn the 3 parts of a real apology, then practice writing one.",
                       blocks, "Manners · Grade 1")


# ── Coverage batch 3 ─────────────────────────────────────────────────────────

def _feelings_vocabulary_builder():
    pairs = [
        ("frustrated", "annoyed because something is hard or not going your way"),
        ("disappointed", "sad because something didn't turn out how you hoped"),
        ("proud", "happy about something good you did"),
        ("anxious", "worried about what might happen next"),
        ("content", "calm and satisfied with how things are"),
        ("embarrassed", "uncomfortable because others noticed a mistake you made"),
    ]
    return _word_match_table("Feelings Vocabulary Builder", "Match each feeling word to its meaning.",
                              pairs, "Feelings · Grade 4")


def _feelings_body_language_clues():
    blocks = [
        ("Clue 1", "Arms crossed, eyebrows down, stomping feet. What feeling is this? _______________"),
        ("Clue 2", "Shoulders slumped, eyes looking down, quiet voice. What feeling is this? _______________"),
        ("Clue 3", "Wide eyes, hands covering mouth, frozen still. What feeling is this? _______________"),
        ("Clue 4", "Big smile, bouncing on toes, clapping hands. What feeling is this? _______________"),
        ("Your turn", "Act out a feeling for a family member using only your body — can they guess it?"),
    ]
    answers = ["1. Angry/frustrated", "2. Sad", "3. Surprised or scared", "4. Excited/happy",
               "Your turn — answers will vary"]
    return _text_page("Feelings Detective: Body Language Clues", "Read each body-language clue, then guess the feeling.",
                       blocks, "Feelings · Grade 4", answers=answers)


def _feelings_thermometer():
    blocks = [
        ("How it works", "A feeling can be a little bit strong or VERY strong — just like a thermometer measures "
                          "a little warm or very hot."),
        ("Rate it", "Losing your favorite toy: a little upset, or VERY upset? Circle one."),
        ("Rate it", "Someone bumps into you by accident: a little annoyed, or VERY annoyed? Circle one."),
        ("Rate it", "It's your birthday: a little happy, or VERY happy? Circle one."),
        ("Reflect", "Write about a time you felt a feeling VERY strongly. What helped you feel calmer or better?"),
    ]
    return _text_page("My Feelings Thermometer", "Learn that feelings can be a little strong or very strong.",
                       blocks, "Feelings · Grade 2")


def _feelings_match_face_word():
    pairs = [
        ("happy", "big smile, feeling good"), ("sad", "feeling down, might want to cry"),
        ("angry", "feeling mad, face gets hot"), ("scared", "feeling afraid, heart beats fast"),
        ("surprised", "eyes wide open, didn't expect it"), ("silly", "giggly, wants to laugh"),
    ]
    return _word_match_table("Feelings Match-Up", "Match each feeling word to how it looks or feels.",
                              pairs, "Feelings · Grade 2")


def _logic_grid_library_mystery():
    blocks = [
        ("Clues",
         "1. Four friends — Ben, Zara, Omar, and Lily — each checked out exactly one book: mystery, sci-fi, "
         "comic, or biography.<br/>"
         "2. Ben's book is a true story, not a made-up one.<br/>"
         "3. Zara's book has robots in it.<br/>"
         "4. Omar's book made him laugh out loud.<br/>"
         "5. Lily's book has a detective solving a case."),
        ("Your grid — mark YES or NO in each box",
         "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mystery&nbsp;&nbsp;Sci-Fi&nbsp;&nbsp;Comic&nbsp;&nbsp;Bio<br/>"
         "Ben&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___<br/>"
         "Zara&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___<br/>"
         "Omar&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___<br/>"
         "Lily&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___"),
    ]
    answers = ["Ben -> Biography", "Zara -> Sci-Fi", "Omar -> Comic", "Lily -> Mystery"]
    return _text_page("Logic Grid: Library Mystery", "Use the clues to fill in the grid and solve which friend checked out which book.",
                       blocks, "Logic Puzzle · Grade 5", answers=answers)


def _number_sequence_detective_5():
    blocks = [
        ("Puzzle 1", "3, 6, 12, 24, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 2", "1, 4, 9, 16, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 3", "2, 6, 18, 54, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 4", "100, 50, 25, ___, ___  ->  What's the rule? _______________"),
        ("Puzzle 5", "1, 1, 2, 3, 5, 8, ___, ___  ->  What's the rule? (Hint: add the two numbers before it)"),
        ("Challenge", "Make up your own multiplying pattern of 4 numbers, then ask a family member to find the rule."),
    ]
    answers = [
        "1. 48, 96 — multiply by 2 each time", "2. 25, 36 — square numbers (1x1, 2x2, 3x3...)",
        "3. 162, 486 — multiply by 3 each time", "4. 12.5, 6.25 — divide by 2 each time",
        "5. 13, 21 — Fibonacci sequence: add the two numbers before it", "Challenge — answers will vary",
    ]
    return _text_page("Number Sequence Detective", "Find the rule, then continue each advanced pattern.",
                       blocks, "Logic Puzzle · Grade 5", answers=answers)


def _table_manners_checklist():
    items = [
        "Wait until everyone is served before eating",
        "Chew with my mouth closed",
        "Ask to be excused before leaving the table",
        "Say 'please pass the ___' instead of reaching",
        "Use my napkin instead of my sleeve",
    ]
    return _checklist("Table Manners Checklist", "Check off each table manner as you practice it at a meal.",
                       items, "Manners · Grade 1")


def _polite_words_match():
    pairs = [
        ("please", "asking for something politely"), ("thank you", "showing you're grateful"),
        ("excuse me", "asking to get by, or interrupting politely"),
        ("you're welcome", "replying kindly after someone says thank you"),
        ("may I", "politely asking for permission"), ("I'm sorry", "admitting a mistake and showing you care"),
    ]
    return _word_match_table("Polite Words Match-Up", "Match each polite phrase to what it means.",
                              pairs, "Manners · Grade 1")


def _tracing_polite_words():
    return _tracing_items("Tracing Polite Words", "Trace each polite word, then write it once on your own.",
                           ["PLEASE", "THANKS", "SORRY", "HI", "BYE"], "Manners · TK")


def _kind_or_unkind_circle():
    blocks = [
        ("Scene 1", "A friend falls down and you help them up.  Kind  or  Unkind?  Circle one."),
        ("Scene 2", "You grab a toy without asking.  Kind  or  Unkind?  Circle one."),
        ("Scene 3", "You share your snack with a friend.  Kind  or  Unkind?  Circle one."),
        ("Scene 4", "You laugh at someone who made a mistake.  Kind  or  Unkind?  Circle one."),
        ("Scene 5", "You say 'nice job!' to a classmate.  Kind  or  Unkind?  Circle one."),
    ]
    answers = ["1. Kind", "2. Unkind", "3. Kind", "4. Unkind", "5. Kind"]
    return _text_page("Kind or Unkind?", "Read each scene, then circle Kind or Unkind.",
                       blocks, "Manners · TK", answers=answers)


def _good_listener_checklist():
    items = [
        "Look at the person who is talking",
        "Keep my hands and feet still",
        "Wait for my turn to talk",
        "Think about what they are saying",
        "Ask a question if I don't understand",
    ]
    return _checklist("Good Listener Checklist", "Check off each good-listening habit as you practice it.",
                       items, "Manners · Kindergarten")


def _manners_at_the_table():
    blocks = [
        ("Before eating", "Wash your hands and wait for everyone to sit down."),
        ("While eating", "Chew with your mouth closed and use a quiet inside voice."),
        ("Asking for food", "Say 'please may I have ___' instead of grabbing."),
        ("When you're done", "Say 'thank you' and ask if you may leave the table."),
        ("Practice", "Draw your family eating a meal together, using good manners."),
    ]
    return _text_page("Manners at the Table", "Learn four good manners to use at mealtime.",
                       blocks, "Manners · Kindergarten")


def _outline_a_topic():
    blocks = [
        ("Why outline?", "An outline organizes your ideas BEFORE you write, so your report or essay makes sense."),
        ("Topic", "Write a topic you know about (an animal, a place, a hobby): _______________________"),
        ("Main idea 1", "_______________________  ->  detail: _______________________"),
        ("Main idea 2", "_______________________  ->  detail: _______________________"),
        ("Main idea 3", "_______________________  ->  detail: _______________________"),
        ("Conclusion", "In one sentence, how would you wrap up this topic? _______________________"),
    ]
    return _text_page("Outline a Topic", "Practice organizing your ideas into a simple outline before you write.",
                       blocks, "Study Skills · Grade 4")


def _multi_step_word_problems_4():
    probs, answers = [], []
    for _ in range(9):
        kind = random.choice(["buy", "save", "collect"])
        if kind == "buy":
            price = random.randint(2, 9)
            qty = random.randint(2, 6)
            extra = random.randint(1, 12)
            total = price * qty + extra
            probs.append(f"Notebooks cost ${price} each. Maria buys {qty} notebooks, then a pen for ${extra}. "
                         "How much does she spend in total?")
            answers.append(f"${total}")
        elif kind == "save":
            weekly = random.randint(4, 10)
            weeks = random.randint(3, 6)
            spent = random.randint(1, weekly * weeks - 5)
            total = weekly * weeks - spent
            probs.append(f"Sam saves ${weekly} each week for {weeks} weeks, then spends ${spent}. "
                         "How much money does Sam have left?")
            answers.append(f"${total}")
        else:
            per_group = random.randint(3, 9)
            groups = random.randint(3, 6)
            extra = random.randint(2, 10)
            grand_total = per_group * groups + extra
            probs.append(f"{groups} classrooms each collect {per_group} cans of food. The office adds {extra} "
                         "more cans. How many cans in all?")
            answers.append(str(grand_total))
    return _build("Multi-Step Word Problems", "Read carefully — each problem takes two steps to solve.", probs,
                  "Workbook Practice · Grade 4", cols=1, col_w=6.5, answers=answers)


def _flashcard_maker_study_skills():
    blocks = [
        ("Why flashcards work", "Writing a question on one side and the answer on the other helps your brain "
                                 "practice remembering."),
        ("Make one", "Pick a fact you're learning (a spelling word, a math fact, a vocabulary word): "
                      "_______________________"),
        ("Front of card", "Write the question or word: _______________________"),
        ("Back of card", "Write the answer or definition: _______________________"),
        ("Practice tip", "Quiz yourself with your flashcard 3 times today, then again tomorrow."),
    ]
    return _text_page("Flashcard Maker: Study Skills", "Learn how to make your own flashcards to study smarter.",
                       blocks, "Study Skills · Grade 3")


def _multiplication_fact_fluency_drill():
    pairs = [(random.randint(1, 10), random.randint(1, 10)) for _ in range(18)]
    probs = [f"{a} × {b} = ___" for a, b in pairs]
    answers = [str(a * b) for a, b in pairs]
    return _build("Multiplication Fact Fluency", "Practice your times tables until they feel automatic.", probs,
                  "Workbook Practice · Grade 3", answers=answers)


# ── Coverage batch 4 — Science & Writing zero-coverage grades ──────────────

def _five_senses_match():
    pairs = [
        ("see", "use your eyes"), ("hear", "use your ears"), ("smell", "use your nose"),
        ("taste", "use your tongue"), ("touch", "use your skin and hands"),
    ]
    return _word_match_table("My Five Senses", "Match each sense to the body part you use.",
                              pairs, "Science · TK")


def _living_or_nonliving_tk():
    blocks = [
        ("Living or Nonliving?", "A tree — it grows and needs water.  Living  or  Nonliving?  Circle one."),
        ("Living or Nonliving?", "A rock — it does not grow or need food.  Living  or  Nonliving?  Circle one."),
        ("Living or Nonliving?", "A dog — it breathes, eats, and grows.  Living  or  Nonliving?  Circle one."),
        ("Living or Nonliving?", "A car — it needs gas, but does not grow.  Living  or  Nonliving?  Circle one."),
        ("Living or Nonliving?", "A flower — it grows and needs sunlight.  Living  or  Nonliving?  Circle one."),
    ]
    answers = ["1. Living", "2. Nonliving", "3. Living", "4. Nonliving", "5. Living"]
    return _text_page("Living or Nonliving?", "Circle Living or Nonliving for each thing.",
                       blocks, "Science · TK", answers=answers)


def _four_seasons_match():
    pairs = [
        ("Winter", "cold, and sometimes snowy"), ("Spring", "flowers bloom and rain falls"),
        ("Summer", "hot, with long sunny days"), ("Fall", "leaves change color and fall"),
    ]
    return _word_match_table("The Four Seasons", "Match each season to how it looks and feels.",
                              pairs, "Science · Kindergarten")


def _what_plants_need_k():
    blocks = [
        ("What do plants need to grow?", "Plants need four things: sunlight, water, soil, and air."),
        ("Fill in the blank", "Plants need ___ to help make their own food (hint: it comes from the sky). "
                               "_______________________"),
        ("Fill in the blank", "Plants drink ___ through their roots. _______________________"),
        ("Fill in the blank", "Plants grow in ___, which holds their roots in place. _______________________"),
        ("Draw", "Draw a plant and label its roots, stem, leaves, and a flower."),
    ]
    answers = ["1. Sunlight", "2. Water", "3. Soil"]
    return _text_page("What Plants Need", "Learn the four things every plant needs to grow.",
                       blocks, "Science · Kindergarten", answers=answers)


def _solids_liquids_true_false_1():
    blocks = [
        ("True or False?", "A solid keeps its own shape.  True  or  False?"),
        ("True or False?", "A liquid takes the shape of its container.  True  or  False?"),
        ("True or False?", "Water is always a solid.  True  or  False?"),
        ("True or False?", "Ice is water in solid form.  True  or  False?"),
        ("True or False?", "You can pour a solid the same way you pour a liquid.  True  or  False?"),
    ]
    answers = ["1. True", "2. True", "3. False", "4. True", "5. False"]
    return _text_page("Solids & Liquids: True or False", "Circle True or False for each statement about solids and liquids.",
                       blocks, "Science · Grade 1", answers=answers)


def _day_and_night_match_1():
    pairs = [
        ("Day", "the sun is up and the sky is bright"), ("Night", "the moon and stars are out and the sky is dark"),
        ("Sunrise", "the sun comes up in the morning"), ("Sunset", "the sun goes down in the evening"),
    ]
    return _word_match_table("Day and Night", "Match each word to what happens at that time.",
                              pairs, "Science · Grade 1")


def _butterfly_life_cycle():
    blocks = [
        ("Step 1: Egg", "A butterfly's life starts as a tiny egg laid on a leaf."),
        ("Step 2: ___", "Fill in the missing step: a caterpillar hatches and eats leaves to grow. "
                         "_______________________"),
        ("Step 3: Chrysalis", "The caterpillar forms a hard shell around itself called a chrysalis."),
        ("Step 4: ___", "Fill in the missing step: an adult comes out of the chrysalis and flies away! "
                         "_______________________"),
        ("Order them", "Number these in order from 1 to 4: ___ Chrysalis   ___ Egg   ___ Butterfly   "
                        "___ Caterpillar"),
    ]
    answers = ["Step 2 — Caterpillar (larva)", "Step 4 — Butterfly (adult)",
               "Order — Egg=1, Caterpillar=2, Chrysalis=3, Butterfly=4"]
    return _text_page("Butterfly Life Cycle", "Learn and order the four stages of a butterfly's life.",
                       blocks, "Science · Grade 3", answers=answers)


def _simple_machines_match_3():
    pairs = [
        ("Lever", "a seesaw that lifts things with a bar and a pivot point"),
        ("Wheel and Axle", "a doorknob that turns to open a door"),
        ("Inclined Plane", "a ramp that helps move things up or down"),
        ("Pulley", "a rope and wheel that raises a flag up a pole"),
        ("Screw", "a spiral ramp that holds a jar lid on tight"),
        ("Wedge", "a sharp tool, like an axe, that splits things apart"),
    ]
    return _word_match_table("Simple Machines Match-Up", "Match each simple machine to a real-life example.",
                              pairs, "Science · Grade 3")


def _forms_of_energy_match():
    pairs = [
        ("Light energy", "comes from the sun or a lamp"), ("Heat energy", "comes from a stove or a campfire"),
        ("Sound energy", "comes from a speaker or a drum"), ("Motion energy", "comes from a rolling ball or a moving car"),
        ("Electrical energy", "comes from a battery or a wall outlet"),
    ]
    return _word_match_table("Forms of Energy", "Match each type of energy to a real example.",
                              pairs, "Science · Grade 4")


def _forest_food_chain():
    blocks = [
        ("What is a food chain?", "It shows who eats whom, starting with a plant and ending with a top predator."),
        ("Producer", "A plant that makes its own food using sunlight. Example: grass."),
        ("Herbivore", "An animal that eats only plants. Give an example: _______________________"),
        ("Carnivore", "An animal that eats other animals. Give an example: _______________________"),
        ("Build a chain", "Put these four in order from producer to top predator: hawk, grass, snake, mouse. "
                           "_______________________"),
    ]
    answers = ["Herbivore examples: rabbit, deer, grasshopper (answers will vary)",
               "Carnivore examples: fox, hawk, snake (answers will vary)",
               "Chain — grass, then mouse, then snake, then hawk"]
    return _text_page("Forest Food Chain", "Learn how energy passes from plants to animals in a food chain.",
                       blocks, "Science · Grade 4", answers=answers)


def _cell_parts_match_6():
    pairs = [
        ("Nucleus", "controls the cell, like its brain"),
        ("Cell membrane", "protects the cell and controls what goes in and out"),
        ("Mitochondria", "makes energy for the cell"),
        ("Cytoplasm", "the jelly-like fluid that fills the cell"),
        ("Cell wall", "a rigid outer layer found in plant cells, not animal cells"),
    ]
    return _word_match_table("Cell Parts & Functions", "Match each cell part to its job.",
                              pairs, "Science · Grade 6")


def _physical_vs_chemical_change_6():
    blocks = [
        ("The difference", "A physical change alters how something LOOKS (its shape, size, or state) without "
                            "changing what it's made of. A chemical change creates a brand-new substance."),
        ("Sort it", "Melting ice into water.  Physical  or  Chemical?"),
        ("Sort it", "Burning a piece of wood.  Physical  or  Chemical?"),
        ("Sort it", "Cutting a sheet of paper.  Physical  or  Chemical?"),
        ("Sort it", "Rusting of an iron nail.  Physical  or  Chemical?"),
        ("Sort it", "Baking a cake in the oven.  Physical  or  Chemical?"),
    ]
    answers = ["1. Physical", "2. Chemical", "3. Physical", "4. Chemical", "5. Chemical"]
    return _text_page("Physical vs. Chemical Change", "Sort each example as a physical change or a chemical change.",
                       blocks, "Science · Grade 6", answers=answers)


def _label_the_picture_tk():
    blocks = [
        ("Draw & Label 1", "Draw a sun. Underneath it, write the word SUN."),
        ("Draw & Label 2", "Draw a cat. Underneath it, write the word CAT."),
        ("Draw & Label 3", "Draw a tree. Underneath it, write the word TREE."),
        ("Draw & Label 4", "Draw a house. Underneath it, write the word HOUSE."),
    ]
    return _text_page("Label the Picture", "Draw a picture, then write the word underneath it.",
                       blocks, "Writing · TK")


def _trace_first_sight_words():
    return _tracing_items("Trace My First Words", "Trace each word, then write it once on your own.",
                           ["I", "SEE", "GO", "UP", "ME"], "Writing · TK")


def _writing_simple_sentences_k():
    blocks = [
        ("Finish the sentence", "I like to ___________________."),
        ("Finish the sentence", "My favorite animal is a ___________________."),
        ("Finish the sentence", "Today I feel ___________________."),
        ("Finish the sentence", "I can ___________________."),
        ("Remember", "Every sentence starts with a CAPITAL letter and ends with a period ( . )"),
    ]
    return _text_page("Finish My Sentence", "Complete each sentence, then check your capital letter and period.",
                       blocks, "Writing · Kindergarten")


def _capital_letter_period_check():
    blocks = [
        ("Fix it", "the dog ran fast  ->  rewrite it correctly: _______________________"),
        ("Fix it", "i like pizza  ->  rewrite it correctly: _______________________"),
        ("Fix it", "she is my friend  ->  rewrite it correctly: _______________________"),
        ("Remember", "Every sentence starts with a CAPITAL letter and ends with a period ( . )"),
    ]
    answers = ["1. The dog ran fast.", "2. I like pizza.", "3. She is my friend."]
    return _text_page("Capital Letters & Periods", "Rewrite each sentence with a capital letter and a period.",
                       blocks, "Writing · Kindergarten", answers=answers)


def _sentence_types_practice():
    blocks = [
        ("Statement or Question?", "the sun is hot  ->  add the right end mark: _______________________"),
        ("Statement or Question?", "what is your name  ->  add the right end mark: _______________________"),
        ("Statement or Question?", "i have a red bike  ->  add the right end mark: _______________________"),
        ("Statement or Question?", "do you like ice cream  ->  add the right end mark: _______________________"),
        ("Your turn", "Write one statement and one question of your own."),
    ]
    answers = ["1. The sun is hot.", "2. What is your name?", "3. I have a red bike.", "4. Do you like ice cream?"]
    return _text_page("Statements & Questions", "Decide if each sentence is a statement or a question, then add the right end mark.",
                       blocks, "Writing · Grade 1", answers=answers)


def _descriptive_words_practice():
    blocks = [
        ("Add a describing word", "The ___ dog ran across the yard. (Example: big, fluffy, fast)"),
        ("Add a describing word", "I ate a ___ apple for lunch. (Example: red, juicy, crunchy)"),
        ("Add a describing word", "We saw a ___ bird in the tree. (Example: tiny, colorful, loud)"),
        ("Add a describing word", "She wore a ___ hat to the party. (Example: sparkly, striped, silly)"),
        ("Challenge", "Write your own sentence with two describing words in it."),
    ]
    return _text_page("Descriptive Words", "Add a describing word (adjective) to make each sentence more interesting.",
                       blocks, "Writing · Grade 1")


def _story_elements_planner():
    blocks = [
        ("Character", "Who is your story about? _______________________"),
        ("Setting", "Where does your story happen? _______________________"),
        ("Beginning", "What happens first? _______________________"),
        ("Middle", "What is the problem or exciting part? _______________________"),
        ("End", "How does your story end? _______________________"),
    ]
    return _text_page("Story Elements Planner", "Plan your story by filling in each part.",
                       blocks, "Writing · Grade 2")


def _using_adjectives_2():
    pairs = [
        ("fluffy", "how something feels, like a soft cloud"), ("gigantic", "how big something is"),
        ("ancient", "how old something is"), ("sparkly", "how something shines"),
        ("delicious", "how good food tastes"), ("exhausted", "how tired someone feels"),
    ]
    return _word_match_table("Powerful Adjectives", "Match each adjective to what it describes.",
                              pairs, "Writing · Grade 2")


def _paragraph_structure_intro():
    blocks = [
        ("Topic sentence", "Tells the reader what the paragraph is about. Write one: _______________________"),
        ("Detail 1", "Give a fact or example that supports your topic sentence: _______________________"),
        ("Detail 2", "Give another fact or example: _______________________"),
        ("Detail 3", "Give one more fact or example: _______________________"),
        ("Closing sentence", "Wrap up your paragraph with a final thought: _______________________"),
    ]
    return _text_page("Paragraph Structure Builder", "Build a paragraph with a topic sentence, three details, and a closing sentence.",
                       blocks, "Writing · Grade 4")


def _transition_words_match():
    pairs = [
        ("First", "shows the beginning of a list or sequence"), ("However", "shows a contrast or change in idea"),
        ("For example", "introduces an example"), ("In addition", "adds another idea"),
        ("Finally", "shows the last item or the ending"), ("Because", "explains a reason"),
    ]
    return _word_match_table("Transition Words", "Match each transition word to what it signals in writing.",
                              pairs, "Writing · Grade 4")


def _show_dont_tell_practice():
    blocks = [
        ("What it means", "'Telling' just states a feeling. 'Showing' uses details so the READER feels it too."),
        ("Telling", "She was sad."),
        ("Now show it", "Rewrite it to SHOW instead of tell: _______________________"),
        ("Telling", "He was nervous."),
        ("Now show it", "Rewrite it to SHOW instead of tell: _______________________"),
        ("Telling", "The dog was excited."),
        ("Now show it", "Rewrite it to SHOW instead of tell: _______________________"),
    ]
    return _text_page("Show, Don't Tell", "Practice turning a 'telling' sentence into a 'showing' sentence with vivid details.",
                       blocks, "Writing · Grade 5")


def _strong_verbs_swap():
    pairs = [
        ("walked", "strolled, marched, tiptoed"), ("said", "whispered, shouted, exclaimed"),
        ("went", "dashed, wandered, zoomed"), ("looked", "glanced, stared, peered"),
        ("ate", "devoured, nibbled, gobbled"), ("happy", "thrilled, delighted, ecstatic"),
    ]
    return _word_match_table("Strong Verb Swap", "Match each overused word to stronger, more specific choices.",
                              pairs, "Writing · Grade 5")


def _writing_process_steps():
    blocks = [
        ("1. Prewriting", "Brainstorm and plan your ideas before you write. What's your topic? "
                           "_______________________"),
        ("2. Drafting", "Write your first version — don't worry about mistakes yet."),
        ("3. Revising", "Reread your draft. What could you ADD, CUT, or REORDER to make it better?"),
        ("4. Editing", "Fix spelling, grammar, and punctuation mistakes."),
        ("5. Publishing", "Share your final, polished piece with a reader."),
    ]
    return _text_page("The Writing Process", "Learn the five steps every writer uses, from first idea to final draft.",
                       blocks, "Writing · Grade 6")


def _figurative_language_id():
    pairs = [
        ("Simile", "Her smile was like sunshine."), ("Metaphor", "The classroom was a zoo."),
        ("Personification", "The wind whispered through the trees."), ("Hyperbole", "I've told you a million times."),
        ("Alliteration", "Sally sells seashells."), ("Idiom", "It's raining cats and dogs."),
    ]
    return _word_match_table("Figurative Language Match-Up", "Match each figurative-language term to an example.",
                              pairs, "Writing · Grade 6")


# ── Coverage batch 5 — closing 2/5 combos to 5/5 ────────────────────────────

def _color_wheel_basics():
    from reportlab.graphics.shapes import Drawing, Wedge
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Color Wheel Basics", "Learn primary and secondary colors, then color the wheel.")

    blocks_text = [
        ("Primary colors", "Red, yellow, and blue — colors you CAN'T make by mixing other colors."),
        ("Secondary colors", "Orange, green, and purple — made by mixing two primary colors together."),
        ("Try it", "Red + Yellow = ___________   Yellow + Blue = ___________   Blue + Red = ___________"),
    ]
    for heading, body in blocks_text:
        story.append(Paragraph(heading, ParagraphStyle("h", parent=styles["Heading3"], fontSize=13,
                                                         textColor=colors.HexColor("#5b4fcf"), spaceBefore=8, spaceAfter=4)))
        story.append(Paragraph(body, ParagraphStyle("b", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=6)))

    d = Drawing(4*inch, 4*inch)
    cx, cy, r = 2*inch, 2*inch, 1.8*inch
    PURPLE = colors.HexColor("#5b4fcf")
    for i in range(6):
        start = i * 60
        end = start + 60
        d.add(Wedge(cx, cy, r, start, end, strokeColor=PURPLE, strokeWidth=1.5, fillColor=None))
    story.append(Spacer(1, 10))
    story.append(d)
    story.append(Paragraph("Color each wedge going around the circle: Red, Orange, Yellow, Green, Blue, Purple.",
                            ParagraphStyle("cap", parent=styles["Normal"], fontSize=11, spaceBefore=6)))

    answers = ["Red + Yellow = Orange", "Yellow + Blue = Green", "Blue + Red = Purple"]
    _packet_section(story, styles, "Answer Key", "For grown-ups — check your scholar's work against these answers.")
    ans_text = "&nbsp;&nbsp;&nbsp;&nbsp;".join(f"{i+1}. {a}" for i, a in enumerate(answers))
    story.append(Paragraph(ans_text, ParagraphStyle("aka", parent=styles["Normal"], fontSize=11, leading=19)))

    _footer(story, styles, "Art · Grade 4")
    doc.build(story)
    return buf.getvalue()


def _symmetry_line_art():
    from reportlab.graphics.shapes import Drawing, Line
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Symmetry Art: Mirror Wings", "Draw a design on one side, then mirror it exactly on the other side.")

    steps = [
        "1. On the LEFT side of the dashed line below, draw half of a butterfly wing, a leaf, or any shape you like.",
        "2. Look closely at every curve, dot, and line you drew.",
        "3. On the RIGHT side, draw the EXACT mirror image — same size, same shape, flipped like a reflection.",
        "4. Color both sides to match exactly.",
    ]
    for s in steps:
        story.append(Paragraph(s, ParagraphStyle("s", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=6)))

    d = Drawing(5.5*inch, 4*inch)
    PURPLE = colors.HexColor("#5b4fcf")
    d.add(Line(2.75*inch, 0, 2.75*inch, 4*inch, strokeColor=PURPLE, strokeWidth=2, strokeDashArray=[6, 4]))
    story.append(Spacer(1, 10))
    story.append(d)
    story.append(Paragraph("The dashed line is your LINE OF SYMMETRY.",
                            ParagraphStyle("cap", parent=styles["Normal"], fontSize=11, spaceBefore=6)))
    _footer(story, styles, "Art · Grade 4")
    doc.build(story)
    return buf.getvalue()


def _shading_techniques_practice():
    blocks = [
        ("Hatching", "Draw many thin lines close together, all going the same direction, to make an area look shaded."),
        ("Cross-Hatching", "Draw hatching lines, then draw MORE lines crossing over them at an angle — it looks darker."),
        ("Stippling", "Make tiny dots close together instead of lines — more dots close together looks darker."),
        ("Blending", "Use the side of your pencil and rub gently to smooth out light and dark areas."),
        ("Practice", "Pick your favorite technique from above and use it to shade a circle, so it looks like a sphere."),
    ]
    return _text_page("Shading Techniques", "Learn four ways artists use pencil marks to show light and shadow.",
                       blocks, "Art · Grade 4")


def _conflict_resolution_steps():
    blocks = [
        ("Step 1: Calm down", "Take three deep breaths before you talk about the problem."),
        ("Step 2: Use an I-statement", "Say how YOU feel without blaming: 'I feel ___ when ___ happens.'"),
        ("Step 3: Listen", "Let the other person share their side without interrupting."),
        ("Step 4: Find a compromise", "Think of a solution that works for both of you."),
        ("Practice", "Write an I-statement for a time a friend upset you: _______________________"),
    ]
    return _text_page("Conflict Resolution Steps", "Learn four steps to solve a disagreement calmly and fairly.",
                       blocks, "Feelings · Grade 5")


def _emotional_triggers_reflection():
    blocks = [
        ("What's a trigger?", "A trigger is something that sets off a strong feeling quickly, like being teased "
                               "or losing a game."),
        ("Reflect", "Name one thing that triggers frustration or anger for you: _______________________"),
        ("Reflect", "What does your body do right before you feel that trigger? (fast heartbeat, hot face, "
                     "clenched fists) _______________________"),
        ("Plan ahead", "Write one calming strategy you can use the NEXT time that trigger happens: "
                        "_______________________"),
    ]
    return _text_page("Understanding My Triggers", "Reflect on what sets off strong feelings for you, and plan ahead.",
                       blocks, "Feelings · Grade 5")


def _empathy_perspective_taking_5():
    blocks = [
        ("Scenario", "Two students, Alex and Jordan, are picked last for a team during gym class."),
        ("Alex's view", "Alex feels embarrassed and thinks the other kids don't want to play with them. Write "
                         "what Alex might be feeling and why: _______________________"),
        ("Jordan's view", "Jordan is the team captain and was just trying to pick people quickly, not to be "
                           "unkind. Write what Jordan might say if they knew how Alex felt: "
                           "_______________________"),
        ("Your turn", "Describe a time you misunderstood someone's actions. How did it turn out?"),
    ]
    return _text_page("Seeing Both Sides", "Practice understanding a situation from two different people's perspectives.",
                       blocks, "Feelings · Grade 5")


def _same_or_different_tk():
    blocks = [
        ("Same or Different?", "Two red circles.  Same  or  Different?"),
        ("Same or Different?", "A red circle and a blue circle.  Same  or  Different?"),
        ("Same or Different?", "Two stars.  Same  or  Different?"),
        ("Same or Different?", "A dog and a cat.  Same  or  Different?"),
    ]
    answers = ["1. Same", "2. Different", "3. Same", "4. Different"]
    return _text_page("Same or Different?", "Look at each pair and decide if they are the same or different.",
                       blocks, "Logic · TK", answers=answers)


def _what_comes_next_tk():
    blocks = [
        ("Puzzle 1", "Red, Blue, Red, Blue, Red, ___  ->  What comes next?"),
        ("Puzzle 2", "Star, Star, Moon, Star, Star, Moon, ___  ->  What comes next?"),
        ("Puzzle 3", "Dog, Cat, Dog, Cat, Dog, ___  ->  What comes next?"),
    ]
    answers = ["1. Blue", "2. Star", "3. Cat"]
    return _text_page("What Comes Next?", "Look at the pattern, then say what comes next.",
                       blocks, "Logic · TK", answers=answers)


def _which_one_is_different_tk():
    blocks = [
        ("Which is different?", "Apple, Banana, Apple.  Which one is different? _______________"),
        ("Which is different?", "Dog, Dog, Cat.  Which one is different? _______________"),
        ("Which is different?", "Star, Star, Star, Moon.  Which one is different? _______________"),
    ]
    answers = ["1. Banana", "2. Cat", "3. Moon"]
    return _text_page("Which One is Different?", "Look at each group and find the one that doesn't match.",
                       blocks, "Logic · TK", answers=answers)


def _digital_manners_6():
    blocks = [
        ("Why it matters", "Good manners apply online too — words in texts and posts can hurt just as much as "
                            "words said out loud."),
        ("Think before you send", "Before posting or texting something, ask: would I say this to their face? "
                                    "Would I want this said to me?"),
        ("Practice", "Rewrite this rude text more kindly: 'ur project was so bad lol'  ->  "
                      "_______________________"),
        ("Reflect", "Why might ALL CAPS or lots of exclamation points come across as yelling online? "
                     "_______________________"),
    ]
    return _text_page("Digital Manners", "Learn how good manners apply to texting, gaming, and social media.",
                       blocks, "Manners · Grade 6")


def _respectful_disagreement_6():
    blocks = [
        ("It's okay to disagree", "You can disagree with someone's opinion while still being respectful of them "
                                    "as a person."),
        ("Do", "Use phrases like 'I see it differently because...' or 'I understand, but I think...'"),
        ("Don't", "Avoid interrupting, name-calling, or saying 'that's a dumb idea.'"),
        ("Practice", "A classmate says their favorite book is boring, but you love it. Write a respectful "
                      "response: _______________________"),
    ]
    return _text_page("Respectful Disagreement", "Learn how to disagree with someone while still being kind and respectful.",
                       blocks, "Manners · Grade 6")


def _cultural_respect_manners_6():
    blocks = [
        ("Why it matters", "Different families and cultures have different customs, foods, holidays, and "
                            "traditions — all worth respecting."),
        ("Practice", "If a classmate's family celebrates a holiday you don't know about, what's a respectful "
                      "question to ask? _______________________"),
        ("Practice", "Why is it unkind to say someone's food, clothing, or traditions are 'weird'? "
                      "_______________________"),
        ("Reflect", "Name one tradition from your own family or culture that's meaningful to you."),
    ]
    return _text_page("Respecting Different Cultures", "Practice showing respect for customs and traditions different from your own.",
                       blocks, "Manners · Grade 6")


def _factors_and_multiples_4():
    blocks = [
        ("Factors", "Factors of a number divide into it evenly. List all factors of 24: _______________________"),
        ("Factors", "List all factors of 36: _______________________"),
        ("Multiples", "Multiples are what you get when you multiply a number by 1, 2, 3... List the first 5 "
                       "multiples of 6: _______________________"),
        ("Multiples", "List the first 5 multiples of 9: _______________________"),
        ("Both", "What is one number that is both a factor of 24 AND a multiple of 4? _______________________"),
    ]
    answers = ["24: 1, 2, 3, 4, 6, 8, 12, 24", "36: 1, 2, 3, 4, 6, 9, 12, 18, 36", "6: 6, 12, 18, 24, 30",
               "9: 9, 18, 27, 36, 45", "4, 8, 12, or 24 all work"]
    return _text_page("Factors & Multiples", "Practice finding factors and multiples of numbers.",
                       blocks, "Math · Grade 4", answers=answers)


def _fraction_basics_4():
    blocks = [
        ("What is a fraction?", "A fraction shows part of a whole. The top number (numerator) is how many parts "
                                  "you have. The bottom number (denominator) is how many equal parts make the whole."),
        ("Identify it", "A pizza is cut into 8 slices, and you eat 3. What fraction did you eat? "
                          "_______________________"),
        ("Compare", "Which is bigger: 1/2 or 1/4? _______________________"),
        ("Compare", "Which is bigger: 3/4 or 2/4? _______________________"),
        ("Simplify", "2/4 is the same as what simpler fraction? _______________________"),
    ]
    answers = ["3/8", "1/2 is bigger", "3/4 is bigger", "1/2"]
    return _text_page("Fraction Basics", "Learn what a fraction means, then compare and simplify.",
                       blocks, "Math · Grade 4", answers=answers)


def _multi_digit_multiplication_word_problems_4():
    probs, answers = [], []
    for _ in range(9):
        kind = random.choice(["rows", "boxes", "days"])
        if kind == "rows":
            a = random.randint(12, 45)
            b = random.randint(3, 9)
            probs.append(f"A theater has {b} rows with {a} seats in each row. How many seats in total?")
            answers.append(str(a * b))
        elif kind == "boxes":
            a = random.randint(15, 60)
            b = random.randint(4, 8)
            probs.append(f"A warehouse has {b} boxes with {a} toys in each box. How many toys in total?")
            answers.append(str(a * b))
        else:
            a = random.randint(20, 90)
            b = random.randint(5, 12)
            probs.append(f"A factory makes {a} widgets a day for {b} days. How many widgets in total?")
            answers.append(str(a * b))
    return _build("Multiplication Word Problems", "Multiply carefully to solve each real-world problem.", probs,
                  "Math · Grade 4", cols=1, col_w=6.5, answers=answers)


def _r_controlled_vowels_3():
    pairs = [
        ("car", "ar makes the sound in car, star, far"), ("bird", "ir makes the sound in bird, girl, first"),
        ("burn", "ur makes the sound in burn, turn, nurse"), ("corn", "or makes the sound in corn, fork, storm"),
        ("her", "er makes the sound in her, fern, term"),
    ]
    return _word_match_table("R-Controlled Vowels", "Match each r-controlled vowel pattern to its sound example.",
                              pairs, "Phonics · Grade 3")


def _prefixes_suffixes_3():
    pairs = [
        ("un-", "means 'not' — unhappy means not happy"), ("re-", "means 'again' — redo means do again"),
        ("-ful", "means 'full of' — joyful means full of joy"), ("-less", "means 'without' — careless means without care"),
        ("-ing", "shows an action happening now — running"),
    ]
    return _word_match_table("Prefixes & Suffixes", "Match each word part to what it means.",
                              pairs, "Phonics · Grade 3")


def _compound_words_contractions_3():
    blocks = [
        ("Compound words", "Two small words joined to make one new word. sun + flower = sunflower."),
        ("Build one", "tooth + brush = _______________________"),
        ("Build one", "rain + bow = _______________________"),
        ("Contractions", "Two words shortened with an apostrophe. do not = don't."),
        ("Shorten it", "I am = _______________________"),
        ("Shorten it", "they are = _______________________"),
    ]
    answers = ["toothbrush", "rainbow", "I'm", "they're"]
    return _text_page("Compound Words & Contractions", "Build compound words, then shorten phrases into contractions.",
                       blocks, "Phonics · Grade 3", answers=answers)


def _context_clues_2():
    blocks = [
        ("What are context clues?", "Words around a tricky word that help you guess its meaning."),
        ("Guess it", "The arid desert had no rain for months, so the plants were dry and crackly. What does "
                      "'arid' mean? _______________________"),
        ("Guess it", "She was famished after skipping lunch, so she ate a huge dinner. What does 'famished' "
                      "mean? _______________________"),
        ("Guess it", "The enormous elephant was much bigger than the tiny mouse. What does 'enormous' mean? "
                      "_______________________"),
    ]
    answers = ["arid = dry", "famished = very hungry", "enormous = very big"]
    return _text_page("Context Clues", "Use clues in the sentence to guess what each bolded word means.",
                       blocks, "Reading · Grade 2", answers=answers)


def _fact_or_opinion_2():
    blocks = [
        ("What's the difference?", "A FACT can be proven true. An OPINION is what someone thinks or feels."),
        ("Fact or Opinion?", "Dogs are the best pets.  Fact  or  Opinion?"),
        ("Fact or Opinion?", "A dog has four legs.  Fact  or  Opinion?"),
        ("Fact or Opinion?", "Pizza tastes better than salad.  Fact  or  Opinion?"),
        ("Fact or Opinion?", "Water freezes at 32 degrees Fahrenheit.  Fact  or  Opinion?"),
    ]
    answers = ["1. Opinion", "2. Fact", "3. Opinion", "4. Fact"]
    return _text_page("Fact or Opinion?", "Decide whether each sentence is a fact or an opinion.",
                       blocks, "Reading · Grade 2", answers=answers)


def _story_sequencing_2():
    blocks = [
        ("Read the story", "Maya woke up, brushed her teeth, ate breakfast, then walked to the bus stop."),
        ("Put in order", "Number these 1 to 4 in the order they happened: ___ Ate breakfast   ___ Woke up   "
                          "___ Walked to the bus stop   ___ Brushed teeth"),
        ("Your turn", "Write three things you did this morning, in order: 1) _______ 2) _______ 3) _______"),
    ]
    answers = ["Woke up = 1, Brushed teeth = 2, Ate breakfast = 3, Walked to bus stop = 4"]
    return _text_page("Story Sequencing", "Practice putting story events in the correct order.",
                       blocks, "Reading · Grade 2", answers=answers)


def _plot_diagram_6():
    blocks = [
        ("Exposition", "Introduces characters and setting. Describe yours: _______________________"),
        ("Rising Action", "Problems build up. What challenges does your character face? _______________________"),
        ("Climax", "The most exciting, turning-point moment. What happens? _______________________"),
        ("Falling Action", "Things start to resolve. What happens next? _______________________"),
        ("Resolution", "How does the story end? _______________________"),
    ]
    return _text_page("Plot Diagram Planner", "Plan a story using all five parts of a classic plot diagram.",
                       blocks, "Story Activities · Grade 6")


def _character_motivation_6():
    blocks = [
        ("What is motivation?", "The reason a character wants something or acts a certain way."),
        ("Analyze", "Pick a character from a book or movie you know. What do they want most? "
                     "_______________________"),
        ("Analyze", "What is stopping them from getting it? _______________________"),
        ("Create", "Invent a new character. What do THEY want, and why? _______________________"),
    ]
    return _text_page("Character Motivation", "Explore what drives a character's actions in a story.",
                       blocks, "Story Activities · Grade 6")


def _write_a_plot_twist_6():
    blocks = [
        ("What's a plot twist?", "A surprising turn in the story that readers didn't expect."),
        ("Read this setup", "A detective is about to arrest the town's mayor for a crime."),
        ("Add a twist", "Write a surprising twist that changes everything: _______________________"),
        ("Your own story", "Write a two-sentence story setup, then a plot twist for it."),
    ]
    return _text_page("Write a Plot Twist", "Practice creating surprising, satisfying plot twists.",
                       blocks, "Story Activities · Grade 6")


# ── Coverage batch 6 — closing the batch-4 Science/Writing combos to 5/5 ───

def _weather_types_tk():
    pairs = [
        ("Sunny", "bright and warm, with a clear sky"), ("Rainy", "wet drops falling from gray clouds"),
        ("Windy", "the air is moving fast"), ("Snowy", "cold, with white flakes falling"),
        ("Cloudy", "the sky is covered in gray clouds"),
    ]
    return _word_match_table("Weather Words", "Match each weather word to what it looks like.",
                              pairs, "Science · TK")


def _hot_or_cold_tk():
    blocks = [
        ("Hot or Cold?", "The sun.  Hot  or  Cold?"),
        ("Hot or Cold?", "An ice cube.  Hot  or  Cold?"),
        ("Hot or Cold?", "A campfire.  Hot  or  Cold?"),
        ("Hot or Cold?", "Snow.  Hot  or  Cold?"),
        ("Hot or Cold?", "Hot cocoa.  Hot  or  Cold?"),
    ]
    answers = ["1. Hot", "2. Cold", "3. Hot", "4. Cold", "5. Hot"]
    return _text_page("Hot or Cold?", "Circle Hot or Cold for each thing.",
                       blocks, "Science · TK", answers=answers)


def _animal_babies_match_tk():
    pairs = [
        ("Dog", "has a baby called a puppy"), ("Cat", "has a baby called a kitten"),
        ("Cow", "has a baby called a calf"), ("Horse", "has a baby called a foal"),
        ("Chicken", "has a baby called a chick"),
    ]
    return _word_match_table("Animal Babies", "Match each animal to the name of its baby.",
                              pairs, "Science · TK")


def _things_that_float_or_sink_k():
    blocks = [
        ("Float or Sink?", "A rubber duck.  Float  or  Sink?"),
        ("Float or Sink?", "A heavy rock.  Float  or  Sink?"),
        ("Float or Sink?", "A leaf.  Float  or  Sink?"),
        ("Float or Sink?", "A metal coin.  Float  or  Sink?"),
        ("Float or Sink?", "An empty plastic bottle with the cap on.  Float  or  Sink?"),
    ]
    answers = ["1. Float", "2. Sink", "3. Float", "4. Sink", "5. Float"]
    return _text_page("Float or Sink?", "Circle Float or Sink for each object in water.",
                       blocks, "Science · Kindergarten", answers=answers)


def _animal_habitats_match_k():
    pairs = [
        ("Fish", "lives in the ocean or a pond"), ("Bear", "lives in the forest"),
        ("Camel", "lives in the desert"), ("Penguin", "lives on ice and snow"),
        ("Monkey", "lives in the jungle"),
    ]
    return _word_match_table("Animal Habitats", "Match each animal to where it lives.",
                              pairs, "Science · Kindergarten")


def _day_sky_night_sky_k():
    blocks = [
        ("Day sky", "During the DAY, the sky is bright and blue, and you can see the sun."),
        ("Fill in the blank", "During the NIGHT, the sky is ___ and you can see the ___ and ___. "
                               "_______________________"),
        ("Draw", "Draw a day sky on one half of a page and a night sky on the other half."),
    ]
    answers = ["Night — dark, moon, and stars"]
    return _text_page("Day Sky, Night Sky", "Compare what the sky looks like during the day and at night.",
                       blocks, "Science · Kindergarten", answers=answers)


def _animal_body_coverings_1():
    pairs = [
        ("Fur", "covers mammals like dogs and bears, and keeps them warm"),
        ("Feathers", "cover birds, help them fly, and keep them warm"),
        ("Scales", "cover fish and reptiles, and protect their skin"),
        ("Shell", "covers turtles and snails, and protects their soft body"),
    ]
    return _word_match_table("Animal Body Coverings", "Match each body covering to what it does.",
                              pairs, "Science · Grade 1")


def _push_or_pull_1():
    blocks = [
        ("Push or Pull?", "Opening a drawer toward you.  Push  or  Pull?"),
        ("Push or Pull?", "Closing a door away from you.  Push  or  Pull?"),
        ("Push or Pull?", "Kicking a ball.  Push  or  Pull?"),
        ("Push or Pull?", "Pulling a wagon behind you.  Push  or  Pull?"),
        ("Reflect", "Name one more push and one more pull you do every day."),
    ]
    answers = ["1. Pull", "2. Push", "3. Push", "4. Pull"]
    return _text_page("Push or Pull?", "Decide if each action is a push force or a pull force.",
                       blocks, "Science · Grade 1", answers=answers)


def _plant_parts_and_jobs_1():
    pairs = [
        ("Roots", "soak up water and hold the plant in the ground"),
        ("Stem", "carries water up to the leaves and holds the plant up"),
        ("Leaves", "use sunlight to make food for the plant"),
        ("Flower", "makes seeds so new plants can grow"),
    ]
    return _word_match_table("Plant Parts & Jobs", "Match each plant part to its job.",
                              pairs, "Science · Grade 1")


def _rock_types_match_3():
    pairs = [
        ("Igneous", "forms when hot melted rock (magma or lava) cools and hardens"),
        ("Sedimentary", "forms when layers of sand, mud, and shells press together over time"),
        ("Metamorphic", "forms when heat and pressure change one rock into a new kind"),
    ]
    return _word_match_table("Types of Rocks", "Match each rock type to how it forms.",
                              pairs, "Science · Grade 3")


def _states_of_matter_changes_3():
    blocks = [
        ("Solid to Liquid", "When a solid turns into a liquid (like ice into water), it is called "
                             "___. _______________________"),
        ("Liquid to Solid", "When a liquid turns into a solid (like water into ice), it is called "
                             "___. _______________________"),
        ("Liquid to Gas", "When a liquid turns into a gas (like water into steam), it is called "
                           "___. _______________________"),
        ("Gas to Liquid", "When a gas turns into a liquid (like steam onto a cold window), it is called "
                           "___. _______________________"),
    ]
    answers = ["Melting", "Freezing", "Evaporation", "Condensation"]
    return _text_page("States of Matter: Changes", "Name the change each time matter switches from one state to another.",
                       blocks, "Science · Grade 3", answers=answers)


def _animal_adaptations_3():
    blocks = [
        ("What's an adaptation?", "A special feature that helps an animal survive in its environment."),
        ("Explain it", "A polar bear has thick white fur. How does this help it survive? "
                        "_______________________"),
        ("Explain it", "A cactus has spines instead of leaves. How does this help it survive in the desert? "
                        "_______________________"),
        ("Explain it", "A chameleon can change color. How does this help it survive? _______________________"),
    ]
    answers = ["White fur camouflages in snow and keeps the bear warm",
               "Spines reduce water loss and protect from predators",
               "Changing color helps it hide from predators or blend in"]
    return _text_page("Animal Adaptations", "Learn how special features help animals survive.",
                       blocks, "Science · Grade 3", answers=answers)


def _writing_shapes_practice_tk():
    blocks = [
        ("Straight lines", "Practice: draw 3 straight lines going from left to right."),
        ("Circles", "Practice: draw 3 circles, going around and around."),
        ("Zigzags", "Practice: draw a zigzag line, like a bumpy mountain."),
        ("Why it matters", "These shapes are the building blocks for writing letters!"),
    ]
    return _text_page("Writing Shapes Practice", "Practice the basic strokes and shapes used to write letters.",
                       blocks, "Writing · TK")


def _my_favorite_things_tk():
    blocks = [
        ("My favorite toy", "Draw it, then write its name: _______________________"),
        ("My favorite food", "Draw it, then write its name: _______________________"),
        ("My favorite animal", "Draw it, then write its name: _______________________"),
    ]
    return _text_page("My Favorite Things", "Draw three of your favorite things, then write what each one is.",
                       blocks, "Writing · TK")


def _family_members_labels_tk():
    blocks = [
        ("Draw your family", "Draw the people in your family."),
        ("Label them", "Under each person, write who they are: MOM, DAD, ME, or their name."),
        ("Count", "How many people are in your family? Write the number: _______________________"),
    ]
    return _text_page("My Family", "Draw your family, then label who everyone is.",
                       blocks, "Writing · TK")


def _writing_about_pictures_k():
    blocks = [
        ("Picture 1", "A dog is playing with a ball in the park. Write one sentence about it: "
                       "_______________________"),
        ("Picture 2", "A girl is eating ice cream on a hot day. Write one sentence about it: "
                       "_______________________"),
        ("Picture 3", "Draw your own picture, then write one sentence about it."),
    ]
    return _text_page("Writing About Pictures", "Practice writing a complete sentence about what you see.",
                       blocks, "Writing · Kindergarten")


def _using_and_in_lists_k():
    blocks = [
        ("Joining words with AND", "I like apples and bananas. The word AND joins two things together."),
        ("Try it", "I have a cat ___ a dog. (fill in the joining word) _______________________"),
        ("Try it", "Write your own sentence using AND to join two things: _______________________"),
        ("Try it", "Write a sentence about three things you like, using AND before the last one: "
                    "_______________________"),
    ]
    answers = ["and"]
    return _text_page("Joining Words with AND", "Practice using the word AND to connect two or more things in a sentence.",
                       blocks, "Writing · Kindergarten", answers=answers)


def _labeling_a_scene_k():
    blocks = [
        ("Draw a park scene", "Draw a park with at least 3 things in it (a tree, a swing, a dog, etc.)"),
        ("Label it", "Write the name of each thing you drew next to it."),
        ("Write a sentence", "Write one sentence describing your park scene: _______________________"),
    ]
    return _text_page("Label a Scene", "Draw a scene, label what's in it, then write a sentence describing it.",
                       blocks, "Writing · Kindergarten")


def _writing_exclamations_1():
    blocks = [
        ("What's an exclamation?", "A sentence that shows strong feeling, like excitement or surprise, "
                                    "ending with an exclamation point ( ! )."),
        ("Add the mark", "We won the game  ->  add the right end mark: _______________________"),
        ("Add the mark", "Watch out for that puddle  ->  add the right end mark: _______________________"),
        ("Your turn", "Write your own exclamation about something exciting: _______________________"),
    ]
    answers = ["We won the game!", "Watch out for that puddle!"]
    return _text_page("Writing Exclamations", "Practice writing sentences that show strong feeling.",
                       blocks, "Writing · Grade 1", answers=answers)


def _friendly_letter_basics_1():
    blocks = [
        ("Greeting", "Starts the letter: 'Dear ___,'"),
        ("Body", "The main message — what you want to say."),
        ("Closing", "Ends the letter: 'Love,' or 'Your friend,'"),
        ("Try it", "Write a short letter to a friend telling them about your day. Use a greeting, body, "
                    "and closing."),
    ]
    return _text_page("Friendly Letter Basics", "Learn the three parts of a friendly letter, then write one.",
                       blocks, "Writing · Grade 1")


def _sequence_words_1():
    pairs = [
        ("First", "tells what happens at the very beginning"), ("Next", "tells what happens after that"),
        ("Then", "tells what happens after next"), ("Last", "tells what happens at the very end"),
    ]
    return _word_match_table("Sequence Words", "Match each sequence word to when it's used in a story.",
                              pairs, "Writing · Grade 1")


def _informational_writing_intro_2():
    blocks = [
        ("What is informational writing?", "Writing that teaches the reader true facts about a topic."),
        ("Pick a topic", "Choose something you know a lot about (an animal, a sport, a place): "
                          "_______________________"),
        ("Fact 1", "Write one true fact about your topic: _______________________"),
        ("Fact 2", "Write another true fact: _______________________"),
        ("Fact 3", "Write one more true fact: _______________________"),
    ]
    return _text_page("Informational Writing", "Practice writing true facts about a topic you know well.",
                       blocks, "Writing · Grade 2")


def _similes_intro_2():
    pairs = [
        ("as brave as a lion", "comparing courage to a lion"), ("as slow as a turtle", "comparing slowness to a turtle"),
        ("as bright as the sun", "comparing brightness to the sun"), ("as quiet as a mouse", "comparing quietness to a mouse"),
    ]
    return _word_match_table("Similes: Like or As", "Match each simile to what it's comparing.",
                              pairs, "Writing · Grade 2")


def _writing_a_thank_you_note_2():
    blocks = [
        ("Why write thank-you notes?", "To show someone you appreciate a gift, favor, or kind act."),
        ("Parts of a thank-you note", "A greeting, what you're thankful for and why, and a closing."),
        ("Try it", "Write a thank-you note to someone who did something kind for you: "
                    "_______________________"),
    ]
    return _text_page("Writing a Thank-You Note", "Learn the parts of a thank-you note, then write your own.",
                       blocks, "Writing · Grade 2")


# ── Coverage batch 7 — closing the last batch-4 combos to 5/5 ──────────────

def _ecosystems_intro_4():
    pairs = [
        ("Habitat", "the natural home of a plant or animal"),
        ("Population", "all the members of one species living in an area"),
        ("Community", "all the different species living together in one place"),
        ("Ecosystem", "living things and their environment, all interacting together"),
    ]
    return _word_match_table("Ecosystems Vocabulary", "Match each ecosystem term to its definition.",
                              pairs, "Science · Grade 4")


def _earth_layers_4():
    blocks = [
        ("Crust", "The thin, rocky outer layer we live on."),
        ("Mantle", "A thick layer of hot, slowly moving rock beneath the crust."),
        ("Outer Core", "A layer of liquid metal, mostly iron and nickel."),
        ("Inner Core", "The center of the Earth — solid metal, even hotter than the outer core."),
        ("Order them", "Number these from the OUTSIDE in: ___ Inner Core   ___ Crust   ___ Mantle   "
                        "___ Outer Core"),
    ]
    answers = ["Crust = 1, Mantle = 2, Outer Core = 3, Inner Core = 4"]
    return _text_page("Layers of the Earth", "Learn the four layers of the Earth, from crust to core.",
                       blocks, "Science · Grade 4", answers=answers)


def _magnets_and_forces_4():
    blocks = [
        ("True or False?", "Opposite poles of a magnet attract (pull together).  True  or  False?"),
        ("True or False?", "Two north poles will attract each other.  True  or  False?"),
        ("True or False?", "Magnets can pull objects without touching them.  True  or  False?"),
        ("True or False?", "All metals are attracted to magnets.  True  or  False?"),
        ("Explain", "Name one object in your house that uses a magnet: _______________________"),
    ]
    answers = ["1. True", "2. False", "3. True", "4. False (only some metals, like iron, are attracted)"]
    return _text_page("Magnets & Forces", "Test what you know about how magnets attract and repel.",
                       blocks, "Science · Grade 4", answers=answers)


def _human_body_systems_6():
    pairs = [
        ("Circulatory system", "pumps blood through the body using the heart"),
        ("Respiratory system", "brings oxygen into the body through the lungs"),
        ("Digestive system", "breaks down food so the body can use it"),
        ("Skeletal system", "gives the body structure and protects organs"),
        ("Nervous system", "carries messages between the brain and the body"),
    ]
    return _word_match_table("Human Body Systems", "Match each body system to its job.",
                              pairs, "Science · Grade 6")


def _newtons_laws_intro_6():
    blocks = [
        ("Newton's First Law", "An object at rest stays at rest, and an object in motion stays in motion, "
                                "unless a force acts on it. Give an example: _______________________"),
        ("Newton's Second Law", "The more force you use on an object, the more it speeds up. Give an example: "
                                 "_______________________"),
        ("Newton's Third Law", "For every action, there's an equal and opposite reaction. Give an example: "
                                "_______________________"),
    ]
    return _text_page("Newton's Three Laws of Motion", "Learn the three basic laws that explain how objects move.",
                       blocks, "Science · Grade 6")


def _ecosystem_energy_pyramid_6():
    blocks = [
        ("What is an energy pyramid?", "It shows how energy decreases as it moves up from producers to top "
                                        "predators."),
        ("Bottom level", "Producers (plants) — they have the MOST energy because they make their own food "
                          "from sunlight."),
        ("Fill in", "Animals that eat producers are called ___. _______________________"),
        ("Fill in", "Animals that eat other animals are called ___. _______________________"),
        ("Explain", "Why does each level of the pyramid have LESS energy than the level below it? "
                     "_______________________"),
    ]
    answers = ["Herbivores (primary consumers)", "Carnivores (secondary/tertiary consumers)",
               "Energy is lost as heat at each step, so less is passed up the pyramid"]
    return _text_page("Energy Pyramid", "Learn how energy flows and decreases through an ecosystem.",
                       blocks, "Science · Grade 6", answers=answers)


def _compare_contrast_writing_4():
    blocks = [
        ("Pick two things", "Choose two things to compare (two animals, two places, two seasons): "
                             "_______________________"),
        ("How are they alike?", "List two ways they are similar: _______________________"),
        ("How are they different?", "List two ways they are different: _______________________"),
        ("Use signal words", "Words like 'both,' 'but,' 'however,' and 'unlike' help show comparisons. Write "
                              "one sentence using a signal word: _______________________"),
    ]
    return _text_page("Compare & Contrast Writing", "Practice comparing two things using signal words.",
                       blocks, "Writing · Grade 4")


def _strong_openings_4():
    blocks = [
        ("Why openings matter", "A strong opening hooks the reader and makes them want to keep reading."),
        ("Question hook", "Start with a question: _______________________"),
        ("Surprising fact hook", "Start with a surprising fact: _______________________"),
        ("Action hook", "Start in the middle of an exciting moment: _______________________"),
        ("Try it", "Pick your favorite hook above and turn it into a full opening sentence for a story."),
    ]
    return _text_page("Strong Story Openings", "Practice three ways to hook a reader in your first sentence.",
                       blocks, "Writing · Grade 4")


def _editing_marks_practice_4():
    blocks = [
        ("Capitalize", "A line under a letter means make it a capital: the dog ran."),
        ("Add a period", "A caret (^) with a period means insert one: i like dogs ^"),
        ("Delete", "A loop through a word means take it out: I like like dogs."),
        ("Practice", "Mark the mistakes, then rewrite this sentence correctly: 'my dog Max run fast' -> "
                      "_______________________"),
    ]
    answers = ["My dog Max runs fast."]
    return _text_page("Editing Marks Practice", "Learn basic proofreading marks, then use them to fix a sentence.",
                       blocks, "Writing · Grade 4", answers=answers)


def _writing_dialogue_5():
    blocks = [
        ("Rule 1", "Put a comma before the quotation, and quotation marks around the exact words spoken."),
        ("Rule 2", "Start a NEW paragraph every time a different person speaks."),
        ("Fix it", "Add quotation marks and punctuation: Maya said I cant find my shoes -> "
                    "_______________________"),
        ("Try it", "Write a short dialogue (3-4 lines) between two characters about a lost pet."),
    ]
    answers = ["Maya said, \"I can't find my shoes.\""]
    return _text_page("Writing Dialogue", "Learn the punctuation rules for writing conversation between characters.",
                       blocks, "Writing · Grade 5", answers=answers)


def _sensory_details_5():
    blocks = [
        ("What are sensory details?", "Details that use the five senses — sight, sound, smell, taste, touch — "
                                       "to help readers picture a scene."),
        ("Sight", "Describe what a campfire looks like: _______________________"),
        ("Sound", "Describe what a campfire sounds like: _______________________"),
        ("Smell", "Describe what a campfire smells like: _______________________"),
        ("Combine", "Write one sentence about a campfire using at least two senses: _______________________"),
    ]
    return _text_page("Sensory Details", "Practice using your five senses to write vivid descriptions.",
                       blocks, "Writing · Grade 5")


def _thesis_statement_practice_5():
    blocks = [
        ("What's a thesis statement?", "One sentence that tells the reader the main point of your whole piece "
                                        "of writing."),
        ("Weak example", "Dogs are animals. (too obvious — not a real opinion or focus)"),
        ("Strong example", "Dogs make better pets than cats because they are loyal, trainable, and protective."),
        ("Try it", "Write your own thesis statement about your favorite hobby: _______________________"),
    ]
    return _text_page("Thesis Statement Practice", "Learn what makes a strong thesis statement, then write your own.",
                       blocks, "Writing · Grade 5")


def _essay_structure_recap_6():
    blocks = [
        ("Introduction", "Hook + background + thesis statement (your main point)."),
        ("Body Paragraph 1", "A topic sentence + evidence/examples + explanation."),
        ("Body Paragraph 2", "A second topic sentence + evidence/examples + explanation."),
        ("Body Paragraph 3", "A third topic sentence + evidence/examples + explanation."),
        ("Conclusion", "Restate your thesis in new words, then add a final thought."),
    ]
    return _text_page("Five-Paragraph Essay Structure", "Learn the five parts of a classic essay outline.",
                       blocks, "Writing · Grade 6")


def _active_vs_passive_voice_6():
    blocks = [
        ("Active voice", "The subject DOES the action. Example: The dog chased the ball."),
        ("Passive voice", "The subject RECEIVES the action. Example: The ball was chased by the dog."),
        ("Rewrite it", "Passive: The cake was eaten by Sam.  ->  Rewrite in active voice: "
                        "_______________________"),
        ("Rewrite it", "Passive: The window was broken by the storm.  ->  Rewrite in active voice: "
                        "_______________________"),
        ("Why it matters", "Active voice is usually clearer and more direct — most writers use it more often."),
    ]
    answers = ["Sam ate the cake.", "The storm broke the window."]
    return _text_page("Active vs. Passive Voice", "Practice identifying and rewriting passive-voice sentences as active voice.",
                       blocks, "Writing · Grade 6", answers=answers)


def _citing_evidence_6():
    blocks = [
        ("Why cite evidence?", "Using specific evidence from a text makes your writing more convincing and "
                                "credible."),
        ("Claim", "Main character Jake is brave."),
        ("Evidence", "Find a specific detail or quote that PROVES the claim (from a book you know): "
                      "_______________________"),
        ("Explain", "Explain HOW that evidence proves the claim: _______________________"),
    ]
    return _text_page("Citing Evidence", "Practice supporting a claim about a text with specific evidence.",
                       blocks, "Writing · Grade 6")


# ── Coverage batch 8 — closing 2/5 combos to 5/5 ────────────────────────────

def _shape_tracing_tk():
    return _tracing_items("Trace Shape Names", "Trace each shape word, then write it once on your own.",
                           ["CIRCLE", "SQUARE", "TRIANGLE", "STAR", "HEART"], "Workbook Practice · TK")


def _matching_shapes_tk():
    pairs = [
        ("Circle", "has 0 sides — it's round all the way around"), ("Triangle", "has 3 sides"),
        ("Square", "has 4 equal sides"), ("Rectangle", "has 4 sides, two long and two short"),
        ("Star", "has 5 points"),
    ]
    return _word_match_table("Shapes & Sides", "Match each shape to how many sides it has.",
                              pairs, "Workbook Practice · TK")


def _following_directions_tk():
    items = [
        "Touch your nose", "Clap your hands two times", "Stand up, then sit back down",
        "Point to something red", "Wave hello",
    ]
    return _checklist("Following Directions", "Ask a grown-up to read each direction aloud, then check it off after you do it.",
                       items, "Workbook Practice · TK")


def _writing_numbers_words_k():
    pairs = [
        ("1", "one"), ("2", "two"), ("3", "three"), ("4", "four"), ("5", "five"),
    ]
    return _word_match_table("Number Words 1-5", "Match each number to how it's spelled out as a word.",
                              pairs, "Workbook Practice · Kindergarten")


def _calendar_basics_k():
    blocks = [
        ("Days of the week", "There are 7 days: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday."),
        ("Fill in", "Write today's day of the week: _______________________"),
        ("Fill in", "What day comes right after Monday? _______________________"),
        ("Fill in", "What day comes right before Saturday? _______________________"),
    ]
    answers = ["Tuesday", "Friday"]
    return _text_page("Calendar Basics", "Learn the days of the week and practice using a calendar.",
                       blocks, "Workbook Practice · Kindergarten", answers=answers)


def _measuring_with_objects_k():
    blocks = [
        ("Measure it", "Use your hand span to measure a book. About how many hand spans long is it? "
                        "_______________________"),
        ("Measure it", "Use paper clips laid end to end to measure a pencil. About how many paper clips "
                        "long is it? _______________________"),
        ("Compare", "Which is longer: your shoe or your hand? _______________________"),
    ]
    return _text_page("Measuring with Objects", "Practice measuring things using everyday objects instead of a ruler.",
                       blocks, "Workbook Practice · Kindergarten")


def _value_scale_practice_6():
    from reportlab.graphics.shapes import Drawing, Rect
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Value Scale Practice", "Learn how artists use light and dark values to show depth.")

    story.append(Paragraph("A value scale shows a range from the lightest white to the darkest black, with "
                            "grays in between. Artists use values to show light, shadow, and depth.",
                            ParagraphStyle("b", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=10)))
    d = Drawing(6 * inch, 1 * inch)
    n = 6
    for i in range(n):
        gray = 1 - i / (n - 1)
        d.add(Rect(i * inch, 0, inch, inch, fillColor=colors.Color(gray, gray, gray),
                    strokeColor=colors.black, strokeWidth=1))
    story.append(d)
    story.append(Spacer(1, 10))
    story.append(Paragraph("Practice: draw a sphere below and shade it using at least 4 different values, "
                            "from a bright highlight to a dark shadow.",
                            ParagraphStyle("b2", parent=styles["Normal"], fontSize=12, leading=18, spaceBefore=10)))
    _footer(story, styles, "Art · Grade 6")
    doc.build(story)
    return buf.getvalue()


def _composition_rule_of_thirds_6():
    from reportlab.graphics.shapes import Drawing, Line, Circle
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    buf, doc, story, styles = _doc("Rule of Thirds", "Learn a simple trick artists and photographers use to make a composition more interesting.")

    story.append(Paragraph("Instead of putting your subject dead-center, imagine a grid dividing your page "
                            "into 3 columns and 3 rows. Place your subject along one of the lines, or where "
                            "two lines cross — it looks more natural and interesting than the center.",
                            ParagraphStyle("b", parent=styles["Normal"], fontSize=12, leading=18, spaceAfter=10)))
    d = Drawing(5.4 * inch, 5.4 * inch)
    PURPLE = colors.HexColor("#5b4fcf")
    size = 5.4 * inch
    for i in (1, 2):
        pos = size * i / 3
        d.add(Line(pos, 0, pos, size, strokeColor=PURPLE, strokeWidth=1, strokeDashArray=[4, 3]))
        d.add(Line(0, pos, size, pos, strokeColor=PURPLE, strokeWidth=1, strokeDashArray=[4, 3]))
    d.add(Circle(size / 3, 2 * size / 3, 4, fillColor=PURPLE))
    story.append(d)
    story.append(Spacer(1, 8))
    story.append(Paragraph("The dot marks one of the four 'power points.' Draw a sun, a tree, or a face "
                            "at one of those crossing points — not in the middle.",
                            ParagraphStyle("cap", parent=styles["Normal"], fontSize=11, spaceBefore=6)))
    _footer(story, styles, "Art · Grade 6")
    doc.build(story)
    return buf.getvalue()


def _warm_cool_colors_6():
    blocks = [
        ("Warm colors", "Red, orange, and yellow — they remind people of sun and fire."),
        ("Cool colors", "Blue, green, and purple — they remind people of water and ice."),
        ("Sort it", "Is teal (blue-green) a warm or cool color? _______________________"),
        ("Sort it", "Is coral (red-orange) a warm or cool color? _______________________"),
        ("Mix it", "What do you get mixing red and orange (both warm)? What about blue and green (both "
                    "cool)? _______________________"),
    ]
    answers = ["Teal is cool", "Coral is warm", "Red-orange and blue-green — both are tertiary colors"]
    return _text_page("Warm & Cool Colors", "Learn how colors create warm or cool feelings, and how to mix them.",
                       blocks, "Art · Grade 6", answers=answers)


def _naming_basic_feelings_tk():
    pairs = [
        ("Big smile", "happy"), ("Tears on cheeks", "sad"), ("Eyebrows down, red face", "angry"),
        ("Wide eyes, mouth open", "surprised"), ("Shaky, wanting to hide", "scared"),
    ]
    return _word_match_table("Naming My Feelings", "Match each face description to the feeling word.",
                              pairs, "Feelings · TK")


def _how_do_you_feel_today_tk():
    blocks = [
        ("Point and say", "Point to a face that shows happy. Now point to a face that shows sad."),
        ("How do you feel today?", "Circle one: Happy   Sad   Angry   Scared   Silly"),
        ("Why?", "Tell a grown-up why you feel that way today."),
        ("Draw", "Draw your own face showing how you feel right now."),
    ]
    return _text_page("How Do You Feel Today?", "Circle the feeling you have today, then draw your own face.",
                       blocks, "Feelings · TK")


def _calm_down_breathing_tk():
    blocks = [
        ("Balloon breathing", "Breathe in slowly through your nose, like you're blowing up a balloon in your belly."),
        ("Hold it", "Hold your breath for 2 seconds."),
        ("Let it out", "Breathe out slowly through your mouth, like you're letting the air out of the balloon."),
        ("Practice", "Try balloon breathing 3 times right now with a grown-up."),
    ]
    return _text_page("Balloon Breathing", "Learn a simple breathing trick to help you feel calm.",
                       blocks, "Feelings · TK")


def _sorting_by_one_rule_k():
    blocks = [
        ("Sort them", "Look at these: apple, car, banana, truck, orange. Sort them into two groups: "
                       "FRUITS and VEHICLES."),
        ("Fruits", "Write the fruits: _______________________"),
        ("Vehicles", "Write the vehicles: _______________________"),
        ("Your turn", "Pick 4 objects around you and sort them into two groups of your choosing."),
    ]
    answers = ["Fruits: apple, banana, orange", "Vehicles: car, truck"]
    return _text_page("Sorting by One Rule", "Sort a group of items into two categories.",
                       blocks, "Logic · Kindergarten", answers=answers)


def _first_second_third_k():
    blocks = [
        ("Ordinal numbers", "1st = first, 2nd = second, 3rd = third — they tell you the ORDER of things."),
        ("Line them up", "Five kids are in a race. Number their places: 1st, 2nd, 3rd, 4th, 5th."),
        ("Answer it", "Who finishes right after 2nd place? _______________________"),
        ("Answer it", "If you are 4th in line, how many people are in front of you? _______________________"),
    ]
    answers = ["3rd place", "3 people"]
    return _text_page("1st, 2nd, 3rd: Ordinal Numbers", "Practice using ordinal numbers to describe order.",
                       blocks, "Logic · Kindergarten", answers=answers)


def _true_or_false_logic_k():
    blocks = [
        ("True or False?", "A ball is round.  True  or  False?"),
        ("True or False?", "A fish can fly in the sky.  True  or  False?"),
        ("True or False?", "Ice is cold.  True  or  False?"),
        ("True or False?", "A book can talk by itself.  True  or  False?"),
    ]
    answers = ["1. True", "2. False", "3. True", "4. False"]
    return _text_page("True or False Logic", "Circle True or False for each statement.",
                       blocks, "Logic · Kindergarten", answers=answers)


def _phone_manners_2():
    blocks = [
        ("Answering politely", "Say hello and your name, like 'Hello, this is Sam.'"),
        ("Listening", "Let the other person finish talking before you speak."),
        ("Ending a call", "Say 'goodbye' or 'talk to you later' before hanging up."),
        ("Practice", "Write what you would say if you answered the phone for your family: "
                      "_______________________"),
    ]
    return _text_page("Phone Manners", "Learn how to politely answer and talk on the phone.",
                       blocks, "Manners · Grade 2")


def _being_a_good_sport_2():
    items = [
        "Say 'good game' whether I win or lose", "Cheer for my teammates", "Follow the rules fairly",
        "Don't brag if I win", "Don't blame others if I lose",
    ]
    return _checklist("Being a Good Sport", "Check off each good sportsmanship habit as you practice it.",
                       items, "Manners · Grade 2")


def _manners_with_guests_2():
    blocks = [
        ("Welcoming a guest", "Say hello, smile, and offer to show them around."),
        ("Sharing", "Offer to share your toys or snacks with a guest."),
        ("Being a good host", "Ask your guest what THEY want to do, not just what you want."),
        ("Practice", "Write what you'd say to welcome a friend into your home: _______________________"),
    ]
    return _text_page("Manners with Guests", "Learn how to be a polite and welcoming host.",
                       blocks, "Manners · Grade 2")


def _ending_sounds_k():
    pairs = [
        ("cat, hat, bat", "ending sound: t"), ("sun, fun, run", "ending sound: n"),
        ("dog, log, fog", "ending sound: g"), ("cup, pup, up", "ending sound: p"),
    ]
    return _word_match_table("Ending Sounds", "Match each group of words to their shared ending sound.",
                              pairs, "Phonics · Kindergarten")


def _rhyming_pairs_k():
    pairs = [
        ("cat", "hat, bat, mat all rhyme with cat"), ("dog", "log, fog, jog all rhyme with dog"),
        ("sun", "fun, run, bun all rhyme with sun"), ("pig", "big, dig, wig all rhyme with pig"),
    ]
    return _word_match_table("Rhyming Pairs", "Match each word to a group of words that rhyme with it.",
                              pairs, "Phonics · Kindergarten")


def _short_a_words_k():
    blocks = [
        ("The short A sound", "Say these words out loud: cat, hat, map, bag, can."),
        ("Fill in the blank", "c_t (hint: an animal that says meow) -> _______________________"),
        ("Fill in the blank", "b_g (hint: you carry things in it) -> _______________________"),
        ("Write your own", "Write two more short-a words: _______________________"),
    ]
    answers = ["cat", "bag"]
    return _text_page("Short A Word Family", "Practice reading and writing short-a words.",
                       blocks, "Phonics · Kindergarten", answers=answers)


def _finish_the_story_tk():
    blocks = [
        ("Story starter", "Once upon a time, a little bunny found a shiny red ball in the forest..."),
        ("What happens next?", "Tell a grown-up what happens next in the story."),
        ("Draw it", "Draw a picture of what the bunny does with the ball."),
    ]
    return _text_page("Finish the Story", "Listen to the story starter, then imagine what happens next.",
                       blocks, "Story Activities · TK")


def _puppet_show_prompts_tk():
    blocks = [
        ("Get two toys or stuffed animals", "One is a hungry dragon, one is a brave knight."),
        ("Act it out", "Make the dragon ask the knight for a snack instead of breathing fire!"),
        ("Act it out", "Make the knight and dragon become friends and go on an adventure."),
        ("Your turn", "Pick two of your own toys and make up a short story with them."),
    ]
    return _text_page("Puppet Show Story Prompts", "Use toys or stuffed animals to act out silly story prompts.",
                       blocks, "Story Activities · TK")


def _story_order_pictures_tk():
    blocks = [
        ("Listen to the story", "A seed is planted. It gets water and sun. It grows into a tall plant. "
                                 "A flower blooms."),
        ("What happened first?", "Tell a grown-up what happened FIRST in the story."),
        ("What happened last?", "Tell a grown-up what happened LAST in the story."),
        ("Draw it", "Draw two pictures: one showing the seed, and one showing the flower."),
    ]
    return _text_page("Story Order: What Happened First?", "Listen to a simple story, then talk about what happened first and last.",
                       blocks, "Story Activities · TK")


# ── Coverage batch 9 — closing 2/5 combos to 5/5 ────────────────────────────

def _counting_coins_1():
    blocks = [
        ("Coin values", "Penny = 1 cent. Nickel = 5 cents. Dime = 10 cents. Quarter = 25 cents."),
        ("Count it", "3 pennies + 1 nickel = ___ cents. _______________________"),
        ("Count it", "2 dimes + 1 nickel = ___ cents. _______________________"),
        ("Count it", "1 quarter + 2 pennies = ___ cents. _______________________"),
    ]
    answers = ["8 cents", "25 cents", "27 cents"]
    return _text_page("Counting Coins", "Practice adding up the value of pennies, nickels, dimes, and quarters.",
                       blocks, "Workbook Practice · Grade 1", answers=answers)


def _reading_a_simple_calendar_1():
    blocks = [
        ("Weeks and months", "A week has 7 days. A month has about 4 weeks."),
        ("Fill in", "How many days are in one week? _______________________"),
        ("Fill in", "If today is Wednesday, what day was it 2 days ago? _______________________"),
        ("Fill in", "If a party is in 7 days, what day of the week will it be? _______________________"),
    ]
    answers = ["7 days", "Monday", "The same day of the week as today"]
    return _text_page("Reading a Calendar", "Practice answering questions about days, weeks, and dates.",
                       blocks, "Workbook Practice · Grade 1", answers=answers)


def _two_step_directions_1():
    blocks = [
        ("Follow along", "Draw a circle, THEN put a dot inside it."),
        ("Follow along", "Write your name, THEN underline it."),
        ("Follow along", "Clap 3 times, THEN stomp 2 times."),
        ("Your turn", "Give a grown-up two directions to follow, in order."),
    ]
    return _text_page("Two-Step Directions", "Practice following directions that have two steps, in order.",
                       blocks, "Workbook Practice · Grade 1")


def _time_management_planner_5():
    blocks = [
        ("Why plan your time?", "Planning helps you finish homework, chores, and fun activities without "
                                 "feeling rushed."),
        ("List it", "Write 3 things you need to do today: _______________________"),
        ("Order it", "Number them in the order you'll do them, based on what's due soonest."),
        ("Estimate", "Next to each task, write about how many minutes it will take."),
    ]
    return _text_page("Time Management Planner", "Practice planning and prioritizing your tasks for the day.",
                       blocks, "Workbook Practice · Grade 5")


def _note_taking_cornell_method_5():
    blocks = [
        ("The Cornell Method", "Divide your paper into 3 sections: Notes (main area), Questions/Cues "
                                "(left side), Summary (bottom)."),
        ("Notes", "Write down key facts and ideas as you read or listen."),
        ("Questions/Cues", "After class, write questions in the margin that your notes answer."),
        ("Summary", "At the bottom, summarize the whole page in 1-2 sentences."),
        ("Try it", "Take notes on any topic using this method, then write a 1-sentence summary: "
                    "_______________________"),
    ]
    return _text_page("Cornell Note-Taking Method", "Learn a structured way to take and organize notes.",
                       blocks, "Workbook Practice · Grade 5")


def _percent_word_problems_5():
    probs, answers = [], []
    for _ in range(9):
        total = random.choice([20, 40, 50, 80, 100, 200])
        pct = random.choice([10, 20, 25, 50, 75])
        result = total * pct // 100
        probs.append(f"What is {pct}% of {total}?")
        answers.append(str(result))
    return _build("Percent Word Problems", "Find the percentage of each number.", probs,
                  "Workbook Practice · Grade 5", answers=answers)


def _research_skills_intro_6():
    blocks = [
        ("Reliable sources", "Look for sources written by experts, updated recently, and free of strong bias."),
        ("Evaluate it", "Is a random blog post a more or less reliable source than a museum's website? Why? "
                         "_______________________"),
        ("Practice", "Pick a topic you're curious about. Write one question you'd research: "
                      "_______________________"),
        ("Cite it", "Why is it important to write down where you found your information? "
                     "_______________________"),
    ]
    return _text_page("Research Skills Intro", "Learn how to judge whether a source is reliable, and why citing sources matters.",
                       blocks, "Workbook Practice · Grade 6")


def _goal_setting_smart_6():
    blocks = [
        ("S - Specific", "Exactly what do you want to achieve?"),
        ("M - Measurable", "How will you know when you've done it?"),
        ("A - Achievable", "Is it realistic for you right now?"),
        ("R - Relevant", "Why does this goal matter to you?"),
        ("T - Time-bound", "When will you finish it by?"),
        ("Write your goal", "Use all five parts to write one SMART goal: _______________________"),
    ]
    return _text_page("SMART Goal Setting", "Learn a five-part framework for setting goals you can actually reach.",
                       blocks, "Workbook Practice · Grade 6")


def _budgeting_basics_6():
    blocks = [
        ("Income", "Money you receive (allowance, gifts, a job)."),
        ("Expenses", "Money you spend (snacks, games, gifts for others)."),
        ("Savings", "Money you set aside instead of spending."),
        ("Try it", "If you get $20 allowance, and you plan to spend $12 and save the rest, how much will "
                    "you save? _______________________"),
        ("Reflect", "Why is it smart to save at least some money instead of spending it all? "
                     "_______________________"),
    ]
    answers = ["$8"]
    return _text_page("Budgeting Basics", "Learn the basics of income, expenses, and saving money.",
                       blocks, "Workbook Practice · Grade 6", answers=answers)


def _drawing_texture_3():
    blocks = [
        ("What is texture?", "In art, texture is how something looks like it would FEEL — rough, smooth, "
                              "bumpy, fuzzy."),
        ("Draw rough texture", "Fill a small box with short jagged lines to look rough, like tree bark."),
        ("Draw smooth texture", "Fill a small box with soft curved lines to look smooth, like water."),
        ("Draw bumpy texture", "Fill a small box with small circles to look bumpy, like an orange peel."),
        ("Combine", "Draw a simple object (a tree, a rock, a cloud) and give it real texture using these "
                     "patterns."),
    ]
    return _text_page("Drawing Texture", "Practice using line patterns to make a drawing look rough, smooth, or bumpy.",
                       blocks, "Art · Grade 3")


def _still_life_basics_3():
    blocks = [
        ("What's a still life?", "A drawing or painting of ordinary objects, like fruit or flowers, arranged "
                                  "and observed closely."),
        ("Set it up", "Gather 3 small objects (a cup, a fruit, a toy) and arrange them on a table."),
        ("Observe", "Look closely — where is the light coming from? Where are the shadows?"),
        ("Draw it", "Draw your still life, paying attention to each object's shape and size compared to the "
                     "others."),
    ]
    return _text_page("Still Life Basics", "Learn how to observe and draw a simple arrangement of everyday objects.",
                       blocks, "Art · Grade 3")


def _paper_collage_art_3():
    blocks = [
        ("What's a collage?", "Art made by gluing different materials (paper, fabric, magazine clippings) "
                               "onto a background."),
        ("Gather materials", "Find old magazines, colored paper, or scraps."),
        ("Plan it", "Decide on a theme (an animal, a landscape, a shape) before you start gluing."),
        ("Build it", "Tear or cut your materials into pieces, then arrange and glue them to build your picture."),
    ]
    return _text_page("Paper Collage Art", "Learn how to build a picture out of torn and glued paper pieces.",
                       blocks, "Art · Grade 3")


def _managing_big_emotions_6():
    blocks = [
        ("Name it", "Naming a feeling out loud can make it feel less overwhelming. Try: 'I'm feeling ___ "
                     "right now.'"),
        ("Rate it", "On a scale of 1-10, how strong is the feeling? _______________________"),
        ("Cope with it", "List one healthy way to cope: talk to someone, take a walk, write in a journal, "
                          "deep breathing."),
        ("Reflect", "Write about a recent time you managed a big emotion well. What did you do? "
                     "_______________________"),
    ]
    return _text_page("Managing Big Emotions", "Practice a simple process for naming, rating, and coping with strong feelings.",
                       blocks, "Feelings · Grade 6")


def _peer_pressure_scenarios_6():
    blocks = [
        ("What is peer pressure?", "Feeling pushed by friends or classmates to do something you might not "
                                    "choose on your own."),
        ("Scenario", "A friend wants you to skip homework to play video games. What could you say? "
                      "_______________________"),
        ("Scenario", "A group is making fun of someone, and they want you to join in. What could you say "
                      "or do? _______________________"),
        ("Reflect", "Why is it sometimes hard to say no to peer pressure, even when you know it's wrong? "
                     "_______________________"),
    ]
    return _text_page("Handling Peer Pressure", "Practice responding to situations where friends pressure you to do something.",
                       blocks, "Feelings · Grade 6")


def _self_esteem_reflection_6():
    blocks = [
        ("What is self-esteem?", "How much you value and respect yourself."),
        ("Strengths", "List 3 things you're good at or proud of: _______________________"),
        ("Reframe it", "Turn this negative thought into a kinder one: 'I'm bad at math.' -> "
                        "_______________________"),
        ("Practice", "Write one kind thing you can say to yourself the next time you make a mistake: "
                      "_______________________"),
    ]
    return _text_page("Self-Esteem Reflection", "Practice recognizing your strengths and reframing negative self-talk.",
                       blocks, "Feelings · Grade 6")


def _sorting_by_two_rules_1():
    blocks = [
        ("Sort them", "Look at these: red circle, blue square, red square, blue circle. Sort them by COLOR "
                       "first."),
        ("Red group", "_______________________"),
        ("Blue group", "_______________________"),
        ("Now sort by SHAPE", "Circles: _______________________   Squares: _______________________"),
    ]
    answers = ["Red: red circle, red square", "Blue: blue circle, blue square",
               "Circles: red circle, blue circle. Squares: red square, blue square"]
    return _text_page("Sorting by Two Rules", "Practice sorting the same group of items two different ways.",
                       blocks, "Logic · Grade 1", answers=answers)


def _what_doesnt_belong_1():
    blocks = [
        ("Which doesn't belong?", "apple, banana, carrot, orange -> _______________________"),
        ("Which doesn't belong?", "dog, cat, fish, chair -> _______________________"),
        ("Which doesn't belong?", "red, blue, happy, green -> _______________________"),
        ("Why?", "Explain your answer for the last one: _______________________"),
    ]
    answers = ["Carrot (it's a vegetable, others are fruit)", "Chair (it's furniture, others are animals)",
               "Happy (it's a feeling, others are colors)"]
    return _text_page("What Doesn't Belong?", "Find the item that doesn't fit with the others in each group.",
                       blocks, "Logic · Grade 1", answers=answers)


def _if_then_thinking_1():
    blocks = [
        ("If-then thinking", "If it's raining, THEN I should bring an umbrella."),
        ("Complete it", "If I am tired, THEN I should _______________________"),
        ("Complete it", "If the stove is hot, THEN I should NOT _______________________"),
        ("Complete it", "If my friend is sad, THEN I could _______________________"),
    ]
    return _text_page("If-Then Thinking", "Practice figuring out what should happen next, based on a situation.",
                       blocks, "Logic · Grade 1")


def _manners_in_public_4():
    blocks = [
        ("At a movie theater", "Keep your voice low and your phone off or silent."),
        ("At a restaurant", "Wait to be seated, use an inside voice, and thank the server."),
        ("On public transportation", "Offer your seat to someone who needs it more."),
        ("Practice", "Write one more public-manners rule you follow: _______________________"),
    ]
    return _text_page("Manners in Public", "Learn good manners for movie theaters, restaurants, and public transportation.",
                       blocks, "Manners · Grade 4")


def _email_and_message_etiquette_4():
    blocks = [
        ("Greeting", "Start a message politely: 'Hi Ms. Lee,' or 'Dear Grandma,'"),
        ("Clear message", "Say what you need clearly and politely, without demanding."),
        ("Closing", "End politely: 'Thank you,' or 'Sincerely,'"),
        ("Practice", "Write a polite short message asking a teacher for help with homework: "
                      "_______________________"),
    ]
    return _text_page("Email & Message Etiquette", "Learn how to write a polite, clear message or email.",
                       blocks, "Manners · Grade 4")


def _handling_mistakes_gracefully_4():
    blocks = [
        ("Own it", "Admit the mistake honestly instead of blaming someone else."),
        ("Apologize sincerely", "Say sorry and mean it — no excuses attached."),
        ("Fix it if you can", "Offer to make it right, if there's a way to."),
        ("Practice", "You accidentally broke a friend's toy. Write what you'd say and do: "
                      "_______________________"),
    ]
    return _text_page("Handling Mistakes Gracefully", "Practice owning up to a mistake and making it right.",
                       blocks, "Manners · Grade 4")


def _picture_walk_prediction_tk():
    blocks = [
        ("What's a picture walk?", "Looking at the pictures in a book BEFORE reading the words, to guess "
                                    "what it's about."),
        ("Look and guess", "Look at a book cover. What do you think the story is about? Tell a grown-up."),
        ("Check your guess", "Read the book. Was your guess close?"),
        ("Draw", "Draw your favorite picture from the book."),
    ]
    return _text_page("Picture Walk & Prediction", "Practice guessing what a story is about by looking at the pictures first.",
                       blocks, "Reading · TK")


def _parts_of_a_book_tk():
    blocks = [
        ("Front cover", "Shows the title and a picture. It's the FIRST page you see."),
        ("Back cover", "The LAST part of the book, often has a short description."),
        ("Title", "The name of the book — find it and say it out loud."),
        ("Practice", "Pick a book. Point to the front cover, the title, and the back cover."),
    ]
    return _text_page("Parts of a Book", "Learn to identify the front cover, back cover, and title of a book.",
                       blocks, "Reading · TK")


def _listening_comprehension_tk():
    blocks = [
        ("Listen to a story", "Ask a grown-up to read you a short story out loud."),
        ("Who?", "Who was the story about? _______________________"),
        ("Where?", "Where did the story happen? _______________________"),
        ("What happened?", "Tell one thing that happened in the story."),
    ]
    return _text_page("Listening Comprehension", "Practice answering simple questions about a story someone reads to you.",
                       blocks, "Reading · TK")


# ── Coverage batch 10 — closing story and phonics 2/5 combos to 5/5 ────────

def _simple_story_map_k():
    blocks = [
        ("Who?", "Who is the story about? Draw or write: _______________________"),
        ("Where?", "Where does the story happen? Draw or write: _______________________"),
        ("What happens?", "What is one thing that happens in the story? _______________________"),
        ("How does it end?", "How does the story end? _______________________"),
    ]
    return _text_page("Simple Story Map", "Fill in the four parts of a story after you hear one.",
                       blocks, "Story Activities · Kindergarten")


def _act_it_out_k():
    blocks = [
        ("Pick a story", "Choose a story you know well, like a fairy tale."),
        ("Pick a character", "Choose one character to be."),
        ("Act it out", "Act out your character's actions and voice for a grown-up."),
        ("Guess it", "Ask a family member to guess which character you're acting out."),
    ]
    return _text_page("Act It Out", "Practice acting out a character from a story you know.",
                       blocks, "Story Activities · Kindergarten")


def _story_feelings_k():
    pairs = [
        ("The wolf huffed and puffed", "angry, trying hard"), ("Cinderella cried at midnight", "sad"),
        ("The mouse squeaked with joy", "happy"), ("The kids jumped when the door creaked", "scared, surprised"),
    ]
    return _word_match_table("How Do Story Characters Feel?", "Match each story moment to the feeling the character has.",
                              pairs, "Story Activities · Kindergarten")


def _story_problem_and_solution_2():
    blocks = [
        ("What's a story problem?", "Something a character needs to solve or overcome."),
        ("Example", "Goldilocks is lost and hungry in the woods. Her problem is: _______________________"),
        ("Example", "How does she try to solve it? _______________________"),
        ("Your turn", "Think of a story you know. What was the problem, and how was it solved? "
                       "_______________________"),
    ]
    return _text_page("Story Problem & Solution", "Practice identifying a character's problem and how it gets solved.",
                       blocks, "Story Activities · Grade 2")


def _setting_details_2():
    blocks = [
        ("What's a setting?", "WHERE and WHEN a story happens."),
        ("Describe it", "Picture a story set in a spooky castle at midnight. List 3 details you might see: "
                         "_______________________"),
        ("Describe it", "Picture a story set on a sunny beach in summer. List 3 details you might see: "
                         "_______________________"),
        ("Your turn", "Invent your own setting and describe it in 2 sentences: _______________________"),
    ]
    return _text_page("Setting Details", "Practice imagining and describing where and when a story takes place.",
                       blocks, "Story Activities · Grade 2")


def _retelling_with_5_fingers_2():
    blocks = [
        ("Thumb", "Characters — who is in the story?"),
        ("Pointer", "Setting — where and when does it happen?"),
        ("Middle", "Problem — what goes wrong?"),
        ("Ring", "Events — what happens to try to fix it?"),
        ("Pinky", "Solution — how does it end?"),
        ("Try it", "Use your hand to retell a story you know to a family member!"),
    ]
    return _text_page("Five-Finger Retell", "Use your hand to remember the five parts of retelling a story.",
                       blocks, "Story Activities · Grade 2")


def _comic_strip_story_3():
    blocks = [
        ("Plan it", "Draw 4 boxes on a piece of paper — that's your comic strip."),
        ("Box 1", "Introduce your character and setting."),
        ("Box 2", "Something happens — the problem starts."),
        ("Box 3", "Your character tries to solve it."),
        ("Box 4", "How does it end? Add a funny or surprising twist!"),
    ]
    return _text_page("Comic Strip Story", "Plan a four-panel comic strip with a beginning, problem, and ending.",
                       blocks, "Story Activities · Grade 3")


def _story_theme_intro_3():
    blocks = [
        ("What's a theme?", "The BIG lesson or message a story teaches, not just what happens."),
        ("Example", "In 'The Tortoise and the Hare,' the events are a race. The THEME is: slow and steady "
                     "wins the race."),
        ("Try it", "Think of a story you know. What is one event? _______________________"),
        ("Try it", "What is the theme (the lesson)? _______________________"),
    ]
    return _text_page("Story Theme", "Practice telling the difference between what happens and the lesson a story teaches.",
                       blocks, "Story Activities · Grade 3")


def _alternate_ending_3():
    blocks = [
        ("Pick a story", "Choose a story you know well."),
        ("The real ending", "Write how the story actually ends: _______________________"),
        ("Your new ending", "Write a different, surprising ending: _______________________"),
        ("Compare", "Which ending do you like better, and why? _______________________"),
    ]
    return _text_page("Write an Alternate Ending", "Practice rewriting the ending of a story you already know.",
                       blocks, "Story Activities · Grade 3")


def _setting_the_scene_4():
    blocks = [
        ("Why setting matters", "A great setting can create mood — spooky, cheerful, mysterious, peaceful."),
        ("Spooky setting", "Describe a spooky setting in 2-3 sentences: _______________________"),
        ("Cheerful setting", "Describe a cheerful setting in 2-3 sentences: _______________________"),
        ("Your choice", "Pick a mood, then describe a setting that matches it: _______________________"),
    ]
    return _text_page("Setting the Scene", "Practice writing settings that create a specific mood.",
                       blocks, "Story Activities · Grade 4")


def _conflict_types_4():
    pairs = [
        ("Character vs. Character", "two characters are in conflict, like two rivals"),
        ("Character vs. Self", "a character struggles with their own fear or doubt"),
        ("Character vs. Nature", "a character struggles against weather, animals, or the wild"),
        ("Character vs. Society", "a character struggles against rules or people's expectations"),
    ]
    return _word_match_table("Types of Story Conflict", "Match each type of conflict to its description.",
                              pairs, "Story Activities · Grade 4")


def _story_mountain_planner_4():
    blocks = [
        ("Beginning (bottom of mountain)", "Introduce your character and setting."),
        ("Climbing up", "Things start to go wrong — the problem grows."),
        ("Top of the mountain", "The most exciting moment — the climax!"),
        ("Coming down", "Things start to get resolved."),
        ("Bottom (the end)", "How does your story end?"),
    ]
    return _text_page("Story Mountain Planner", "Plan your story using the shape of a mountain: build up, peak, and come down.",
                       blocks, "Story Activities · Grade 4")


def _foreshadowing_intro_5():
    blocks = [
        ("What is foreshadowing?", "A hint early in a story about something that will happen later."),
        ("Example", "A character notices dark clouds before a storm ruins the picnic. That's foreshadowing!"),
        ("Spot it", "Write one small hint you could put early in a story about a character who will get "
                     "lost: _______________________"),
        ("Try it", "Write 2 sentences that foreshadow a surprise ending, without giving it away: "
                    "_______________________"),
    ]
    return _text_page("Foreshadowing", "Learn how authors hint at what's coming later in a story.",
                       blocks, "Story Activities · Grade 5")


def _point_of_view_5():
    pairs = [
        ("First person", "the narrator IS a character, using 'I' and 'me'"),
        ("Third person limited", "the narrator knows only one character's thoughts, using 'he/she'"),
        ("Third person omniscient", "the narrator knows ALL characters' thoughts and feelings"),
    ]
    return _word_match_table("Point of View", "Match each point of view to how the narrator tells the story.",
                              pairs, "Story Activities · Grade 5")


def _dynamic_vs_static_characters_5():
    blocks = [
        ("Dynamic character", "Changes in an important way by the end of the story."),
        ("Static character", "Stays basically the same throughout the story."),
        ("Analyze", "Think of a story you know. Name one dynamic character and how they changed: "
                     "_______________________"),
        ("Analyze", "Name one static character from a story you know: _______________________"),
    ]
    return _text_page("Dynamic vs. Static Characters", "Learn the difference between characters who change and those who stay the same.",
                       blocks, "Story Activities · Grade 5")


def _vowel_teams_2():
    pairs = [
        ("ai", "makes the long A sound, like in rain"), ("ee", "makes the long E sound, like in tree"),
        ("oa", "makes the long O sound, like in boat"), ("ea", "makes the long E sound, like in leaf"),
    ]
    return _word_match_table("Vowel Teams", "Match each vowel team to the sound it makes.",
                              pairs, "Phonics · Grade 2")


def _soft_c_and_g_2():
    blocks = [
        ("Soft C", "When C is followed by e, i, or y, it sounds like S: city, cent, cycle."),
        ("Hard C", "Otherwise, C sounds like K: cat, cup, cost."),
        ("Soft G", "When G is followed by e, i, or y, it often sounds like J: giant, gem, gym."),
        ("Sort it", "Circle the words with a SOFT c or g: race, gas, giraffe, cot, gym, cut."),
    ]
    answers = ["Soft: race, giraffe, gym"]
    return _text_page("Soft C and Soft G", "Learn when C and G make their soft sounds instead of their hard sounds.",
                       blocks, "Phonics · Grade 2", answers=answers)


def _compound_word_building_2():
    pairs = [
        ("sun + flower", "sunflower"), ("back + pack", "backpack"),
        ("rain + coat", "raincoat"), ("butter + fly", "butterfly"),
    ]
    return _word_match_table("Building Compound Words", "Match each pair of small words to the compound word they make.",
                              pairs, "Phonics · Grade 2")


def _roots_bio_tele_aqua_photo_4():
    pairs = [
        ("bio-", "means 'life' — biology is the study of life"),
        ("tele-", "means 'far' — telephone sends sound far away"),
        ("aqua-", "means 'water' — an aquarium holds water animals"),
        ("photo-", "means 'light' — a photograph is made with light"),
    ]
    return _word_match_table("Roots: Bio, Tele, Aqua, Photo", "Match each word root to what it means.",
                              pairs, "Phonics · Grade 4")


def _homophones_4():
    pairs = [
        ("their / there / they're", "belonging to them / a place / they are"),
        ("to / too / two", "toward / also or excessive / the number 2"),
        ("your / you're", "belonging to you / you are"), ("its / it's", "belonging to it / it is"),
    ]
    return _word_match_table("Tricky Homophones", "Match each set of homophones to what each word means.",
                              pairs, "Phonics · Grade 4")


def _syllable_types_4():
    blocks = [
        ("Closed syllable", "Ends in a consonant, short vowel sound: cat, nap."),
        ("Open syllable", "Ends in a vowel, long vowel sound: go, hi."),
        ("Silent-e syllable", "Ends in silent e, long vowel sound: cake, time."),
        ("Sort it", "Sort these words: sit, no, bike, hop, she, cute -> Closed: ___ Open: ___ Silent-e: ___"),
    ]
    answers = ["Closed: sit, hop", "Open: no, she", "Silent-e: bike, cute"]
    return _text_page("Syllable Types", "Learn three types of syllables and how they change a vowel's sound.",
                       blocks, "Phonics · Grade 4", answers=answers)


def _prefixes_advanced_5():
    pairs = [
        ("inter-", "means 'between' — international means between nations"),
        ("trans-", "means 'across' — transport means to carry across"),
        ("micro-", "means 'small' — microscope helps see small things"),
        ("mis-", "means 'wrongly' — misspell means to spell wrongly"),
    ]
    return _word_match_table("Advanced Prefixes", "Match each prefix to its meaning.",
                              pairs, "Phonics · Grade 5")


def _word_origins_5():
    blocks = [
        ("Etymology", "The study of where words come from."),
        ("Latin roots", "Many English words come from Latin, like 'dictionary' from 'dicere' (to speak)."),
        ("Greek roots", "Many science words come from Greek, like 'photograph' from 'phos' (light) + "
                         "'graphein' (to write)."),
        ("Try it", "Look up (or guess) where the word 'television' comes from. Write what you find: "
                    "_______________________"),
    ]
    return _text_page("Where Words Come From", "Learn how English words often come from Latin or Greek roots.",
                       blocks, "Phonics · Grade 5")


def _spelling_patterns_5():
    blocks = [
        ("The rule", "'I' before 'E' except after 'C', or when it sounds like 'AY' as in neighbor and weigh."),
        ("Sort it", "believe, receive, eight, friend -> which follow the rule normally (i before e)? "
                     "_______________________"),
        ("Sort it", "which are exceptions (after c, or sounds like ay)? _______________________"),
        ("Tricky ones", "Some words break the rule anyway, like 'weird' and 'science' — just memorize those!"),
    ]
    answers = ["Normal: believe, friend", "Exceptions: receive (after c), eight (sounds like ay)"]
    return _text_page("Spelling Patterns: I Before E", "Learn the i-before-e rule and its exceptions.",
                       blocks, "Phonics · Grade 5", answers=answers)


def _silent_letters_6():
    pairs = [
        ("kn-", "silent k, like in knee and knife"), ("wr-", "silent w, like in write and wrong"),
        ("gh", "often silent, like in night and light"), ("mb", "silent b, like in comb and thumb"),
    ]
    return _word_match_table("Silent Letters", "Match each silent-letter pattern to an example word.",
                              pairs, "Phonics · Grade 6")


def _stress_and_syllables_6():
    blocks = [
        ("What is stress?", "The syllable you say LOUDER or LONGER in a word."),
        ("Example", "RE-cord (noun, a thing) vs re-CORD (verb, to record). Same spelling, different stress!"),
        ("Try it", "Say 'PRE-sent' (a gift) and 'pre-SENT' (to give a speech) out loud. Notice the difference."),
        ("Practice", "Write one more word that changes meaning based on which syllable is stressed: "
                      "_______________________"),
    ]
    return _text_page("Word Stress & Syllables", "Learn how stressing a different syllable can change a word's meaning.",
                       blocks, "Phonics · Grade 6")


def _commonly_confused_words_6():
    pairs = [
        ("affect / effect", "affect is usually a verb (to influence); effect is usually a noun (a result)"),
        ("accept / except", "accept means to receive; except means excluding"),
        ("than / then", "than compares things; then shows time or sequence"),
        ("lose / loose", "lose means to not have anymore; loose means not tight"),
    ]
    return _word_match_table("Commonly Confused Words", "Match each word pair to how they're different.",
                              pairs, "Phonics · Grade 6")


# ── Coverage batch 11 — closing the last 2/5 combos to 5/5 ──────────────────

def _landscape_layers_5():
    blocks = [
        ("Foreground", "The part of a landscape closest to you — biggest and most detailed."),
        ("Middle ground", "The middle area — medium-sized, less detailed."),
        ("Background", "The farthest part — smallest, blurriest, often includes the sky and horizon."),
        ("Practice", "Draw a simple landscape with all three layers: a big tree in front, a hill in the "
                      "middle, and mountains far away."),
    ]
    return _text_page("Landscape Layers", "Learn how foreground, middle ground, and background create depth in a landscape.",
                       blocks, "Art · Grade 5")


def _proportion_and_scale_5():
    blocks = [
        ("What is proportion?", "How the size of one part relates to another part, or to the whole."),
        ("Example", "A person's head is usually about 1/7 to 1/8 of their total height."),
        ("Practice", "Draw a simple person, checking that the head isn't too big or too small compared to "
                      "the body."),
        ("Compare", "Which is bigger in real life: an elephant or a mouse? How would you show that "
                     "difference in a drawing? _______________________"),
    ]
    return _text_page("Proportion & Scale", "Learn how artists use proportion to make drawings look realistic.",
                       blocks, "Art · Grade 5")


def _printmaking_basics_5():
    blocks = [
        ("What is printmaking?", "Creating a design on one surface (like a stamp), then pressing it onto "
                                  "paper to make a print."),
        ("Simple printmaking", "Cut a shape out of a sponge or eraser, dip it in paint, and stamp it onto "
                                "paper."),
        ("Pattern", "Use your stamp to create a repeating pattern across the page."),
        ("Reflect", "Why might an artist want to make many copies of the same image using a stamp? "
                     "_______________________"),
    ]
    return _text_page("Printmaking Basics", "Learn the basics of stamping and repeating a design to create a print.",
                       blocks, "Art · Grade 5")


def _calm_down_toolkit_k():
    items = [
        "Take 3 deep breaths", "Count to 5 slowly", "Give myself a hug",
        "Ask for a hug from a grown-up", "Squeeze a soft pillow",
    ]
    return _checklist("My Calm-Down Toolkit", "Check off calming strategies you can try when you feel upset.",
                       items, "Feelings · Kindergarten")


def _feelings_and_faces_k():
    pairs = [
        ("Smiling, bright eyes", "happy"), ("Tears, quiet", "sad"),
        ("Frowning, red face", "angry"), ("Wide eyes, open mouth", "surprised"),
    ]
    return _word_match_table("Feelings and Faces", "Match each face description to the feeling word.",
                              pairs, "Feelings · Kindergarten")


def _kind_words_i_can_say_k():
    blocks = [
        ("When someone is sad", "Say: 'Are you okay?' or 'I'm here for you.'"),
        ("When someone shares", "Say: 'Thank you!' or 'That's so nice of you.'"),
        ("When someone is scared", "Say: 'It's okay, I'll stay with you.'"),
        ("Practice", "Pick one kind phrase above and say it out loud to a family member today."),
    ]
    return _text_page("Kind Words I Can Say", "Learn kind phrases to say to help a friend feel better.",
                       blocks, "Feelings · Kindergarten")


def _feelings_journal_prompts_3():
    blocks = [
        ("Prompt 1", "Write about a time you felt proud of yourself: _______________________"),
        ("Prompt 2", "Write about a time you felt nervous, and what helped: _______________________"),
        ("Prompt 3", "Write about a time a friend made you feel happy: _______________________"),
        ("Reflect", "Why can writing about feelings help you understand them better?"),
    ]
    return _text_page("Feelings Journal Prompts", "Practice writing about your feelings using guided prompts.",
                       blocks, "Feelings · Grade 3")


def _feeling_word_upgrade_3():
    pairs = [
        ("mad", "furious, irritated, or annoyed — which one fits best?"),
        ("sad", "disappointed, heartbroken, or gloomy — which one fits best?"),
        ("happy", "thrilled, content, or cheerful — which one fits best?"),
        ("scared", "nervous, terrified, or uneasy — which one fits best?"),
    ]
    return _word_match_table("Feeling Word Upgrade", "Practice choosing a more specific word instead of a basic feeling word.",
                              pairs, "Feelings · Grade 3")


def _problem_size_and_reaction_3():
    blocks = [
        ("Small problem", "Losing a game, forgetting a pencil. Reaction should be SMALL — shrug it off, try again."),
        ("Medium problem", "A friend is upset with you, you fail a quiz. Reaction should be MEDIUM — talk it "
                            "out, ask for help."),
        ("Big problem", "Someone is hurt, a real emergency. Reaction should be BIG — get a grown-up right away."),
        ("Sort it", "Spilling juice on your shirt is a ___ problem. _______________________"),
    ]
    answers = ["Small problem"]
    return _text_page("Problem Size & Reaction Size", "Practice matching the size of your reaction to the size of the problem.",
                       blocks, "Feelings · Grade 3", answers=answers)


def _feelings_have_names_1():
    pairs = [
        ("Jealous", "wishing you had what someone else has"), ("Proud", "feeling good about something you did"),
        ("Frustrated", "feeling stuck or annoyed when something is hard"),
        ("Lonely", "feeling alone or wishing you had someone with you"),
    ]
    return _word_match_table("Feelings Have Names", "Match each feeling word to what it means.",
                              pairs, "Feelings · Grade 1")


def _what_makes_me_feel_1():
    blocks = [
        ("Happy", "Write one thing that makes you feel happy: _______________________"),
        ("Sad", "Write one thing that makes you feel sad: _______________________"),
        ("Proud", "Write one thing that makes you feel proud: _______________________"),
        ("Share it", "Tell a family member about one of your answers."),
    ]
    return _text_page("What Makes Me Feel...", "Reflect on what causes different feelings for you.",
                       blocks, "Feelings · Grade 1")


def _calm_down_choices_1():
    items = [
        "Take slow, deep breaths", "Squeeze my hands tight, then let go", "Ask for a hug",
        "Take a break in a quiet spot", "Talk to a grown-up about it",
    ]
    return _checklist("Calm-Down Choices", "Check off the calming strategies you know how to use.",
                       items, "Feelings · Grade 1")


def _logic_grid_simple_2():
    blocks = [
        ("Clues",
         "1. Three friends — Mia, Leo, and Zoe — each have one pet: a bird, a rabbit, or a turtle.<br/>"
         "2. Mia's pet can fly.<br/>"
         "3. Leo's pet is NOT slow."),
        ("Your grid — mark YES or NO",
         "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bird&nbsp;&nbsp;Rabbit&nbsp;&nbsp;Turtle<br/>"
         "Mia&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___<br/>"
         "Leo&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___<br/>"
         "Zoe&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;___&nbsp;&nbsp;&nbsp;&nbsp;___"),
    ]
    answers = ["Mia -> Bird", "Leo -> Rabbit", "Zoe -> Turtle"]
    return _text_page("Logic Grid: Pet Pals", "Use the clues to figure out which friend owns which pet.",
                       blocks, "Logic · Grade 2", answers=answers)


def _guess_my_number_2():
    blocks = [
        ("Clue game", "I'm thinking of a number. It's more than 10 and less than 20. It's an even number. "
                       "It has a 4 in it. What is it? _______________________"),
        ("Clue game", "I'm thinking of a number. It's more than 50 and less than 60. If you add its two "
                       "digits, you get 11. What is it? _______________________"),
        ("Your turn", "Write your own 'guess my number' clues for a friend to solve."),
    ]
    answers = ["14", "56"]
    return _text_page("Guess My Number", "Use number clues to figure out the mystery number.",
                       blocks, "Logic · Grade 2", answers=answers)


def _true_for_all_or_some_2():
    blocks = [
        ("All or Some?", "All dogs are animals. Is this true for ALL dogs or SOME dogs? _______________________"),
        ("All or Some?", "Some fruits are red. Is this true for ALL fruits or SOME fruits? _______________________"),
        ("All or Some?", "All squares have 4 sides. Is this true for ALL squares or SOME squares? "
                          "_______________________"),
        ("Your turn", "Write your own 'ALL' statement and your own 'SOME' statement."),
    ]
    answers = ["ALL dogs", "SOME fruits", "ALL squares"]
    return _text_page("True for All, or Just Some?", "Practice telling the difference between statements that are always true and sometimes true.",
                       blocks, "Logic · Grade 2", answers=answers)


def _deductive_reasoning_6():
    blocks = [
        ("What's deductive reasoning?", "Starting with general facts to reach a specific, certain conclusion."),
        ("Example", "All birds have feathers. A robin is a bird. So a robin has feathers."),
        ("Try it", "All mammals are warm-blooded. A whale is a mammal. What can you conclude? "
                    "_______________________"),
        ("Try it", "Write your own two-fact deduction, then state the conclusion: _______________________"),
    ]
    answers = ["A whale is warm-blooded"]
    return _text_page("Deductive Reasoning", "Practice drawing certain conclusions from two true facts.",
                       blocks, "Logic · Grade 6", answers=answers)


def _logical_fallacies_intro_6():
    blocks = [
        ("What's a logical fallacy?", "A flaw in reasoning that makes an argument weak, even if it sounds "
                                       "convincing."),
        ("Example", "'Everyone is doing it, so it must be right.' This ignores whether it's ACTUALLY right."),
        ("Spot it", "'You're wrong because you're just a kid.' What's wrong with this argument? "
                     "_______________________"),
        ("Spot it", "'If we allow one exception, soon EVERYTHING will fall apart.' What's wrong with this "
                     "argument? _______________________"),
    ]
    answers = ["Attacks the person, not the idea (age doesn't determine if an idea is right)",
               "Assumes an extreme outcome without evidence (a 'slippery slope')"]
    return _text_page("Logical Fallacies Intro", "Learn to spot flawed reasoning in arguments.",
                       blocks, "Logic · Grade 6", answers=answers)


def _advanced_logic_grid_6():
    blocks = [
        ("Clues",
         "1. Four teams — Red, Blue, Green, Yellow — finished a race in 1st, 2nd, 3rd, and 4th place.<br/>"
         "2. Red did not finish first or last.<br/>"
         "3. Blue finished right before Green.<br/>"
         "4. Yellow finished last."),
        ("Work it out", "Use the clues to figure out the exact order, 1st through 4th: "
                         "_______________________"),
    ]
    answers = ["1st: Blue, 2nd: Green, 3rd: Red, 4th: Yellow"]
    return _text_page("Advanced Logic Grid: Race Results", "Use the clues to figure out the exact finishing order of four teams.",
                       blocks, "Logic · Grade 6", answers=answers)


def _conflict_manners_5():
    blocks = [
        ("Stay calm", "Take a breath before responding when you're upset with someone."),
        ("Use respectful words", "Avoid name-calling or yelling, even when frustrated."),
        ("Listen to understand", "Let the other person explain their side before reacting."),
        ("Practice", "Write a respectful way to tell a friend they hurt your feelings: "
                      "_______________________"),
    ]
    return _text_page("Manners During a Conflict", "Learn how to stay respectful even when you disagree with someone.",
                       blocks, "Manners · Grade 5")


def _manners_with_technology_5():
    blocks = [
        ("At the table", "Keep phones and devices away during meals and conversations."),
        ("In group chats", "Don't spam, gossip, or leave people out on purpose."),
        ("Gaming online", "Be a good sport — no trash talk or cheating."),
        ("Practice", "Write one rule you think is important for using technology politely: "
                      "_______________________"),
    ]
    return _text_page("Manners with Technology", "Learn polite habits for phones, group chats, and online gaming.",
                       blocks, "Manners · Grade 5")


def _including_others_5():
    blocks = [
        ("Why it matters", "Nobody likes to feel left out — including others makes everyone feel valued."),
        ("Practice", "You see someone sitting alone at lunch. What could you do or say? "
                      "_______________________"),
        ("Practice", "A new student just joined your class. How could you help them feel welcome? "
                      "_______________________"),
        ("Reflect", "Write about a time someone included YOU when you felt left out. How did it feel?"),
    ]
    return _text_page("Including Others", "Practice noticing when someone feels left out, and including them.",
                       blocks, "Manners · Grade 5")


def _classroom_manners_3():
    items = [
        "Raise my hand before speaking", "Listen when someone else is talking", "Keep my workspace neat",
        "Wait my turn in line", "Use an inside voice",
    ]
    return _checklist("Classroom Manners", "Check off each classroom manner as you practice it.",
                       items, "Manners · Grade 3")


def _borrowing_and_returning_3():
    blocks = [
        ("Asking to borrow", "Say 'May I borrow your ___?' instead of just taking it."),
        ("Taking care of it", "Use borrowed things carefully, like they're your own."),
        ("Returning it", "Give it back in the same or better condition, and say thank you."),
        ("Practice", "Write what you'd say to ask a friend to borrow a pencil: _______________________"),
    ]
    return _text_page("Borrowing & Returning Politely", "Learn the polite steps for borrowing something from someone.",
                       blocks, "Manners · Grade 3")


def _manners_with_siblings_3():
    blocks = [
        ("Sharing space", "Knock before entering a sibling's room."),
        ("Sharing things", "Ask before using a sibling's belongings."),
        ("Solving arguments", "Use calm words instead of yelling when you disagree."),
        ("Practice", "Write one way you can be kinder to a sibling or family member this week: "
                      "_______________________"),
    ]
    return _text_page("Manners with Siblings", "Practice respectful habits for sharing space and things at home.",
                       blocks, "Manners · Grade 3")


def _area_and_perimeter_3():
    blocks = [
        ("Perimeter", "The distance around the OUTSIDE of a shape. Add up all the sides."),
        ("Area", "The space INSIDE a shape. For a rectangle: length times width."),
        ("Find it", "A rectangle is 5 units long and 3 units wide. What is its perimeter? "
                     "_______________________"),
        ("Find it", "What is its area? _______________________"),
    ]
    answers = ["Perimeter: 16 units (5+5+3+3)", "Area: 15 square units (5 x 3)"]
    return _text_page("Area & Perimeter", "Practice finding the area and perimeter of a rectangle.",
                       blocks, "Math · Grade 3", answers=answers)


def _division_intro_3():
    probs, answers = [], []
    for _ in range(12):
        b = random.randint(2, 9)
        result = random.randint(2, 9)
        a = b * result
        probs.append(f"{a} / {b} = ___")
        answers.append(str(result))
    return _build("Division Basics", "Divide each number evenly.", probs, "Math · Grade 3", answers=answers)


def _telling_time_to_the_minute_3():
    blocks = [
        ("Reading the clock", "The short hand shows the hour. The long hand shows the minutes."),
        ("Read it", "If the long hand points to the 3, how many minutes past the hour is it? "
                     "_______________________"),
        ("Read it", "If the long hand points to the 9, how many minutes past the hour is it? "
                     "_______________________"),
        ("Elapsed time", "If it's 2:15 now, what time will it be in 45 minutes? _______________________"),
    ]
    answers = ["15 minutes", "45 minutes", "3:00"]
    return _text_page("Telling Time to the Minute", "Practice reading a clock and calculating elapsed time.",
                       blocks, "Math · Grade 3", answers=answers)


def _making_inferences_3():
    blocks = [
        ("What's an inference?", "A smart guess using clues from the text PLUS what you already know."),
        ("Clue", "Sam grabbed his umbrella and rain boots before leaving. What can you infer? "
                  "_______________________"),
        ("Clue", "Mia's stomach growled loudly during class. What can you infer? _______________________"),
        ("Your turn", "Write one sentence that gives a clue, then ask a friend to make an inference."),
    ]
    answers = ["It's probably raining outside", "Mia is probably hungry"]
    return _text_page("Making Inferences", "Practice using clues to make a smart guess about what's happening.",
                       blocks, "Reading · Grade 3", answers=answers)


def _summarizing_a_story_3():
    blocks = [
        ("What's a summary?", "A short retelling of the MOST IMPORTANT parts of a story, in your own words."),
        ("Steps", "Include: who, what happened, and how it ended. Leave out small details."),
        ("Practice", "Pick a story you know well. Summarize it in 2-3 sentences: _______________________"),
        ("Check yourself", "Did you keep it short? Did you include the most important parts?"),
    ]
    return _text_page("Summarizing a Story", "Practice retelling a story's most important parts in just a few sentences.",
                       blocks, "Reading · Grade 3")


def _text_features_nonfiction_3():
    pairs = [
        ("Heading", "tells you what a section is about"), ("Caption", "explains what a picture or photo shows"),
        ("Bold word", "a word that's extra important or new"),
        ("Table of Contents", "lists the chapters and their page numbers"),
    ]
    return _word_match_table("Nonfiction Text Features", "Match each text feature to what it does.",
                              pairs, "Reading · Grade 3")


def _beginning_middle_end_1():
    blocks = [
        ("Beginning", "Introduces the characters and setting."),
        ("Middle", "The main event happens — something exciting or a problem."),
        ("End", "How the story finishes."),
        ("Practice", "Think of a story you know. Write one sentence for the beginning, one for the middle, "
                      "and one for the end."),
    ]
    return _text_page("Beginning, Middle, End", "Practice breaking a story into its three main parts.",
                       blocks, "Reading · Grade 1")


def _predicting_what_happens_next_1():
    blocks = [
        ("What's a prediction?", "A guess about what will happen next, based on clues."),
        ("Story so far", "A boy plants a seed and waters it every day."),
        ("Predict", "What do you think will happen next? _______________________"),
        ("Story so far", "A girl studies hard for her spelling test all week."),
        ("Predict", "What do you think will happen next? _______________________"),
    ]
    return _text_page("Predicting What Happens Next", "Practice guessing what will happen next in a story, using clues.",
                       blocks, "Reading · Grade 1")


def _who_what_where_1():
    blocks = [
        ("Read this", "Ben and his dog Max played fetch at the park on a sunny day."),
        ("Who?", "Who is the story about? _______________________"),
        ("What?", "What did they do? _______________________"),
        ("Where?", "Where did it happen? _______________________"),
    ]
    answers = ["Ben and Max", "Played fetch", "At the park"]
    return _text_page("Who, What, Where?", "Practice answering simple questions about a short passage.",
                       blocks, "Reading · Grade 1", answers=answers)


def _theme_vs_topic_4():
    blocks = [
        ("Topic", "What the story is ABOUT (in a few words). Example: friendship."),
        ("Theme", "The LESSON or message about that topic. Example: True friends stick together even when "
                   "it's hard."),
        ("Practice", "Name the topic of a book you've read: _______________________"),
        ("Practice", "What is the theme (the lesson) of that book? _______________________"),
    ]
    return _text_page("Theme vs. Topic", "Practice telling the difference between a story's topic and its theme.",
                       blocks, "Reading · Grade 4")


def _comparing_two_texts_4():
    blocks = [
        ("Pick two texts", "Choose two books or articles about a similar topic."),
        ("How are they alike?", "List one way they're similar: _______________________"),
        ("How are they different?", "List one way they're different: _______________________"),
        ("Which did you prefer?", "Explain why: _______________________"),
    ]
    return _text_page("Comparing Two Texts", "Practice comparing and contrasting two different texts on a similar topic.",
                       blocks, "Reading · Grade 4")


def _authors_word_choice_4():
    blocks = [
        ("Why word choice matters", "Authors pick specific words to create a feeling or picture in your mind."),
        ("Compare", "'The dog walked slowly' vs. 'The dog trudged wearily.' Which paints a clearer picture? "
                     "Why? _______________________"),
        ("Find it", "Find a sentence in a book you're reading with a strong, specific word choice. Write it "
                     "here: _______________________"),
        ("Explain", "Why did the author choose that word instead of a simpler one? _______________________"),
    ]
    return _text_page("Author's Word Choice", "Practice noticing how specific word choices affect a reader's imagination.",
                       blocks, "Reading · Grade 4")


# ── Coverage batch 12 — the final 3 stragglers, finishing the backlog ──────

def _life_cycle_of_a_frog_2():
    blocks = [
        ("Egg", "Frogs start as eggs laid in water."),
        ("Tadpole", "The egg hatches into a tadpole, which swims and breathes with gills."),
        ("Froglet", "The tadpole grows legs and starts to look like a small frog."),
        ("Adult Frog", "The froglet becomes a full-grown frog that can live on land and in water."),
        ("Order them", "Number these 1-4: ___ Tadpole   ___ Egg   ___ Adult Frog   ___ Froglet"),
    ]
    answers = ["Egg = 1, Tadpole = 2, Froglet = 3, Adult Frog = 4"]
    return _text_page("Life Cycle of a Frog", "Learn and order the four stages of a frog's life.",
                       blocks, "Science · Grade 2", answers=answers)


def _magnet_push_pull_2():
    blocks = [
        ("What magnets do", "Magnets can push (repel) or pull (attract) certain metal objects."),
        ("True or False?", "A magnet can pick up a paperclip without touching it.  True  or  False?"),
        ("True or False?", "A magnet can pick up a piece of paper.  True  or  False?"),
        ("Try it", "Name one object in your house that a magnet could stick to: _______________________"),
    ]
    answers = ["1. True", "2. False"]
    return _text_page("Magnets: Push and Pull", "Learn how magnets attract and repel objects.",
                       blocks, "Science · Grade 2", answers=answers)


def _weather_tools_2():
    pairs = [
        ("Thermometer", "measures how hot or cold it is"), ("Rain gauge", "measures how much rain fell"),
        ("Wind vane", "shows which direction the wind is blowing"),
        ("Umbrella", "keeps you dry when it's raining"),
    ]
    return _word_match_table("Weather Tools", "Match each weather tool to what it does.",
                              pairs, "Science · Grade 2")


def _animal_groups_2():
    blocks = [
        ("Mammals", "Have fur or hair, and feed their babies milk. Example: dogs, humans."),
        ("Birds", "Have feathers and lay eggs. Example: robins, eagles."),
        ("Fish", "Live in water and breathe through gills. Example: salmon, goldfish."),
        ("Sort it", "Which group does a whale belong to? (Hint: it breathes air and feeds its babies milk!) "
                     "_______________________"),
    ]
    answers = ["Mammal"]
    return _text_page("Animal Groups", "Learn about three groups of animals: mammals, birds, and fish.",
                       blocks, "Science · Grade 2", answers=answers)


def _states_of_matter_particles_5():
    blocks = [
        ("Solid", "Particles are packed tightly and vibrate in place — that's why solids keep their shape."),
        ("Liquid", "Particles are close but can slide past each other — that's why liquids flow and take "
                    "the shape of their container."),
        ("Gas", "Particles are spread far apart and move freely — that's why gases expand to fill any space."),
        ("Explain", "Why does a gas take up more space than the same amount of matter as a liquid? "
                     "_______________________"),
    ]
    answers = ["Because gas particles are spread far apart and move freely, unlike liquid particles which "
               "stay close together"]
    return _text_page("States of Matter: How Particles Move", "Learn how particle movement explains solids, liquids, and gases.",
                       blocks, "Science · Grade 5", answers=answers)


def _photosynthesis_5():
    blocks = [
        ("What is photosynthesis?", "The process plants use to make their own food using sunlight."),
        ("What plants need", "Sunlight, water, and carbon dioxide (from the air)."),
        ("What plants make", "Glucose (sugar, for food) and oxygen (released into the air)."),
        ("Fill in", "Photosynthesis happens mostly in a plant's ___. (Hint: the green parts) "
                     "_______________________"),
    ]
    answers = ["Leaves"]
    return _text_page("Photosynthesis", "Learn how plants make their own food using sunlight, water, and air.",
                       blocks, "Science · Grade 5", answers=answers)


def _simple_circuits_5():
    blocks = [
        ("What is a circuit?", "A complete loop that electricity can flow through."),
        ("Parts of a circuit", "A power source (battery), wires, and something that uses the electricity "
                                "(a bulb)."),
        ("Open vs. Closed", "A CLOSED circuit is complete, so electricity flows and the bulb lights up. An "
                             "OPEN circuit has a break, so it doesn't."),
        ("Explain", "Why does flipping a light switch off stop the light from working? "
                     "_______________________"),
    ]
    answers = ["It opens the circuit, breaking the loop so electricity can't flow"]
    return _text_page("Simple Circuits", "Learn how a complete circuit lets electricity flow to power a light.",
                       blocks, "Science · Grade 5", answers=answers)


def _weathering_and_erosion_5():
    pairs = [
        ("Weathering", "the breaking down of rock into smaller pieces, by wind, water, or ice"),
        ("Erosion", "the moving of broken-down rock and soil from one place to another"),
        ("Deposition", "when moved rock and soil settle in a new place"),
        ("Glacier", "a huge, slow-moving sheet of ice that can carve valleys"),
    ]
    return _word_match_table("Weathering & Erosion", "Match each Earth-science term to its definition.",
                              pairs, "Science · Grade 5")


def _editing_for_run_ons_3():
    blocks = [
        ("What's a run-on sentence?", "Two or more complete sentences joined together without correct "
                                       "punctuation."),
        ("Run-on", "I like dogs I have two of them."),
        ("Fix it", "Rewrite it correctly, using a period or the word 'and': _______________________"),
        ("Run-on", "The rain stopped we went outside to play."),
        ("Fix it", "Rewrite it correctly: _______________________"),
    ]
    answers = ["I like dogs. I have two of them.", "The rain stopped, and we went outside to play."]
    return _text_page("Fixing Run-On Sentences", "Practice breaking run-on sentences into correct, complete sentences.",
                       blocks, "Writing · Grade 3", answers=answers)


def _writing_a_book_report_3():
    blocks = [
        ("Title & Author", "Write the title and author of a book you've read: _______________________"),
        ("Main Characters", "Who are the main characters? _______________________"),
        ("Summary", "What happens in the book? Write 2-3 sentences: _______________________"),
        ("Opinion", "Did you like it? Why or why not? _______________________"),
    ]
    return _text_page("Writing a Book Report", "Practice summarizing and reviewing a book you've read.",
                       blocks, "Writing · Grade 3")


def _using_strong_adjectives_3():
    pairs = [
        ("nice", "could be replaced with: kind, generous, thoughtful"),
        ("big", "could be replaced with: enormous, gigantic, massive"),
        ("good", "could be replaced with: excellent, wonderful, fantastic"),
        ("bad", "could be replaced with: terrible, awful, dreadful"),
    ]
    return _word_match_table("Stronger Word Choices", "Practice swapping overused adjectives for more specific ones.",
                              pairs, "Writing · Grade 3")


def _writing_directions_3():
    blocks = [
        ("Why order matters", "When writing directions, steps must be in the correct order or they won't "
                               "make sense."),
        ("Use sequence words", "First, next, then, after that, finally."),
        ("Try it", "Write step-by-step directions for making a sandwich, using at least 4 sequence words: "
                    "_______________________"),
        ("Check yourself", "Could someone follow your directions exactly, without skipping a step?"),
    ]
    return _text_page("Writing Clear Directions", "Practice writing step-by-step directions in the correct order.",
                       blocks, "Writing · Grade 3")


# ── Weekly Packets — dynamic multi-page packet by grade + week ─────────────
# Each packet mixes a randomised drill page, original themed word problems, a
# pattern/number-sense page, and a word-play page into ONE combined PDF —
# generated fresh (new random numbers) on every request, in the spirit of
# commercial weekly-practice packets but with entirely original, hand-written
# content and layout (see lsh.database/41_weekly_packets.sql for the initial
# grade/week rollout).

def _packet_section(story, styles, heading, subheading=None):
    from reportlab.platypus import Paragraph, PageBreak, HRFlowable
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib import colors
    from reportlab.lib.enums import TA_CENTER
    story.append(PageBreak())
    story.append(Paragraph(heading, ParagraphStyle("psh", parent=styles["Heading2"], fontSize=15,
                                                     textColor=colors.HexColor("#5b4fcf"), alignment=TA_CENTER,
                                                     spaceAfter=4)))
    if subheading:
        story.append(Paragraph(subheading, ParagraphStyle("pss", parent=styles["Normal"], fontSize=10.5,
                                                            textColor=colors.gray, alignment=TA_CENTER, spaceAfter=10)))
    story.append(HRFlowable(width="100%", thickness=1, color=colors.HexColor("#e5e7eb"), spaceAfter=12))


_PACKET_THEMES_G1 = {
    "farm": {
        "label": "Farm Friends", "chars": ["Josie", "Mateo", "Priya"], "place": "the barn",
        "start_label": "COOP", "finish_label": "BARN", "ops": ["+", "+", "-", "+"],
        "problems": [
            "{c1} collected {a} eggs in the morning and {b} more in the afternoon. How many eggs did {c1} collect in all? ___",
            "There were {a} chickens in {place}. {b} more chickens wandered in. How many chickens are in {place} now? ___",
            "{c2} had {a} carrots to feed the goats. The goats ate {b} of them. How many carrots are left? ___",
            "{c3} counted {a} sheep in the field, then {b} more came from the barn. How many sheep in all? ___",
        ],
    },
    "space": {
        "label": "Space Explorers", "chars": ["Amir", "Luna", "Devon"], "place": "the spaceship",
        "start_label": "MOON", "finish_label": "SHIP", "ops": ["+", "+", "-", "+"],
        "problems": [
            "{c1} spotted {a} stars through the telescope, then {b} more. How many stars in all? ___",
            "There were {a} astronauts aboard {place}. {b} more joined for the mission. How many astronauts now? ___",
            "{c2} packed {a} space snacks for the trip but already ate {b} of them. How many are left? ___",
            "{c3} saw {a} moons near a planet, then {b} more came into view. How many moons in all? ___",
        ],
    },
    "bakery": {
        "label": "Bakery Bunch", "chars": ["Nora", "Sam", "Elena"], "place": "the bakery",
        "start_label": "MIXER", "finish_label": "OVEN", "ops": ["+", "+", "-", "+"],
        "problems": [
            "{c1} baked {a} cupcakes in the morning and {b} more in the afternoon. How many cupcakes in all? ___",
            "There were {a} loaves of bread in {place}. {b} more came out of the oven. How many loaves now? ___",
            "{c2} had {a} cookies on a tray. {b} of them were sold. How many cookies are left? ___",
            "{c3} counted {a} muffins, then frosted {b} more. How many muffins in all? ___",
        ],
    },
}


def _number_bond_drawing(total, known):
    from reportlab.graphics.shapes import Drawing, Circle, Line, String
    from reportlab.lib import colors
    from reportlab.lib.units import inch
    PURPLE = colors.HexColor("#5b4fcf")
    w, h = 1.7 * inch, 1.35 * inch
    d = Drawing(w, h)
    tx, ty = w / 2, h - 0.24 * inch
    lx, ly = 0.34 * inch, 0.26 * inch
    rx, ry = w - 0.34 * inch, 0.26 * inch
    d.add(Line(tx, ty, lx, ly, strokeColor=PURPLE, strokeWidth=1.3))
    d.add(Line(tx, ty, rx, ry, strokeColor=PURPLE, strokeWidth=1.3))
    d.add(Circle(tx, ty, 0.23 * inch, strokeColor=PURPLE, strokeWidth=1.5, fillColor=colors.white))
    d.add(String(tx, ty - 5, str(total), textAnchor="middle", fontSize=13, fontName="Kalam-Bold"))
    d.add(Circle(lx, ly, 0.21 * inch, strokeColor=PURPLE, strokeWidth=1.5, fillColor=colors.white))
    d.add(String(lx, ly - 5, str(known), textAnchor="middle", fontSize=12, fontName="Kalam-Bold"))
    d.add(Circle(rx, ry, 0.21 * inch, strokeColor=PURPLE, strokeWidth=1.5, fillColor=colors.white))
    return d


def _number_bonds_page():
    """Returns (table_flowable, answers) — answers is the missing part for
    each of the 6 bonds, in reading order (left-to-right, top-to-bottom)."""
    from reportlab.platypus import Table, TableStyle
    from reportlab.lib.units import inch

    drawings, answers = [], []
    for _ in range(6):
        total = random.randint(6, 12)
        known = random.randint(1, total - 1)
        drawings.append(_number_bond_drawing(total, known))
        answers.append(str(total - known))
    t = Table([drawings[0:3], drawings[3:6]], colWidths=[2.1 * inch] * 3, rowHeights=[1.55 * inch] * 2)
    t.setStyle(TableStyle([("ALIGN", (0, 0), (-1, -1), "CENTER"), ("VALIGN", (0, 0), (-1, -1), "MIDDLE")]))
    return t, answers


def _clock_drawing(hour, minute, size=1.5):
    from reportlab.graphics.shapes import Drawing, Circle, Line, String
    from reportlab.lib import colors
    from reportlab.lib.units import inch
    import math

    r = size * inch / 2
    d = Drawing(size * inch, size * inch)
    cx = cy = size * inch / 2
    d.add(Circle(cx, cy, r - 2, strokeColor=colors.black, strokeWidth=1.5, fillColor=colors.white))
    for n in range(1, 13):
        ang = math.radians(90 - n * 30)
        tx, ty = cx + (r - 14) * math.cos(ang), cy + (r - 14) * math.sin(ang)
        d.add(String(tx, ty - 4, str(n), textAnchor="middle", fontSize=8, fontName="Kalam-Bold"))
    minute_ang = math.radians(90 - minute / 60 * 360)
    hour_ang = math.radians(90 - ((hour % 12) + minute / 60) / 12 * 360)
    d.add(Line(cx, cy, cx + (r * 0.85) * math.cos(minute_ang), cy + (r * 0.85) * math.sin(minute_ang),
                strokeColor=colors.black, strokeWidth=1.5))
    d.add(Line(cx, cy, cx + (r * 0.55) * math.cos(hour_ang), cy + (r * 0.55) * math.sin(hour_ang),
                strokeColor=colors.black, strokeWidth=2.2))
    d.add(Circle(cx, cy, 2.5, fillColor=colors.black))
    return d


def _clock_reading_page():
    """Returns (table_flowable, answers) — answers are "H:MM" strings for
    the 4 clocks, in reading order."""
    from reportlab.platypus import Table, TableStyle, Paragraph
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch

    times = [(random.randint(1, 12), random.choice([0, 15, 30, 45])) for _ in range(4)]
    answers = [f"{h}:{m:02d}" for h, m in times]
    clocks = [_clock_drawing(h, m) for h, m in times]
    label_style = ParagraphStyle("cl", fontSize=10.5, alignment=1, spaceBefore=4, fontName="Kalam")
    labels = [Paragraph("What time does this clock show? ___:___", label_style) for _ in times]
    rows = [[clocks[0], clocks[1]], [labels[0], labels[1]], [clocks[2], clocks[3]], [labels[2], labels[3]]]
    t = Table(rows, colWidths=[3.1 * inch] * 2)
    t.setStyle(TableStyle([("ALIGN", (0, 0), (-1, -1), "CENTER"), ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
                           ("TOPPADDING", (0, 0), (-1, -1), 6), ("BOTTOMPADDING", (0, 0), (-1, -1), 10)]))
    return t, answers


def _color_path_puzzle(start_label, finish_label, target_a, target_b, rows=6, cols=6):
    from reportlab.platypus import Paragraph, Table, TableStyle
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors

    path = {(0, 0)}
    r = c = 0
    while (r, c) != (rows - 1, cols - 1):
        opts = []
        if r < rows - 1:
            opts.append("d")
        if c < cols - 1:
            opts.append("r")
        if random.choice(opts) == "d":
            r += 1
        else:
            c += 1
        path.add((r, c))

    other_diffs = [d for d in range(1, 11) if d not in (target_a, target_b)]
    cell_style = ParagraphStyle("pc", fontSize=11, alignment=1, leading=13, fontName="Kalam")
    end_style = ParagraphStyle("pe", fontSize=9.5, alignment=1, leading=11, fontName="Kalam-Bold")
    rows_data = []
    for rr in range(rows):
        row_cells = []
        for cc in range(cols):
            if (rr, cc) == (0, 0):
                row_cells.append(Paragraph(f"<b>{start_label}</b>", end_style))
            elif (rr, cc) == (rows - 1, cols - 1):
                row_cells.append(Paragraph(f"<b>{finish_label}</b>", end_style))
            else:
                diff = random.choice([target_a, target_b]) if (rr, cc) in path else random.choice(other_diffs)
                b = random.randint(0, 10 - diff)
                a = b + diff
                row_cells.append(Paragraph(f"{a}<br/>- {b}", cell_style))
        rows_data.append(row_cells)

    col_w = 6.5 / cols
    t = Table(rows_data, colWidths=[col_w * inch] * cols, rowHeights=[0.62 * inch] * rows)
    t.setStyle(TableStyle([
        ("GRID", (0, 0), (-1, -1), 0.75, colors.HexColor("#999")),
        ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
        ("ALIGN", (0, 0), (-1, -1), "CENTER"),
    ]))
    return t


def _weekly_packet_word_problems(theme_key):
    """Returns (lines, answers) for the 4 themed word problems."""
    theme = _PACKET_THEMES_G1[theme_key]
    c1, c2, c3 = theme["chars"]
    lines, answers = [], []
    for i, tmpl in enumerate(theme["problems"]):
        a = random.randint(4, 12)
        b = random.randint(2, 8)
        text = tmpl.format(a=a, b=b, c1=c1, c2=c2, c3=c3, place=theme["place"])
        lines.append(f"{i+1}.  {text}")
        answers.append(str(a + b) if theme["ops"][i] == "+" else str(a - b))
    return lines, answers


def _answer_key_block(story, styles, day_title, answers):
    from reportlab.platypus import Paragraph
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib import colors

    story.append(Paragraph(day_title, ParagraphStyle("akh", parent=styles["Heading3"], fontSize=12.5,
                                                       textColor=colors.HexColor("#5b4fcf"), spaceBefore=10, spaceAfter=4)))
    ans_text = "&nbsp;&nbsp;&nbsp;&nbsp;".join(f"{i+1}. {a}" for i, a in enumerate(answers))
    story.append(Paragraph(ans_text, ParagraphStyle("aka", parent=styles["Normal"], fontSize=11, leading=19)))


def _weekly_packet_g1(week_of_label: str, theme_key: str):
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib import colors

    theme = _PACKET_THEMES_G1[theme_key]
    target_a, target_b = random.sample(range(2, 8), 2)
    answer_key = []  # list of (day_title, [answers]) — rendered on the final page
    buf, doc, story, styles = _doc("1st Grade Weekly Packet", f"Week of {week_of_label}  ·  Theme: {theme['label']}")

    story.append(Paragraph("This week you'll practice:", ParagraphStyle("cvh", parent=styles["Heading3"],
                                                                          fontSize=13, spaceAfter=8)))
    for sk in ["Addition & subtraction to 20", "Word problems", "Number patterns & skip counting",
               "Number bonds", "Telling time", "A color-path logic puzzle", "Sight-word word play"]:
        story.append(Paragraph(f"[ ]  {sk}", ParagraphStyle("sk", parent=styles["Normal"], fontSize=12, leading=20)))
    story.append(Spacer(1, 10))
    story.append(Paragraph(
        "Complete one page a day, Monday through Thursday, then finish with Friday's wrap-up. "
        "Ask a grown-up to check your work when you're done!",
        ParagraphStyle("cvb", parent=styles["Normal"], fontSize=11, leading=17, textColor=colors.gray)))

    _packet_section(story, styles, "Day 1 -- Addition & Subtraction",
                     "Solve each problem. Go for accuracy first, then speed!")
    probs, day1_answers = [], []
    for _ in range(9):
        a, b = random.randint(1, 12), random.randint(1, 12)
        while a + b > 20:
            a, b = random.randint(1, 12), random.randint(1, 12)
        probs.append(f"{a} + {b} = ___")
        day1_answers.append(str(a + b))
    for _ in range(6):
        a = random.randint(5, 20)
        b = random.randint(0, a)
        probs.append(f"{a} - {b} = ___")
        day1_answers.append(str(a - b))
    _problem_grid(story, styles, probs, cols=3, col_w=2.1)
    answer_key.append(("Day 1 -- Addition & Subtraction", day1_answers))

    _packet_section(story, styles, "Day 2 -- Word Problems",
                     f"This week's theme: {theme['label']}. Read carefully, then solve.")
    wp_lines, day2_answers = _weekly_packet_word_problems(theme_key)
    for line in wp_lines:
        story.append(Paragraph(line, ParagraphStyle("wp", parent=styles["Normal"], fontSize=12.5, leading=22, spaceAfter=10)))
    answer_key.append(("Day 2 -- Word Problems", day2_answers))

    _packet_section(story, styles, "Day 3 -- Patterns & Number Sense",
                     "Find the rule, then fill in the missing numbers.")
    s2, s5, s10 = random.randint(1, 5), random.randint(1, 4), random.randint(1, 3)
    back_start = random.randint(15, 20)
    pattern_probs = [
        f"Count by 2s: {s2}, {s2+2}, {s2+4}, ___, ___, ___",
        f"Count by 5s: {s5*5}, {s5*5+5}, {s5*5+10}, ___, ___, ___",
        f"Count by 10s: {s10*10}, {s10*10+10}, {s10*10+20}, ___, ___, ___",
        "Shape pattern: triangle, circle, triangle, circle, triangle, ___, ___  (draw the next two shapes)",
        f"Count backward by 1s from {back_start}: ___, ___, ___, ___, ___",
    ]
    _problem_grid(story, styles, pattern_probs, cols=1, col_w=6.5)
    day3_answers = [
        f"{s2+6}, {s2+8}, {s2+10}",
        f"{s5*5+15}, {s5*5+20}, {s5*5+25}",
        f"{s10*10+30}, {s10*10+40}, {s10*10+50}",
        "circle, triangle",
        ", ".join(str(n) for n in range(back_start - 1, back_start - 6, -1)),
    ]
    answer_key.append(("Day 3 -- Patterns & Number Sense", day3_answers))

    _packet_section(story, styles, "Day 4 -- Number Bonds",
                     "Each tree shows a total and one part. Write the missing part in the empty circle.")
    bonds_table, day4_answers = _number_bonds_page()
    story.append(bonds_table)
    answer_key.append(("Day 4 -- Number Bonds", day4_answers))

    _packet_section(story, styles, "Day 5 -- Telling Time",
                     "Read each clock, then write the time on the line.")
    clocks_table, day5_answers = _clock_reading_page()
    story.append(clocks_table)
    answer_key.append(("Day 5 -- Telling Time", day5_answers))

    _packet_section(story, styles, "Day 6 -- Path Puzzle",
                     f"Solve each subtraction problem. Circle every box with an answer of {target_a} or "
                     f"{target_b} to draw a path from {theme['start_label']} to {theme['finish_label']}.")
    story.append(_color_path_puzzle(theme["start_label"], theme["finish_label"], target_a, target_b))
    answer_key.append(("Day 6 -- Path Puzzle", [f"Circle every answer of {target_a} or {target_b} — "
                                                 f"those boxes trace the path from {theme['start_label']} to {theme['finish_label']}."]))

    _packet_section(story, styles, "Day 7 -- Word Play",
                     "Unscramble each sight word, then write a sentence using it.")
    picks = random.sample(["said", "they", "with", "have", "from", "were"], 4)
    wp_rows = []
    for w in picks:
        letters = list(w)
        random.shuffle(letters)
        while "".join(letters) == w:
            random.shuffle(letters)
        wp_rows.append(f"{'-'.join(letters).upper()}   ->   ___________")
    _problem_grid(story, styles, wp_rows, cols=1, col_w=6.5)
    answer_key.append(("Day 7 -- Word Play", picks))

    _packet_section(story, styles, "Day 8 -- Weekly Wrap-Up",
                     "Check off each activity, then celebrate finishing the week!")
    for activity in ["Addition & Subtraction", "Word Problems", "Patterns & Number Sense", "Number Bonds",
                      "Telling Time", "Path Puzzle", "Word Play"]:
        story.append(Paragraph(f"[ ]  {activity} -- I did my best!", ParagraphStyle("wd", parent=styles["Normal"],
                                                                                     fontSize=12, leading=22)))
    story.append(Spacer(1, 8))
    story.append(Paragraph("What was your favorite page this week, and why? _______________________",
                            ParagraphStyle("refl", parent=styles["Normal"], fontSize=11.5, leading=18, spaceBefore=6)))

    _packet_section(story, styles, "Answer Key",
                     "For grown-ups — check your scholar's work against these answers.")
    for day_title, answers in answer_key:
        _answer_key_block(story, styles, day_title, answers)

    _footer(story, styles, f"Weekly Packet - Grade 1 - Week of {week_of_label}", stars=5)
    doc.build(story)
    return buf.getvalue()


def _weekly_packet_g1_w1():
    return _weekly_packet_g1("Aug 10, 2026", "farm")


def _weekly_packet_g1_w2():
    return _weekly_packet_g1("Aug 17, 2026", "space")


def _weekly_packet_g1_w3():
    return _weekly_packet_g1("Aug 24, 2026", "bakery")


GENERATORS = {
    "add_to_10":            _addition_to_10,
    "number_bonds_20":      _number_bonds_20,
    "subtract_2digit":      _subtract_2digit,
    "drill_subtraction":    _drill_subtraction,
    "drill_multiplication": _drill_multiplication,
    "long_multiplication":  _long_multiplication,
    "long_division":        _long_division,
    "bar_model_ratios":     _bar_model_ratios,
    "prealgebra_variables": _prealgebra_variables,
    "ratios_proportions":   _ratios_proportions,
    "trace_numbers_1_10":   _trace_numbers_1_10,
    "drill_addition_10":    _drill_addition_10,

    # TK
    "trace_letters_az":       _trace_letters_az,
    "beginning_sounds_smt":   _beginning_sounds_smt,
    "numbers_minibook":       _numbers_minibook,
    "draw_unicorn":           _draw_unicorn,
    "draw_trex":              _draw_trex,
    "draw_flower":            _draw_flower,
    # K
    "draw_shark":             _draw_shark,
    "sight_words_1":          _sight_words_1,
    "pinyin_four_tones":      _pinyin_four_tones,
    "decodable_sam_cat":      _decodable_sam_cat,
    "minibook_i_see_cat":     _minibook_i_see_cat,
    # 1st
    "draw_race_car":              _draw_race_car,
    "letras_primeras_palabras":   _letras_primeras_palabras,
    "short_vowel_sounds":         _short_vowel_sounds,
    "sight_words_2":              _sight_words_2,
    "pinyin_tone_practice":       _pinyin_tone_practice,
    "minibook_family_story":      _minibook_family_story,
    "tangshi_quiet_night":        _tangshi_quiet_night,
    # 2nd
    "draw_castle":                    _draw_castle,
    "rangoli_geometry":               _rangoli_geometry,
    "calm_down_cards":                _calm_down_cards,
    "gita_values":                    _gita_values,
    "tangshi_quiet_night_minibook":   _tangshi_quiet_night_minibook,
    "cursive_az_trace":               _cursive_az_trace,
    # 3rd
    "garden_mandala":         _garden_mandala,
    "flor_nochebuena":        _flor_nochebuena,
    "pattern_power_3":        _pattern_power_3,
    "chess_pawns":            _chess_pawns,
    "cursive_letter_pack":    _cursive_letter_pack,
    # 4th
    "papel_picado":              _papel_picado,
    "empathy_scenarios":         _empathy_scenarios,
    "gita_little_lamp":          _gita_little_lamp,
    "logic_grid_pets":           _logic_grid_pets,
    "persuasive_essay_frame":    _persuasive_essay_frame,
    # 5th
    "one_point_perspective":  _one_point_perspective,
    "sudoku_6x6":              _sudoku_6x6,
    "theme_tone_reading":      _theme_tone_reading,
    # 6th
    "greek_latin_roots":       _greek_latin_roots,
    "tangshi_capstone_20":     _tangshi_capstone_20,
    "argument_essay_frame":    _argument_essay_frame,

    # ── Coverage batch 1 ──
    "subtraction_hop_10":        _subtraction_hop_10,
    "fraction_fundamentals":     _fraction_fundamentals,
    "ratios_percents_6":         _ratios_percents_6,
    "rhyming_words_match":       _rhyming_words_match,
    "silent_e_magic":            _silent_e_magic,
    "draw_happy_sun":            _draw_happy_sun,
    "draw_rocket_ship":          _draw_rocket_ship,
    "pattern_detective_3":       _pattern_detective_3,
    "phonics_word_chunking_6":   _phonics_word_chunking_6,
    "write_your_own_fable":      _write_your_own_fable,
    "story_starters_mystery":    _story_starters_mystery,
    "build_a_story_character":   _build_a_story_character,
    "compare_contrast_habitats": _compare_contrast_habitats,
    "main_idea_details_2":       _main_idea_details_2,
    "story_sequence_1":          _story_sequence_1,
    "practice_pack_tk":          _practice_pack_tk,
    "practice_pack_k":           _practice_pack_k,
    "practice_pack_1":           _practice_pack_1,
    "practice_pack_5":           _practice_pack_5,

    # ── Coverage batch 2 ──
    "cvc_word_building":          _cvc_word_building,
    "digraph_detectives":         _digraph_detectives,
    "retell_beginning_middle_end": _retell_beginning_middle_end,
    "picture_clue_riddles":       _picture_clue_riddles,
    "cause_effect_storm":         _cause_effect_storm,
    "authors_purpose_practice":   _authors_purpose_practice,
    "inference_practice_6":       _inference_practice_6,
    "summarizing_nonfiction_6":   _summarizing_nonfiction_6,
    "shapes_and_counting_k":      _shapes_and_counting_k,
    "more_or_less_10":            _more_or_less_10,
    "count_and_match_5":          _count_and_match_5,
    "big_and_small_sorting":      _big_and_small_sorting,
    "skip_counting_2_5_10":       _skip_counting_2_5_10,
    "telling_time_half_hour":     _telling_time_half_hour,
    "draw_butterfly":             _draw_butterfly,
    "draw_your_family":           _draw_your_family,
    "draw_rainbow":                _draw_rainbow,
    "draw_spaceship":             _draw_spaceship,
    "silly_mad_libs":             _silly_mad_libs,
    "my_weekend_story":           _my_weekend_story,
    "practice_pack_2_week1":      _practice_pack_2_week1,
    "practice_pack_2_week2":      _practice_pack_2_week2,
    "odd_one_out_4":              _odd_one_out_4,
    "code_breaker_cipher":        _code_breaker_cipher,
    "good_manners_checklist_tk":  _good_manners_checklist_tk,
    "sharing_taking_turns":       _sharing_taking_turns,
    "saying_sorry_right_way":     _saying_sorry_right_way,

    # ── Coverage batch 3 ──
    "feelings_vocabulary_builder":     _feelings_vocabulary_builder,
    "feelings_body_language_clues":    _feelings_body_language_clues,
    "feelings_thermometer":            _feelings_thermometer,
    "feelings_match_face_word":        _feelings_match_face_word,
    "logic_grid_library_mystery":      _logic_grid_library_mystery,
    "number_sequence_detective_5":     _number_sequence_detective_5,
    "table_manners_checklist":         _table_manners_checklist,
    "polite_words_match":              _polite_words_match,
    "tracing_polite_words":            _tracing_polite_words,
    "kind_or_unkind_circle":           _kind_or_unkind_circle,
    "good_listener_checklist":         _good_listener_checklist,
    "manners_at_the_table":            _manners_at_the_table,
    "outline_a_topic":                 _outline_a_topic,
    "multi_step_word_problems_4":      _multi_step_word_problems_4,
    "flashcard_maker_study_skills":    _flashcard_maker_study_skills,
    "multiplication_fact_fluency_drill": _multiplication_fact_fluency_drill,

    # ── Coverage batch 4 — Science & Writing ──
    "five_senses_match":              _five_senses_match,
    "living_or_nonliving_tk":         _living_or_nonliving_tk,
    "four_seasons_match":             _four_seasons_match,
    "what_plants_need_k":             _what_plants_need_k,
    "solids_liquids_true_false_1":    _solids_liquids_true_false_1,
    "day_and_night_match_1":          _day_and_night_match_1,
    "butterfly_life_cycle":           _butterfly_life_cycle,
    "simple_machines_match_3":        _simple_machines_match_3,
    "forms_of_energy_match":          _forms_of_energy_match,
    "forest_food_chain":              _forest_food_chain,
    "cell_parts_match_6":             _cell_parts_match_6,
    "physical_vs_chemical_change_6":  _physical_vs_chemical_change_6,
    "label_the_picture_tk":           _label_the_picture_tk,
    "trace_first_sight_words":        _trace_first_sight_words,
    "writing_simple_sentences_k":     _writing_simple_sentences_k,
    "capital_letter_period_check":    _capital_letter_period_check,
    "sentence_types_practice":        _sentence_types_practice,
    "descriptive_words_practice":     _descriptive_words_practice,
    "story_elements_planner":         _story_elements_planner,
    "using_adjectives_2":             _using_adjectives_2,
    "paragraph_structure_intro":      _paragraph_structure_intro,
    "transition_words_match":         _transition_words_match,
    "show_dont_tell_practice":        _show_dont_tell_practice,
    "strong_verbs_swap":              _strong_verbs_swap,
    "writing_process_steps":          _writing_process_steps,
    "figurative_language_id":         _figurative_language_id,

    # ── Coverage batch 5 ──
    "color_wheel_basics":                     _color_wheel_basics,
    "symmetry_line_art":                      _symmetry_line_art,
    "shading_techniques_practice":             _shading_techniques_practice,
    "conflict_resolution_steps":               _conflict_resolution_steps,
    "emotional_triggers_reflection":           _emotional_triggers_reflection,
    "empathy_perspective_taking_5":            _empathy_perspective_taking_5,
    "same_or_different_tk":                    _same_or_different_tk,
    "what_comes_next_tk":                      _what_comes_next_tk,
    "which_one_is_different_tk":               _which_one_is_different_tk,
    "digital_manners_6":                       _digital_manners_6,
    "respectful_disagreement_6":               _respectful_disagreement_6,
    "cultural_respect_manners_6":               _cultural_respect_manners_6,
    "factors_and_multiples_4":                 _factors_and_multiples_4,
    "fraction_basics_4":                       _fraction_basics_4,
    "multi_digit_multiplication_word_problems_4": _multi_digit_multiplication_word_problems_4,
    "r_controlled_vowels_3":                   _r_controlled_vowels_3,
    "prefixes_suffixes_3":                     _prefixes_suffixes_3,
    "compound_words_contractions_3":           _compound_words_contractions_3,
    "context_clues_2":                         _context_clues_2,
    "fact_or_opinion_2":                       _fact_or_opinion_2,
    "story_sequencing_2":                      _story_sequencing_2,
    "plot_diagram_6":                          _plot_diagram_6,
    "character_motivation_6":                  _character_motivation_6,
    "write_a_plot_twist_6":                    _write_a_plot_twist_6,

    # ── Coverage batch 6 ──
    "weather_types_tk":               _weather_types_tk,
    "hot_or_cold_tk":                 _hot_or_cold_tk,
    "animal_babies_match_tk":         _animal_babies_match_tk,
    "things_that_float_or_sink_k":    _things_that_float_or_sink_k,
    "animal_habitats_match_k":        _animal_habitats_match_k,
    "day_sky_night_sky_k":            _day_sky_night_sky_k,
    "animal_body_coverings_1":        _animal_body_coverings_1,
    "push_or_pull_1":                 _push_or_pull_1,
    "plant_parts_and_jobs_1":         _plant_parts_and_jobs_1,
    "rock_types_match_3":             _rock_types_match_3,
    "states_of_matter_changes_3":     _states_of_matter_changes_3,
    "animal_adaptations_3":           _animal_adaptations_3,
    "writing_shapes_practice_tk":     _writing_shapes_practice_tk,
    "my_favorite_things_tk":          _my_favorite_things_tk,
    "family_members_labels_tk":       _family_members_labels_tk,
    "writing_about_pictures_k":       _writing_about_pictures_k,
    "using_and_in_lists_k":           _using_and_in_lists_k,
    "labeling_a_scene_k":             _labeling_a_scene_k,
    "writing_exclamations_1":         _writing_exclamations_1,
    "friendly_letter_basics_1":       _friendly_letter_basics_1,
    "sequence_words_1":               _sequence_words_1,
    "informational_writing_intro_2":  _informational_writing_intro_2,
    "similes_intro_2":                _similes_intro_2,
    "writing_a_thank_you_note_2":     _writing_a_thank_you_note_2,

    # ── Coverage batch 7 ──
    "ecosystems_intro_4":             _ecosystems_intro_4,
    "earth_layers_4":                 _earth_layers_4,
    "magnets_and_forces_4":           _magnets_and_forces_4,
    "human_body_systems_6":           _human_body_systems_6,
    "newtons_laws_intro_6":           _newtons_laws_intro_6,
    "ecosystem_energy_pyramid_6":     _ecosystem_energy_pyramid_6,
    "compare_contrast_writing_4":     _compare_contrast_writing_4,
    "strong_openings_4":              _strong_openings_4,
    "editing_marks_practice_4":       _editing_marks_practice_4,
    "writing_dialogue_5":             _writing_dialogue_5,
    "sensory_details_5":              _sensory_details_5,
    "thesis_statement_practice_5":    _thesis_statement_practice_5,
    "essay_structure_recap_6":        _essay_structure_recap_6,
    "active_vs_passive_voice_6":      _active_vs_passive_voice_6,
    "citing_evidence_6":              _citing_evidence_6,

    # ── Coverage batch 8 ──
    "shape_tracing_tk":               _shape_tracing_tk,
    "matching_shapes_tk":             _matching_shapes_tk,
    "following_directions_tk":        _following_directions_tk,
    "writing_numbers_words_k":        _writing_numbers_words_k,
    "calendar_basics_k":              _calendar_basics_k,
    "measuring_with_objects_k":       _measuring_with_objects_k,
    "value_scale_practice_6":         _value_scale_practice_6,
    "composition_rule_of_thirds_6":   _composition_rule_of_thirds_6,
    "warm_cool_colors_6":             _warm_cool_colors_6,
    "naming_basic_feelings_tk":       _naming_basic_feelings_tk,
    "how_do_you_feel_today_tk":       _how_do_you_feel_today_tk,
    "calm_down_breathing_tk":         _calm_down_breathing_tk,
    "sorting_by_one_rule_k":          _sorting_by_one_rule_k,
    "first_second_third_k":           _first_second_third_k,
    "true_or_false_logic_k":          _true_or_false_logic_k,
    "phone_manners_2":                _phone_manners_2,
    "being_a_good_sport_2":           _being_a_good_sport_2,
    "manners_with_guests_2":          _manners_with_guests_2,
    "ending_sounds_k":                _ending_sounds_k,
    "rhyming_pairs_k":                _rhyming_pairs_k,
    "short_a_words_k":                _short_a_words_k,
    "finish_the_story_tk":            _finish_the_story_tk,
    "puppet_show_prompts_tk":         _puppet_show_prompts_tk,
    "story_order_pictures_tk":        _story_order_pictures_tk,

    # ── Coverage batch 9 ──
    "counting_coins_1":               _counting_coins_1,
    "reading_a_simple_calendar_1":    _reading_a_simple_calendar_1,
    "two_step_directions_1":          _two_step_directions_1,
    "time_management_planner_5":      _time_management_planner_5,
    "note_taking_cornell_method_5":   _note_taking_cornell_method_5,
    "percent_word_problems_5":        _percent_word_problems_5,
    "research_skills_intro_6":        _research_skills_intro_6,
    "goal_setting_smart_6":           _goal_setting_smart_6,
    "budgeting_basics_6":             _budgeting_basics_6,
    "drawing_texture_3":              _drawing_texture_3,
    "still_life_basics_3":            _still_life_basics_3,
    "paper_collage_art_3":            _paper_collage_art_3,
    "managing_big_emotions_6":        _managing_big_emotions_6,
    "peer_pressure_scenarios_6":      _peer_pressure_scenarios_6,
    "self_esteem_reflection_6":       _self_esteem_reflection_6,
    "sorting_by_two_rules_1":         _sorting_by_two_rules_1,
    "what_doesnt_belong_1":           _what_doesnt_belong_1,
    "if_then_thinking_1":             _if_then_thinking_1,
    "manners_in_public_4":            _manners_in_public_4,
    "email_and_message_etiquette_4":  _email_and_message_etiquette_4,
    "handling_mistakes_gracefully_4": _handling_mistakes_gracefully_4,
    "picture_walk_prediction_tk":     _picture_walk_prediction_tk,
    "parts_of_a_book_tk":             _parts_of_a_book_tk,
    "listening_comprehension_tk":     _listening_comprehension_tk,

    # ── Coverage batch 10 ──
    "simple_story_map_k":             _simple_story_map_k,
    "act_it_out_k":                   _act_it_out_k,
    "story_feelings_k":               _story_feelings_k,
    "story_problem_and_solution_2":   _story_problem_and_solution_2,
    "setting_details_2":              _setting_details_2,
    "retelling_with_5_fingers_2":     _retelling_with_5_fingers_2,
    "comic_strip_story_3":            _comic_strip_story_3,
    "story_theme_intro_3":            _story_theme_intro_3,
    "alternate_ending_3":             _alternate_ending_3,
    "setting_the_scene_4":            _setting_the_scene_4,
    "conflict_types_4":               _conflict_types_4,
    "story_mountain_planner_4":       _story_mountain_planner_4,
    "foreshadowing_intro_5":          _foreshadowing_intro_5,
    "point_of_view_5":                _point_of_view_5,
    "dynamic_vs_static_characters_5": _dynamic_vs_static_characters_5,
    "vowel_teams_2":                  _vowel_teams_2,
    "soft_c_and_g_2":                 _soft_c_and_g_2,
    "compound_word_building_2":       _compound_word_building_2,
    "roots_bio_tele_aqua_photo_4":    _roots_bio_tele_aqua_photo_4,
    "homophones_4":                   _homophones_4,
    "syllable_types_4":               _syllable_types_4,
    "prefixes_advanced_5":            _prefixes_advanced_5,
    "word_origins_5":                 _word_origins_5,
    "spelling_patterns_5":            _spelling_patterns_5,
    "silent_letters_6":               _silent_letters_6,
    "stress_and_syllables_6":         _stress_and_syllables_6,
    "commonly_confused_words_6":      _commonly_confused_words_6,

    # ── Coverage batch 11 ──
    "landscape_layers_5":             _landscape_layers_5,
    "proportion_and_scale_5":         _proportion_and_scale_5,
    "printmaking_basics_5":           _printmaking_basics_5,
    "calm_down_toolkit_k":            _calm_down_toolkit_k,
    "feelings_and_faces_k":           _feelings_and_faces_k,
    "kind_words_i_can_say_k":         _kind_words_i_can_say_k,
    "feelings_journal_prompts_3":     _feelings_journal_prompts_3,
    "feeling_word_upgrade_3":         _feeling_word_upgrade_3,
    "problem_size_and_reaction_3":    _problem_size_and_reaction_3,
    "feelings_have_names_1":          _feelings_have_names_1,
    "what_makes_me_feel_1":           _what_makes_me_feel_1,
    "calm_down_choices_1":            _calm_down_choices_1,
    "logic_grid_simple_2":            _logic_grid_simple_2,
    "guess_my_number_2":              _guess_my_number_2,
    "true_for_all_or_some_2":         _true_for_all_or_some_2,
    "deductive_reasoning_6":          _deductive_reasoning_6,
    "logical_fallacies_intro_6":      _logical_fallacies_intro_6,
    "advanced_logic_grid_6":          _advanced_logic_grid_6,
    "conflict_manners_5":             _conflict_manners_5,
    "manners_with_technology_5":      _manners_with_technology_5,
    "including_others_5":             _including_others_5,
    "classroom_manners_3":            _classroom_manners_3,
    "borrowing_and_returning_3":      _borrowing_and_returning_3,
    "manners_with_siblings_3":        _manners_with_siblings_3,
    "area_and_perimeter_3":           _area_and_perimeter_3,
    "division_intro_3":               _division_intro_3,
    "telling_time_to_the_minute_3":   _telling_time_to_the_minute_3,
    "making_inferences_3":            _making_inferences_3,
    "summarizing_a_story_3":          _summarizing_a_story_3,
    "text_features_nonfiction_3":     _text_features_nonfiction_3,
    "beginning_middle_end_1":         _beginning_middle_end_1,
    "predicting_what_happens_next_1": _predicting_what_happens_next_1,
    "who_what_where_1":               _who_what_where_1,
    "theme_vs_topic_4":               _theme_vs_topic_4,
    "comparing_two_texts_4":          _comparing_two_texts_4,
    "authors_word_choice_4":          _authors_word_choice_4,

    # ── Coverage batch 12 (final) ──
    "life_cycle_of_a_frog_2":         _life_cycle_of_a_frog_2,
    "magnet_push_pull_2":             _magnet_push_pull_2,
    "weather_tools_2":                _weather_tools_2,
    "animal_groups_2":                _animal_groups_2,
    "states_of_matter_particles_5":   _states_of_matter_particles_5,
    "photosynthesis_5":               _photosynthesis_5,
    "simple_circuits_5":              _simple_circuits_5,
    "weathering_and_erosion_5":       _weathering_and_erosion_5,
    "editing_for_run_ons_3":          _editing_for_run_ons_3,
    "writing_a_book_report_3":        _writing_a_book_report_3,
    "using_strong_adjectives_3":      _using_strong_adjectives_3,
    "writing_directions_3":           _writing_directions_3,

    # ── Weekly Packets ──
    "weekly_packet_g1_w1":        _weekly_packet_g1_w1,
    "weekly_packet_g1_w2":        _weekly_packet_g1_w2,
    "weekly_packet_g1_w3":        _weekly_packet_g1_w3,
}


# ── DB-driven content path ───────────────────────────────────────────────
# Worksheets whose Worksheets.content_data column is populated are rendered
# generically from that JSON instead of from a hardcoded Python function —
# see lsh.database/42_worksheet_content_data.sql and
# scratch_tmp/extract_worksheet_content.py for how content_data gets there.
# ── Colorable outlines ─────────────────────────────────────────────────────
# Each draws into a 200x150 local box. Stroke only: a filled shape cannot be
# colored in, and thin lines vanish under a blunt crayon.

def _o_rainbow(g, O, S):
    from reportlab.graphics.shapes import PolyLine, Line
    for i in range(7):
        r = 96 - i * 9
        g.add(PolyLine(_arc(100, 16, r, r, 0, 180, 44), **O))
    for cx in (20, 180):                                   # a cloud at each end
        g.add(PolyLine(_arc(cx - 14, 20, 14, 12, 0, 180, 20), **O))
        g.add(PolyLine(_arc(cx + 1, 24, 17, 15, 0, 180, 20), **O))
        g.add(PolyLine(_arc(cx + 16, 20, 13, 11, 0, 180, 20), **O))
        g.add(Line(cx - 28, 20, cx + 29, 20, **O))


def _o_sun(g, O, S):
    from reportlab.graphics.shapes import Circle, Polygon, PolyLine
    import math
    g.add(Circle(100, 75, 44, **O))
    for k in range(12):                                     # rays
        a = math.radians(k * 30)
        x1, y1 = 100 + 50 * math.cos(a), 75 + 50 * math.sin(a)
        x2, y2 = 100 + 68 * math.cos(a), 75 + 68 * math.sin(a)
        pa = a + 0.13
        g.add(Polygon([100 + 50 * math.cos(pa), 75 + 50 * math.sin(pa),
                       x2, y2,
                       100 + 50 * math.cos(a - 0.13), 75 + 50 * math.sin(a - 0.13)], **O))
    g.add(Circle(86, 86, 4.2, **S))
    g.add(Circle(114, 86, 4.2, **S))
    g.add(PolyLine(_arc(100, 78, 20, 17, 200, 340), **O))


def _o_flower(g, O, S):
    from reportlab.graphics.shapes import Circle, PolyLine, Line
    import math
    # Six round petals on a ring, sized so neighbours just touch. The first
    # version used eight ellipses at the same radius and they overlapped into
    # a knot of loops.
    for k in range(6):
        a = math.radians(k * 60 + 90)
        g.add(Circle(100 + 42 * math.cos(a), 94 + 42 * math.sin(a), 20, **O))
    g.add(Circle(100, 94, 21, **O))
    g.add(Line(100, 73, 100, 8, **O))
    g.add(PolyLine(_arc(76, 44, 24, 14, -6, 154), **O))
    g.add(PolyLine(_arc(124, 30, 24, 14, 26, 186), **O))


def _o_butterfly(g, O, S):
    from reportlab.graphics.shapes import Circle, Ellipse, PolyLine, Line
    g.add(Ellipse(100, 72, 7, 44, **O))                      # body
    g.add(Circle(100, 122, 9, **O))                          # head
    g.add(PolyLine([100, 130, 88, 146], **O))                # antennae
    g.add(PolyLine([100, 130, 112, 146], **O))
    for sgn in (-1, 1):
        g.add(Ellipse(100 + sgn * 42, 96, 38, 30, **O))      # upper wings
        g.add(Ellipse(100 + sgn * 34, 44, 30, 24, **O))      # lower wings
        g.add(Circle(100 + sgn * 46, 100, 9, **O))           # spots to color
        g.add(Circle(100 + sgn * 34, 44, 7, **O))


def _o_shark(g, O, S):
    from reportlab.graphics.shapes import Circle, Polygon, PolyLine
    g.add(PolyLine(_arc(96, 74, 76, 34, 0, 180, 40), **O))   # back
    g.add(PolyLine(_arc(96, 74, 76, 30, 180, 360, 40), **O))  # belly
    g.add(Polygon([88, 106, 104, 140, 120, 104], **O))       # dorsal fin
    g.add(Polygon([172, 74, 196, 104, 190, 74, 196, 44], **O))  # tail
    g.add(Polygon([96, 46, 84, 22, 118, 44], **O))           # pectoral fin
    g.add(Circle(44, 84, 4.5, **S))
    g.add(PolyLine(_arc(40, 74, 22, 14, 190, 250), **O))     # mouth
    for x in (58, 66, 74):
        g.add(PolyLine(_arc(x, 74, 12, 20, 250, 290), **O))  # gills


def _o_race_car(g, O, S):
    from reportlab.graphics.shapes import Circle, Polygon, Rect, PolyLine
    g.add(Polygon([16, 44, 184, 44, 178, 70, 24, 70], **O))  # chassis
    g.add(Polygon([62, 70, 84, 100, 128, 100, 142, 70], **O))  # cabin
    g.add(Rect(158, 70, 26, 8, **O))                          # spoiler
    g.add(PolyLine([170, 70, 170, 62], **O))
    g.add(Circle(56, 40, 22, **O))
    g.add(Circle(56, 40, 9, **O))
    g.add(Circle(146, 40, 22, **O))
    g.add(Circle(146, 40, 9, **O))
    g.add(Circle(100, 56, 11, **O))                           # number roundel


def _o_rocket(g, O, S):
    from reportlab.graphics.shapes import Circle, Polygon, PolyLine, Line
    # Fins outside the body. Tucked against it they vanished into the
    # silhouette and the whole thing read as a lighthouse.
    g.add(Polygon([80, 36, 54, 6, 80, 56], **O))
    g.add(Polygon([120, 36, 146, 6, 120, 56], **O))
    g.add(Line(80, 36, 80, 100, **O))
    g.add(Line(120, 36, 120, 100, **O))
    g.add(Line(80, 36, 120, 36, **O))
    g.add(Polygon([80, 100, 100, 142, 120, 100], **O))
    g.add(Line(80, 100, 120, 100, **O))
    g.add(Circle(100, 86, 12, **O))
    g.add(Circle(100, 56, 8, **O))
    for dx in (-11, 0, 11):                                   # flame
        g.add(Polygon([94 + dx, 36, 100 + dx, 8, 106 + dx, 36], **O))


def _o_spaceship(g, O, S):
    from reportlab.graphics.shapes import Circle, Ellipse, PolyLine, Polygon
    g.add(Ellipse(100, 62, 86, 22, **O))                      # saucer
    g.add(PolyLine(_arc(100, 66, 46, 44, 10, 170, 34), **O))  # dome
    g.add(PolyLine([54, 66, 146, 66], **O))
    for x in (64, 100, 136):
        g.add(Circle(x, 54, 7, **O))                          # lights
    g.add(Polygon([76, 42, 100, 12, 124, 42], **O))           # beam
    g.add(Circle(100, 96, 10, **O))


def _o_castle(g, O, S):
    from reportlab.graphics.shapes import Rect, Polygon, PolyLine, Circle
    def tower(x, w, h):
        g.add(Rect(x, 20, w, h, **O))
        n, cw = 4, w / 7.0
        for k in range(n):
            bx = x + k * (w - cw) / (n - 1.0)
            g.add(Rect(bx, 20 + h, cw, 9, **O))
    tower(18, 44, 84)
    tower(138, 44, 84)
    tower(74, 52, 62)
    g.add(PolyLine([62, 62, 74, 62], **O))
    g.add(PolyLine([126, 62, 138, 62], **O))
    g.add(PolyLine(_arc(100, 20, 17, 30, 0, 180, 22), **O))   # gate arch
    g.add(PolyLine([83, 20, 83, 20], **O))
    for x in (34, 154):
        g.add(Circle(x + 6, 78, 8, **O))                      # windows
    g.add(PolyLine([100, 91, 100, 118], **O))                 # flagpole
    g.add(Polygon([100, 118, 128, 110, 100, 102], **O))       # flag


def _o_unicorn(g, O, S):
    from reportlab.graphics.shapes import Circle, Polygon, PolyLine, Line
    # A closed head silhouette. Before, the muzzle was a loose arc floating
    # beside a circle and the mane was a pile of unattached loops.
    head = [22, 66, 17, 80, 30, 93, 56, 103, 78, 113, 97, 111, 105, 92,
            97, 66, 70, 54, 40, 54]
    g.add(Polygon(head, **O))
    g.add(Polygon([86, 112, 99, 150, 105, 110], **O))         # horn
    for k in range(4):                                        # horn stripes
        g.add(Line(88 + k * 2.6, 118 + k * 8, 103 - k * 1.4, 116 + k * 8, **O))
    g.add(Polygon([105, 104, 120, 128, 111, 98], **O))        # ear
    for k in range(3):                                        # mane, against the head
        g.add(PolyLine(_arc(103 + k * 3, 92 - k * 15, 17, 19, 70, 262), **O))
    g.add(Circle(55, 88, 4.2, **S))
    g.add(Circle(28, 75, 3.2, **S))
    g.add(Line(19, 71, 33, 66, **O))


def _o_trex(g, O, S):
    from reportlab.graphics.shapes import Circle, Polygon, PolyLine, Line
    # One closed silhouette. Drawn as separate parts they never met, and the
    # head floated away from the body.
    body = [20, 96, 56, 101, 70, 112, 98, 121, 140, 111, 178, 97, 197, 73,
            169, 67, 151, 50, 147, 19, 159, 13, 137, 15, 133, 48, 112, 52,
            108, 19, 121, 13, 99, 15, 95, 49, 78, 58, 66, 74, 20, 81]
    g.add(Polygon(body, **O))
    g.add(Line(20, 88, 62, 91, **O))                          # jaw
    for k in range(5):                                        # teeth
        x = 26 + k * 8
        g.add(Polygon([x, 88, x + 4, 82, x + 8, 88], **O))
    g.add(Circle(48, 96, 4, **S))
    g.add(Polygon([84, 62, 70, 44, 88, 52], **O))             # little arm


_OUTLINES = {
    "rainbow": _o_rainbow, "sun": _o_sun, "flower": _o_flower,
    "butterfly": _o_butterfly, "shark": _o_shark, "race_car": _o_race_car,
    "rocket": _o_rocket, "spaceship": _o_spaceship, "castle": _o_castle,
    "unicorn": _o_unicorn, "trex": _o_trex,
}


def _coloring_outline(shape, title, facts, footer_label, grade=None):
    """A real coloring page: one big outline, then the facts.

    Replaces _draw_your_own, which drew a dashed rectangle with a dashed
    ellipse in the middle and called itself an honest substitute. A child
    given an empty box has been given nothing to start from.
    """
    from reportlab.platypus import Paragraph, Spacer
    from reportlab.graphics.shapes import Drawing, Group
    from reportlab.lib.styles import ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors

    INK = colors.HexColor("#4c46b8")
    buf, doc, story, styles = _doc(title, "Trace the outline, then color it in.")

    draw = _OUTLINES.get(shape)
    if draw is None:
        raise KeyError("no outline for %r" % shape)

    # Younger children get a heavier line; it survives a blunt crayon.
    lw = 3.0 if (grade is None or int(grade) <= 2) else 2.4
    O = dict(strokeColor=INK, strokeWidth=lw, fillColor=None,
             strokeLineCap=1, strokeLineJoin=1)
    S = dict(strokeColor=INK, strokeWidth=0, fillColor=INK)

    inner = Group()
    draw(inner, O, S)

    W = 6.9 * inch
    sc = W / 200.0
    d = Drawing(W, 150 * sc)
    inner.transform = (sc, 0, 0, sc, 0, 0)
    d.add(inner)
    story.append(d)
    story.append(Spacer(1, 14))

    story.append(Paragraph("Fun facts to inspire your coloring:", ParagraphStyle(
        "h", parent=styles["Heading3"], fontSize=13, spaceAfter=6)))
    for f in facts:
        story.append(Paragraph("\u2022  " + f, ParagraphStyle(
            "f", parent=styles["Normal"], fontSize=11.5, leading=17, spaceAfter=3)))
    _footer(story, styles, footer_label)
    doc.build(story)
    return buf.getvalue()


_RENDERERS = {
    "build":             _build,
    "text_page":         _text_page,
    "tracing_items":     _tracing_items,
    "checklist":         _checklist,
    "word_match_table":  _word_match_table,
    "draw_your_own":     _draw_your_own,
    # Takes `grade`; render_from_content_data passes it when the row has one.
    "family_tree":       _draw_your_family,
    "color_outline":     _coloring_outline,
}


def render_from_content_data(content_data_json: str,
                             grade: int | None = None) -> bytes:
    """content_data_json: the Worksheets.content_data column value —
    {"renderer": "<one of _RENDERERS>", "params": {...kwargs for that renderer}}.

    A renderer that bands its layout by age declares `grade`; it is passed
    only to those, so the existing renderers keep their signatures.
    """
    import inspect
    payload = json.loads(content_data_json)
    fn = _RENDERERS[payload["renderer"]]
    params = dict(payload.get("params") or {})
    try:
        if "grade" in inspect.signature(fn).parameters:
            params.setdefault("grade", grade)
    except (TypeError, ValueError):
        pass
    return fn(**params)


def generate(key: str, content_data: str | None = None,
             grade: int | None = None) -> bytes:
    """Raises KeyError if the generator key isn't registered (and no
    content_data was supplied as an alternative source)."""
    if content_data:
        return render_from_content_data(content_data, grade=grade)
    fn = GENERATORS[key]
    # Most generators take no arguments. The ones that band their layout by
    # age declare `grade`, so pass it only where it is wanted rather than
    # changing 200 signatures.
    try:
        import inspect
        if "grade" in inspect.signature(fn).parameters:
            return fn(grade=grade)
    except (TypeError, ValueError):
        pass
    return fn()
