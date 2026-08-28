export interface ActivityItem {
  key: string;
  type: "quiz" | "homework";
  timestamp: string;
  // quiz
  question_text?: string;
  given_answer?: string;
  correct_answer?: string;
  is_correct?: boolean;
  // homework
  worksheet_title?: string | null;
  image_url?: string;
  score?: number | null;
}

/** Merges quiz attempts + homework submissions into one reverse-chronological feed. */
export function mergeActivities(data?: {
  quiz_attempts?: any[];
  homework?: any[];
}): ActivityItem[] {
  if (!data) return [];
  const quiz: ActivityItem[] = (data.quiz_attempts ?? []).map(q => ({
    key: `quiz-${q.attempt_id}`,
    type: "quiz" as const,
    timestamp: q.attempted_at,
    question_text: q.question_text,
    given_answer: q.given_answer,
    correct_answer: q.correct_answer,
    is_correct: q.is_correct,
  }));
  const homework: ActivityItem[] = (data.homework ?? []).map(h => ({
    key: `hw-${h.submission_id}`,
    type: "homework" as const,
    timestamp: h.submitted_at,
    worksheet_title: h.worksheet_title,
    image_url: h.image_url,
    score: h.score,
  }));
  return [...quiz, ...homework].sort(
    (a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime()
  );
}
