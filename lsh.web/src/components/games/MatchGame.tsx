/**
 * MatchGame — connect each prompt on the left to its answer on the right.
 * Built from a small batch of questions; records one attempt per matched pair
 * so rewards flow exactly like the other games.
 */
import { CelebrationBurst } from "../CelebrationBurst";
import { useMemo, useState } from "react";
import { View, Text, TouchableOpacity, StyleSheet, Image } from "react-native";
import { GameQuestion, answerOf, textOf, recordAttempt, shuffle, Celebrate, colors } from "./gameKit";
import { fonts } from "../../constants/theme";
import { questionImage, type ArtContext } from "../../constants/questionImages";
import { SpeakButton } from "../SpeakButton";

interface Props { questions: GameQuestion[]; childId?: number; context?: ArtContext; onDone: (correct: number) => void; }

interface Left  { key: number; q: GameQuestion; label: string; img: any; answer: string; }
interface Right { key: number; answer: string; }

export function MatchGame({ questions, childId, context, onDone }: Props) {
  const lefts = useMemo<Left[]>(() => questions.map((q, i) => {
    const img = questionImage(textOf(q), q.hint, context);
    const t   = textOf(q);
    // Keep the wording even when there's a picture — two subtraction cards would
    // otherwise both show a bare "−" glyph and the round couldn't be solved.
    return { key: i, q, img, answer: answerOf(q), label: tidy(t) };
  }), [questions, context]);

  const rights = useMemo<Right[]>(
    () => shuffle(lefts.map(l => ({ key: l.key, answer: l.answer }))),
    [lefts],
  );

  const [sel, setSel]         = useState<number | null>(null); // selected left key
  const [matched, setMatched] = useState<Set<number>>(new Set());
  const [flash, setFlash]     = useState<{ side: "l" | "r"; key: number } | null>(null);
  const [wonAt, setWonAt]     = useState(false);
  // Bumped on each correct pair so the burst replays; a run of correct
  // matches is the thing worth rewarding, not just finishing the board.
  const [burst, setBurst]     = useState(0);

  const tryMatch = async (leftKey: number, rightAnswer: string, rightKey: number) => {
    const left = lefts.find(l => l.key === leftKey)!;
    if (left.answer.toLowerCase() === rightAnswer.toLowerCase()) {
      const next = new Set(matched); next.add(leftKey);
      setMatched(next); setSel(null);
      setBurst(b => b + 1);
      await recordAttempt(left.q, childId, left.answer);
      if (next.size === lefts.length) {
        setWonAt(true);
        setTimeout(() => onDone(lefts.length), 1400);
      }
    } else {
      setFlash({ side: "r", key: rightKey });
      setTimeout(() => setFlash(null), 500);
      setSel(null);
    }
  };

  return (
    <View style={s.card}>
      <CelebrationBurst
        trigger={burst}
        grade={typeof context?.grade === "number"
                 ? context.grade
                 : parseInt(String(context?.grade ?? 0), 10) || 0}
        streak={matched.size}
      />
      {wonAt && <Celebrate emoji="🎉" />}
      <Text style={s.title}>Match each one to its answer</Text>
      <View style={s.columns}>
        {/* Left: prompts */}
        <View style={s.col}>
          {lefts.map(l => {
            const isMatched = matched.has(l.key);
            return (
              <TouchableOpacity key={l.key} disabled={isMatched}
                onPress={() => setSel(l.key)}
                style={[s.item, sel === l.key && s.itemSel, isMatched && s.itemDone]}>
                {!!l.img && (
                  <View style={s.imgTile}>
                    <Image source={l.img} style={s.itemImg} resizeMode="contain" />
                  </View>
                )}
                <Text style={[s.itemText, isMatched && s.itemTextDone]}>{l.label}</Text>
                {isMatched
                  ? <Text style={s.check}>✓</Text>
                  : <SpeakButton text={l.label} accessibilityLabel={`Read this out loud: ${l.label}`} />}
              </TouchableOpacity>
            );
          })}
        </View>

        {/* Right: answers */}
        <View style={s.col}>
          {rights.map(r => {
            const isMatched = matched.has(r.key);
            const isFlash   = flash?.side === "r" && flash.key === r.key;
            return (
              <TouchableOpacity key={r.key} disabled={isMatched || sel == null}
                onPress={() => sel != null && tryMatch(sel, r.answer, r.key)}
                style={[s.item, s.itemAnswer, isMatched && s.itemDone, isFlash && s.itemWrong,
                  sel != null && !isMatched && s.itemActive]}>
                <Text style={[s.answerText, isMatched && s.itemTextDone]}>{r.answer}</Text>
                {isMatched
                  ? <Text style={s.check}>✓</Text>
                  : <SpeakButton text={r.answer} accessibilityLabel={`Read this answer out loud: ${r.answer}`} />}
              </TouchableOpacity>
            );
          })}
        </View>
      </View>
      <Text style={s.helper}>
        {wonAt ? "All matched! 🌟" : sel != null ? "Now tap its answer →" : "Tap a picture / word to start"}
      </Text>
    </View>
  );
}

