import http from "./client";

export const configApi = {
  getAll: (languageId: number = 1) =>
    http.get(`/config/?language_id=${languageId}`) as Promise<Record<string, any>>,
  get: (key: string, languageId: number = 1) =>
    http.get(`/config/${key}?language_id=${languageId}`) as Promise<{ key: string; value: any }>,
};
