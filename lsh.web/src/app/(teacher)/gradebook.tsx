/**
 * Gradebook — per-classroom table of students with aggregated homework scores.
 */
import { useState } from "react";
import {
  View, Text, TouchableOpacity, ScrollView,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useClassrooms, useGradebook } from "../../hooks/useTeacher";
import { colors } from "../../constants/theme";

export default function Gradebook() {
  const router = useRouter();
  const { data: classrooms = [] } = useClassrooms();
  const [classroomId, setClassroomId] = useState<number | undefined>(undefined);
  const activeClassroomId = classroomId ?? classrooms[0]?.classroom_id;

  const { data: rows = [], isLoading } = useGradebook(activeClassroomId);

  if (classrooms.length === 0) {
    return (
      <View style={s.centerRoot}>
        <Text style={s.emptyEmoji}>📊</Text>
        <Text style={s.emptyText}>Create a classroom on the Classrooms tab first.</Text>
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>📊 Gradebook</Text>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        <Text style={s.label}>Classroom</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
          {classrooms.map((c: any) => (
            <TouchableOpacity
              key={c.classroom_id}
              style={[s.chip, activeClassroomId === c.classroom_id && s.chipActive]}
              onPress={() => setClassroomId(c.classroom_id)}
            >
              <Text style={[s.chipText, activeClassroomId === c.classroom_id && s.chipTextActive]}>
                {c.classroom_name}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {isLoading ? (
          <ActivityIndicator color={colors.brand} style={{ marginTop: 24 }} />
        ) : rows.length === 0 ? (
          <Text style={s.empty}>No students in this classroom yet.</Text>
        ) : (
          <>
            <View style={s.tableHeader}>
              <Text style={[s.thName, s.th]}>Student</Text>
              <Text style={[s.thNum, s.th]}>Avg</Text>
              <Text style={[s.thNum, s.th]}>Graded</Text>
              <Text style={[s.thNum, s.th]}>Assigned</Text>
            </View>
            {rows.map((r: any) => (
              <TouchableOpacity
                key={r.child_id}
                style={s.row}
                onPress={() => router.push(`/(teacher)/students/${r.child_id}` as any)}
              >
                <Text style={[s.tdName, s.td]} numberOfLines={1}>{r.nickname}</Text>
                <Text style={[s.tdNum, s.td, r.avg_score == null && s.tdMuted]}>
                  {r.avg_score != null ? Math.round(r.avg_score) : "—"}
                </Text>
                <Text style={[s.tdNum, s.td]}>{r.graded_count}/{r.submission_count}</Text>
                <Text style={[s.tdNum, s.td]}>{r.assignment_count}</Text>
              </TouchableOpacity>
            ))}
          </>
        )}

        <View style={{ height: 40 }} />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:       { flex: 1, backgroundColor: "#f8f7ff" },
  centerRoot: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },
  emptyEmoji: { fontSize: 48, marginBottom: 12 },
  emptyText:  { fontSize: 14, color: colors.textMuted, textAlign: "center" },

  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  body:   { padding: 16 },

  label: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  chip:       { paddingHorizontal: 14, paddingVertical: 8, borderRadius: 12, backgroundColor: "white",
                borderWidth: 1.5, borderColor: colors.border, marginRight: 8, maxWidth: 200 },
  chipActive: { backgroundColor: colors.brand, borderColor: colors.brand },
  chipText:   { fontSize: 13, fontWeight: "600", color: colors.text },
  chipTextActive: { color: "white" },

  empty: { fontSize: 13, color: colors.textMuted, textAlign: "center", marginTop: 24 },

  tableHeader: { flexDirection: "row", paddingHorizontal: 14, paddingBottom: 8 },
  th:  { fontSize: 11, fontWeight: "700", color: colors.textMuted },
  thName: { flex: 1 },
  thNum:  { width: 64, textAlign: "right" },

  row: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
         borderRadius: 12, padding: 14, marginBottom: 8,
         shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 4, elevation: 1 },
  td:  { fontSize: 13, color: colors.text },
  tdName: { flex: 1, fontWeight: "700" },
  tdNum:  { width: 64, textAlign: "right", fontWeight: "700" },
  tdMuted:{ color: colors.textMuted, fontWeight: "600" },
});
