import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { teacherApi } from "../api/teacher";

export function useClassrooms() {
  return useQuery({
    queryKey: ["teacherClassrooms"],
    queryFn:  () => teacherApi.listClassrooms(),
    staleTime: 60_000,
    placeholderData: [],
  });
}

export function useAllStudents() {
  return useQuery({
    queryKey: ["teacherAllStudents"],
    queryFn:  () => teacherApi.listAllStudents(),
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useCreateClassroom() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (body: { classroom_name: string; school_name?: string; grade_id: number }) =>
      teacherApi.createClassroom(body),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["teacherClassrooms"] }),
  });
}

export function useRegenerateCode() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (classroomId: number) => teacherApi.regenerateCode(classroomId),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["teacherClassrooms"] }),
  });
}

export function useUpdateClassroom() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ classroomId, body }: { classroomId: number; body: { classroom_name: string; school_name?: string; grade_id: number } }) =>
      teacherApi.updateClassroom(classroomId, body),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["teacherClassrooms"] }),
  });
}

export function useDeleteClassroom() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (classroomId: number) => teacherApi.deleteClassroom(classroomId),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["teacherClassrooms"] }),
  });
}

export function useRoster(classroomId: number | undefined) {
  return useQuery({
    queryKey: ["classroomRoster", classroomId],
    queryFn:  () => teacherApi.getRoster(classroomId!),
    enabled:  !!classroomId,
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useAddToRoster() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ classroomId, body }: { classroomId: number; body: { nickname: string; grade_id: number; birth_year?: number } }) =>
      teacherApi.addToRoster(classroomId, body),
    onSuccess: (_: any, vars: any) => {
      qc.invalidateQueries({ queryKey: ["classroomRoster", vars.classroomId] });
      qc.invalidateQueries({ queryKey: ["teacherClassrooms"] });
    },
  });
}

export function useUpdateRosterStudent() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ classroomId, childId, body }: { classroomId: number; childId: number; body: { nickname: string; grade_id: number } }) =>
      teacherApi.updateRosterStudent(classroomId, childId, body),
    onSuccess: (_: any, vars: any) => {
      qc.invalidateQueries({ queryKey: ["classroomRoster", vars.classroomId] });
    },
  });
}

export function useRemoveFromRoster() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ classroomId, childId }: { classroomId: number; childId: number }) =>
      teacherApi.removeFromRoster(classroomId, childId),
    onSuccess: (_: any, vars: any) => {
      qc.invalidateQueries({ queryKey: ["classroomRoster", vars.classroomId] });
      qc.invalidateQueries({ queryKey: ["teacherClassrooms"] });
    },
  });
}

export function useAssignments(classroomId: number | undefined) {
  return useQuery({
    queryKey: ["classroomAssignments", classroomId],
    queryFn:  () => teacherApi.listAssignments(classroomId!),
    enabled:  !!classroomId,
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useCreateAssignment() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ classroomId, body }: { classroomId: number; body: { worksheet_id: number; child_id?: number | null; note?: string } }) =>
      teacherApi.createAssignment(classroomId, body),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["classroomAssignments", vars.classroomId] }),
  });
}

export function useDeleteAssignment() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ assignmentId }: { assignmentId: number; classroomId: number }) =>
      teacherApi.deleteAssignment(assignmentId),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["classroomAssignments", vars.classroomId] }),
  });
}

// ── Grades & activity ────────────────────────────────────────

export function useGradebook(classroomId: number | undefined) {
  return useQuery({
    queryKey: ["classroomGradebook", classroomId],
    queryFn:  () => teacherApi.getGradebook(classroomId!),
    enabled:  !!classroomId,
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useStudentGrades(childId: number | undefined) {
  return useQuery({
    queryKey: ["studentGrades", childId],
    queryFn:  () => teacherApi.getStudentGrades(childId!),
    enabled:  !!childId,
    staleTime: 30_000,
  });
}

export function useStudentProgress(childId: number | undefined) {
  return useQuery({
    queryKey: ["studentProgress", childId],
    queryFn:  () => teacherApi.getStudentProgress(childId!),
    enabled:  !!childId,
    staleTime: 30_000,
  });
}

// ── Add existing students via parent lookup ──────────────────

export function useSearchParents(search: string) {
  return useQuery({
    queryKey: ["teacherParentSearch", search],
    queryFn:  () => teacherApi.searchParents(search),
    enabled:  search.trim().length >= 2,
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useParentChildren(familyId: number | undefined) {
  return useQuery({
    queryKey: ["teacherParentChildren", familyId],
    queryFn:  () => teacherApi.getParentChildren(familyId!),
    enabled:  !!familyId,
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useLinkStudentsToClassroom() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ classroomId, childIds }: { classroomId: number; childIds: number[] }) =>
      teacherApi.linkStudentsToClassroom(classroomId, childIds),
    onSuccess: (_: any, vars: any) => {
      qc.invalidateQueries({ queryKey: ["classroomRoster", vars.classroomId] });
      qc.invalidateQueries({ queryKey: ["teacherClassrooms"] });
    },
  });
}
