/**
 * GamePlayerModal — plays an interactive "game" worksheet in the browser
 * (no PDF). Supports two original game types stored as JSON in
 * Worksheets.game_data:
 *   - tap_answer: multiple-choice, tap an answer for instant feedback
 *   - tap_match:  tap-to-pair matching (term + match, shuffled)
 */
import { useEffect, useMemo, useState } from "react";
import { View, Text, TouchableOpacity, StyleSheet, Platform } from "react-native";
import { Modal } from "./ui/Modal";
import { colors } from "../constants/theme";

interface TapAnswerQuestion {
  prompt: string;
  choices: string[];
  correct: number;
}
interface TapAnswerData {
  type: "tap_answer";
  questions: TapAnswerQuestion[];
}
interface TapMatchData {
  type: "tap_match";
  pairs: [string, string][];
}
type GameData = TapAnswerData | TapMatchData;

interface Props {
  visible: boolean;
  onClose: () => void;
  title?: string;
  gameData: string | GameData | null | undefined;
  onComplete?: () => void;
}

function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

export function GamePlayerModal({ visible, onClose, title, gameData, onComplete }: Props) {
  const parsed: GameData | null = useMemo(() => {
    if (!gameData) return null;
    if (typeof gameData === "string") {
      try { return JSON.parse(gameData); } catch { return null; }
    }
    return gameData;
  }, [gameData]);

  if (!parsed) {
    return (
      <Modal visible={visible} onClose={onClose} title={title}>
        <Text style={s.emptyText}>This game isn't available right now.</Text>
      </Modal>
    );
  }

  return (
    <Modal visible={visible} onClose={onClose} title={title} subtitle="🎮 Tap to play">
      {parsed.type === "tap_answer"
        ? <TapAnswerGame data={parsed} onComplete={onComplete} />
        : <TapMatchGame data={parsed} onComplete={onComplete} />}
    </Modal>
  );
}

function TapAnswerGame({ data, onComplete }: { data: TapAnswerData; onComplete?: () => void }) {
  const [index, setIndex] = useState(0);
  const [score, setScore] = useState(0);
  const [picked, setPicked] = useState<number | null>(null);
  const [finished, setFinished] = useState(false);
  const [notified, setNotified] = useState(false);

  useEffect(() => {
    if (finished && !notified) { onComplete?.(); setNotified(true); }
  }, [finished, notified, onComplete]);

  const reset = () => { setIndex(0); setScore(0); setPicked(null); setFinished(false); setNotified(false); };

  if (finished) {
    return (
      <View style={s.center}>
        <Text style={s.resultEmoji}>{score === data.questions.length ? "🏆" : score >= data.questions.length / 2 ? "🎉" : "💪"}</Text>
        <Text style={s.resultText}>You got {score} / {data.questions.length}!</Text>
        <TouchableOpacity style={s.primaryBtn} onPress={reset} activeOpacity={0.85}>
          <Text style={s.primaryBtnText}>🔁 Play Again</Text>
        </TouchableOpacity>
      </View>
    );
  }

  const q = data.questions[index];
  const onPick = (i: number) => {
    if (picked !== null) return;
    setPicked(i);
    if (i === q.correct) setScore(sc => sc + 1);
    setTimeout(() => {
      if (index + 1 < data.questions.length) { setIndex(idx => idx + 1); setPicked(null); }
      else { setFinished(true); }
    }, 700);
  };

  return (
    <View>
      <Text style={s.progress}>Question {index + 1} of {data.questions.length}</Text>
      <Text style={s.prompt}>{q.prompt}</Text>
      <View style={s.choiceGrid}>
        {q.choices.map((c, i) => {
          const isPicked = picked === i;
          const isCorrect = picked !== null && i === q.correct;
          const isWrong = isPicked && i !== q.correct;
          return (
            <TouchableOpacity
              key={i}
              disabled={picked !== null}
              onPress={() => onPick(i)}
              activeOpacity={0.85}
              style={[s.choiceBtn, isCorrect && s.choiceCorrect, isWrong && s.choiceWrong]}
            >
              <Text style={[s.choiceText, (isCorrect || isWrong) && s.choiceTextActive]}>{c}</Text>
            </TouchableOpacity>
          );
        })}
      </View>
    </View>
  );
}

