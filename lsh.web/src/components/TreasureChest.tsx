import { View, Text, Image, StyleSheet } from "react-native";
import { colors } from "../constants/theme";
import { chestEmoji, chestImage } from "../constants/avatars";

interface Props { gems: number; stars: number; chestStyle?: string; }

/** Treasure chest progress tracker — gems & stars a child has collected. */
export function TreasureChest({ gems, stars, chestStyle }: Props) {
  const img = chestImage(chestStyle);
  return (
    <View style={s.wrap}>
      {img
        ? <Image source={img} style={s.chestImg} resizeMode="contain" />
        : <Text style={s.chest}>{chestEmoji(chestStyle)}</Text>}
      <View style={{ flex: 1 }}>
        <Text style={s.label}>My treasure chest</Text>
        <View style={s.row}>
          <Text style={s.count}>💎 {gems}</Text>
          <Text style={s.count}>⭐ {stars}</Text>
        </View>
      </View>
    </View>
  );
}

const s = StyleSheet.create({
  wrap:  { flexDirection: "row", alignItems: "center", gap: 14, marginHorizontal: 20, marginBottom: 12,
           backgroundColor: "white", borderRadius: 18, padding: 16,
           shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  chest: { fontSize: 46 },
  chestImg: { width: 58, height: 58 },
  label: { fontSize: 12, color: colors.textMuted, fontWeight: "700", letterSpacing: 0.5, textTransform: "uppercase" },
  row:   { flexDirection: "row", gap: 18, marginTop: 4 },
  count: { fontSize: 22, fontWeight: "900", color: colors.text },
});
