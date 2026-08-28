/**
 * Shared rendering for the Weekly Packets feature (DB-driven — composed
 * from dbo.usp_GetOrCreateWeeklyPacket via /content/practice-packet).
 * Used by the admin, parent, and teacher Weekly Packets screens: the
 * on-screen body (category cards, diagrams, answer key) and the print-ready
 * HTML document builder both live here so all three surfaces render
 * identically.
 */
import { useMemo } from "react";
import { View, Text, ActivityIndicator, StyleSheet, Platform } from "react-native";
import type { PracticePacket } from "../api/content";
import { WEEK_OPTIONS_2026, buildWordSearch, type WordSearchResult } from "../utils/weeklyPacketWeeks";
import { colors } from "../constants/theme";

export const SUBJECT_META: Record<string, { label: string; color: string; tint: string }> = {
  math:           { label: "MATH",           color: "#453aa8", tint: "#eeecfb" },
  ela:            { label: "ELA",            color: "#1f6b3a", tint: "#e9f3e4" },
  writing:        { label: "WRITING",        color: "#a83f2a", tint: "#fbe9e4" },
  science:        { label: "SCIENCE",        color: "#1b5a8a", tint: "#e6f0fa" },
  social_studies: { label: "SOCIAL STUDIES", color: "#8a5a1b", tint: "#f7ecd9" },
  puzzle:         { label: "PUZZLE",         color: "#8a1b6e", tint: "#f8e6f3" },
};

/** Splits categories into on-screen layout groups and computes the
 * word-search grids + Ollie mascot line + everything a Print button needs. */
export function useWeeklyPacketDisplay(packet: PracticePacket | undefined) {
  const shortAnswer = packet?.categories.filter(c => c.layout_type === "short_answer") ?? [];
  const spaceHeavy   = packet?.categories.filter(c => c.layout_type === "space_heavy") ?? [];
  const puzzles      = packet?.categories.filter(c => c.layout_type === "puzzle") ?? [];

  // Categories render out of order (grouped by layout for a tidier page),
  // but should still read "1, 2, 3..." matching the order the API returned —
  // this map recovers that original numbering for each split-out group.
  const numberByCatId = new Map((packet?.categories ?? []).map((c, i) => [c.category_id, i + 1]));

  const wordSearches = useMemo(() => {
    const map: Record<number, WordSearchResult> = {};
    for (const cat of puzzles) {
      const q = cat.questions[0];
      if (!q) continue;
      const words = q.prompt.replace(/^Find these words:\s*/i, "").split(",").map(w => w.trim().toUpperCase());
      map[cat.category_id] = buildWordSearch(words);
    }
    return map;
  }, [puzzles]);

  return { shortAnswer, spaceHeavy, puzzles, numberByCatId, wordSearches };
}

export function printWeeklyPacket(packet: PracticePacket, wordSearches: Record<number, WordSearchResult>) {
  if (Platform.OS !== "web") return;
  const html = buildPrintHtml(packet, wordSearches);
  const iframe = document.createElement("iframe");
  iframe.style.position = "fixed";
  iframe.style.right = "0";
  iframe.style.bottom = "0";
  iframe.style.width = "0";
  iframe.style.height = "0";
  iframe.style.border = "none";
  document.body.appendChild(iframe);
  const doc = iframe.contentWindow?.document;
  if (doc) {
    doc.open(); doc.write(html); doc.close();
    iframe.onload = () => {
      try { iframe.contentWindow?.focus(); iframe.contentWindow?.print(); }
      catch { /* no-op — best effort */ }
      setTimeout(() => document.body.removeChild(iframe), 60_000);
    };
  }
}

