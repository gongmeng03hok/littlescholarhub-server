/**
 * hooks/useApi.ts
 * React Query wrappers for all major data fetching.
 * Every hook has a sensible staleTime and fallback placeholder.
 */

import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { contentApi }   from "../api/content";
import { questionsApi } from "../api/questions";
import { progressApi }  from "../api/progress";
import { assessmentApi }from "../api/assessment";
import { adminApi }     from "../api/admin";
import { useAuthStore } from "../store/authStore";
import { useChildStore } from "../store/childStore";

// ── Content ──────────────────────────────────────────────────

export function useSubjects() {
  return useQuery({
    queryKey: ["subjects"],
    queryFn:  () => contentApi.getSubjects() as Promise<any[]>,
    staleTime: 24 * 60 * 60 * 1000, // 24h — subjects rarely change
  });
}

export function useGrades() {
  return useQuery({
    queryKey: ["grades"],
    queryFn:  () => contentApi.getGrades() as Promise<any[]>,
    staleTime: 24 * 60 * 60 * 1000,
  });
}

export function useWorksheets(params: {
  subject?: string; grade?: number; language_id?: number;
  content_type?: string; interest?: string; level?: string; trending?: boolean;
}) {
  return useQuery({
    queryKey: ["worksheets", params],
    queryFn:  () => contentApi.getWorksheets(params) as Promise<any[]>,
    staleTime: 10 * 60 * 1000,
    placeholderData: [],
  });
}

export function useInterests() {
  return useQuery({
    queryKey: ["interests"],
    queryFn:  () => contentApi.getInterests() as Promise<any[]>,
    staleTime: 24 * 60 * 60 * 1000,
    placeholderData: [],
  });
}

export function useLevels() {
  return useQuery({
    queryKey: ["levels"],
    queryFn:  () => contentApi.getLevels() as Promise<any[]>,
    staleTime: 24 * 60 * 60 * 1000,
    placeholderData: [],
  });
}

export function useFeatured() {
  return useQuery({
    queryKey: ["featured"],
    queryFn:  () => contentApi.getFeatured() as Promise<any[]>,
    staleTime: 10 * 60 * 1000,
    placeholderData: [],
  });
}

export function useRecordView() {
  return useMutation({
    mutationFn: ({ worksheetId, childId }: { worksheetId: number; childId?: number }) =>
      contentApi.recordView(worksheetId, childId),
  });
}

export function useAssignments(childId: number | undefined) {
  return useQuery({
    queryKey: ["assignments", childId],
    queryFn:  () => contentApi.getAssignments(childId!),
    enabled:  !!childId,
    staleTime: 60_000,
    placeholderData: [],
  });
}

export function useJoinClassroom() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ childId, code }: { childId: number; code: string }) =>
      contentApi.joinClassroom(childId, code),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["assignments", vars.childId] }),
  });
}

export function useCompleteAssignment() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ assignmentId, childId }: { assignmentId: number; childId: number }) =>
      contentApi.completeAssignment(assignmentId, childId),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["assignments", vars.childId] }),
  });
}

export function useAssignWorksheet() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ childId, worksheetId, note }: { childId: number; worksheetId: number; note?: string }) =>
      contentApi.assignWorksheet(childId, worksheetId, note),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["assignments", vars.childId] }),
  });
}

export function useDeleteAssignment() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ assignmentId }: { assignmentId: number; childId: number }) =>
      contentApi.deleteAssignment(assignmentId),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["assignments", vars.childId] }),
  });
}

// ── Mini-Story Library (our own authored stories) ───────────

export function useStoriesLibrary(grade?: number, childId?: number) {
  return useQuery({
    queryKey: ["storiesLibrary", grade, childId],
    queryFn:  () => contentApi.getStoriesLibrary(grade, childId),
    staleTime: 60_000,
    placeholderData: [],
  });
}

