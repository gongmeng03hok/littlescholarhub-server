import { View, Text, StyleSheet } from "react-native";
import { colors } from "../constants/theme";

interface Props {
  level: number;
  xpIntoLevel: number;
  xpForNext: number;
  coins: number;
}

/** Compact XP progress bar with level badge + coin count (kid dashboard). */
export function LevelBar({ level, xpIntoLevel, xpForNext, coins }: Props) {
  const pct = Math.max(0, Math.min(1, xpForNext ? xpIntoLevel / xpForNext : 0));
  return (
    <View style={s.wrap}>
      <View style={s.row}>
        <View style={s.levelBadge}>
          <Text style={s.levelText}>Lv {level}</Text>
        </View>
        <View style={s.track}>
          <View style={[s.fill, { width: `${pct * 100}%` }]} />
        </View>
        <Text style={s.coins}>🪙 {coins}</Text>
      </View>
      <Text style={s.xpText}>{xpIntoLevel} / {xpForNext} XP → Level {level + 1}</Text>
    </View>
  );
}

const s = StyleSheet.create({
  wrap:       { marginHorizontal: 20, marginBottom: 12, backgroundColor: "white", borderRadius: 18,
                padding: 16, shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  row:        { flexDirection: "row", alignItems: "center", gap: 12 },
  levelBadge: { backgroundColor: colors.brand, borderRadius: 12, paddingHorizontal: 10, paddingVertical: 6 },
  levelText:  { color: "white", fontWeight: "900", fontSize: 14 },
  track:      { flex: 1, height: 14, borderRadius: 7, backgroundColor: colors.surfaceAlt, overflow: "hidden" },
  fill:       { height: "100%", borderRadius: 7, backgroundColor: colors.success },
  coins:      { fontSize: 15, fontWeight: "800", color: colors.text },
  xpText:     { fontSize: 12, color: colors.textMuted, fontWeight: "600", marginTop: 8, textAlign: "center" },
});
