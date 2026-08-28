import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { rewardsApi } from "../api/rewards";

export function useRewardItems(all = false) {
  return useQuery({
    queryKey: ["rewardItems", all],
    queryFn:  () => rewardsApi.listItems(all),
    staleTime: 30_000,
    placeholderData: [],
  });
}

export function useCreateRewardItem() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: rewardsApi.createItem,
    onSuccess: () => qc.invalidateQueries({ queryKey: ["rewardItems"] }),
  });
}

export function useUpdateRewardItem() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ rewardId, body }: { rewardId: number; body: Parameters<typeof rewardsApi.updateItem>[1] }) =>
      rewardsApi.updateItem(rewardId, body),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["rewardItems"] }),
  });
}

export function useDeleteRewardItem() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (rewardId: number) => rewardsApi.deleteItem(rewardId),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["rewardItems"] }),
  });
}

export function useRedeemReward() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ childId, rewardId }: { childId: number; rewardId: number }) =>
      rewardsApi.redeem(childId, rewardId),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["redemptions"] });
      qc.invalidateQueries({ queryKey: ["gameProfile"] });
    },
  });
}

export function useRedemptions() {
  return useQuery({
    queryKey: ["redemptions"],
    queryFn:  () => rewardsApi.listRedemptions(),
    staleTime: 15_000,
    placeholderData: [],
  });
}

export function useResolveRedemption() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ redemptionId, status, note }: {
      redemptionId: number; status: "approved" | "denied" | "fulfilled"; note?: string;
    }) => rewardsApi.resolveRedemption(redemptionId, status, note),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["redemptions"] }),
  });
}
