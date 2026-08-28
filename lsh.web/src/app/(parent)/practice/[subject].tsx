/**
 * Practice screen — dynamically routed by subject slug.
 * Loads questions from API, cycles through them, logs session on completion.
 */
import { useState, useRef } from "react";
import {
  View, Text, ScrollView, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";

import { useChildStore }   from "../../../store/childStore";
import { useQuestions, useLogSession } from "../../../hooks/useApi";
import { QuestionCard }    from "../../../components/QuestionCard";
import { ScreenHeader }    from "../../../components/ui/ScreenHeader";
import { Button }          from "../../../components/ui/Button";
import { EmptyState }      from "../../../components/ui/EmptyState";
import { colors, SUBJECT_META } from "../../../constants/theme";

export default function PracticeScreen() {
  const router = useRouter();
  const { subject, grade } = useLocalSearchParams<{ subject: string; grade: string }>();
  const { activeChild } = useChildStore();

  const gradeId  = parseInt(grade ?? "2", 10);
  const meta     = SUBJECT_META[subject ?? "math"];
  const childId  = activeChild?.child_id;

  const [idx,      setIdx]      = useState(0);
  const [correct,  setCorrect]  = useState(0);
  const [done,     setDone]     = useState(false);
  const startRef               = useRef(Date.now());

  const { data: questions = [], isLoading, isError, refetch } = useQuestions(subject ?? "math", gradeId, 5);
  const { mutate: logSession } = useLogSession();

  const handleResult = (isCorrect: boolean) => {
    if (isCorrect) setCorrect(c => c + 1);
    if (idx + 1 >= questions.length) {
      // Session complete — log it
      const durationMin = Math.round((Date.now() - startRef.current) / 60000) || 1;
      if (childId && meta) {
        logSession({ child_id: childId, subject_id: meta.subjectId, duration_min: durationMin });
      }
      setDone(true);
    } else {
      setIdx(i => i + 1);
    }
  };

  const restart = () => {
    setIdx(0); setCorrect(0); setDone(false);
    startRef.current = Date.now();
    refetch();
  };

  if (isLoading) {
    return (
      <View style={s.center}>
        <ActivityIndicator size="large" color={colors.brand} />
        <Text style={s.loadingText}>Building your questions…</Text>
      </View>
    );
  }

  if (isError || questions.length === 0) {
    return (
      <View style={{ flex: 1, backgroundColor: "#f8f7ff" }}>
        <ScreenHeader title={meta?.label ?? subject ?? ""} showBack />
        <EmptyState emoji="😕" title="No questions yet"
          body="We're still building this subject. Check back soon!"
          actionLabel="Go back" onAction={() => router.back()} />
      </View>
    );
  }

  if (done) {
    const pct = Math.round((correct / questions.length) * 100);
    return (
      <View style={[s.center, { backgroundColor: "#f8f7ff" }]}>
        <Text style={s.doneEmoji}>{pct >= 80 ? "🎉" : pct >= 50 ? "👍" : "💪"}</Text>
        <Text style={s.doneTitle}>Session complete!</Text>
        <Text style={s.doneScore}>{correct} / {questions.length} correct · {pct}%</Text>
        <Text style={s.doneSub}>
          {pct >= 80 ? "Excellent work! Keep it up!" : pct >= 50 ? "Good effort — keep practising!" : "Every session makes you stronger!"}
        </Text>
        <View style={s.doneActions}>
          <Button label="Practice again" onPress={restart} />
          <Button label="Back to home" onPress={() => router.replace("/(parent)")} variant="outline" />
        </View>
      </View>
    );
  }

  const question = questions[idx];

  return (
    <View style={{ flex: 1, backgroundColor: "#f8f7ff" }}>
      <ScreenHeader
        title={`${meta?.icon ?? ""} ${meta?.label ?? subject}`}
        subtitle={`${idx + 1} of ${questions.length}`}
        showBack
      />

      {/* Progress bar */}
      <View style={s.progressBar}>
        <View style={[s.progressFill, { width: `${((idx) / questions.length) * 100}%` }]} />
      </View>

      <ScrollView contentContainerStyle={s.scroll} keyboardShouldPersistTaps="handled">
        <QuestionCard
          key={idx}
          question={question}
          childId={childId}
          onResult={handleResult}
        />

        <View style={s.statsRow}>
          <Text style={s.statItem}>✅ {correct} correct</Text>
          <Text style={s.statItem}>❌ {idx - correct} missed</Text>
          <Text style={s.statItem}>📚 {questions.length - idx - 1} left</Text>
        </View>
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  center:      { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, backgroundColor: "#f8f7ff" },
  loadingText: { marginTop: 16, color: colors.textMuted, fontSize: 15 },
  progressBar: { height: 4, backgroundColor: colors.border },
  progressFill:{ height: 4, backgroundColor: colors.brand, borderRadius: 2 },
  scroll:      { padding: 20, gap: 20 },
  statsRow:    { flexDirection: "row", justifyContent: "space-around", backgroundColor: "white",
                 borderRadius: 14, padding: 14 },
  statItem:    { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  doneEmoji:   { fontSize: 72, marginBottom: 16 },
  doneTitle:   { fontSize: 28, fontWeight: "900", color: colors.text, marginBottom: 8 },
  doneScore:   { fontSize: 22, fontWeight: "800", color: colors.brand, marginBottom: 12 },
  doneSub:     { fontSize: 15, color: colors.textMuted, textAlign: "center", lineHeight: 24, marginBottom: 32 },
  doneActions: { gap: 12, width: "100%" },
});
