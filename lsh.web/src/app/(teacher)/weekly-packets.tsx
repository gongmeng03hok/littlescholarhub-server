/**
 * Teacher Weekly Packets — pick one of your classrooms (or any grade, if
 * you don't have a classroom set up yet) and a week to view/print that
 * grade's practice packet for the whole class. Rendering is shared with
 * the admin/parent Weekly Packets screens via components/WeeklyPacketView.tsx.
 */
import { useEffect, useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet, Platform } from "react-native";
import { usePracticePacket } from "../../hooks/useApi";
import { useClassrooms } from "../../hooks/useTeacher";
import { WeekPicker } from "../../components/WeekPickerModal";
import { WeeklyPacketBody, printWeeklyPacket, useWeeklyPacketDisplay } from "../../components/WeeklyPacketView";
import { weekContainingToday, WEEK_OPTIONS_2026 } from "../../utils/weeklyPacketWeeks";
import { EmptyState } from "../../components/ui/EmptyState";
import { colors, GRADES } from "../../constants/theme";

const DEFAULT_WEEK = weekContainingToday(WEEK_OPTIONS_2026) ?? "2026-08-10";

export default function TeacherWeeklyPackets() {
  const { data: classrooms = [], isLoading: classroomsLoading } = useClassrooms();
  const [classroomId, setClassroomId] = useState<number | null>(null);
  const [manualGradeId, setManualGradeId] = useState<number | null>(null);
  const [weekOf, setWeekOf] = useState(DEFAULT_WEEK);

  useEffect(() => {
    if (classroomId === null && (classrooms as any[]).length > 0) {
      setClassroomId((classrooms as any[])[0].classroom_id);
    }
  }, [classrooms]);

  const activeClassroom = (classrooms as any[]).find(c => c.classroom_id === classroomId);
  const gradeId = activeClassroom ? activeClassroom.grade_id : manualGradeId;

  const { data: packet, isLoading, error } = usePracticePacket(gradeId ?? -1, weekOf);
  const { wordSearches } = useWeeklyPacketDisplay(packet);

  if (classroomsLoading) return null;

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>Weekly Packets 📅</Text>
        <Text style={s.sub}>Prep a printable practice packet for your whole class.</Text>

        {(classrooms as any[]).length > 0 ? (
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 10 }}>
            {(classrooms as any[]).map(c => (
              <TouchableOpacity key={c.classroom_id}
                onPress={() => { setClassroomId(c.classroom_id); setManualGradeId(null); }}
                style={[s.chip, classroomId === c.classroom_id && !manualGradeId && s.chipActive]}>
                <Text style={[s.chipText, classroomId === c.classroom_id && !manualGradeId && s.chipTextActive]}>
                  {c.classroom_name}{c.grade_label ? ` · ${c.grade_label}` : ""}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        ) : (
          <>
            <Text style={s.noClassroomHint}>No classrooms yet — pick a grade to preview a packet:</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 8 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id}
                  onPress={() => setManualGradeId(g.grade_id)}
                  style={[s.chip, manualGradeId === g.grade_id && s.chipActive]}>
                  <Text style={[s.chipText, manualGradeId === g.grade_id && s.chipTextActive]}>{g.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </>
        )}

        <View style={s.controlsRow}>
          <WeekPicker weekOf={weekOf} onChange={setWeekOf} />
          {packet && Platform.OS === "web" && (
            <TouchableOpacity onPress={() => printWeeklyPacket(packet, wordSearches)} style={s.printBtn}>
              <Text style={s.printBtnText}>🖨️ Print Packet</Text>
            </TouchableOpacity>
          )}
        </View>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {gradeId == null ? (
          <EmptyState emoji="🏫" title="Pick a classroom or grade" body="Choose one above to see this week's packet." />
        ) : (
          <WeeklyPacketBody
            packet={packet}
            isLoading={isLoading}
            error={error}
            emptyMessage="No packet content for this grade yet."
          />
        )}
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.bg },
  header: {
    backgroundColor: "white",
    paddingTop: Platform.OS === "ios" ? 56 : 20,
    paddingBottom: 16, paddingHorizontal: 20,
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  title: { fontSize: 22, fontWeight: "900", color: colors.text },
  sub:   { fontSize: 13, color: colors.textMuted, marginTop: 2 },
  noClassroomHint: { fontSize: 12.5, color: colors.textMuted, marginTop: 12 },

  chip: { paddingHorizontal: 14, paddingVertical: 8, borderRadius: 16, backgroundColor: colors.surfaceAlt, marginRight: 8 },
  chipActive: { backgroundColor: colors.brand },
  chipText: { fontSize: 12.5, fontWeight: "700", color: colors.text },
  chipTextActive: { color: "white" },

  controlsRow: { flexDirection: "row", flexWrap: "wrap", gap: 12, alignItems: "center", marginTop: 14 },
  printBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  printBtnText: { color: "white", fontWeight: "800", fontSize: 13 },

  body: { padding: 18, paddingBottom: 60 },
});