export function useAssignStory() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ childId, storyId, note }: { childId: number; storyId: number; note?: string }) =>
      contentApi.assignStory(childId, storyId, note),
    onSuccess: (_: any, vars: any) => {
      qc.invalidateQueries({ queryKey: ["assignments", vars.childId] });
      qc.invalidateQueries({ queryKey: ["storiesLibrary"] });
    },
  });
}


export function useUploadWorksheet() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (params: {
      child_id: number; file: any; filename: string; mime: string;
      title?: string; subject_id?: number; note?: string;
    }) => contentApi.uploadWorksheet(params),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["assignments", vars.child_id] }),
  });
}

export function useTodayStory(grade: number) {
  const { family } = useAuthStore();
  const langId = family?.language_id ?? 1;
  return useQuery({
    queryKey: ["story", grade, langId],
    queryFn:  () => contentApi.getTodayStory(grade, langId),
    staleTime: 60 * 60 * 1000,
  });
}

export function usePracticePacket(grade: number, weekOf: string) {
  return useQuery({
    queryKey: ["practicePacket", grade, weekOf],
    queryFn:  () => contentApi.getPracticePacket(grade, weekOf),
    staleTime: 60 * 60 * 1000,
    enabled: grade != null && grade >= 0 && !!weekOf,
  });
}

export function useOutdoorGames() {
  return useQuery({
    queryKey: ["outdoorGames"],
    queryFn:  () => contentApi.getOutdoorGames(),
    staleTime: 60 * 60 * 1000,
  });
}

export function useThemeWeeks(grade?: number) {
  return useQuery({
    queryKey: ["themeWeeks", grade],
    queryFn:  () => contentApi.getThemeWeeks(grade),
    staleTime: 5 * 60 * 1000,
    placeholderData: [],
  });
}

export function useThemeWeek(id: number | undefined) {
  return useQuery({
    queryKey: ["themeWeek", id],
    queryFn:  () => contentApi.getThemeWeek(id!),
    enabled:  !!id,
    staleTime: 5 * 60 * 1000,
  });
}

export function useWisdom() {
  const { family } = useAuthStore();
  const langId = family?.language_id ?? 1;
  return useQuery({
    queryKey: ["wisdom", langId],
    queryFn:  () => contentApi.getDailyWisdom(langId),
    staleTime: 60 * 60 * 1000,
    placeholderData: {
      text_original: "You have the right to perform your actions, but not to the fruits of your actions.",
      author: "Bhagavad Gita 2.47",
      source_track: "gita",
    },
  });
}

// ── Questions ────────────────────────────────────────────────

/**
 * Generated practice questions.
 *
 * `theme` threads the catalog's `interest_tag` through to the generator so a
 * sheet titled "Ocean Math" actually asks about the ocean; `enabled` lets a
 * caller hold the request back (demo worksheets, and stories that carry their
 * own questions, must not fall through to the generic pool).
 */
export function useQuestions(
  subject: string,
  grade: number,
  count = 5,
  opts: { enabled?: boolean; theme?: string; skill?: string } = {},
) {
  const { enabled = true, theme = "", skill = "" } = opts;
  return useQuery({
    queryKey: ["questions", subject, grade, count, theme, skill],
    // Math normally comes from the SQL proc, which knows nothing about a
    // named skill -- so "Skip Counting by 2s, 5s, 10s" was served ordinary
    // arithmetic. When the sheet names a skill, go through the generator.
    queryFn:  () => (subject === "math" && !skill)
                      ? questionsApi.getDynamicMath(grade, count).then((r: any) => r.questions || [])
                      : questionsApi.generate(subject, grade, count, theme, skill).then((r: any) => r.questions || []),
    enabled,
    staleTime: 0, // Always fresh — questions are randomised
  });
}

/** One worksheet by id — steps, materials, video and any linked story. */
export function useWorksheet(worksheetId?: number) {
  return useQuery({
    queryKey: ["worksheet", worksheetId],
    queryFn:  () => contentApi.getWorksheet(worksheetId!) as Promise<any>,
    enabled:  !!worksheetId,
    staleTime: 10 * 60 * 1000,
  });
}

