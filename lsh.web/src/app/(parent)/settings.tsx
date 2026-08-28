/**
 * Family settings — manage children, language, account, logout.
 */
import { useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, Alert, Switch, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useQuery, useMutation } from "@tanstack/react-query";
import { useAuthStore }   from "../../store/authStore";
import { useChildStore }  from "../../store/childStore";
import { useChildren, useAddChild, useUpdateChild, useDeleteChild } from "../../hooks/useChildren";
import { authApi } from "../../api/auth";
import { confirmAction } from "../../utils/confirm";
import { Input }          from "../../components/ui/Input";
import { Button }         from "../../components/ui/Button";
import { Card }           from "../../components/ui/Card";
import { gamificationApi } from "../../api/gamification";
import { colors, GRADES } from "../../constants/theme";

const LANGS = [
  { id: 1, label: "English 🇺🇸" },
  { id: 2, label: "中文 🏮" },
  { id: 3, label: "हिन्दी 🪔" },
  { id: 4, label: "Español 🌻" },
];

export default function SettingsScreen() {
  const router = useRouter();
  const { family, logout, setFamily } = useAuthStore();
  const { children }       = useChildStore();
  const { refetch }        = useChildren();
  const { mutate: addChild,    isPending: adding   } = useAddChild();
  const { mutate: updateChild, isPending: updating } = useUpdateChild();
  const { mutate: deleteChild, isPending: deleting } = useDeleteChild();

  const [showAdd,   setShowAdd]   = useState(false);
  const [nickname,  setNickname]  = useState("");
  const [gradeId,   setGradeId]   = useState(2);
  const [nameError, setNameError] = useState("");

  // Edit-child modal state
  const [editChild, setEditChild] = useState<{ childId: number } | null>(null);
  const [editNickname, setEditNickname] = useState("");
  const [editGradeId,  setEditGradeId]  = useState(2);
  const [editNameErr,  setEditNameErr]  = useState("");

   // Leaderboard opt-in (COPPA-safe: nickname + avatar + coarse region only)
  const [leaderOptIn,  setLeaderOptIn]  = useState(false);
  const [region,       setRegion]       = useState("");
  const [savingLeader, setSavingLeader] = useState(false);
  const saveLeader = () => {
    setSavingLeader(true);
    gamificationApi.settings({ show_on_leaderboard: leaderOptIn, region: region.trim() || undefined })
      .then(() => { if (Platform.OS === "web") window.alert("Saved!"); else Alert.alert("Saved"); })
      .catch((e: any) => Alert.alert("Error", e.message))
      .finally(() => setSavingLeader(false));
  };
  const { data: referrals } = useQuery({
    queryKey: ["referrals"],
    queryFn:  () => authApi.getReferrals(),
    staleTime: 60_000,
  });

  const { mutate: updateLanguage, isPending: savingLanguage } = useMutation({
    mutationFn: (language_id: number) => authApi.updateMe({ language_id }),
    onSuccess: (_, language_id) => {
      if (family) setFamily({ ...family, language_id });
    },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const handleAdd = () => {
    if (!nickname.trim()) { setNameError("Name is required"); return; }
    setNameError("");
    addChild(
      { nickname: nickname.trim(), grade_id: gradeId },
      {
        onSuccess: () => { setNickname(""); setShowAdd(false); refetch(); },
        onError: (e: any) => Alert.alert("Error", e.message),
      }
    );
  };

  const openEditModal = (child: any) => {
    setEditNickname(child.nickname);
    setEditGradeId(child.grade_id);
    setEditNameErr("");
    setEditChild({ childId: child.child_id });
  };

  const saveEdit = () => {
    if (!editChild) return;
    if (!editNickname.trim()) { setEditNameErr("Name is required"); return; }
    setEditNameErr("");
    updateChild(
      { id: editChild.childId, body: { nickname: editNickname.trim(), grade_id: editGradeId } },
      {
        onSuccess: () => { setEditChild(null); refetch(); },
        onError: (e: any) => Alert.alert("Error", e.message),
      }
    );
  };

  const confirmDelete = (id: number, name: string) => {
    Alert.alert(`Remove ${name}?`, "This will delete all their progress data.", [
      { text: "Cancel", style: "cancel" },
      { text: "Remove", style: "destructive", onPress: () => deleteChild(id, { onSuccess: () => refetch() }) },
    ]);
  };

  const handleLogout = async () => {
    // Alert.alert is a no-op on web — use window.confirm instead
    if (Platform.OS === "web") {
      if (!window.confirm("Sign out? You'll need to sign back in.")) return;
      await logout();
      router.replace("/(auth)/login");
    } else {
      Alert.alert("Sign out?", "You'll need to sign back in.", [
        { text: "Cancel", style: "cancel" },
        { text: "Sign out", style: "destructive", onPress: async () => { await logout(); router.replace("/(auth)/login"); } },
      ]);
    }
  };

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      <View style={s.header}>
        <Text style={s.title}>Family 👨‍👩‍👧</Text>
        <Text style={s.email}>{family?.email ?? "—"}</Text>
        <Text style={s.plan}>Plan: {family?.plann ?? "explorer"}</Text>
      </View>

      {/* Children */}
      <Text style={s.sectionLabel}>Children</Text>
      {children.map(ch => (
        <Card key={ch.child_id} style={s.childCard}>
          <View style={s.childRow}>
            <View>
              <Text style={s.childName}>{ch.nickname}</Text>
              <Text style={s.childGrade}>{ch.grade_label} · Grade {ch.grade_id}</Text>
            </View>
            <View style={{ flexDirection: "row" }}>
              <TouchableOpacity onPress={() => openEditModal(ch)} style={s.deleteBtn}>
                <Text style={s.editText}>Edit</Text>
              </TouchableOpacity>
              <TouchableOpacity onPress={() => confirmDelete(ch.child_id, ch.nickname)} style={s.deleteBtn}>
                <Text style={s.deleteText}>Remove</Text>
              </TouchableOpacity>
            </View>
          </View>
        </Card>
      ))}

      {editChild && (
        <View style={s.overlay}>
          <Card style={s.addForm}>
            <Text style={s.addTitle}>Edit child</Text>
            <Input
              label="Nickname"
              value={editNickname}
              onChangeText={setEditNickname}
              placeholder="e.g. Aanya"
              error={editNameErr}
            />
            <Text style={s.gradeLabel}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id}
                  onPress={() => setEditGradeId(g.grade_id)}
                  style={[s.gradeChip, editGradeId === g.grade_id && s.gradeChipActive]}>
                  <Text style={[s.gradeChipText, editGradeId === g.grade_id && s.gradeChipTextActive]}>
                    {g.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
            <View style={s.addBtnRow}>
              <Button label={updating ? "Saving…" : "Save"} onPress={saveEdit} loading={updating} style={{ flex: 1 }} />
              <Button label="Cancel" onPress={() => setEditChild(null)} variant="outline" style={{ flex: 1 }} />
            </View>
          </Card>
        </View>
      )}

      {children.length < 4 && (
        showAdd ? (
          <Card style={s.addForm}>
            <Text style={s.addTitle}>Add a child</Text>
            <Input
              label="Nickname"
              value={nickname}
              onChangeText={setNickname}
              placeholder="e.g. Aanya"
              error={nameError}
            />
            <Text style={s.gradeLabel}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id}
                  onPress={() => setGradeId(g.grade_id)}
                  style={[s.gradeChip, gradeId === g.grade_id && s.gradeChipActive]}>
                  <Text style={[s.gradeChipText, gradeId === g.grade_id && s.gradeChipTextActive]}>
                    {g.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
            <View style={s.addBtnRow}>
              <Button label="Add child" onPress={handleAdd} loading={adding} style={{ flex: 1 }} />
              <Button label="Cancel" onPress={() => setShowAdd(false)} variant="outline" style={{ flex: 1 }} />
            </View>
          </Card>
        ) : (
          <TouchableOpacity style={s.addChildBtn} onPress={() => setShowAdd(true)}>
            <Text style={s.addChildBtnText}>➕ Add a child ({children.length}/4)</Text>
          </TouchableOpacity>
        )
      )}

      {/* Kid mode CTA */}
      <TouchableOpacity style={s.kidModeBtn} onPress={() => router.push("/(auth)/kid-select")}>
        <Text style={s.kidModeText}>🎮 Switch to Kid Mode</Text>
        <Text style={s.kidModeSub}>Your child gets a simplified, fun view</Text>
      </TouchableOpacity>

      {/* Language preference */}
      <Text style={s.sectionLabel}>Home language</Text>
      <Card style={{ marginHorizontal: 20, marginBottom: 4 }}>
        <View style={s.langRow}>
          {LANGS.map(l => (
            <TouchableOpacity key={l.id}
              disabled={savingLanguage}
              onPress={() => updateLanguage(l.id)}
              style={[s.langBtn, family?.language_id === l.id && s.langBtnActive]}>
              <Text style={[s.langText, family?.language_id === l.id && s.langTextActive]}>
                {l.label}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </Card>

      {/* Referral */}
      <Text style={s.sectionLabel}>Referral code</Text>
      <Card style={{ marginHorizontal: 20, marginBottom: 4 }}>
        <Text style={s.refCode}>{family?.referral_code ?? "—"}</Text>
        <Text style={s.refDesc}>Share this code — your friend gets their first month free, you get your next month free.</Text>
        {!!referrals?.count && (
          <Text style={s.refCount}>🎉 {referrals.count} friend{referrals.count === 1 ? "" : "s"} joined with your code</Text>
        )}
      </Card>
      {/* Leaderboard opt-in */}
      <Text style={s.sectionLabel}>Leaderboard</Text>
      <Card style={{ marginHorizontal: 20 }}>
        <View style={s.leaderRow}>
          <View style={{ flex: 1, paddingRight: 12 }}>
            <Text style={s.leaderTitle}>Show my kids on the leaderboard</Text>
            <Text style={s.leaderHint}>
              Off by default. Only a nickname, avatar, and a broad region (e.g. state/country)
              are ever shown — never real names, emails, or exact location.
            </Text>
          </View>
          <Switch value={leaderOptIn} onValueChange={setLeaderOptIn}
            trackColor={{ true: colors.brand }} />
        </View>
        {leaderOptIn && (
          <View style={{ marginTop: 12 }}>
            <Input label="Region (broad)" value={region} onChangeText={setRegion}
              placeholder="e.g. California, USA" />
          </View>
        )}
        <Button label="Save" onPress={saveLeader} loading={savingLeader} style={{ marginTop: 12 }} />
      </Card>

      {/* Community & office hours */}
      <Text style={s.sectionLabel}>Community</Text>
      <TouchableOpacity style={s.communityBtn} onPress={() => router.push("/(parent)/community")}>
        <Text style={s.communityBtnText}>💬 Office hours & parent groups</Text>
        <Text style={s.communityBtnSub}>Live teacher Q&A + language-specific parent groups</Text>
      </TouchableOpacity>

      {/* Sign out */}
      <View style={{ paddingHorizontal: 20, marginTop: 24 }}>
        <Button label="Sign out" onPress={handleLogout} variant="outline" fullWidth />
      </View>

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  content: { paddingBottom: 40 },

  header:  { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
             paddingBottom: 20, paddingHorizontal: 20,
             borderBottomWidth: 1, borderBottomColor: colors.border, marginBottom: 20 },
  title:   { fontSize: 22, fontWeight: "900", color: colors.text },
  email:   { fontSize: 14, color: colors.textMuted, marginTop: 4 },
  plan:    { fontSize: 13, color: colors.brand, fontWeight: "700", marginTop: 4 },

  sectionLabel: { fontSize: 13, fontWeight: "700", color: colors.textMuted, letterSpacing: 0.5,
                  paddingHorizontal: 20, marginTop: 20, marginBottom: 10, textTransform: "uppercase" },

  childCard: { marginHorizontal: 20, marginBottom: 10 },
  childRow:  { flexDirection: "row", justifyContent: "space-between", alignItems: "center" },
  childName: { fontSize: 16, fontWeight: "800", color: colors.text },
  childGrade:{ fontSize: 13, color: colors.textMuted, marginTop: 2 },
  deleteBtn: { padding: 8 },
  deleteText:{ fontSize: 13, color: colors.danger, fontWeight: "700" },
  editText:  { fontSize: 13, color: colors.brand, fontWeight: "700" },

  overlay: { ...StyleSheet.absoluteFillObject, backgroundColor: "rgba(0,0,0,0.55)",
             justifyContent: "center", padding: 24, zIndex: 100 },
  addForm:    { marginHorizontal: 20, marginBottom: 10 },
  addTitle:   { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 14 },
  gradeLabel: { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  gradeChip:       { borderWidth: 2, borderColor: colors.border, borderRadius: 10,
                     paddingHorizontal: 12, paddingVertical: 6, marginRight: 6 },
  gradeChipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  gradeChipText:   { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  gradeChipTextActive: { color: colors.brand },
  addBtnRow:  { flexDirection: "row", gap: 10 },

  addChildBtn:    { marginHorizontal: 20, marginTop: 4, backgroundColor: colors.brandLight,
                    borderRadius: 14, padding: 16, alignItems: "center" },
  addChildBtnText:{ color: colors.brand, fontWeight: "700", fontSize: 15 },

  kidModeBtn:  { marginHorizontal: 20, marginTop: 16, backgroundColor: "white", borderRadius: 14,
                 padding: 16, borderWidth: 2, borderColor: colors.brandLight },
  kidModeText: { fontSize: 15, fontWeight: "800", color: colors.brand },
  kidModeSub:  { fontSize: 13, color: colors.textMuted, marginTop: 4 },

  langRow:       { flexDirection: "row", flexWrap: "wrap", gap: 8 },
  langBtn:       { borderWidth: 2, borderColor: colors.border, borderRadius: 10,
                   paddingHorizontal: 12, paddingVertical: 8 },
  langBtnActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  langText:      { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  langTextActive:{ color: colors.brand },

  refCode: { fontSize: 18, fontWeight: "900", color: colors.brand, letterSpacing: 2, marginBottom: 8 },
  refDesc: { fontSize: 13, color: colors.textMuted, lineHeight: 20 },
  refCount:{ fontSize: 13, color: colors.brand, fontWeight: "700", marginTop: 10 },

  communityBtn:    { marginHorizontal: 20, backgroundColor: "white", borderRadius: 14,
                     padding: 16, borderWidth: 2, borderColor: colors.brandLight },
  communityBtnText:{ fontSize: 15, fontWeight: "800", color: colors.brand },
  communityBtnSub: { fontSize: 13, color: colors.textMuted, marginTop: 4 },
  leaderRow:   { flexDirection: "row", alignItems: "center" },
  leaderTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  leaderHint:  { fontSize: 12, color: colors.textMuted, lineHeight: 18, marginTop: 4 },
});
