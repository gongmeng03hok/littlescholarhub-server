/**
 * WorksheetPlayer — turns a set of questions into a game-like worksheet:
 * a Match round (when possible) followed by per-question Tap / Build / Trace
 * rounds. Every round records its attempt, so gems / stars / XP are awarded
 * server-side exactly as before. Fully reviewable in-app; download optional.
 */
import { useMemo, useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet } from "react-native";
import { QuestionCard } from "./QuestionCard";
import { BuildGame } from "./games/BuildGame";
import { TraceGame } from "./games/TraceGame";
import { MatchGame } from "./games/MatchGame";
import { GameQuestion, GameType, classify, answerOf, RoundBanner, colors } from "./games/gameKit";
import { type ArtContext } from "../constants/questionImages";
import { useLangStore } from "../store/langStore";

type Round =
  | { kind: "match"; questions: GameQuestion[] }
  | { kind: "tap" | "build" | "trace"; q: GameQuestion };

interface Props {
  questions: GameQuestion[];
  childId?: number;
  headerTitle?: string;
  /** Subject / topic / grade for tailored artwork. Anything not passed is
   *  sniffed out of headerTitle ("Dinosaurs Manners - Grade TK"). */
  artContext?: ArtContext;
  onExit: () => void;
  onComplete?: (correct: number, total: number) => void;
}

export function WorksheetPlayer({ questions, childId, headerTitle, artContext, onExit, onComplete }: Props) {
  const rounds = useMemo(() => buildRounds(questions), [questions]);
  const totalItems = questions.length;
  const { lang } = useLangStore();

  // The culture track comes from the family's chosen language; subject, topic
  // and grade come from the caller or are read off the worksheet title.
  const context = useMemo<ArtContext>(() => ({
    title: headerTitle,
    culture: lang && lang !== "en" ? lang : undefined,
    ...artContext,
  }), [headerTitle, lang, artContext]);

  const [roundIdx, setRoundIdx] = useState(0);
  const [correct, setCorrect]   = useState(0);
  const [done, setDone]         = useState(false);

  const advance = (gotCorrect: number) => {
    const nextCorrect = correct + gotCorrect;
    setCorrect(nextCorrect);
    if (roundIdx + 1 >= rounds.length) {
      setDone(true);
      onComplete?.(nextCorrect, totalItems);
    } else {
      setRoundIdx(i => i + 1);
    }
  };

  const restart = () => { setRoundIdx(0); setCorrect(0); setDone(false); };

  if (!rounds.length) {
    return (
      <View style={s.center}>
        <Text style={{ fontSize: 60 }}>😕</Text>
        <Text style={s.doneTitle}>No questions yet!</Text>
        <TouchableOpacity style={s.homeBtn} onPress={onExit}>
          <Text style={s.homeText}>← Go back</Text>
        </TouchableOpacity>
      </View>
    );
  }

  if (done) {
    const pct  = totalItems ? Math.round((correct / totalItems) * 100) : 0;
    const gems = correct * 2;
    return (
      <View style={s.center}>
        <Text style={{ fontSize: 84 }}>{pct >= 80 ? "🏆" : pct >= 50 ? "🎉" : "💪"}</Text>
        <Text style={s.doneTitle}>{pct >= 80 ? "Amazing!" : pct >= 50 ? "Great job!" : "Keep going!"}</Text>
        <Text style={s.doneScore}>{correct} of {totalItems} correct</Text>
        <View style={s.earned}>
          <Text style={s.earnedText}>💎 {gems}</Text>
          <Text style={s.earnedLabel}>gems earned</Text>
        </View>
        <TouchableOpacity style={s.bigBtn} onPress={restart}>
          <Text style={s.bigText}>🔄 Play again</Text>
        </TouchableOpacity>
        <TouchableOpacity style={s.homeBtn} onPress={onExit}>
          <Text style={s.homeText}>🏠 Go home</Text>
        </TouchableOpacity>
      </View>
    );
  }

  const round = rounds[roundIdx];
  const bannerType: GameType = round.kind;

  return (
    <View style={s.root}>
      <View style={s.header}>
        <TouchableOpacity onPress={onExit} style={s.back}><Text style={s.backText}>←</Text></TouchableOpacity>
        <Text style={s.headerTitle}>{headerTitle ?? "Worksheet"}</Text>
        <Text style={s.progress}>{roundIdx + 1}/{rounds.length}</Text>
      </View>

      <View style={s.dots}>
        {rounds.map((_, i) => (
          <View key={i} style={[s.dot, i < roundIdx && s.dotDone, i === roundIdx && s.dotActive]} />
        ))}
      </View>

      <ScrollView contentContainerStyle={s.scroll} keyboardShouldPersistTaps="handled">
        <RoundBanner type={bannerType} />
        {round.kind === "match" && (
          <MatchGame key={roundIdx} questions={round.questions} childId={childId} context={context}
            onDone={(n) => advance(n)} />
        )}
        {round.kind === "tap" && (
          <QuestionCard key={roundIdx} question={round.q} childId={childId} kidMode context={context}
            onResult={(ok) => advance(ok ? 1 : 0)} />
        )}
        {round.kind === "build" && (
          <BuildGame key={roundIdx} question={round.q} childId={childId} context={context}
            onDone={(ok) => advance(ok ? 1 : 0)} />
        )}
        {round.kind === "trace" && (
          <TraceGame key={roundIdx} question={round.q} childId={childId}
            onDone={(ok) => advance(ok ? 1 : 0)} />
        )}
      </ScrollView>
    </View>
  );
}

