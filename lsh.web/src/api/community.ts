import http from "./client";

export const communityApi = {
  getRsvp: (sessionLabel: string) =>
    http.get(`/community/office-hours/rsvp?session_label=${encodeURIComponent(sessionLabel)}`) as Promise<{ rsvped: boolean }>,
  rsvp: (sessionLabel: string) =>
    http.post("/community/office-hours/rsvp", { session_label: sessionLabel }) as Promise<{ ok: boolean; rsvped: boolean }>,
};
