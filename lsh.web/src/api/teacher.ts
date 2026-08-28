import http from "./client";

export const teacherApi = {
  listClassrooms:   () => http.get("/teacher/classrooms") as Promise<any[]>,
  createClassroom:  (body: { classroom_name: string; school_name?: string; grade_id: number }) =>
    http.post("/teacher/classrooms", body) as Promise<{ ok: boolean; classroom_id: number; classroom_code: string }>,
  regenerateCode:   (classroomId: number) =>
    http.put(`/teacher/classrooms/${classroomId}/regenerate-code`, {}) as Promise<{ ok: boolean; classroom_code: string }>,
  updateClassroom:  (classroomId: number, body: { classroom_name: string; school_name?: string; grade_id: number }) =>
    http.put(`/teacher/classrooms/${classroomId}`, body) as Promise<{ ok: boolean }>,
  deleteClassroom:  (classroomId: number) => http.delete(`/teacher/classrooms/${classroomId}`),

  getRoster:        (classroomId: number) => http.get(`/teacher/classrooms/${classroomId}/roster`) as Promise<any[]>,
  addToRoster:      (classroomId: number, body: { nickname: string; grade_id: number; birth_year?: number }) =>
    http.post(`/teacher/classrooms/${classroomId}/roster`, body) as Promise<{ ok: boolean; child_id: number }>,
  updateRosterStudent: (classroomId: number, childId: number, body: { nickname: string; grade_id: number }) =>
    http.put(`/teacher/classrooms/${classroomId}/roster/${childId}`, body) as Promise<{ ok: boolean }>,
  removeFromRoster: (classroomId: number, childId: number) =>
    http.delete(`/teacher/classrooms/${classroomId}/roster/${childId}`),

  listAssignments:  (classroomId: number) => http.get(`/teacher/classrooms/${classroomId}/assignments`) as Promise<any[]>,
  createAssignment: (classroomId: number, body: { worksheet_id: number; child_id?: number | null; note?: string }) =>
    http.post(`/teacher/classrooms/${classroomId}/assignments`, body) as Promise<{ ok: boolean; assignment_id: number }>,
  deleteAssignment: (assignmentId: number) => http.delete(`/teacher/assignments/${assignmentId}`),

  getGradebook:     (classroomId: number) => http.get(`/teacher/classrooms/${classroomId}/gradebook`) as Promise<any[]>,
  getStudentGrades: (childId: number) => http.get(`/teacher/students/${childId}/grades`) as Promise<any>,
  getStudentProgress: (childId: number) => http.get(`/teacher/students/${childId}/progress`) as Promise<any>,

  listAllStudents:  () => http.get("/teacher/students") as Promise<any[]>,

  searchParents:    (search: string) =>
    http.get("/teacher/parents", { params: { search } }) as Promise<
      { family_id: number; email: string; child_count: number }[]
    >,
  getParentChildren: (familyId: number) =>
    http.get(`/teacher/parents/${familyId}/children`) as Promise<
      { child_id: number; nickname: string; grade_id: number; grade_label: string }[]
    >,
  linkStudentsToClassroom: (classroomId: number, childIds: number[]) =>
    http.post(`/teacher/classrooms/${classroomId}/roster/link`, { child_ids: childIds }) as Promise<{
      ok: boolean; linked: number[]; skipped: number[];
    }>,
};
