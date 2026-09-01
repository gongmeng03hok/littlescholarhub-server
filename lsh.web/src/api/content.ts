import { Platform } from "react-native";
import http from "./client";

export interface PracticePacket {
  plan_id: number; grade_id: number; week_of: string; title: string;
  categories: {
    category_id: number; category_name: string;
    // The original 6 (see dbo.PacketSubjectAreas.is_always_on = 1) plus the
    // Whole-Child Curriculum groups added in 63_whole_child_rotation.sql —
    // only 'sel' and 'cognitive_skills' have content so far, the rest are
    // seeded in the lookup table for future content batches.
    subject_area: "math" | "ela" | "writing" | "science" | "social_studies" | "puzzle"
      | "sel" | "cognitive_skills" | "life_skills" | "stem_engineering" | "arts"
      | "civic" | "health" | "humor_play" | "character" | "culture";
    layout_type: "short_answer" | "space_heavy" | "puzzle";
    intro_text: string | null;
    questions: {
      question_id: number;
      question_type: "fill_blank" | "multiple_choice" | "short_response" | "matching" | "word_search";
      prompt: string;
      // string[] for multiple_choice; {left, right} for matching (answer is
      // a JSON-stringified array of [leftIndex, rightIndex] correct pairs —
      // not decoded here, only used for the printed/on-screen answer key).
      choices: string[] | { left: string[]; right: string[] } | null;
      answer: string;
      diagram_type: "clock" | "emoji" | "ten_frame" | "angle" | "rectangle_dims" | "coordinate_point" | "sequence_steps" | null;
      diagram_data: {
        hour?: number; minute?: number; emoji?: string; count?: number; degrees?: number;
        width?: number; height?: number; unit?: string; x?: number; y?: number; size?: number;
        steps?: string[];
      } | null;
    }[];
  }[];
}

export interface OutdoorGame {
  grade_id: number;
  grade_label: string;
  name: string;
  // Only present on the 1980s-retro batch (71_outdoor_games_retro80s_content.sql)
  // — empty string for games from earlier batches without this line.
  inspiration: string;
  objective: string;
  materials: string[];
  steps: string[];
  safety_tip: string;
}

export interface WorksheetFilters {
  subject?: string;
  grade?: number;
  language_id?: number;
  content_type?: string;
  interest?: string;
  level?: string;
  trending?: boolean;
}

export const contentApi = {
  getSubjects: () => http.get("/content/subjects") as Promise<any[]>,
  getGrades: ()    => http.get("/content/grades")   as Promise<any[]>,
  getInterests: () => http.get("/content/interests") as Promise<any[]>,
  getLevels: ()    => http.get("/content/levels")    as Promise<any[]>,
  getFeatured: ()  => http.get("/content/featured")  as Promise<any[]>,

  /** Single worksheet incl. steps/materials/video and any linked story. */
  getWorksheet: (worksheetId: number) =>
    http.get(`/content/worksheets/${worksheetId}`) as Promise<any>,

  getWorksheets: (params: WorksheetFilters) =>
    http.get("/content/worksheets", { params }) as Promise<any[]>,

  recordView: (worksheetId: number, childId?: number) =>
    http.post(`/content/worksheets/${worksheetId}/view`, childId ? { child_id: childId } : {}),

  printBatch: (worksheetIds: number[]) =>
    http.post("/content/worksheets/print-batch", { worksheet_ids: worksheetIds }, {
      responseType: "blob",
    }) as Promise<Blob>,

  getTodayStory: (grade: number, language_id = 1) =>
    http.get("/content/story/today", { params: { grade, language_id } }) as Promise<any>,

  getStoriesLibrary: (grade?: number, child_id?: number, language_id = 1) =>
    http.get("/content/stories/library", { params: { grade, child_id, language_id } }) as Promise<any[]>,

  getDailyWisdom: (language_id = 1) =>
    http.get("/content/wisdom/today", { params: { language_id } }) as Promise<any>,

  joinClassroom: (child_id: number, classroom_code: string) =>
    http.post("/content/classrooms/join", { child_id, classroom_code }) as Promise<{
      ok: boolean; classroom_id: number; classroom_name: string;
    }>,

  getAssignments: (child_id: number) =>
    http.get("/content/assignments", { params: { child_id } }) as Promise<any[]>,

  completeAssignment: (assignmentId: number, child_id: number) =>
    http.put(`/content/assignments/${assignmentId}/complete`, { child_id }),

  assignWorksheet: (child_id: number, worksheet_id: number, note?: string) =>
    http.post("/content/assignments", { child_id, worksheet_id, note }) as Promise<{
      ok: boolean; assignment_id: number;
    }>,

  assignStory: (child_id: number, story_id: number, note?: string) =>
    http.post("/content/assignments", { child_id, story_id, note }) as Promise<{
      ok: boolean; assignment_id: number;
    }>,

  deleteAssignment: (assignmentId: number) =>
    http.delete(`/content/assignments/${assignmentId}`),

  uploadWorksheet: (params: {
    child_id: number; file: any; filename: string; mime: string;
    title?: string; subject_id?: number; note?: string;
  }) => {
    const fd = new FormData();
    if (Platform.OS === "web") {
      fd.append("file", params.file, params.filename); // params.file is a real File/Blob on web
    } else {
      // @ts-ignore — React Native FormData accepts {uri,name,type} objects, unlike the web File type
      fd.append("file", { uri: params.file, name: params.filename, type: params.mime });
    }
    fd.append("child_id", String(params.child_id));
    if (params.title)      fd.append("title", params.title);
    if (params.subject_id) fd.append("subject_id", String(params.subject_id));
    if (params.note)       fd.append("note", params.note);
    return http.post("/content/worksheets/upload", fd, {
      headers: { "Content-Type": "multipart/form-data" },
    }) as Promise<{ ok: boolean; worksheet_id: number; assignment_id: number; pdf_url: string }>;
  },

  getPracticePacket: (grade: number, week_of: string) =>
    http.get("/content/practice-packet", { params: { grade, week_of } }) as Promise<PracticePacket>,

  // Admin-only: the full Outdoor Games bank across every grade (not the
  // weekly-rotated 7-of-14 subset getPracticePacket returns).
  getOutdoorGames: () =>
    http.get("/content/outdoor-games") as Promise<{ games: OutdoorGame[] }>,

  getThemeWeeks: (grade?: number) =>
    http.get("/content/theme-weeks", { params: grade ? { grade } : {} }) as Promise<any[]>,
  getThemeWeek: (id: number) =>
    http.get(`/content/theme-weeks/${id}`) as Promise<any>,
};
