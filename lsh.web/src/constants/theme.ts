import { Platform } from "react-native";

// ── Palette — editorial-soft, matches venerable-gnome-807695.netlify.app ──────
export const colors = {
  brand:      "#d8785f",   // dusty coral
  brandDark:  "#b55e48",
  brandLight: "#fff6ef",   // light coral tint
  accent:     "#e6c76a",   // dusty mustard
  blue:       "#7a96b2",   // muted slate blue
  green:      "#9fb298",   // dusty sage
  pink:       "#e4a5a3",   // dusty rose
  purple:     "#a89cb3",   // dusty lavender
  chinese:    "#fff8f0",
  indian:     "#fff5f5",
  hispanic:   "#f5fff5",
  surface:    "#ffffff",
  surfaceAlt: "#f1e9dc",   // warm sand
  bg:         "#faf6ef",   // warm cream base
  text:       "#2b2a27",   // soft warm charcoal
  textMuted:  "#8a847b",   // warm gray
  border:     "#e8e0d2",
  shadow:     "rgba(60, 45, 30, 0.06)",
  success:    "#9fb298",
  danger:     "#d8785f",
  warning:    "#e6c76a",
};

// ── Typography — Fraunces (serif) headings, Inter body ────────────────────────
export const fonts = {
  heading: Platform.OS === "web" ? "'Fraunces', Georgia, serif" : undefined,
  body:    Platform.OS === "web" ? "'Inter', system-ui, sans-serif" : undefined,
};

export const SUBJECT_META: Record<string, { icon: string; label: string; color: string; subjectId: number }> = {
  math:     { icon: "🧮", label: "Math",                color: "#dbeafe", subjectId: 3  },
  phonics:  { icon: "📖", label: "English & Phonics",   color: "#fef9c3", subjectId: 1  },
  reading:  { icon: "📚", label: "Reading",             color: "#dcfce7", subjectId: 2  },
  art:      { icon: "🎨", label: "Art & Creativity",    color: "#fce7f3", subjectId: 4  },
  story:    { icon: "🐉", label: "Story Activities",    color: "#fff0f6", subjectId: 5  },
  workbooks:{ icon: "📕", label: "Workbooks",           color: "#fef3c7", subjectId: 6  },
  logic:    { icon: "🧩", label: "Logic & Thinking",    color: "#f3e8ff", subjectId: 7  },
  feelings: { icon: "💛", label: "Feelings & Emotions", color: "#fff7ed", subjectId: 8  },
  manners:  { icon: "🌱", label: "Character & Manners", color: "#ecfdf5", subjectId: 9  },
  pinyin:   { icon: "🏮", label: "Pinyin",              color: "#fff1f2", subjectId: 10 },
  hanzi:    { icon: "🏮", label: "汉字 Hanzi",          color: "#fff1f2", subjectId: 11 },
  tangshi:  { icon: "📜", label: "唐诗 Tang Poems",     color: "#fffbeb", subjectId: 12 },
  gita:     { icon: "🪔", label: "Gita Stories",        color: "#fce7f3", subjectId: 13 },
  letras:   { icon: "🌻", label: "Letras",              color: "#f0fdf4", subjectId: 14 },
  fiestas:  { icon: "🎉", label: "Fiestas",             color: "#fff7ed", subjectId: 15 },
  maestros: { icon: "🎭", label: "Maestros",            color: "#f5f3ff", subjectId: 16 },
  writing:  { icon: "✍️", label: "Writing",             color: "#fef2f2", subjectId: 18 },
  science:  { icon: "🔬", label: "Science",             color: "#eff6ff", subjectId: 19 },
};

export const CULTURAL_TRACKS = [
  {
    emoji: "🏮",
    title: "Chinese Track",
    desc: "Pinyin → 汉字 → 唐诗",
    bg: colors.chinese,
    subjects: ["pinyin", "hanzi", "tangshi"],
  },
  {
    emoji: "🪔",
    title: "Indian Track",
    desc: "Gita Stories + Art + Character",
    bg: colors.indian,
    subjects: ["gita"],
  },
  {
    emoji: "🌻",
    title: "Hispanic Track",
    desc: "Letras · Fiestas · Maestros",
    bg: colors.hispanic,
    subjects: ["letras", "fiestas", "maestros"],
  },
];

export const GRADES = [
  { grade_id: 0, label: "TK" },
  { grade_id: 1, label: "K" },
  { grade_id: 2, label: "1st" },
  { grade_id: 3, label: "2nd" },
  { grade_id: 4, label: "3rd" },
  { grade_id: 5, label: "4th" },
  { grade_id: 6, label: "5th" },
  { grade_id: 7, label: "6th" },
];
