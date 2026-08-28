import { useEffect, useState } from "react";
import {
  View, Text, TouchableOpacity, ScrollView,
  StyleSheet, ActivityIndicator, Alert, Platform,
} from "react-native";
import { useChildStore } from "../../store/childStore";
import { useRewardItems, useRedeemReward, useRedemptions } from "../../hooks/useRewards";
import { gamificationApi, GameProfile } from "../../api/gamification";
import { colors } from "../../constants/theme";

export default function KidRewardsScreen() {
  const { activeChild } = useChildStore();
  const childId = activeChild?.child_id;

  const { data: items = [], isLoading: itemsLoading } = useRewardItems(false);
  const { data: redemptions = [] } = useRedemptions();
  const { mutate: redeem, isPending: redeeming } = useRedeemReward();

  const [game, setGame] = useState<GameProfile | null>(null);
  const reloadCoins = async () => {
    if (!childId) return;
    try { setGame(await gamificationApi.profile(childId)); } catch {}
  };
  useEffect(() => { reloadCoins(); }, [childId]);

  const coins = game?.coins ?? 0;
  const myRequests = (redemptions as any[]).filter(r => r.child_id === childId);

  const doRedeem = (rewardId: number, title: string, cost: number) => {
    if (!childId) return;
    if (coins < cost) {
      Alert.alert("Not enough points", `You need ${cost} points but have ${coins}.`);
      return;
    }
    Alert.alert(
      "Redeem this reward?",
      `Spend ${cost} points on "${title}"? Your parent will need to approve it.`,
      [
        { text: "Cancel", style: "cancel" },
        {
          text: "Redeem", onPress: () => redeem(
            { childId, rewardId },
            {
              onSuccess: () => { reloadCoins(); Alert.alert("Requested! 🎉", "Your parent will approve it soon."); },
              onError:   (e: any) => Alert.alert("Couldn't redeem", e.message),
            }
          ),
        },
      ]
    );
  };

  if (!activeChild) {
    return (
      <View style={s.centerRoot}>
        <Text style={s.emptyText}>Pick a profile to see rewards.</Text>
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>🎁 Rewards Store</Text>
        <View style={s.coinBadge}>
          <Text style={s.coinEmoji}>🪙</Text>
          <Text style={s.coinNum}>{coins}</Text>
        </View>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {itemsLoading ? (
          <ActivityIndicator color={colors.brand} size="large" style={{ marginTop: 32 }} />
        ) : items.length === 0 ? (
          <Text style={s.empty}>No rewards yet — ask your parent to add some!</Text>
        ) : (
          (items as any[]).map(item => {
            const affordable = coins >= item.point_cost;
            return (
              <View key={item.reward_id} style={s.card}>
                <View style={{ flex: 1 }}>
                  <Text style={s.cardTitle}>{item.title}</Text>
                  {item.description && <Text style={s.cardDesc}>{item.description}</Text>}
                  <Text style={s.cardCost}>🪙 {item.point_cost} points</Text>
                </View>
                <TouchableOpacity
                  style={[s.redeemBtn, (!affordable || redeeming) && s.redeemBtnDim]}
                  disabled={!affordable || redeeming}
                  onPress={() => doRedeem(item.reward_id, item.title, item.point_cost)}
                >
                  <Text style={s.redeemBtnText}>{affordable ? "Redeem" : "Locked"}</Text>
                </TouchableOpacity>
              </View>
            );
          })
        )}

        {myRequests.length > 0 && (
          <>
            <Text style={s.sectionTitle}>My requests</Text>
            {myRequests.map((r: any) => (
              <View key={r.redemption_id} style={s.historyRow}>
                <Text style={s.historyText}>{r.reward_title} · {r.points_spent} pts</Text>
                <Text style={[s.historyStatus, r.status === "denied" ? s.statusDenied : s.statusOk]}>
                  {r.status}
                </Text>
              </View>
            ))}
          </>
        )}
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.brandLight },
  centerRoot: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },
  emptyText: { color: colors.textMuted, fontSize: 14, textAlign: "center" },

  header: { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
            backgroundColor: colors.brand, paddingTop: Platform.OS === "ios" ? 56 : 32,
            paddingBottom: 20, paddingHorizontal: 20 },
  title: { fontSize: 22, fontWeight: "900", color: "white" },
  coinBadge: { flexDirection: "row", alignItems: "center", gap: 6, backgroundColor: "rgba(255,255,255,0.2)",
               borderRadius: 20, paddingHorizontal: 14, paddingVertical: 8 },
  coinEmoji: { fontSize: 18 },
  coinNum: { fontSize: 18, fontWeight: "900", color: "white" },

  body: { padding: 20, gap: 12 },
  empty: { textAlign: "center", color: colors.textMuted, marginTop: 32, fontSize: 14 },

  card: { flexDirection: "row", alignItems: "center", backgroundColor: "white", borderRadius: 18, padding: 18,
          shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  cardTitle: { fontSize: 16, fontWeight: "800", color: colors.text },
  cardDesc: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  cardCost: { fontSize: 13, fontWeight: "700", color: colors.brand, marginTop: 6 },

  redeemBtn: { backgroundColor: colors.brand, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 10 },
  redeemBtnDim: { backgroundColor: colors.border },
  redeemBtnText: { color: "white", fontWeight: "800", fontSize: 13 },

  sectionTitle: { fontSize: 16, fontWeight: "900", color: colors.text, marginTop: 16, marginBottom: 8 },
  historyRow: { flexDirection: "row", justifyContent: "space-between", backgroundColor: "white",
                borderRadius: 12, padding: 14, marginBottom: 8 },
  historyText: { fontSize: 13, color: colors.text, flex: 1 },
  historyStatus: { fontSize: 12, fontWeight: "800", textTransform: "uppercase" },
  statusOk: { color: "#16a34a" },
  statusDenied: { color: "#dc2626" },
});
