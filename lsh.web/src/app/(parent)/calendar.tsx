/**
 * Calendar — a month of one child's learning, and what is still outstanding.
 *
 * Progress already answers "how did this week go" with a 7-day bar chart. A
 * parent planning the fortnight ahead is asking something the bar chart cannot
 * show: which days we actually sat down, which days we skipped, and what was
 * set but never finished. That shape is a month grid.
 *
 * Interactive, not a report: tap a day to see what happened on it, tick off an
 * assignment from that sheet, or jump straight to the worksheet library to set
 * something new.
 */
import { useMemo, useState } from "react";
import {
  ScrollView, View, Text, TouchableOpacity, StyleSheet,
  ActivityIndicator, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { useChildren } from "../../hooks/useChildren";
import { useCalendarMonth, useAssignments, useCompleteAssignment } from "../../hooks/useApi";
import { EmptyState } from "../../components/ui/EmptyState";
import { colors, SUBJECT_META } from "../../constants/theme";

const WEEKDAYS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
const MONTHS = ["January", "February", "March", "April", "May", "June",
                "July", "August", "September", "October", "November", "December"];

function pad2(n: number) { return String(n).padStart(2, "0"); }
function ymOf(d: Date) { return `${d.getFullYear()}-${pad2(d.getMonth() + 1)}`; }
function isoOf(d: Date) { return `${ymOf(d)}-${pad2(d.getDate())}`; }

/** Parse YYYY-MM-DD as a LOCAL date. `new Date("2026-08-01")` is parsed as UTC
 *  and lands on July 31 for anyone west of Greenwich, which silently shifts
 *  every cell in the grid by one day. */
function localDate(iso: string) {
  const [y, m, d] = iso.split("-").map(Number);
  return new Date(y, m - 1, d);
}

/** Normalise whatever the API sent to a YYYY-MM-DD key.
 *
 *  It sends dates two ways. A SQL DATE (session_date) comes back as
 *  "2026-08-03", but a DATETIME2 (assigned_at, completed_at) comes back as
 *  RFC-1123 — "Sun, 02 Aug 2026 00:00:00 GMT" — because that is what Flask's
 *  jsonify emits. Slicing ten characters off the second gives "Sun, 02 Au",
 *  so every assignment date read "Invalid Date" and none of them ever matched
 *  a day in the grid. Read it back in UTC: it is UTC midnight, and converting
 *  to local time would move it to the previous day west of Greenwich. */
function toIsoKey(value?: string | null): string | null {
  if (!value) return null;
  if (/^\d{4}-\d{2}-\d{2}/.test(value)) return value.slice(0, 10);
  const t = Date.parse(value);
  if (Number.isNaN(t)) return null;
  const d = new Date(t);
  return `${d.getUTCFullYear()}-${pad2(d.getUTCMonth() + 1)}-${pad2(d.getUTCDate())}`;
}

/** "Aug 2", or nothing at all rather than "Invalid Date". */
function shortDate(value?: string | null): string {
  const iso = toIsoKey(value);
  return iso ? localDate(iso).toLocaleDateString("en-US", { month: "short", day: "numeric" }) : "";
}

type Day = {
  date: string; minutes: number; sessions: number;
  subjects: string[]; assigned: number; completed: number;
};

export default function CalendarScreen() {
  useChildren();                       // hydrate on a cold reload or deep link
  const router = useRouter();
  const { activeChild } = useChildStore();
  const childId = activeChild?.child_id;

  const [cursor, setCursor] = useState(() => new Date());
  const [picked, setPicked] = useState<string | null>(null);

  const month = ymOf(cursor);
  const { data, isLoading } = useCalendarMonth(childId, month);
  const { data: assignments } = useAssignments(childId);
  const complete = useCompleteAssignment();

  const todayIso = isoOf(new Date());

  /** Six weeks of cells, Sunday-first, with leading/trailing blanks so the
   *  weekday columns line up. */
  const cells = useMemo(() => {
    const days: Day[] = data?.days ?? [];
    if (!days.length) return [];
    const lead = localDate(days[0].date).getDay();
    const out: (Day | null)[] = Array(lead).fill(null);
    out.push(...days);
    while (out.length % 7 !== 0) out.push(null);
    return out;
  }, [data]);

  const byDate = useMemo(() => {
    const m: Record<string, Day> = {};
    for (const d of data?.days ?? []) m[d.date] = d;
    return m;
  }, [data]);

  /** Assignments grouped onto the day they were set, and the day they were
   *  finished — an assignment set on the 3rd and done on the 6th belongs to
   *  both, which is exactly what a parent wants to see. */
  const dayAssignments = useMemo(() => {
    const set: Record<string, any[]> = {};
    const done: Record<string, any[]> = {};
    for (const a of assignments ?? []) {
      const setOn = toIsoKey(a.assigned_at);
      const doneOn = toIsoKey(a.completed_at);
      if (setOn) (set[setOn] ||= []).push(a);
      if (doneOn) (done[doneOn] ||= []).push(a);
    }
    return { set, done };
  }, [assignments]);

  const outstanding = useMemo(
    () => (assignments ?? []).filter((a: any) => !a.completed_at),
    [assignments]
  );

  if (!childId) {
    return <EmptyState emoji="👶" title="No child selected"
      body="Add a child from the Family tab to see their calendar." />;
  }

  const shift = (months: number) => {
    setPicked(null);
    setCursor(new Date(cursor.getFullYear(), cursor.getMonth() + months, 1));
  };

  const totals = data?.totals ?? { days_active: 0, minutes: 0, sessions: 0, completed: 0 };
  const streak = data?.streak ?? { current_streak: 0, longest_streak: 0, last_active: null };
  const pickedDay = picked ? byDate[picked] : null;

  return (
    <ScrollView style={s.root} contentContainerStyle={s.content} showsVerticalScrollIndicator={false}>
      <View style={s.header}>
        <Text style={s.h1}>Calendar</Text>
        <Text style={s.sub}>{activeChild?.nickname ?? "Your child"}'s month at a glance</Text>
      </View>

      {/* ── Month switcher ─────────────────────────────────────────────── */}
      <View style={s.monthBar}>
        <TouchableOpacity onPress={() => shift(-1)} style={s.navBtn} accessibilityLabel="Previous month">
          <Text style={s.navTxt}>‹</Text>
        </TouchableOpacity>
        <Text style={s.monthTxt}>{MONTHS[cursor.getMonth()]} {cursor.getFullYear()}</Text>
        <TouchableOpacity onPress={() => shift(1)} style={s.navBtn} accessibilityLabel="Next month">
          <Text style={s.navTxt}>›</Text>
        </TouchableOpacity>
      </View>

      {/* ── The month ──────────────────────────────────────────────────── */}
      <View style={s.card}>
        <View style={s.weekRow}>
          {WEEKDAYS.map(w => <Text key={w} style={s.weekday}>{w}</Text>)}
        </View>

        {isLoading ? (
          <View style={s.loading}><ActivityIndicator color={colors.brand} /></View>
        ) : (
          <View style={s.grid}>
            {cells.map((day, i) => {
              if (!day) return <View key={`blank${i}`} style={s.cell} />;
              const n = Number(day.date.slice(8));
              const isToday = day.date === todayIso;
              const isPicked = day.date === picked;
              const studied = day.sessions > 0;
              const owed = (dayAssignments.set[day.date] ?? [])
                .filter((a: any) => !a.completed_at).length;
              return (
                <TouchableOpacity
                  key={day.date}
                  style={[s.cell, studied && s.cellStudied, isToday && s.cellToday,
                          isPicked && s.cellPicked]}
                  onPress={() => setPicked(isPicked ? null : day.date)}
                  accessibilityLabel={
                    `${MONTHS[cursor.getMonth()]} ${n}: ` +
                    (studied ? `${day.minutes} minutes over ${day.sessions} sessions` : "nothing logged") +
                    (owed ? `, ${owed} still to do` : "")}
                >
                  <Text style={[s.cellNum, studied && s.cellNumOn, isToday && s.cellNumToday]}>{n}</Text>
                  <View style={s.dots}>
                    {day.subjects.slice(0, 3).map((slug, k) => (
                      <View key={`${slug}${k}`}
                            style={[s.dot, { backgroundColor: SUBJECT_META[slug]?.color ?? colors.brandLight }]} />
                    ))}
                    {owed > 0 && <View style={[s.dot, s.dotOwed]} />}
                  </View>
                  {day.minutes > 0 && <Text style={s.cellMin}>{day.minutes}m</Text>}
                </TouchableOpacity>
              );
            })}
          </View>
        )}

        <View style={s.legend}>
          <View style={s.legendItem}>
            <View style={[s.dot, { backgroundColor: SUBJECT_META.math?.color }]} />
            <Text style={s.legendTxt}>a subject studied</Text>
          </View>
          <View style={s.legendItem}>
            <View style={[s.dot, s.dotOwed]} />
            <Text style={s.legendTxt}>set, not finished</Text>
          </View>
        </View>
      </View>

      {/* ── This month in four numbers ─────────────────────────────────── */}
      <View style={s.statRow}>
        <Stat value={String(totals.days_active)} label="days active" />
        <Stat value={String(Math.round(totals.minutes / 60 * 10) / 10)} label="hours" />
        <Stat value={String(totals.completed)} label="finished" />
        <Stat value={String(streak.current_streak)} label="day streak" />
      </View>

      {/* ── The day you tapped ─────────────────────────────────────────── */}
      {pickedDay && (
        <View style={s.card}>
          <Text style={s.cardTitle}>
            {localDate(pickedDay.date).toLocaleDateString("en-US",
              { weekday: "long", month: "long", day: "numeric" })}
          </Text>

          {pickedDay.sessions > 0 ? (
            <Text style={s.dayLine}>
              {pickedDay.minutes} minutes across {pickedDay.sessions}{" "}
              {pickedDay.sessions === 1 ? "session" : "sessions"}
              {pickedDay.subjects.length
                ? ` — ${pickedDay.subjects.map(x => SUBJECT_META[x]?.label ?? x).join(", ")}`
                : ""}
            </Text>
          ) : (
            <Text style={[s.dayLine, s.dayLineQuiet]}>Nothing logged on this day.</Text>
          )}

          {(dayAssignments.done[pickedDay.date] ?? []).map((a: any) => (
            <View key={`done${a.assignment_id}`} style={s.assignRow}>
              <Text style={s.tick}>✓</Text>
              <Text style={s.assignTxt}>{a.worksheet_title ?? "Assignment"}</Text>
            </View>
          ))}

          {(dayAssignments.set[pickedDay.date] ?? [])
            .filter((a: any) => !a.completed_at)
            .map((a: any) => (
              <View key={`todo${a.assignment_id}`} style={s.assignRow}>
                <TouchableOpacity
                  style={s.checkbox}
                  disabled={complete.isPending}
                  onPress={() => complete.mutate({ assignmentId: a.assignment_id, childId })}
                  accessibilityLabel={`Mark ${a.worksheet_title ?? "assignment"} as done`}
                />
                <Text style={s.assignTxt}>{a.worksheet_title ?? "Assignment"}</Text>
                <Text style={s.assignTag}>{a.source === "teacher" ? "teacher" : "set by you"}</Text>
              </View>
            ))}

          <TouchableOpacity style={s.action} onPress={() => router.push("/(parent)/content")}>
            <Text style={s.actionTxt}>Find something to set →</Text>
          </TouchableOpacity>
        </View>
      )}

      {/* ── Still outstanding, whatever month you are looking at ───────── */}
      {outstanding.length > 0 && (
        <View style={s.card}>
          <Text style={s.cardTitle}>Still to do ({outstanding.length})</Text>
          <Text style={s.cardSub}>
            Assignments carry no due date, so they sit here until they are ticked off.
          </Text>
          {outstanding.slice(0, 6).map((a: any) => (
            <View key={a.assignment_id} style={s.assignRow}>
              <TouchableOpacity
                style={s.checkbox}
                disabled={complete.isPending}
                onPress={() => complete.mutate({ assignmentId: a.assignment_id, childId })}
                accessibilityLabel={`Mark ${a.worksheet_title ?? "assignment"} as done`}
              />
              <Text style={s.assignTxt}>{a.worksheet_title ?? "Assignment"}</Text>
              <Text style={s.assignTag}>{shortDate(a.assigned_at)}</Text>
            </View>
          ))}
          {outstanding.length > 6 && (
            <TouchableOpacity style={s.action} onPress={() => router.push("/(parent)/assignments")}>
              <Text style={s.actionTxt}>See all {outstanding.length} →</Text>
            </TouchableOpacity>
          )}
        </View>
      )}
    </ScrollView>
  );
}

function Stat({ value, label }: { value: string; label: string }) {
  return (
    <View style={s.stat}>
      <Text style={s.statVal}>{value}</Text>
      <Text style={s.statLbl}>{label}</Text>
    </View>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: colors.bg },
  content: { padding: 16, paddingBottom: 48, maxWidth: 720, width: "100%", alignSelf: "center" },

  header: { marginBottom: 12 },
  h1:  { fontSize: 28, fontWeight: "900", color: colors.text },
  sub: { fontSize: 14, color: colors.textMuted, marginTop: 2 },

  monthBar: { flexDirection: "row", alignItems: "center", justifyContent: "space-between",
              marginBottom: 10 },
  navBtn:  { width: 40, height: 40, borderRadius: 20, alignItems: "center", justifyContent: "center",
             backgroundColor: colors.surface, borderWidth: 1, borderColor: colors.border },
  navTxt:  { fontSize: 22, fontWeight: "900", color: colors.brand, lineHeight: 24 },
  monthTxt:{ fontSize: 18, fontWeight: "800", color: colors.text },

  card: { backgroundColor: colors.surface, borderRadius: 18, padding: 14, marginBottom: 14,
          borderWidth: 1, borderColor: colors.border },
  cardTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 4 },
  cardSub:   { fontSize: 13, color: colors.textMuted, marginBottom: 8 },

  weekRow:  { flexDirection: "row" },
  weekday:  { flex: 1, textAlign: "center", fontSize: 11, fontWeight: "800",
              color: colors.textMuted, marginBottom: 6 },
  grid:     { flexDirection: "row", flexWrap: "wrap" },
  loading:  { paddingVertical: 40, alignItems: "center" },

  // 100/7 written out: a computed template string widens to `string`, which is
  // not assignable to RN's DimensionValue, and the build typechecks first.
  cell: { width: "14.28%", aspectRatio: 0.92, alignItems: "center", justifyContent: "flex-start",
          paddingTop: 4, borderRadius: 10 },
  cellStudied: { backgroundColor: colors.brandLight },
  cellToday:   { borderWidth: 2, borderColor: colors.brand },
  cellPicked:  { backgroundColor: colors.surfaceAlt },
  cellNum:      { fontSize: 13, fontWeight: "700", color: colors.textMuted },
  cellNumOn:    { color: colors.text, fontWeight: "800" },
  cellNumToday: { color: colors.brand, fontWeight: "900" },
  cellMin: { fontSize: 9, color: colors.textMuted, marginTop: 1 },

  dots: { flexDirection: "row", gap: 2, marginTop: 3, minHeight: 8 },
  dot:  { width: 6, height: 6, borderRadius: 3, backgroundColor: colors.brandLight },
  dotOwed: { backgroundColor: colors.accent, borderWidth: 1, borderColor: colors.brandDark },

  legend:     { flexDirection: "row", gap: 16, marginTop: 10, justifyContent: "center" },
  legendItem: { flexDirection: "row", alignItems: "center", gap: 5 },
  legendTxt:  { fontSize: 11, color: colors.textMuted },

  statRow: { flexDirection: "row", gap: 8, marginBottom: 14 },
  stat:    { flex: 1, backgroundColor: colors.surface, borderRadius: 14, paddingVertical: 12,
             alignItems: "center", borderWidth: 1, borderColor: colors.border },
  statVal: { fontSize: 20, fontWeight: "900", color: colors.brand },
  statLbl: { fontSize: 10, color: colors.textMuted, marginTop: 2, textAlign: "center" },

  dayLine:      { fontSize: 14, color: colors.text, marginBottom: 8 },
  dayLineQuiet: { color: colors.textMuted },

  assignRow: { flexDirection: "row", alignItems: "center", gap: 8, paddingVertical: 7,
               borderTopWidth: 1, borderTopColor: colors.border },
  checkbox:  { width: 20, height: 20, borderRadius: 6, borderWidth: 2,
               borderColor: colors.brand, ...(Platform.OS === "web" ? { cursor: "pointer" } as any : {}) },
  tick:      { width: 20, textAlign: "center", fontSize: 15, color: colors.success, fontWeight: "900" },
  assignTxt: { flex: 1, fontSize: 14, color: colors.text },
  assignTag: { fontSize: 11, color: colors.textMuted },

  action:    { marginTop: 10 },
  actionTxt: { fontSize: 14, fontWeight: "800", color: colors.brand },
});