// ── On-screen body ──────────────────────────────────────────────────────
function ClockDiagram({ hour, minute = 0 }: { hour: number; minute?: number }) {
  const hourDeg = ((hour % 12) + minute / 60) * 30;
  const minDeg = minute * 6;
  return (
    <View style={s.clockFace}>
      <View style={[s.clockHand, s.clockHourHand, { transform: [{ rotate: `${hourDeg}deg` }] } as any]} />
      <View style={[s.clockHand, s.clockMinHand, { transform: [{ rotate: `${minDeg}deg` }] } as any]} />
      <View style={s.clockPin} />
    </View>
  );
}

function TenFrameDiagram({ count }: { count: number }) {
  const cells = Array.from({ length: 10 }, (_, i) => i < count);
  return (
    <View style={s.tenFrame}>
      {[0, 1].map(row => (
        <View key={row} style={s.tenFrameRow}>
          {cells.slice(row * 5, row * 5 + 5).map((filled, i) => (
            <View key={i} style={[s.tenFrameCell, filled && s.tenFrameCellFilled]} />
          ))}
        </View>
      ))}
    </View>
  );
}

function AngleDiagram({ degrees }: { degrees: number }) {
  return (
    <View style={s.angleBox}>
      <View style={[s.angleRay, { transform: [{ rotate: "0deg" }] } as any]} />
      <View style={[s.angleRay, { transform: [{ rotate: `-${degrees}deg` }] } as any]} />
      <View style={s.angleVertex} />
    </View>
  );
}

function RectangleDimsDiagram({ width, height, unit }: { width: number; height: number; unit?: string }) {
  const maxDim = 60;
  const ratio = width / height;
  const boxW = ratio >= 1 ? maxDim : maxDim * ratio;
  const boxH = ratio >= 1 ? maxDim / ratio : maxDim;
  return (
    <View style={s.rectDimsWrap}>
      <Text style={s.rectDimsTopLabel}>{width}{unit ?? ""}</Text>
      <View style={{ flexDirection: "row", alignItems: "center" }}>
        <View style={[s.rectDimsBox, { width: boxW, height: boxH }]} />
        <Text style={s.rectDimsSideLabel}>{height}{unit ?? ""}</Text>
      </View>
    </View>
  );
}

function CoordinatePointDiagram({ x, y, size = 6 }: { x: number; y: number; size?: number }) {
  const cell = 8;
  const gridPx = size * 2 * cell;
  const centerPx = size * cell;
  const px = centerPx + x * cell;
  const py = centerPx - y * cell;
  return (
    <View style={[s.coordGrid, { width: gridPx, height: gridPx }]}>
      <View style={[s.coordAxis, { left: centerPx, top: 0, bottom: 0, width: 1.5 }]} />
      <View style={[s.coordAxis, { top: centerPx, left: 0, right: 0, height: 1.5 }]} />
      <View style={[s.coordDot, { left: px - 4, top: py - 4 }]} />
    </View>
  );
}

function QuestionDiagram({ q }: { q: any }) {
  if (q.diagram_type === "clock" && q.diagram_data) {
    return <ClockDiagram hour={q.diagram_data.hour} minute={q.diagram_data.minute} />;
  }
  if (q.diagram_type === "emoji" && q.diagram_data?.emoji) {
    return <Text style={s.emojiDiagram}>{q.diagram_data.emoji}</Text>;
  }
  if (q.diagram_type === "ten_frame" && q.diagram_data) {
    return <TenFrameDiagram count={q.diagram_data.count} />;
  }
  if (q.diagram_type === "angle" && q.diagram_data) {
    return <AngleDiagram degrees={q.diagram_data.degrees} />;
  }
  if (q.diagram_type === "rectangle_dims" && q.diagram_data) {
    return <RectangleDimsDiagram width={q.diagram_data.width} height={q.diagram_data.height} unit={q.diagram_data.unit} />;
  }
  if (q.diagram_type === "coordinate_point" && q.diagram_data) {
    return <CoordinatePointDiagram x={q.diagram_data.x} y={q.diagram_data.y} size={q.diagram_data.size} />;
  }
  return null;
}

