/**
 * Weekly Plan screen — shows the 5-day plan from the latest assessment.
 * Data from GET /api/assessment/plan/:childId
 */
import { useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useQuery }  from "@tanstack/react-query";
import { assessmentApi } from "../../api/assessment";
import { useChildStore }  from "../../store/childStore";
import { useChildren }    from "../../hooks/useChildren";
import { Button }         from "../../components/ui/Button";
import { EmptyState }     from "../../components/ui/EmptyState";
import { colors, SUBJECT_META } from "../../constants/theme";

const DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

export default function PlanScreen() {
  const router = useRouter();
  useChildren(); // hydrate the child list so a reload / deep link resolves a child
  const { activeChild } = useChildStore();
  const childId = activeChild?.child_id;
  const [activeDay, setActiveDay] = useState(0);

  const { data: plan, isLoading } = useQuery({
    queryKey: ["plan", childId],
    queryFn:  () => assessmentApi.getPlan(childId!),
    enabled:  !!childId,
    staleTime: 15 * 60 * 1000,
  });

  if (!childId) {
    return <EmptyState emoji="👶" title="No child selected"
      body="Select a child from the Family tab first." />;
  }

  if (isLoading) {
    return <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>;
  }

  if (!plan) {
    return (
      <View style={s.center}>
        <Text style={{ fontSize: 52 }}>📋</Text>
        <Text style={s.emptyTitle}>No plan yet</Text>
        <Text style={s.emptySub}>Take the 2-minute assessment to get a personalised weekly plan.</Text>
        <Button label="Start assessment →" onPress={() => router.push("/(parent)/assessment")} style={{ marginTop: 20 }} />
      </View>
    );
  }

  // plan.plan_json is the full schedule; plan.daily_min, sessions_day, study_days from WeeklyPlans
  let schedule: Record<string, any[]> = {};
  try {
    schedule = typeof plan.plan_json === "string" ? JSON.parse(plan.plan_json) : (plan.plan_json ?? {});
  } catch { schedule = {}; }

  const daySchedule: any[] = schedule[DAYS[activeDay]] ?? [];

  return (
    <View style={s.root}>
      {/* Header */}
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
          <Text style={s.backBtn}>← </Text>
        </TouchableOpacity>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>📋 Weekly Plan</Text>
          <Text style={s.sub}>{activeChild?.nickname} · {plan.daily_min ?? 30} min/day · {plan.study_days ?? 5} days</Text>
        </View>
        <TouchableOpacity onPress={() => router.push("/(parent)/assessment")} style={s.redoBtn}>
          <Text style={s.redoBtnText}>Redo</Text>
        </TouchableOpacity>
      </View>

      {/* Day tabs */}
      <ScrollView horizontal showsHorizontalScrollIndicator={false} style={s.dayScroll}>
        {DAYS.map((day, i) => (
          <TouchableOpacity key={day} onPress={() => setActiveDay(i)}
            style={[s.dayTab, activeDay === i && s.dayTabActive]}>
            <Text style={[s.dayTabText, activeDay === i && s.dayTabTextActive]}>
              {day.slice(0, 3)}
            </Text>
            {(schedule[day] ?? []).length > 0 && (
              <View style={[s.dayDot, activeDay === i && s.dayDotActive]} />
            )}
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* Subject allocations */}
      <ScrollView contentContainerStyle={s.scroll} showsVerticalScrollIndicator={false}>
        {daySchedule.length === 0 ? (
          <View style={s.dayEmpty}>
            <Text style={{ fontSize: 40 }}>🌿</Text>
            <Text style={s.restTitle}>Rest day</Text>
            <Text style={s.restSub}>No sessions scheduled — enjoy the break!</Text>
          </View>
        ) : (
          daySchedule.map((session: any, idx: number) => {
            const meta = SUBJECT_META[session.slug ?? session.subject] ?? {};
            return (
              <TouchableOpacity
                key={idx}
                style={[s.sessionCard, { backgroundColor: meta.color ?? "#f0f0f0" }]}
                onPress={() => router.push({
                  pathname: "/(parent)/practice/[subject]",
                  params: { subject: session.slug ?? session.subject, grade: activeChild?.grade_id ?? 2 },
                })}
                activeOpacity={0.85}
              >
                <View style={s.sessionLeft}>
                  <Text style={s.sessionIcon}>{meta.icon ?? "📚"}</Text>
                  <View>
                    <Text style={s.sessionSubject}>{meta.label ?? session.subject}</Text>
                    <Text style={s.sessionMeta}>
                      {session.minutes ?? session.duration_min ?? 15} min
                      {session.difficulty ? ` · ${session.difficulty}` : ""}
                    </Text>
                  </View>
                </View>
                <Text style={s.startBtn}>Start →</Text>
              </TouchableOpacity>
            );
          })
        )}

        {/* Subject allocation summary */}
        {plan.allocations?.length > 0 && (
          <View style={s.allocSection}>
            <Text style={s.allocTitle}>This week's subject split</Text>
            {(plan.allocations ?? []).map((alloc: any) => {
              const meta = SUBJECT_META[alloc.slug ?? "math"] ?? {};
              return (
                <View key={alloc.slug} style={s.allocRow}>
                  <Text style={s.allocIcon}>{meta.icon ?? "📚"}</Text>
                  <Text style={s.allocLabel}>{meta.label ?? alloc.slug}</Text>
                  <View style={s.allocBarBg}>
                    <View style={[s.allocBar, { width: `${Math.min(100, (alloc.minutes_wk / 120) * 100)}%` }]} />
                  </View>
                  <Text style={s.allocMins}>{alloc.minutes_wk}m/wk</Text>
                </View>
              );
            })}
          </View>
        )}

        <View style={{ height: 40 }} />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32 },

  header:   { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
              paddingBottom: 16, paddingHorizontal: 20,
              flexDirection: "row", alignItems: "center", gap: 8,
              borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn:  { fontSize: 22, color: colors.brand, fontWeight: "700" },
  title:    { fontSize: 20, fontWeight: "900", color: colors.text },
  sub:      { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  redoBtn:  { backgroundColor: colors.brandLight, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6 },
  redoBtnText: { color: colors.brand, fontWeight: "700", fontSize: 13 },

  dayScroll: { backgroundColor: "white", paddingHorizontal: 12, paddingVertical: 10,
               borderBottomWidth: 1, borderBottomColor: colors.border },
  dayTab:       { paddingHorizontal: 18, paddingVertical: 10, borderRadius: 20, marginRight: 6,
                  alignItems: "center" },
  dayTabActive: { backgroundColor: colors.brand },
  dayTabText:   { fontSize: 14, fontWeight: "700", color: colors.textMuted },
  dayTabTextActive: { color: "white" },
  dayDot:       { width: 5, height: 5, borderRadius: 3, backgroundColor: colors.brand, marginTop: 4 },
  dayDotActive: { backgroundColor: "white" },

  scroll: { padding: 16, gap: 12 },

  dayEmpty:  { alignItems: "center", paddingVertical: 48 },
  restTitle: { fontSize: 22, fontWeight: "800", color: colors.text, marginTop: 12 },
  restSub:   { fontSize: 14, color: colors.textMuted, marginTop: 6 },

  sessionCard: { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
                 borderRadius: 16, padding: 18 },
  sessionLeft: { flexDirection: "row", alignItems: "center", gap: 14 },
  sessionIcon: { fontSize: 32 },
  sessionSubject: { fontSize: 16, fontWeight: "800", color: colors.text },
  sessionMeta:    { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  startBtn:       { fontSize: 14, fontWeight: "700", color: colors.brand },

  allocSection: { backgroundColor: "white", borderRadius: 16, padding: 20, marginTop: 8 },
  allocTitle:   { fontSize: 15, fontWeight: "800", color: colors.text, marginBottom: 14 },
  allocRow:     { flexDirection: "row", alignItems: "center", gap: 10, marginBottom: 10 },
  allocIcon:    { fontSize: 20, width: 28 },
  allocLabel:   { width: 110, fontSize: 13, fontWeight: "600", color: colors.text },
  allocBarBg:   { flex: 1, height: 8, backgroundColor: "#f0f0f0", borderRadius: 4, overflow: "hidden" },
  allocBar:     { height: 8, backgroundColor: colors.brand, borderRadius: 4 },
  allocMins:    { width: 52, fontSize: 12, color: colors.textMuted, textAlign: "right" },

  emptyTitle: { fontSize: 22, fontWeight: "800", color: colors.text, marginTop: 16, textAlign: "center" },
  emptySub:   { fontSize: 14, color: colors.textMuted, textAlign: "center", lineHeight: 22, marginTop: 8 },
});
