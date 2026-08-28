/**
 * Math Weekly screen — 5-day packet, drill, topics.
 * Data from GET /api/math/week, /api/math/drill, /api/math/topics
 */
import { useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useQuery } from "@tanstack/react-query";
import http from "../../api/client";
import { questionsApi } from "../../api/questions";
import { useChildStore }  from "../../store/childStore";
import { Button }         from "../../components/ui/Button";
import { colors }         from "../../constants/theme";

type Tab = "week" | "drill" | "topics" | "dynamic";

export default function MathScreen() {
  const router = useRouter();
  const { activeChild } = useChildStore();
  const grade   = activeChild?.grade_id ?? 2;
  const [tab, setTab] = useState<Tab>("week");

  const { data: weekData, isLoading: weekLoading } = useQuery({
    queryKey: ["mathWeek", grade],
    queryFn:  () => http.get(`/math/week?grade=${grade}`) as Promise<any>,
    enabled:  tab === "week",
    staleTime: 60 * 60 * 1000,
  });

  const { data: drillData, isLoading: drillLoading } = useQuery({
    queryKey: ["mathDrill", grade],
    queryFn:  () => http.get(`/math/drill?grade=${grade}`) as Promise<any>,
    enabled:  tab === "drill",
    staleTime: 0,
  });

  const { data: topicsData, isLoading: topicsLoading } = useQuery({
    queryKey: ["mathTopics", grade],
    queryFn:  () => http.get(`/math/topics?grade=${grade}`) as Promise<any>,
    enabled:  tab === "topics",
    staleTime: 24 * 60 * 60 * 1000,
  });

  const { data: dynamicData, isLoading: dynamicLoading } = useQuery({
    queryKey: ["dynamicMath", grade],
    queryFn:  () => questionsApi.getDynamicMath(grade, 5),
    enabled:  tab === "dynamic",
    staleTime: 0,
  });

  const TABS: { key: Tab; label: string; emoji: string }[] = [
    { key: "week",     label: "5-Day Packet", emoji: "📅" },
    { key: "drill",    label: "Timed Drill",  emoji: "⚡" },
    { key: "topics",   label: "Topics",       emoji: "📚" },
    { key: "dynamic",  label: "Dynamic Qs",   emoji: "🧠" },
  ];

  return (
    <View style={s.root}>
      {/* Header */}
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
          <Text style={s.backBtn}>←</Text>
        </TouchableOpacity>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>🧮 Math Weekly</Text>
          <Text style={s.sub}>Grade {activeChild?.grade_label ?? grade} · {activeChild?.nickname}</Text>
        </View>
      </View>

      {/* Tabs */}
      <View style={s.tabRow}>
        {TABS.map(t => (
          <TouchableOpacity key={t.key} onPress={() => setTab(t.key)}
            style={[s.tabBtn, tab === t.key && s.tabBtnActive]}>
            <Text style={[s.tabText, tab === t.key && s.tabTextActive]}>
              {t.emoji} {t.label}
            </Text>
          </TouchableOpacity>
        ))}
      </View>

      {/* Week tab */}
      {tab === "week" && (
        weekLoading
          ? <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
          : <WeekView data={weekData} grade={grade} router={router} />
      )}

      {/* Drill tab */}
      {tab === "drill" && (
        drillLoading
          ? <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
          : <DrillView data={drillData} />
      )}

      {/* Topics tab */}
      {tab === "topics" && (
        topicsLoading
          ? <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
          : <TopicsView data={topicsData ?? []} grade={grade} router={router} />
      )}

      {/* Dynamic questions tab */}
      {tab === "dynamic" && (
        dynamicLoading
          ? <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
          : <DynamicQuestionsView data={dynamicData} />
      )}
    </View>
  );
}

