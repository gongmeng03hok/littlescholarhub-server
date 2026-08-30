/**
 * Shared kit for the in-app worksheet games.
 * Every game records its attempt through the SAME endpoint the classic
 * QuestionCard uses, so gems / stars / XP keep being awarded server-side.
 */
import { useEffect, useRef } from "react";
import { fonts } from "../../constants/theme";
import { Animated, Easing, View, Text, StyleSheet } from "react-native";
import { questionsApi } from "../../api/questions";
import { colors } from "../../constants/theme";

export interface GameQuestion {
  question_text?: string;
  question?: string;
  correct_answer?: string;
  answer?: string;
  options?: string[];
  hint?: string;
  gq_id?: number;
}

export type GameType = "tap" | "build" | "trace" | "match";

export const textOf   = (q: GameQuestion) => (q.question_text ?? q.question ?? "").trim();
export const answerOf = (q: GameQuestion) => (q.correct_answer ?? q.answer ?? "").trim();

/** Pick a game type from the shape of a single question. */
export function classify(q: GameQuestion): GameType {
  if (q.options && q.options.length) return "tap";
  const a = answerOf(q);
  if (a.length === 1 && /[a-z0-9]/i.test(a)) return "trace";
  if (a.length >= 1 && a.length <= 9 && /^[a-z0-9 ]+$/i.test(a)) return "build";
  return "tap"; // long / free-text falls back to the tap card (fill-in)
}

/** Record one attempt; resolves to whether it was correct. Never throws. */
export async function recordAttempt(
  q: GameQuestion, childId: number | undefined, given: string,
): Promise<boolean> {
  try {
    const res = (await questionsApi.recordAttempt({
      child_id:       childId,
      question_text:  textOf(q),
      given_answer:   given,
      correct_answer: answerOf(q),
      hint:           q.hint,
      options:        q.options,
    })) as any;
    return !!res?.is_correct;
  } catch {
    // Offline / server hiccup — compare locally so play isn't blocked.
    return given.trim().toLowerCase() === answerOf(q).toLowerCase();
  }
}

export function shuffle<T>(arr: T[]): T[] {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

/** Big celebratory emoji that pops + fades. Mount it when a round is won. */
export function Celebrate({ emoji = "🎉" }: { emoji?: string }) {
  const scale = useRef(new Animated.Value(0)).current;
  const rise  = useRef(new Animated.Value(0)).current;
  useEffect(() => {
    Animated.parallel([
      Animated.spring(scale, { toValue: 1, friction: 4, useNativeDriver: true }),
      Animated.timing(rise, { toValue: 1, duration: 900, easing: Easing.out(Easing.quad), useNativeDriver: true }),
    ]).start();
  }, []);
  const translateY = rise.interpolate({ inputRange: [0, 1], outputRange: [0, -28] });
  const opacity    = rise.interpolate({ inputRange: [0, 0.7, 1], outputRange: [1, 1, 0] });
  return (
    <View pointerEvents="none" style={k.celebrateWrap}>
      <Animated.Text style={[k.celebrateEmoji, { opacity, transform: [{ scale }, { translateY }] }]}>
        {emoji}
      </Animated.Text>
    </View>
  );
}

/** Coloured banner that names the game type — makes each round feel distinct. */
export function RoundBanner({ type }: { type: GameType }) {
  const meta = BANNER[type];
  return (
    <View style={[k.banner, { backgroundColor: meta.bg }]}>
      <Text style={k.bannerEmoji}>{meta.emoji}</Text>
      <Text style={[k.bannerText, { color: meta.fg }]}>{meta.label}</Text>
    </View>
  );
}

const BANNER: Record<GameType, { emoji: string; label: string; bg: string; fg: string }> = {
  tap:   { emoji: "👆", label: "Tap the answer!", bg: "#eef3ec", fg: "#5f7a55" },
  build: { emoji: "🧩", label: "Build the answer!", bg: "#fdf3e4", fg: "#a5772e" },
  trace: { emoji: "✏️", label: "Trace it!",        bg: "#fdeee9", fg: "#b55e48" },
  match: { emoji: "🔗", label: "Match the pairs!", bg: "#eef0f7", fg: "#5a5f8a" },
};

const k = StyleSheet.create({
  celebrateWrap:  { position: "absolute", top: 0, left: 0, right: 0, alignItems: "center", zIndex: 20 },
  celebrateEmoji: { fontSize: 84 },
  banner:      { flexDirection: "row", alignItems: "center", justifyContent: "center", gap: 8,
                 borderRadius: 14, paddingVertical: 10, marginBottom: 16 },
  bannerEmoji: { fontSize: 22 },
  bannerText:  { fontSize: 16, fontWeight: "900", letterSpacing: 0.3 },
});

export { colors };
