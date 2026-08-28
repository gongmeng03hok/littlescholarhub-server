/**
 * Public assessment wizard — no login required.
 * 18 questions fetched from /api/assessment/questions.
 * Options are objects {v, label, emo?} rendered as 2-col emoji tiles
 * (matching venerable-gnome-807695.netlify.app/#assessment).
 * On success: 3 activity previews + "Create account to save" CTA.
 */
import { useState, useRef } from "react";
import {
  View, Text, ScrollView, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform, Animated,
} from "react-native";
import { useRouter } from "expo-router";
import { useQuery, useMutation } from "@tanstack/react-query";
import { savePendingAssessment } from "../../utils/pendingAssessment";
import { assessmentApi }        from "../../api/assessment";
import { Button }               from "../../components/ui/Button";
import { PlanConsolidation }    from "../../components/PlanConsolidation";
import { colors }               from "../../constants/theme";

// Normalise option to always be {v, label, emo?}
type Opt = { v: string; label: string; emo?: string };

function toOpt(o: any): Opt {
  if (typeof o === "string") return { v: o, label: o };
  return o;
}

export default function PublicAssessmentScreen() {
  const router = useRouter();

  const [step,       setStep]       = useState(0);
  const [answers,    setAnswers]    = useState<Record<string, any>>({});
  const [planResult, setPlanResult] = useState<any>(null);
  const progress                    = useRef(new Animated.Value(0)).current;

  const { data: questions = [], isLoading } = useQuery({
    queryKey: ["assessmentQuestions"],
    queryFn:  () => assessmentApi.getQuestions() as Promise<any[]>,
    staleTime: 60 * 60 * 1000,
  });

  const { mutate: submit, isPending: submitting, isError, error } = useMutation({
    mutationFn: () => assessmentApi.submit(0, answers) as Promise<any>,
    onSuccess:  (data) => {
      // Keep the answers so the plan can be rebuilt against the real child
      // once the parent finishes signing up (see utils/pendingAssessment).
      savePendingAssessment(answers);
      setPlanResult(data);
    },
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
        {/* Slim header */}
        <View style={s.doneHeader}>
          <Text style={s.doneBadge}>🎉  Your personalised plan is ready!</Text>
        </View>
        <PlanConsolidation
          plan={planResult.plan}
          cta={
            <>
              <Button
                label="Create free account to save plan →"
                onPress={() => router.push("/(auth)/register")}
                fullWidth
              />
              <Button
                label="Already have an account? Log in"
                onPress={() => router.push("/(auth)/login")}
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
          {current?.subject && <Text style={s.eyebrow}>{current.subject.toUpperCase()}</Text>}
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
        {/* Question card */}
        <View style={s.questionCard}>
          <Text style={s.questionText}>{current?.text ?? ""}</Text>
          {!!current?.sub && <Text style={s.questionSub}>{current.sub}</Text>}
        </View>

        {/* Options grid */}
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

        {/* Error */}
        {isError && (
          <View style={s.errorBox}>
            <Text style={s.errorText}>
              {(error as Error)?.message ?? "Something went wrong. Please try again."}
            </Text>
          </View>
        )}

        {/* Footer */}
        <View style={s.footer}>
          {isLast && sel ? (
            <Button
              label={submitting ? "Building your plan…" : "See my plan →"}
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
  doneBadge: { fontSize: 16, fontWeight: "800", color: "#fff", textAlign: "center" },
  doneTitle: { fontSize: 26, fontWeight: "900", color: colors.text, textAlign: "center", marginTop: 16, marginBottom: 8 },
  doneSub:   { fontSize: 14, color: colors.textMuted, textAlign: "center", lineHeight: 22 },

  // ── Wizard ──────────────────────────────────────────────────
  header: { flexDirection: "row", alignItems: "center", gap: 12,
            backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 16, paddingHorizontal: 20,
            borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn:   { fontSize: 22, color: colors.brand, fontWeight: "700" },
  stepLabel: { fontSize: 13, color: colors.textMuted, fontWeight: "700" },
  eyebrow:   { fontSize: 11, color: colors.brand, fontWeight: "700", letterSpacing: 1.2, marginTop: 2 },
  closeBtn:  { fontSize: 18, color: colors.textMuted },

  barBg:   { height: 8, backgroundColor: "#f2eadf" },
  barFill: { height: 8, backgroundColor: colors.brand, borderRadius: 999 },

  scroll:       { padding: 20, paddingBottom: 60 },
  questionCard: { marginBottom: 20 },
  questionText: { fontSize: 28, fontWeight: "800", color: colors.text, lineHeight: 36,
                  fontFamily: Platform.OS === "web" ? "'Fraunces', Georgia, serif" : undefined },
  questionSub:  { fontSize: 14, color: colors.textMuted, marginTop: 8, lineHeight: 20 },

  // 2-column option tiles — matches reference site layout
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

  errorBox:  { backgroundColor: "#fff0f0", borderRadius: 12, padding: 14, marginBottom: 16 },
  errorText: { color: "#c0392b", fontSize: 14, textAlign: "center" },

  footer:      { marginTop: 8 },
  skipBtn:     { alignItems: "center", padding: 16 },
  skipBtnText: { color: colors.textMuted, fontSize: 14, fontWeight: "600" },
});
