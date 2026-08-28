import { useState } from "react";
import {
  View, Text, TextInput, TouchableOpacity, ScrollView, Modal,
  StyleSheet, ActivityIndicator, Alert, Platform, Share,
} from "react-native";
import { useRouter } from "expo-router";
import {
  useClassrooms, useCreateClassroom, useRegenerateCode,
  useUpdateClassroom, useDeleteClassroom,
  useRoster, useRemoveFromRoster, useAddToRoster, useUpdateRosterStudent,
  useSearchParents, useParentChildren, useLinkStudentsToClassroom,
} from "../../hooks/useTeacher";
import { useAuthStore } from "../../store/authStore";
import { SchoolSearchInput } from "../../components/SchoolSearchInput";
import { useGrades } from "../../hooks/useApi";
import { confirmAction } from "../../utils/confirm";
import { colors, GRADES } from "../../constants/theme";

export default function TeacherHome() {
  const router = useRouter();
  const { family, logout } = useAuthStore();
  const { data: classrooms = [], isLoading } = useClassrooms();
  const { data: classroomGrades = [] } = useGrades();
  const { mutate: createClassroom, isPending: creating } = useCreateClassroom();
  const { mutate: regenerateCode } = useRegenerateCode();
  const { mutate: updateClassroom, isPending: savingClassroom } = useUpdateClassroom();
  const { mutate: deleteClassroom } = useDeleteClassroom();
  const { mutate: removeFromRoster } = useRemoveFromRoster();
  const { mutate: addToRoster, isPending: addingStudent } = useAddToRoster();
  const { mutate: updateRosterStudent, isPending: savingStudent } = useUpdateRosterStudent();

  const [name, setName]     = useState("");
  const [school, setSchool] = useState("");
  const [gradeId, setGradeId] = useState<number | null>(null);
  const [expanded, setExpanded] = useState<number | null>(null);

  const [editingClassroomId, setEditingClassroomId] = useState<number | null>(null);
  const [editName, setEditName]     = useState("");
  const [editSchool, setEditSchool] = useState("");
  const [editGradeId, setEditGradeId] = useState<number | null>(null);

  const [showAddStudent, setShowAddStudent] = useState(false);
  const [studentName, setStudentName]       = useState("");
  const [studentGradeId, setStudentGradeId] = useState(2);

  const [editingChildId, setEditingChildId] = useState<number | null>(null);
  const [editStudentName, setEditStudentName]       = useState("");
  const [editStudentGradeId, setEditStudentGradeId] = useState(2);

  const { data: roster = [], isLoading: rosterLoading } = useRoster(expanded ?? undefined);

  // Add existing student via parent lookup
  const [linkClassroomId, setLinkClassroomId] = useState<number | null>(null);
  const [parentSearch, setParentSearch]       = useState("");
  const [selectedParentId, setSelectedParentId] = useState<number | null>(null);
  const [selectedChildIds, setSelectedChildIds] = useState<number[]>([]);
  const { data: parentResults = [], isLoading: searchingParents } = useSearchParents(parentSearch);
  const { data: parentChildren = [], isLoading: loadingChildren } = useParentChildren(selectedParentId ?? undefined);
  const { mutate: linkStudents, isPending: linking } = useLinkStudentsToClassroom();

  const openLinkModal = (classroomId: number) => {
    setLinkClassroomId(classroomId);
    setParentSearch("");
    setSelectedParentId(null);
    setSelectedChildIds([]);
  };

  const toggleChildSelected = (childId: number) => {
    setSelectedChildIds(ids => ids.includes(childId) ? ids.filter(id => id !== childId) : [...ids, childId]);
  };

  const submitLinkStudents = () => {
    if (!linkClassroomId || selectedChildIds.length === 0) return;
    linkStudents(
      { classroomId: linkClassroomId, childIds: selectedChildIds },
      {
        onSuccess: (data: any) => {
          setLinkClassroomId(null);
          const skippedNote = data.skipped?.length ? ` (${data.skipped.length} already in this classroom)` : "";
          Alert.alert("Added!", `${data.linked.length} student${data.linked.length === 1 ? "" : "s"} added${skippedNote}.`);
        },
        onError: (e: any) => Alert.alert("Couldn't add students", e.message),
      }
    );
  };

  const submitAddStudent = (classroomId: number) => {
    if (!studentName.trim()) {
      Alert.alert("Please enter the student's name");
      return;
    }
    addToRoster(
      { classroomId, body: { nickname: studentName.trim(), grade_id: studentGradeId } },
      {
        onSuccess: () => { setStudentName(""); setStudentGradeId(2); setShowAddStudent(false); },
        onError: (e: any) => Alert.alert("Error", e.message),
      }
    );
  };

  const startEditStudent = (r: any) => {
    setEditingChildId(r.child_id);
    setEditStudentName(r.nickname);
    setEditStudentGradeId(r.grade_id);
  };

  const submitEditStudent = (classroomId: number, childId: number) => {
    if (!editStudentName.trim()) {
      Alert.alert("Please enter the student's name");
      return;
    }
    updateRosterStudent(
      { classroomId, childId, body: { nickname: editStudentName.trim(), grade_id: editStudentGradeId } },
      {
        onSuccess: () => setEditingChildId(null),
        onError: (e: any) => Alert.alert("Error", e.message),
      }
    );
  };

  const submitCreate = () => {
    if (!name.trim()) {
      Alert.alert("Please enter a classroom name");
      return;
    }
    if (gradeId === null) {
      Alert.alert("Please choose a grade");
      return;
    }
    createClassroom(
      { classroom_name: name.trim(), school_name: school.trim() || undefined, grade_id: gradeId },
      { onSuccess: () => { setName(""); setSchool(""); setGradeId(null); }, onError: (e: any) => Alert.alert("Error", e.message) }
    );
  };

  const startEditClassroom = (c: any) => {
    setEditingClassroomId(c.classroom_id);
    setEditName(c.classroom_name);
    setEditSchool(c.school_name ?? "");
    setEditGradeId(c.grade_id ?? null);
  };

  const submitEditClassroom = (classroomId: number) => {
    if (!editName.trim()) {
      Alert.alert("Please enter a classroom name");
      return;
    }
    if (editGradeId === null) {
      Alert.alert("Please choose a grade");
      return;
    }
    updateClassroom(
      { classroomId, body: { classroom_name: editName.trim(), school_name: editSchool.trim() || undefined, grade_id: editGradeId } },
      {
        onSuccess: () => setEditingClassroomId(null),
        onError: (e: any) => Alert.alert("Error", e.message),
      }
    );
  };

  const confirmDeleteClassroom = (c: any) => {
    confirmAction(
      "Delete classroom?",
      `"${c.classroom_name}" will be archived and removed from your list. Students, assignments and grades are kept.`,
      () => deleteClassroom(c.classroom_id, { onError: (e: any) => Alert.alert("Error", e.message) }),
    );
  };

  const shareCode = (code: string, classroomName: string) => {
    Share.share({ message: `Join my classroom "${classroomName}" on Little Scholars Hub with code: ${code}` });
  };

  const handleSignOut = () => {
    confirmAction("Sign out?", "You'll need to sign back in.", async () => {
      await logout();
      router.replace("/(auth)/login");
    }, "Sign out");
  };

  return (
    <View style={s.root}>
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>🏫 My Classrooms</Text>
          <Text style={s.count}>
            {family?.email ? `${family.email} · ` : ""}{classrooms.length} total
          </Text>
        </View>
        <TouchableOpacity style={s.signOutBtn} onPress={handleSignOut}>
          <Text style={s.signOutText}>Sign out</Text>
        </TouchableOpacity>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {/* Create classroom */}
        <View style={s.createCard}>
          <Text style={s.createTitle}>Create a new classroom</Text>
          <TextInput style={s.input} placeholder="Classroom name" value={name} onChangeText={setName} />
          <Text style={s.fieldLabel}>Grade</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            {classroomGrades.map((cg: any) => (
              <TouchableOpacity
                key={cg.grade_id}
                onPress={() => setGradeId(cg.grade_id)}
                style={[s.gradeChip, gradeId === cg.grade_id && s.gradeChipActive]}
              >
                <Text style={[s.gradeChipText, gradeId === cg.grade_id && s.gradeChipTextActive]}>{cg.label}</Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
          <SchoolSearchInput value={school} onChangeText={setSchool} style={{ marginTop: 10 }} />
          <TouchableOpacity style={[s.createBtn, { marginTop: 10 }, creating && s.btnDim]} onPress={submitCreate} disabled={creating}>
            <Text style={s.createBtnText}>{creating ? "Creating…" : "Create classroom"}</Text>
          </TouchableOpacity>
        </View>

        {isLoading ? (
          <ActivityIndicator style={{ marginTop: 24 }} color={colors.brand} />
        ) : classrooms.length === 0 ? (
          <Text style={s.empty}>No classrooms yet — create one above.</Text>
        ) : (
          classrooms.map((c: any) => {
            const isExpanded = expanded === c.classroom_id;
            const isEditing  = editingClassroomId === c.classroom_id;
            return (
              <View key={c.classroom_id} style={s.classroomCard}>
                {isEditing ? (
                  <View style={s.editCard}>
                    <TextInput style={s.input} placeholder="Classroom name" value={editName} onChangeText={setEditName} />
                    <Text style={s.fieldLabel}>Grade</Text>
                    <ScrollView horizontal showsHorizontalScrollIndicator={false}>
                      {classroomGrades.map((cg: any) => (
                        <TouchableOpacity
                          key={cg.grade_id}
                          onPress={() => setEditGradeId(cg.grade_id)}
                          style={[s.gradeChip, editGradeId === cg.grade_id && s.gradeChipActive]}
                        >
                          <Text style={[s.gradeChipText, editGradeId === cg.grade_id && s.gradeChipTextActive]}>{cg.label}</Text>
                        </TouchableOpacity>
                      ))}
                    </ScrollView>
                    <SchoolSearchInput value={editSchool} onChangeText={setEditSchool} style={{ marginTop: 10 }} />
                    <View style={{ flexDirection: "row", gap: 10, marginTop: 10 }}>
                      <TouchableOpacity
                        style={[s.createBtn, { flex: 1 }, savingClassroom && s.btnDim]}
                        disabled={savingClassroom}
                        onPress={() => submitEditClassroom(c.classroom_id)}
                      >
                        <Text style={s.createBtnText}>{savingClassroom ? "Saving…" : "Save"}</Text>
                      </TouchableOpacity>
                      <TouchableOpacity style={s.cancelBtn} onPress={() => setEditingClassroomId(null)}>
                        <Text style={s.cancelBtnText}>Cancel</Text>
                      </TouchableOpacity>
                    </View>
                  </View>
                ) : (
                  <>
                    <TouchableOpacity onPress={() => setExpanded(isExpanded ? null : c.classroom_id)}>
                      <View style={s.classroomTop}>
                        <View style={{ flex: 1 }}>
                          <View style={{ flexDirection: "row", alignItems: "center", gap: 8 }}>
                            <Text style={s.classroomName}>{c.classroom_name}</Text>
                            {c.grade_label && <View style={s.gradeBadge}><Text style={s.gradeBadgeText}>{c.grade_label}</Text></View>}
                          </View>
                          {c.school_name && <Text style={s.classroomMeta}>{c.school_name}</Text>}
                          <Text style={s.classroomMeta}>{c.student_count} student{c.student_count === 1 ? "" : "s"}</Text>
                        </View>
                        <Text style={s.chevron}>{isExpanded ? "▲" : "▼"}</Text>
                      </View>
                    </TouchableOpacity>

                    <View style={s.classroomActionsRow}>
                      <TouchableOpacity onPress={() => startEditClassroom(c)}>
                        <Text style={s.codeAction}>Edit</Text>
                      </TouchableOpacity>
                      <TouchableOpacity onPress={() => confirmDeleteClassroom(c)}>
                        <Text style={[s.codeAction, { color: colors.danger }]}>Delete</Text>
                      </TouchableOpacity>
                    </View>

                    <View style={s.codeRow}>
                      <Text style={s.codeLabel}>Join code:</Text>
                      <Text style={s.codeValue}>{c.classroom_code}</Text>
                      <TouchableOpacity onPress={() => shareCode(c.classroom_code, c.classroom_name)}>
                        <Text style={s.codeAction}>Share</Text>
                      </TouchableOpacity>
                      <TouchableOpacity onPress={() => {
                        confirmAction(
                          "Regenerate code?", "The old code will stop working.",
                          () => regenerateCode(c.classroom_id), "Regenerate",
                        );
                      }}>
                        <Text style={s.codeAction}>Regenerate</Text>
                      </TouchableOpacity>
                    </View>
                  </>
                )}

                {isExpanded && (
                  <View style={s.roster}>
                    {rosterLoading ? (
                      <ActivityIndicator color={colors.brand} />
                    ) : roster.length === 0 ? (
                      <Text style={s.rosterEmpty}>No students have joined yet.</Text>
                    ) : (
                      roster.map((r: any) => (
                        editingChildId === r.child_id ? (
                          <View key={r.link_id} style={s.addStudentCard}>
                            <TextInput
                              style={s.input}
                              placeholder="Student name"
                              value={editStudentName}
                              onChangeText={setEditStudentName}
                            />
                            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginVertical: 8 }}>
                              {GRADES.map((g: any) => (
                                <TouchableOpacity
                                  key={g.grade_id}
                                  onPress={() => setEditStudentGradeId(g.grade_id)}
                                  style={[s.gradeChip, editStudentGradeId === g.grade_id && s.gradeChipActive]}
                                >
                                  <Text style={[s.gradeChipText, editStudentGradeId === g.grade_id && s.gradeChipTextActive]}>{g.label}</Text>
                                </TouchableOpacity>
                              ))}
                            </ScrollView>
                            <View style={{ flexDirection: "row", gap: 10 }}>
                              <TouchableOpacity
                                style={[s.createBtn, { flex: 1 }, savingStudent && s.btnDim]}
                                disabled={savingStudent}
                                onPress={() => submitEditStudent(c.classroom_id, r.child_id)}
                              >
                                <Text style={s.createBtnText}>{savingStudent ? "Saving…" : "Save"}</Text>
                              </TouchableOpacity>
                              <TouchableOpacity style={s.cancelBtn} onPress={() => setEditingChildId(null)}>
                                <Text style={s.cancelBtnText}>Cancel</Text>
                              </TouchableOpacity>
                            </View>
                          </View>
                        ) : (
                          <TouchableOpacity
                            key={r.link_id}
                            style={s.rosterRow}
                            onPress={() => router.push(`/(teacher)/students/${r.child_id}` as any)}
                          >
                            <Text style={s.rosterName}>{r.nickname}</Text>
                            <View style={{ flexDirection: "row", alignItems: "center", gap: 14 }}>
                              <Text style={s.rosterView}>View ›</Text>
                              {!!r.is_teacher_added && (
                                <TouchableOpacity onPress={(e) => {
                                  e.stopPropagation?.();
                                  startEditStudent(r);
                                }}>
                                  <Text style={s.codeAction}>Edit</Text>
                                </TouchableOpacity>
                              )}
                              <TouchableOpacity onPress={(e) => {
                                e.stopPropagation?.();
                                confirmAction(
                                  "Remove student?", `${r.nickname} will be removed from this classroom.`,
                                  () => removeFromRoster({ classroomId: c.classroom_id, childId: r.child_id }), "Remove",
                                );
                              }}>
                                <Text style={s.rosterRemove}>Remove</Text>
                              </TouchableOpacity>
                            </View>
                          </TouchableOpacity>
                        )
                      ))
                    )}

                    {showAddStudent && expanded === c.classroom_id ? (
                      <View style={s.addStudentCard}>
                        <TextInput
                          style={s.input}
                          placeholder="Student name"
                          value={studentName}
                          onChangeText={setStudentName}
                        />
                        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginVertical: 8 }}>
                          {GRADES.map((g: any) => (
                            <TouchableOpacity
                              key={g.grade_id}
                              onPress={() => setStudentGradeId(g.grade_id)}
                              style={[s.gradeChip, studentGradeId === g.grade_id && s.gradeChipActive]}
                            >
                              <Text style={[s.gradeChipText, studentGradeId === g.grade_id && s.gradeChipTextActive]}>{g.label}</Text>
                            </TouchableOpacity>
                          ))}
                        </ScrollView>
                        <View style={{ flexDirection: "row", gap: 10 }}>
                          <TouchableOpacity
                            style={[s.createBtn, { flex: 1 }, addingStudent && s.btnDim]}
                            disabled={addingStudent}
                            onPress={() => submitAddStudent(c.classroom_id)}
                          >
                            <Text style={s.createBtnText}>{addingStudent ? "Adding…" : "Add student"}</Text>
                          </TouchableOpacity>
                          <TouchableOpacity
                            style={s.cancelBtn}
                            onPress={() => { setShowAddStudent(false); setStudentName(""); setStudentGradeId(2); }}
                          >
                            <Text style={s.cancelBtnText}>Cancel</Text>
                          </TouchableOpacity>
                        </View>
                      </View>
                    ) : (
                      <View style={{ flexDirection: "row", gap: 10 }}>
                        <TouchableOpacity
                          style={[s.addStudentBtn, { flex: 1 }]}
                          onPress={() => { setShowAddStudent(true); setStudentName(""); setStudentGradeId(2); }}
                        >
                          <Text style={s.addStudentBtnText}>➕ Add a student</Text>
                        </TouchableOpacity>
                        <TouchableOpacity
                          style={[s.addStudentBtn, { flex: 1 }]}
                          onPress={() => openLinkModal(c.classroom_id)}
                        >
                          <Text style={s.addStudentBtnText}>🔍 Find existing student</Text>
                        </TouchableOpacity>
                      </View>
                    )}
                  </View>
                )}
              </View>
            );
          })
        )}
      </ScrollView>

      <Modal
        visible={linkClassroomId !== null}
        animationType="slide"
        transparent
        onRequestClose={() => setLinkClassroomId(null)}
      >
        <View style={s.modalOverlay}>
          <View style={s.modalCard}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Find existing student</Text>
              <TouchableOpacity onPress={() => setLinkClassroomId(null)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>

            <TextInput
              style={s.input}
              placeholder="Search by parent email…"
              value={parentSearch}
              onChangeText={(t) => { setParentSearch(t); setSelectedParentId(null); setSelectedChildIds([]); }}
              autoFocus
            />

            <ScrollView style={s.modalBody}>
              {selectedParentId === null ? (
                searchingParents ? (
                  <ActivityIndicator color={colors.brand} style={{ marginTop: 16 }} />
                ) : parentSearch.trim().length < 2 ? (
                  <Text style={s.rosterEmpty}>Type at least 2 characters to search.</Text>
                ) : parentResults.length === 0 ? (
                  <Text style={s.rosterEmpty}>No matching parents found.</Text>
                ) : (
                  parentResults.map((p: any) => (
                    <TouchableOpacity
                      key={p.family_id}
                      style={s.parentRow}
                      onPress={() => setSelectedParentId(p.family_id)}
                    >
                      <Text style={s.rosterName}>{p.email}</Text>
                      <Text style={s.rosterView}>{p.child_count} kid{p.child_count === 1 ? "" : "s"} ›</Text>
                    </TouchableOpacity>
                  ))
                )
              ) : (
                <>
                  <TouchableOpacity onPress={() => setSelectedParentId(null)} style={{ marginBottom: 8 }}>
                    <Text style={s.codeAction}>‹ Back to search</Text>
                  </TouchableOpacity>
                  {loadingChildren ? (
                    <ActivityIndicator color={colors.brand} style={{ marginTop: 16 }} />
                  ) : parentChildren.length === 0 ? (
                    <Text style={s.rosterEmpty}>This parent has no children yet.</Text>
                  ) : (
                    parentChildren.map((child: any) => {
                      const checked = selectedChildIds.includes(child.child_id);
                      return (
                        <TouchableOpacity
                          key={child.child_id}
                          style={s.parentRow}
                          onPress={() => toggleChildSelected(child.child_id)}
                        >
                          <View>
                            <Text style={s.rosterName}>{child.nickname}</Text>
                            <Text style={s.classroomMeta}>{child.grade_label}</Text>
                          </View>
                          <View style={[s.checkbox, checked && s.checkboxChecked]}>
                            {checked && <Text style={s.checkboxMark}>✓</Text>}
                          </View>
                        </TouchableOpacity>
                      );
                    })
                  )}
                </>
              )}
            </ScrollView>

            <View style={{ flexDirection: "row", gap: 10, marginTop: 12 }}>
              <TouchableOpacity
                style={[s.createBtn, { flex: 1 }, (linking || selectedChildIds.length === 0) && s.btnDim]}
                disabled={linking || selectedChildIds.length === 0}
                onPress={submitLinkStudents}
              >
                <Text style={s.createBtnText}>
                  {linking ? "Adding…" : `Add ${selectedChildIds.length || ""} student${selectedChildIds.length === 1 ? "" : "s"}`}
                </Text>
              </TouchableOpacity>
              <TouchableOpacity style={s.cancelBtn} onPress={() => setLinkClassroomId(null)}>
                <Text style={s.cancelBtnText}>Cancel</Text>
              </TouchableOpacity>
            </View>
          </View>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center", justifyContent: "space-between",
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  count:  { fontSize: 13, color: colors.textMuted, fontWeight: "600", marginTop: 2 },
  signOutBtn:  { backgroundColor: colors.brandLight, borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8 },
  signOutText: { color: colors.brand, fontSize: 13, fontWeight: "700" },
  body:   { padding: 16, gap: 12 },

  createCard: { backgroundColor: "white", borderRadius: 14, padding: 16, gap: 10,
                shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  createTitle:{ fontSize: 15, fontWeight: "800", color: colors.text },
  input:      { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                paddingHorizontal: 14, paddingVertical: 12, fontSize: 14, color: colors.text },
  createBtn:  { backgroundColor: colors.brand, borderRadius: 10, paddingVertical: 12, alignItems: "center" },
  btnDim:     { opacity: 0.6 },
  createBtnText: { color: "white", fontWeight: "800", fontSize: 14 },

  empty: { textAlign: "center", color: colors.textMuted, marginTop: 24, fontSize: 14 },

  classroomCard: { backgroundColor: "white", borderRadius: 14, padding: 16,
                   shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  classroomTop:  { flexDirection: "row", alignItems: "center" },
  classroomName: { fontSize: 15, fontWeight: "800", color: colors.text },
  classroomMeta: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  gradeBadge:    { backgroundColor: colors.brandLight, borderRadius: 8, paddingHorizontal: 8, paddingVertical: 2 },
  gradeBadgeText:{ fontSize: 11, fontWeight: "800", color: colors.brand },
  fieldLabel:    { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginTop: 10, marginBottom: 6 },
  chevron:       { fontSize: 14, color: colors.textMuted, marginLeft: 8 },
  editCard:      { gap: 4 },
  classroomActionsRow: { flexDirection: "row", gap: 16, marginTop: 10 },

  codeRow:   { flexDirection: "row", alignItems: "center", gap: 10, marginTop: 12,
               borderTopWidth: 1, borderTopColor: colors.border, paddingTop: 12 },
  codeLabel: { fontSize: 12, color: colors.textMuted, fontWeight: "600" },
  codeValue: { fontSize: 15, fontWeight: "900", color: colors.brand, letterSpacing: 1, flex: 1 },
  codeAction:{ fontSize: 12, fontWeight: "700", color: colors.brand },

  roster:      { marginTop: 12, borderTopWidth: 1, borderTopColor: colors.border, paddingTop: 12, gap: 8 },
  rosterEmpty: { fontSize: 13, color: colors.textMuted },
  rosterRow:   { flexDirection: "row", alignItems: "center", justifyContent: "space-between", paddingVertical: 4 },
  rosterName:  { fontSize: 13, fontWeight: "700", color: colors.text },
  rosterView:  { fontSize: 12, fontWeight: "700", color: colors.brand },
  rosterRemove:{ fontSize: 12, fontWeight: "700", color: colors.danger },

  addStudentBtn:    { marginTop: 4, alignItems: "center", paddingVertical: 10,
                      borderWidth: 1.5, borderColor: colors.border, borderStyle: "dashed", borderRadius: 10 },
  addStudentBtnText:{ fontSize: 13, fontWeight: "700", color: colors.brand },
  addStudentCard:   { marginTop: 4, backgroundColor: "#f8f7ff", borderRadius: 10, padding: 12 },
  cancelBtn:        { borderRadius: 10, paddingVertical: 12, paddingHorizontal: 16,
                      alignItems: "center", borderWidth: 1.5, borderColor: colors.border },
  cancelBtnText:    { fontSize: 14, fontWeight: "700", color: colors.textMuted },

  gradeChip:      { paddingHorizontal: 12, paddingVertical: 6, borderRadius: 10, backgroundColor: "white",
                    borderWidth: 1.5, borderColor: colors.border, marginRight: 8 },
  gradeChipActive:{ backgroundColor: colors.brand, borderColor: colors.brand },
  gradeChipText:  { fontSize: 12, fontWeight: "700", color: colors.text },
  gradeChipTextActive:{ color: "white" },

  modalOverlay: { flex: 1, backgroundColor: "rgba(0,0,0,0.4)", justifyContent: "flex-end" },
  modalCard:    { backgroundColor: "white", borderTopLeftRadius: 20, borderTopRightRadius: 20,
                  padding: 20, maxHeight: "80%", gap: 10 },
  modalHeader:  { flexDirection: "row", alignItems: "center", justifyContent: "space-between" },
  modalTitle:   { fontSize: 16, fontWeight: "900", color: colors.text },
  modalClose:   { fontSize: 18, color: colors.textMuted, fontWeight: "700" },
  modalBody:    { marginTop: 4 },

  parentRow:    { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
                  paddingVertical: 12, borderBottomWidth: 1, borderBottomColor: colors.border },
  checkbox:     { width: 22, height: 22, borderRadius: 6, borderWidth: 1.5, borderColor: colors.border,
                  alignItems: "center", justifyContent: "center" },
  checkboxChecked: { backgroundColor: colors.brand, borderColor: colors.brand },
  checkboxMark: { color: "white", fontSize: 13, fontWeight: "900" },
});
