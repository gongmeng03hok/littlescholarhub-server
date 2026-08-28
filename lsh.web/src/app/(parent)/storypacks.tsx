/**
 * Weekly Story Packs — a themed bundle: one read-aloud story + a set of
 * worksheets (vocab / math / art / workbook) + a journal prompt, all on
 * one theme (e.g. "Ocean Week"). Curated by admins in the CMS.
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform, Linking,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { useThemeWeeks, useThemeWeek } from "../../hooks/useApi";
import { EmptyState } from "../../components/ui/EmptyState";
import { colors, SUBJECT_META, GRADES } from "../../constants/theme";

const ROLE_LABEL: Record<string, string> = {
  vocab: "📚 Vocabulary", math: "🧮 Math", art: "🎨 Art craft",
  workbook: "📕 Workbook", worksheet: "📋 Worksheet",
};

export default function StoryPacksScreen() {
  const router = useRouter();
  const { activeChild } = useChildStore();
  const [selectedId, setSelectedId] = useState<number | null>(null);

  const { data: weeks = [], isLoading } = useThemeWeeks(activeChild?.grade_id);
  const { data: week, isLoading: weekLoading } = useThemeWeek(selectedId ?? undefined);

  const gradeLabel = (gradeId: number | null) =>
    gradeId == null ? "All grades" : GRADES.find(g => g.grade_id === gradeId)?.label ?? gradeId;

  if (selectedId) {
    return (
      <View style={s.root}>
        <View style={s.header}>
          <TouchableOpacity onPress={() => setSelectedId(null)} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
            <Text style={s.backBtn}>← Back</Text>
          </TouchableOpacity>
          <Text style={s.title} numberOfLines={1}>{week?.title ?? "Story pack"}</Text>
        </View>

        {weekLoading || !week ? (
          <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
        ) : (
          <ScrollView contentContainerStyle={s.body}>
            {!!week.description && <Text style={s.desc}>{week.description}</Text>}

            {/* Story */}
            {week.story_id && (
              <View style={s.card}>
                <Text style={s.cardEyebrow}>📖 THIS WEEK'S STORY</Text>
                <Text style={s.storyTitle}>{week.story_title}</Text>
                {!!week.read_min && <Text style={s.meta}>{week.read_min} min read</Text>}
                {!!week.story_body && (
                  <Text style={s.storyBody} numberOfLines={6}>{week.story_body}</Text>
                )}
                <TouchableOpacity style={s.primaryBtn} onPress={() => router.push("/(parent)/story")}>
                  <Text style={s.primaryBtnText}>Read together →</Text>
                </TouchableOpacity>
              </View>
            )}

            {/* Worksheets by role */}
            {week.worksheets?.length > 0 && (
              <>
                <Text style={s.sectionTitle}>This week's activities</Text>
                {week.worksheets.map((w: any) => {
                  const meta = SUBJECT_META[w.subject] ?? { icon: "📄", label: w.subject, color: colors.surfaceAlt };
                  return (
                    <View key={w.worksheet_id} style={s.wsRow}>
                      <View style={[s.wsIconWrap, { backgroundColor: meta.color }]}>
                        <Text style={s.wsIcon}>{meta.icon}</Text>
                      </View>
                      <View style={{ flex: 1 }}>
                        <Text style={s.wsRole}>{ROLE_LABEL[w.role] ?? w.role}</Text>
                        <Text style={s.wsTitle}>{w.title}</Text>
                      </View>
                      {!!w.pdf_url && (
                        <TouchableOpacity style={s.printBtn} onPress={() => Linking.openURL(w.pdf_url)}>
                          <Text style={s.printBtnText}>🖨️ Print</Text>
                        </TouchableOpacity>
                      )}
                    </View>
                  );
                })}
              </>
            )}

            {/* Journal prompt */}
            {!!week.journal_prompt && (
              <View style={[s.card, { backgroundColor: colors.brandLight }]}>
                <Text style={s.cardEyebrow}>✏️ JOURNAL PROMPT</Text>
                <Text style={s.journalText}>{week.journal_prompt}</Text>
              </View>
            )}

            <View style={{ height: 40 }} />
          </ScrollView>
        )}
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>🗓️ Weekly Story Packs</Text>
        <Text style={s.count}>{weeks.length} available</Text>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {isLoading ? (
          <ActivityIndicator style={{ marginTop: 24 }} color={colors.brand} />
        ) : weeks.length === 0 ? (
          <EmptyState emoji="🗓️" title="No story packs yet"
            body="Themed weekly bundles will show up here once they're published." />
        ) : (
          weeks.map((w: any) => (
            <TouchableOpacity key={w.theme_week_id} style={s.weekCard} onPress={() => setSelectedId(w.theme_week_id)}>
              <View style={{ flex: 1 }}>
                <Text style={s.weekTitle}>{w.title}</Text>
                {!!w.description && <Text style={s.weekDesc} numberOfLines={2}>{w.description}</Text>}
                <Text style={s.weekMeta}>
                  {gradeLabel(w.grade_id)}{w.story_title ? ` · ${w.story_title}` : ""}
                </Text>
              </View>
              <Text style={s.arrow}>›</Text>
            </TouchableOpacity>
          ))
        )}
        <View style={{ height: 40 }} />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center", justifyContent: "space-between",
            borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn:{ fontSize: 14, fontWeight: "700", color: colors.brand },
  title:  { fontSize: 18, fontWeight: "900", color: colors.text, flex: 1, marginLeft: 12 },
  count:  { fontSize: 13, color: colors.textMuted, fontWeight: "600" },

  body: { padding: 16, gap: 10 },
  desc: { fontSize: 13, color: colors.textMuted, marginBottom: 4, lineHeight: 20 },

  weekCard: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
              borderRadius: 14, padding: 16,
              shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  weekTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  weekDesc:  { fontSize: 12, color: colors.textMuted, marginTop: 4, lineHeight: 18 },
  weekMeta:  { fontSize: 11, color: colors.brand, fontWeight: "700", marginTop: 6 },
  arrow:     { fontSize: 22, color: colors.brand, fontWeight: "700", marginLeft: 8 },

  card: { backgroundColor: "white", borderRadius: 16, padding: 18, marginBottom: 16,
          shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 8, elevation: 2 },
  cardEyebrow: { fontSize: 11, fontWeight: "800", color: colors.brand, letterSpacing: 1, marginBottom: 8 },
  storyTitle:  { fontSize: 18, fontWeight: "900", color: colors.text },
  meta:        { fontSize: 12, color: colors.textMuted, marginTop: 2, marginBottom: 10 },
  storyBody:   { fontSize: 14, color: colors.text, lineHeight: 22, marginBottom: 14 },

  primaryBtn:  { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 12, alignItems: "center" },
  primaryBtnText: { color: "white", fontWeight: "800", fontSize: 14 },

  sectionTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginTop: 4, marginBottom: 4 },

  wsRow: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
           borderRadius: 12, padding: 12,
           shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 4, elevation: 1 },
  wsIconWrap: { width: 42, height: 42, borderRadius: 12, alignItems: "center", justifyContent: "center", marginRight: 12 },
  wsIcon:  { fontSize: 20 },
  wsRole:  { fontSize: 11, fontWeight: "700", color: colors.textMuted },
  wsTitle: { fontSize: 14, fontWeight: "700", color: colors.text, marginTop: 2 },
  printBtn: { backgroundColor: colors.brandLight, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 8 },
  printBtnText: { fontSize: 12, fontWeight: "700", color: colors.brand },

  journalText: { fontSize: 15, color: colors.text, lineHeight: 24, fontStyle: "italic" },
});
