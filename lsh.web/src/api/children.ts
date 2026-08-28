import http from "./client";

export const childrenApi = {
  list: () => http.get("/children/") as Promise<any[]>,

  add: (body: { nickname: string; grade_id: number; birth_year?: number }) =>
    http.post("/children/", body) as Promise<{ ok: boolean; child_id: number }>,

  update: (id: number, body: Partial<{ nickname: string; grade_id: number; avatar_url: string }>) =>
    http.patch(`/children/${id}`, body),

  delete: (id: number) => http.delete(`/children/${id}`),

  // Kid profile management
  getKidProfile: (childId: number) =>
    http.get(`/children/${childId}/kid-profile`) as Promise<any>,

  createKidProfile: (childId: number, body: { display_name?: string; avatar_slug?: string; pin?: string }) =>
    http.post(`/children/${childId}/kid-profile`, body) as Promise<{ ok: boolean }>,

  updateKidProfile: (childId: number, body: { display_name?: string; avatar_slug?: string; pin?: string }) =>
    http.patch(`/children/${childId}/kid-profile`, body) as Promise<{ ok: boolean }>,
};