/**
 * Tidy a prompt for a match tile. Deliberately does NOT truncate: this used to
 * cut at 42 chars, which turned "Which word is spelled correctly? (sight word:
 * 'at')" into "…(sight…" and hid the very word the child had to match. Tiles
 * grow to fit instead — see `item` / `itemText` below.
 */
function tidy(t: string): string {
  // Reading prompts arrive as passage + blank line + question; the tile only
  // needs the question, and the passage is already on screen above.
  const parts = t.split("\n\n");
  return (parts.length > 1 ? parts[parts.length - 1] : t).trim();
}

const s = StyleSheet.create({
  card:  { backgroundColor: "white", borderRadius: 22, padding: 20,
           shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 12, elevation: 3 },
  title: { fontSize: 22, fontWeight: "700", fontFamily: fonts.kid, color: colors.text,
           textAlign: "center", marginBottom: 18 },
  columns: { flexDirection: "row", gap: 12 },
  col:   { flex: 1, gap: 10 },
  // minHeight (not height) so a tile grows to fit however many lines the
  // prompt wraps to — nothing is ever clipped.
  item:  { minHeight: 64, borderRadius: 16, borderWidth: 2, borderColor: colors.border, backgroundColor: "white",
           alignItems: "center", justifyContent: "center", padding: 10, flexDirection: "row", gap: 6 },
  itemAnswer: { backgroundColor: colors.brandLight },
  itemSel:    { borderColor: colors.brand, backgroundColor: colors.brandLight },
  itemActive: { borderColor: colors.accent },
  itemWrong:  { borderColor: colors.danger, backgroundColor: "#fdf1ef" },
  itemDone:   { borderColor: colors.success, backgroundColor: "#f0f6ee", opacity: 0.85 },
  // The picture is the question for a child who cannot read the sentence
  // yet, so it leads. 54px made it look like a bullet point.
  itemImg:    { width: 96, height: 96, borderRadius: 20 },
  imgTile:    {
    width: 112, height: 112, borderRadius: 24, marginRight: 14,
    alignItems: "center", justifyContent: "center",
    backgroundColor: "#fff",
  },
  itemText:   { flex: 1, flexShrink: 1, fontSize: 17, lineHeight: 24, fontWeight: "600",
                fontFamily: fonts.kid, color: colors.text, letterSpacing: 0.1 },
  itemTextDone:{ color: colors.success },
  // flexShrink lets a long answer wrap inside its tile rather than spilling
  // past the rounded border.
  answerText: { fontSize: 22, fontWeight: "700", fontFamily: fonts.kid,
                color: colors.text, textAlign: "center", letterSpacing: 0.2 },
  check:      { fontSize: 18, fontWeight: "900", color: colors.success },
  helper:     { textAlign: "center", marginTop: 16, fontSize: 14, fontWeight: "700", color: colors.textMuted },
});
