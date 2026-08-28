/**
 * Kid story screen — larger font, prominent read-aloud button, emoji feedback.
 */
import { useEffect, useRef, useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity, Image,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { Audio } from "expo-av";
import { useChildStore } from "../../store/childStore";
import { useTodayStory, useLogSession, useAssignments, useCompleteAssignment } from "../../hooks/useApi";
import { colors } from "../../constants/theme";
import { BookReaderModal } from "../../components/BookReaderModal";

const COVER_COLORS = ["#f97362", "#5b4fcf", "#f5a623", "#22a06b", "#3b82c4", "#c2417a"];
function coverColorFor(id: number) {
  return COVER_COLORS[id % COVER_COLORS.length];
}

export default function KidStoryScreen() {
  const { activeChild } = useChildStore();
  const grade   = activeChild?.grade_id ?? 2;
  const childId = activeChild?.child_id;

  const { data: dailyStory, isLoading, refetch } = useTodayStory(grade);
  const { mutate: logSession, isPending } = useLogSession();

  // Stories a parent assigned from the Story Library — a shelf of picks
  // that stays visible regardless of today's daily-story state, shown in
  // the order they were assigned. What differs by type is what tapping
  // the card does, handled in openBook() below.
  const { data: assignments = [] } = useAssignments(childId);
  const bookShelf = (assignments as any[])
    .filter(a => a.content_type === "mini_story")
    .sort((a, b) => new Date(a.assigned_at).getTime() - new Date(b.assigned_at).getTime());
  const { mutate: completeAssignment } = useCompleteAssignment();
  const [readerPdfUrl, setReaderPdfUrl] = useState<string | null>(null);
  const [readerAudioUrl, setReaderAudioUrl] = useState<string | null>(null);
  const [readerTitle, setReaderTitle] = useState("");
  const [selectedAssignment, setSelectedAssignment] = useState<any | null>(null);

  const openBook = (a: any) => {
    if (a.story_pdf_url) {
      setReaderPdfUrl(a.story_pdf_url);
      setReaderAudioUrl(a.story_audio_url);
      setReaderTitle(a.worksheet_title);
      return;
    }
    setSelectedAssignment(a);
    setDone(false);
  };

  // The story actually being read right now: a shelf pick the kid tapped,
  // or (by default) today's rotating mini-story.
  const story = selectedAssignment
    ? {
        story_id: `assignment-${selectedAssignment.assignment_id}`,
        title: selectedAssignment.worksheet_title,
        body_text: selectedAssignment.story_body_text,
        audio_url: selectedAssignment.story_audio_url,
        read_min: selectedAssignment.story_read_min,
        thumbnail_url: selectedAssignment.thumbnail_url,
        vocab_json: [],
      }
    : dailyStory;

  const [vocabOpen, setVocabOpen] = useState(false);
  const [done,      setDone]      = useState(false);

  const soundRef = useRef<Audio.Sound | null>(null);
  const [audioState, setAudioState] = useState<"idle" | "loading" | "playing" | "paused">("idle");

  useEffect(() => {
    // Stop and unload any playing narration when the story changes or the screen unmounts.
    return () => { soundRef.current?.unloadAsync(); soundRef.current = null; };
  }, [story?.story_id]);

  const toggleReadAloud = async () => {
    if (!story?.audio_url) return;
    if (soundRef.current) {
      const status = await soundRef.current.getStatusAsync();
      if (status.isLoaded && status.isPlaying) {
        await soundRef.current.pauseAsync();
        setAudioState("paused");
      } else {
        await soundRef.current.playAsync();
        setAudioState("playing");
      }
      return;
    }
    try {
      setAudioState("loading");
      const { sound } = await Audio.Sound.createAsync(
        { uri: story.audio_url },
        { shouldPlay: true },
        (status) => {
          if (status.isLoaded && status.didJustFinish) setAudioState("paused");
        }
      );
      soundRef.current = sound;
      setAudioState("playing");
    } catch {
      setAudioState("idle");
    }
  };

  const markRead = () => {
    if (childId) logSession({ child_id: childId, subject_id: 5, duration_min: story?.read_min ?? 5 });
    if (selectedAssignment && childId) {
      completeAssignment({ assignmentId: selectedAssignment.assignment_id, childId });
    }
    setDone(true);
  };

  const backToShelf = () => {
    setSelectedAssignment(null);
    setDone(false);
  };

  const vocab: { word: string; definition: string }[] =
    Array.isArray(story?.vocab_json) ? story.vocab_json : [];

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      {/* Stories a parent picked from the Story Library — the main event
          when present, always visible independent of today's daily-story
          state. */}
      {bookShelf.length > 0 ? (
        <View style={s.shelfSection}>
          <Text style={s.shelfTitle}>📚 Stories picked for you</Text>
          <Text style={s.shelfSub}>Stories a grown-up chose just for you.</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={s.shelfRow}>
            {bookShelf.map((a: any) => (
              <View key={a.assignment_id} style={s.shelfCard}>
                <TouchableOpacity onPress={() => openBook(a)} activeOpacity={0.85}>
                  {a.thumbnail_url ? (
                    <Image source={{ uri: a.thumbnail_url }} style={s.shelfThumb} resizeMode="cover" />
                  ) : (
                    <View style={[s.shelfThumb, s.shelfThumbGenerated, { backgroundColor: coverColorFor(a.assignment_id) }]}>
                      <Text style={s.shelfThumbEmoji}>📖</Text>
                      <Text numberOfLines={4} style={s.shelfThumbTitle}>{a.worksheet_title}</Text>
                    </View>
                  )}
                </TouchableOpacity>
                <Text numberOfLines={2} style={s.shelfCardTitle}>{a.worksheet_title}</Text>
                {a.completed_at ? (
                  <Text style={s.shelfDone}>✅ Read</Text>
                ) : childId && (
                  <TouchableOpacity onPress={() => completeAssignment({ assignmentId: a.assignment_id, childId })}>
                    <Text style={s.shelfMarkDone}>Mark as read</Text>
                  </TouchableOpacity>
                )}
              </View>
            ))}
          </ScrollView>
        </View>
      ) : (
        <View style={s.hintCard}>
          <Text style={s.hintText}>💡 Ask a grown-up to pick you a real storybook in the Story Library!</Text>
        </View>
      )}

      {selectedAssignment ? (
        <TouchableOpacity onPress={backToShelf} style={s.backRow}>
          <Text style={s.backLabel}>‹  Back to your shelf</Text>
        </TouchableOpacity>
      ) : (
        <Text style={s.dailyLabel}>✨  OR TRY TODAY'S MINI-STORY</Text>
      )}

      {isLoading ? (
        <View style={s.center}>
          <ActivityIndicator size="large" color={colors.brand} />
        </View>
      ) : done ? (
        <View style={s.center}>
          <Text style={{ fontSize: 80 }}>🎉</Text>
          <Text style={s.doneTitle}>Great reading!</Text>
          <Text style={s.doneSub}>+1 streak day 🔥</Text>
          <TouchableOpacity style={s.againBtn} onPress={() => { backToShelf(); refetch(); }}>
            <Text style={s.againBtnText}>Read another story</Text>
          </TouchableOpacity>
        </View>
      ) : !story ? (
        <View style={s.center}>
          <Text style={{ fontSize: 60 }}>📭</Text>
          <Text style={s.doneTitle}>No story today</Text>
          <TouchableOpacity style={s.againBtn} onPress={() => refetch()}>
            <Text style={s.againBtnText}>Try again</Text>
          </TouchableOpacity>
        </View>
      ) : (
        <>
          {/* Big colourful header */}
          <View style={s.header}>
            {!!story.thumbnail_url && (
              <Image source={{ uri: story.thumbnail_url }} style={s.coverChip} resizeMode="cover" />
            )}
            <Text style={s.title}>{story.title}</Text>
            <Text style={s.meta}>⏱ {story.read_min} min</Text>
            {!!story.audio_url && (
              <TouchableOpacity style={s.readAloudBtn} onPress={toggleReadAloud} activeOpacity={0.85}>
                <Text style={s.readAloudBtnText}>
                  {audioState === "loading" ? "⏳ Loading…"
                    : audioState === "playing" ? "⏸  Pause read-aloud"
                    : "🔊  Read aloud to me"}
                </Text>
              </TouchableOpacity>
            )}
          </View>

          {/* Large-text story body */}
          <View style={s.bodyCard}>
            <Text style={s.bodyText}>{story.body_text}</Text>
          </View>

          {/* Vocab */}
          {vocab.length > 0 && (
            <TouchableOpacity style={s.vocabToggle} onPress={() => setVocabOpen(o => !o)}>
              <Text style={s.vocabToggleText}>📚 New words ({vocab.length})</Text>
              <Text style={{ fontSize: 20, color: colors.brand }}>{vocabOpen ? "▲" : "▼"}</Text>
            </TouchableOpacity>
          )}
          {vocabOpen && vocab.map(v => (
            <View key={v.word} style={s.vocabRow}>
              <Text style={s.vocabWord}>{v.word}</Text>
              <Text style={s.vocabDef}>{v.definition}</Text>
            </View>
          ))}

          {/* Big "Done" button */}
          <TouchableOpacity style={s.doneBtn} onPress={markRead} disabled={isPending} activeOpacity={0.85}>
            <Text style={s.doneBtnText}>{isPending ? "Saving…" : "✅  I finished reading!"}</Text>
          </TouchableOpacity>
        </>
      )}

      <View style={{ height: 40 }} />

      <BookReaderModal
        visible={!!readerPdfUrl}
        pdfUrl={readerPdfUrl}
        audioUrl={readerAudioUrl}
        title={readerTitle}
        onClose={() => { setReaderPdfUrl(null); setReaderAudioUrl(null); }}
      />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  content: { paddingBottom: 40 },
  center:  { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },

  shelfSection: { paddingTop: 20, paddingBottom: 4 },
  shelfTitle:   { fontSize: 17, fontWeight: "900", color: colors.text, marginLeft: 16 },
  shelfSub:     { fontSize: 13, color: colors.textMuted, marginLeft: 16, marginTop: 2, marginBottom: 12 },
  shelfRow:     { paddingHorizontal: 16, gap: 14 },
  shelfCard:    { width: 130 },
  shelfThumb:   { width: 130, height: 170, borderRadius: 14, backgroundColor: "#e5e7eb",
                  shadowColor: "#000", shadowOpacity: 0.1, shadowRadius: 6, elevation: 2 },
  shelfThumbGenerated: { padding: 12, justifyContent: "flex-end" },
  shelfThumbEmoji: { fontSize: 22, marginBottom: 6 },
  shelfThumbTitle: { fontSize: 13, fontWeight: "900", color: "white", lineHeight: 17 },
  shelfCardTitle: { fontSize: 13, fontWeight: "700", color: colors.text, marginTop: 8, minHeight: 34 },
  shelfDone:      { fontSize: 12, fontWeight: "700", color: colors.success },
  shelfMarkDone:  { fontSize: 12, fontWeight: "700", color: colors.brand },

  hintCard: { margin: 16, marginTop: 20, backgroundColor: colors.brandLight, borderRadius: 14, padding: 16 },
  hintText: { fontSize: 14, color: colors.brand, fontWeight: "700", textAlign: "center", lineHeight: 20 },
  dailyLabel: { fontSize: 12, fontWeight: "800", color: colors.textMuted, letterSpacing: 1,
                marginLeft: 16, marginTop: 8, marginBottom: 4 },
  backRow:   { marginLeft: 16, marginTop: 12, marginBottom: 4 },
  backLabel: { fontSize: 14, fontWeight: "800", color: colors.brand },
  coverChip: { width: 56, height: 56, borderRadius: 12, marginBottom: 12, backgroundColor: "rgba(255,255,255,0.3)" },

  header:  { backgroundColor: colors.brand, paddingTop: Platform.OS === "ios" ? 60 : 28,
             paddingBottom: 32, paddingHorizontal: 24 },
  eyebrow: { fontSize: 12, fontWeight: "800", color: "rgba(255,255,255,0.7)", letterSpacing: 1.5, marginBottom: 10 },
  title:   { fontSize: 30, fontWeight: "900", color: "white", lineHeight: 40, marginBottom: 10 },
  meta:    { fontSize: 15, color: "rgba(255,255,255,0.8)" },
  readAloudBtn:     { marginTop: 18, backgroundColor: "rgba(255,255,255,0.2)", borderRadius: 16,
                      paddingVertical: 14, alignItems: "center", borderWidth: 2, borderColor: "rgba(255,255,255,0.5)" },
  readAloudBtnText: { color: "white", fontWeight: "900", fontSize: 17 },

  bodyCard: { margin: 16, backgroundColor: "white", borderRadius: 20, padding: 24,
              shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 10, elevation: 2 },
  thumbImage: { width: "100%", height: 220, borderRadius: 16, marginBottom: 18, backgroundColor: "#f0f0f0" },
  bodyText: { fontSize: 20, lineHeight: 34, color: colors.text },

  vocabToggle:    { marginHorizontal: 16, marginTop: 12, backgroundColor: colors.brandLight, borderRadius: 14,
                    padding: 16, flexDirection: "row", justifyContent: "space-between", alignItems: "center" },
  vocabToggleText:{ fontWeight: "800", color: colors.brand, fontSize: 17 },
  vocabRow:       { marginHorizontal: 16, marginTop: 8, backgroundColor: "white", borderRadius: 12,
                    padding: 16, borderLeftWidth: 4, borderLeftColor: colors.brand },
  vocabWord:      { fontSize: 18, fontWeight: "900", color: colors.text },
  vocabDef:       { fontSize: 15, color: colors.textMuted, marginTop: 4, lineHeight: 22 },

  doneBtn:     { marginHorizontal: 20, marginTop: 24, backgroundColor: colors.success,
                 borderRadius: 20, paddingVertical: 22, alignItems: "center" },
  doneBtnText: { color: "white", fontWeight: "900", fontSize: 20 },

  doneTitle: { fontSize: 30, fontWeight: "900", color: colors.text, textAlign: "center", marginTop: 16 },
  doneSub:   { fontSize: 22, color: colors.brand, fontWeight: "800", marginTop: 8 },
  againBtn:  { marginTop: 24, backgroundColor: colors.brand, borderRadius: 16,
               paddingHorizontal: 32, paddingVertical: 16 },
  againBtnText: { color: "white", fontWeight: "800", fontSize: 18 },
});
