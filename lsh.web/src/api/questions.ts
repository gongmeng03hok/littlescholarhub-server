import http from "./client";

export const questionsApi = {
  // `theme` is a worksheet's interest_tag (ocean, dinosaurs, space …). Passing
  // it is what makes "Ocean Math" actually count seashells.
  generate: (subject: string, grade: number, count = 5, theme = "", skill = "") =>
    http.get("/questions/generate", { params: { subject, grade, count, theme, skill } }) as Promise<{ questions: Array<any & { question_text?: string; question?: string; correct_answer?: string; answer?: string }> }>,
  getDynamicMath: (grade: number, count = 5) =>
    http.get("/math/dynamic-questions", { params: { grade, count } }) as Promise<{ questions: any[] }>,
  recordAttempt: (body: {
    child_id?: number;
    question_text: string;
    given_answer: string;
    correct_answer: string;
    hint?: string;
    options?: string[];
    time_sec?: number;
  }) => http.post("/questions/attempt", body) as Promise<{ is_correct: boolean; correct_answer: string }>,

  getTemplates: () => http.get("/questions/templates") as Promise<any[]>,
};
