import { useState } from "react";
import {
  View, Text, TextInput, TouchableOpacity, ScrollView,
  StyleSheet, ActivityIndicator, Alert, Platform, Modal, Switch,
} from "react-native";
import { colors } from "../../constants/theme";
import { confirmAction } from "../../utils/confirm";
import { useChildren } from "../../hooks/useChildren";
import {
  useRewardItems, useCreateRewardItem, useUpdateRewardItem, useDeleteRewardItem,
  useRedemptions, useResolveRedemption,
} from "../../hooks/useRewards";

export default function RewardsScreen() {
  const { data: items = [], isLoading: itemsLoading } = useRewardItems(true);
  const { data: redemptions = [], isLoading: redemptionsLoading } = useRedemptions();
  const { data: children = [] } = useChildren();
  const { mutate: createItem, isPending: creating } = useCreateRewardItem();
  const { mutate: updateItem } = useUpdateRewardItem();
  const { mutate: deleteItem } = useDeleteRewardItem();
  const { mutate: resolveRedemption } = useResolveRedemption();

  const [formOpen, setFormOpen] = useState(false);
  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [imageUrl, setImageUrl] = useState("");
  const [productUrl, setProductUrl] = useState("");
  const [pointCost, setPointCost] = useState("");
  const [forChildId, setForChildId] = useState<number | null>(null);

  const pending  = (redemptions as any[]).filter(r => r.status === "pending");
  const history  = (redemptions as any[]).filter(r => r.status !== "pending");

  const openForm = () => {
    setTitle(""); setDescription(""); setImageUrl(""); setProductUrl(""); setPointCost("");
    setForChildId(null);
    setFormOpen(true);
  };

  const submitForm = () => {
    const cost = parseInt(pointCost, 10);
    if (!title.trim() || !cost || cost <= 0) {
      Alert.alert("Please enter a title and a positive point cost");
      return;
    }
    createItem(
      {
        title: title.trim(),
        description: description.trim() || undefined,
        image_url: imageUrl.trim() || undefined,
        product_url: productUrl.trim() || undefined,
        point_cost: cost,
        child_id: forChildId,
      },
      {
        onSuccess: () => setFormOpen(false),
        onError:   (e: any) => Alert.alert("Couldn't add reward", e.message),
      }
    );
  };

  const toggleActive = (rewardId: number, isActive: boolean) => {
    updateItem({ rewardId, body: { is_active: !isActive } });
  };

  const removeItem = (rewardId: number, title: string) => {
    confirmAction(
      "Remove reward",
      `Remove "${title}" from the reward store? This won't affect past redemptions.`,
      () => deleteItem(rewardId),
      "Remove",
      true
    );
  };

  const resolve = (redemptionId: number, status: "approved" | "denied" | "fulfilled") => {
    resolveRedemption(
      { redemptionId, status },
      { onError: (e: any) => Alert.alert("Couldn't update", e.message) }
    );
  };

  return (
    <View style={s.root}>
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>🎁 Rewards</Text>
          <Text style={s.count}>Curate items your kids can redeem points for</Text>
        </View>
        <TouchableOpacity style={s.addBtn} onPress={openForm}>
          <Text style={s.addBtnText}>+ Add reward</Text>
        </TouchableOpacity>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {/* Pending requests */}
        <Text style={s.sectionTitle}>Pending requests {pending.length > 0 ? `(${pending.length})` : ""}</Text>
        {redemptionsLoading ? (
          <ActivityIndicator color={colors.brand} />
        ) : pending.length === 0 ? (
          <Text style={s.empty}>No pending redemption requests.</Text>
        ) : (
          pending.map((r: any) => (
            <View key={r.redemption_id} style={s.card}>
              <View style={{ flex: 1 }}>
                <Text style={s.cardTitle}>{r.child_nickname} wants: {r.reward_title}</Text>
                <Text style={s.cardMeta}>{r.points_spent} points · requested {new Date(r.requested_at).toLocaleDateString()}</Text>
                {r.product_url && <Text style={s.link}>{r.product_url}</Text>}
              </View>
              <View style={{ gap: 8, alignItems: "flex-end" }}>
                <TouchableOpacity onPress={() => resolve(r.redemption_id, "approved")}>
                  <Text style={s.approveAction}>Approve</Text>
                </TouchableOpacity>
                <TouchableOpacity onPress={() => resolve(r.redemption_id, "denied")}>
                  <Text style={s.denyAction}>Deny (refund)</Text>
                </TouchableOpacity>
              </View>
            </View>
          ))
        )}

        {/* Reward store */}
        <Text style={s.sectionTitle}>Reward store</Text>
        {itemsLoading ? (
          <ActivityIndicator color={colors.brand} />
        ) : items.length === 0 ? (
          <Text style={s.empty}>No rewards yet. Add one — e.g. paste a link to something on Amazon.</Text>
        ) : (
          (items as any[]).map(item => (
            <View key={item.reward_id} style={[s.card, !item.is_active && s.cardInactive]}>
              <View style={{ flex: 1 }}>
                <Text style={s.cardTitle}>{item.title}{!item.is_active ? " (paused)" : ""}</Text>
                <Text style={s.cardMeta}>{item.point_cost} points</Text>
                <Text style={s.forBadge}>
                  {item.child_id ? `For: ${item.child_nickname}` : "For: All kids"}
                </Text>
                {item.product_url && <Text style={s.link} numberOfLines={1}>{item.product_url}</Text>}
              </View>
              <View style={{ gap: 8, alignItems: "flex-end" }}>
                <View style={{ flexDirection: "row", alignItems: "center", gap: 6 }}>
                  <Text style={s.switchLabel}>Active</Text>
                  <Switch value={item.is_active} onValueChange={() => toggleActive(item.reward_id, item.is_active)} />
                </View>
                <TouchableOpacity onPress={() => removeItem(item.reward_id, item.title)}>
                  <Text style={s.denyAction}>Remove</Text>
                </TouchableOpacity>
              </View>
            </View>
          ))
        )}

        {/* History */}
        {history.length > 0 && (
          <>
            <Text style={s.sectionTitle}>History</Text>
            {history.map((r: any) => (
              <View key={r.redemption_id} style={s.historyRow}>
                <Text style={s.historyText}>
                  {r.child_nickname} · {r.reward_title} · {r.points_spent} pts
                </Text>
                <Text style={[
                  s.historyStatus,
                  r.status === "denied" ? s.statusDenied : s.statusOk,
                ]}>{r.status}</Text>
              </View>
            ))}
          </>
        )}
      </ScrollView>

      {/* Add reward modal */}
      <Modal visible={formOpen} animationType="slide" transparent onRequestClose={() => setFormOpen(false)}>
        <View style={s.modalBackdrop}>
          <View style={s.modalSheet}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Add a reward</Text>
              <TouchableOpacity onPress={() => setFormOpen(false)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>
            <ScrollView>
              <TextInput style={s.input} placeholder="Title (e.g. LEGO Set)" value={title} onChangeText={setTitle} />
              <TextInput style={s.input} placeholder="Description (optional)" value={description} onChangeText={setDescription} />
              <TextInput style={s.input} placeholder="Image URL (optional)" value={imageUrl} onChangeText={setImageUrl} autoCapitalize="none" />
              <TextInput style={s.input} placeholder="Amazon / product link (optional)" value={productUrl} onChangeText={setProductUrl} autoCapitalize="none" />
              <TextInput style={s.input} placeholder="Point cost (e.g. 100)" value={pointCost} onChangeText={setPointCost} keyboardType="number-pad" />

              <Text style={s.label}>Who is this for?</Text>
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={s.chipRow}>
                <TouchableOpacity
                  onPress={() => setForChildId(null)}
                  style={[s.chip, forChildId === null && s.chipActive]}
                >
                  <Text style={[s.chipText, forChildId === null && s.chipTextActive]}>All kids</Text>
                </TouchableOpacity>
                {(children as any[]).map(c => (
                  <TouchableOpacity
                    key={c.child_id}
                    onPress={() => setForChildId(c.child_id)}
                    style={[s.chip, forChildId === c.child_id && s.chipActive]}
                  >
                    <Text style={[s.chipText, forChildId === c.child_id && s.chipTextActive]}>{c.nickname}</Text>
                  </TouchableOpacity>
                ))}
              </ScrollView>

              <TouchableOpacity style={[s.submitBtn, creating && s.btnDim]} disabled={creating} onPress={submitForm}>
                <Text style={s.submitBtnText}>{creating ? "Adding…" : "Add reward"}</Text>
              </TouchableOpacity>
            </ScrollView>
          </View>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: "#f8f7ff" },
  header: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
            paddingTop: Platform.OS === "ios" ? 56 : 20, paddingBottom: 14, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title: { fontSize: 20, fontWeight: "900", color: colors.text },
  count: { fontSize: 13, color: colors.textMuted, fontWeight: "600", marginTop: 2 },
  addBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 10 },
  addBtnText: { color: "white", fontWeight: "800", fontSize: 13 },

  body: { padding: 16, gap: 10 },
  sectionTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginTop: 14, marginBottom: 8 },
  empty: { color: colors.textMuted, fontSize: 13, marginBottom: 8 },

  card: { flexDirection: "row", backgroundColor: "white", borderRadius: 14, padding: 16,
          shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  cardInactive: { opacity: 0.6 },
  cardTitle: { fontSize: 14, fontWeight: "800", color: colors.text },
  cardMeta: { fontSize: 12, color: colors.textMuted, marginTop: 4 },
  forBadge: { fontSize: 11, color: colors.brand, fontWeight: "700", marginTop: 4 },
  link: { fontSize: 11, color: colors.brand, marginTop: 4 },

  approveAction: { fontSize: 12, fontWeight: "700", color: "#16a34a" },
  denyAction: { fontSize: 12, fontWeight: "700", color: "#dc2626" },
  switchLabel: { fontSize: 11, color: colors.textMuted, fontWeight: "600" },

  historyRow: { flexDirection: "row", justifyContent: "space-between", alignItems: "center",
                paddingVertical: 8, borderBottomWidth: 1, borderBottomColor: colors.border },
  historyText: { fontSize: 12, color: colors.text, flex: 1 },
  historyStatus: { fontSize: 11, fontWeight: "800", textTransform: "uppercase" },
  statusOk: { color: "#16a34a" },
  statusDenied: { color: "#dc2626" },

  modalBackdrop: { flex: 1, backgroundColor: "rgba(0,0,0,0.4)", justifyContent: "flex-end" },
  modalSheet: { backgroundColor: "white", borderTopLeftRadius: 20, borderTopRightRadius: 20,
                padding: 20, maxHeight: "85%" },
  modalHeader: { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 14 },
  modalTitle: { fontSize: 18, fontWeight: "900", color: colors.text },
  modalClose: { fontSize: 20, color: colors.textMuted, padding: 4 },
  input: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 14,
           paddingVertical: 12, fontSize: 14, color: colors.text, marginBottom: 10 },
  submitBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingVertical: 14, alignItems: "center", marginTop: 4 },
  btnDim: { opacity: 0.6 },
  submitBtnText: { color: "white", fontWeight: "800", fontSize: 15 },

  label: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginBottom: 6 },
  chipRow: { marginBottom: 14 },
  chip: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 20,
          paddingHorizontal: 14, paddingVertical: 8, marginRight: 8, backgroundColor: "white" },
  chipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText: { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  chipTextActive: { color: colors.brand },
});
