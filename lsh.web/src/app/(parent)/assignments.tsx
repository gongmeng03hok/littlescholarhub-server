import { useState } from "react";
import {
  View, Text, TextInput, TouchableOpacity, ScrollView,
  StyleSheet, ActivityIndicator, Alert, Platform, Linking, Modal, FlatList,
} from "react-native";
import { useRouter } from "expo-router";
import { useQuery } from "@tanstack/react-query";
import * as ImagePicker from "expo-image-picker";
import { useChildStore } from "../../store/childStore";
import {
  useAssignments, useJoinClassroom, useCompleteAssignment,
  useAssignWorksheet, useDeleteAssignment, useUploadWorksheet,
} from "../../hooks/useApi";
import { contentApi } from "../../api/content";
import { colors, SUBJECT_META } from "../../constants/theme";
import { confirmAction } from "../../utils/confirm";

const SUBJECT_CHIPS = ["math", "phonics", "reading", "art", "story", "workbooks", "logic"];

export default function AssignmentsInbox() {
  const router = useRouter();
  const { activeChild } = useChildStore();
  const { data: assignments = [], isLoading } = useAssignments(activeChild?.child_id);
  const { mutate: joinClassroom, isPending: joining } = useJoinClassroom();
  const { mutate: completeAssignment } = useCompleteAssignment();
  const { mutate: assignWorksheet, isPending: assigning } = useAssignWorksheet();
  const { mutate: deleteAssignment } = useDeleteAssignment();
  const { mutate: uploadWorksheet, isPending: uploadingFile } = useUploadWorksheet();

  const [code, setCode] = useState("");
  const [pickerOpen, setPickerOpen] = useState(false);
  const [pickerSearch, setPickerSearch] = useState("");
  const [pickerSubject, setPickerSubject] = useState<string | null>(null);
  const [pickerNote, setPickerNote] = useState("");

  const [uploadOpen, setUploadOpen] = useState(false);
  const [uploadFile, setUploadFile] = useState<{ file: any; name: string; type: string } | null>(null);
  const [uploadTitle, setUploadTitle] = useState("");
  const [uploadSubject, setUploadSubject] = useState<string | null>(null);
  const [uploadNote, setUploadNote] = useState("");

  const { data: pickerResults = [], isLoading: pickerLoading } = useQuery({
    queryKey: ["worksheetsPicker", pickerSubject, activeChild?.grade_id],
    queryFn: () => contentApi.getWorksheets({
      subject: pickerSubject || undefined,
      grade: activeChild?.grade_id,
    }),
    enabled: pickerOpen,
    staleTime: 60_000,
  });

  const filteredResults = pickerSearch.trim()
    ? pickerResults.filter((w: any) =>
        w.title?.toLowerCase().includes(pickerSearch.trim().toLowerCase()))
    : pickerResults;

  const openPicker = () => {
    if (!activeChild) { Alert.alert("Select a child first"); return; }
    setPickerNote("");
    setPickerSearch("");
    setPickerSubject(null);
    setPickerOpen(true);
  };

  const assign = (worksheetId: number, title: string) => {
    assignWorksheet(
      { childId: activeChild!.child_id, worksheetId, note: pickerNote.trim() || undefined },
      {
        onSuccess: () => { setPickerOpen(false); Alert.alert("Assigned!", `"${title}" was added to ${activeChild!.nickname}'s assignments.`); },
        onError:   (e: any) => Alert.alert("Couldn't assign", e.message),
      }
    );
  };

  const removeAssignment = (assignmentId: number, title: string) => {
    confirmAction(
      "Remove assignment",
      `Remove "${title}" from ${activeChild?.nickname}'s assignments?`,
      () => deleteAssignment({ assignmentId, childId: activeChild!.child_id }),
      "Remove",
      true
    );
  };

  const openUpload = () => {
    if (!activeChild) { Alert.alert("Select a child first"); return; }
    setUploadFile(null);
    setUploadTitle("");
    setUploadSubject(null);
    setUploadNote("");
    setUploadOpen(true);
  };

  const pickFile = async () => {
    if (Platform.OS === "web") {
      const input = document.createElement("input");
      input.type = "file";
      input.accept = "application/pdf,image/*";
      input.onchange = () => {
        const f = input.files?.[0];
        if (f) setUploadFile({ file: f, name: f.name, type: f.type || "application/octet-stream" });
      };
      input.click();
      return;
    }
    const perm = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) { Alert.alert("Permission needed", "Please allow access to continue."); return; }
    const result = await ImagePicker.launchImageLibraryAsync({ mediaTypes: ["images"], quality: 0.8 });
    if (!result.canceled && result.assets?.[0]) {
      setUploadFile({ file: result.assets[0].uri, name: `worksheet-${Date.now()}.jpg`, type: "image/jpeg" });
    }
  };

  const submitUpload = () => {
    if (!activeChild || !uploadFile) return;
    const subjectId = uploadSubject ? SUBJECT_META[uploadSubject]?.subjectId : undefined;
    uploadWorksheet(
      {
        child_id: activeChild.child_id,
        file: uploadFile.file,
        filename: uploadFile.name,
        mime: uploadFile.type,
        title: uploadTitle.trim() || undefined,
        subject_id: subjectId,
        note: uploadNote.trim() || undefined,
      },
      {
        onSuccess: () => { setUploadOpen(false); Alert.alert("Uploaded!", `Added to ${activeChild.nickname}'s assignments.`); },
        onError:   (e: any) => Alert.alert("Couldn't upload", e.message),
      }
    );
  };

  const submitJoin = () => {
    if (!activeChild) {
      Alert.alert("Select a child first");
      return;
    }
    if (!code.trim()) {
      Alert.alert("Please enter a classroom code");
      return;
    }
    joinClassroom(
      { childId: activeChild.child_id, code: code.trim().toUpperCase() },
      {
        onSuccess: (data: any) => { setCode(""); Alert.alert("Joined!", `${activeChild.nickname} joined ${data.classroom_name}.`); },
        onError:   (e: any) => Alert.alert("Couldn't join", e.message),
      }
    );
  };

  if (!activeChild) {
    return (
      <View style={s.centerRoot}>
        <Text style={s.emptyEmoji}>👨‍👩‍👧</Text>
        <Text style={s.emptyText}>Add a child profile first to join a classroom.</Text>
        <TouchableOpacity onPress={() => router.push("/(parent)/children")}>
          <Text style={s.emptyLink}>Go to Children</Text>
        </TouchableOpacity>
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>📝 Assignments</Text>
          <Text style={s.count}>for {activeChild.nickname}</Text>
        </View>
        <View style={{ flexDirection: "row", gap: 8 }}>
          <TouchableOpacity style={s.uploadBtn} onPress={openUpload}>
            <Text style={s.uploadBtnText}>📤 Upload</Text>
          </TouchableOpacity>
          <TouchableOpacity style={s.assignBtn} onPress={openPicker}>
            <Text style={s.assignBtnText}>+ Assign</Text>
          </TouchableOpacity>
        </View>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {/* Join classroom */}
        <View style={s.joinCard}>
          <Text style={s.joinTitle}>Join a classroom</Text>
          <Text style={s.joinSub}>Ask your child's teacher for their classroom code.</Text>
          <View style={s.joinRow}>
            <TextInput
              style={s.joinInput}
              placeholder="CLASSROOM CODE"
              value={code}
              onChangeText={setCode}
              autoCapitalize="characters"
            />
            <TouchableOpacity style={[s.joinBtn, joining && s.btnDim]} onPress={submitJoin} disabled={joining}>
              <Text style={s.joinBtnText}>{joining ? "Joining…" : "Join"}</Text>
            </TouchableOpacity>
          </View>
        </View>

        {/* Assignments inbox */}
        {isLoading ? (
          <ActivityIndicator style={{ marginTop: 24 }} color={colors.brand} />
        ) : assignments.length === 0 ? (
          <Text style={s.empty}>No assignments yet. Tap "+ Assign" above to give {activeChild.nickname} a worksheet, or join a classroom to see teacher homework here.</Text>
        ) : (
          assignments.map((a: any) => (
            <View key={a.assignment_id} style={s.assignmentCard}>
              <View style={{ flex: 1 }}>
                <Text style={s.assignmentClassroom}>
                  {a.source === "parent" ? "ASSIGNED BY YOU" : a.classroom_name}
                </Text>
                <Text style={s.assignmentTitle}>{a.worksheet_title}</Text>
                {a.note && <Text style={s.assignmentNote}>{a.note}</Text>}
                <Text style={s.assignmentMeta}>
                  Assigned {new Date(a.assigned_at).toLocaleDateString()}
                  {a.completed_at ? " · ✅ Done" : ""}
                </Text>
              </View>
              <View style={{ gap: 8, alignItems: "flex-end" }}>
                {a.pdf_url && (
                  <TouchableOpacity onPress={() => Linking.openURL(a.pdf_url)}>
                    <Text style={s.openAction}>Open</Text>
                  </TouchableOpacity>
                )}
                {!a.completed_at && (
                  <TouchableOpacity onPress={() =>
                    completeAssignment({ assignmentId: a.assignment_id, childId: activeChild.child_id })
                  }>
                    <Text style={s.doneAction}>Mark done</Text>
                  </TouchableOpacity>
                )}
                {a.source === "parent" && (
                  <TouchableOpacity onPress={() => removeAssignment(a.assignment_id, a.worksheet_title)}>
                    <Text style={s.removeAction}>Remove</Text>
                  </TouchableOpacity>
                )}
              </View>
            </View>
          ))
        )}
      </ScrollView>

      {/* Worksheet picker modal */}
      <Modal visible={pickerOpen} animationType="slide" transparent onRequestClose={() => setPickerOpen(false)}>
        <View style={s.modalBackdrop}>
          <View style={s.modalSheet}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Assign a worksheet</Text>
              <TouchableOpacity onPress={() => setPickerOpen(false)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>

            <TextInput
              style={s.pickerSearch}
              placeholder="Search worksheets…"
              value={pickerSearch}
              onChangeText={setPickerSearch}
            />

            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={s.chipRow}>
              <TouchableOpacity
                onPress={() => setPickerSubject(null)}
                style={[s.chip, pickerSubject === null && s.chipActive]}
              >
                <Text style={[s.chipText, pickerSubject === null && s.chipTextActive]}>All</Text>
              </TouchableOpacity>
              {SUBJECT_CHIPS.map(slug => (
                <TouchableOpacity
                  key={slug}
                  onPress={() => setPickerSubject(slug)}
                  style={[s.chip, pickerSubject === slug && s.chipActive]}
                >
                  <Text style={[s.chipText, pickerSubject === slug && s.chipTextActive]}>
                    {SUBJECT_META[slug]?.icon} {SUBJECT_META[slug]?.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <TextInput
              style={s.noteInput}
              placeholder={'Optional note (e.g. "Do this after dinner")'}
              value={pickerNote}
              onChangeText={setPickerNote}
            />

            {pickerLoading ? (
              <ActivityIndicator style={{ marginTop: 24 }} color={colors.brand} />
            ) : (
              <FlatList
                data={filteredResults}
                keyExtractor={(item: any) => String(item.worksheet_id)}
                style={s.pickerList}
                ListEmptyComponent={<Text style={s.empty}>No worksheets found.</Text>}
                renderItem={({ item }: any) => (
                  <View style={s.pickerRow}>
                    <View style={{ flex: 1 }}>
                      <Text style={s.pickerRowTitle}>{item.title}</Text>
                      <Text style={s.pickerRowMeta}>
                        {SUBJECT_META[item.subject]?.icon} {SUBJECT_META[item.subject]?.label}
                        {item.estimated_min ? ` · ${item.estimated_min} min` : ""}
                      </Text>
                    </View>
                    <TouchableOpacity
                      style={[s.pickerAssignBtn, assigning && s.btnDim]}
                      disabled={assigning}
                      onPress={() => assign(item.worksheet_id, item.title)}
                    >
                      <Text style={s.pickerAssignBtnText}>Assign</Text>
                    </TouchableOpacity>
                  </View>
                )}
              />
            )}
          </View>
        </View>
      </Modal>

      {/* Upload-your-own worksheet modal */}
      <Modal visible={uploadOpen} animationType="slide" transparent onRequestClose={() => setUploadOpen(false)}>
        <View style={s.modalBackdrop}>
          <View style={s.modalSheet}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Upload a worksheet</Text>
              <TouchableOpacity onPress={() => setUploadOpen(false)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>

            <ScrollView>
              <Text style={s.uploadHint}>PDF or image (jpg/png) — up to 15MB</Text>

              <TouchableOpacity style={s.filePickBtn} onPress={pickFile}>
                <Text style={s.filePickBtnText}>
                  {uploadFile ? `📎 ${uploadFile.name}` : "Choose a file…"}
                </Text>
              </TouchableOpacity>

              <TextInput
                style={s.pickerSearch}
                placeholder="Title (optional — defaults to filename)"
                value={uploadTitle}
                onChangeText={setUploadTitle}
              />

              <Text style={s.label}>Subject (optional)</Text>
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={s.chipRow}>
                <TouchableOpacity
                  onPress={() => setUploadSubject(null)}
                  style={[s.chip, uploadSubject === null && s.chipActive]}
                >
                  <Text style={[s.chipText, uploadSubject === null && s.chipTextActive]}>Workbooks</Text>
                </TouchableOpacity>
                {SUBJECT_CHIPS.map(slug => (
                  <TouchableOpacity
                    key={slug}
                    onPress={() => setUploadSubject(slug)}
                    style={[s.chip, uploadSubject === slug && s.chipActive]}
                  >
                    <Text style={[s.chipText, uploadSubject === slug && s.chipTextActive]}>
                      {SUBJECT_META[slug]?.icon} {SUBJECT_META[slug]?.label}
                    </Text>
                  </TouchableOpacity>
                ))}
              </ScrollView>

              <TextInput
                style={s.noteInput}
                placeholder={'Optional note (e.g. "From grandma")'}
                value={uploadNote}
                onChangeText={setUploadNote}
              />

              <TouchableOpacity
                style={[s.pickerAssignBtn, s.uploadSubmitBtn, (!uploadFile || uploadingFile) && s.btnDim]}
                disabled={!uploadFile || uploadingFile}
                onPress={submitUpload}
              >
                <Text style={s.pickerAssignBtnText}>
                  {uploadingFile ? "Uploading…" : `Assign to ${activeChild.nickname}`}
                </Text>
              </TouchableOpacity>
            </ScrollView>
          </View>
        </View>
      </Modal>

    </View>
  );
}

const s = StyleSheet.create({
  root:       { flex: 1, backgroundColor: "#f8f7ff" },
  centerRoot: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },
  emptyEmoji: { fontSize: 48, marginBottom: 12 },
  emptyText:  { fontSize: 14, color: colors.textMuted, textAlign: "center", marginBottom: 12 },
  emptyLink:  { fontSize: 14, fontWeight: "700", color: colors.brand },

  header: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
            paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  count:  { fontSize: 13, color: colors.textMuted, fontWeight: "600", marginTop: 2 },
  assignBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 10 },
  assignBtnText: { color: "white", fontWeight: "800", fontSize: 13 },
  uploadBtn: { backgroundColor: "white", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 10,
               borderWidth: 1.5, borderColor: colors.brand },
  uploadBtnText: { color: colors.brand, fontWeight: "800", fontSize: 13 },
  body:   { padding: 16, gap: 12 },

  joinCard:  { backgroundColor: "white", borderRadius: 14, padding: 16, gap: 8,
               shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  joinTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  joinSub:   { fontSize: 12, color: colors.textMuted, marginBottom: 4 },
  joinRow:   { flexDirection: "row", gap: 8 },
  joinInput: { flex: 1, borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
               paddingHorizontal: 14, paddingVertical: 12, fontSize: 14, color: colors.text, letterSpacing: 1 },
  joinBtn:   { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 18, justifyContent: "center" },
  btnDim:    { opacity: 0.6 },
  joinBtnText:{ color: "white", fontWeight: "800", fontSize: 14 },

  empty: { textAlign: "center", color: colors.textMuted, marginTop: 24, fontSize: 14 },

  assignmentCard: { flexDirection: "row", backgroundColor: "white", borderRadius: 14, padding: 16,
                    shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  assignmentClassroom: { fontSize: 11, fontWeight: "700", color: colors.brand, textTransform: "uppercase" },
  assignmentTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginTop: 2 },
  assignmentNote:  { fontSize: 12, color: colors.textMuted, marginTop: 4, fontStyle: "italic" },
  assignmentMeta:  { fontSize: 11, color: colors.textMuted, marginTop: 6 },
  openAction:      { fontSize: 12, fontWeight: "700", color: colors.brand },
  doneAction:      { fontSize: 12, fontWeight: "700", color: colors.text },
  removeAction:    { fontSize: 12, fontWeight: "700", color: "#dc2626" },

  modalBackdrop: { flex: 1, backgroundColor: "rgba(0,0,0,0.4)", justifyContent: "flex-end" },
  modalSheet:    { backgroundColor: "white", borderTopLeftRadius: 20, borderTopRightRadius: 20,
                   padding: 20, maxHeight: "85%", minHeight: "60%" },
  modalHeader:   { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 14 },
  modalTitle:    { fontSize: 18, fontWeight: "900", color: colors.text },
  modalClose:    { fontSize: 20, color: colors.textMuted, padding: 4 },

  pickerSearch: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                  paddingHorizontal: 14, paddingVertical: 12, fontSize: 14, color: colors.text, marginBottom: 10 },
  noteInput:    { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                  paddingHorizontal: 14, paddingVertical: 10, fontSize: 13, color: colors.text, marginBottom: 10 },

  chipRow:   { marginBottom: 10 },
  chip:      { borderWidth: 1.5, borderColor: colors.border, borderRadius: 20,
               paddingHorizontal: 14, paddingVertical: 8, marginRight: 8, backgroundColor: "white" },
  chipActive:{ borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText:  { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  chipTextActive: { color: colors.brand },

  pickerList: { flex: 1 },
  pickerRow:  { flexDirection: "row", alignItems: "center", paddingVertical: 12,
                borderBottomWidth: 1, borderBottomColor: colors.border },
  pickerRowTitle: { fontSize: 14, fontWeight: "700", color: colors.text },
  pickerRowMeta:  { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  pickerAssignBtn: { backgroundColor: colors.brand, borderRadius: 8, paddingHorizontal: 14, paddingVertical: 8 },
  pickerAssignBtnText: { color: "white", fontWeight: "800", fontSize: 12 },

  uploadHint: { fontSize: 12, color: colors.textMuted, marginBottom: 10 },
  filePickBtn: { borderWidth: 1.5, borderColor: colors.border, borderStyle: "dashed", borderRadius: 12,
                 paddingVertical: 18, alignItems: "center", marginBottom: 12, backgroundColor: "#f8f7ff" },
  filePickBtnText: { fontSize: 14, fontWeight: "700", color: colors.text },
  label: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginBottom: 6 },
  uploadSubmitBtn: { alignItems: "center", paddingVertical: 14, marginTop: 4 },
});
