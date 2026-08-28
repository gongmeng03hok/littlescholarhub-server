import http from "./client";

export const assessmentApi = {
  getQuestions: () => http.get("/assessment/questions") as Promise<any[]>,
  submit: (child_id: number, answers: Record<string, any>) =>
    http.post("/assessment/submit", { child_id, answers }) as Promise<{ plan: any }>,
  getPlan: (childId: number) =>
    http.get(`/assessment/plan/${childId}`) as Promise<any>,
};
