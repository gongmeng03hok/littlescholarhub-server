import { CelebrationBurst } from "./CelebrationBurst";
import { useRef, useState } from "react";
import { View, Text, TouchableOpacity, TextInput, StyleSheet, ActivityIndicator, Image } from "react-native";
import { questionsApi } from "../api/questions";
import { colors } from "../constants/theme";
import { emotionImage } from "../constants/emotionImages";
import { questionImage, optionImage, type ArtContext } from "../constants/questionImages";
import { SpeakButton } from "./SpeakButton";

interface Question {
  question_text?: string;
  question?: string;
  correct_answer?: string;
  answer?: string;
  options?: string[];
  hint?: string;
  gq_id?: number;
}

interface Props {
  question: Question;
  childId?: number;
  kidMode?: boolean;
  /** Subject / topic / grade / culture — picks the tailored artwork. */
  context?: ArtContext;
  onResult: (correct: boolean) => void;
}

export function QuestionCard({ question, childId, kidMode, context, onResult }: Props) {
  const [answer,    setAnswer]   = useState("");
  const [selected,  setSelected] = useState<string | null>(null);
  const [result,    setResult]   = useState<"correct" | "wrong" | null>(null);
  const [loading,   setLoading]  = useState(false);
  // Bumped on every correct answer so the burst replays; the streak is
  // kept here rather than in the parent so a single card can show it.
  const [celebrate, setCelebrate] = useState(0);
  const streak = useRef(0);
  const isMCQ = !!question.options?.length;

  const questionText = question.question_text ?? question.question ?? "";
  const correctAnswer = question.correct_answer ?? question.answer ?? "";
  const sceneImg = questionImage(questionText, question.hint, context);

  const submit = async (ans: string) => {
    if (result || loading) return;
    setLoading(true);
    try {
      const res = await questionsApi.recordAttempt({
        child_id:       childId,
        question_text:  questionText,
        given_answer:   ans,
        correct_answer: correctAnswer,
        hint:           question.hint,
        options:        question.options,
      }) as any;
      const isCorrect = res.is_correct;
      setResult(isCorrect ? "correct" : "wrong");
      if (isCorrect) {
        streak.current += 1;
        setCelebrate(c => c + 1);
      } else {
        streak.current = 0;
      }
      setTimeout(() => onResult(isCorrect), 1200);
    } catch {
      setResult("wrong");
      setTimeout(() => onResult(false), 1200);
    } finally {
      setLoading(false);
    }
  };

  const fontSize = kidMode ? 20 : 16;

  return (
    <View style={[s.card, result === "correct" && s.correct, result === "wrong" && s.wrong]}>
      <CelebrationBurst
        trigger={celebrate}
        grade={typeof context?.grade === "number" ? context.grade : parseInt(String(context?.grade ?? 0), 10) || 0}
        streak={streak.current}
      />
      {sceneImg && (
        <Image source={sceneImg} style={s.sceneImg} resizeMode="contain" />
      )}
      <Text style={[s.question, { fontSize }]}>{questionText}</Text>

      {/* Reads the question, then its hint and choices — a child who cannot
          read the question cannot read the answers either. */}
      <SpeakButton
        size="large"
        label="Read to me"
        accessibilityLabel="Read the question and choices out loud"
        text={[
          questionText,
          ...(question.hint && !result ? [question.hint] : []),
          ...(isMCQ ? question.options! : []),
        ]}
        style={{ marginBottom: 12 }}
      />

      {question.hint && !result && (
        <Text style={s.hint}>💡 {question.hint}</Text>
      )}

      {isMCQ ? (
        <View style={s.options}>
          {question.options!.map(opt => {
            // purpose-drawn emotion art wins; otherwise match the option wording
            const img = emotionImage(opt) ?? optionImage(opt, context);
            return (
              <TouchableOpacity
                key={opt}
                onPress={() => { setSelected(opt); submit(opt); }}
                disabled={!!result}
                style={[
                  s.option,
                  img && s.optionWithImg,
                  selected === opt && s.optionSelected,
                  result && opt === correctAnswer && s.optionCorrect,
                  result === "wrong" && selected === opt && s.optionWrong,
                  kidMode && s.optionKid,
                ]}
              >
                {img && (
                  <Image source={img} style={s.optionImg} resizeMode="contain" />
                )}
                <Text style={[s.optionText, kidMode && s.optionTextKid,
                  img && s.optionTextImg,
                  selected === opt && { color: "white" }]}>
                  {opt}
                </Text>
                {/* Hear one choice on its own without committing to it. Sits
                    inside the row but handles its own press, so tapping the
                    speaker never submits the answer. */}
                {!result && (
                  <SpeakButton
                    text={opt}
                    accessibilityLabel={`Read the choice ${opt} out loud`}
                    style={{ marginLeft: "auto" }}
                  />
                )}
              </TouchableOpacity>
            );
          })}
        </View>
      ) : (
        <View style={s.fillWrap}>
          <TextInput
            value={answer}
            onChangeText={setAnswer}
            placeholder="Your answer…"
            placeholderTextColor={colors.textMuted}
            style={[s.fillInput, kidMode && s.fillInputKid]}
            editable={!result}
            onSubmitEditing={() => answer && submit(answer)}
          />
          <TouchableOpacity
            onPress={() => answer && submit(answer)}
            disabled={!answer || !!result || loading}
            style={[s.submitBtn, (!answer || !!result) && { opacity: 0.4 }]}
          >
            {loading
              ? <ActivityIndicator color="white" size="small" />
              : <Text style={s.submitText}>{kidMode ? "Check! ✅" : "Check"}</Text>
            }
          </TouchableOpacity>
        </View>
      )}

      {result && (
        <Text style={[s.feedback, result === "correct" ? s.feedbackOk : s.feedbackErr]}>
          {result === "correct"
            ? (kidMode ? "🎉 YES! You got it!" : "✅ Correct!")
            : (kidMode ? `😅 Almost! The answer is ${correctAnswer}` : `Answer: ${correctAnswer}`)}
        </Text>
      )}
    </View>
  );
}

