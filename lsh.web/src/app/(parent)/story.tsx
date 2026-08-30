/**
 * Story tab — full mini-story library (Audible-style cover grid, hover to
 * preview) plus today's rotating pick. Parents assign straight from the
 * grid; each card shows whether it's already been given to the active
 * child, how long ago, and whether the kid has finished it.
 */
import { useEffect, useRef, useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity, Image, Linking,
  StyleSheet, ActivityIndicator, Platform, Alert,
} from "react-native";
import { Audio } from "expo-av";
import { useChildStore } from "../../store/childStore";
import { useTodayStory, useLogSession, useStoriesLibrary, useAssignStory } from "../../hooks/useApi";
import { useChildren }    from "../../hooks/useChildren";
import { Button }        from "../../components/ui/Button";
import { colors }        from "../../constants/theme";

const COVER_COLORS = ["#f97362", "#5b4fcf", "#f5a623", "#22a06b", "#3b82c4", "#c2417a"];

function coverColorFor(id: number) {
  return COVER_COLORS[id % COVER_COLORS.length];
}

function timeAgo(dateStr: string | null | undefined): string {
  if (!dateStr) return "";
  const then = new Date(dateStr).getTime();
  const diffMs = Date.now() - then;
  const mins = Math.floor(diffMs / 60000);
  if (mins < 1) return "just now";
  if (mins < 60) return `${mins} min${mins === 1 ? "" : "s"} ago`;
  const hours = Math.floor(mins / 60);
  if (hours < 24) return `${hours} hour${hours === 1 ? "" : "s"} ago`;
  const days = Math.floor(hours / 24);
  if (days < 30) return `${days} day${days === 1 ? "" : "s"} ago`;
  const months = Math.floor(days / 30);
  return `${months} month${months === 1 ? "" : "s"} ago`;
}

/** A book-style cover: real thumbnail if we have one, otherwise a
 * generated color block with the title — every card reads as a book
 * either way, none look "broken". */
function StoryCover({ item, hovered }: { item: any; hovered: boolean }) {
  if (item.thumbnail_url) {
    return (
      <View style={s.cover}>
        <Image source={{ uri: item.thumbnail_url }} style={s.coverImg} resizeMode="cover" />
        {hovered && <View style={s.coverHoverDim} />}
      </View>
    );
  }
  return (
    <View style={[s.cover, s.coverGenerated, { backgroundColor: coverColorFor(item.story_id) }]}>
      <Text style={s.coverEmoji}>📖</Text>
      <Text style={s.coverTitle} numberOfLines={4}>{item.title}</Text>
      {hovered && <View style={s.coverHoverDim} />}
    </View>
  );
}