// ── Week view ────────────────────────────────────────────────
function WeekView({ data, grade, router }: any) {
  const [openDay, setOpenDay] = useState<string | null>(null);
  if (!data) return <EmptyMsg msg="No packet this week yet." />;

  const days: [string, any][] = Object.entries(data.days ?? {});

  return (
    <ScrollView contentContainerStyle={w.scroll} showsVerticalScrollIndicator={false}>
      {/* Week header */}
      <View style={w.weekHeader}>
        <Text style={w.weekTitle}>{data.topic ?? "Weekly Math"}</Text>
        <Text style={w.weekMeta}>Week {data.week ?? "—"} · Grade {grade} · {days.length} days</Text>
      </View>

      {/* Days */}
      {days.map(([dayName, dayData]: [string, any]) => (
        <TouchableOpacity key={dayName}
          onPress={() => setOpenDay(openDay === dayName ? null : dayName)}
          style={w.dayCard} activeOpacity={0.85}>
          <View style={w.dayHeader}>
            <Text style={w.dayName}>{dayName}</Text>
            <Text style={w.dayMeta}>{dayData?.questions?.length ?? 0} questions</Text>
            <Text style={w.dayArrow}>{openDay === dayName ? "▲" : "▼"}</Text>
          </View>
          {openDay === dayName && (dayData?.questions ?? []).map((q: any, i: number) => (
            <View key={i} style={w.qRow}>
              <Text style={w.qNum}>{i + 1}.</Text>
              <Text style={w.qText}>{q.question_text ?? q.text}</Text>
            </View>
          ))}
        </TouchableOpacity>
      ))}

      {/* PDF download link */}
      {data.pdf_url && (
        <Button label="📄  Download PDF packet" onPress={() => {}}
          variant="outline" fullWidth style={{ marginTop: 8 }} />
      )}

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

// ── Drill view ───────────────────────────────────────────────
function DrillView({ data }: any) {
  const [revealed, setRevealed] = useState<Set<number>>(new Set());
  if (!data) return <EmptyMsg msg="No drill available." />;

  const problems: any[] = data.problems ?? [];

  return (
    <ScrollView contentContainerStyle={w.scroll} showsVerticalScrollIndicator={false}>
      <View style={w.weekHeader}>
        <Text style={w.weekTitle}>⚡ Timed Drill</Text>
        <Text style={w.weekMeta}>{problems.length} problems · tap to reveal answer</Text>
      </View>
      <View style={w.drillGrid}>
        {problems.map((p: any, i: number) => (
          <TouchableOpacity key={i} style={w.drillCard}
            onPress={() => setRevealed(r => { const n = new Set(r); n.has(i) ? n.delete(i) : n.add(i); return n; })}>
            <Text style={w.drillQ}>{p.question_text ?? p.text}</Text>
            {revealed.has(i) && <Text style={w.drillA}>{p.correct_answer}</Text>}
          </TouchableOpacity>
        ))}
      </View>
      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

// ── Topics view ──────────────────────────────────────────────
function TopicsView({ data, grade, router }: any) {
  const topics = data?.schedule ?? [];
  if (!topics.length) return <EmptyMsg msg="No topics loaded." />;
  return (
    <ScrollView contentContainerStyle={w.scroll} showsVerticalScrollIndicator={false}>
      <Text style={[w.weekTitle, { marginBottom: 16 }]}>Topic schedule · Grade {grade}</Text>
      {topics.map((topic: any, i: number) => (
        <TouchableOpacity key={i} style={w.topicCard}
          onPress={() => router.push({ pathname: "/(parent)/practice/[subject]",
            params: { subject: "math", grade } })}>
          <View style={w.topicLeft}>
            <Text style={w.topicWeek}>Week {topic.week_in_cycle ?? i + 1}</Text>
            <Text style={w.topicTitle}>{topic.label ?? topic.slug}</Text>
            {topic.description && <Text style={w.topicDesc}>{topic.description}</Text>}
          </View>
          <Text style={{ color: colors.brand, fontSize: 18 }}>→</Text>
        </TouchableOpacity>
      ))}
      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

function DynamicQuestionsView({ data }: any) {
  const questions: any[] = data?.questions ?? [];
  if (!questions.length) return <EmptyMsg msg="No dynamic questions available yet." />;

  return (
    <ScrollView contentContainerStyle={w.scroll} showsVerticalScrollIndicator={false}>
      <View style={w.weekHeader}>
        <Text style={w.weekTitle}>🧠 Dynamic Math Questions</Text>
        <Text style={w.weekMeta}>{questions.length} formula-based questions from the database</Text>
      </View>
      {questions.map((q: any, i: number) => (
        <View key={`${q.template_id ?? i}-${i}`} style={w.dayCard}>
          <Text style={w.qText}>{i + 1}. {q.question_text}</Text>
          {q.hint ? <Text style={w.topicDesc}>Hint: {q.hint}</Text> : null}
          <Text style={[w.topicWeek, { marginTop: 8 }]}>Answer: {q.correct_answer}</Text>
        </View>
      ))}
      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

function EmptyMsg({ msg }: { msg: string }) {
  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center", padding: 40 }}>
      <Text style={{ fontSize: 44 }}>🧮</Text>
      <Text style={{ fontSize: 16, color: colors.textMuted, textAlign: "center", marginTop: 12 }}>{msg}</Text>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 16, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center", gap: 8,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn: { fontSize: 22, color: colors.brand, fontWeight: "700" },
  title:   { fontSize: 20, fontWeight: "900", color: colors.text },
  sub:     { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  tabRow:  { flexDirection: "row", backgroundColor: "white", paddingHorizontal: 12, paddingVertical: 8,
             borderBottomWidth: 1, borderBottomColor: colors.border, gap: 6 },
  tabBtn:       { flex: 1, paddingVertical: 8, borderRadius: 10, alignItems: "center",
                  backgroundColor: "#f0f0f0" },
  tabBtnActive: { backgroundColor: colors.brand },
  tabText:      { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  tabTextActive:{ color: "white" },
});

const w = StyleSheet.create({
  scroll:      { padding: 16, gap: 12 },
  weekHeader:  { backgroundColor: "white", borderRadius: 16, padding: 20, marginBottom: 4 },
  weekTitle:   { fontSize: 18, fontWeight: "900", color: colors.text },
  weekMeta:    { fontSize: 13, color: colors.textMuted, marginTop: 4 },

  dayCard:   { backgroundColor: "white", borderRadius: 14, padding: 16 },
  dayHeader: { flexDirection: "row", alignItems: "center" },
  dayName:   { flex: 1, fontSize: 15, fontWeight: "800", color: colors.text },
  dayMeta:   { fontSize: 12, color: colors.textMuted, marginRight: 8 },
  dayArrow:  { fontSize: 14, color: colors.brand },
  qRow:      { flexDirection: "row", gap: 8, marginTop: 10, paddingTop: 10,
               borderTopWidth: 1, borderTopColor: colors.border },
  qNum:      { fontSize: 14, fontWeight: "700", color: colors.brand, width: 20 },
  qText:     { flex: 1, fontSize: 14, color: colors.text, lineHeight: 22 },

  drillGrid: { flexDirection: "row", flexWrap: "wrap", gap: 10 },
  drillCard: { width: "47%", backgroundColor: "white", borderRadius: 12, padding: 14, alignItems: "center" },
  drillQ:    { fontSize: 15, fontWeight: "700", color: colors.text, marginBottom: 6 },
  drillA:    { fontSize: 17, fontWeight: "900", color: colors.brand },

  topicCard:  { flexDirection: "row", alignItems: "center", backgroundColor: "white",
                borderRadius: 14, padding: 16 },
  topicLeft:  { flex: 1 },
  topicWeek:  { fontSize: 11, fontWeight: "800", color: colors.brand, letterSpacing: 1, marginBottom: 4 },
  topicTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  topicDesc:  { fontSize: 13, color: colors.textMuted, marginTop: 4, lineHeight: 20 },
});
