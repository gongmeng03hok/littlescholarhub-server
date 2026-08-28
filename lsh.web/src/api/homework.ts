import http from "./client";

export interface HomeworkImageAsset {
  uri: string;
  name: string;
  type: string;
}

export const homeworkApi = {
  upload: (asset: HomeworkImageAsset) => {
    const fd = new FormData();
    // @ts-ignore — React Native FormData accepts {uri,name,type} objects, unlike the web File type
    fd.append("file", { uri: asset.uri, name: asset.name, type: asset.type });
    return http.post("/homework/upload", fd, {
      headers: { "Content-Type": "multipart/form-data" },
    }) as Promise<{ ok: boolean; file_id: number; url: string }>;
  },

  createSubmission: (body: {
    child_id: number;
    image_file_id: number;
    mode: "ai" | "teacher";
    worksheet_id?: number;
    classroom_id?: number;
  }) => http.post("/homework/submissions", body) as Promise<{ ok: boolean; submission_id: number; mode: string }>,

  aiGrade: (submissionId: number) =>
    http.post(`/homework/submissions/${submissionId}/ai-grade`, {}) as Promise<{
      ok: boolean; submission_id: number; score: number; feedback: any;
    }>,

  teacherQueue: (classroomId?: number) =>
    http.get("/homework/teacher-queue", { params: classroomId ? { classroom_id: classroomId } : {} }) as Promise<any[]>,

  reviewSubmission: (submissionId: number, score: number, feedback?: string) =>
    http.put(`/homework/submissions/${submissionId}/review`, { score, feedback }),
};