export default function StoryScreen() {
  const { activeChild } = useChildStore();
  const grade   = activeChild?.grade_id ?? 2;
  const childId = activeChild?.child_id;

  const { data: story, isLoading, refetch } = useTodayStory(grade);
  const { mutate: logSession, isPending: logging } = useLogSession();

  const { data: children = [] } = useChildren();
  const [assignToId, setAssignToId] = useState<number | undefined>(undefined);
  const assignTargetId = assignToId ?? childId;
  const assignTargetChild = (children as any[]).find(c => c.child_id === assignTargetId) ?? activeChild;

  const { data: library = [], isLoading: libraryLoading } = useStoriesLibrary(grade, assignTargetId);
  const { mutate: assignStory, isPending: assigningStory } = useAssignStory();

  const assignFromLibrary = (storyId: number, title: string) => {
    if (!assignTargetId) return;
    assignStory(
      { childId: assignTargetId, storyId },
      {
        onSuccess: () => Alert.alert("Assigned!", `"${title}" was added to ${assignTargetChild?.nickname}'s story shelf.`),
        onError: (e: any) => Alert.alert("Couldn't assign", e.message),
      }
    );
  };

  // Hover-to-preview: one shared player for whichever card is being previewed.
  const [hoveredId, setHoveredId] = useState<number | null>(null);
  const previewSoundRef = useRef<Audio.Sound | null>(null);
  const [previewingId, setPreviewingId] = useState<number | null>(null);

  useEffect(() => {
    return () => { previewSoundRef.current?.unloadAsync(); previewSoundRef.current = null; };
  }, []);

  const togglePreview = async (item: any) => {
    if (!item.audio_url) return;
    if (previewingId === item.story_id && previewSoundRef.current) {
      await previewSoundRef.current.stopAsync();
      await previewSoundRef.current.unloadAsync();
      previewSoundRef.current = null;
      setPreviewingId(null);
      return;
    }
    if (previewSoundRef.current) {
      await previewSoundRef.current.stopAsync();
      await previewSoundRef.current.unloadAsync();
      previewSoundRef.current = null;
    }
    const { sound } = await Audio.Sound.createAsync(
      { uri: item.audio_url },
      { shouldPlay: true },
      (status) => { if (status.isLoaded && status.didJustFinish) setPreviewingId(null); }
    );
    previewSoundRef.current = sound;
    setPreviewingId(item.story_id);
  };

  const [vocabOpen,  setVocabOpen]  = useState(false);
  const [readDone,   setReadDone]   = useState(false);

  const soundRef = useRef<Audio.Sound | null>(null);
  const [audioState, setAudioState] = useState<"idle" | "loading" | "playing" | "paused">("idle");

  useEffect(() => {
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
    if (childId) {
      logSession({ child_id: childId, subject_id: 5, duration_min: story?.read_min ?? 5 });
    }
    setReadDone(true);
  };

  const vocab: { word: string; definition: string }[] =
    Array.isArray(story?.vocab_json) ? story.vocab_json : [];

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      {/* Mini-Story Library — every story, Audible-style */}
      <View style={s.libraryHeader}>
        <Text style={s.libraryTitle}>📖 Story Library</Text>
        <Text style={s.librarySub}>Hover a cover to preview the narration, then assign it.</Text>

        {children.length > 1 && (
          <View style={s.childPickerRow}>
            <Text style={s.childPickerLabel}>Assign to:</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false}>
              {(children as any[]).map(c => (
                <TouchableOpacity
                  key={c.child_id}
                  style={[s.childChip, assignTargetId === c.child_id && s.childChipActive]}
                  onPress={() => setAssignToId(c.child_id)}
                >
                  <Text style={[s.childChipText, assignTargetId === c.child_id && s.childChipTextActive]}>
                    {c.nickname}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>
          </View>
        )}
      </View>

      {libraryLoading ? (
        <ActivityIndicator style={{ marginVertical: 20 }} color={colors.brand} />
      ) : (
        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={s.shelfRow}>
          {library.map((item: any) => {
            // @ts-ignore — web-only hover events, pass through cleanly on native (no-op)
            const hoverProps = Platform.OS === "web" ? {
              onMouseEnter: () => setHoveredId(item.story_id),
              onMouseLeave: () => setHoveredId(null),
            } : {};
            const hovered = hoveredId === item.story_id;
            const isPreviewing = previewingId === item.story_id;
            return (
              <View key={item.story_id} style={s.card} {...hoverProps}>
                <TouchableOpacity onPress={() => togglePreview(item)} activeOpacity={0.9}>
                  <StoryCover item={item} hovered={hovered} />
                  {(hovered || isPreviewing) && !!item.audio_url && (
                    <View style={s.playOverlay}>
                      <Text style={s.playIcon}>{isPreviewing ? "⏸" : "▶"}</Text>
                    </View>
                  )}
                </TouchableOpacity>

                <Text numberOfLines={2} style={s.cardTitle}>{item.title}</Text>
                <Text style={s.cardMeta}>⏱ {item.read_min} min</Text>

                {item.current_assignment_id ? (
                  <View style={s.assignedFlag}>
                    <Text style={s.assignedFlagText}>
                      {item.current_completed_at ? "✅ Completed" : "📌 Assigned"} {timeAgo(item.current_assigned_at)}
                    </Text>
                  </View>
                ) : null}
                {item.times_assigned > 0 && (
                  <Text style={s.timesAssigned}>Given {item.times_assigned}× before</Text>
                )}

                {!!item.pdf_url && (
                  <TouchableOpacity onPress={() => Linking.openURL(item.pdf_url)}>
                    <Text style={s.viewPdfLink}>📄 View original PDF</Text>
                  </TouchableOpacity>
                )}

                <TouchableOpacity
                  style={[s.assignBtn, assigningStory && s.btnDim]}
                  disabled={assigningStory || !assignTargetId}
                  onPress={() => assignFromLibrary(item.story_id, item.title)}
                >
                  <Text style={s.assignBtnText}>
                    {item.current_assignment_id ? "Assign again" : `Assign to ${assignTargetChild?.nickname ?? "child"}`}
                  </Text>
                </TouchableOpacity>
              </View>
            );
          })}
        </ScrollView>
      )}

      {isLoading ? (
        <View style={s.center}>
          <ActivityIndicator size="large" color={colors.brand} />
        </View>
      ) : !story ? (
        <View style={s.center}>
          <Text style={{ fontSize: 48 }}>📭</Text>
          <Text style={s.emptyTitle}>No story today</Text>
          <Button label="Refresh" onPress={() => refetch()} style={{ marginTop: 16 }} />
        </View>
      ) : (
        <>
          {/* Header */}
          <View style={s.header}>
            <Text style={s.eyebrow}>✨  OR TRY TODAY'S PICK</Text>
            <Text style={s.title}>{story.title}</Text>
            <View style={s.metaRow}>
              {story.read_min && <Text style={s.meta}>⏱ {story.read_min} min</Text>}
              {story.theme_tag && <Text style={s.meta}>🏷 {story.theme_tag}</Text>}
              {story.grade_id != null && <Text style={s.meta}>📚 Grade {story.grade_id}</Text>}
            </View>
            {!!story.audio_url && (
              <TouchableOpacity style={s.readAloudBtn} onPress={toggleReadAloud} activeOpacity={0.85}>
                <Text style={s.readAloudBtnText}>
                  {audioState === "loading" ? "⏳ Loading…"
                    : audioState === "playing" ? "⏸  Pause read-aloud"
                    : "🔊  Read aloud"}
                </Text>
              </TouchableOpacity>
            )}
          </View>

          {/* Story body */}
          <View style={s.bodyCard}>
            {!!story.thumbnail_url && (
              <Image source={{ uri: story.thumbnail_url }} style={s.thumbImage} resizeMode="cover" />
            )}
            <Text style={s.bodyText}>{story.body_text}</Text>
            {!!story.source_attribution && (
              <Text style={s.attribution}>{story.source_attribution}</Text>
            )}
          </View>

          {/* Vocabulary section */}
          {vocab.length > 0 && (
            <TouchableOpacity style={s.vocabToggle} onPress={() => setVocabOpen(o => !o)}>
              <Text style={s.vocabToggleText}>📚 Vocabulary words ({vocab.length})</Text>
              <Text style={s.vocabArrow}>{vocabOpen ? "▲" : "▼"}</Text>
            </TouchableOpacity>
          )}
          {vocabOpen && vocab.map(v => (
            <View key={v.word} style={s.vocabRow}>
              <Text style={s.vocabWord}>{v.word}</Text>
              <Text style={s.vocabDef}>{v.definition}</Text>
            </View>
          ))}

          {/* Mark as read */}
          {!readDone ? (
            <Button
              label={logging ? "Saving…" : "✅  Mark as read (+streak)"}
              onPress={markRead}
              loading={logging}
              fullWidth
              style={{ marginTop: 24 }}
            />
          ) : (
            <View style={s.doneRow}>
              <Text style={s.doneText}>🎉 Great reading today!</Text>
              <Button label="Read another" onPress={() => { setReadDone(false); refetch(); }}
                variant="outline" style={{ marginTop: 12 }} />
            </View>
          )}

          {/* Discussion prompts */}
          <View style={s.promptCard}>
            <Text style={s.promptTitle}>💬 Talk about it</Text>
            {[
              "What was your favorite part of the story?",
              "What would you have done differently?",
              "What does this story teach us?",
            ].map(q => (
              <Text key={q} style={s.promptQ}>• {q}</Text>
            ))}
          </View>
        </>
      )}

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  content: { paddingBottom: 40 },
  center:  { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },

  libraryHeader: { paddingHorizontal: 16, paddingTop: 20, paddingBottom: 4 },
  libraryTitle: { fontSize: 19, fontWeight: "900", color: colors.text },
  librarySub:   { fontSize: 12, color: colors.textMuted, marginTop: 4 },
  childPickerRow:  { flexDirection: "row", alignItems: "center", marginTop: 10 },
  childPickerLabel:{ fontSize: 12, fontWeight: "700", color: colors.textMuted, marginRight: 8 },
  childChip:       { borderWidth: 1.5, borderColor: colors.border, borderRadius: 16,
                     paddingHorizontal: 12, paddingVertical: 6, marginRight: 8, backgroundColor: "white" },
  childChipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  childChipText:   { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  childChipTextActive: { color: colors.brand },
  viewPdfLink: { fontSize: 11, fontWeight: "700", color: colors.brand, marginTop: 6 },

  shelfRow: { paddingHorizontal: 16, paddingVertical: 14, gap: 14 },
  card:     { width: 150 },

  cover:    { width: 150, height: 190, borderRadius: 14, overflow: "hidden",
              shadowColor: "#000", shadowOpacity: 0.12, shadowRadius: 8, elevation: 3 },
  coverImg: { width: "100%", height: "100%" },
  coverGenerated: { padding: 14, justifyContent: "flex-end" },
  coverEmoji: { fontSize: 26, marginBottom: 8 },
  coverTitle: { fontSize: 14, fontWeight: "900", color: "white", lineHeight: 18 },
  coverHoverDim: { ...StyleSheet.absoluteFillObject, backgroundColor: "rgba(0,0,0,0.25)" },

  playOverlay: { position: "absolute", top: 0, left: 0, right: 0, bottom: 0,
                 alignItems: "center", justifyContent: "center" },
  playIcon: { fontSize: 40, color: "white" },

  cardTitle: { fontSize: 13, fontWeight: "800", color: colors.text, marginTop: 8, minHeight: 34 },
  cardMeta:  { fontSize: 11, color: colors.textMuted, marginTop: 2 },

  assignedFlag: { backgroundColor: colors.brandLight, borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3,
                  marginTop: 6, alignSelf: "flex-start" },
  assignedFlagText: { fontSize: 10, fontWeight: "700", color: colors.brand },
  timesAssigned: { fontSize: 10, color: colors.textMuted, marginTop: 4 },

  assignBtn: { backgroundColor: colors.brand, borderRadius: 8, paddingVertical: 8, alignItems: "center", marginTop: 8 },
  assignBtnText: { color: "white", fontWeight: "800", fontSize: 12 },
  btnDim: { opacity: 0.6 },

  header:  { backgroundColor: colors.brand, paddingTop: 20,
             paddingBottom: 28, paddingHorizontal: 24, marginTop: 12 },
  eyebrow: { fontSize: 11, fontWeight: "800", color: "rgba(255,255,255,0.7)", letterSpacing: 1.5, marginBottom: 8 },
  title:   { fontSize: 26, fontWeight: "900", color: "white", lineHeight: 34, marginBottom: 12 },
  metaRow: { flexDirection: "row", gap: 10 },
  meta:    { fontSize: 12, color: "rgba(255,255,255,0.75)", fontWeight: "600",
             backgroundColor: "rgba(255,255,255,0.15)", borderRadius: 8, paddingHorizontal: 10, paddingVertical: 4 },
  readAloudBtn:     { marginTop: 16, backgroundColor: "rgba(255,255,255,0.2)", borderRadius: 14,
                      paddingVertical: 12, alignItems: "center", borderWidth: 2, borderColor: "rgba(255,255,255,0.5)" },
  readAloudBtnText: { color: "white", fontWeight: "800", fontSize: 15 },

  bodyCard: { margin: 16, backgroundColor: "white", borderRadius: 16, padding: 22,
              shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 10, elevation: 2 },
  thumbImage: { width: "100%", height: 200, borderRadius: 12, marginBottom: 16, backgroundColor: colors.surfaceAlt },
  bodyText: { fontSize: 17, lineHeight: 30, color: colors.text, fontFamily: "Georgia" },
  attribution: { fontSize: 12, color: colors.textMuted, marginTop: 16, fontStyle: "italic" },

  vocabToggle:     { marginHorizontal: 16, backgroundColor: colors.brandLight, borderRadius: 12,
                     padding: 14, flexDirection: "row", justifyContent: "space-between", alignItems: "center" },
  vocabToggleText: { fontWeight: "700", color: colors.brand, fontSize: 15 },
  vocabArrow:      { color: colors.brand, fontSize: 16 },
  vocabRow:        { marginHorizontal: 16, marginTop: 8, backgroundColor: "white", borderRadius: 10,
                     padding: 14, borderLeftWidth: 3, borderLeftColor: colors.brand },
  vocabWord:       { fontSize: 16, fontWeight: "800", color: colors.text },
  vocabDef:        { fontSize: 14, color: colors.textMuted, marginTop: 4 },

  doneRow:  { marginHorizontal: 16, marginTop: 24, alignItems: "center" },
  doneText: { fontSize: 20, fontWeight: "900", color: colors.success },

  promptCard:  { margin: 16, marginTop: 20, backgroundColor: colors.surfaceAlt, borderRadius: 14, padding: 18 },
  promptTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginBottom: 10 },
  promptQ:     { fontSize: 14, color: colors.textMuted, lineHeight: 24 },

  emptyTitle: { fontSize: 20, fontWeight: "800", color: colors.text, marginTop: 12 },
});
