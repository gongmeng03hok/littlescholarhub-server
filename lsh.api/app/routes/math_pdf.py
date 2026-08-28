"""
routes/math_pdf.py  –  /api/math/pdf
Serve printable PDF worksheets.

GET /api/math/pdf/day?grade=2&day=Monday&child_name=Kai
GET /api/math/pdf/week?grade=2&child_name=Kai
GET /api/math/pdf/drill?grade=2&child_name=Kai
"""

from flask import Blueprint, request, send_file, jsonify
import io
from services.math_weekly_generator import (
    generate_weekly_packet, generate_daily_sheet,
    generate_timed_drill, get_current_week_topic
)

math_pdf_bp = Blueprint("math_pdf", __name__)


def _grade():
    try:
        return max(0, min(7, int(request.args.get("grade", 2))))
    except (ValueError, TypeError):
        return 2


@math_pdf_bp.get("/day")
def pdf_day():
    """Single day worksheet as PDF."""
    try:
        from services.math_pdf_generator import generate_worksheet_pdf
    except ImportError:
        return jsonify({"error": "reportlab not installed. pip install reportlab"}), 501

    grade      = _grade()
    day        = request.args.get("day", "Monday").capitalize()
    child_name = request.args.get("child_name", "Student")

    topic  = get_current_week_topic(grade)
    packet = generate_weekly_packet(grade)

    try:
        pdf_bytes = generate_worksheet_pdf(packet, day, child_name)
    except Exception as exc:
        return jsonify({"error": str(exc)}), 500

    return send_file(
        io.BytesIO(pdf_bytes),
        mimetype="application/pdf",
        as_attachment=True,
        download_name=f"LSH_Math_{day}_Week{topic['week']}_Grade{grade}.pdf"
    )


@math_pdf_bp.get("/week")
def pdf_week():
    """Full 5-day packet as PDF."""
    try:
        from services.math_pdf_generator import generate_week_pdf
    except ImportError:
        return jsonify({"error": "reportlab not installed. pip install reportlab"}), 501

    grade      = _grade()
    child_name = request.args.get("child_name", "Student")
    week_num   = request.args.get("week", type=int)

    packet = generate_weekly_packet(grade, week_num)

    try:
        pdf_bytes = generate_week_pdf(packet, child_name)
    except Exception as exc:
        return jsonify({"error": str(exc)}), 500

    return send_file(
        io.BytesIO(pdf_bytes),
        mimetype="application/pdf",
        as_attachment=True,
        download_name=f"LSH_MathWeek{packet['week']}_Grade{grade}_{child_name}.pdf"
    )


@math_pdf_bp.get("/drill")
def pdf_drill():
    """Timed drill sheet as PDF."""
    try:
        from reportlab.lib.pagesizes import letter
        from reportlab.platypus import SimpleDocTemplate, Paragraph, Table, TableStyle, HRFlowable
        from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
        from reportlab.lib.units import inch
        from reportlab.lib import colors
        from reportlab.lib.enums import TA_CENTER
    except ImportError:
        return jsonify({"error": "reportlab not installed"}), 501

    grade      = _grade()
    child_name = request.args.get("child_name", "Student")
    drill      = generate_timed_drill(grade)

    buf = io.BytesIO()
    doc = SimpleDocTemplate(buf, pagesize=letter,
                             leftMargin=0.75*inch, rightMargin=0.75*inch,
                             topMargin=0.75*inch,  bottomMargin=0.75*inch)
    styles = getSampleStyleSheet()
    PURPLE = colors.HexColor("#5b4fcf")

    story = []
    story.append(Paragraph("⚡ Math Fluency Drill",
        ParagraphStyle("t", parent=styles["Heading1"], fontSize=18,
                        textColor=PURPLE, alignment=TA_CENTER)))
    story.append(Paragraph(
        f"Name: {'_'*26}  Time: {'_'*12}  Score: ___ / 30",
        ParagraphStyle("hl", parent=styles["Normal"], fontSize=10,
                        alignment=TA_CENTER, spaceAfter=8)))
    story.append(HRFlowable(width="100%", thickness=1.5, color=PURPLE, spaceAfter=10))

    # 3-column grid of questions
    qs = drill["questions"]
    rows = []
    for i in range(0, len(qs), 3):
        row = []
        for j in range(3):
            idx = i+j
            if idx < len(qs):
                text = f"{idx+1:2d}.  {qs[idx]['question'].replace('= ___','= _____')}"
                row.append(Paragraph(text, ParagraphStyle("dq", parent=styles["Normal"],
                                                           fontSize=12, leading=18)))
            else:
                row.append("")
        rows.append(row)

    t = Table(rows, colWidths=[2.25*inch]*3)
    t.setStyle(TableStyle([
        ("VALIGN",       (0,0),(-1,-1),"MIDDLE"),
        ("LEFTPADDING",  (0,0),(-1,-1), 8),
        ("RIGHTPADDING", (0,0),(-1,-1), 8),
        ("TOPPADDING",   (0,0),(-1,-1), 6),
        ("BOTTOMPADDING",(0,0),(-1,-1), 6),
        ("ROWBACKGROUNDS",(0,0),(-1,-1),[colors.HexColor("#f9fafb"), colors.white]),
        ("GRID",         (0,0),(-1,-1), 0.5, colors.HexColor("#e5e7eb")),
    ]))
    story.append(t)

    story.append(HRFlowable(width="100%", thickness=0.5, color=colors.lightgrey, spaceBefore=12))
    story.append(Paragraph(f"littlescholarshub.com  •  {child_name}",
        ParagraphStyle("ft", parent=styles["Normal"], fontSize=8,
                        textColor=colors.gray, alignment=TA_CENTER)))

    doc.build(story)
    pdf_bytes = buf.getvalue()

    return send_file(
        io.BytesIO(pdf_bytes),
        mimetype="application/pdf",
        as_attachment=True,
        download_name=f"LSH_MathDrill_Grade{grade}_{child_name}.pdf"
    )
