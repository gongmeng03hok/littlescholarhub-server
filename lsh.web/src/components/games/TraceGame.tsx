/**
 * TraceGame — drag a finger over the big letter / number to "trace" it.
 * For single-character answers. Coverage is measured by total drag distance,
 * so it works with plain PanResponder (no drawing library) on web + native.
 */
import { useMemo, useRef, useState } from "react";
import { View, Text, StyleSheet, PanResponder, Animated } from "react-native";
import { GameQuestion, answerOf, textOf, recordAttempt, Celebrate, colors } from "./gameKit";

interface Props { question: GameQuestion; childId?: number; onDone: (correct: boolean) => void; }

const NEEDED = 600; // px of finger travel to fully "trace" the glyph

export function TraceGame({ question, childId, onDone }: Props) {
  const answer = answerOf(question);
  const glyph  = answer.charAt(0).toUpperCase();

  const [progress, setProgress] = useState(0);
  const [done, setDone]         = useState(false);
  const dist = useRef(0);
  const last = useRef<{ x: number; y: number } | null>(null);
  const fill = useRef(new Animated.Value(0)).current;

  const finish = async () => {
    if (done) return;
    setDone(true);
    await recordAttempt(question, childId, answer);
    setTimeout(() => onDone(true), 1300);
  };

  const bump = (x: number, y: number) => {
    if (done) return;
    if (last.current) {
      dist.current += Math.hypot(x - last.current.x, y - last.current.y);
    }
    last.current = { x, y };
    const p = Math.min(1, dist.current / NEEDED);
    setProgress(p);
    Animated.timing(fill, { toValue: p, duration: 80, useNativeDriver: false }).start();
    if (p >= 1) finish();
  };

  const pan = useMemo(() => PanResponder.create({
    onStartShouldSetPanResponder: () => true,
    onMoveShouldSetPanResponder:  () => true,
    onPanResponderGrant:   (e) => { last.current = { x: e.nativeEvent.locationX, y: e.nativeEvent.locationY }; },
    onPanResponderMove:    (e) => bump(e.nativeEvent.locationX, e.nativeEvent.locationY),
    onPanResponderRelease: () => { last.current = null; },
  }), [done]);

  const pct = Math.round(progress * 100);

  return (
    <View style={[s.card, done && s.ok]}>
      {done && <Celebrate emoji="⭐" />}
      <Text style={s.q}>{textOf(question)}</Text>
      <Text style={s.instruction}>Drag your finger over the letter to trace it ✏️</Text>

      <View style={s.padWrap}>
        <View style={s.pad} {...pan.panHandlers}>
          {/* faint target glyph */}
          <Text style={s.glyphGhost}>{glyph}</Text>
          {/* filled glyph, revealed by width as you trace */}
          <Animated.View style={[s.glyphFillClip, { width: fill.interpolate({ inputRange: [0, 1], outputRange: ["0%", "100%"] }) }]}>
            <Text style={[s.glyphFill, done && { color: colors.success }]}>{glyph}</Text>
          </Animated.View>
        </View>
      </View>

      <View style={s.meter}>
        <Animated.View style={[s.meterFill, { width: fill.interpolate({ inputRange: [0, 1], outputRange: ["0%", "100%"] }) }]} />
      </View>
      <Text style={s.pct}>{done ? "Perfect tracing! 🌟" : `${pct}%`}</Text>
    </View>
  );
}

const s = StyleSheet.create({
  card:  { backgroundColor: "white", borderRadius: 22, padding: 24, borderWidth: 2, borderColor: "transparent",
           shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 12, elevation: 3 },
  ok:    { borderColor: colors.success, backgroundColor: "#f4f8f2" },
  q:     { fontSize: 20, fontWeight: "800", color: colors.text, textAlign: "center", lineHeight: 28 },
  instruction: { fontSize: 13, color: colors.textMuted, textAlign: "center", marginTop: 8, marginBottom: 16 },

  padWrap: { alignItems: "center" },
  pad:     { width: 220, height: 220, borderRadius: 24, backgroundColor: colors.brandLight,
             borderWidth: 2, borderColor: colors.border, alignItems: "center", justifyContent: "center", overflow: "hidden" },
  glyphGhost: { position: "absolute", fontSize: 170, fontWeight: "900", color: "#e7ddcf" },
  glyphFillClip: { position: "absolute", left: 0, top: 0, bottom: 0, overflow: "hidden", alignItems: "flex-start", justifyContent: "center" },
  glyphFill:  { width: 220, textAlign: "center", fontSize: 170, fontWeight: "900", color: colors.brand },

  meter:     { height: 12, borderRadius: 6, backgroundColor: "#eee", overflow: "hidden", marginTop: 20 },
  meterFill: { height: 12, backgroundColor: colors.accent },
  pct:       { textAlign: "center", marginTop: 10, fontSize: 16, fontWeight: "900", color: colors.text },
});
