import { useState } from "react";
import {
  View, Text, TouchableOpacity, ScrollView, TextInput,
  StyleSheet, ActivityIndicator, Alert, Platform,
} from "react-native";
import { useClassrooms, useRoster, useAssignments, useCreateAssignment, useDeleteAssignment } from "../../hooks/useTeacher";
import { useWorksheets, useSubjects } from "../../hooks/useApi";
import { useTeacherQueue, useReviewSubmission } from "../../hooks/useHomework";
import { confirmAction } from "../../utils/confirm";
import { colors } from "../../constants/theme";

export default function TeacherAssignments() {
  const { data: classrooms = [] } = useClassrooms();
  const [classroomId, setClassroomId] = useState<number | undefined>(undefined);
  const activeClassroomId = classroomId ?? classrooms[0]?.classroom_id;
  const activeClassroom = (classrooms as any[]).find((c: any) => c.classroom_id === activeClassroomId);

  const { data: roster = [] }      = useRoster(activeClassroomId);
  const { data: worksheets = [] }  = useWorksheets({ grade: activeClassroom?.grade_id });
  const { data: subjects = [] }    = useSubjects();
  const coreSubjects = (subjects as any[]).filter((sub: any) => !sub.is_cultural);
  const subjectsWithWorksheets = coreSubjects.filter((subj: any) =>
    (worksheets as any[]).some((w: any) => w.subject === subj.slug)
  );
  const [activeSubjectSlug, setActiveSubjectSlug] = useState<string | undefined>(undefined);
  const activeSubjectSlugResolved = subjectsWithWorksheets.some((s: any) => s.slug === activeSubjectSlug)
    ? activeSubjectSlug
    : subjectsWithWorksheets[0]?.slug;
  const activeSubjectWorksheets = (worksheets as any[]).filter((w: any) => w.subject === activeSubjectSlugResolved);
  const { data: assignments = [], isLoading: assignmentsLoading } = useAssignments(activeClassroomId);
  const { mutate: createAssignment, isPending: creating } = useCreateAssignment();
  const { mutate: deleteAssignment } = useDeleteAssignment();

  const { data: homeworkQueue = [] } = useTeacherQueue(activeClassroomId);
  const { mutate: reviewSubmission } = useReviewSubmission();
  const [scoreDrafts, setScoreDrafts] = useState<Record<number, string>>({});

  const submitReview = (submissionId: number) => {
    const score = parseInt(scoreDrafts[submissionId] || "", 10);
    if (!Number.isFinite(score) || score < 0 || score > 100) {
      Alert.alert("Enter a score between 0 and 100");
      return;
    }
    reviewSubmission({ submissionId, score, classroomId: activeClassroomId });
  };

  const [worksheetId, setWorksheetId] = useState<number | undefined>(undefined);
  const [childId, setChildId]         = useState<number | null>(null); // null = whole class
  const [note, setNote]               = useState("");

  const submit = () => {
    if (!activeClassroomId) {
      Alert.alert("Create a classroom first");
      return;
    }
    if (!worksheetId) {
      Alert.alert("Please choose a worksheet");
      return;
    }
    createAssignment(
      { classroomId: activeClassroomId, body: { worksheet_id: worksheetId, child_id: childId, note: note.trim() || undefined } },
      { onSuccess: () => setNote(""), onError: (e: any) => Alert.alert("Error", e.message) }
    );
  };

  if (classrooms.length === 0) {
    return (
      <View style={s.centerRoot}>
        <Text style={s.emptyEmoji}>🏫</Text>
        <Text style={s.emptyText}>Create a classroom on the Classrooms tab first.</Text>
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>📝 Assignments</Text>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {/* Classroom picker */}
        <Text style={s.label}>Classroom</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
          {classrooms.map((c: any) => (
            <TouchableOpacity
              key={c.classroom_id}
              style={[s.chip, activeClassroomId === c.classroom_id && s.chipActive]}
              onPress={() => setClassroomId(c.classroom_id)}
            >
              <Text style={[s.chipText, activeClassroomId === c.classroom_id && s.chipTextActive]}>
                {c.classroom_name}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {/* Create assignment */}
        <View style={s.createCard}>
          <Text style={s.createTitle}>
            Assign a worksheet{activeClassroom?.grade_label ? ` — ${activeClassroom.grade_label}` : ""}
          </Text>

          <Text style={s.label}>Worksheet</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 10 }}>
            {subjectsWithWorksheets.map((subj: any) => (
              <TouchableOpacity
                key={subj.subject_id}
                style={[s.subjectTab, activeSubjectSlugResolved === subj.slug && s.subjectTabActive]}
                onPress={() => setActiveSubjectSlug(subj.slug)}
              >
                <Text style={[s.subjectTabText, activeSubjectSlugResolved === subj.slug && s.subjectTabTextActive]}>
                  {subj.icon} {subj.label}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 12 }}>
            {activeSubjectWorksheets.map((w: any) => (
              <TouchableOpacity
                key={w.worksheet_id}
                style={[s.chip, worksheetId === w.worksheet_id && s.chipActive]}
                onPress={() => setWorksheetId(w.worksheet_id)}
              >
                <Text style={[s.chipText, worksheetId === w.worksheet_id && s.chipTextActive]} numberOfLines={1}>
                  {w.title}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>

          <Text style={s.label}>Assign to</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 12 }}>
            <TouchableOpacity style={[s.chip, childId === null && s.chipActive]} onPress={() => setChildId(null)}>
              <Text style={[s.chipText, childId === null && s.chipTextActive]}>Whole class</Text>
            </TouchableOpacity>
            {roster.map((r: any) => (
              <TouchableOpacity
                key={r.child_id}
                style={[s.chip, childId === r.child_id && s.chipActive]}
                onPress={() => setChildId(r.child_id)}
              >
                <Text style={[s.chipText, childId === r.child_id && s.chipTextActive]}>{r.nickname}</Text>
              </TouchableOpacity>
            ))}
          </ScrollView>

          <TextInput style={s.input} placeholder="Note (optional)" value={note} onChangeText={setNote} />

          <TouchableOpacity style={[s.createBtn, creating && s.btnDim]} onPress={submit} disabled={creating}>
            <Text style={s.createBtnText}>{creating ? "Assigning…" : "Assign to Student"}</Text>
          </TouchableOpacity>
        </View>

        {/* Past assignments */}
        <Text style={s.label}>Past assignments</Text>
        {assignmentsLoading ? (
          <ActivityIndicator color={colors.brand} />
        ) : assignments.length === 0 ? (
          <Text style={s.empty}>No assignments yet.</Text>
        ) : (
          assignments.map((a: any) => (
            <View key={a.assignment_id} style={s.assignmentRow}>
              <View style={{ flex: 1 }}>
                <Text style={s.assignmentTitle}>{a.worksheet_title}</Text>
                <Text style={s.assignmentMeta}>
                  {a.child_nickname ? a.child_nickname : "Whole class"} · {new Date(a.assigned_at).toLocaleDateString()}
                  {a.completed_at ? " · done" : ""}
                </Text>
                {a.note && <Text style={s.assignmentNote}>{a.note}</Text>}
              </View>
              <TouchableOpacity onPress={() => {
                confirmAction(
                  "Delete assignment?", "",
                  () => deleteAssignment({ assignmentId: a.assignment_id, classroomId: activeClassroomId! }),
                );
              }}>
                <Text style={s.deleteAction}>Delete</Text>
              </TouchableOpacity>
            </View>
          ))
        )}

        {/* Homework submitted for teacher review */}
        <Text style={[s.label, { marginTop: 20 }]}>Homework to review</Text>
        {homeworkQueue.length === 0 ? (
          <Text style={s.empty}>Nothing waiting for review.</Text>
        ) : (
          homeworkQueue.map((sub: any) => (
            <View key={sub.submission_id} style={s.assignmentRow}>
              <View style={{ flex: 1 }}>
                <Text style={s.assignmentTitle}>{sub.child_nickname}</Text>
                <Text style={s.assignmentMeta}>
                  {sub.worksheet_title || "Homework photo"} · {new Date(sub.submitted_at).toLocaleDateString()}
                  {sub.reviewed_at ? ` · scored ${sub.score}` : ""}
                </Text>
              </View>
              {!sub.reviewed_at && (
                <View style={{ flexDirection: "row", alignItems: "center", gap: 8 }}>
                  <TextInput
                    style={s.scoreInput}
                    placeholder="0-100"
                    keyboardType="number-pad"
                    value={scoreDrafts[sub.submission_id] || ""}
                    onChangeText={(v) => setScoreDrafts(prev => ({ ...prev, [sub.submission_id]: v }))}
                  />
                  <TouchableOpacity onPress={() => submitReview(sub.submission_id)}>
                    <Text style={s.saveScoreAction}>Save</Text>
                  </TouchableOpacity>
                </View>
              )}
            </View>
          ))
        )}
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:       { flex: 1, backgroundColor: "#f8f7ff" },
  centerRoot: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },
  emptyEmoji: { fontSize: 48, marginBottom: 12 },
  emptyText:  { fontSize: 14, color: colors.textMuted, textAlign: "center" },

  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  body:   { padding: 16, gap: 4 },

  label: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },

  subjectTab:    { paddingHorizontal: 12, paddingVertical: 8, borderRadius: 10, backgroundColor: "#f8f7ff",
                   borderWidth: 1.5, borderColor: colors.border, marginRight: 8 },
  subjectTabActive: { backgroundColor: colors.text, borderColor: colors.text },
  subjectTabText:   { fontSize: 12, fontWeight: "700", color: colors.text },
  subjectTabTextActive: { color: "white" },

  chip:       { paddingHorizontal: 14, paddingVertical: 8, borderRadius: 12, backgroundColor: "white",
                borderWidth: 1.5, borderColor: colors.border, marginRight: 8, maxWidth: 200 },
  chipActive: { backgroundColor: colors.brand, borderColor: colors.brand },
  chipText:   { fontSize: 13, fontWeight: "600", color: colors.text },
  chipTextActive: { color: "white" },

  createCard: { backgroundColor: "white", borderRadius: 14, padding: 16, gap: 4, marginBottom: 20,
                shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  createTitle:{ fontSize: 15, fontWeight: "800", color: colors.text, marginBottom: 8 },
  input:      { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                paddingHorizontal: 14, paddingVertical: 12, fontSize: 14, color: colors.text, marginBottom: 12 },
  scoreInput: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 8,
                paddingHorizontal: 10, paddingVertical: 8, fontSize: 13, color: colors.text, width: 64, textAlign: "center" },
  saveScoreAction: { fontSize: 12, fontWeight: "700", color: colors.brand },
  createBtn:  { backgroundColor: colors.brand, borderRadius: 10, paddingVertical: 12, alignItems: "center" },
  btnDim:     { opacity: 0.6 },
  createBtnText: { color: "white", fontWeight: "800", fontSize: 14 },

  empty: { fontSize: 13, color: colors.textMuted, marginBottom: 16 },

  assignmentRow: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
                   borderRadius: 12, padding: 14, marginBottom: 8,
                   shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 4, elevation: 1 },
  assignmentTitle:{ fontSize: 13, fontWeight: "700", color: colors.text },
  assignmentMeta: { fontSize: 11, color: colors.textMuted, marginTop: 2 },
  assignmentNote: { fontSize: 12, color: colors.textMuted, marginTop: 4, fontStyle: "italic" },
  deleteAction:   { fontSize: 12, fontWeight: "700", color: colors.danger, marginLeft: 12 },
});
