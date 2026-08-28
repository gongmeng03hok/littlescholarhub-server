import http from "./client";

export const authApi = {
  register: (
    email: string,
    password: string,
    language_id = 1,
    role: "parent" | "teacher" = "parent",
    teacher_name?: string,
    teacher_school?: string,
    referral_code?: string,
  ) =>
    http.post("/auth/register", { email, password, language_id, role, teacher_name, teacher_school, referral_code }) as Promise<{
      token: string; family_id: number; role: string; is_approved: boolean;
    }>,

  login: (email: string, password: string) =>
    http.post("/auth/login", { email, password }) as Promise<{ token: string; family_id: number; role: string }>,

  adminLogin: (email: string, password: string) =>
    http.post("/auth/admin-login", { email, password }) as Promise<{ token: string; family_id: number; role: string }>,

  kidLogin: (child_id: number, pin?: string) =>
    http.post("/auth/kid-login", { child_id, pin }) as Promise<{ token: string; kid_id: number }>,

  me: () => http.get("/auth/me") as Promise<any>,

  updateMe: (body: { language_id: number }) =>
    http.put("/auth/me", body) as Promise<{ ok: boolean; language_id: number }>,

  getReferrals: () => http.get("/auth/referrals") as Promise<{ count: number; referrals: any[] }>,

  refresh: () => http.post("/auth/refresh", {}) as Promise<{ token: string }>,

  forgotPassword: (email: string) =>
    http.post("/auth/forgot-password", { email }) as Promise<{ ok: boolean; message: string }>,

  resetPassword: (token: string, password: string) =>
    http.post("/auth/reset-password", { token, password }) as Promise<{ ok: boolean }>,
};
