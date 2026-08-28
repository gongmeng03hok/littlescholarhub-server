/**
 * Kid practice screen — now a game-like worksheet player.
 * Loads questions for the subject/grade and hands them to WorksheetPlayer,
 * which runs Match / Tap / Build / Trace rounds and awards gems as before.
 */
import { useRef } from "react";
import { View, Text, StyleSheet, ActivityIndicator } from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useChildStore }   from "../../../store/childStore";
import { useQuestions, useLogSession } from "../../../hooks/useApi";
import { WorksheetPlayer } from "../../../components/WorksheetPlayer";
import { colors, SUBJECT_META } from "../../../constants/theme";

export default function KidPracticeScreen() {
  const router = useRouter();
  const { subject, grade } = useLocalSearchParams<{ subject: string; grade: string }>();
  const { activeChild } = useChildStore();

  const gradeId = parseInt(grade ?? "2", 10);
  const meta    = SUBJECT_META[subject ?? "math"];
  const childId = activeChild?.child_id;
  const startRef = useRef(Date.now());

  const { data: questions = [], isLoading } = useQuestions(subject ?? "math", gradeId, 5);
  const { mutate: logSession } = useLogSession();

  const handleComplete = () => {
    const durationMin = Math.round((Date.now() - startRef.current) / 60000) || 1;
    if (childId && meta) {
      logSession({ child_id: childId, subject_id: meta.subjectId, duration_min: durationMin });
    }
  };

  if (isLoading) {
    return (
      <View style={s.center}>
        <Text style={{ fontSize: 60, marginBottom: 16 }}>⏳</Text>
        <ActivityIndicator size="large" color={colors.brand} />
        <Text style={s.loadingText}>Getting your worksheet…</Text>
      </View>
    );
  }

  return (
    <WorksheetPlayer
      questions={questions}
      childId={childId}
      headerTitle={`${meta?.icon ?? ""} ${meta?.label ?? subject ?? ""}`.trim()}
      onExit={() => router.replace("/(kid)")}
      onComplete={handleComplete}
    />
  );
}

const s = StyleSheet.create({
  center:      { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, backgroundColor: "#f8f7ff" },
  loadingText: { marginTop: 16, fontSize: 18, color: colors.textMuted, fontWeight: "600" },
});
