/**
 * Student detail — a teacher's view of one student's activity and grades.
 * Reuses the same streak/chart/subject-breakdown shape as the parent Progress tab.
 */
import { useLocalSearchParams, useRouter } from "expo-router";
import {
  View, Text, ScrollView, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useStudentProgress, useStudentGrades } from "../../../hooks/useTeacher";
import { StreakBadge } from "../../../components/StreakBadge";
import { colors, GRADES } from "../../../constants/theme";

const BAR_MAX_H = 90;

function BarChart({ data }: { data: { date: string; minutes: number }[] }) {
  const maxMins = Math.max(...data.map(d => d.minutes), 1);
  const days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
  return (
    <View style={c.chart}>
      {data.map((d) => {
        const barH = Math.max(4, (d.minutes / maxMins) * BAR_MAX_H);
        const day = new Date(d.date + "T12:00:00");
        const label = days[day.getDay()];
        const today = new Date().toDateString() === day.toDateString();
        return (
          <View key={d.date} style={c.barWrap}>
            {d.minutes > 0 && <Text style={c.barVal}>{d.minutes}</Text>}
            <View style={[c.bar, { height: barH, backgroundColor: today ? colors.brand : colors.brandLight }]} />
            <Text style={[c.barLabel, today && { color: colors.brand, fontWeight: "800" }]}>{label}</Text>
          </View>
        );
      })}
    </View>
  );
}

