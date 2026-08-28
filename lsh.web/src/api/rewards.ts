import http from "./client";

export interface RewardItem {
  reward_id: number;
  family_id: number;
  child_id: number | null;
  child_nickname: string | null;
  title: string;
  description: string | null;
  image_url: string | null;
  product_url: string | null;
  point_cost: number;
  is_active: boolean;
  created_at: string;
}

export interface Redemption {
  redemption_id: number;
  child_id: number;
  child_nickname: string;
  reward_id: number;
  reward_title: string;
  image_url: string | null;
  product_url: string | null;
  points_spent: number;
  status: "pending" | "approved" | "denied" | "fulfilled";
  requested_at: string;
  resolved_at: string | null;
  resolved_note: string | null;
}

export const rewardsApi = {
  listItems: (all = false) =>
    http.get("/rewards/items", { params: all ? { all: 1 } : {} }) as Promise<RewardItem[]>,

  createItem: (body: {
    title: string; description?: string; image_url?: string;
    product_url?: string; point_cost: number; child_id?: number | null;
  }) => http.post("/rewards/items", body) as Promise<{ ok: boolean; reward_id: number }>,

  updateItem: (rewardId: number, body: Partial<{
    title: string; description: string; image_url: string;
    product_url: string; point_cost: number; is_active: boolean; child_id: number | null;
  }>) => http.put(`/rewards/items/${rewardId}`, body),

  deleteItem: (rewardId: number) => http.delete(`/rewards/items/${rewardId}`),

  redeem: (childId: number, rewardId: number) =>
    http.post("/rewards/redeem", { child_id: childId, reward_id: rewardId }) as Promise<{
      ok: boolean; redemption_id: number; points_spent: number; remaining_coins: number;
    }>,

  listRedemptions: () => http.get("/rewards/redemptions") as Promise<Redemption[]>,

  resolveRedemption: (redemptionId: number, status: "approved" | "denied" | "fulfilled", note?: string) =>
    http.put(`/rewards/redemptions/${redemptionId}/resolve`, { status, note }),
};
