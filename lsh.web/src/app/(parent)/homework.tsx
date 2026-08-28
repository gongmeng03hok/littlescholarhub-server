import { useState, useMemo } from "react";
import {
  View, Text, TouchableOpacity, ScrollView, Image,
  StyleSheet, ActivityIndicator, Alert, Platform,
} from "react-native";
import * as ImagePicker from "expo-image-picker";
import { useChildStore } from "../../store/childStore";
import { useAssignments } from "../../hooks/useApi";
import { useUploadHomeworkPhoto, useCreateHomeworkSubmission, useAiGradeSubmission } from "../../hooks/useHomework";
import { MiniGame } from "../../components/MiniGame";
import { colors } from "../../constants/theme";

export default function HomeworkScanner() {
  const { activeChild } = useChildStore();
  const { data: assignments = [] } = useAssignments(activeChild?.child_id);

  const classroomOptions = useMemo(() => {
    const seen = new Map<number, string>();
    for (const a of assignments as any[]) seen.set(a.classroom_id, a.classroom_name);
    return Array.from(seen, ([classroom_id, classroom_name]) => ({ classroom_id, classroom_name }));
  }, [assignments]);

  const { mutateAsync: uploadPhoto, isPending: uploading } = useUploadHomeworkPhoto();
  const { mutateAsync: createSubmission, isPending: submitting } = useCreateHomeworkSubmission();
  const { mutateAsync: aiGrade, isPending: grading } = useAiGradeSubmission();

  const [imageUri, setImageUri] = useState<string | null>(null);
  const [mode, setMode] = useState<"ai" | "teacher">("ai");
  const [classroomId, setClassroomId] = useState<number | undefined>(undefined);
  const [result, setResult] = useState<{ score: number; feedback: any } | null>(null);
  const [submittedForReview, setSubmittedForReview] = useState(false);
  const [showMiniGame, setShowMiniGame] = useState(false);

  const pickImage = async (fromCamera: boolean) => {
    const perm = fromCamera
      ? await ImagePicker.requestCameraPermissionsAsync()
      : await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) {
      Alert.alert("Permission needed", "Please allow access to continue.");
      return;
    }
    const result = fromCamera
      ? await ImagePicker.launchCameraAsync({ quality: 0.7 })
      : await ImagePicker.launchImageLibraryAsync({ mediaTypes: ["images"], quality: 0.7 });
    if (!result.canceled && result.assets?.[0]) {
      setImageUri(result.assets[0].uri);
      setResult(null);
      setSubmittedForReview(false);
    }
  };

  const submit = async () => {
    if (!activeChild || !imageUri) return;
    if (mode === "teacher" && !classroomId) {
      Alert.alert("Please choose a classroom to send this to your teacher.");
      return;
    }
    try {
      const uploaded = await uploadPhoto({
        uri: imageUri,
        name: `homework-${Date.now()}.jpg`,
        type: "image/jpeg",
      });
      const submission = await createSubmission({
        child_id: activeChild.child_id,
        image_file_id: uploaded.file_id,
        mode,
        classroom_id: mode === "teacher" ? classroomId : undefined,
      });
      if (mode === "ai") {
        const graded = await aiGrade(submission.submission_id);
        setResult({ score: graded.score, feedback: graded.feedback });
      } else {
        setSubmittedForReview(true);
      }
    } catch (e: any) {
      Alert.alert("Something went wrong", e.message);
    }
  };

  const busy = uploading || submitting || grading;

  if (!activeChild) {
    return (
      <View style={s.centerRoot}>
        <Text style={s.emptyText}>Select a child to scan homework.</Text>
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>📸 Homework Scanner</Text>
        <Text style={s.count}>for {activeChild.nickname}</Text>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {imageUri ? (
          <Image source={{ uri: imageUri }} style={s.preview} resizeMode="contain" />
        ) : (
          <View style={s.placeholder}>
            <Text style={s.placeholderEmoji}>🧾</Text>
            <Text style={s.placeholderText}>Take or choose a photo of finished homework</Text>
          </View>
        )}

        <View style={s.pickRow}>
          <TouchableOpacity style={s.pickBtn} onPress={() => pickImage(true)}>
            <Text style={s.pickBtnText}>📷 Camera</Text>
          </TouchableOpacity>
          <TouchableOpacity style={s.pickBtn} onPress={() => pickImage(false)}>
            <Text style={s.pickBtnText}>🖼️ Library</Text>
          </TouchableOpacity>
        </View>

        {imageUri && !result && !submittedForReview && (
          <>
            <Text style={s.label}>Check with</Text>
            <View style={s.modeRow}>
              <TouchableOpacity style={[s.modeChip, mode === "ai" && s.modeChipActive]} onPress={() => setMode("ai")}>
                <Text style={[s.modeChipText, mode === "ai" && s.modeChipTextActive]}>Instant AI check</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={[s.modeChip, mode === "teacher" && s.modeChipActive, classroomOptions.length === 0 && s.modeChipDisabled]}
                onPress={() => classroomOptions.length > 0 && setMode("teacher")}
              >
                <Text style={[s.modeChipText, mode === "teacher" && s.modeChipTextActive]}>Send to teacher</Text>
              </TouchableOpacity>
            </View>

            {mode === "teacher" && classroomOptions.length > 0 && (
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 12 }}>
                {classroomOptions.map(c => (
                  <TouchableOpacity
                    key={c.classroom_id}
                    style={[s.chip, classroomId === c.classroom_id && s.chipActive]}
                    onPress={() => setClassroomId(c.classroom_id)}
                  >
                    <Text style={[s.chipText, classroomId === c.classroom_id && s.chipTextActive]}>{c.classroom_name}</Text>
                  </TouchableOpacity>
                ))}
              </ScrollView>
            )}

            <TouchableOpacity style={[s.submitBtn, busy && s.btnDim]} onPress={submit} disabled={busy}>
              <Text style={s.submitBtnText}>{busy ? "Working…" : "Submit"}</Text>
            </TouchableOpacity>
          </>
        )}

        {result && (
          <View style={s.resultCard}>
            <Text style={s.resultScore}>{result.score}/100</Text>
            <Text style={s.resultMessage}>{result.feedback?.message}</Text>
            <Text style={s.resultDisclaimer}>
              This is an automated estimate, not a real teacher review — {" "}
              use "Send to teacher" for an actual grade.
            </Text>
          </View>
        )}

        {submittedForReview && (
          <View style={s.resultCard}>
            <Text style={s.resultMessage}>Sent to your teacher for review — check back later for feedback.</Text>
          </View>
        )}

        {(result || submittedForReview) && !showMiniGame && (
          <TouchableOpacity style={s.miniGameBtn} onPress={() => setShowMiniGame(true)}>
            <Text style={s.miniGameBtnText}>🎮 Play a quick mini-game while you wait</Text>
          </TouchableOpacity>
        )}

        {showMiniGame && (
          <MiniGame
            subject="math"
            grade={activeChild.grade_id}
            childId={activeChild.child_id}
            onExit={() => setShowMiniGame(false)}
          />
        )}
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:       { flex: 1, backgroundColor: "#f8f7ff" },
  centerRoot: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },
  emptyText:  { fontSize: 14, color: colors.textMuted, textAlign: "center" },

  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  count:  { fontSize: 13, color: colors.textMuted, fontWeight: "600", marginTop: 2 },
  body:   { padding: 16, gap: 12 },

  preview:     { width: "100%", height: 260, borderRadius: 14, backgroundColor: "#eee" },
  placeholder: { height: 200, borderRadius: 14, backgroundColor: "white", borderWidth: 1.5,
                 borderColor: colors.border, borderStyle: "dashed",
                 justifyContent: "center", alignItems: "center" },
  placeholderEmoji: { fontSize: 40, marginBottom: 8 },
  placeholderText:  { fontSize: 13, color: colors.textMuted, textAlign: "center", paddingHorizontal: 24 },

  pickRow: { flexDirection: "row", gap: 10 },
  pickBtn: { flex: 1, backgroundColor: "white", borderRadius: 10, paddingVertical: 12,
             alignItems: "center", borderWidth: 1.5, borderColor: colors.border },
  pickBtnText: { fontSize: 14, fontWeight: "700", color: colors.text },

  label: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginTop: 4 },
  modeRow: { flexDirection: "row", gap: 8, marginBottom: 4 },
  modeChip: { flex: 1, paddingVertical: 10, borderRadius: 10, backgroundColor: "white",
              borderWidth: 1.5, borderColor: colors.border, alignItems: "center" },
  modeChipActive: { backgroundColor: colors.brand, borderColor: colors.brand },
  modeChipDisabled: { opacity: 0.4 },
  modeChipText: { fontSize: 13, fontWeight: "700", color: colors.text },
  modeChipTextActive: { color: "white" },

  chip:       { paddingHorizontal: 14, paddingVertical: 8, borderRadius: 12, backgroundColor: "white",
                borderWidth: 1.5, borderColor: colors.border, marginRight: 8 },
  chipActive: { backgroundColor: colors.brand, borderColor: colors.brand },
  chipText:   { fontSize: 13, fontWeight: "600", color: colors.text },
  chipTextActive: { color: "white" },

  submitBtn:  { backgroundColor: colors.brand, borderRadius: 10, paddingVertical: 14, alignItems: "center" },
  btnDim:     { opacity: 0.6 },
  submitBtnText: { color: "white", fontWeight: "800", fontSize: 15 },

  resultCard: { backgroundColor: "white", borderRadius: 14, padding: 20, alignItems: "center", gap: 8,
                shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  resultScore: { fontSize: 32, fontWeight: "900", color: colors.brand },
  resultMessage: { fontSize: 14, color: colors.text, textAlign: "center" },
  resultDisclaimer: { fontSize: 11, color: colors.textMuted, textAlign: "center" },

  miniGameBtn: { backgroundColor: colors.brandLight, borderRadius: 12, paddingVertical: 14, alignItems: "center" },
  miniGameBtnText: { fontSize: 14, fontWeight: "800", color: colors.brand },
});
