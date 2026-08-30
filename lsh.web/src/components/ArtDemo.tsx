/**
 * ArtDemo — how "show me" content is presented: art projects, coloring pages,
 * mini-books and the NASA space images.
 *
 * These worksheets have no questions behind them. Routing them into
 * WorksheetPlayer meant asking QuestionGenerator for a subject it has no
 * generator for, which silently returns MATH — so "Animals Art - Grade 2nd"
 * opened a money-counting quiz. This screen shows the thing itself instead:
 * the printable sheet, the steps, and a demonstration video when one is set.
 *
 * Every block is optional. A row with only a title and a sheet still renders a
 * complete, sensible page.
 */
import { useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet, Linking, Image } from "react-native";
import { colors } from "../constants/theme";
import { SpeakButton } from "./SpeakButton";
import { StoryBlock, type Story } from "./StoryBlock";
import { PaintCanvas, hasPaintScene } from "./PaintCanvas";

export interface DemoWorksheet {
  title: string;
  description?: string | null;
  pdf_url?: string | null;
  thumbnail_url?: string | null;
  video_url?: string | null;
  materials?: string | null;
  steps?: string[];
  estimated_min?: number | null;
  teacher_name?: string | null;
  content_type?: string | null;
  subject?: string | null;
  interest_tag?: string | null;
  /** picks the line art to paint, and the printable it matches */
  pdf_generator_key?: string | null;
  /** Attached reading for a "<Theme> Story" worksheet. */
  story?: Story | null;
}

const VERB: Record<string, string> = {
  coloring:    "Open the coloring sheet",
  space_image: "Open the full-size picture",
  mini_book:   "Open the mini-book",
  iacl_book:   "Open the book",
};

/**
 * Closing line when there are no steps and no video. Keyed by content type
 * first, then subject — a story activity must never be told there is "no wrong
 * way to color it", which is what a single coloring-page default produced.
 */
const HINT_BY_TYPE: Record<string, string> = {
  coloring:    "Print the sheet and make it together — there's no wrong way to color it.",
  space_image: "Open the picture full-size and talk about what you notice first.",
  mini_book:   "Print it, fold it, and read it together — your child can keep this one.",
  iacl_book:   "Open the book and read a few pages together.",
};

/**
 * Cover art. Almost no Worksheets row carries a thumbnail_url, so without a
 * fallback this screen was a wall of text and one button. Resolution order is
 * the row's own thumbnail, then its content type, then its subject.
 */
/**
 * Theme art wins over the content-type fallback. Without it, 28 worksheets —
 * a unicorn, a shark, a T-Rex, a fairy-tale castle — all showed the same
 * crayons-and-flower picture, which read as the wrong content entirely.
 */
const COVER_BY_THEME: Record<string, string> = {
  animals:   "/art/cover_theme_animals.svg",
  dinosaurs: "/art/cover_theme_dinosaurs.svg",
  space:     "/art/cover_theme_space.svg",
  ocean:     "/art/cover_theme_ocean.svg",
  fantasy:   "/art/cover_theme_fantasy.svg",
  vehicles:  "/art/cover_theme_vehicles.svg",
  holidays:  "/art/cover_theme_holidays.svg",
  sports:    "/art/cover_theme_sports.svg",
  nature:    "/art/cover_theme_nature.svg",
};

const COVER_BY_TYPE: Record<string, string> = {
  mini_book:   "/art/cover_mini_book.svg",
  iacl_book:   "/art/cover_story_book.svg",
  coloring:    "/art/cover_coloring.svg",
  space_image: "/art/cover_space.svg",
};

const COVER_BY_SUBJECT: Record<string, string> = {
  story:        "/art/cover_story_book.svg",
  art:          "/art/cover_coloring.svg",
  solar_system: "/art/cover_space.svg",
  workbooks:    "/art/cover_worksheet.svg",
  writing:      "/art/cover_worksheet.svg",
  science:      "/art/cover_worksheet.svg",
};

const HINT_BY_SUBJECT: Record<string, string> = {
  story:     "Print the activity and read it together — take turns being the storyteller.",
  writing:   "Print the page and write it together. Spelling can wait; ideas come first.",
  science:   "Print the sheet and try it together — talk about what you expect before you start.",
  workbooks: "Print the pages and work through them at your child's own pace.",
  art:       "Print the sheet and make it together — there's no wrong way to color it.",
};

