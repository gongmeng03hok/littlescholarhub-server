/**
 * Public "play a sample" screen — lets a visitor try a worksheet with no
 * account. Rewards are simply skipped (no childId).
 *
 * Three shapes of content arrive here:
 *   • demonstrations        → ArtDemo (art, coloring, mini-books, space images)
 *   • reading + a story     → read the story first, then answer about it
 *   • plain quiz worksheets → WorksheetPlayer
 *
 * The demo split matters: /questions/generate has no generator for art, story,
 * workbooks, solar_system, science or writing, and silently answers with MATH.
 * That is how "Animals Art - Grade 2nd" opened a money-counting quiz. The API
 * marks the distinction with `is_demo` so both clients agree.
 */
import { track, useTrackView } from "../../utils/track";
import { useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet, ActivityIndicator } from "react-native";
import { useLocalSearchParams, useRouter } from "expo-router";
import { useQuestions, useWorksheet } from "../../hooks/useApi";
import { WorksheetPlayer } from "../../components/WorksheetPlayer";
import { ArtDemo } from "../../components/ArtDemo";
import { StoryBlock } from "../../components/StoryBlock";
import { colors, SUBJECT_META } from "../../constants/theme";

const DEMO_CONTENT_TYPES = ["coloring", "space_image", "mini_book", "iacl_book"];
const NO_QUESTION_SUBJECTS = ["art", "story", "workbooks", "solar_system", "science", "writing"];

export default function SampleScreen() {
  useTrackView("sample_view");
  const router = useRouter();
  const { subject, grade, title, id } = useLocalSearchParams<{
    subject: string; grade: string; title: string; id?: string;
  }>();

  const subj    = subject ?? "math";
  const gradeId = parseInt(grade ?? "2", 10);
  const meta    = SUBJECT_META[subj];
  const wsId    = id ? parseInt(id, 10) : undefined;

  const { data: worksheet, isLoading: wsLoading } = useWorksheet(wsId);

  const isDemo = worksheet
    ? (worksheet.is_demo ??
       (DEMO_CONTENT_TYPES.includes(worksheet.content_type) ||
        NO_QUESTION_SUBJECTS.includes(worksheet.subject)))
    : NO_QUESTION_SUBJECTS.includes(subj);

  // A "<Theme> Reading" worksheet is a quiz *about* a story. Show the story
  // first — answering comprehension questions about a text you were never given
  // is the mismatch this screen exists to prevent.
  const story    = !isDemo ? worksheet?.story : null;
  const [reading, setReading] = useState(true);

  // Questions written for THIS story beat the generic pool. Without this a
  // child reads about Sam the cat and is then asked about a puppy.
  const storyQuestions = (story?.questions ?? []).map((q: any) => ({
    question_text: q.q,
    correct_answer: q.answer,
    options: q.options,
    hint: null,
  }));

  const { data: generated = [], isLoading: qLoading } =
    useQuestions(subj, gradeId, 5, {
      enabled: !wsLoading && !isDemo && storyQuestions.length === 0,
      theme: worksheet?.interest_tag ?? "",
      // The skill the title promises. Without it "Beginning Sounds: S, M, T"
      // drew from the generic phonics pool and served medial vowels.
      skill: worksheet?.skill_key ?? "",
    });

  const questions = storyQuestions.length ? storyQuestions : generated;

  const goBack = () => (router.canGoBack() ? router.back() : router.replace("/"));
  const heading = title || `${meta?.icon ?? ""} ${meta?.label ?? subj}`.trim();

  if (wsLoading || (!isDemo && qLoading && !story?.questions?.length)) {
    return (
      <View style={s.center}>
        <Text style={{ fontSize: 60, marginBottom: 16 }}>⏳</Text>
        <ActivityIndicator size="large" color={colors.brand} />
        <Text style={s.loading}>Loading your sample…</Text>
      </View>
    );
  }

  if (isDemo) {
    // Without an id we still have the title from the link, which is enough to
    // render a valid (if sparse) demonstration rather than the wrong quiz.
    return (
      <ArtDemo
        worksheet={worksheet ?? { title: title || meta?.label || "Activity" }}
        onExit={goBack}
      />
    );
  }

  if (story && reading) {
    return (
      <View style={s.root}>
        <View style={s.header}>
          <TouchableOpacity onPress={goBack} style={s.back} accessibilityRole="button"
            accessibilityLabel="Go back">
            <Text style={s.backText}>←</Text>
          </TouchableOpacity>
          <Text style={s.headerTitle}>{heading}</Text>
        </View>
        <ScrollView contentContainerStyle={s.scroll}>
          <StoryBlock story={story} />
          <TouchableOpacity
            style={s.next}
            accessibilityRole="button"
            onPress={() => setReading(false)}
            activeOpacity={0.85}
          >
            <Text style={s.nextText}>I've read it — ask me the questions →</Text>
          </TouchableOpacity>
        </ScrollView>
      </View>
    );
  }

  return (
    <WorksheetPlayer
      questions={questions}
      headerTitle={heading}
      onExit={story ? () => setReading(true) : goBack}
    />
  );
}

const s = StyleSheet.create({
  center:  { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, backgroundColor: "#f8f7ff" },
  loading: { marginTop: 14, fontSize: 16, fontWeight: "700", color: colors.textMuted },

  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { backgroundColor: colors.brand, paddingTop: 56, paddingBottom: 18, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center" },
  back:   { marginRight: 12 },
  backText: { fontSize: 28, color: "white", fontWeight: "700" },
  // No numberOfLines: a long worksheet title wraps rather than being chopped.
  headerTitle: { flex: 1, fontSize: 20, fontWeight: "900", color: "white" },

  scroll: { padding: 18, paddingBottom: 48 },
  next:   { marginTop: 18, backgroundColor: colors.brand, borderRadius: 16,
            paddingVertical: 16, alignItems: "center" },
  nextText: { color: "white", fontSize: 16, fontWeight: "900" },
});
