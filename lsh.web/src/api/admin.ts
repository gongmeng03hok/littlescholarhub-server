import { Platform } from "react-native";
import http from "./client";

export const adminApi = {
  getStats:    () => http.get("/admin/stats")    as Promise<any>,
  getDetailedStats: () => http.get("/admin/stats/detailed") as Promise<any>,
  getUsers:    () => http.get("/admin/users")    as Promise<any[]>,
  getFamilies: () => http.get("/admin/families") as Promise<any[]>,
  setUserRole: (id: number, role: string) =>
    http.put(`/admin/users/${id}/role`, { role }),

  // Teacher approval
  listPendingTeachers: () => http.get("/admin/teachers/pending") as Promise<any[]>,
  approveTeacher:      (id: number) => http.put(`/admin/teachers/${id}/approve`, {}),
  denyTeacher:         (id: number) => http.put(`/admin/teachers/${id}/deny`, {}),

  // Children under a parent / classrooms under a teacher
  getFamilyChildren:    (familyId: number) => http.get(`/admin/families/${familyId}/children`) as Promise<any[]>,
  getFamilyClassrooms:  (familyId: number) => http.get(`/admin/families/${familyId}/classrooms`) as Promise<any[]>,
  updateChild: (childId: number, body: Partial<{ nickname: string; grade_id: number; birth_year: number }>) =>
    http.put(`/admin/children/${childId}`, body),

  // Impersonation
  impersonate: (familyId: number) =>
    http.post(`/admin/impersonate/${familyId}`, {}) as Promise<{
      token: string; family_id: number; role: string; email: string;
    }>,

  // Worksheets
  listWorksheets:  ()                     => http.get("/admin/worksheets")         as Promise<any[]>,
  createWorksheet: (body: any)            => http.post("/admin/worksheets", body),
  updateWorksheet: (id: number, body: any)=> http.put(`/admin/worksheets/${id}`, body),
  deleteWorksheet: (id: number)           => http.delete(`/admin/worksheets/${id}`),

  // File uploads (stored in DB, returns { file_id, url })
  uploadFile: (file: File) => {
    const fd = new FormData();
    fd.append("file", file, file.name);
    return http.post("/admin/uploads", fd) as Promise<{ ok: boolean; file_id: number; url: string }>;
  },

  // Featured Collections
  listFeatured:  ()                      => http.get("/admin/featured")           as Promise<any[]>,
  createFeatured:(body: any)             => http.post("/admin/featured", body),
  updateFeatured:(id: number, body: any) => http.put(`/admin/featured/${id}`, body),
  deleteFeatured:(id: number)            => http.delete(`/admin/featured/${id}`),

  // Stories
  listStories:   ()                      => http.get("/admin/stories")             as Promise<any[]>,
  createStory:   (body: any)             => http.post("/admin/stories", body),
  updateStory:   (id: number, body: any) => http.put(`/admin/stories/${id}`, body),
  deleteStory:   (id: number)            => http.delete(`/admin/stories/${id}`),
  generateStoryAudio: (id: number)       => http.post(`/admin/stories/${id}/generate-audio`, {}) as Promise<{ ok: boolean; audio_url: string }>,
  uploadStoryPdf: (params: { file: any; filename: string; title: string; grade_id: number; theme_tag?: string }) => {
    const fd = new FormData();
    if (Platform.OS === "web") {
      fd.append("file", params.file, params.filename);
    } else {
      // @ts-ignore — React Native FormData accepts {uri,name,type} objects, unlike the web File type
      fd.append("file", { uri: params.file, name: params.filename, type: "application/pdf" });
    }
    fd.append("title", params.title);
    fd.append("grade_id", String(params.grade_id));
    if (params.theme_tag) fd.append("theme_tag", params.theme_tag);
    return http.post("/admin/stories/upload-pdf", fd, {
      headers: { "Content-Type": "multipart/form-data" },
    }) as Promise<{ ok: boolean; story_id: number; pdf_url: string; audio_url: string | null; read_min: number }>;
  },

  // Wisdom
  listWisdom:    ()                      => http.get("/admin/wisdom")              as Promise<any[]>,
  createWisdom:  (body: any)             => http.post("/admin/wisdom", body),
  updateWisdom:  (id: number, body: any) => http.put(`/admin/wisdom/${id}`, body),
  deleteWisdom:  (id: number)            => http.delete(`/admin/wisdom/${id}`),

  // Questions
  listQuestions:  ()                      => http.get("/admin/questions")          as Promise<any[]>,
  updateQuestion: (id: number, body: any) => http.put(`/admin/questions/${id}`, body),

  // Config
  getConfig:    (languageId: number | "all" = 1) =>
    http.get(`/admin/config?language_id=${languageId}`) as Promise<any[]>,
  updateConfig: (key: string, value: any, languageId: number = 1, label?: string) =>
    http.put(`/admin/config/${key}`, { value, language_id: languageId, label }),

  // Weekly Story Packs (Theme Weeks)
  listThemeWeeks:  ()                       => http.get("/admin/theme-weeks")            as Promise<any[]>,
  createThemeWeek: (body: any)              => http.post("/admin/theme-weeks", body),
  updateThemeWeek: (id: number, body: any)  => http.put(`/admin/theme-weeks/${id}`, body),
  deleteThemeWeek: (id: number)             => http.delete(`/admin/theme-weeks/${id}`),
  addThemeWeekWorksheet:    (weekId: number, worksheetId: number, role: string) =>
    http.post(`/admin/theme-weeks/${weekId}/worksheets`, { worksheet_id: worksheetId, role }),
  removeThemeWeekWorksheet: (weekId: number, linkId: number) =>
    http.delete(`/admin/theme-weeks/${weekId}/worksheets/${linkId}`),
};
