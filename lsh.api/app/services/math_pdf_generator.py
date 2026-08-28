"""
services/math_pdf_generator.py
Generates printable PDF math worksheets using ReportLab.
pip install reportlab

Usage:
  from services.math_pdf_generator import generate_worksheet_pdf
  pdf_bytes = generate_worksheet_pdf(packet, day="Monday", child_name="Kai")
"""

import io
from datetime import date
from typing import Dict, Any

try:
    from reportlab.lib.pagesizes import letter
    from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
    from reportlab.lib.units import inch
    from reportlab.lib import colors
    from reportlab.platypus import (SimpleDocTemplate, Paragraph, Spacer,
                                    Table, TableStyle, HRFlowable, KeepTogether)
    from reportlab.lib.enums import TA_CENTER, TA_LEFT
    HAS_REPORTLAB = True
except ImportError:
    HAS_REPORTLAB = False


BRAND_PURPLE  = colors.HexColor("#5b4fcf")
BRAND_LIGHT   = colors.HexColor("#f3f0ff")
LIGHT_GRAY    = colors.HexColor("#f9fafb")
BORDER_GRAY   = colors.HexColor("#e5e7eb")
SUCCESS_GREEN = colors.HexColor("#dcfce7")
TEXT_DARK     = colors.HexColor("#1f2937")


def generate_worksheet_pdf(packet: Dict, day: str = "Monday",
                            child_name: str = "Student") -> bytes:
    """
    Generate a printable PDF for one day of the weekly packet.
    Returns raw PDF bytes.
    """
    if not HAS_REPORTLAB:
        raise ImportError("reportlab is required. pip install reportlab")

    buf = io.BytesIO()
    doc = SimpleDocTemplate(
        buf,
        pagesize=letter,
        leftMargin=0.75*inch, rightMargin=0.75*inch,
        topMargin=0.75*inch,  bottomMargin=0.75*inch,
    )

    styles = getSampleStyleSheet()
    title_style = ParagraphStyle("lsh_title", parent=styles["Heading1"],
                                  fontSize=18, textColor=BRAND_PURPLE,
                                  spaceAfter=2, alignment=TA_CENTER)
    sub_style   = ParagraphStyle("lsh_sub",   parent=styles["Normal"],
                                  fontSize=10, textColor=colors.gray,
                                  spaceAfter=4, alignment=TA_CENTER)
    section_style = ParagraphStyle("lsh_section", parent=styles["Heading2"],
                                    fontSize=12, textColor=BRAND_PURPLE,
                                    spaceBefore=12, spaceAfter=4)
    q_style     = ParagraphStyle("lsh_q", parent=styles["Normal"],
                                  fontSize=10, leading=14, textColor=TEXT_DARK)
    small_style = ParagraphStyle("lsh_small", parent=styles["Normal"],
                                  fontSize=8, textColor=colors.gray)

    story = []

    # ── Header ────────────────────────────────────────────────────────────────
    story.append(Paragraph("🌟 Little Scholars Hub", title_style))
    story.append(Paragraph(
        f"Weekly Math Worksheet  •  {day}  •  Week {packet.get('week','')}  •  "
        f"{packet.get('topic_label','')}",
        sub_style
    ))
    story.append(Paragraph(
        f"Name: {'_'*28}  &nbsp;&nbsp;  Date: {'_'*18}  &nbsp;&nbsp;  Score: ___  / ___",
        ParagraphStyle("hdr_line", parent=styles["Normal"], fontSize=10, spaceAfter=6)
    ))
    story.append(HRFlowable(width="100%", thickness=1.5, color=BRAND_PURPLE,
                             spaceAfter=8))

    # ── Sections ──────────────────────────────────────────────────────────────
    day_data = packet.get("days", {}).get(day, {})
    sections = day_data.get("sections", {})

    ICONS = {
        "warm_up":       "⚡ Warm-Up",
        "skill_focus":   "📘 Skill Focus",
        "spiral_review": "🔄 Spiral Review",
        "word_problems": "✏️ Word Problems",
        "friday_assessment": "🏆 Assessment",
    }

    for sec_key, section in sections.items():
        sec_title = section.get("title", ICONS.get(sec_key, sec_key))
        story.append(Paragraph(sec_title, section_style))

        questions = section.get("questions", [])
        # Layout 2-column for short questions, 1-column for long ones
        short_qs = [q for q in questions if len(q.get("question","")) < 60]
        long_qs  = [q for q in questions if len(q.get("question","")) >= 60]

        # Two-column table for short questions
        if short_qs:
            rows = []
            for i in range(0, len(short_qs), 2):
                left  = _q_cell(i+1,   short_qs[i],   q_style, small_style)
                right = _q_cell(i+2, short_qs[i+1], q_style, small_style) if i+1 < len(short_qs) else ""
                rows.append([left, right])

            t = Table(rows, colWidths=[3.5*inch, 3.5*inch],
                      repeatRows=0, hAlign="LEFT")
            t.setStyle(TableStyle([
                ("VALIGN",      (0,0), (-1,-1), "TOP"),
                ("LEFTPADDING", (0,0), (-1,-1), 6),
                ("RIGHTPADDING",(0,0), (-1,-1), 6),
                ("TOPPADDING",  (0,0), (-1,-1), 4),
                ("BOTTOMPADDING",(0,0),(-1,-1), 4),
                ("ROWBACKGROUNDS",(0,0),(-1,-1),[LIGHT_GRAY, colors.white]),
                ("GRID",        (0,0), (-1,-1), 0.5, BORDER_GRAY),
                ("ROUNDEDCORNERS",(0,0),(-1,-1), 4),
            ]))
            story.append(KeepTogether(t))

        # Single-column for word problems and long questions
        for i, q in enumerate(long_qs, start=len(short_qs)+1):
            block = _q_cell_full(i, q, q_style, small_style)
            story.append(block)

        story.append(Spacer(1, 0.1*inch))

    # ── Footer ────────────────────────────────────────────────────────────────
    story.append(HRFlowable(width="100%", thickness=0.5, color=BORDER_GRAY, spaceBefore=12))
    story.append(Paragraph(
        f"littlescholarshub.com  •  Generated {date.today().strftime('%B %d, %Y')}  "
        f"•  {child_name}  •  © Little Scholars Hub",
        ParagraphStyle("footer", parent=styles["Normal"], fontSize=8,
                        textColor=colors.gray, alignment=TA_CENTER)
    ))

    doc.build(story)
    return buf.getvalue()


