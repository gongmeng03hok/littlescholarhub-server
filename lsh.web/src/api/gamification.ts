import http from "./client";

export interface GameProfile {
  child_id: number;
  total_xp: number;
  level: number;
  xp_into_level: number;
  xp_for_next: number;
  coins: number;
  gems: number;
  stars: number;
  avatar_slug: string;
  chest_style: string;
  checkin_streak: number;
  best_checkin_streak: number;
  checked_in_today: boolean;
  badges: { slug: string; label: string; icon: string; description?: string }[];
}

export interface CheckinResult {
  claimed: boolean;
  already_today?: boolean;
  coins?: number;
  xp?: number;
  checkin_streak?: number;
  best_checkin_streak?: number;
}

export interface LeaderEntry {
  rank: number;
  display_name: string;
  avatar_slug: string;
  region: string;
  total_xp: number;
  level: number;
}

export const gamificationApi = {
  profile: (childId: number) =>
    http.get(`/gamification/profile/${childId}`) as Promise<GameProfile>,
  checkin: (childId: number) =>
    http.post("/gamification/checkin", { child_id: childId }) as Promise<CheckinResult>,
  leaderboard: (childId: number, scope: "global" | "region" = "global", limit = 20) =>
    http.get("/gamification/leaderboard", { params: { child_id: childId, scope, limit } }) as
      Promise<{ scope: string; region: string | null; entries: LeaderEntry[] }>,
  settings: (body: { show_on_leaderboard: boolean; region?: string }) =>
    http.post("/gamification/settings", body) as
      Promise<{ ok: boolean; show_on_leaderboard: boolean; region: string | null }>,
  setAvatar: (childId: number, avatar_slug: string, chest_style: string) =>
    http.post("/gamification/avatar", { child_id: childId, avatar_slug, chest_style }) as
      Promise<{ ok: boolean; avatar_slug: string; chest_style: string }>,
};
