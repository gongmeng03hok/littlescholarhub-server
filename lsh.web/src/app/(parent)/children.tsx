/**
 * Children management — add, edit grade, set kid profile PIN/avatar, delete.
 * Accessible from Settings and Dashboard.
 */
import { useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, Alert, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildren, useAddChild, useUpdateChild, useDeleteChild } from "../../hooks/useChildren";
import { assessmentApi } from "../../api/assessment";
import { readPendingAssessment, clearPendingAssessment, pendingGradeId } from "../../utils/pendingAssessment";
import { childrenApi } from "../../api/children";
import { useMutation, useQueryClient } from "@tanstack/react-query";
import { Input }  from "../../components/ui/Input";
import { Button } from "../../components/ui/Button";
import { Card }   from "../../components/ui/Card";
import { confirmAction } from "../../utils/confirm";
import { colors, GRADES } from "../../constants/theme";

const AVATARS = ["⭐","🐉","🦋","🦁","🐼","🦄","🐬","🦊","🚀","🎨","🌈","🎸"];

export default function ChildrenScreen() {
  const router = useRouter();
  const qc = useQueryClient();
  const { data: children = [], refetch } = useChildren();
  const { mutate: addChild,    isPending: adding   } = useAddChild();
  const { mutate: updateChild, isPending: updating } = useUpdateChild();
  const { mutate: deleteChild, isPending: deleting } = useDeleteChild();

  const [showAdd,  setShowAdd]  = useState(false);
  const [nickname, setNickname] = useState("");
  // Pre-fill from the public assessment when the parent has just signed up,
  // so the grade they already answered is not asked for a second time.
  const [gradeId,  setGradeId]  = useState(() => pendingGradeId() ?? 2);
  const [nameErr,  setNameErr]  = useState("");

  // Edit-child modal state
  const [editChild, setEditChild] = useState<{ childId: number } | null>(null);
  const [editNickname, setEditNickname] = useState("");
  const [editGradeId,  setEditGradeId]  = useState(2);
  const [editNameErr,  setEditNameErr]  = useState("");

  // PIN/avatar modal state
  const [pinModal, setPinModal] = useState<{ childId: number; hasProfile: boolean } | null>(null);
  const [newPin,   setNewPin]   = useState("");
  const [avatar,   setAvatar]   = useState("⭐");
  const [dispName, setDispName] = useState("");

  // Upsert kid profile — create if none exists, patch if it does
  const { mutate: saveProfile, isPending: savingProfile } = useMutation({
    mutationFn: async ({ childId, hasProfile, pin, avatarSlug, displayName }: any) => {
      if (hasProfile) {
        return childrenApi.updateKidProfile(childId, {
          avatar_slug: avatarSlug,
          pin: pin || undefined,
          display_name: displayName,
        });
      } else {
        return childrenApi.createKidProfile(childId, {
          avatar_slug: avatarSlug,
          pin: pin || undefined,
          display_name: displayName,
        });
      }
    },
    onSuccess: () => {
      setPinModal(null);
      setNewPin("");
      qc.invalidateQueries({ queryKey: ["children"] });
    },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const handleAdd = () => {
    if (!nickname.trim()) { setNameErr("Name is required"); return; }
    setNameErr("");
    addChild(
      { nickname: nickname.trim(), grade_id: gradeId },
      {
        onSuccess: (res: any) => {
          // The guest assessment could not be saved before the child existed —
          // re-submit it now so the plan the parent was shown is the plan they get.
          const pending = readPendingAssessment();
          const newId   = res?.child_id;
          if (pending && newId) {
            assessmentApi.submit(newId, pending.answers)
              .catch(() => { /* plan rebuild is best-effort; the child is created either way */ })
              .finally(() => clearPendingAssessment());
          }
          setNickname(""); setGradeId(2); setShowAdd(false); refetch();
        },
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

  const openPinModal = (child: any) => {
    setAvatar(child.avatar_slug ?? "⭐");
    setDispName(child.display_name ?? child.nickname);
    setNewPin("");
    setPinModal({ childId: child.child_id, hasProfile: !!child.display_name });
  };

  const confirmDelete = (id: number, name: string) => {
    Alert.alert(`Remove ${name}?`, "This deletes all their progress permanently.", [
      { text: "Cancel", style: "cancel" },
      {
        text: "Remove", style: "destructive",
        onPress: () => deleteChild(id, {
          onSuccess: () => refetch(),
          onError: (e: any) => Alert.alert("Error", e.message),
        }),
      },
    ]);
  };

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      {/* Header */}
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
          <Text style={s.backBtn}>← </Text>
        </TouchableOpacity>
        <Text style={s.title}>Children ({children.length}/4)</Text>
      </View>

      {/* Child cards */}
      {children.map((ch: any) => (
        <Card key={ch.child_id} style={s.childCard}>
          <View style={s.childRow}>
            <Text style={s.childAvatar}>{ch.avatar_slug ?? "⭐"}</Text>
            <View style={{ flex: 1 }}>
              <Text style={s.childName}>{ch.nickname}</Text>
              <Text style={s.childGrade}>{ch.grade_label}</Text>
              <Text style={s.kidPin}>
                {ch.has_pin ? "🔐 PIN set" : "No PIN"} · Kid profile {ch.display_name ? `(${ch.display_name})` : "not set"}
              </Text>
            </View>
          </View>

          <View style={s.childActions}>
            <TouchableOpacity style={s.actionBtn} onPress={() => openEditModal(ch)}>
              <Text style={s.actionBtnText}>✏️ Edit</Text>
            </TouchableOpacity>
            <TouchableOpacity style={s.actionBtn} onPress={() => openPinModal(ch)}>
              <Text style={s.actionBtnText}>🎮 Kid Profile</Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={[s.actionBtn, s.deleteActionBtn]}
              onPress={() => confirmDelete(ch.child_id, ch.nickname)}
            >
              <Text style={[s.actionBtnText, { color: colors.danger }]}>Remove</Text>
            </TouchableOpacity>
          </View>
        </Card>
      ))}

      {/* Add child form */}
      {children.length < 4 && (
        showAdd ? (
          <Card style={s.addCard}>
            <Text style={s.addTitle}>Add a child</Text>
            <Input label="Nickname" value={nickname} onChangeText={setNickname}
              placeholder="e.g. Aanya" error={nameErr} />

            <Text style={s.gradeLabel}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id} onPress={() => setGradeId(g.grade_id)}
                  style={[s.gradeChip, gradeId === g.grade_id && s.gradeChipActive]}>
                  <Text style={[s.gradeText, gradeId === g.grade_id && s.gradeTextActive]}>{g.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <View style={s.addBtns}>
              <Button label="Add child" onPress={handleAdd} loading={adding} style={{ flex: 1 }} />
              <Button label="Cancel" onPress={() => setShowAdd(false)} variant="outline" style={{ flex: 1 }} />
            </View>
          </Card>
        ) : (
          <TouchableOpacity style={s.addBtn} onPress={() => setShowAdd(true)}>
            <Text style={s.addBtnText}>➕  Add a child</Text>
          </TouchableOpacity>
        )
      )}

      {/* Edit child modal overlay */}
      {editChild && (
        <View style={s.overlay}>
          <View style={s.modal}>
            <Text style={s.modalTitle}>Edit child</Text>

            <Input label="Nickname" value={editNickname} onChangeText={setEditNickname}
              placeholder="e.g. Aanya" error={editNameErr} />

            <Text style={s.gradeLabel}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id} onPress={() => setEditGradeId(g.grade_id)}
                  style={[s.gradeChip, editGradeId === g.grade_id && s.gradeChipActive]}>
                  <Text style={[s.gradeText, editGradeId === g.grade_id && s.gradeTextActive]}>{g.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <View style={s.addBtns}>
              <Button
                label={updating ? "Saving…" : "Save"}
                onPress={saveEdit}
                loading={updating}
                style={{ flex: 1 }}
              />
              <Button
                label="Cancel"
                onPress={() => setEditChild(null)}
                variant="outline"
                style={{ flex: 1 }}
              />
            </View>
          </View>
        </View>
      )}

      {/* Kid profile modal overlay */}
      {pinModal && (
        <View style={s.overlay}>
          <View style={s.modal}>
            <Text style={s.modalTitle}>Kid Profile 🎮</Text>

            <Input
              label="Display name (shown in kid mode)"
              value={dispName}
              onChangeText={setDispName}
              placeholder="Nickname for kid mode"
            />

            <Text style={s.modalLabel}>Avatar</Text>
            <View style={s.avatarGrid}>
              {AVATARS.map(a => (
                <TouchableOpacity key={a} onPress={() => setAvatar(a)}
                  style={[s.avatarBtn, avatar === a && s.avatarBtnActive]}>
                  <Text style={{ fontSize: 26 }}>{a}</Text>
                </TouchableOpacity>
              ))}
            </View>

            <Input
              label="4-digit PIN (optional — leave blank to remove)"
              value={newPin}
              onChangeText={setNewPin}
              keyboardType="number-pad"
              maxLength={4}
              secureTextEntry
              placeholder="e.g. 1234"
            />

            <View style={s.addBtns}>
              <Button
                label={savingProfile ? "Saving…" : "Save"}
                onPress={() => saveProfile({
                  childId:     pinModal.childId,
                  hasProfile:  pinModal.hasProfile,
                  pin:         newPin,
                  avatarSlug:  avatar,
                  displayName: dispName,
                })}
                loading={savingProfile}
                style={{ flex: 1 }}
              />
              <Button
                label="Cancel"
                onPress={() => { setPinModal(null); setNewPin(""); }}
                variant="outline"
                style={{ flex: 1 }}
              />
            </View>
          </View>
        </View>
      )}

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  content: { paddingBottom: 40 },

  header:  { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
             paddingBottom: 16, paddingHorizontal: 20,
             flexDirection: "row", alignItems: "center", gap: 8,
             borderBottomWidth: 1, borderBottomColor: colors.border, marginBottom: 16 },
  backBtn: { fontSize: 22, color: colors.brand, fontWeight: "700" },
  title:   { fontSize: 20, fontWeight: "900", color: colors.text },

  childCard:    { marginHorizontal: 16, marginBottom: 12 },
  childRow:     { flexDirection: "row", alignItems: "flex-start", gap: 14 },
  childAvatar:  { fontSize: 36, width: 48 },
  childName:    { fontSize: 17, fontWeight: "800", color: colors.text },
  childGrade:   { fontSize: 13, color: colors.textMuted, marginTop: 2 },
  kidPin:       { fontSize: 12, color: colors.brand, marginTop: 4 },
  childActions: { flexDirection: "row", gap: 10, marginTop: 14 },
  actionBtn:    { flex: 1, borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                  paddingVertical: 8, alignItems: "center" },
  deleteActionBtn: { borderColor: "#ffd5d5" },
  actionBtnText:{ fontSize: 13, fontWeight: "700", color: colors.text },

  addCard:  { marginHorizontal: 16, marginBottom: 12 },
  addTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 14 },
  gradeLabel:   { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  gradeChip:    { borderWidth: 2, borderColor: colors.border, borderRadius: 10,
                  paddingHorizontal: 12, paddingVertical: 6, marginRight: 6 },
  gradeChipActive:{ borderColor: colors.brand, backgroundColor: colors.brandLight },
  gradeText:    { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  gradeTextActive:{ color: colors.brand },
  addBtns:  { flexDirection: "row", gap: 10 },

  addBtn:     { marginHorizontal: 16, backgroundColor: colors.brandLight, borderRadius: 14,
                padding: 18, alignItems: "center" },
  addBtnText: { color: colors.brand, fontWeight: "800", fontSize: 15 },

  overlay: { ...StyleSheet.absoluteFillObject, backgroundColor: "rgba(0,0,0,0.55)",
             justifyContent: "center", padding: 24, zIndex: 100 },
  modal:       { backgroundColor: "white", borderRadius: 20, padding: 24, maxHeight: "90%" },
  modalTitle:  { fontSize: 20, fontWeight: "900", color: colors.text, marginBottom: 16, textAlign: "center" },
  modalLabel:  { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 10 },
  avatarGrid:  { flexDirection: "row", flexWrap: "wrap", gap: 8, marginBottom: 16 },
  avatarBtn:   { width: 48, height: 48, borderRadius: 12, borderWidth: 2, borderColor: colors.border,
                 justifyContent: "center", alignItems: "center" },
  avatarBtnActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
});
