import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { childrenApi } from "../api/children";
import { useChildStore } from "../store/childStore";
import { useEffect } from "react";

export function useChildren() {
  const { setChildren } = useChildStore();
  const query = useQuery({
    queryKey: ["children"],
    queryFn:  () => childrenApi.list() as Promise<any[]>,
    staleTime: 60_000,
  });

  useEffect(() => {
    if (query.data) setChildren(query.data);
  }, [query.data]);

  return query;
}

export function useAddChild() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: childrenApi.add,
    onSuccess:  () => qc.invalidateQueries({ queryKey: ["children"] }),
  });
}

export function useUpdateChild() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: ({ id, body }: { id: number; body: Partial<{ nickname: string; grade_id: number; avatar_url: string }> }) =>
      childrenApi.update(id, body),
    onSuccess:  () => qc.invalidateQueries({ queryKey: ["children"] }),
  });
}

export function useDeleteChild() {
  const qc = useQueryClient();
  return useMutation({
    mutationFn: (id: number) => childrenApi.delete(id),
    onSuccess:  () => qc.invalidateQueries({ queryKey: ["children"] }),
  });
}
