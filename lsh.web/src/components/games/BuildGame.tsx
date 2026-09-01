/**
 * BuildGame — tap letter / number tiles to spell the answer.
 * Used for fill-in questions with a short answer (≤ 9 chars).
 */
import { useMemo, useState } from "react";
import { View, Text, TouchableOpacity, StyleSheet, Image } from "react-native";
import { GameQuestion, answerOf, textOf, recordAttempt, shuffle, Celebrate, colors } from "./gameKit";
import { questionImage, type ArtContext } from "../../constants/questionImages";

interface Props { question: GameQuestion; childId?: number; context?: ArtContext; onDone: (correct: boolean) => void; }

interface Tile { id: number; ch: string; }

const LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
const DIGITS  = "0123456789".split("");

export function BuildGame({ question, childId, context, onDone }: Props) {
  const answer  = answerOf(question);
  const target  = answer.replace(/\s+/g, "").toUpperCase();
  const isNum   = /^[0-9]+$/.test(target);
  const img     = questionImage(textOf(question), question.hint, context);

  // Answer chars + a couple of distractors, shuffled once.
  const tiles = useMemo<Tile[]>(() => {
    const base = target.split("");
    const pool = isNum ? DIGITS : LETTERS;
    const extras = Math.min(3, Math.max(1, 5 - base.length));
    for (let i = 0; i < extras; i++) {
      base.push(pool[Math.floor(Math.random() * pool.length)]);
    }
    return shuffle(base).map((ch, id) => ({ id, ch }));
  }, [answer]);

  const [placed, setPlaced] = useState<number[]>([]); // tile ids, in order
  const [state,  setState]  = useState<"idle" | "correct" | "wrong">("idle");

  const built = placed.map(id => tiles.find(t => t.id === id)!.ch).join("");
  const used  = new Set(placed);

  const place = (id: number) => {
    if (state === "correct") return;
    const next = [...placed, id];
    setPlaced(next);
    setState("idle");
    const word = next.map(i => tiles.find(t => t.id === i)!.ch).join("");
    if (word.length === target.length) check(word);
  };

  const removeAt = (pos: number) => {
    if (state === "correct") return;
    setPlaced(placed.filter((_, i) => i !== pos));
    setState("idle");
  };

  const check = async (word: string) => {
    if (word.toUpperCase() === target) {
      setState("correct");
      await recordAttempt(question, childId, answer);
      setTimeout(() => onDone(true), 1300);
    } else {
      setState("wrong");
      await recordAttempt(question, childId, word);
      setTimeout(() => { setPlaced([]); setState("idle"); }, 900);
    }
  };

  return (
    <View style={[s.card, state === "correct" && s.ok, state === "wrong" && s.bad]}>
      {state === "correct" && <Celebrate emoji="🎉" />}
      {img && <Image source={img} style={s.img} resizeMode="contain" />}
      <Text style={s.q}>{textOf(question)}</Text>
      {question.hint && state === "idle" && <Text style={s.hint}>💡 {question.hint}</Text>}

      {/* Answer slots */}
      <View style={s.slots}>
        {target.split("").map((_, i) => {
          const id = placed[i];
          const ch = id != null ? tiles.find(t => t.id === id)!.ch : "";
          return (
            <TouchableOpacity key={i} disabled={id == null} onPress={() => removeAt(i)}
              style={[s.slot, ch ? s.slotFilled : null,
                state === "correct" && s.slotOk, state === "wrong" && s.slotBad]}>
              <Text style={s.slotText}>{ch}</Text>
            </TouchableOpacity>
          );
        })}
      </View>

      {/* Tile tray */}
      <View style={s.tray}>
        {tiles.map(t => (
          <TouchableOpacity key={t.id} disabled={used.has(t.id) || state === "correct"}
            onPress={() => place(t.id)}
            style={[s.tile, used.has(t.id) && s.tileUsed]}>
            <Text style={[s.tileText, used.has(t.id) && s.tileTextUsed]}>{t.ch}</Text>
          </TouchableOpacity>
        ))}
      </View>

      {state === "wrong" && <Text style={s.tryAgain}>Oops — try again! 💪</Text>}
      {state === "correct" && <Text style={s.great}>You spelled it! 🌟</Text>}
    </View>
  );
}

const s = StyleSheet.create({
  card:   { backgroundColor: "white", borderRadius: 22, padding: 24, borderWidth: 2, borderColor: "transparent",
            shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 12, elevation: 3 },
  ok:     { borderColor: colors.success, backgroundColor: "#f4f8f2" },
  bad:    { borderColor: colors.danger,  backgroundColor: "#fdf1ef" },
  img:    { width: 180, height: 180, alignSelf: "center", marginBottom: 12 },
  q:      { fontSize: 20, fontWeight: "800", color: colors.text, textAlign: "center", lineHeight: 28 },
  hint:   { fontSize: 13, color: colors.textMuted, fontStyle: "italic", textAlign: "center", marginTop: 8 },

  slots:  { flexDirection: "row", flexWrap: "wrap", justifyContent: "center", gap: 10, marginTop: 20, marginBottom: 8 },
  slot:   { width: 52, height: 60, borderRadius: 14, borderWidth: 2, borderStyle: "dashed",
            borderColor: colors.border, alignItems: "center", justifyContent: "center", backgroundColor: colors.brandLight },
  slotFilled: { borderStyle: "solid", borderColor: colors.brand, backgroundColor: "white" },
  slotOk:  { borderColor: colors.success },
  slotBad: { borderColor: colors.danger },
  slotText:{ fontSize: 30, fontWeight: "900", color: colors.text },

  tray:   { flexDirection: "row", flexWrap: "wrap", justifyContent: "center", gap: 12, marginTop: 16 },
  tile:   { width: 56, height: 64, borderRadius: 16, backgroundColor: colors.brand, alignItems: "center",
            justifyContent: "center", shadowColor: "#000", shadowOpacity: 0.12, shadowRadius: 4, elevation: 2 },
  tileUsed:{ backgroundColor: "#efe9e2" },
  tileText:{ fontSize: 30, fontWeight: "900", color: "white" },
  tileTextUsed:{ color: "transparent" },

  tryAgain: { textAlign: "center", marginTop: 16, fontSize: 16, fontWeight: "800", color: colors.danger },
  great:    { textAlign: "center", marginTop: 16, fontSize: 18, fontWeight: "900", color: colors.success },
});
