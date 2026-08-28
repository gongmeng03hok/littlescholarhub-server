import { useState, useEffect, useRef } from "react";
import { View, Text, TouchableOpacity, StyleSheet, ActivityIndicator } from "react-native";
import { QuestionCard } from "./QuestionCard";
import { useQuestions } from "../hooks/useApi";
import { colors } from "../constants/theme";

interface Props {
  subject: string;
  grade: number;
  childId?: number;
  questionCount?: number;
  timeLimitSec?: number;
  onExit?: () => void;
}

export function MiniGame({ subject, grade, childId, questionCount = 5, timeLimitSec = 60, onExit }: Props) {
  const { data: questions = [], isLoading, refetch } = useQuestions(subject, grade, questionCount);

  const [index, setIndex]       = useState(0);
  const [correct, setCorrect]   = useState(0);
  const [timeLeft, setTimeLeft] = useState(timeLimitSec);
  const [finished, setFinished] = useState(false);
  const intervalRef = useRef<ReturnType<typeof setInterval> | null>(null);

  useEffect(() => {
    if (finished || isLoading) return;
    intervalRef.current = setInterval(() => {
      setTimeLeft(t => {
        if (t <= 1) {
          setFinished(true);
          return 0;
        }
        return t - 1;
      });
    }, 1000);
    return () => { if (intervalRef.current) clearInterval(intervalRef.current); };
  }, [finished, isLoading]);

  const handleResult = (isCorrect: boolean) => {
    if (isCorrect) setCorrect(c => c + 1);
    if (index + 1 >= questions.length) {
      setFinished(true);
    } else {
      setIndex(i => i + 1);
    }
  };

  const playAgain = () => {
    setIndex(0);
    setCorrect(0);
    setTimeLeft(timeLimitSec);
    setFinished(false);
    refetch();
  };

  if (isLoading) {
    return <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>;
  }

  if (finished || questions.length === 0) {
    return (
      <View style={s.resultCard}>
        <Text style={s.resultEmoji}>{correct === questions.length && questions.length > 0 ? "🏆" : "🎮"}</Text>
        <Text style={s.resultScore}>{correct}/{questions.length}</Text>
        <Text style={s.resultLabel}>questions correct</Text>
        <View style={s.resultActions}>
          <TouchableOpacity style={s.playAgainBtn} onPress={playAgain}>
            <Text style={s.playAgainText}>Play again</Text>
          </TouchableOpacity>
          {onExit && (
            <TouchableOpacity style={s.exitBtn} onPress={onExit}>
              <Text style={s.exitText}>Done</Text>
            </TouchableOpacity>
          )}
        </View>
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.hud}>
        <Text style={s.progress}>{index + 1}/{questions.length}</Text>
        <View style={s.timerBar}>
          <View style={[s.timerFill, { width: `${(timeLeft / timeLimitSec) * 100}%` as any }]} />
        </View>
        <Text style={s.timer}>{timeLeft}s</Text>
      </View>
      <QuestionCard
        key={index}
        question={questions[index]}
        childId={childId}
        kidMode
        onResult={handleResult}
      />
    </View>
  );
}

const s = StyleSheet.create({
  root:   { gap: 14 },
  center: { padding: 40, alignItems: "center" },

  hud: { flexDirection: "row", alignItems: "center", gap: 10 },
  progress: { fontSize: 13, fontWeight: "800", color: colors.text },
  timerBar: { flex: 1, height: 8, backgroundColor: "#eee", borderRadius: 4, overflow: "hidden" },
  timerFill:{ height: 8, backgroundColor: colors.brand },
  timer:    { fontSize: 13, fontWeight: "800", color: colors.brand, width: 36, textAlign: "right" },

  resultCard: { backgroundColor: "white", borderRadius: 20, padding: 32, alignItems: "center", gap: 8,
                shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 12, elevation: 3 },
  resultEmoji: { fontSize: 48 },
  resultScore: { fontSize: 36, fontWeight: "900", color: colors.brand },
  resultLabel: { fontSize: 13, color: colors.textMuted, fontWeight: "600", marginBottom: 12 },
  resultActions: { flexDirection: "row", gap: 10 },
  playAgainBtn: { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 12, paddingHorizontal: 20 },
  playAgainText:{ color: "white", fontWeight: "800", fontSize: 14 },
  exitBtn:      { backgroundColor: "#f0f0f0", borderRadius: 12, paddingVertical: 12, paddingHorizontal: 20 },
  exitText:     { color: colors.text, fontWeight: "800", fontSize: 14 },
});
