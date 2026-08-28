/**
 * Carries a guest's assessment answers across the sign-up boundary.
 *
 * The public assessment runs before there is an account, so
 * `POST /assessment/submit` has no `child_id` and the API returns the plan
 * without storing it ("plan saved to DB" only happens for a child the caller
 * owns). The reveal screen's CTA still promised "Create free account to save
 * plan", but nothing was carried across — the new parent landed on an empty
 * dashboard and had to re-enter the grade by hand, and the plan they had just
 * spent two minutes building was gone.
 *
 * We stash the raw answers here, pre-fill the grade on the add-child form, and
 * re-submit them against the real `child_id` once the child exists.
 */
const KEY = "lsh.pendingAssessment";
const MAX_AGE_MS = 7 * 24 * 60 * 60 * 1000; // a week — long enough to finish signing up

export type PendingAssessment = { answers: Record<string, any>; ts: number };

export function savePendingAssessment(answers: Record<string, any>) {
  if (typeof localStorage === "undefined") return;
  try {
    localStorage.setItem(KEY, JSON.stringify({ answers, ts: Date.now() }));
  } catch { /* private mode / quota — the plan simply is not carried over */ }
}

export function readPendingAssessment(): PendingAssessment | null {
  if (typeof localStorage === "undefined") return null;
  try {
    const raw = localStorage.getItem(KEY);
    if (!raw) return null;
    const parsed = JSON.parse(raw) as PendingAssessment;
    if (!parsed?.answers || typeof parsed.ts !== "number") return null;
    if (Date.now() - parsed.ts > MAX_AGE_MS) { clearPendingAssessment(); return null; }
    return parsed;
  } catch { return null; }
}

export function clearPendingAssessment() {
  if (typeof localStorage === "undefined") return;
  try { localStorage.removeItem(KEY); } catch { /* ignore */ }
}

/**
 * grade_id the guest picked, if the assessment captured one.
 *
 * The assessment answers a school year ("TK", "K", "1" … "6"), while
 * `dbo.Grades` keys on grade_id (0=TK, 1=K, 2=1st … 7=6th). Convert here so
 * callers only ever deal with grade_id.
 */
const GRADE_ANSWER_TO_ID: Record<string, number> = {
  TK: 0, K: 1, "1": 2, "2": 3, "3": 4, "4": 5, "5": 6, "6": 7,
};

export function pendingGradeId(): number | null {
  const p = readPendingAssessment();
  if (!p) return null;

  const raw = p.answers?.grade;
  if (typeof raw === "string") {
    const mapped = GRADE_ANSWER_TO_ID[raw.trim().toUpperCase()];
    if (mapped !== undefined) return mapped;
  }

  // Tolerate a grade_id being supplied directly (older stashes / future callers).
  const direct = p.answers?.grade_id;
  const n = typeof direct === "string" ? parseInt(direct, 10) : direct;
  return Number.isFinite(n) && n >= 0 && n <= 7 ? (n as number) : null;
}
