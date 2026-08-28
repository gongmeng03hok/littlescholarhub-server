import { View, Text, ScrollView, StyleSheet } from "react-native";
import { colors } from "../constants/theme";
import { useBadges } from "../hooks/useApi";

interface Props {
  childId: number | undefined;
}

export function AchievementsWall({ childId }: Props) {
  const { data: badges = [] } = useBadges(childId);

  if (!childId || badges.length === 0) return null;

  return (
    <View style={s.root}>
      <Text style={s.title}>🏅 Achievements</Text>
      <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={s.row}>
        {badges.map((b: any) => (
          <View key={b.badge_slug} style={s.badge}>
            <Text style={s.icon}>{b.icon}</Text>
            <Text style={s.label} numberOfLines={2}>{b.label}</Text>
          </View>
        ))}
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:  { marginTop: 16 },
  title: { fontSize: 15, fontWeight: "800", color: colors.text, marginBottom: 10 },
  row:   { gap: 10 },
  badge: { width: 84, alignItems: "center", backgroundColor: colors.brandLight,
           borderRadius: 14, paddingVertical: 12, paddingHorizontal: 6 },
  icon:  { fontSize: 28, marginBottom: 6 },
  label: { fontSize: 11, fontWeight: "700", color: colors.text, textAlign: "center" },
});
