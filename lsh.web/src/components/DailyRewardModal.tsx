import { Modal, View, Text, TouchableOpacity, StyleSheet } from "react-native";
import { colors } from "../constants/theme";

interface Props {
  visible: boolean;
  coins?: number;
  xp?: number;
  streak?: number;
  onClose: () => void;
}

/** Celebratory daily-reward popup shown when a kid checks in for the day. */
export function DailyRewardModal({ visible, coins = 0, xp = 0, streak = 1, onClose }: Props) {
  return (
    <Modal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <View style={s.backdrop}>
        <View style={s.card}>
          <Text style={s.emoji}>🎁</Text>
          <Text style={s.title}>Daily Reward!</Text>
          <Text style={s.streak}>🔥 {streak}-day streak</Text>
          <View style={s.rewards}>
            <View style={s.pill}><Text style={s.pillText}>🪙 +{coins}</Text></View>
            <View style={s.pill}><Text style={s.pillText}>⭐ +{xp} XP</Text></View>
          </View>
          <TouchableOpacity style={s.btn} onPress={onClose} activeOpacity={0.85}>
            <Text style={s.btnText}>Awesome! 🎉</Text>
          </TouchableOpacity>
        </View>
      </View>
    </Modal>
  );
}

const s = StyleSheet.create({
  backdrop: { flex: 1, backgroundColor: "rgba(0,0,0,0.45)", justifyContent: "center", alignItems: "center", padding: 24 },
  card:     { width: "100%", maxWidth: 360, backgroundColor: "white", borderRadius: 28, padding: 28, alignItems: "center" },
  emoji:    { fontSize: 64, marginBottom: 8 },
  title:    { fontSize: 26, fontWeight: "900", color: colors.text, marginBottom: 6 },
  streak:   { fontSize: 16, fontWeight: "700", color: colors.textMuted, marginBottom: 20 },
  rewards:  { flexDirection: "row", gap: 14, marginBottom: 24 },
  pill:     { backgroundColor: colors.surfaceAlt, borderRadius: 16, paddingHorizontal: 18, paddingVertical: 12 },
  pillText: { fontSize: 20, fontWeight: "900", color: colors.text },
  btn:      { backgroundColor: colors.brand, borderRadius: 16, paddingVertical: 16, paddingHorizontal: 40, alignSelf: "stretch", alignItems: "center" },
  btnText:  { color: "white", fontSize: 18, fontWeight: "900" },
});
