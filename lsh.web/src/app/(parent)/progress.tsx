/**
 * Progress screen — streak, weekly summary, 7-day bar chart, subject breakdown.
 */
import {
  ScrollView, View, Text, TouchableOpacity, Image,
  StyleSheet, ActivityIndicator, Platform, Dimensions,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { useChildren } from "../../hooks/useChildren";
import { useProgress, useProgressChart, useActivities } from "../../hooks/useApi";
import { StreakBadge }   from "../../components/StreakBadge";
import { EmptyState }    from "../../components/ui/EmptyState";
import { colors }        from "../../constants/theme";
import { mergeActivities } from "../../utils/activities";

const { width } = Dimensions.get("window");
const CHART_W   = Math.min(width - 40, 640);
const BAR_MAX_H = 100;

function BarChart({ data }: { data: { date: string; minutes: number }[] }) {
  const maxMins = Math.max(...data.map(d => d.minutes), 1);
  const days    = ["Su","Mo","Tu","We","Th","Fr","Sa"];

  return (
    <View style={c.chart}>
      {data.map((d, i) => {
        const barH  = Math.max(4, (d.minutes / maxMins) * BAR_MAX_H);
        const day   = new Date(d.date + "T12:00:00");
        const label = days[day.getDay()];
        const today = new Date().toDateString() === day.toDateString();
        return (
          <View key={d.date} style={c.barWrap}>
            {d.minutes > 0 && (
              <Text style={c.barVal}>{d.minutes}</Text>
            )}
            <View style={[c.bar, { height: barH, backgroundColor: today ? colors.brand : colors.brandLight }]} />
            <Text style={[c.barLabel, today && { color: colors.brand, fontWeight: "800" }]}>{label}</Text>
          </View>
        );
      })}
    </View>
  );
}

export default function ProgressScreen() {
  useChildren(); // hydrate the child list so a reload / deep link resolves a child
  const router = useRouter();
  const { activeChild, children, setActiveChild } = useChildStore();
  const childId = activeChild?.child_id;

  const { data: prog,  isLoading  } = useProgress(childId);
  const { data: chart, isLoading: chartLoading } = useProgressChart(childId);
  const { data: activityData, isLoading: activitiesLoading } = useActivities(childId, 50);
  const activities = mergeActivities(activityData);

  if (!childId) {
    return <EmptyState emoji="👶" title="No child selected"
      body="Add a child from the Family tab to track progress." />;
  }

  if (isLoading) {
    return <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>;
  }

  const streak     = prog?.streak ?? { current_streak: 0, longest_streak: 0, total_hours: 0 };
  const weekly     = prog?.weekly ?? { sessions: 0, mins: 0 };
  const bySubject  = prog?.by_subject ?? [];

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      <View style={s.header}>
        <Text style={s.title}>Progress 📈</Text>
        {children.length > 1 && (
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 10 }}>
            {children.map(ch => (
              <TouchableOpacity key={ch.child_id}
                onPress={() => setActiveChild(ch)}
                style={[s.childChip, activeChild?.child_id === ch.child_id && s.chipActive]}>
                <Text style={[s.chipText, activeChild?.child_id === ch.child_id && s.chipTextActive]}>
                  {ch.nickname}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        )}
      </View>

      {/* The chart below covers seven days; the month lives on its own screen. */}
      <TouchableOpacity style={s.calLink} onPress={() => router.push("/(parent)/calendar")}>
        <Text style={s.calLinkText}>📅  See the whole month</Text>
        <Text style={s.calLinkArrow}>→</Text>
      </TouchableOpacity>

      {/* Streak badges */}
      <View style={s.section}>
        <StreakBadge
          streak={streak.current_streak}
          weeklyMins={weekly.mins}
          totalHours={streak.total_hours}
        />
      </View>

      {/* Stats row */}
      <View style={s.statsRow}>
        {[
          { label: "Sessions this week", value: String(weekly.sessions) },
          { label: "Longest streak",     value: `${streak.longest_streak} days` },
          { label: "Total hours",        value: `${Number(streak.total_hours ?? 0).toFixed(1)} hrs` },
        ].map(item => (
          <View key={item.label} style={s.statCard}>
            <Text style={s.statValue}>{item.value}</Text>
            <Text style={s.statLabel}>{item.label}</Text>
          </View>
        ))}
      </View>

      {/* 7-day chart */}
      <View style={s.chartCard}>
        <Text style={s.sectionTitle}>Minutes per day (last 7 days)</Text>
        {chartLoading
          ? <ActivityIndicator color={colors.brand} style={{ marginTop: 20 }} />
          : chart && chart.length > 0
            ? <BarChart data={chart} />
            : <Text style={s.noData}>No sessions recorded yet — start practising!</Text>}
      </View>

      {/* Subject breakdown */}
      {bySubject.length > 0 && (
        <View style={s.section}>
          <Text style={s.sectionTitle}>Top subjects (last 30 days)</Text>
          {bySubject.map((sub: any, i: number) => {
            const maxMin = bySubject[0]?.total_min ?? 1;
            const pct    = (sub.total_min / maxMin) * 100;
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

      {bySubject.length === 0 && !isLoading && (
        <View style={s.section}>
          <View style={s.encourageCard}>
            <Text style={s.encourageEmoji}>🚀</Text>
            <Text style={s.encourageTitle}>Start your first session!</Text>
            <Text style={s.encourageSub}>
              Practice any subject to build your streak and see progress here.
            </Text>
          </View>
        </View>
      )}

      {/* ── Answer sheet — every completed activity, itemized ────── */}
      <View style={s.section}>
        <Text style={s.sectionTitle}>Completed activities &amp; answer sheet</Text>
        {activitiesLoading ? (
          <ActivityIndicator color={colors.brand} style={{ marginTop: 12 }} />
        ) : activities.length === 0 ? (
          <Text style={s.noData}>
            No completed activities yet. Quiz answers and homework submissions will show up here.
          </Text>
        ) : (
          activities.map(item => (
            <View key={item.key} style={s.activityCard}>
              {item.type === "quiz" ? (
                <>
                  <View style={s.activityHeader}>
                    <View style={[s.resultBadge, item.is_correct ? s.resultBadgeOk : s.resultBadgeErr]}>
                      <Text style={s.resultBadgeText}>{item.is_correct ? "✓ Correct" : "✗ Incorrect"}</Text>
                    </View>
                    <Text style={s.activityTime}>{new Date(item.timestamp).toLocaleString()}</Text>
                  </View>
                  <Text style={s.activityQ}>{item.question_text}</Text>
                  <View style={s.answerRow}>
                    <Text style={s.answerLabel}>Their answer:</Text>
                    <Text style={[s.answerValue, !item.is_correct && s.answerWrong]}>{item.given_answer}</Text>
                  </View>
                  {!item.is_correct && (
                    <View style={s.answerRow}>
                      <Text style={s.answerLabel}>Correct answer:</Text>
                      <Text style={[s.answerValue, s.answerRight]}>{item.correct_answer}</Text>
                    </View>
                  )}
                </>
              ) : (
                <>
                  <View style={s.activityHeader}>
                    <View style={[s.resultBadge, s.resultBadgeHw]}>
                      <Text style={s.resultBadgeText}>📸 Homework</Text>
                    </View>
                    <Text style={s.activityTime}>{new Date(item.timestamp).toLocaleString()}</Text>
                  </View>
                  <Text style={s.activityQ}>{item.worksheet_title ?? "Homework submission"}</Text>
                  <View style={{ flexDirection: "row", alignItems: "center", gap: 12, marginTop: 8 }}>
                    {item.image_url && (
                      <Image source={{ uri: item.image_url }} style={s.answerSheetImg} resizeMode="cover" />
                    )}
                    <Text style={s.answerValue}>
                      {item.score != null ? `Scored ${item.score}/100` : "Awaiting review"}
                    </Text>
                  </View>
                </>
              )}
            </View>
          ))
        )}
      </View>

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  calLink: { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
             backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border,
             borderRadius: 14, paddingVertical: 12, paddingHorizontal: 14, marginBottom: 14 },
  calLinkText:  { fontSize: 15, fontWeight: "800", color: colors.text },
  calLinkArrow: { fontSize: 18, fontWeight: "900", color: colors.brand },
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  content: { paddingBottom: 40 },
  center:  { flex: 1, justifyContent: "center", alignItems: "center" },

  header:  { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
             paddingBottom: 16, paddingHorizontal: 20,
             borderBottomWidth: 1, borderBottomColor: colors.border },
  title:   { fontSize: 22, fontWeight: "900", color: colors.text },

  childChip:    { borderWidth: 2, borderColor: colors.border, borderRadius: 20,
                  paddingHorizontal: 14, paddingVertical: 6, marginRight: 8, backgroundColor: "white" },
  chipActive:   { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText:     { fontSize: 13, fontWeight: "700", color: colors.textMuted },
  chipTextActive:{ color: colors.brand },

  section:      { padding: 20 },
  sectionTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 14 },

  statsRow: { flexDirection: "row", gap: 10, paddingHorizontal: 20, marginTop: 4 },
  statCard: { flex: 1, backgroundColor: "white", borderRadius: 14, padding: 14, alignItems: "center",
              shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  statValue:{ fontSize: 18, fontWeight: "900", color: colors.brand },
  statLabel:{ fontSize: 11, color: colors.textMuted, fontWeight: "600", marginTop: 4, textAlign: "center" },

  chartCard: { margin: 20, backgroundColor: "white", borderRadius: 16, padding: 20,
               shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 10, elevation: 2 },
  noData:    { color: colors.textMuted, fontSize: 14, textAlign: "center", marginTop: 12, lineHeight: 22 },

  subRow:    { flexDirection: "row", alignItems: "center", marginBottom: 12, gap: 10 },
  subLabel:  { width: 120, fontSize: 13, fontWeight: "600", color: colors.text },
  subBarWrap:{ flex: 1, height: 8, backgroundColor: "#f0f0f0", borderRadius: 4, overflow: "hidden" },
  subBar:    { height: 8, backgroundColor: colors.brand, borderRadius: 4 },
  subMins:   { width: 40, fontSize: 12, color: colors.textMuted, textAlign: "right" },

  encourageCard:  { backgroundColor: "white", borderRadius: 16, padding: 24, alignItems: "center" },
  encourageEmoji: { fontSize: 52, marginBottom: 12 },
  encourageTitle: { fontSize: 18, fontWeight: "800", color: colors.text, marginBottom: 8 },
  encourageSub:   { fontSize: 14, color: colors.textMuted, textAlign: "center", lineHeight: 22 },

  activityCard: { backgroundColor: "white", borderRadius: 14, padding: 16, marginBottom: 10,
                  shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 6, elevation: 1 },
  activityHeader: { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 8 },
  resultBadge: { borderRadius: 10, paddingHorizontal: 10, paddingVertical: 4 },
  resultBadgeOk: { backgroundColor: "#dcfce7" },
  resultBadgeErr: { backgroundColor: "#fee2e2" },
  resultBadgeHw: { backgroundColor: colors.brandLight },
  resultBadgeText: { fontSize: 11, fontWeight: "800", color: colors.text },
  activityTime: { fontSize: 11, color: colors.textMuted },
  activityQ: { fontSize: 14, fontWeight: "700", color: colors.text, lineHeight: 20 },
  answerRow: { flexDirection: "row", gap: 6, marginTop: 6 },
  answerLabel: { fontSize: 12, color: colors.textMuted, fontWeight: "600" },
  answerValue: { fontSize: 12, fontWeight: "700", color: colors.text },
  answerWrong: { color: "#dc2626" },
  answerRight: { color: "#16a34a" },
  answerSheetImg: { width: 56, height: 56, borderRadius: 10, backgroundColor: colors.brandLight },
});

// Bar chart sub-styles (kept inline with component)
const c = StyleSheet.create({
  chart:    { flexDirection: "row", alignItems: "flex-end", justifyContent: "space-between",
              marginTop: 16, height: BAR_MAX_H + 40 },
  barWrap:  { flex: 1, alignItems: "center", justifyContent: "flex-end" },
  barVal:   { fontSize: 11, fontWeight: "700", color: colors.brand, marginBottom: 4 },
  bar:      { width: "70%", borderRadius: 4, minHeight: 4 },
  barLabel: { fontSize: 11, color: colors.textMuted, marginTop: 6, fontWeight: "600" },
});
