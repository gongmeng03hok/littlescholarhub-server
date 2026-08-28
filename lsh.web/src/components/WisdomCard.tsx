import { View, Text, Image, StyleSheet } from "react-native";
import { useQuery } from "@tanstack/react-query";
import { contentApi } from "../api/content";
import { colors } from "../constants/theme";
import { useAuthStore } from "../store/authStore";

const TRACK_STYLE: Record<string, { bg: string; accent: string; symbol: string }> = {
  gita:     { bg: colors.indian,   accent: "#c2185b", symbol: "ॐ" },
  chinese:  { bg: colors.chinese,  accent: "#e65100", symbol: "❝" },
  hispanic: { bg: colors.hispanic, accent: "#2e7d32", symbol: "❝" },
  universal:{ bg: colors.surfaceAlt, accent: colors.brand, symbol: "✦" },
};

export function WisdomCard() {
  const { family } = useAuthStore();
  const langId = family?.language_id ?? 1;

  const { data: wisdom } = useQuery({
    queryKey: ["wisdom", langId],
    queryFn: () => contentApi.getDailyWisdom(langId),
    staleTime: 60 * 60 * 1000, // 1 hour
    // Neutral while the real verse loads. This used to be a hard-coded Gita
    // line, so every family -- whatever their home language -- saw scripture
    // flash on the dashboard before their own track arrived.
    placeholderData: {
      text_original: "Small and regular beats big and rare.",
      author: "Little Scholars Hub",
      source_track: "universal",
      text_english: null,
    },
  });

  if (!wisdom) return null;

  const track = wisdom.source_track ?? "universal";
  const ts    = TRACK_STYLE[track] ?? TRACK_STYLE.universal;

  return (
    <View style={[s.card, { backgroundColor: ts.bg }]}>
      <View style={s.row}>
        <View style={s.copy}>
          <Text style={[s.label, { color: ts.accent }]}>
            {ts.symbol}  WORDS FOR TODAY
          </Text>
          <Text style={[s.quote, { color: ts.accent }]}>
            "{wisdom.text_original}"
          </Text>
          {wisdom.text_english && wisdom.text_english !== wisdom.text_original && (
            <Text style={[s.translation, { color: ts.accent }]}>
              {wisdom.text_english}
            </Text>
          )}
          <Text style={[s.author, { color: ts.accent }]}>— {wisdom.author}</Text>
        </View>

        {/* The emblem carries the meaning for a child who cannot read the line
            yet — footsteps for a journey, bamboo for gentleness. Decorative to
            a screen reader: the quote beside it already says the same thing. */}
        {!!wisdom.image_url && (
          <Image
            source={{ uri: wisdom.image_url }}
            style={s.emblem}
            resizeMode="contain"
            accessibilityElementsHidden
            importantForAccessibility="no-hide-descendants"
          />
        )}
      </View>
    </View>
  );
}

const s = StyleSheet.create({
  card:        { borderRadius: 16, padding: 20, marginBottom: 16 },
  row:         { flexDirection: "row", alignItems: "center", gap: 16 },
  copy:        { flex: 1, minWidth: 0 },
  emblem:      { width: 96, height: 96, borderRadius: 20, flexShrink: 0 },
  label:       { fontSize: 11, fontWeight: "800", letterSpacing: 1.5, marginBottom: 10 },
  quote:       { fontSize: 16, fontStyle: "italic", lineHeight: 26, marginBottom: 8 },
  translation: { fontSize: 14, fontStyle: "italic", lineHeight: 22, opacity: 0.75, marginBottom: 6 },
  author:      { fontSize: 13, fontWeight: "700", opacity: 0.75 },
});
