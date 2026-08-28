/**
 * Kid customize — pick an avatar buddy + a treasure-chest style.
 * Shown at sign-up and reachable from the dashboard. License-safe avatars only.
 */
import { useState, useEffect } from "react";
import {
  ScrollView, View, Text, TouchableOpacity, StyleSheet, Platform, Alert, Image,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { gamificationApi } from "../../api/gamification";
import {
  AVATAR_CHOICES, CHESTS, avatarEmoji, avatarImage, chestImage,
} from "../../constants/avatars";
import { colors } from "../../constants/theme";

export default function Customize() {
  const router = useRouter();
  const { activeChild } = useChildStore();
  const childId = activeChild?.child_id;

  const [avatar, setAvatar] = useState("star");
  const [chest, setChest]   = useState("classic");
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!childId) return;
    gamificationApi.profile(childId)
      .then(p => { if (p?.avatar_slug) setAvatar(p.avatar_slug); if (p?.chest_style) setChest(p.chest_style); })
      .catch(() => {});
  }, [childId]);

  const save = () => {
    if (!childId) return;
    setSaving(true);
    gamificationApi.setAvatar(childId, avatar, chest)
      .then(() => router.back())
      .catch((e: any) => { if (Platform.OS === "web") window.alert(e.message); else Alert.alert("Error", e.message); })
      .finally(() => setSaving(false));
  };

  return (
    <ScrollView style={s.root} contentContainerStyle={{ paddingBottom: 48 }} showsVerticalScrollIndicator={false}>
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()}><Text style={s.back}>←</Text></TouchableOpacity>
        <Text style={s.title}>Make it yours ✨</Text>
        <View style={{ width: 28 }} />
      </View>

      {avatarImage(avatar)
        ? <Image source={avatarImage(avatar)} style={s.previewImg} resizeMode="contain" />
        : <Text style={s.preview}>{avatarEmoji(avatar)}</Text>}

      <Text style={s.section}>Pick your buddy</Text>
      {AVATAR_CHOICES.map(tier => (
        <View key={tier.tier} style={{ marginBottom: 12 }}>
          <Text style={s.tier}>{tier.tier} · ages {tier.ages}</Text>
          <View style={s.grid}>
            {tier.slugs.map(slug => (
              <TouchableOpacity key={slug + tier.tier} onPress={() => setAvatar(slug)}
                style={[s.item, avatar === slug && s.sel]} accessibilityRole="button">
                {avatarImage(slug)
                  ? <Image source={avatarImage(slug)} style={s.itemImg} resizeMode="contain" />
                  : <Text style={s.itemEmoji}>{avatarEmoji(slug)}</Text>}
              </TouchableOpacity>
            ))}
          </View>
        </View>
      ))}

      <Text style={s.section}>Pick your treasure chest</Text>
      <View style={s.grid}>
        {CHESTS.map(c => (
          <TouchableOpacity key={c.id} onPress={() => setChest(c.id)}
            style={[s.chestItem, chest === c.id && s.sel]} accessibilityRole="button">
            {chestImage(c.id)
              ? <Image source={chestImage(c.id)} style={s.chestImg} resizeMode="contain" />
              : <Text style={s.itemEmoji}>{c.emoji}</Text>}
            <Text style={s.chestLabel}>{c.label}</Text>
          </TouchableOpacity>
        ))}
      </View>

      <TouchableOpacity style={[s.saveBtn, saving && { opacity: 0.6 }]} onPress={save} disabled={saving}>
        <Text style={s.saveText}>{saving ? "Saving…" : "Save ✓"}</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: colors.brandLight },
  header:  { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
             paddingTop: Platform.OS === "ios" ? 60 : 32, paddingBottom: 12, paddingHorizontal: 20,
             backgroundColor: colors.brand },
  back:    { fontSize: 28, color: "white", fontWeight: "900" },
  title:   { fontSize: 22, fontWeight: "900", color: "white" },
  preview: { fontSize: 90, textAlign: "center", marginVertical: 16 },
  previewImg: { width: 140, height: 140, alignSelf: "center", marginVertical: 16 },
  itemImg: { width: 54, height: 54 },
  chestImg: { width: 60, height: 60 },
  section: { fontSize: 18, fontWeight: "900", color: colors.text, marginHorizontal: 20, marginTop: 12, marginBottom: 10 },
  tier:    { fontSize: 12, fontWeight: "800", color: colors.textMuted, textTransform: "uppercase",
             letterSpacing: 0.5, marginHorizontal: 20, marginBottom: 8 },
  grid:    { flexDirection: "row", flexWrap: "wrap", gap: 12, paddingHorizontal: 20 },
  item:    { width: 66, height: 66, borderRadius: 18, borderWidth: 2, borderColor: colors.border,
             backgroundColor: "white", alignItems: "center", justifyContent: "center" },
  chestItem:{ width: 84, borderRadius: 18, borderWidth: 2, borderColor: colors.border, backgroundColor: "white",
             alignItems: "center", justifyContent: "center", paddingVertical: 12 },
  sel:     { borderColor: colors.brand, backgroundColor: colors.brandLight },
  itemEmoji:{ fontSize: 34 },
  chestLabel:{ fontSize: 11, fontWeight: "800", color: colors.text, marginTop: 4 },
  saveBtn: { backgroundColor: colors.brand, borderRadius: 16, paddingVertical: 16, alignItems: "center",
             marginHorizontal: 20, marginTop: 24 },
  saveText:{ color: "white", fontWeight: "900", fontSize: 17 },
});