export function ArtDemo({ worksheet, onExit }: { worksheet: DemoWorksheet; onExit: () => void }) {
  const w        = worksheet;
  const steps    = w.steps ?? [];
  const openable = w.pdf_url;
  const openWord = VERB[w.content_type ?? ""] ?? "Open the printable sheet";

  // Our own artwork, used both as the fallback when a row has no thumbnail and
  // as the recovery when its thumbnail fails to load.
  // theme first — a "Dinosaurs Art" sheet should look like dinosaurs, not like
  // the generic crayon page every other art worksheet was showing.
  const ownArt = COVER_BY_THEME[(w.interest_tag ?? "").toLowerCase()]
              || COVER_BY_TYPE[w.content_type ?? ""]
              || COVER_BY_SUBJECT[w.subject ?? ""]
              || "/art/cover_worksheet.svg";

  // Several rows point thumbnail_url at archive.org, which has been answering
  // 503 — without this the page rendered a broken image and no picture at all.
  const [thumbFailed, setThumbFailed] = useState(false);
  const cover = (!thumbFailed && w.thumbnail_url) ? w.thumbnail_url : ownArt;

  // A coloring sheet we can draw shows the real drawing instead of a cover.
  const paintable = hasPaintScene(w.pdf_generator_key);

  return (
    <View style={s.root}>
      <View style={s.header}>
        <TouchableOpacity onPress={onExit} style={s.back} accessibilityRole="button"
          accessibilityLabel="Go back">
          <Text style={s.backText}>←</Text>
        </TouchableOpacity>
        <Text style={s.headerTitle}>{w.title}</Text>
      </View>

      <ScrollView contentContainerStyle={s.scroll}>
        <View style={s.card}>
          {paintable ? (
            <PaintCanvas sceneKey={w.pdf_generator_key!} style={{ marginBottom: 16 }} />
          ) : !!cover && (
            <Image
              source={{ uri: cover }}
              style={s.thumb}
              resizeMode="contain"
              onError={() => setThumbFailed(true)}
              accessibilityLabel={`Cover picture for ${w.title}`}
            />
          )}

          <View style={s.metaRow}>
            {!!w.estimated_min && (
              <View style={s.chip}><Text style={s.chipText}>⏱ {w.estimated_min} min</Text></View>
            )}
            {!!w.teacher_name && (
              <View style={s.chip}><Text style={s.chipText}>✎ {w.teacher_name}</Text></View>
            )}
          </View>

          {!!w.description && <Text style={s.desc}>{w.description}</Text>}

          {/* The story itself, when this worksheet is an activity about one.
              It goes above the printable: read first, then do the sheet. */}
          {!!w.story && <StoryBlock story={w.story} style={{ marginBottom: 20 }} />}

          {!!w.materials && (
            <View style={s.materials}>
              <Text style={s.materialsLabel}>You'll need</Text>
              <Text style={s.materialsText}>{w.materials}</Text>
            </View>
          )}

          {steps.length > 0 && (
            <>
              <Text style={s.stepsTitle}>How to make it</Text>
              {/* Reads every step in order, so a child can follow along with
                  glue on their hands instead of re-reading the screen. */}
              <SpeakButton
                size="large"
                label="Read the steps to me"
                accessibilityLabel="Read all the steps out loud"
                text={[...(w.materials ? [`You will need: ${w.materials}`] : []),
                       ...steps.map((st, i) => `Step ${i + 1}. ${st}`)]}
                style={{ marginBottom: 14 }}
              />
              {steps.map((st, i) => (
                <View key={i} style={s.step}>
                  <View style={s.stepNum}><Text style={s.stepNumText}>{i + 1}</Text></View>
                  <Text style={s.stepText}>{st}</Text>
                  <SpeakButton text={st} accessibilityLabel={`Read step ${i + 1} out loud`} />
                </View>
              ))}
            </>
          )}

          {!!w.video_url && (
            <TouchableOpacity
              style={s.videoBtn}
              accessibilityRole="button"
              onPress={() => Linking.openURL(w.video_url!)}
              activeOpacity={0.85}
            >
              <Text style={s.videoIcon}>▶</Text>
              <Text style={s.videoText}>Watch the steps</Text>
            </TouchableOpacity>
          )}

          {!!openable && (
            <TouchableOpacity
              style={[s.printBtn, !w.video_url && s.printBtnPrimary]}
              accessibilityRole="button"
              onPress={() => Linking.openURL(w.pdf_url!)}
              activeOpacity={0.85}
            >
              <Text style={[s.printText, !w.video_url && s.printTextPrimary]}>🖨  {openWord}</Text>
            </TouchableOpacity>
          )}

          {steps.length === 0 && !w.video_url && (
            <Text style={s.hint}>
              {paintable
                ? "Paint it here, or print the same picture to color on paper."
                : HINT_BY_TYPE[w.content_type ?? ""]
                ?? HINT_BY_SUBJECT[w.subject ?? ""]
                ?? "Print the sheet and work through it together."}
            </Text>
          )}
        </View>
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { backgroundColor: colors.brand, paddingTop: 56, paddingBottom: 18, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center" },
  back:   { marginRight: 12 },
  backText: { fontSize: 28, color: "white", fontWeight: "700" },
  // No numberOfLines: a long art title wraps rather than being cut off.
  headerTitle: { flex: 1, fontSize: 20, fontWeight: "900", color: "white" },

  scroll: { padding: 18, paddingBottom: 48 },
  card:   { backgroundColor: "white", borderRadius: 22, padding: 22,
            shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 12, elevation: 3 },
  // contain, not cover: the artwork already carries its own cream ground and
  // rounded corners, so cropping it would cut the illustration.
  thumb:  { width: "100%", height: 210, borderRadius: 16, marginBottom: 18 },

  metaRow: { flexDirection: "row", gap: 8, flexWrap: "wrap", marginBottom: 12 },
  chip:    { backgroundColor: colors.brandLight, borderRadius: 999, paddingHorizontal: 12, paddingVertical: 5 },
  chipText:{ fontSize: 13, fontWeight: "700", color: colors.brand },

  desc:   { fontSize: 16, lineHeight: 25, color: colors.text, marginBottom: 16 },

  story:       { backgroundColor: "#fbf7ef", borderRadius: 16, padding: 18, marginBottom: 20 },
  storyKicker: { fontSize: 11, fontWeight: "900", letterSpacing: 0.8, textTransform: "uppercase",
                 color: colors.brand, marginBottom: 6 },
  storyTitle:  { fontSize: 21, fontWeight: "900", color: colors.text, marginBottom: 12 },
  // Generous line height: this is the one block on the page meant to be read
  // rather than scanned.
  storyPara:   { fontSize: 16, lineHeight: 26, color: colors.text, marginBottom: 12 },
  vocab:       { marginTop: 6, paddingTop: 14, borderTopWidth: 1, borderTopColor: "#e8dfd0" },
  vocabLabel:  { fontSize: 11, fontWeight: "900", letterSpacing: 0.8, textTransform: "uppercase",
                 color: colors.textMuted, marginBottom: 8 },
  vocabRow:    { fontSize: 14, lineHeight: 22, color: colors.textMuted, marginBottom: 4 },
  vocabWord:   { fontWeight: "900", color: colors.brand },

  materials:      { backgroundColor: "#fbf7ef", borderRadius: 14, padding: 14, marginBottom: 18 },
  materialsLabel: { fontSize: 12, fontWeight: "900", letterSpacing: 0.6, textTransform: "uppercase",
                    color: colors.textMuted, marginBottom: 4 },
  materialsText:  { fontSize: 15, lineHeight: 22, color: colors.text, fontWeight: "600" },

  stepsTitle: { fontSize: 17, fontWeight: "900", color: colors.text, marginBottom: 12 },
  step:       { flexDirection: "row", gap: 12, marginBottom: 12, alignItems: "flex-start" },
  stepNum:    { width: 28, height: 28, borderRadius: 14, backgroundColor: colors.brand,
                alignItems: "center", justifyContent: "center", flexShrink: 0 },
  stepNumText:{ color: "white", fontWeight: "900", fontSize: 14 },
  // flex:1 so a long step wraps inside the row instead of overflowing the card.
  stepText:   { flex: 1, fontSize: 15, lineHeight: 23, color: colors.text },

  videoBtn:  { flexDirection: "row", alignItems: "center", justifyContent: "center", gap: 10,
               backgroundColor: colors.brand, borderRadius: 16, paddingVertical: 15, marginTop: 18 },
  videoIcon: { color: "white", fontSize: 16 },
  videoText: { color: "white", fontSize: 16, fontWeight: "900" },

  printBtn:        { flexDirection: "row", alignItems: "center", justifyContent: "center",
                     borderRadius: 16, paddingVertical: 15, marginTop: 10,
                     borderWidth: 2, borderColor: colors.border },
  printBtnPrimary: { backgroundColor: colors.brand, borderColor: colors.brand },
  printText:       { fontSize: 16, fontWeight: "900", color: colors.text },
  printTextPrimary:{ color: "white" },

  hint: { marginTop: 16, fontSize: 14, lineHeight: 21, color: colors.textMuted, textAlign: "center" },
});
