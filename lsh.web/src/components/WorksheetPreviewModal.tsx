/**
 * WorksheetPreviewModal — polished, glossy preview shown when a worksheet
 * (or subject card) is tapped. Primary action plays it as an in-app game;
 * downloading the PDF is optional. Reused on the public landing + in-app.
 */
import { Platform, View, Text, TouchableOpacity, StyleSheet, Linking } from "react-native";
import { Modal } from "./ui/Modal";
import { colors, SUBJECT_META } from "../constants/theme";

export interface PreviewWorksheet {
  title?: string;
  description?: string;
  subject?: string;
  grade_id?: number;
  pdf_url?: string;
  is_free?: boolean;
  rating_avg?: number;
  rating_count?: number;
  view_count?: number;
  teacher_name?: string;
  estimated_min?: number;
  page_count?: number;
}

interface Props {
  worksheet: PreviewWorksheet | null;
  visible: boolean;
  gradeLabel?: string | number;
  playLabel?: string;         // e.g. "Play a sample" (public) or "Play in app"
  onClose: () => void;
  onPlay: () => void;
  onSignup?: () => void;
  onPrint?: () => void;       // logged-in only — sends the PDF straight to the printer
  onAssign?: () => void;      // logged-in only — "Assign to Kid" / "Assign to Student"
  assignLabel?: string;
}

export function WorksheetPreviewModal({
  worksheet, visible, gradeLabel, playLabel = "Play in app", onClose, onPlay, onSignup,
  onPrint, onAssign, assignLabel = "Assign",
}: Props) {
  if (!worksheet) return <Modal visible={visible} onClose={onClose}><View /></Modal>;

  const meta   = SUBJECT_META[worksheet.subject ?? ""] || null;
  const color  = meta?.color || colors.surfaceAlt;
  const icon   = meta?.icon || "📄";
  const canDl  = !!(worksheet.is_free && worksheet.pdf_url);

  return (
    <Modal
      visible={visible}
      onClose={onClose}
      title={worksheet.title}
      subtitle={`${meta?.label || worksheet.subject || "Worksheet"}${gradeLabel != null ? ` · Grade ${gradeLabel}` : ""}`}
    >
      {/* Glossy icon tile */}
      <View style={[s.thumb, { backgroundColor: color }]}>
        <View style={s.sheen} />
        <Text style={s.icon}>{icon}</Text>
      </View>

      {!!worksheet.description && <Text style={s.desc}>{worksheet.description}</Text>}

      {/* Stat chips */}
      <View style={s.stats}>
        {!!worksheet.estimated_min && <Chip>⏱️ ~{worksheet.estimated_min} min</Chip>}
        {!!worksheet.page_count && <Chip>📄 {worksheet.page_count} pages</Chip>}
        {!!worksheet.rating_avg && Number(worksheet.rating_avg) > 0 && (
          <Chip>⭐ {Number(worksheet.rating_avg).toFixed(1)}{worksheet.rating_count ? ` (${worksheet.rating_count})` : ""}</Chip>
        )}
        {!!worksheet.view_count && Number(worksheet.view_count) > 0 && <Chip>⬇ {fmt(worksheet.view_count)}</Chip>}
        {!!worksheet.teacher_name && <Chip>✍️ {worksheet.teacher_name}</Chip>}
      </View>

      {/* Actions — Play primary, Download secondary */}
      <TouchableOpacity style={s.playBtn} onPress={onPlay} activeOpacity={0.9}>
        <Text style={s.playText}>▶  {playLabel}</Text>
      </TouchableOpacity>

      {onAssign && (
        <TouchableOpacity style={s.playBtn} onPress={onAssign} activeOpacity={0.9}>
          <Text style={s.playText}>📌  {assignLabel}</Text>
        </TouchableOpacity>
      )}

      <View style={s.secondaryRow}>
        {canDl && (
          <TouchableOpacity style={[s.dlBtn, s.secondaryBtn]} onPress={() => Linking.openURL(worksheet.pdf_url!)} activeOpacity={0.9}>
            <Text style={s.dlText}>📄  Download</Text>
          </TouchableOpacity>
        )}
        {onPrint && worksheet.pdf_url && (
          <TouchableOpacity style={[s.dlBtn, s.secondaryBtn]} onPress={onPrint} activeOpacity={0.9}>
            <Text style={s.dlText}>🖨️  Print</Text>
          </TouchableOpacity>
        )}
      </View>

      {onSignup && (
        <TouchableOpacity style={s.linkBtn} onPress={onSignup}>
          <Text style={s.linkText}>Sign up for the full library  →</Text>
        </TouchableOpacity>
      )}
    </Modal>
  );
}

const Chip = ({ children }: { children: React.ReactNode }) => (
  <View style={s.chip}><Text style={s.chipText}>{children}</Text></View>
);

function fmt(n: number) { return n >= 1000 ? `${(n / 1000).toFixed(1)}k` : `${n}`; }

const isWeb = Platform.OS === "web";
const fBody: any = isWeb ? { fontFamily: "'Inter', system-ui, sans-serif" } : {};

const s = StyleSheet.create({
  thumb: { height: 150, borderRadius: 20, alignItems: "center", justifyContent: "center", overflow: "hidden",
           shadowColor: "#000", shadowOpacity: 0.12, shadowRadius: 12, shadowOffset: { width: 0, height: 6 }, elevation: 4 },
  sheen: { position: "absolute", top: -40, left: -30, width: 160, height: 160, borderRadius: 80,
           backgroundColor: "rgba(255,255,255,0.35)" },
  icon:  { fontSize: 72 },
  desc:  { fontSize: 15, lineHeight: 24, color: colors.text, marginTop: 18, ...fBody },
  stats: { flexDirection: "row", flexWrap: "wrap", gap: 8, marginTop: 16 },
  chip:  { backgroundColor: colors.surfaceAlt, borderRadius: 999, paddingHorizontal: 12, paddingVertical: 6 },
  chipText: { fontSize: 12.5, fontWeight: "700", color: colors.text },

  playBtn:  { backgroundColor: colors.brand, borderRadius: 16, paddingVertical: 16, alignItems: "center", marginTop: 24,
              shadowColor: colors.brand, shadowOpacity: 0.35, shadowRadius: 12, shadowOffset: { width: 0, height: 6 }, elevation: 3 },
  playText: { color: "white", fontWeight: "900", fontSize: 17, letterSpacing: 0.3 },
  secondaryRow: { flexDirection: "row", gap: 10, marginTop: 12 },
  dlBtn:    { borderWidth: 2, borderColor: colors.brand, borderRadius: 16, paddingVertical: 14, alignItems: "center" },
  secondaryBtn: { flex: 1 },
  dlText:   { color: colors.brand, fontWeight: "800", fontSize: 15 },
  linkBtn:  { alignItems: "center", marginTop: 16 },
  linkText: { color: colors.textMuted, fontWeight: "700", fontSize: 13.5, ...fBody },
});