function guessInstruction(cat: any): string {
  switch (cat.questions[0]?.question_type) {
    case "fill_blank": return "Fill in the blank.";
    case "multiple_choice": return "Circle the correct answer.";
    case "short_response": return "Answer in complete sentences.";
    case "word_search": return "Find and circle the words.";
    default: return "";
  }
}

function CategoryCard({ cat, num, style }: { cat: any; num: number; style: any }) {
  const meta = SUBJECT_META[cat.subject_area] ?? SUBJECT_META.math;
  return (
    <View style={[s.card, style]}>
      <Text style={[s.cardTitle, { color: meta.color }]}>{num}. {cat.category_name}</Text>
      <Text style={s.cardInstr}>{meta.label} · {guessInstruction(cat)}</Text>
      {!!cat.intro_text && <Text style={s.introText}>{cat.intro_text}</Text>}
      {cat.questions.map((q: any, i: number) => (
        <View key={q.question_id} style={[s.qRow, q.diagram_type && s.qRowWithDiagram]}>
          {q.diagram_type && <QuestionDiagram q={q} />}
          <View style={{ flex: 1 }}>
            <Text style={s.qText}>
              {i + 1}. {q.prompt}
              {q.question_type === "multiple_choice" && q.choices ? `  (${q.choices.join(" / ")})` : ""}
            </Text>
            {q.question_type === "short_response" && <View style={s.qLine} />}
          </View>
        </View>
      ))}
    </View>
  );
}

export function WeeklyPacketBody({
  packet, isLoading, error, emptyMessage, mascotLine,
}: {
  packet: PracticePacket | undefined;
  isLoading: boolean;
  error: unknown;
  emptyMessage: string;
  mascotLine?: string;
}) {
  const { shortAnswer, spaceHeavy, puzzles, numberByCatId, wordSearches } = useWeeklyPacketDisplay(packet);

  if (isLoading) {
    return <ActivityIndicator color={colors.brand} size="large" style={{ marginTop: 40 }} />;
  }
  if (error) {
    return <Text style={s.errorText}>{(error as Error).message}</Text>;
  }
  if (!packet || packet.categories.length === 0) {
    return <Text style={s.emptyText}>{emptyMessage}</Text>;
  }

  return (
    <>
      <Text style={s.mascotLine}>{mascotLine ?? "🦉 Hi, I'm Ollie the Owl — your Little Scholars Hub guide!"}</Text>
      <Text style={s.packetTitle}>{packet.title}</Text>
      <Text style={s.packetSubtitle}>Week of {packet.week_of} · {packet.categories.length} categories</Text>

      {/* Short-answer categories — 2 per row */}
      <View style={s.grid}>
        {shortAnswer.map(cat => (
          <CategoryCard key={cat.category_id} cat={cat} num={numberByCatId.get(cat.category_id)!} style={s.cardHalf} />
        ))}
      </View>

      {/* Space-heavy categories — full width */}
      {spaceHeavy.map(cat => (
        <CategoryCard key={cat.category_id} cat={cat} num={numberByCatId.get(cat.category_id)!} style={s.cardFull} />
      ))}

      {/* Puzzle categories — full width, with rendered word-search grid */}
      {puzzles.map(cat => (
        <View key={cat.category_id} style={[s.card, s.cardFull]}>
          <Text style={[s.cardTitle, { color: SUBJECT_META.puzzle.color }]}>
            {numberByCatId.get(cat.category_id)}. {cat.category_name}
          </Text>
          <Text style={s.cardInstr}>{cat.questions[0]?.prompt}</Text>
          {wordSearches[cat.category_id] && (
            <View style={s.wsGrid}>
              {wordSearches[cat.category_id].grid.map((row, r) => (
                <View key={r} style={s.wsRow}>
                  {row.map((ch, c) => (
                    <View key={c} style={s.wsCell}><Text style={s.wsCellText}>{ch}</Text></View>
                  ))}
                </View>
              ))}
            </View>
          )}
        </View>
      ))}

      {/* Answer key — continuous list, matching the printed packet's style */}
      <Text style={s.keyHeading}>Answer Key</Text>
      {packet.categories.map(cat => (
        <Text key={cat.category_id} style={s.keyLine}>
          <Text style={s.keyLineNum}>{numberByCatId.get(cat.category_id)}. {cat.category_name}: </Text>
          {cat.questions.map((q: any) => q.answer).join(", ")}
        </Text>
      ))}
    </>
  );
}

