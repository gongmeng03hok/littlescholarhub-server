/**
 * The moment a child gets one right.
 *
 * Until now a correct answer changed a border colour and printed a line of
 * text. The landing page promises "game-style chimes & confetti for ages 4-8",
 * and this is the thing that was missing.
 *
 * Deliberately short (1.4s) and non-blocking: it plays over the question, does
 * not need dismissing, and never gets in the way of a child who is on a roll.
 * Younger children get the full burst; from about 4th grade it is toned down,
 * because a ten-year-old finds a confetti explosion for one sum patronising.
 */
import { useEffect, useRef } from "react";
import { Animated, Easing, StyleSheet, Text, View, Platform } from "react-native";

const PRAISE_YOUNG = ["Brilliant!", "You got it!", "Well done!", "Amazing!",
                      "Yes! Nice work!", "Superstar!", "That's right!"];
const PRAISE_OLDER = ["Correct", "Nicely done", "That's right", "Good thinking"];

const CONFETTI = ["#ff4d9d", "#8b5cf6", "#22d3ee", "#a3e635", "#fbbf24", "#fb7185"];

type Props = {
  /** Flip to a new value each time an answer is right; the burst replays. */
  trigger: number;
  /** grade_id — TK is 0. Older children get a calmer version. */
  grade?: number;
  /** Streak length, shown once it is worth showing. */
  streak?: number;
};

export function CelebrationBurst({ trigger, grade = 0, streak = 0 }: Props) {
  const young = grade <= 5;                 // TK–4th get the full show
  const pop = useRef(new Animated.Value(0)).current;
  const fade = useRef(new Animated.Value(0)).current;
  const pieces = useRef(
    Array.from({ length: young ? 14 : 6 }, () => new Animated.Value(0)),
  ).current;

  useEffect(() => {
    if (!trigger) return;
    pop.setValue(0);
    fade.setValue(0);
    pieces.forEach(p => p.setValue(0));

    Animated.sequence([
      Animated.parallel([
        // A slight overshoot reads as "pop" rather than "fade in".
        Animated.spring(pop, { toValue: 1, friction: 5, tension: 140, useNativeDriver: false }),
        Animated.timing(fade, { toValue: 1, duration: 140, useNativeDriver: false }),
        ...pieces.map((p, i) =>
          Animated.timing(p, {
            toValue: 1,
            duration: 900 + (i % 5) * 120,
            easing: Easing.out(Easing.quad),
            useNativeDriver: false,
          }),
        ),
      ]),
      Animated.timing(fade, { toValue: 0, duration: 320, delay: 620, useNativeDriver: false }),
    ]).start();
  }, [trigger]);

  if (!trigger) return null;

  const praise = (young ? PRAISE_YOUNG : PRAISE_OLDER)[trigger % (young ? PRAISE_YOUNG.length : PRAISE_OLDER.length)];
  const scale = pop.interpolate({ inputRange: [0, 1], outputRange: [0.4, 1] });

  return (
    <View style={s.overlay} pointerEvents="none" accessibilityRole="alert">
      {young && pieces.map((p, i) => {
        const angle = (i / pieces.length) * Math.PI * 2;
        const dist = 120 + (i % 4) * 34;
        return (
          <Animated.View
            key={i}
            style={[
              s.confetti,
              {
                backgroundColor: CONFETTI[i % CONFETTI.length],
                opacity: p.interpolate({ inputRange: [0, 0.7, 1], outputRange: [1, 1, 0] }),
                transform: [
                  { translateX: p.interpolate({ inputRange: [0, 1], outputRange: [0, Math.cos(angle) * dist] }) },
                  { translateY: p.interpolate({ inputRange: [0, 1], outputRange: [0, Math.sin(angle) * dist + 40] }) },
                  { rotate: p.interpolate({ inputRange: [0, 1], outputRange: ["0deg", `${(i % 2 ? 1 : -1) * 300}deg`] }) },
                  { scale: p.interpolate({ inputRange: [0, 0.3, 1], outputRange: [0.4, 1.1, 0.7] }) },
                ],
              },
            ]}
          />
        );
      })}

      <Animated.View style={[s.badge, { opacity: fade, transform: [{ scale }] }]}>
        <Text style={s.emoji}>{young ? "🌟" : "✅"}</Text>
        <Text style={s.praise}>{praise}</Text>
        {streak >= 3 && (
          <Text style={s.streak}>{streak} in a row! 🔥</Text>
        )}
      </Animated.View>
    </View>
  );
}

const s = StyleSheet.create({
  overlay: {
    ...StyleSheet.absoluteFillObject,
    alignItems: "center",
    justifyContent: "center",
    zIndex: 50,
  },
  confetti: {
    position: "absolute",
    width: 14,
    height: 14,
    borderRadius: 4,
  },
  badge: {
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 34,
    paddingVertical: 22,
    borderRadius: 28,
    backgroundColor: "rgba(255,255,255,0.96)",
    // A glossy lift, so the badge sits above the card rather than on it.
    ...(Platform.OS === "web"
      ? { boxShadow: "0 18px 44px rgba(139,92,246,0.35), 0 2px 0 rgba(255,255,255,0.9) inset" } as any
      : { shadowColor: "#8b5cf6", shadowOpacity: 0.35, shadowRadius: 24, shadowOffset: { width: 0, height: 14 }, elevation: 12 }),
  },
  emoji:  { fontSize: 62, lineHeight: 70 },
  praise: { fontSize: 24, fontWeight: "800", color: "#5b21b6", marginTop: 2 },
  streak: { fontSize: 14, fontWeight: "700", color: "#c2410c", marginTop: 4 },
});
