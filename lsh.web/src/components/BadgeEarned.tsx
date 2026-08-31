/**
 * The moment a child earns a badge.
 *
 * Until now, earning one produced nothing at all — the row went into
 * ChildBadges and the child found out later, if they happened to scroll their
 * home screen. A badge is rarer than a right answer and should not share its
 * 1.4s confetti burst; this one waits to be dismissed.
 *
 * The medal is the whole point, so it is the largest thing on screen and the
 * words sit under it. Several badges can land on one answer (first_sheet and
 * xp_100 together, for instance), so they are shown one after another.
 */
import { useEffect, useRef, useState } from "react";
import { Animated, Easing, Image, Pressable, StyleSheet, Text, View } from "react-native";

import { colors, fonts } from "../constants/theme";

export type EarnedBadge = {
  badge_slug: string;
  label: string;
  icon?: string | null;
  icon_url?: string | null;
  description?: string | null;
  xp_value?: number | null;
};

export function BadgeEarned({
  badges,
  onDone,
}: {
  badges: EarnedBadge[];
  onDone?: () => void;
}) {
  const [i, setI] = useState(0);
  const pop = useRef(new Animated.Value(0)).current;
  const spin = useRef(new Animated.Value(0)).current;

  useEffect(() => {
    if (!badges.length) return;
    pop.setValue(0);
    spin.setValue(0);
    Animated.parallel([
      Animated.spring(pop, { toValue: 1, friction: 5, tension: 90, useNativeDriver: true }),
      Animated.timing(spin, {
        toValue: 1, duration: 900, easing: Easing.out(Easing.cubic), useNativeDriver: true,
      }),
    ]).start();
  }, [i, badges.length, pop, spin]);

  if (!badges.length || i >= badges.length) return null;
  const b = badges[i];

  const next = () => {
    if (i + 1 < badges.length) setI(i + 1);
    else onDone?.();
  };

  const scale = pop.interpolate({ inputRange: [0, 1], outputRange: [0.3, 1] });
  const tilt = spin.interpolate({ inputRange: [0, 1], outputRange: ["-14deg", "0deg"] });

  return (
    <Pressable style={s.backdrop} onPress={next} accessibilityRole="button">
      <Animated.View style={[s.card, { transform: [{ scale }] }]}>
        <Text style={s.eyebrow}>NEW BADGE</Text>

        <Animated.View style={{ transform: [{ rotate: tilt }] }}>
          {b.icon_url ? (
            <Image
              source={{ uri: b.icon_url }}
              style={s.medal}
              resizeMode="contain"
              accessibilityLabel={b.label}
            />
          ) : (
            <Text style={s.fallback}>{b.icon || "🏅"}</Text>
          )}
        </Animated.View>

        <Text style={s.title}>{b.label}</Text>
        {!!b.description && <Text style={s.body}>{b.description}</Text>}
        {!!b.xp_value && <Text style={s.xp}>+{b.xp_value} XP</Text>}

        <Text style={s.tap}>
          {badges.length > 1 ? `Tap to keep going  (${i + 1}/${badges.length})` : "Tap to keep going"}
        </Text>
      </Animated.View>
    </Pressable>
  );
}

const s = StyleSheet.create({
  backdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(28, 20, 44, 0.62)",
    alignItems: "center",
    justifyContent: "center",
    zIndex: 60,
    padding: 24,
  },
  card: {
    backgroundColor: "#fffdf8",
    borderRadius: 28,
    paddingVertical: 26,
    paddingHorizontal: 28,
    alignItems: "center",
    maxWidth: 340,
    borderWidth: 3,
    borderColor: "#ffd97a",
  },
  eyebrow: {
    fontSize: 12, fontWeight: "800", letterSpacing: 2,
    color: "#b4791a", marginBottom: 10,
  },
  // The medal carries the meaning; everything else is a caption to it.
  medal: { width: 150, height: 174 },
  fallback: { fontSize: 96 },
  title: {
    fontFamily: fonts.kid, fontSize: 26, fontWeight: "800",
    color: colors.text, marginTop: 10, textAlign: "center",
  },
  body: {
    fontSize: 15, lineHeight: 21, color: colors.textMuted,
    textAlign: "center", marginTop: 6,
  },
  xp: {
    fontFamily: fonts.kid, fontSize: 18, fontWeight: "800",
    color: "#1f8a4c", marginTop: 10,
  },
  tap: { fontSize: 12, color: colors.textMuted, marginTop: 16 },
});
