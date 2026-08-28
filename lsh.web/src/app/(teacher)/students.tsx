/**
 * Students — flat, searchable list of every student across all of this
 * teacher's classrooms (as opposed to the per-classroom roster on the
 * Classrooms tab). Tap a student to see their grades & activity.
 */
import { useState } from "react";
import {
  View, Text, TextInput, TouchableOpacity, ScrollView,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useAllStudents } from "../../hooks/useTeacher";
import { colors, GRADES } from "../../constants/theme";

export default function StudentsScreen() {
  const router = useRouter();
  const { data: students = [], isLoading } = useAllStudents();
  const [search, setSearch] = useState("");

  const filtered = students.filter((s: any) =>
    !search.trim() || s.nickname.toLowerCase().includes(search.trim().toLowerCase())
  );

  const gradeLabel = (gradeId: number) => GRADES.find(g => g.grade_id === gradeId)?.label ?? "—";

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>🎓 Students</Text>
        <Text style={s.count}>{students.length} total</Text>
      </View>

      <View style={s.searchWrap}>
        <TextInput
          style={s.search}
          placeholder="Search students…"
          value={search}
          onChangeText={setSearch}
        />
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {isLoading ? (
          <ActivityIndicator style={{ marginTop: 24 }} color={colors.brand} />
        ) : students.length === 0 ? (
          <Text style={s.empty}>No students yet — add one from the Classrooms tab.</Text>
        ) : filtered.length === 0 ? (
          <Text style={s.empty}>No students match "{search}".</Text>
        ) : (
          filtered.map((st: any) => (
            <TouchableOpacity
              key={`${st.classroom_id}-${st.child_id}`}
              style={s.row}
              onPress={() => router.push(`/(teacher)/students/${st.child_id}` as any)}
            >
              <View style={{ flex: 1 }}>
                <Text style={s.name}>{st.nickname}</Text>
                <Text style={s.meta}>
                  {st.classroom_name} · Grade {gradeLabel(st.grade_id)}
                  {st.is_teacher_added ? " · added by you" : ""}
                </Text>
              </View>
              <Text style={s.arrow}>›</Text>
            </TouchableOpacity>
          ))
        )}
        <View style={{ height: 40 }} />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center", justifyContent: "space-between",
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  count:  { fontSize: 13, color: colors.textMuted, fontWeight: "600" },

  searchWrap: { backgroundColor: "white", paddingHorizontal: 20, paddingBottom: 14 },
  search:     { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                paddingHorizontal: 14, paddingVertical: 10, fontSize: 14, color: colors.text },

  body:  { padding: 16, gap: 8 },
  empty: { textAlign: "center", color: colors.textMuted, marginTop: 24, fontSize: 14 },

  row:  { flexDirection: "row", alignItems: "center", backgroundColor: "white",
          borderRadius: 12, padding: 14,
          shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 4, elevation: 1 },
  name: { fontSize: 14, fontWeight: "800", color: colors.text },
  meta: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  arrow:{ fontSize: 20, color: colors.brand, fontWeight: "700" },
});
