/**
 * Admin Dashboard — stats overview + recent activity + quick links
 * GET /api/admin/stats
 */
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform, RefreshControl,
} from "react-native";
import { useRouter } from "expo-router";
import { useQueryClient } from "@tanstack/react-query";
import { useAdminStats, useAdminDetailedStats } from "../../hooks/useApi";
import { useAuthStore }  from "../../store/authStore";
import { colors }        from "../../constants/theme";

const STAT_CARDS = [
  { key: "families",   label: "Families",   emoji: "👨‍👩‍👧", color: "#ede9fe" },
  { key: "children",   label: "Children",   emoji: "👶",    color: "#dbeafe" },
  { key: "sessions",   label: "Sessions",   emoji: "📚",    color: "#dcfce7" },
  { key: "worksheets", label: "Worksheets", emoji: "📋",    color: "#fef9c3" },
  { key: "stories",    label: "Stories",    emoji: "📖",    color: "#fce7f3" },
  { key: "wisdom",     label: "Wisdom",     emoji: "ॐ",     color: colors.surfaceAlt },
];

const QUICK_LINKS = [
  { emoji: "📋", label: "Manage Worksheets", route: "/(admin)/content/worksheets" },
  { emoji: "⭐", label: "Featured Collections", route: "/(admin)/content/featured" },
  { emoji: "📖", label: "Manage Stories",    route: "/(admin)/content/stories"    },
  { emoji: "🗓️", label: "Weekly Story Packs",route: "/(admin)/content/theme-weeks"},
  { emoji: "📅", label: "Weekly Packets", route: "/(admin)/content/weekly-packets" },
  { emoji: "🏃", label: "Outdoor Games", route: "/(admin)/content/outdoor-games" },
  { emoji: "ॐ",  label: "Manage Wisdom",     route: "/(admin)/content/wisdom"     },
  { emoji: "❓", label: "Question Templates",route: "/(admin)/content/questions"  },
  { emoji: "👥", label: "Users & Roles",     route: "/(admin)/users"              },
  { emoji: "⚙️", label: "App Config CMS",    route: "/(admin)/config"             },
];

