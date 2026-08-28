/**
 * Typeahead search for real US public schools, backed by the OpenDataSoft
 * "us-public-schools" public dataset. Free-text entry still works — this
 * just offers verified suggestions as the teacher types.
 *
 * On web, the suggestion list is rendered via a direct DOM portal
 * (ReactDOM.createPortal to document.body) rather than React Native's
 * `Modal` — RN Web's Modal does focus-trapping (steals focus on mount,
 * restores it on unmount), which combined with our onFocus-reopen logic
 * caused an infinite open→blur→close→refocus→reopen loop. A plain portal
 * has no focus trap, so it just floats on top of everything without
 * fighting the input for focus, and still escapes any parent
 * overflow/stacking-context clipping.
 */
import { useMemo, useRef, useState } from "react";
import {
  View, TextInput, TouchableOpacity, Text, StyleSheet, ActivityIndicator,
  Dimensions, Platform,
} from "react-native";
import { createPortal } from "react-dom";
import { colors } from "../constants/theme";

interface SchoolResult { name: string; city: string; state: string; }

interface Props {
  value: string;
  onChangeText: (v: string) => void;
  placeholder?: string;
  style?: any;
}

function titleCase(str: string) {
  return (str || "").toLowerCase().replace(/\b\w/g, c => c.toUpperCase());
}

// The dataset abbreviates generic institution words inconsistently
// ("EL", "ELEM", "ELEM SCHOOL", "ELEMENTARY") — a literal substring match on
// a full phrase like "leal elementary school" won't hit "LEAL ELEM SCHOOL".
// Strip generic words and search on what's actually distinctive instead.
const GENERIC_WORDS = new Set([
  "elementary", "school", "schools", "elem", "el", "primary", "middle",
  "intermediate", "high", "academy", "unified", "public", "charter",
  "district", "junior", "jr", "senior", "sr", "center", "of", "the", "for",
]);

function buildSearchTokens(query: string): string[] {
  const words = query.trim().toLowerCase().split(/\s+/).filter(w => w.length >= 2);
  const distinctive = words.filter(w => !GENERIC_WORDS.has(w));
  return distinctive.length > 0 ? distinctive : words;
}

const DROPDOWN_MAX_HEIGHT = 260;

