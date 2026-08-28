/**
 * StoryBlock — the readable story attached to a worksheet.
 *
 * Shared by two screens because two different kinds of worksheet carry a story:
 *   • demonstrations (ArtDemo) — the story sits above the printable;
 *   • "<Theme> Reading - Grade N" quizzes — the child reads first, then answers.
 *
 * Keeping it in one place stops the two from drifting, which is how the catalog
 * got into trouble in the first place.
 */
import { useState } from "react";
import { View, Text, Image, StyleSheet, type ViewStyle } from "react-native";
import { colors } from "../constants/theme";
import { SpeakButton } from "./SpeakButton";

export interface Story {
  title: string;
  body_text: string;
  audio_url?: string | null;
  read_min?: number | null;
  thumbnail_url?: string | null;
  vocab?: { word: string; definition: string }[];
}

export function StoryBlock({ story, kicker, style }: {
  story: Story;
  /** Overrides the default eyebrow, e.g. "Read this first". */
  kicker?: string;
  style?: ViewStyle;
}) {
  const paras = story.body_text.split("\n\n").map((p) => p.trim()).filter(Boolean);
  // An illustration that 404s must not leave a grey slab above the title.
  const [artFailed, setArtFailed] = useState(false);
  const art = !artFailed ? story.thumbnail_url : null;

  return (
    <View style={[s.wrap, style]}>
      <Text style={s.kicker}>
        {kicker ?? "Read this first"}
        {story.read_min ? ` · ${story.read_min} min` : ""}
      </Text>
      <Text style={s.title}>{story.title}</Text>

      {!!art && (
        <Image
          source={{ uri: art }}
          style={s.art}
          resizeMode="cover"
          accessible
          accessibilityLabel={`Illustration for ${story.title}`}
          onError={() => setArtFailed(true)}
        />
      )}

      {/* The whole story, in order, so a child who cannot read it yet can still
          hear it without an adult sitting beside them. */}
      <SpeakButton
        size="large"
        label="Read the story to me"
        accessibilityLabel={`Read ${story.title} out loud`}
        text={[story.title, ...paras]}
        style={{ marginBottom: 14 }}
      />

      {paras.map((p, i) => (
        <Text key={i} style={s.para}>{p}</Text>
      ))}

      {!!story.vocab?.length && (
        <View style={s.vocab}>
          <Text style={s.vocabLabel}>New words</Text>
          {story.vocab.map((v) => (
            <Text key={v.word} style={s.vocabRow}>
              <Text style={s.vocabWord}>{v.word}</Text>{"  —  "}{v.definition}
            </Text>
          ))}
        </View>
      )}
    </View>
  );
}

const s = StyleSheet.create({
  wrap:   { backgroundColor: "#fbf7ef", borderRadius: 16, padding: 18 },
  kicker: { fontSize: 11, fontWeight: "900", letterSpacing: 0.8, textTransform: "uppercase",
            color: colors.brand, marginBottom: 6 },
  // 400x250 source art, so 8:5 keeps it un-cropped at any width.
  art:    { width: "100%", aspectRatio: 8 / 5, borderRadius: 12, marginBottom: 14,
            backgroundColor: "#efe7d8" },
  title:  { fontSize: 21, fontWeight: "900", color: colors.text, marginBottom: 12 },
  // Generous leading: this is the one block on the page meant to be read
  // rather than scanned.
  para:   { fontSize: 16, lineHeight: 26, color: colors.text, marginBottom: 12 },

  vocab:      { marginTop: 6, paddingTop: 14, borderTopWidth: 1, borderTopColor: "#e8dfd0" },
  vocabLabel: { fontSize: 11, fontWeight: "900", letterSpacing: 0.8, textTransform: "uppercase",
                color: colors.textMuted, marginBottom: 8 },
  vocabRow:   { fontSize: 14, lineHeight: 22, color: colors.textMuted, marginBottom: 4 },
  vocabWord:  { fontWeight: "900", color: colors.brand },
});