function TapMatchGame({ data, onComplete }: { data: TapMatchData; onComplete?: () => void }) {
  const [left, setLeft] = useState<string[]>([]);
  const [right, setRight] = useState<string[]>([]);
  const [matched, setMatched] = useState<Set<string>>(new Set());
  const [selLeft, setSelLeft] = useState<string | null>(null);
  const [selRight, setSelRight] = useState<string | null>(null);
  const [wrongPair, setWrongPair] = useState<[string, string] | null>(null);
  const [notified, setNotified] = useState(false);

  const setup = () => {
    setLeft(shuffle(data.pairs.map(p => p[0])));
    setRight(shuffle(data.pairs.map(p => p[1])));
    setMatched(new Set());
    setSelLeft(null);
    setSelRight(null);
    setWrongPair(null);
    setNotified(false);
  };
  useEffect(setup, [data]);

  const finished = matched.size === data.pairs.length;
  useEffect(() => {
    if (finished && !notified) { onComplete?.(); setNotified(true); }
  }, [finished, notified, onComplete]);

  const matchOf = (term: string) => data.pairs.find(p => p[0] === term)?.[1];

  const trySelect = (side: "left" | "right", value: string) => {
    if (matched.has(value)) return;
    if (side === "left") {
      setSelLeft(value);
      if (selRight) checkPair(value, selRight);
    } else {
      setSelRight(value);
      if (selLeft) checkPair(selLeft, value);
    }
  };

  const checkPair = (l: string, r: string) => {
    if (matchOf(l) === r) {
      setMatched(prev => new Set(prev).add(l).add(r));
      setSelLeft(null);
      setSelRight(null);
    } else {
      setWrongPair([l, r]);
      setTimeout(() => { setWrongPair(null); setSelLeft(null); setSelRight(null); }, 550);
    }
  };

  if (finished) {
    return (
      <View style={s.center}>
        <Text style={s.resultEmoji}>🏆</Text>
        <Text style={s.resultText}>You matched all {data.pairs.length} pairs!</Text>
        <TouchableOpacity style={s.primaryBtn} onPress={setup} activeOpacity={0.85}>
          <Text style={s.primaryBtnText}>🔁 Play Again</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View>
      <Text style={s.progress}>{matched.size / 2} of {data.pairs.length} matched — tap one from each column</Text>
      <View style={s.matchRow}>
        <View style={s.matchCol}>
          {left.map(v => (
            <MatchCard key={v} value={v} active={selLeft === v} done={matched.has(v)}
              wrong={wrongPair?.[0] === v} onPress={() => trySelect("left", v)} />
          ))}
        </View>
        <View style={s.matchCol}>
          {right.map(v => (
            <MatchCard key={v} value={v} active={selRight === v} done={matched.has(v)}
              wrong={wrongPair?.[1] === v} onPress={() => trySelect("right", v)} />
          ))}
        </View>
      </View>
    </View>
  );
}

function MatchCard({ value, active, done, wrong, onPress }: {
  value: string; active: boolean; done: boolean; wrong: boolean; onPress: () => void;
}) {
  return (
    <TouchableOpacity
      disabled={done}
      onPress={onPress}
      activeOpacity={0.85}
      style={[s.matchCard, active && s.matchCardActive, done && s.matchCardDone, wrong && s.matchCardWrong]}
    >
      <Text style={[s.matchCardText, done && s.matchCardTextDone]}>{value}</Text>
    </TouchableOpacity>
  );
}

const isWeb = Platform.OS === "web";
const fBody: any = isWeb ? { fontFamily: "'Inter', system-ui, sans-serif" } : {};

const s = StyleSheet.create({
  emptyText: { fontSize: 14, color: colors.textMuted, textAlign: "center", padding: 20, ...fBody },

  progress: { fontSize: 12.5, fontWeight: "700", color: colors.textMuted, textAlign: "center", marginBottom: 10, ...fBody },
  prompt: { fontSize: 19, fontWeight: "800", color: colors.text, textAlign: "center", marginBottom: 20, ...fBody },

  choiceGrid: { gap: 12 },
  choiceBtn: { borderWidth: 2, borderColor: colors.border, borderRadius: 14, paddingVertical: 16,
               alignItems: "center", backgroundColor: colors.surfaceAlt },
  choiceCorrect: { borderColor: "#22c55e", backgroundColor: "#dcfce7" },
  choiceWrong: { borderColor: "#ef4444", backgroundColor: "#fee2e2" },
  choiceText: { fontSize: 16, fontWeight: "700", color: colors.text, ...fBody },
  choiceTextActive: { color: colors.text },

  matchRow: { flexDirection: "row", gap: 14 },
  matchCol: { flex: 1, gap: 10 },
  matchCard: { borderWidth: 2, borderColor: colors.border, borderRadius: 12, paddingVertical: 14,
               paddingHorizontal: 10, alignItems: "center", backgroundColor: colors.surfaceAlt, minHeight: 56, justifyContent: "center" },
  matchCardActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  matchCardDone: { borderColor: "#22c55e", backgroundColor: "#dcfce7", opacity: 0.55 },
  matchCardWrong: { borderColor: "#ef4444", backgroundColor: "#fee2e2" },
  matchCardText: { fontSize: 13.5, fontWeight: "700", color: colors.text, textAlign: "center", ...fBody },
  matchCardTextDone: { color: "#15803d" },

  center: { alignItems: "center", paddingVertical: 20 },
  resultEmoji: { fontSize: 56, marginBottom: 8 },
  resultText: { fontSize: 18, fontWeight: "800", color: colors.text, marginBottom: 18, ...fBody },
  primaryBtn: { backgroundColor: colors.brand, borderRadius: 16, paddingVertical: 14, paddingHorizontal: 28 },
  primaryBtnText: { color: "white", fontWeight: "900", fontSize: 15 },
});
