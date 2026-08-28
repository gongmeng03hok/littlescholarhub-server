import { create } from "zustand";
import {
  getToken, setToken, removeToken,
  getImpersonatorToken, setImpersonatorToken, removeImpersonatorToken,
} from "../api/client";
import { authApi } from "../api/auth";

export type Role = "admin" | "parent" | "teacher" | "kid" | null;

interface Family {
  family_id: number;
  email?: string;
  plann?: string;
  language_id?: number;
  referral_code?: string;
  role?: string;
  is_approved?: boolean;
  teacher_name?: string;
  teacher_school?: string;
}

interface AuthState {
  token:       string | null;
  family:      Family | null;
  role:        Role;
  kidId:       number | null;
  isApproved:  boolean;
  isLoaded:    boolean;
  isImpersonating: boolean;

  setAuth:        (token: string, family: Family | null, role: Role, kidId?: number | null) => void;
  setFamily:      (family: Family) => void;
  logout:         () => Promise<void>;
  loadFromStorage: () => Promise<void>;
  impersonate:    (token: string, family: Family | null, role: Role) => Promise<void>;
  returnFromImpersonation: () => Promise<void>;
}

/** Decode JWT payload without verifying signature — just to read role/kid_id */
function decodeJWT(token: string): Record<string, any> | null {
  try {
    const b64 = token.split(".")[1].replace(/-/g, "+").replace(/_/g, "/");
    const json = atob(b64);
    return JSON.parse(json);
  } catch {
    return null;
  }
}

export const useAuthStore = create<AuthState>((set, get) => ({
  token:      null,
  family:     null,
  role:       null,
  kidId:      null,
  isApproved: true,
  isLoaded:   false,
  isImpersonating: false,

  setAuth: (token, family, role, kidId = null) => {
    setToken(token);
    set({
      token, family, kidId,
      role:       role ? (role.toLowerCase() as Role) : null,
      isApproved: family?.is_approved ?? true,
    });

    // Login and register only know the family_id from their own response, so
    // the rest of the profile -- language_id above all -- was missing for the
    // whole session. `restore()` refetched it on a cold boot but nothing did
    // after a fresh sign-in, so WisdomCard fell back to language_id 1 and a
    // Chinese, Hindi or Spanish family was served the English pool until they
    // next reloaded the app. Pull the full profile here too.
    if (family && (family as any).language_id === undefined) {
      authApi.me()
        .then((me: any) => set({ family: me, isApproved: me?.is_approved ?? true }))
        .catch(() => { /* non-fatal: the token still works for API calls */ });
    }
  },

  setFamily: (family) => set({ family, isApproved: family?.is_approved ?? true }),

  logout: async () => {
    await removeToken();
    await removeImpersonatorToken();
    set({ token: null, family: null, role: null, kidId: null, isApproved: true, isImpersonating: false });
  },

  impersonate: async (token, family, role) => {
    const current = await getToken();
    if (current) await setImpersonatorToken(current);
    await setToken(token);
    set({
      token, family, kidId: null,
      role: role ? (role.toLowerCase() as Role) : null,
      isApproved: family?.is_approved ?? true,
      isImpersonating: true,
    });
  },

  returnFromImpersonation: async () => {
    const adminToken = await getImpersonatorToken();
    if (!adminToken) return;
    const payload = decodeJWT(adminToken);
    await setToken(adminToken);
    await removeImpersonatorToken();
    set({
      token: adminToken,
      role: (payload?.role ?? "admin") as Role,
      kidId: null,
      isApproved: true,
      isImpersonating: false,
      family: null, // refetched by whichever screen mounts next (admin dashboard doesn't need it)
    });
  },

  loadFromStorage: async () => {
    const token = await getToken();
    if (!token) {
      set({ isLoaded: true });
      return;
    }

    // Decode role & kidId from JWT payload (no network needed)
    const payload = decodeJWT(token);
    if (!payload) {
      await removeToken();
      set({ isLoaded: true });
      return;
    }

    // Check expiry
    const now = Math.floor(Date.now() / 1000);
    if (payload.exp && payload.exp < now) {
      await removeToken();
      set({ isLoaded: true });
      return;
    }

    const role  = (payload.role ?? "parent") as Role;
    const kidId = payload.kid_id ?? null;
    const isApproved = payload.approved ?? true;
    const isImpersonating = !!(await getImpersonatorToken());

    set({ token, role, kidId, isApproved, isLoaded: true, isImpersonating });

    // Fetch full family profile in background (non-blocking)
    try {
      const me = await authApi.me();
      set({ family: me, isApproved: me?.is_approved ?? isApproved });
    } catch {
      // Not fatal — token may still be valid for API calls
    }
  },
}));
