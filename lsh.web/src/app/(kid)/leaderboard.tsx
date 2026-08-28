/**
 * Kid Leaderboard — friendly, privacy-safe ranking.
 * Shows ONLY nickname + avatar + coarse region for opt-in families.
 */
import { useEffect, useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity, StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { gamificationApi, LeaderEntry } from "../../api/gamification";
import { avatarEmoji } from "../../constants/avatars";
import { colors } from "../../constants/theme";

export default function Leaderboard() {
  const router = useRouter();
  const { activeChild } = useChildStore();
  const childId = activeChild?.child_id;

  const [scope, setScope]   = useState<"global" | "region">("global");
  const [entries, setEntries] = useState<LeaderEntry[]>([]);
  const [region, setRegion] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!childId) return;
    let alive = true;
    setLoading(true);
    gamificationApi.leaderboard(childId, scope)
      .then(res => { if (alive) { setEntries(res.entries || []); setRegion(res.region); } })
      .catch(() => { if (alive) setEntries([]); })
      .finally(() => { if (alive) setLoading(false); });
    return () => { alive = false; };
  }, [childId, scope]);

  const medal = (rank: number) => (rank === 1 ? "🥇" : rank === 2 ? "🥈" : rank === 3 ? "🥉" : `#${rank}`);

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()}><Text style={s.back}>←</Text></TouchableOpacity>
        <Text style={s.title}>🏆 Leaderboard</Text>
        <View style={{ width: 28 }} />
      </View>

      <View style={s.tabs}>
        <TouchableOpacity style={[s.tab, scope === "global" && s.tabActive]} onPress={() => setScope("global")}>
          <Text style={[s.tabText, scope === "global" && s.tabTextActive]}>🌍 Everyone</Text>
        </TouchableOpacity>
        <TouchableOpacity style={[s.tab, scope === "region" && s.tabActive]} onPress={() => setScope("region")}>
          <Text style={[s.tabText, scope === "region" && s.tabTextActive]}>📍 {region || "My region"}</Text>
        </TouchableOpacity>
      </View>

      {loading ? (
        <ActivityIndicator color={colors.brand} style={{ marginTop: 40 }} />
      ) : entries.length === 0 ? (
        <View style={s.empty}>
          <Text style={s.emptyEmoji}>🌱</Text>
          <Text style={s.emptyText}>No one here yet! Keep learning to climb the board.</Text>
          <Text style={s.emptyHint}>A grown-up can turn on the leaderboard in Settings.</Text>
        </View>
      ) : (
        entries.map(e => {
          const mine = e.display_name === activeChild?.nickname;
          return (
            <View key={`${e.rank}-${e.display_name}`} style={[s.rowCard, mine && s.rowMine]}>
              <Text style={s.rank}>{medal(e.rank)}</Text>
              <Text style={s.avatar}>{avatarEmoji(e.avatar_slug)}</Text>
              <View style={{ flex: 1 }}>
                <Text style={s.nameText}>{e.display_name}{mine ? " (you)" : ""}</Text>
                <Text style={s.metaText}>Level {e.level} · {e.region}</Text>
              </View>
              <Text style={s.xp}>{e.total_xp} XP</Text>
            </View>
          );
        })
      )}
      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: colors.brandLight },
  content: { paddingBottom: 40 },
  header:  { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
             paddingTop: Platform.OS === "ios" ? 60 : 32, paddingBottom: 16, paddingHorizontal: 20,
             backgroundColor: colors.brand },
  back:    { fontSize: 28, color: "white", fontWeight: "900" },
  title:   { fontSize: 22, fontWeight: "900", color: "white" },

  tabs:      { flexDirection: "row", gap: 10, padding: 20 },
  tab:       { flex: 1, backgroundColor: "white", borderRadius: 14, paddingVertical: 12, alignItems: "center",
               borderWidth: 2, borderColor: "transparent" },
  tabActive: { borderColor: colors.brand, backgroundColor: colors.surfaceAlt },
  tabText:      { fontSize: 15, fontWeight: "800", color: colors.textMuted },
  tabTextActive:{ color: colors.brand },

  rowCard: { flexDirection: "row", alignItems: "center", gap: 14, marginHorizontal: 20, marginBottom: 10,
             backgroundColor: "white", borderRadius: 16, padding: 16,
             borderWidth: 2, borderColor: "transparent" },
  rowMine: { borderColor: colors.brand, backgroundColor: colors.surfaceAlt },
  rank:    { fontSize: 20, fontWeight: "900", color: colors.text, width: 40, textAlign: "center" },
  avatar:  { fontSize: 32 },
  nameText:{ fontSize: 17, fontWeight: "800", color: colors.text },
  metaText:{ fontSize: 13, color: colors.textMuted, fontWeight: "600", marginTop: 2 },
  xp:      { fontSize: 15, fontWeight: "900", color: colors.brand },

  empty:     { alignItems: "center", padding: 40, marginTop: 20 },
  emptyEmoji:{ fontSize: 56, marginBottom: 12 },
  emptyText: { fontSize: 18, fontWeight: "800", color: colors.text, textAlign: "center", lineHeight: 26 },
  emptyHint: { fontSize: 14, color: colors.textMuted, textAlign: "center", marginTop: 8 },
});