const s = StyleSheet.create({
  card:          { backgroundColor: "white", borderRadius: 20, padding: 24, borderWidth: 2, borderColor: "transparent",
                   shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 12, elevation: 3 },
  correct:       { borderColor: colors.success, backgroundColor: "#f0fdf4" },
  wrong:         { borderColor: colors.danger,  backgroundColor: "#fff5f5" },
  sceneImg:      { width: 220, height: 220, borderRadius: 18, alignSelf: "center", marginBottom: 16 },
  question:      { fontWeight: "800", color: colors.text, lineHeight: 28, marginBottom: 20 },
  hint:          { fontSize: 13, color: colors.textMuted, fontStyle: "italic", marginBottom: 12 },
  options:       { gap: 10 },
  // Row so the 🔊 sits beside the wording rather than under it; the text takes
  // flex:1 below so a long choice wraps instead of being clipped.
  option:        { borderWidth: 2, borderColor: colors.border, borderRadius: 12, padding: 14,
                   flexDirection: "row", alignItems: "center", gap: 10 },
  optionWithImg: { flexDirection: "row", alignItems: "center", gap: 14, paddingVertical: 12 },
  optionImg:     { width: 72, height: 72, borderRadius: 14 },
  optionTextImg: { fontSize: 20, fontWeight: "800", textTransform: "capitalize" },
  optionSelected:{ backgroundColor: colors.brand, borderColor: colors.brand },
  optionCorrect: { backgroundColor: colors.success, borderColor: colors.success },
  optionWrong:   { backgroundColor: colors.danger,  borderColor: colors.danger  },
  optionKid:     { padding: 18, borderRadius: 16 },
  optionText:    { flex: 1, fontSize: 15, lineHeight: 22, fontWeight: "600", color: colors.text },
  optionTextKid: { fontSize: 18, fontWeight: "700" },
  fillWrap:      { gap: 10 },
  fillInput:     { borderWidth: 2, borderColor: colors.border, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 16, color: colors.text },
  fillInputKid:  { fontSize: 22, paddingVertical: 18 },
  submitBtn:     { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 14, alignItems: "center" },
  submitText:    { color: "white", fontWeight: "800", fontSize: 16 },
  feedback:      { marginTop: 14, fontSize: 16, fontWeight: "700", textAlign: "center" },
  feedbackOk:    { color: colors.success },
  feedbackErr:   { color: colors.danger },
});
