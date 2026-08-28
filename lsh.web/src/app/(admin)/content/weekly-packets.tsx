/**
 * Admin Weekly Packets — DB-driven weekly packet viewer/editor entry point.
 * Fetches a composed grade+week packet from /content/practice-packet
 * (backed by dbo.usp_GetOrCreateWeeklyPacket + the PacketCategories /
 * PacketQuestions bank) and renders it on-screen, with a Print button.
 * Shared rendering lives in components/WeeklyPacketView.tsx so this same
 * pipeline powers the Parent and Teacher Weekly Packets screens too.
 */
import { View, Text, ScrollView, TouchableOpacity, StyleSheet } from "react-native";
import { usePracticePacket } from "../../../hooks/useApi";
import { WeekPicker } from "../../../components/WeekPickerModal";
import { WeeklyPacketBody, printWeeklyPacket, useWeeklyPacketDisplay } from "../../../components/WeeklyPacketView";
import { colors, GRADES } from "../../../constants/theme";
import { useState } from "react";

export default function AdminWeeklyPackets() {
  const [gradeId, setGradeId] = useState(1); // Kindergarten
  const [weekOf, setWeekOf] = useState("2026-08-10");
  const { data: packet, isLoading, error } = usePracticePacket(gradeId, weekOf);
  const { wordSearches } = useWeeklyPacketDisplay(packet);

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>Weekly Packets 📅</Text>

        <View style={s.controlsRow}>
          <View style={s.gradeChips}>
            {GRADES.map(g => (
              <TouchableOpacity
                key={g.grade_id}
                onPress={() => setGradeId(g.grade_id)}
                style={[s.chip, gradeId === g.grade_id && s.chipActive]}
              >
                <Text style={[s.chipText, gradeId === g.grade_id && s.chipTextActive]}>{g.label}</Text>
              </TouchableOpacity>
            ))}
          </View>
          <WeekPicker weekOf={weekOf} onChange={setWeekOf} />
          {packet && (
            <TouchableOpacity onPress={() => printWeeklyPacket(packet, wordSearches)} style={s.printBtn}>
              <Text style={s.printBtnText}>🖨️ Print Packet</Text>
            </TouchableOpacity>
          )}
        </View>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        <WeeklyPacketBody
          packet={packet}
          isLoading={isLoading}
          error={error}
          emptyMessage="No packet content for this grade yet."
        />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.bg },
  header: { backgroundColor: "white", padding: 18, borderBottomWidth: 1, borderBottomColor: colors.border },
  title: { fontSize: 20, fontWeight: "900", color: colors.text, marginBottom: 12 },
  controlsRow: { flexDirection: "row", flexWrap: "wrap", gap: 12, alignItems: "center" },
  gradeChips: { flexDirection: "row", flexWrap: "wrap", gap: 6 },
  chip: { paddingHorizontal: 12, paddingVertical: 6, borderRadius: 14, backgroundColor: colors.surfaceAlt },
  chipActive: { backgroundColor: colors.brand },
  chipText: { fontSize: 12.5, fontWeight: "700", color: colors.text },
  chipTextActive: { color: "white" },
  printBtn: { marginLeft: "auto", backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  printBtnText: { color: "white", fontWeight: "800", fontSize: 13 },
  body: { padding: 18, paddingBottom: 60 },
});