export default function AdminDashboard() {
  const router  = useRouter();
  const qc      = useQueryClient();
  const { family, logout } = useAuthStore();
  const { data: stats, isLoading, isRefetching, refetch } = useAdminStats();
  const { data: detailed } = useAdminDetailedStats();

  return (
    <ScrollView
      style={s.root}
      contentContainerStyle={s.content}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl refreshing={isRefetching} onRefresh={refetch} tintColor={colors.accent} />
      }
    >
      {/* ── Header ───────────────────────────────────── */}
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.eyebrow}>ADMIN CONSOLE</Text>
          <Text style={s.title}>Little Scholars Hub</Text>
          <Text style={s.sub}>{family?.email ?? "—"}</Text>
        </View>
        <TouchableOpacity
          style={s.logoutBtn}
          onPress={async () => { await logout(); router.replace("/(auth)/login"); }}
        >
          <Text style={s.logoutText}>Sign out</Text>
        </TouchableOpacity>
      </View>

      {/* ── Stats grid ───────────────────────────────── */}
      <Text style={s.sectionLabel}>Platform overview</Text>
      {isLoading ? (
        <ActivityIndicator color={colors.accent} size="large" style={{ marginTop: 32 }} />
      ) : (
        <View style={s.statsGrid}>
          {STAT_CARDS.map(card => (
            <View key={card.key} style={[s.statCard, { backgroundColor: card.color }]}>
              <Text style={s.statEmoji}>{card.emoji}</Text>
              <Text style={s.statNum}>
                {stats?.[card.key] !== undefined
                  ? Number(stats[card.key]).toLocaleString()
                  : "—"}
              </Text>
              <Text style={s.statLabel}>{card.label}</Text>
            </View>
          ))}
        </View>
      )}

      {/* ── Plan mix ─────────────────────────────────── */}
      {!!detailed?.plan_mix?.length && (
        <>
          <Text style={s.sectionLabel}>Plan mix</Text>
          <View style={s.planMixCard}>
            {detailed.plan_mix.map((p: any) => (
              <View key={p.plan_name} style={s.planMixRow}>
                <Text style={s.planMixLabel}>{p.plan_name}</Text>
                <View style={s.planMixBarBg}>
                  <View style={[s.planMixBarFill, { width: `${p.pct}%` as any }]} />
                </View>
                <Text style={s.planMixPct}>{p.pct}% · {p.family_count}</Text>
              </View>
            ))}
          </View>
        </>
      )}

      {/* ── Homework submissions (14-day) ─────────────── */}
      {!!(detailed?.submissions_by_grade?.length || detailed?.submissions_by_subject?.length) && (
        <>
          <Text style={s.sectionLabel}>Homework scans · last 14 days</Text>
          <View style={s.analyticsRow}>
            <View style={s.analyticsCard}>
              <Text style={s.analyticsTitle}>By grade</Text>
              {(detailed?.submissions_by_grade ?? []).map((r: any) => (
                <View key={r.grade_label} style={s.analyticsRowItem}>
                  <Text style={s.analyticsRowLabel}>{r.grade_label}</Text>
                  <Text style={s.analyticsRowVal}>{r.submission_count}</Text>
                </View>
              ))}
            </View>
            <View style={s.analyticsCard}>
              <Text style={s.analyticsTitle}>By subject</Text>
              {(detailed?.submissions_by_subject ?? []).map((r: any) => (
                <View key={r.subject_label} style={s.analyticsRowItem}>
                  <Text style={s.analyticsRowLabel}>{r.subject_label}</Text>
                  <Text style={s.analyticsRowVal}>{r.submission_count}</Text>
                </View>
              ))}
            </View>
          </View>
        </>
      )}

      {/* ── Schools & districts rollup ──────────────────── */}
      {!!detailed?.by_school?.length && (
        <>
          <Text style={s.sectionLabel}>Schools & districts</Text>
          <View style={s.quickGrid}>
            {detailed.by_school.map((sc: any) => (
              <View key={sc.school_name} style={s.classroomCard}>
                <Text style={s.classroomName}>{sc.school_name}</Text>
                <Text style={s.classroomMeta}>
                  {sc.classroom_count} classroom{sc.classroom_count === 1 ? "" : "s"} ·{" "}
                  {sc.teacher_count} teacher{sc.teacher_count === 1 ? "" : "s"} ·{" "}
                  {sc.student_count} student{sc.student_count === 1 ? "" : "s"}
                </Text>
              </View>
            ))}
          </View>
        </>
      )}

      {/* ── Classroom directory ────────────────────────── */}
      {!!detailed?.classrooms?.length && (
        <>
          <Text style={s.sectionLabel}>Classrooms</Text>
          <View style={s.quickGrid}>
            {detailed.classrooms.map((c: any) => (
              <View key={c.classroom_id} style={s.classroomCard}>
                <Text style={s.classroomName}>{c.classroom_name}</Text>
                <Text style={s.classroomMeta}>
                  {c.teacher_name} · {c.student_count} student{c.student_count === 1 ? "" : "s"}
                  {c.school_name ? ` · ${c.school_name}` : ""}
                </Text>
              </View>
            ))}
          </View>
        </>
      )}

      {/* ── Quick links ──────────────────────────────── */}
      <Text style={s.sectionLabel}>Content management</Text>
      <View style={s.quickGrid}>
        {QUICK_LINKS.map(link => (
          <TouchableOpacity
            key={link.route}
            style={s.quickCard}
            onPress={() => router.push(link.route as any)}
            activeOpacity={0.82}
          >
            <Text style={s.quickEmoji}>{link.emoji}</Text>
            <Text style={s.quickLabel}>{link.label}</Text>
            <Text style={s.quickArrow}>→</Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* ── Tips ─────────────────────────────────────── */}
      <View style={s.tipCard}>
        <Text style={s.tipTitle}>💡 Admin tips</Text>
        {[
          "Edit hero tagline, pricing, and community links via Config CMS — changes go live instantly, no deploy needed.",
          "Use Worksheets → toggle Published to hide/show content without deleting.",
          "Promote a family to admin via Users → tap their row → Change role.",
          "Wisdom entries with no active_date rotate automatically based on DB order.",
        ].map((tip, i) => (
          <Text key={i} style={s.tipItem}>• {tip}</Text>
        ))}
      </View>

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#0f0f1e" },
  content: { paddingBottom: 40 },

  header: {
    backgroundColor: "#1a1a2e",
    paddingTop: Platform.OS === "ios" ? 56 : 24,
    paddingBottom: 20, paddingHorizontal: 20,
    flexDirection: "row", alignItems: "center",
    borderBottomWidth: 1, borderBottomColor: "#2d2d4e",
  },
  eyebrow:    { fontSize: 10, fontWeight: "800", letterSpacing: 2, color: colors.accent, marginBottom: 4 },
  title:      { fontSize: 22, fontWeight: "900", color: "white" },
  sub:        { fontSize: 12, color: "rgba(255,255,255,0.5)", marginTop: 2 },
  logoutBtn:  { backgroundColor: "#2d2d4e", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8 },
  logoutText: { color: "rgba(255,255,255,0.6)", fontSize: 13, fontWeight: "600" },

  sectionLabel: {
    fontSize: 11, fontWeight: "800", letterSpacing: 1.5,
    color: "rgba(255,255,255,0.4)", textTransform: "uppercase",
    paddingHorizontal: 20, marginTop: 28, marginBottom: 12,
  },

  statsGrid: { flexDirection: "row", flexWrap: "wrap", gap: 10, paddingHorizontal: 20 },
  statCard:  {
    width: "30%", flex: 1, borderRadius: 16, padding: 16,
    alignItems: "center", minWidth: 100,
  },
  statEmoji: { fontSize: 28, marginBottom: 6 },
  statNum:   { fontSize: 24, fontWeight: "900", color: colors.text },
  statLabel: { fontSize: 12, color: colors.textMuted, fontWeight: "600", marginTop: 2 },

  planMixCard: { marginHorizontal: 20, backgroundColor: "#1a1a2e", borderRadius: 14, padding: 16,
                 borderWidth: 1, borderColor: "#2d2d4e", gap: 12 },
  planMixRow:  { flexDirection: "row", alignItems: "center", gap: 10 },
  planMixLabel:{ width: 70, fontSize: 12, fontWeight: "700", color: "white", textTransform: "capitalize" },
  planMixBarBg:{ flex: 1, height: 8, backgroundColor: "#2d2d4e", borderRadius: 4, overflow: "hidden" },
  planMixBarFill: { height: 8, backgroundColor: colors.accent },
  planMixPct:  { width: 90, fontSize: 11, color: "rgba(255,255,255,0.6)", textAlign: "right" },

  analyticsRow:  { flexDirection: "row", gap: 10, paddingHorizontal: 20 },
  analyticsCard: { flex: 1, backgroundColor: "#1a1a2e", borderRadius: 14, padding: 16,
                   borderWidth: 1, borderColor: "#2d2d4e" },
  analyticsTitle:{ fontSize: 12, fontWeight: "800", color: colors.accent, marginBottom: 10 },
  analyticsRowItem: { flexDirection: "row", justifyContent: "space-between", paddingVertical: 4 },
  analyticsRowLabel:{ fontSize: 12, color: "rgba(255,255,255,0.7)" },
  analyticsRowVal:  { fontSize: 12, fontWeight: "800", color: "white" },

  classroomCard: { backgroundColor: "#1a1a2e", borderRadius: 14, padding: 16,
                   borderWidth: 1, borderColor: "#2d2d4e" },
  classroomName: { fontSize: 14, fontWeight: "800", color: "white" },
  classroomMeta: { fontSize: 12, color: "rgba(255,255,255,0.55)", marginTop: 4 },

  quickGrid: { paddingHorizontal: 20, gap: 10 },
  quickCard: {
    flexDirection: "row", alignItems: "center", gap: 14,
    backgroundColor: "#1a1a2e", borderRadius: 14, padding: 18,
    borderWidth: 1, borderColor: "#2d2d4e",
  },
  quickEmoji: { fontSize: 28, width: 36 },
  quickLabel: { flex: 1, fontSize: 15, fontWeight: "700", color: "white" },
  quickArrow: { fontSize: 18, color: colors.accent },

  tipCard:  {
    marginHorizontal: 20, marginTop: 24, backgroundColor: "#1a1a2e",
    borderRadius: 14, padding: 18, borderWidth: 1, borderColor: "#2d2d4e",
  },
  tipTitle: { fontSize: 14, fontWeight: "800", color: colors.accent, marginBottom: 12 },
  tipItem:  { fontSize: 13, color: "rgba(255,255,255,0.55)", lineHeight: 22, marginBottom: 6 },
});
