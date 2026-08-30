import { useEffect } from "react";
/**
 * First-party funnel telemetry.
 *
 * We could not answer "where do people stop" because nothing recorded it — the
 * only evidence was me driving a browser by hand, which is not evidence. This
 * is the smallest thing that fixes that.
 *
 * No cookie, no third-party tag, no personal data. The session key is random,
 * lives in sessionStorage, and dies when the tab closes, so it cannot be joined
 * to an account. The product is sold on "COPPA & kid-privacy-first" and is used
 * by four-year-olds; a Google tag would contradict that.
 *
 * Every call is fire-and-forget: telemetry must never be able to break the
 * product it is measuring.
 */
import { API_BASE } from "../api/client";

const KEY = "lsh.telemetry.session";

export type TrackEvent =
  | "landing_view"
  | "cta_click"
  | "assessment_start"
  | "assessment_step"
  | "assessment_complete"
  | "plan_view"
  | "register_view"
  | "register_success"
  | "child_added"
  | "sample_view"
  | "pricing_view"
  | "invite_share";

function sessionKey(): string | null {
  if (typeof sessionStorage === "undefined") return null;
  try {
    let k = sessionStorage.getItem(KEY);
    if (!k) {
      // 16 chars of [A-Za-z0-9] — matches the server's validation exactly.
      const abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      const bytes = new Uint8Array(16);
      (globalThis.crypto ?? ({} as any)).getRandomValues?.(bytes);
      k = Array.from(bytes, b => abc[b % abc.length]).join("");
      if (k.length !== 16) return null;
      sessionStorage.setItem(KEY, k);
    }
    return k;
  } catch {
    return null;   // private mode, storage disabled — measure nothing, break nothing
  }
}

/** Record one funnel step. Never throws, never awaits, never blocks a render. */
export function track(event: TrackEvent, opts: { step?: number; meta?: string } = {}) {
  try {
    const session = sessionKey();
    if (!session) return;
    const body = JSON.stringify({ event, session, step: opts.step, meta: opts.meta });

    // keepalive lets the request outlive the page, which matters for the last
    // event before someone navigates away — usually the interesting one.
    fetch(`${API_BASE}/events`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body,
      keepalive: true,
    }).catch(() => { /* dropped measurement, not a broken page */ });
  } catch {
    /* ignore */
  }
}

/** Record a screen view once, on mount. */
export function useTrackView(event: TrackEvent, opts: { meta?: string } = {}) {
  useEffect(() => {
    track(event, opts);
    // Deliberately mount-only: re-firing on every prop change would count one
    // visit many times and make the funnel look healthier than it is.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);
}
