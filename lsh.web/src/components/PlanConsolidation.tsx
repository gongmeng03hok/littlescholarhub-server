/**
 * PlanConsolidation — full "plan done" screen matching the reference portal.
 * Shows: Daily target · About your child · Time by subject · Week tracker
 */
import { useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet, Platform } from "react-native";
import Svg, { Path } from "react-native-svg";
import { colors } from "../constants/theme";
import { AchievementsWall } from "./AchievementsWall";

// ── Week tracker helpers ─────────────────────────────────────────────────────

function startOfWeek(d: Date): Date {
  const x = new Date(d);
  const diff = (x.getDay() + 6) % 7; // Monday = 0
  x.setHours(0, 0, 0, 0);
  x.setDate(x.getDate() - diff);
  return x;
}
function ymd(d: Date): string { return d.toISOString().slice(0, 10); }

const DAY_LABELS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

// ── Types ────────────────────────────────────────────────────────────────────

interface Subject {
  key: string; label: string; icon: string; color: string;
  minutes: number; note: string;
  sessions_per_week?: number; session_min?: number;
}
interface About {
  age: string; grade: string; interest: string; language: string; goal: string;
}
interface Plan {
  daily_min: number; weekly_hrs: number; study_days: number; sessions_per_day: number;
  kind?: string; subjects: Subject[]; about: About;
  /** Subjects the week is too short to fit yet - named so they are not silently dropped. */
  rotates_in?: string[]; session_min?: number; sessions_total?: number;
}

interface Props {
  plan: Plan;
  /** CTA slot — rendered below the tracker (register CTA for guests, navigate buttons for authed) */
  cta: React.ReactNode;
  /** When provided, shows the child's earned achievement badges below the tracker */
  childId?: number;
}

// ── Component ────────────────────────────────────────────────────────────────