def _q_cell(num: int, q: Dict, q_style, small_style):
    """Build a cell for a short question."""
    lines = [Paragraph(f"<b>{num}.</b>  {q.get('question','')}", q_style)]
    # Work-space blank lines
    ws = q.get("work_space", 1)
    for _ in range(ws):
        lines.append(HRFlowable(width="90%", thickness=0.5, color=BORDER_GRAY,
                                 spaceBefore=6, spaceAfter=6))
    if q.get("options"):
        opts_text = "  ".join([f"({chr(65+i)}) {o}" for i,o in enumerate(q["options"])])
        lines.append(Paragraph(opts_text, small_style))
    return lines


def _q_cell_full(num: int, q: Dict, q_style, small_style):
    """Single-column block for long/word problems."""
    from reportlab.platypus import KeepTogether
    items = [
        Spacer(1, 4),
        Paragraph(f"<b>{num}.</b>  {q.get('question','')}", q_style),
    ]
    ws = q.get("work_space", 2)
    for _ in range(ws):
        items.append(HRFlowable(width="100%", thickness=0.5, color=BORDER_GRAY,
                                 spaceBefore=8, spaceAfter=8))
    if q.get("options"):
        opts_text = "     ".join([f"({chr(65+i)}) {o}" for i,o in enumerate(q["options"])])
        items.append(Paragraph(opts_text, small_style))
    items.append(Spacer(1, 4))
    return KeepTogether(items)


def generate_week_pdf(packet: Dict, child_name: str = "Student") -> bytes:
    """Generate a full 5-day packet PDF (all days concatenated)."""
    if not HAS_REPORTLAB:
        raise ImportError("reportlab is required. pip install reportlab")

    from reportlab.platypus import PageBreak

    buf = io.BytesIO()
    doc = SimpleDocTemplate(buf, pagesize=letter,
                             leftMargin=0.75*inch, rightMargin=0.75*inch,
                             topMargin=0.75*inch,  bottomMargin=0.75*inch)
    story = []
    days  = ["Monday","Tuesday","Wednesday","Thursday","Friday"]

    for i, day in enumerate(days):
        # Each day's content (re-use single-day builder logic)
        day_bytes  = generate_worksheet_pdf(packet, day, child_name)
        # We rebuild inline instead of nesting docs
        _add_day_to_story(story, packet, day, child_name)
        if i < len(days)-1:
            story.append(PageBreak())

    doc.build(story)
    return buf.getvalue()


def _add_day_to_story(story, packet, day, child_name):
    """Append one day's content to an existing story list."""
    # Simplified inline version
    styles = getSampleStyleSheet()
    story.append(Paragraph(
        f"<b>🌟 Little Scholars Hub</b> — {day}  •  Week {packet.get('week','')}  •  {packet.get('topic_label','')}",
        ParagraphStyle("dh", parent=styles["Heading2"], fontSize=13,
                        textColor=BRAND_PURPLE, spaceAfter=2)
    ))
    story.append(Paragraph(
        f"Name: {'_'*26}  Date: {'_'*16}  Score: ___ / ___",
        ParagraphStyle("dl", parent=styles["Normal"], fontSize=9, spaceAfter=4)
    ))
    story.append(HRFlowable(width="100%", thickness=1, color=BRAND_PURPLE, spaceAfter=6))

    day_data = packet.get("days",{}).get(day,{})
    q_style   = ParagraphStyle("qq", parent=styles["Normal"], fontSize=10, leading=14)
    sm_style  = ParagraphStyle("ss", parent=styles["Normal"], fontSize=8, textColor=colors.gray)

    for sec_key, section in day_data.get("sections",{}).items():
        story.append(Paragraph(section.get("title", sec_key),
            ParagraphStyle("sh", parent=styles["Heading3"], fontSize=11,
                            textColor=BRAND_PURPLE, spaceBefore=8, spaceAfter=3)))
        for i, q in enumerate(section.get("questions",[])):
            story.append(Paragraph(
                f"<b>{i+1}.</b> {q.get('question','')}",
                q_style
            ))
            for _ in range(q.get("work_space",1)):
                story.append(HRFlowable(width="100%", thickness=0.4, color=BORDER_GRAY,
                                         spaceBefore=5, spaceAfter=5))
