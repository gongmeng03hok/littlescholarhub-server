import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { homeworkApi, HomeworkImageAsset } from "../api/homework";

export function useUploadHomeworkPhoto() {
  return useMutation({
    mutationFn: (asset: HomeworkImageAsset) => homeworkApi.upload(asset),
  });
}

export function useCreateHomeworkSubmission() {
  return useMutation({
    mutationFn: (body: {
      child_id: number; image_file_id: number; mode: "ai" | "teacher";
      worksheet_id?: number; classroom_id?: number;
    }) => homeworkApi.createSubmission(body),
  });
}

export function useAiGradeSubmission() {
  return useMutation({
    mutationFn: (submissionId: number) => homeworkApi.aiGrade(submissionId),
  });
}

export function useTeacherQueue(classroomId: number | undefined) {
  return useQuery({
    queryKey: ["homeworkTeacherQueue", classroomId],
    queryFn:  () => homeworkApi.teacherQueue(classroomId),
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useReviewSubmission() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ submissionId, score, feedback }: { submissionId: number; score: number; feedback?: string; classroomId?: number }) =>
      homeworkApi.reviewSubmission(submissionId, score, feedback),
    onSuccess: (_: any, vars: any) =>
      qc.invalidateQueries({ queryKey: ["homeworkTeacherQueue", vars.classroomId] }),
  });
}