export function PlanConsolidation({ plan, cta, childId }: Props) {
  const [checked, setChecked] = useState<Record<string, boolean>>({});

  const today    = new Date(); today.setHours(0, 0, 0, 0);
  const weekStart = startOfWeek(today);

  const weekDone   = Object.values(checked).filter(Boolean).length;
  const totalHours = weekDone * (plan.daily_min / 60);
  const todayKey   = ymd(today);
  const todayDone  = !!checked[todayKey];

  const maxMins = Math.max(...plan.subjects.map(s => s.minutes), 1);

  const toggle = (key: string, isFuture: boolean) => {
    if (isFuture) return;
    setChecked(prev => ({ ...prev, [key]: !prev[key] }));
  };

  return (
    <ScrollView style={s.root} contentContainerStyle={s.scroll} showsVerticalScrollIndicator={false}>

      {/* ── Hand-drawn highlight around the plan + tracker ─────────────── */}
      <View style={s.highlightWrap}>
      <View pointerEvents="none" style={StyleSheet.absoluteFill}>
        <Svg width="100%" height="100%" viewBox="0 0 400 900" preserveAspectRatio="none">
          <Path
            d="M150,14 C60,8 18,60 14,140 C8,260 6,420 10,560
               C14,680 40,780 130,820 C220,858 320,850 372,780
               C398,742 392,660 388,560 C384,430 392,300 380,180
               C372,96 340,40 260,20 C220,10 190,16 150,14"
            stroke="#FFE14D"
            strokeWidth={14}
            fill="none"
            strokeLinecap="round"
            strokeLinejoin="round"
            opacity={0.85}
          />
        </Svg>
      </View>

      {/* ── Top row: Daily target + About ─────────────────────────────── */}
      <View style={s.topRow}>
        {/* Dark daily target card */}
        <View style={s.targetCard}>
          <Text style={s.targetEyebrow}>Daily target</Text>
          <Text style={s.targetBig}>{plan.daily_min}</Text>
          <Text style={s.targetUnit}>MINUTES PER DAY</Text>
          <View style={s.targetStats}>
            <View style={s.targetStat}>
              <Text style={s.targetStatVal}>{plan.weekly_hrs} hrs</Text>
              <Text style={s.targetStatLabel}>per week</Text>
            </View>
            <View style={s.targetStat}>
              <Text style={s.targetStatVal}>{plan.study_days}</Text>
              <Text style={s.targetStatLabel}>study days per week</Text>
            </View>
            <View style={s.targetStat}>
              <Text style={s.targetStatVal}>{plan.sessions_per_day}</Text>
              <Text style={s.targetStatLabel}>short sessions/day</Text>
            </View>
          </View>
        </View>

        {/* About your child */}
        <View style={s.aboutCard}>
          <Text style={s.aboutTitle}>About your child</Text>
          {[
            ["Age",       plan.about.age],
            ["Grade",     plan.about.grade],
            ["Interest",  plan.about.interest],
            ["Languages", plan.about.language],
            ["Goal",      plan.about.goal],
          ].map(([label, val]) => (
            <View key={label} style={s.aboutRow}>
              <Text style={s.aboutLabel}>{label}</Text>
              <Text style={s.aboutVal}>{val}</Text>
            </View>
          ))}
        </View>
      </View>

      {/* ── Time by subject ───────────────────────────────────────────── */}
      <Text style={s.sectionTitle}>Time by subject</Text>
      <View style={s.subjectGrid}>
        {plan.subjects.map(subj => (
          <View key={subj.key} style={s.subjectCard}>
            <View style={s.subjectRow}>
              <Text style={s.subjectName}>{subj.icon} {subj.label}</Text>
              <Text style={s.subjectMins}>
                {subj.minutes} min/wk
                {subj.sessions_per_week && subj.session_min
                  ? `  ·  ${subj.sessions_per_week}×${subj.session_min}min`
                  : ""}
              </Text>
            </View>
            <View style={s.barBg}>
              <View style={[s.barFill, {
                width: `${Math.round((subj.minutes / maxMins) * 100)}%` as any,
                backgroundColor: subj.color,
              }]} />
            </View>
            <Text style={s.subjectNote}>{subj.note}</Text>
          </View>
        ))}
      </View>
      {!!plan.rotates_in?.length && (
        <Text style={s.rotatesNote}>
          ↻ {plan.rotates_in.map(k => k.charAt(0).toUpperCase() + k.slice(1)).join(" · ")}
          {" "}rotate in as your week grows — every subject stays available.
        </Text>
      )}

      {/* ── Weekly tracker ────────────────────────────────────────────── */}
      <View style={s.trackerCard}>
        <Text style={s.trackerTitle}>This week's tracker</Text>
        <Text style={s.trackerSub}>
          Tap today's tile when your child finishes their session. Streaks are saved on this device.
        </Text>

        {/* Day tiles */}
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={s.daysScroll}>
          <View style={s.daysRow}>
            {Array.from({ length: 7 }).map((_, i) => {
              const d = new Date(weekStart);
              d.setDate(weekStart.getDate() + i);
              const key      = ymd(d);
              const isToday  = key === todayKey;
              const isFuture = d.getTime() > today.getTime();
              const done     = !!checked[key];
              return (
                <TouchableOpacity
                  key={key}
                  onPress={() => toggle(key, isFuture)}
                  activeOpacity={isFuture ? 1 : 0.8}
                  style={[
                    s.dayTile,
                    isToday && s.dayTileToday,
                    done && s.dayTileDone,
                  ]}
                >
                  <Text style={[s.dayLabel, done && s.dayLabelDone]}>{DAY_LABELS[i]}</Text>
                  <Text style={[s.dayNum,   done && s.dayNumDone]}>{d.getDate()}</Text>
                  <Text style={[s.dayCheck, done && s.dayCheckDone]}>
                    {done ? "✓" : "○"}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </ScrollView>

        {/* Stats row */}
        <View style={s.statsRow}>
          {[
            { label: "TODAY",        val: todayDone ? "Done ✓" : "Pending" },
            { label: "THIS WEEK",    val: `${weekDone}/${plan.study_days}` },
            { label: "HOURS LOGGED", val: Number(totalHours).toFixed(1) },
            { label: "STREAK",       val: `${weekDone} 🔥` },
          ].map(({ label, val }) => (
            <View key={label} style={s.statBox}>
              <Text style={s.statLabel}>{label}</Text>
              <Text style={s.statVal}>{val}</Text>
            </View>
          ))}
        </View>
      </View>

      <AchievementsWall childId={childId} />
      </View>

      {/* ── CTA slot ──────────────────────────────────────────────────── */}
      <View style={s.ctaWrap}>{cta}</View>

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

// ── Styles ───────────────────────────────────────────────────────────────────

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#faf6ef" },
  scroll: { padding: 16, paddingTop: Platform.OS === "ios" ? 20 : 16 },

  highlightWrap: { position: "relative" },

  // ── Top row ────────────────────────────────────────────────
  topRow: { flexDirection: "row", gap: 12, marginBottom: 24, flexWrap: "wrap" },

  targetCard: {
    flex: 1, minWidth: 180,
    backgroundColor: "#2b2a27", borderRadius: 18, padding: 20,
  },
  targetEyebrow: { fontSize: 12, fontWeight: "700", color: "#e6c76a",
                   textTransform: "uppercase", letterSpacing: 0.8, marginBottom: 6 },
  targetBig:     { fontSize: 64, fontWeight: "900", color: "#e6c76a", lineHeight: 72,
                   fontFamily: Platform.OS === "web" ? "'Fraunces', Georgia, serif" : undefined },
  targetUnit:    { fontSize: 11, fontWeight: "700", color: "rgba(255,255,255,0.5)",
                   letterSpacing: 1.2, marginBottom: 16 },
  targetStats:   { gap: 8 },
  targetStat:    { flexDirection: "row", alignItems: "baseline", gap: 6 },
  targetStatVal: { fontSize: 18, fontWeight: "800", color: "#fff" },
  targetStatLabel:{ fontSize: 11, color: "rgba(255,255,255,0.55)" },

  aboutCard: {
    flex: 1, minWidth: 180,
    backgroundColor: "#fff", borderRadius: 18, padding: 20,
    borderWidth: 1, borderColor: colors.border,
  },
  aboutTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 14 },
  aboutRow:   { flexDirection: "row", justifyContent: "space-between",
                paddingVertical: 5, borderBottomWidth: 1, borderBottomColor: "#f2eadf",
                gap: 8, flexWrap: "wrap" },
  aboutLabel: { fontSize: 13, color: colors.textMuted, fontWeight: "500", minWidth: 70 },
  aboutVal:   { fontSize: 13, fontWeight: "700", color: colors.brand, flex: 1, textAlign: "right" },

  rotatesNote: {
    fontSize: 12, color: colors.textMuted, fontStyle: "italic",
    marginTop: 8, marginBottom: 4, lineHeight: 17,
  },

  // ── Time by subject ─────────────────────────────────────────
  sectionTitle: { fontSize: 17, fontWeight: "800", color: colors.text, marginBottom: 12 },
  subjectGrid:  { flexDirection: "row", flexWrap: "wrap", gap: 10, marginBottom: 24 },
  subjectCard:  {
    width: Platform.OS === "web" ? "31%" : "48%",
    backgroundColor: "#fff", borderRadius: 14, padding: 14,
    borderWidth: 1, borderColor: colors.border,
    minWidth: 140,
  },
  subjectRow:   { flexDirection: "row", justifyContent: "space-between",
                  alignItems: "flex-start", marginBottom: 8 },
  subjectName:  { flex: 1, fontSize: 13, fontWeight: "700", color: colors.text, lineHeight: 18 },
  subjectMins:  { fontSize: 12, fontWeight: "700", color: colors.brand, marginLeft: 4 },
  barBg:        { height: 5, backgroundColor: "#f2eadf", borderRadius: 3, overflow: "hidden", marginBottom: 8 },
  barFill:      { height: 5, borderRadius: 3 },
  subjectNote:  { fontSize: 11, color: colors.textMuted, lineHeight: 16 },

  // ── Tracker ─────────────────────────────────────────────────
  trackerCard: {
    backgroundColor: "#fff8f1", borderRadius: 18, padding: 20,
    borderWidth: 1, borderColor: colors.border, marginBottom: 20,
  },
  trackerTitle: { fontSize: 17, fontWeight: "800", color: colors.text, marginBottom: 4 },
  trackerSub:   { fontSize: 12, color: colors.textMuted, lineHeight: 18, marginBottom: 16 },

  daysScroll: { marginBottom: 16 },
  daysRow:    { flexDirection: "row", gap: 8 },
  dayTile:    {
    width: 64, alignItems: "center", paddingVertical: 12, paddingHorizontal: 8,
    backgroundColor: "#fff", borderRadius: 14,
    borderWidth: 1.5, borderColor: colors.border,
  },
  dayTileToday: { borderColor: colors.brand },
  dayTileDone:  { backgroundColor: "#f2eadf", borderColor: colors.brand },
  dayLabel:     { fontSize: 10, fontWeight: "700", color: colors.textMuted,
                  letterSpacing: 0.5, marginBottom: 6 },
  dayLabelDone: { color: colors.brand },
  dayNum:       { fontSize: 20, fontWeight: "800", color: colors.text, marginBottom: 6 },
  dayNumDone:   { color: colors.brand },
  dayCheck:     { fontSize: 14, color: colors.textMuted },
  dayCheckDone: { color: colors.brand, fontWeight: "800" },

  statsRow: { flexDirection: "row", flexWrap: "wrap", gap: 10 },
  statBox:  {
    flex: 1, minWidth: 80,
    backgroundColor: "#fff", borderRadius: 12, padding: 12,
    borderWidth: 1, borderColor: colors.border,
  },
  statLabel: { fontSize: 9, fontWeight: "700", color: colors.textMuted,
               letterSpacing: 1, textTransform: "uppercase", marginBottom: 4 },
  statVal:   { fontSize: 18, fontWeight: "800", color: colors.text },

  ctaWrap: { gap: 12 },
});