export default function StudentDetail() {
  const router = useRouter();
  const { childId } = useLocalSearchParams<{ childId: string }>();
  const id = childId ? parseInt(childId, 10) : undefined;

  const { data: progress, isLoading: progressLoading } = useStudentProgress(id);
  const { data: grades,   isLoading: gradesLoading }   = useStudentGrades(id);

  const loading = progressLoading || gradesLoading;
  const student = progress?.student ?? grades?.student;
  const gradeLabel = GRADES.find(g => g.grade_id === student?.grade_id)?.label;

  return (
    <View style={s.root}>
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
          <Text style={s.backBtn}>‹ Back</Text>
        </TouchableOpacity>
        <Text style={s.title}>{student ? student.nickname : "Student"}</Text>
        {gradeLabel && <Text style={s.subtitle}>Grade {gradeLabel}</Text>}
      </View>

      {loading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.body} showsVerticalScrollIndicator={false}>
          {/* Activity */}
          <Text style={s.sectionTitle}>Activity</Text>
          <View style={s.card}>
            <StreakBadge
              streak={progress?.streak?.current_streak ?? 0}
              weeklyMins={progress?.weekly?.mins ?? 0}
              totalHours={Number(progress?.streak?.total_hours ?? 0)}
            />
          </View>

          <View style={s.card}>
            <Text style={s.cardTitle}>Minutes per day (last 7 days)</Text>
            {progress?.chart?.length ? (
              <BarChart data={progress.chart} />
            ) : (
              <Text style={s.noData}>No activity recorded yet.</Text>
            )}
          </View>

          {progress?.by_subject?.length > 0 && (
            <View style={s.card}>
              <Text style={s.cardTitle}>Top subjects (last 30 days)</Text>
              {progress.by_subject.map((sub: any) => {
                const maxMin = progress.by_subject[0]?.total_min ?? 1;
                const pct = (sub.total_min / maxMin) * 100;
                return (
                  <View key={sub.slug} style={s.subRow}>
                    <Text style={s.subLabel}>{sub.label}</Text>
                    <View style={s.subBarWrap}>
                      <View style={[s.subBar, { width: `${pct}%` }]} />
                    </View>
                    <Text style={s.subMins}>{sub.total_min}m</Text>
                  </View>
                );
              })}
            </View>
          )}

          {progress?.badges?.length > 0 && (
            <View style={s.card}>
              <Text style={s.cardTitle}>Badges earned</Text>
              <View style={{ flexDirection: "row", flexWrap: "wrap", gap: 10 }}>
                {progress.badges.map((b: any) => (
                  <View key={b.badge_slug} style={s.badgeChip}>
                    <Text style={s.badgeEmoji}>{b.icon}</Text>
                    <Text style={s.badgeLabel}>{b.label}</Text>
                  </View>
                ))}
              </View>
            </View>
          )}

          {/* Grades */}
          <Text style={[s.sectionTitle, { marginTop: 8 }]}>Grades</Text>
          <View style={s.card}>
            <View style={s.gradeSummaryRow}>
              <View style={s.gradeSummaryItem}>
                <Text style={s.gradeSummaryValue}>{grades?.avg_score ?? "—"}</Text>
                <Text style={s.gradeSummaryLabel}>Average score</Text>
              </View>
              <View style={s.gradeSummaryItem}>
                <Text style={s.gradeSummaryValue}>{grades?.graded_count ?? 0}</Text>
                <Text style={s.gradeSummaryLabel}>Graded</Text>
              </View>
              <View style={s.gradeSummaryItem}>
                <Text style={s.gradeSummaryValue}>{grades?.submissions?.length ?? 0}</Text>
                <Text style={s.gradeSummaryLabel}>Submitted</Text>
              </View>
            </View>
          </View>

          {!grades?.submissions?.length ? (
            <Text style={s.noData}>No homework submitted yet.</Text>
          ) : (
            grades.submissions.map((sub: any) => (
              <View key={sub.submission_id} style={s.submissionRow}>
                <View style={{ flex: 1 }}>
                  <Text style={s.submissionTitle}>{sub.worksheet_title || "Homework photo"}</Text>
                  <Text style={s.submissionMeta}>
                    {sub.classroom_name} · {new Date(sub.submitted_at).toLocaleDateString()}
                  </Text>
                </View>
                <Text style={[s.submissionScore, sub.score == null && s.submissionScorePending]}>
                  {sub.score != null ? sub.score : "Pending"}
                </Text>
              </View>
            ))
          )}

          <View style={{ height: 40 }} />
        </ScrollView>
      )}
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn:  { fontSize: 14, fontWeight: "700", color: colors.brand, marginBottom: 6 },
  title:    { fontSize: 20, fontWeight: "900", color: colors.text },
  subtitle: { fontSize: 13, color: colors.textMuted, marginTop: 2, fontWeight: "600" },

  body: { padding: 16, gap: 12 },
  sectionTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginTop: 4 },

  card: { backgroundColor: "white", borderRadius: 14, padding: 16,
          shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  cardTitle: { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 12 },
  noData: { color: colors.textMuted, fontSize: 13, textAlign: "center", padding: 12 },

  subRow: { flexDirection: "row", alignItems: "center", marginBottom: 10, gap: 10 },
  subLabel: { width: 110, fontSize: 12, fontWeight: "600", color: colors.text },
  subBarWrap: { flex: 1, height: 8, backgroundColor: "#f0f0f0", borderRadius: 4, overflow: "hidden" },
  subBar: { height: 8, backgroundColor: colors.brand, borderRadius: 4 },
  subMins: { width: 36, fontSize: 12, color: colors.textMuted, textAlign: "right" },

  badgeChip: { flexDirection: "row", alignItems: "center", gap: 6, backgroundColor: colors.brandLight,
               borderRadius: 20, paddingHorizontal: 12, paddingVertical: 6 },
  badgeEmoji: { fontSize: 16 },
  badgeLabel: { fontSize: 12, fontWeight: "700", color: colors.brand },

  gradeSummaryRow: { flexDirection: "row", justifyContent: "space-around" },
  gradeSummaryItem: { alignItems: "center" },
  gradeSummaryValue: { fontSize: 20, fontWeight: "900", color: colors.brand },
  gradeSummaryLabel: { fontSize: 11, color: colors.textMuted, fontWeight: "600", marginTop: 4 },

  submissionRow: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
                   borderRadius: 12, padding: 14,
                   shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 4, elevation: 1 },
  submissionTitle: { fontSize: 13, fontWeight: "700", color: colors.text },
  submissionMeta:  { fontSize: 11, color: colors.textMuted, marginTop: 2 },
  submissionScore: { fontSize: 16, fontWeight: "900", color: colors.brand, marginLeft: 12 },
  submissionScorePending: { fontSize: 12, color: colors.textMuted, fontWeight: "700" },
});

const c = StyleSheet.create({
  chart:    { flexDirection: "row", alignItems: "flex-end", justifyContent: "space-between",
              marginTop: 4, height: BAR_MAX_H + 40 },
  barWrap:  { flex: 1, alignItems: "center", justifyContent: "flex-end" },
  barVal:   { fontSize: 11, fontWeight: "700", color: colors.brand, marginBottom: 4 },
  bar:      { width: "70%", borderRadius: 4, minHeight: 4 },
  barLabel: { fontSize: 11, color: colors.textMuted, marginTop: 6, fontWeight: "600" },
});
