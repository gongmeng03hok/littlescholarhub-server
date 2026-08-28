import { View, Text, StyleSheet } from "react-native";
import { colors } from "../constants/theme";

interface Props {
  streak: number;
  totalHours?: number;
  weeklyMins?: number;
}

export function StreakBadge({ streak, totalHours, weeklyMins }: Props) {
  return (
    <View style={s.row}>
      <View style={s.badge}>
        <Text style={s.fire}>🔥</Text>
        <View>
          <Text style={s.count}>{streak}</Text>
          <Text style={s.label}>day streak</Text>
        </View>
      </View>
      {weeklyMins !== undefined && (
        <View style={s.badge}>
          <Text style={s.fire}>⏱️</Text>
          <View>
            <Text style={s.count}>{weeklyMins}</Text>
            <Text style={s.label}>min this week</Text>
          </View>
        </View>
      )}
      {totalHours !== undefined && (
        <View style={s.badge}>
          <Text style={s.fire}>⭐</Text>
          <View>
            <Text style={s.count}>{Number(totalHours).toFixed(1)}</Text>
            <Text style={s.label}>total hours</Text>
          </View>
        </View>
      )}
    </View>
  );
}

const s = StyleSheet.create({
  row:   { flexDirection: "row", gap: 12 },
  badge: { flexDirection: "row", alignItems: "center", gap: 8, backgroundColor: colors.brandLight, borderRadius: 14, paddingHorizontal: 14, paddingVertical: 10, flex: 1 },
  fire:  { fontSize: 24 },
  count: { fontSize: 20, fontWeight: "900", color: colors.brand },
  label: { fontSize: 11, color: colors.textMuted, fontWeight: "600" },
});