export function SchoolSearchInput({ value, onChangeText, placeholder, style }: Props) {
  const [results, setResults] = useState<SchoolResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [open, setOpen]       = useState(false);
  const [error, setError]     = useState<string | null>(null);
  const [searched, setSearched] = useState(false);
  const [anchor, setAnchor] = useState<{ x: number; y: number; width: number; height: number } | null>(null);
  const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const wrapRef  = useRef<View>(null);

  const measure = (cb?: () => void) => {
    wrapRef.current?.measureInWindow((x, y, width, height) => {
      setAnchor({ x, y, width, height });
      cb?.();
    });
  };

  const handleChange = (text: string) => {
    onChangeText(text);
    if (timerRef.current) clearTimeout(timerRef.current);

    const query = text.trim();
    if (query.length < 3) {
      setResults([]);
      setOpen(false);
      setError(null);
      setSearched(false);
      return;
    }

    // Open (and anchor) immediately, once, for this typing session — the
    // dropdown then stays mounted and just updates its inner content as
    // results come in, instead of unmounting/remounting every keystroke.
    setLoading(true);
    if (!open) measure(() => setOpen(true));

    timerRef.current = setTimeout(async () => {
      setError(null);
      try {
        const tokens = buildSearchTokens(query);
        const where = tokens
          .map(t => `name like '%${t.replace(/'/g, "''")}%'`)
          .join(" and ");
        const url = "https://public.opendatasoft.com/api/explore/v2.1/catalog/datasets/us-public-schools/records"
          + `?where=${encodeURIComponent(where)}&limit=8`;
        const res = await fetch(url);
        if (!res.ok) throw new Error(`Lookup failed (${res.status})`);
        const json = await res.json();
        const rows: SchoolResult[] = (json.results || []).map((r: any) => ({
          name: r.name, city: r.city, state: r.state,
        }));
        setResults(rows);
        setSearched(true);
      } catch (e: any) {
        setResults([]);
        setSearched(true);
        setError(e?.message || "Couldn't reach the school directory — you can still type the name manually.");
        console.error("SchoolSearchInput lookup failed:", e);
      } finally {
        setLoading(false);
      }
    }, 400);
  };

  const pick = (r: SchoolResult) => {
    onChangeText(`${titleCase(r.name)} — ${titleCase(r.city)}, ${r.state}`);
    setOpen(false);
  };

  const handleFocus = () => {
    if (results.length > 0 || error) measure(() => setOpen(true));
  };

  const handleBlur = () => {
    // Delay so a tap on a dropdown row registers before we close it.
    setTimeout(() => setOpen(false), 150);
  };

  const dropdownPosition = useMemo(() => {
    if (!anchor) return null;
    const windowHeight = Dimensions.get("window").height;
    const openUpward = anchor.y + anchor.height + DROPDOWN_MAX_HEIGHT > windowHeight;
    return {
      // Portaled straight to <body> on web — "fixed" anchors to the
      // viewport, matching measureInWindow's viewport-relative coordinates
      // exactly regardless of page scroll position.
      position: (Platform.OS === "web" ? "fixed" : "absolute") as any,
      left: anchor.x,
      width: anchor.width,
      ...(openUpward
        ? { bottom: windowHeight - anchor.y + 6 }
        : { top: anchor.y + anchor.height + 6 }),
    };
  }, [anchor]);

  const dropdownContent = open && dropdownPosition && (
    <View style={[s.dropdown, dropdownPosition]}>
      {error ? (
        <Text style={s.statusText}>{error}</Text>
      ) : results.length === 0 && loading ? (
        <View style={s.loadingRow}>
          <ActivityIndicator size="small" color={colors.brand} />
          <Text style={s.loadingText}>Searching…</Text>
        </View>
      ) : results.length === 0 && searched ? (
        <Text style={s.statusText}>No matches — try just the school's distinctive name (e.g. "Leal" not "Leal Elementary").</Text>
      ) : (
        results.map((r, i) => (
          <TouchableOpacity
            key={i}
            style={[s.row, i === results.length - 1 && s.rowLast]}
            onPress={() => pick(r)}
          >
            <Text style={s.rowIcon}>🏫</Text>
            <View style={{ flex: 1 }}>
              <Text style={s.rowName} numberOfLines={1}>{titleCase(r.name)}</Text>
              <Text style={s.rowMeta}>{titleCase(r.city)}, {r.state}</Text>
            </View>
          </TouchableOpacity>
        ))
      )}
    </View>
  );

  return (
    <View ref={wrapRef} style={[s.wrap, style]} collapsable={false}>
      <TextInput
        style={s.input}
        placeholder={placeholder ?? "School name (optional)"}
        value={value}
        onChangeText={handleChange}
        onFocus={handleFocus}
        onBlur={handleBlur}
      />
      {loading && <ActivityIndicator size="small" color={colors.brand} style={s.spinner} />}

      {Platform.OS === "web"
        ? (dropdownContent && typeof document !== "undefined" ? createPortal(dropdownContent, document.body) : null)
        : dropdownContent}
    </View>
  );
}

const s = StyleSheet.create({
  wrap:  { position: "relative" },
  input: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
           paddingHorizontal: 14, paddingVertical: 12, fontSize: 14, color: colors.text },
  spinner: { position: "absolute", right: 12, top: 12 },
  dropdown: { position: "absolute", backgroundColor: "white", borderRadius: 16,
              borderWidth: 1, borderColor: colors.border, paddingVertical: 6,
              maxHeight: DROPDOWN_MAX_HEIGHT, overflow: "hidden",
              shadowColor: "#000", shadowOpacity: 0.16, shadowRadius: 20, shadowOffset: { width: 0, height: 6 },
              elevation: 8 },
  row:   { flexDirection: "row", alignItems: "center", gap: 12,
           paddingHorizontal: 16, paddingVertical: 12,
           borderBottomWidth: 1, borderBottomColor: "#f1f0fa" },
  rowLast: { borderBottomWidth: 0 },
  rowIcon: { fontSize: 16 },
  rowName:{ fontSize: 14, fontWeight: "600", color: colors.text },
  rowMeta:{ fontSize: 12, color: colors.textMuted, marginTop: 2 },
  statusText: { fontSize: 12, color: colors.textMuted, padding: 14, lineHeight: 18 },
  loadingRow: { flexDirection: "row", alignItems: "center", gap: 10, padding: 14 },
  loadingText: { fontSize: 12, color: colors.textMuted },
});