export function useRecordAttempt() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: questionsApi.recordAttempt,
    onSuccess: () => {
      // Invalidate progress after an attempt
      const { activeChild } = useChildStore.getState();
      if (activeChild) qc.invalidateQueries({ queryKey: ["progress", activeChild.child_id] });
    },
  });
}

// ── Progress ─────────────────────────────────────────────────

export function useProgress(childId: number | undefined) {
  return useQuery({
    queryKey: ["progress", childId],
    queryFn:  () => progressApi.get(childId!),
    enabled:  !!childId,
    staleTime: 5 * 60 * 1000,
    placeholderData: {
      streak:     { current_streak: 0, longest_streak: 0, total_hours: 0 },
      weekly:     { sessions: 0, mins: 0 },
      by_subject: [],
    },
  });
}

export function useCalendarMonth(childId: number | undefined, month: string) {
  return useQuery({
    queryKey: ["calendar", childId, month],
    queryFn:  () => progressApi.calendar(childId!, month),
    enabled:  !!childId,
    staleTime: 60 * 1000,
  });
}

export function useBadges(childId: number | undefined) {
  return useQuery({
    queryKey: ["badges", childId],
    queryFn:  () => progressApi.getBadges(childId!),
    enabled:  !!childId,
    staleTime: 60 * 1000,
    placeholderData: [],
  });
}

export function useActivities(childId: number | undefined, limit = 30) {
  return useQuery({
    queryKey: ["activities", childId, limit],
    queryFn:  () => progressApi.getActivities(childId!, limit),
    enabled:  !!childId,
    staleTime: 30 * 1000,
    placeholderData: { quiz_attempts: [], homework: [] },
  });
}

export function useProgressChart(childId: number | undefined) {
  return useQuery({
    queryKey: ["progressChart", childId],
    queryFn:  () => progressApi.chart(childId!),
    enabled:  !!childId,
    staleTime: 5 * 60 * 1000,
    placeholderData: [],
  });
}

export function useLogSession() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: progressApi.log,
    onSuccess: (_: any, vars: any) => {
      qc.invalidateQueries({ queryKey: ["progress", vars.child_id] });
      qc.invalidateQueries({ queryKey: ["progressChart", vars.child_id] });
    },
  });
}

// ── Assessment ───────────────────────────────────────────────

export function useAssessmentQuestions() {
  return useQuery({
    queryKey: ["assessmentQuestions"],
    queryFn:  () => assessmentApi.getQuestions(),
    staleTime: 60 * 60 * 1000,
  });
}

// ── Admin ────────────────────────────────────────────────────

export function useAdminStats() {
  return useQuery({
    queryKey: ["adminStats"],
    queryFn:  () => adminApi.getStats(),
    staleTime: 2 * 60 * 1000,
  });
}

export function useAdminUsers() {
  return useQuery({
    queryKey: ["adminUsers"],
    queryFn:  () => adminApi.getUsers(),
    staleTime: 60_000,
    placeholderData: [],
  });
}

export function useAdminDetailedStats() {
  return useQuery({
    queryKey: ["adminDetailedStats"],
    queryFn:  () => adminApi.getDetailedStats(),
    staleTime: 2 * 60 * 1000,
  });
}

export function useAdminConfig() {
  return useQuery({
    queryKey: ["adminConfig"],
    queryFn:  () => adminApi.getConfig(),
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useUpdateConfig() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ key, value }: { key: string; value: any }) =>
      adminApi.updateConfig(key, value),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["adminConfig"] });
      qc.invalidateQueries({ queryKey: ["appConfig"] });
    },
  });
}

export function useAdminWisdom() {
  return useQuery({
    queryKey: ["adminWisdom"],
    queryFn:  () => adminApi.getConfig().then(() => []), // placeholder
    staleTime: 60_000,
    placeholderData: [],
  });
}
