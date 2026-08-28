/**
 * Authenticated assessment wizard — 18 steps matching the reference portal.
 * Questions fetched from /api/assessment/questions (DB-driven, admin-editable).
 * Options: objects {v, label, emo?} rendered as 2-col emoji tiles.
 * Success screen: 3 starter activity tiles + links to plan.
 */
import { useState, useRef } from "react";
import {
  View, Text, ScrollView, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform, Animated,
} from "react-native";
import { useRouter } from "expo-router";
import { useQuery, useMutation } from "@tanstack/react-query";
import { assessmentApi }     from "../../api/assessment";
import { useChildStore }     from "../../store/childStore";
import { Button }            from "../../components/ui/Button";
import { PlanConsolidation } from "../../components/PlanConsolidation";
import { colors }            from "../../constants/theme";

type Opt = { v: string; label: string; emo?: string };

function toOpt(o: any): Opt {
  if (typeof o === "string") return { v: o, label: o };
  return o;
}

export default function AssessmentScreen() {
  const router = useRouter();
  const { activeChild } = useChildStore();

  const [step,       setStep]       = useState(0);
  const [answers,    setAnswers]    = useState<Record<string, any>>({});
  const [planResult, setPlanResult] = useState<any>(null);
  const progress                    = useRef(new Animated.Value(0)).current;

  const { data: questions = [], isLoading } = useQuery({
    queryKey: ["assessmentQuestions"],
    queryFn:  () => assessmentApi.getQuestions() as Promise<any[]>,
    staleTime: 60 * 60 * 1000,
  });

  const { mutate: submit, isPending: submitting } = useMutation({
    mutationFn: () =>
      assessmentApi.submit(activeChild?.child_id ?? 0, answers) as Promise<any>,
    onSuccess: (data) => setPlanResult(data),
  });

  const total   = questions.length || 18;
  const current = questions[step];

  const animateProgress = (next: number) =>
    Animated.timing(progress, {
      toValue: next / total, duration: 300, useNativeDriver: false,
    }).start();

  const selectAnswer = (value: string) => {
    if (!current) return;
    setAnswers(prev => ({ ...prev, [current.step]: value }));
    if (step + 1 >= questions.length) { animateProgress(total); return; }
    animateProgress(step + 1);
    setStep(s => s + 1);
  };

  const back = () => {
    if (step === 0) { router.back(); return; }
    animateProgress(step - 1);
    setStep(s => s - 1);
  };

  if (isLoading) {
    return (
      <View style={s.center}>
        <ActivityIndicator size="large" color={colors.brand} />
        <Text style={s.loadingText}>Loading assessment…</Text>
      </View>
    );
  }

  // ── Success screen (full consolidation) ────────────────────────────────────
  if (planResult?.plan) {
    return (
      <View style={{ flex: 1 }}>
        <View style={s.doneHeader}>
          <Text style={s.doneBadge}>
            🎉  {activeChild?.nickname ?? "Your child"}'s plan is ready!
          </Text>
        </View>
        <PlanConsolidation
          plan={planResult.plan}
          childId={activeChild?.child_id}
          cta={
            <>
              <Button
                label="See full weekly plan →"
                onPress={() => router.replace("/(parent)/plan")}
                fullWidth
              />
              <Button
                label="Back to home"
                onPress={() => router.replace("/(parent)")}
                variant="ghost"
                fullWidth
              />
            </>
          }
        />
      </View>
    );
  }

  if (questions.length === 0) {
    return (
      <View style={s.center}>
        <Text style={{ fontSize: 40 }}>📋</Text>
        <Text style={s.doneTitle}>Assessment</Text>
        <Text style={s.doneSub}>Could not load questions. Check your connection.</Text>
        <Button label="Back" onPress={() => router.back()} style={{ marginTop: 20 }} />
      </View>
    );
  }

  const opts: Opt[] = (current?.options ?? []).map(toOpt);
  const sel    = answers[current?.step];
  const isLast = step + 1 >= questions.length;

  return (
    <View style={s.root}>
      {/* Header */}
      <View style={s.header}>
        <TouchableOpacity onPress={back} hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}>
          <Text style={s.backBtn}>←</Text>
        </TouchableOpacity>
        <View style={{ flex: 1 }}>
          <Text style={s.stepLabel}>Question {step + 1} of {total}</Text>
          <Text style={s.eyebrow}>
            Building {activeChild?.nickname ?? "your child"}'s plan
          </Text>
        </View>
        <TouchableOpacity onPress={() => router.back()}>
          <Text style={s.closeBtn}>✕</Text>
        </TouchableOpacity>
      </View>

      {/* Progress bar */}
      <View style={s.barBg}>
        <Animated.View style={[s.barFill, {
          width: progress.interpolate({ inputRange: [0, 1], outputRange: ["0%", "100%"] }),
        }]} />
      </View>

      <ScrollView contentContainerStyle={s.scroll} keyboardShouldPersistTaps="handled">
        {/* Question */}
        <View style={s.questionCard}>
          {current?.subject && (
            <Text style={s.subjectTag}>{current.subject.toUpperCase()}</Text>
          )}
          <Text style={s.questionText}>{current?.text ?? ""}</Text>
          {!!current?.sub && <Text style={s.questionSub}>{current.sub}</Text>}
        </View>

        {/* 2-column emoji tile options */}
        <View style={s.optionsGrid}>
          {opts.map(opt => {
            const selected = sel === opt.v;
            return (
              <TouchableOpacity
                key={opt.v}
                onPress={() => selectAnswer(opt.v)}
                style={[s.optTile, selected && s.optTileActive]}
                activeOpacity={0.8}
              >
                {!!opt.emo && <Text style={s.optEmoji}>{opt.emo}</Text>}
                <Text style={[s.optLabel, selected && s.optLabelActive]}>{opt.label}</Text>
              </TouchableOpacity>
            );
          })}
        </View>

        {/* Footer */}
        <View style={s.footer}>
          {isLast && sel ? (
            <Button
              label={submitting ? "Building plan…" : "Build my plan →"}
              onPress={() => submit()}
              loading={submitting}
              fullWidth
              size="lg"
            />
          ) : (
            <TouchableOpacity
              onPress={() => setStep(s => Math.min(s + 1, total - 1))}
              style={s.skipBtn}
            >
              <Text style={s.skipBtnText}>Skip this question →</Text>
            </TouchableOpacity>
          )}
        </View>
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:        { flex: 1, backgroundColor: "#faf6ef" },
  center:      { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, backgroundColor: "#faf6ef" },
  loadingText: { marginTop: 16, color: colors.textMuted, fontSize: 15 },

  // ── Success header bar ──────────────────────────────────────
  doneHeader: {
    backgroundColor: colors.brand,
    paddingTop: Platform.OS === "ios" ? 56 : 20,
    paddingBottom: 14, paddingHorizontal: 20,
  },
  doneBadge:  { fontSize: 16, fontWeight: "800", color: "#fff", textAlign: "center" },
  doneTitle:  { fontSize: 22, fontWeight: "800", color: colors.text, textAlign: "center", marginTop: 12 },
  doneSub:    { fontSize: 14, color: colors.textMuted, textAlign: "center", lineHeight: 22 },

  // ── Wizard ──────────────────────────────────────────────────
  header:    { flexDirection: "row", alignItems: "center", gap: 12,
               backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
               paddingBottom: 16, paddingHorizontal: 20,
               borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn:   { fontSize: 22, color: colors.brand, fontWeight: "700" },
  stepLabel: { fontSize: 13, color: colors.textMuted, fontWeight: "700" },
  eyebrow:   { fontSize: 12, color: colors.brand, fontWeight: "600", marginTop: 2 },
  closeBtn:  { fontSize: 18, color: colors.textMuted },

  barBg:   { height: 8, backgroundColor: "#f2eadf" },
  barFill: { height: 8, backgroundColor: colors.brand, borderRadius: 999 },

  scroll:       { padding: 20, paddingBottom: 60 },
  questionCard: { marginBottom: 20 },
  subjectTag:   { fontSize: 11, fontWeight: "800", letterSpacing: 1.5, color: colors.brand, marginBottom: 8 },
  questionText: { fontSize: 28, fontWeight: "800", color: colors.text, lineHeight: 36,
                  fontFamily: Platform.OS === "web" ? "'Fraunces', Georgia, serif" : undefined },
  questionSub:  { fontSize: 14, color: colors.textMuted, marginTop: 8, lineHeight: 20 },

  optionsGrid: { flexDirection: "row", flexWrap: "wrap", gap: 10, marginBottom: 24 },
  optTile: {
    width: "48%", minHeight: 72,
    flexDirection: "row", alignItems: "center", gap: 10,
    backgroundColor: "white", borderRadius: 16,
    borderWidth: 1.5, borderColor: colors.border,
    padding: 14,
  },
  optTileActive: { borderColor: colors.brand, backgroundColor: "#fff6ef" },
  optEmoji:      { fontSize: 22, flexShrink: 0 },
  optLabel:      { flex: 1, fontSize: 13, fontWeight: "600", color: colors.textMuted, lineHeight: 18 },
  optLabelActive:{ color: colors.text, fontWeight: "700" },

  footer:      { marginTop: 8 },
  skipBtn:     { alignItems: "center", padding: 16 },
  skipBtnText: { color: colors.textMuted, fontSize: 14, fontWeight: "600" },
});