// ── Print HTML assembly ─────────────────────────────────────────────────
function esc(s: string) {
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

function diagramHtml(q: any): string {
  if (q.diagram_type === "clock" && q.diagram_data) {
    const hour = q.diagram_data.hour ?? 12;
    const minute = q.diagram_data.minute ?? 0;
    const hourDeg = ((hour % 12) + minute / 60) * 30;
    const minDeg = minute * 6;
    return `
      <div class="clock">
        <div class="hand hour" style="transform:translateX(-50%) rotate(${hourDeg}deg)"></div>
        <div class="hand min" style="transform:translateX(-50%) rotate(${minDeg}deg)"></div>
        <div class="pin"></div>
      </div>`;
  }
  if (q.diagram_type === "emoji" && q.diagram_data?.emoji) {
    return `<div class="emoji-diagram">${q.diagram_data.emoji}</div>`;
  }
  if (q.diagram_type === "ten_frame" && q.diagram_data) {
    const count = q.diagram_data.count ?? 0;
    const cells = Array.from({ length: 10 }, (_, i) => i < count);
    const rowHtml = (row: boolean[]) => row.map(f => `<span class="tf-cell${f ? " filled" : ""}"></span>`).join("");
    return `<div class="ten-frame">
      <div class="tf-row">${rowHtml(cells.slice(0, 5))}</div>
      <div class="tf-row">${rowHtml(cells.slice(5, 10))}</div>
    </div>`;
  }
  if (q.diagram_type === "angle" && q.diagram_data) {
    const degrees = q.diagram_data.degrees ?? 90;
    return `<div class="angle-box">
      <div class="angle-ray" style="transform:rotate(0deg)"></div>
      <div class="angle-ray" style="transform:rotate(-${degrees}deg)"></div>
      <div class="angle-vertex"></div>
    </div>`;
  }
  if (q.diagram_type === "rectangle_dims" && q.diagram_data) {
    const { width, height, unit = "" } = q.diagram_data;
    const maxDim = 50;
    const ratio = width / height;
    const boxW = ratio >= 1 ? maxDim : maxDim * ratio;
    const boxH = ratio >= 1 ? maxDim / ratio : maxDim;
    return `<div class="rect-dims">
      <div class="rd-top">${esc(String(width))}${esc(unit)}</div>
      <div class="rd-row">
        <div class="rd-box" style="width:${boxW}px;height:${boxH}px"></div>
        <div class="rd-side">${esc(String(height))}${esc(unit)}</div>
      </div>
    </div>`;
  }
  if (q.diagram_type === "coordinate_point" && q.diagram_data) {
    const { x, y, size = 6 } = q.diagram_data;
    const cell = 7;
    const gridPx = size * 2 * cell;
    const centerPx = size * cell;
    const px = centerPx + x * cell;
    const py = centerPx - y * cell;
    return `<div class="coord-grid" style="width:${gridPx}px;height:${gridPx}px">
      <div class="coord-axis coord-axis-v" style="left:${centerPx}px"></div>
      <div class="coord-axis coord-axis-h" style="top:${centerPx}px"></div>
      <div class="coord-dot" style="left:${px - 3}px;top:${py - 3}px"></div>
    </div>`;
  }
  return "";
}

const GRADE_DISPLAY: Record<string, string> = {
  TK: "TK", K: "Kindergarten", "1st": "Grade 1", "2nd": "Grade 2", "3rd": "Grade 3",
  "4th": "Grade 4", "5th": "Grade 5", "6th": "Grade 6",
};

function gradeDisplayName(packet: { title: string }) {
  const gradeLabel = packet.title.replace(/\s*Weekly Practice Packet$/i, "").trim();
  return GRADE_DISPLAY[gradeLabel] ?? gradeLabel;
}

/** Short single-line prompts (drill facts, fill-in-the-blank) read fine in
 * two columns; anything with a full sentence needs the full page width. */
function questionColumns(cat: any): 1 | 2 {
  const avgLen = cat.questions.reduce((sum: number, q: any) => sum + q.prompt.length, 0) / (cat.questions.length || 1);
  return avgLen <= 40 ? 2 : 1;
}

function buildPrintHtml(packet: PracticePacket, wordSearches: Record<number, WordSearchResult>) {
  const districtLine = `${gradeDisplayName(packet)} · Week 1 · ABC Unified School District`;
  const weekNum = WEEK_OPTIONS_2026.find(w => w.value === packet.week_of)?.weekNum;
  const hasPuzzle = packet.categories.some(c => c.layout_type === "puzzle");

  const pageHeader = `
    <div class="pageheader">
      <span>Name: <span class="nameline"></span></span>
      <span class="brandblock"><strong>Little Scholar Hub</strong><br/>${esc(districtLine)}</span>
    </div>
    <hr class="rule"/>`;

  const questionHtml = (q: any, i: number) => `
    <div class="q ${q.diagram_type ? "q-with-diagram" : ""}">
      ${diagramHtml(q)}
      <div class="q-body">
        <span><b>${i + 1}.</b> ${esc(q.prompt).replace(/\n/g, "<br/>")}${q.question_type === "multiple_choice" && q.choices ? `  (${esc(q.choices.join(" / "))})` : ""}</span>
        ${q.question_type === "short_response" ? '<div class="line"></div>' : ""}
      </div>
    </div>`;

  const categoryHtml = (cat: any, num: number) => {
    const meta = SUBJECT_META[cat.subject_area] ?? SUBJECT_META.math;
    const cols = questionColumns(cat);
    const qs = cat.questions.map((q: any, i: number) => questionHtml(q, i));
    const qsHtml = cols === 2
      ? `<div class="qcols">${qs.join("")}</div>`
      : qs.join("");
    return `
      <article class="box">
        <h2 style="color:${meta.color}">${num}. ${esc(cat.category_name)}</h2>
        <p class="instr">${meta.label} · ${esc(guessInstruction(cat))}</p>
        ${cat.intro_text ? `<div class="passage">${esc(cat.intro_text).replace(/\n/g, "<br/>")}</div>` : ""}
        ${qsHtml}
      </article>`;
  };

  const puzzleHtml = (cat: any, num: number) => {
    const ws = wordSearches[cat.category_id];
    const gridHtml = ws ? ws.grid.map(row => `<div class="ws-row">${row.map(ch => `<span class="ws-cell">${ch}</span>`).join("")}</div>`).join("") : "";
    return `
      <article class="box">
        <h2 style="color:${SUBJECT_META.puzzle.color}">${num}. ${esc(cat.category_name)}</h2>
        <p class="instr">Fun Break · ${esc(cat.questions[0]?.prompt ?? "")}</p>
        <div class="ws-grid">${gridHtml}</div>
      </article>`;
  };

  const contentHtml = packet.categories.map((cat, i) =>
    cat.layout_type === "puzzle" ? puzzleHtml(cat, i + 1) : categoryHtml(cat, i + 1)
  ).join("");

  const keyHtml = packet.categories.map((cat, i) => `
    <p class="keyline"><b>${i + 1}. ${esc(cat.category_name)}:</b> ${cat.questions.map(q => esc(q.answer)).join(", ")}</p>`
  ).join("");

  return `<!DOCTYPE html><html><head><meta charset="utf-8"><title>${esc(packet.title)}</title>
  <style>
    * { box-sizing: border-box; }
    body { font-family: Georgia, 'Times New Roman', serif; color: #221c33; margin: 0; }
    .sansbody, .instr, .q, .keyline, .nameline, .brandblock { font-family: -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif; }
    .sheet { width: 100%; padding: 0.5in 0.6in; page-break-after: always; }
    .sheet:last-child { page-break-after: auto; }

    .cover { text-align: center; padding-top: 1.3in; }
    .cover .mascot { font-size: 56px; margin-bottom: 10px; }
    .cover h1 { font-size: 30px; color: #4a3f7a; margin: 0 0 8px; }
    .cover .sub { font-size: 15px; color: #55506b; margin: 0 0 28px; }
    .cover .infobox { display: inline-block; border: 2px solid #7a6bbf; border-radius: 14px; padding: 18px 30px;
                       font-size: 13.5px; color: #3a3355; line-height: 1.7; font-family: -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif; }
    .cover .mascot-line { margin-top: 24px; font-size: 13px; color: #55506b; font-style: italic;
                           font-family: -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif; }

    .pageheader { display: flex; justify-content: space-between; align-items: flex-start; font-size: 13px;
                  font-family: -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif; }
    .nameline { display: inline-block; width: 220px; border-bottom: 1px solid #221c33; margin-left: 4px; }
    .brandblock { text-align: right; font-size: 11.5px; color: #55506b; line-height: 1.5; }
    .rule { border: none; border-top: 2px solid #221c33; margin: 6px 0 18px; }

    .box { border: 2px solid #b7a9e8; border-radius: 12px; padding: 14px 16px; margin-bottom: 16px; break-inside: avoid; }
    .box h2 { margin: 0 0 2px; font-size: 16px; }
    .instr { margin: 0 0 10px; font-style: italic; color: #6b628c; font-size: 12px; }
    .passage { font-size: 12.5px; line-height: 1.6; background: #f7f5fc; border-radius: 8px; padding: 10px 12px; margin-bottom: 10px; white-space: pre-line; }
    .q { font-size: 13px; line-height: 1.6; margin-bottom: 9px; }
    .q-with-diagram { display: flex; align-items: center; gap: 10px; }
    .q-body { flex: 1; }
    .qcols { display: grid; grid-template-columns: 1fr 1fr; gap: 4px 20px; }
    .line { border-bottom: 1px dotted #6b628c; height: 16px; margin-top: 2px; }

    .clock { width: 32px; height: 32px; border-radius: 50%; border: 2px solid #221c33; position: relative; flex-shrink: 0; background: #fff; }
    .clock .hand { position: absolute; left: 50%; bottom: 50%; transform-origin: bottom center; background: #221c33; border-radius: 2px; }
    .clock .hand.hour { width: 2.5px; height: 8px; }
    .clock .hand.min { width: 2px; height: 12px; }
    .clock .pin { position: absolute; left: 50%; top: 50%; width: 4px; height: 4px; margin: -2px; border-radius: 50%; background: #221c33; }
    .emoji-diagram { font-size: 20px; flex-shrink: 0; }

    .ten-frame { display: inline-flex; flex-direction: column; gap: 2px; flex-shrink: 0; }
    .tf-row { display: flex; gap: 2px; }
    .tf-cell { width: 12px; height: 12px; border: 1.5px solid #221c33; border-radius: 2px; background: #fff; }
    .tf-cell.filled { background: #453aa8; border-color: #453aa8; }

    .angle-box { width: 44px; height: 34px; position: relative; flex-shrink: 0; }
    .angle-ray { position: absolute; left: 4px; bottom: 4px; width: 36px; height: 2px; background: #221c33; transform-origin: left center; }
    .angle-vertex { position: absolute; left: 1px; bottom: 1px; width: 6px; height: 6px; margin-left: -3px; margin-bottom: -3px; border-radius: 50%; background: #221c33; }

    .rect-dims { display: inline-flex; flex-direction: column; align-items: center; gap: 2px; flex-shrink: 0; font-size: 10px; }
    .rd-top { font-weight: 700; }
    .rd-row { display: flex; align-items: center; gap: 4px; }
    .rd-box { border: 2px solid #453aa8; background: #eeecfb; }
    .rd-side { font-weight: 700; }

    .coord-grid { position: relative; border: 1px solid #b7a9e8; background: #f7f5fc; flex-shrink: 0; }
    .coord-axis { position: absolute; background: #6b628c; }
    .coord-axis-v { top: 0; bottom: 0; width: 1px; }
    .coord-axis-h { left: 0; right: 0; height: 1px; }
    .coord-dot { position: absolute; width: 6px; height: 6px; border-radius: 50%; background: #a83f2a; }

    .ws-grid { display: inline-flex; flex-direction: column; gap: 1px; background: #b7a9e8; border: 2px solid #b7a9e8; border-radius: 6px; overflow: hidden; margin-top: 6px; }
    .ws-row { display: flex; gap: 1px; }
    .ws-cell { width: 22px; height: 22px; background: #fff; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: bold;
               font-family: -apple-system, 'Segoe UI', Helvetica, Arial, sans-serif; }

    .keyheader { color: #4a3f7a; font-size: 20px; margin: 0 0 4px; }
    .keysub { color: #6b628c; font-size: 12px; margin: 0 0 16px; }
    .keyline { font-size: 12px; line-height: 1.6; margin: 0 0 8px; break-inside: avoid; }
    @page { size: letter; margin: 0.5in; }
  </style></head>
  <body>
    <div class="sheet cover">
      <div class="mascot">🦉</div>
      <h1>${esc(gradeDisplayName(packet))} Weekly Practice Packet</h1>
      <p class="sub">${weekNum ? `Week ${weekNum}` : "Week 1"} &nbsp;|&nbsp; ABC Unified School District</p>
      <div class="infobox">
        Little Scholar Hub<br/>
        ${packet.categories.length} Practice Categories &middot; Mixed Subjects<br/>
        ${hasPuzzle ? "Word Puzzle &middot; " : ""}Full Answer Key Included
      </div>
      <p class="mascot-line">🦉 Hi, I'm Ollie the Owl — your Little Scholars Hub guide. Let's practice together!</p>
    </div>
    <div class="sheet">
      ${pageHeader}
      ${contentHtml}
    </div>
    <div class="sheet">
      <h1 class="keyheader">Answer Key</h1>
      <p class="keysub">${esc(gradeDisplayName(packet))} · ${weekNum ? `Week ${weekNum}` : "Week 1"} · ${esc(packet.week_of)}</p>
      ${keyHtml}
    </div>
  </body></html>`;
}

const s = StyleSheet.create({
  errorText: { color: "#c0392b", textAlign: "center", marginTop: 40 },
  emptyText: { color: colors.textMuted, textAlign: "center", marginTop: 40, fontSize: 14, paddingHorizontal: 20 },
  mascotLine: { fontSize: 13, fontStyle: "italic", color: colors.textMuted, textAlign: "center", marginBottom: 6 },
  packetTitle: { fontSize: 22, fontWeight: "900", color: colors.brand, textAlign: "center" },
  packetSubtitle: { fontSize: 13, color: colors.textMuted, textAlign: "center", marginBottom: 18 },

  grid: { flexDirection: "row", flexWrap: "wrap", gap: 12 },
  card: { borderWidth: 2, borderColor: colors.border, borderRadius: 14, padding: 14, backgroundColor: "white", marginBottom: 12 },
  cardHalf: { flexBasis: "48%", flexGrow: 1, minWidth: 260 },
  cardFull: { flexBasis: "100%" },
  cardTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 2 },
  cardInstr: { fontSize: 12, fontStyle: "italic", color: colors.textMuted, marginBottom: 10 },
  introText: { fontSize: 13, color: colors.text, lineHeight: 19, marginBottom: 10, backgroundColor: colors.surfaceAlt,
               borderRadius: 8, padding: 10 },
  qRow: { marginBottom: 8 },
  qText: { fontSize: 13.5, color: colors.text, lineHeight: 20 },
  qLine: { borderBottomWidth: 1, borderBottomColor: colors.border, borderStyle: "dotted", height: 18, marginTop: 4 },
  qRowWithDiagram: { flexDirection: "row", alignItems: "center", gap: 10 },

  clockFace: { width: 46, height: 46, borderRadius: 23, borderWidth: 2.5, borderColor: colors.text,
               backgroundColor: "white", position: "relative", flexShrink: 0 },
  clockHand: { position: "absolute", left: "50%", top: "50%", backgroundColor: colors.text, borderRadius: 2 },
  clockHourHand: { width: 3, height: 11, marginLeft: -1.5, marginTop: -11, transformOrigin: "center bottom" } as any,
  clockMinHand: { width: 2, height: 16, marginLeft: -1, marginTop: -16, transformOrigin: "center bottom" } as any,
  clockPin: { position: "absolute", left: "50%", top: "50%", width: 4, height: 4, marginLeft: -2, marginTop: -2,
              borderRadius: 2, backgroundColor: colors.text },
  emojiDiagram: { fontSize: 28, flexShrink: 0 },

  tenFrame: { gap: 3, flexShrink: 0 },
  tenFrameRow: { flexDirection: "row", gap: 3 },
  tenFrameCell: { width: 14, height: 14, borderWidth: 1.5, borderColor: colors.text, borderRadius: 3, backgroundColor: "white" },
  tenFrameCellFilled: { backgroundColor: colors.brand, borderColor: colors.brand },

  angleBox: { width: 52, height: 40, position: "relative", flexShrink: 0 },
  angleRay: { position: "absolute", left: 4, bottom: 4, width: 42, height: 2.5, backgroundColor: colors.text, transformOrigin: "left center" } as any,
  angleVertex: { position: "absolute", left: 1, bottom: 1, width: 7, height: 7, marginLeft: -3.5, marginBottom: -3.5, borderRadius: 4, backgroundColor: colors.text },

  rectDimsWrap: { alignItems: "center", gap: 3, flexShrink: 0 },
  rectDimsTopLabel: { fontSize: 11, fontWeight: "800", color: colors.text },
  rectDimsBox: { borderWidth: 2.5, borderColor: colors.brand, backgroundColor: colors.brandLight },
  rectDimsSideLabel: { fontSize: 11, fontWeight: "800", color: colors.text, marginLeft: 6 },

  coordGrid: { position: "relative", borderWidth: 1, borderColor: colors.border, backgroundColor: colors.surfaceAlt, flexShrink: 0 },
  coordAxis: { position: "absolute", backgroundColor: colors.textMuted },
  coordDot: { position: "absolute", width: 8, height: 8, borderRadius: 4, backgroundColor: "#a83f2a" },

  wsGrid: { alignSelf: "center", gap: 1, backgroundColor: colors.border, borderRadius: 8, overflow: "hidden", padding: 1, marginTop: 8 },
  wsRow: { flexDirection: "row", gap: 1 },
  wsCell: { width: 24, height: 24, backgroundColor: "white", alignItems: "center", justifyContent: "center" },
  wsCellText: { fontSize: 12, fontWeight: "800" },

  keyHeading: { fontSize: 18, fontWeight: "900", color: colors.brand, marginTop: 8, marginBottom: 12 },
  keyLine: { fontSize: 12.5, color: colors.text, lineHeight: 21, marginBottom: 6 },
  keyLineNum: { fontWeight: "800", color: colors.brand },
});