/** Compose rounds: a Match opener (if ≥3 distinct short answers) then the rest. */
function buildRounds(questions: GameQuestion[]): Round[] {
  const rounds: Round[] = [];
  const pool = [...questions];

  // Gather up to 4 questions with DISTINCT, short answers for a match round.
  const matchQs: GameQuestion[] = [];
  const seen = new Set<string>();
  for (const q of pool) {
    const a = answerOf(q).toLowerCase();
    if (!a || a.length > 14 || seen.has(a)) continue;
    if (matchQs.length >= 4) break;
    seen.add(a);
    matchQs.push(q);
  }

  let remaining = pool;
  if (matchQs.length >= 3) {
    rounds.push({ kind: "match", questions: matchQs });
    const used = new Set(matchQs);
    remaining = pool.filter(q => !used.has(q));
  }

  for (const q of remaining) {
    const t = classify(q);
    rounds.push({ kind: t, q } as Round);
  }
  return rounds;
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, backgroundColor: "#f8f7ff" },

  header: { backgroundColor: colors.brand, paddingTop: 56, paddingBottom: 14, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center" },
  back:   { marginRight: 12 },
  backText: { fontSize: 28, color: "white", fontWeight: "700" },
  // No numberOfLines/ellipsis anywhere in the header: a long worksheet title
  // wraps onto a second line instead of being chopped. flexShrink:0 on the
  // counter keeps "3/12" from being squeezed off the right edge by the title.
  headerTitle: { flex: 1, fontSize: 20, fontWeight: "900", color: "white" },
  progress: { fontSize: 16, color: "rgba(255,255,255,0.85)", fontWeight: "800",
              flexShrink: 0, marginLeft: 12 },

  dots:   { flexDirection: "row", justifyContent: "center", gap: 8, backgroundColor: colors.brand, paddingBottom: 16 },
  dot:    { width: 10, height: 10, borderRadius: 5, backgroundColor: "rgba(255,255,255,0.3)" },
  dotDone:{ backgroundColor: colors.success },
  dotActive: { backgroundColor: "white", width: 14, height: 14, borderRadius: 7 },

  scroll: { padding: 20, paddingBottom: 48 },

  doneTitle: { fontSize: 34, fontWeight: "900", color: colors.text, textAlign: "center", marginTop: 12 },
  doneScore: { fontSize: 22, fontWeight: "800", color: colors.brand, marginTop: 6 },
  earned:    { alignItems: "center", marginTop: 20, marginBottom: 28, backgroundColor: "white", borderRadius: 18,
               paddingVertical: 16, paddingHorizontal: 34, shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  earnedText:{ fontSize: 34, fontWeight: "900", color: colors.text },
  earnedLabel:{ fontSize: 12, fontWeight: "800", color: colors.textMuted, textTransform: "uppercase", letterSpacing: 0.5, marginTop: 2 },
  bigBtn:  { backgroundColor: colors.brand, borderRadius: 20, paddingHorizontal: 40, paddingVertical: 18, marginBottom: 14 },
  bigText: { color: "white", fontWeight: "900", fontSize: 20 },
  homeBtn: { borderWidth: 2, borderColor: colors.brand, borderRadius: 20, paddingHorizontal: 40, paddingVertical: 16 },
  homeText:{ color: colors.brand, fontWeight: "800", fontSize: 18 },
});
