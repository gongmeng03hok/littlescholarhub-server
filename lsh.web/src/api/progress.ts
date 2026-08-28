import http from "./client";

export const progressApi = {
  get: (childId: number) => http.get(`/progress/${childId}`) as Promise<any>,
  chart: (childId: number) => http.get(`/progress/${childId}/chart`) as Promise<any[]>,
  log: (body: { child_id: number; subject_id: number; duration_min: number }) =>
    http.post("/progress/log", body),
  getBadges: (childId: number) => http.get(`/progress/${childId}/badges`) as Promise<any[]>,
  getActivities: (childId: number, limit = 30) =>
    http.get(`/progress/${childId}/activities`, { params: { limit } }) as Promise<{
      quiz_attempts: {
        attempt_id: number; question_text: string; given_answer: string;
        correct_answer: string; is_correct: boolean; time_sec: number | null; attempted_at: string;
      }[];
      homework: {
        submission_id: number; worksheet_id: number | null; worksheet_title: string | null;
        image_file_id: number; image_url: string; score: number | null;
        mode: string; submitted_at: string; reviewed_at: string | null;
      }[];
    }>,
};
