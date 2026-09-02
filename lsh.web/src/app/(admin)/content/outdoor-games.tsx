/**
 * Admin Outdoor Games Library — browse the FULL outdoor-games bank across
 * every grade (all 14 per grade), not the weekly-rotated 7-of-14 subset
 * parents/teachers see in Weekly Packets. Read-only reference view backed
 * by GET /content/outdoor-games (admin-only — see
 * lsh.database/68_outdoor_games_content.sql for how this content was
 * authored, and outdoor_games_image_prompts.md for the illustrator/
 * AI-image prompts that go with each game, kept out of this API since
 * nothing in the app renders images).
 */
import { useMemo, useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet, ActivityIndicator } from "react-native";
import { useOutdoorGames } from "../../../hooks/useApi";
import { colors, GRADES } from "../../../constants/theme";
import { EmptyState } from "../../../components/ui/EmptyState";

export default function AdminOutdoorGames() {
  const { data, isLoading, error } = useOutdoorGames();
  const [gradeId, setGradeId] = useState<number | null>(null);

  const games = data?.games ?? [];
  const countByGrade = useMemo(() => {
    const counts: Record<number, number> = {};
    for (const g of games) counts[g.grade_id] = (counts[g.grade_id] ?? 0) + 1;
    return counts;
  }, [games]);

  const shown = gradeId == null ? games : games.filter(g => g.grade_id === gradeId);

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>Outdoor Games Library 🏃</Text>
        <Text style={s.sub}>
          The full game bank behind Weekly Packets' "Outdoor Games" section — {games.length} games total,
          14 per grade. Each week's packet shows a rotating 7-of-14 pick automatically.
        </Text>

        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 12 }}>
          <TouchableOpacity onPress={() => setGradeId(null)} style={[s.chip, gradeId === null && s.chipActive]}>
            <Text style={[s.chipText, gradeId === null && s.chipTextActive]}>All ({games.length})</Text>
          </TouchableOpacity>
          {GRADES.map(g => (
            <TouchableOpacity
              key={g.grade_id}
              onPress={() => setGradeId(g.grade_id)}
              style={[s.chip, gradeId === g.grade_id && s.chipActive]}
            >
              <Text style={[s.chipText, gradeId === g.grade_id && s.chipTextActive]}>
                {g.label} ({countByGrade[g.grade_id] ?? 0})
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {isLoading ? (
          <ActivityIndicator color={colors.brand} size="large" style={{ marginTop: 40 }} />
        ) : error ? (
          <Text style={s.errorText}>{(error as Error).message}</Text>
        ) : shown.length === 0 ? (
          <EmptyState emoji="🏃" title="No games found" body="Nothing matches this filter." />
        ) : (
          <View style={s.grid}>
            {shown.map((game, i) => (
              <View key={`${game.grade_id}-${i}`} style={s.card}>
                <View style={s.cardHeader}>
                  <View style={{ flexDirection: "row", gap: 6 }}>
                    <Text style={s.gradeBadge}>{game.grade_label}</Text>
                    {!!game.players && <Text style={s.playersBadge}>👥 {game.players}</Text>}
                  </View>
                  <Text style={s.gameName}>{game.name}</Text>
                </View>
                {!!game.inspiration && (
                  <Text style={s.inspiration}>🕹️ {game.inspiration}</Text>
                )}
                <Text style={s.objective}>{game.objective}</Text>
                {!!game.prerequisites && (
                  <Text style={s.prerequisites}>🔓 Before you start: {game.prerequisites}</Text>
                )}

                <Text style={s.sectionLabel}>Materials</Text>
                {game.materials.map((m, mi) => (
                  <Text key={mi} style={s.listItem}>• {m}</Text>
                ))}

                <Text style={s.sectionLabel}>Steps</Text>
                {game.steps.map((step, si) => (
                  <View key={si} style={s.stepRow}>
                    <View style={s.stepBadge}><Text style={s.stepBadgeText}>{si + 1}</Text></View>
                    <Text style={s.stepText}>{step}</Text>
                  </View>
                ))}

                <Text style={s.safetyTip}>⚠️ {game.safety_tip}</Text>
              </View>
            ))}
          </View>
        )}
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.bg },
  header: {
    backgroundColor: "white", padding: 18,
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  title: { fontSize: 20, fontWeight: "900", color: colors.text },
  sub: { fontSize: 12.5, color: colors.textMuted, marginTop: 4, lineHeight: 18 },

  chip: { paddingHorizontal: 12, paddingVertical: 6, borderRadius: 14, backgroundColor: colors.surfaceAlt, marginRight: 6 },
  chipActive: { backgroundColor: colors.brand },
  chipText: { fontSize: 12.5, fontWeight: "700", color: colors.text },
  chipTextActive: { color: "white" },

  errorText: { color: "#c0392b", textAlign: "center", marginTop: 40 },
  body: { padding: 18, paddingBottom: 60 },

  grid: { flexDirection: "row", flexWrap: "wrap", gap: 14 },
  card: {
    flexBasis: "31%", flexGrow: 1, minWidth: 300,
    borderWidth: 2, borderColor: colors.border, borderRadius: 14,
    padding: 14, backgroundColor: "white",
  },
  cardHeader: { marginBottom: 4 },
  inspiration: { fontSize: 11.5, color: "#6b3aa8", backgroundColor: "#ece4f9", borderRadius: 6, padding: 6, marginTop: 4, marginBottom: 6, lineHeight: 16, fontStyle: "italic" },
  gradeBadge: {
    alignSelf: "flex-start", fontSize: 10.5, fontWeight: "800", color: "white",
    backgroundColor: colors.brand, borderRadius: 6, paddingHorizontal: 7, paddingVertical: 2, marginBottom: 6,
  },
  playersBadge: {
    alignSelf: "flex-start", fontSize: 10.5, fontWeight: "800", color: colors.brand,
    backgroundColor: colors.brandLight, borderRadius: 6, paddingHorizontal: 7, paddingVertical: 2, marginBottom: 6,
  },
  gameName: { fontSize: 15.5, fontWeight: "800", color: colors.text },
  objective: { fontSize: 12.5, color: colors.textMuted, fontStyle: "italic", marginTop: 4, marginBottom: 10, lineHeight: 18 },
  prerequisites: { fontSize: 11.5, color: "#1b5a8a", backgroundColor: "#e6f0fa", borderRadius: 6, padding: 6, marginTop: -4, marginBottom: 10, lineHeight: 16 },

  sectionLabel: { fontSize: 11, fontWeight: "800", color: colors.brand, textTransform: "uppercase", marginTop: 6, marginBottom: 4 },
  listItem: { fontSize: 12.5, color: colors.text, lineHeight: 19 },

  stepRow: { flexDirection: "row", alignItems: "flex-start", gap: 8, marginBottom: 5 },
  stepBadge: { width: 18, height: 18, borderRadius: 9, backgroundColor: colors.brand, alignItems: "center", justifyContent: "center", flexShrink: 0, marginTop: 1 },
  stepBadgeText: { color: "white", fontSize: 10, fontWeight: "800" },
  stepText: { fontSize: 12.5, color: colors.text, flex: 1, lineHeight: 18 },

  safetyTip: { fontSize: 11.5, color: "#8a5a1b", backgroundColor: "#f7ecd9", borderRadius: 8, padding: 8, marginTop: 10, lineHeight: 16 },
});
