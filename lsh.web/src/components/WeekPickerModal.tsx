/**
 * Shared "Week of: ..." control (select button + modal list + Today button)
 * used by the admin, parent, and teacher Weekly Packets screens.
 */
import { useState } from "react";
import { View, Text, TouchableOpacity, ScrollView, Modal, StyleSheet } from "react-native";
import { WEEK_OPTIONS_2026, weekContainingToday } from "../utils/weeklyPacketWeeks";
import { colors } from "../constants/theme";

export function WeekPicker({ weekOf, onChange }: { weekOf: string; onChange: (value: string) => void }) {
  const [open, setOpen] = useState(false);
  const currentWeek = WEEK_OPTIONS_2026.find(w => w.value === weekOf);

  return (
    <>
      <View style={s.weekRow}>
        <Text style={s.weekLabel}>Week of:</Text>
        <TouchableOpacity onPress={() => setOpen(true)} style={s.weekSelect}>
          <Text style={s.weekSelectText} numberOfLines={1}>
            {currentWeek ? currentWeek.label : weekOf}
          </Text>
          <Text style={s.weekSelectCaret}>▾</Text>
        </TouchableOpacity>
        <TouchableOpacity
          onPress={() => { const w = weekContainingToday(WEEK_OPTIONS_2026); if (w) onChange(w); }}
          style={s.todayBtn}
        >
          <Text style={s.todayBtnText}>Today</Text>
        </TouchableOpacity>
      </View>

      <Modal visible={open} transparent animationType="fade" onRequestClose={() => setOpen(false)}>
        <TouchableOpacity style={s.modalBackdrop} activeOpacity={1} onPress={() => setOpen(false)}>
          <View style={s.weekModalCard} onStartShouldSetResponder={() => true}>
            <Text style={s.weekModalTitle}>Choose a week — 2026</Text>
            <ScrollView style={s.weekModalList}>
              {WEEK_OPTIONS_2026.map(w => (
                <TouchableOpacity
                  key={w.value}
                  onPress={() => { onChange(w.value); setOpen(false); }}
                  style={[s.weekOption, w.value === weekOf && s.weekOptionActive]}
                >
                  <Text style={[s.weekOptionText, w.value === weekOf && s.weekOptionTextActive]}>{w.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>
        </TouchableOpacity>
      </Modal>
    </>
  );
}

const s = StyleSheet.create({
  weekRow: { flexDirection: "row", alignItems: "center", gap: 8 },
  weekLabel: { fontSize: 12.5, fontWeight: "700", color: colors.textMuted },
  weekSelect: { flexDirection: "row", alignItems: "center", gap: 6, borderWidth: 1, borderColor: colors.border,
                borderRadius: 8, paddingHorizontal: 10, paddingVertical: 7, maxWidth: 320 },
  weekSelectText: { fontSize: 12.5, color: colors.text, flexShrink: 1 },
  weekSelectCaret: { fontSize: 11, color: colors.textMuted },
  todayBtn: { paddingHorizontal: 10, paddingVertical: 6, borderRadius: 8, backgroundColor: colors.surfaceAlt },
  todayBtnText: { fontSize: 12, fontWeight: "700", color: colors.text },

  modalBackdrop: { flex: 1, backgroundColor: "rgba(34,30,26,0.55)", alignItems: "center", justifyContent: "center", padding: 20 },
  weekModalCard: { width: "100%", maxWidth: 440, maxHeight: "80%", backgroundColor: "white", borderRadius: 16, padding: 16 },
  weekModalTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 10 },
  weekModalList: { maxHeight: 420 },
  weekOption: { paddingHorizontal: 12, paddingVertical: 10, borderRadius: 10 },
  weekOptionActive: { backgroundColor: colors.brandLight },
  weekOptionText: { fontSize: 13, color: colors.text },
  weekOptionTextActive: { fontWeight: "800", color: colors.brand },
});
