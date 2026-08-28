/**
 * ISO-8601 week calendar (Mon–Sun weeks; a week "belongs" to whichever
 * month/year contains its Thursday — the standard ISO rule, so Dec 29, 2025
 * through Jan 4, 2026 is "Week 1 - Jan 2026") plus the deterministic
 * word-search grid generator, shared by the admin/parent/teacher Weekly
 * Packets screens.
 */
function pad2(n: number) { return String(n).padStart(2, "0"); }
export function toISODate(d: Date) { return `${d.getFullYear()}-${pad2(d.getMonth() + 1)}-${pad2(d.getDate())}`; }
function formatShort(d: Date) { return d.toLocaleDateString("en-US", { month: "short", day: "2-digit", year: "numeric" }); }

export interface WeekOption { weekNum: number; label: string; value: string }

export function getIsoWeeksForYear(year: number): WeekOption[] {
  const jan4 = new Date(year, 0, 4);
  const jan4Day = (jan4.getDay() + 6) % 7; // Monday=0 .. Sunday=6
  const monday = new Date(jan4);
  monday.setDate(jan4.getDate() - jan4Day);

  const weeks: WeekOption[] = [];
  let weekNum = 1;
  while (true) {
    const sunday = new Date(monday);
    sunday.setDate(monday.getDate() + 6);
    const thursday = new Date(monday);
    thursday.setDate(monday.getDate() + 3);
    if (thursday.getFullYear() > year) break;
    if (thursday.getFullYear() === year) {
      const monthLabel = thursday.toLocaleDateString("en-US", { month: "short" });
      weeks.push({
        weekNum,
        label: `Week ${weekNum} - ${monthLabel} ${year}: ${formatShort(monday)} – ${formatShort(sunday)}`,
        value: toISODate(monday),
      });
      weekNum++;
    }
    monday.setDate(monday.getDate() + 7);
  }
  return weeks;
}

export const WEEK_OPTIONS_2026 = getIsoWeeksForYear(2026);

export function weekContainingToday(options: WeekOption[]): string | null {
  const today = toISODate(new Date());
  let match: WeekOption | null = null;
  for (const w of options) {
    if (w.value <= today) match = w; else break;
  }
  return match?.value ?? null;
}

// ── Deterministic word-search grid, seeded from the word list ──────────────
function hashStr(s: string) {
  let h = 0;
  for (let i = 0; i < s.length; i++) h = (Math.imul(31, h) + s.charCodeAt(i)) | 0;
  return h;
}
function seededRandom(seed: number) {
  let s = seed;
  return () => {
    s |= 0; s = (s + 0x6d2b79f5) | 0;
    let t = Math.imul(s ^ (s >>> 15), 1 | s);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
export function buildWordSearch(words: string[], size = 9) {
  const rand = seededRandom(hashStr(words.join(",")));
  const grid: (string | null)[][] = Array.from({ length: size }, () => Array(size).fill(null));
  const found = new Set<string>();
  const dirs: [number, number][] = [[0, 1], [1, 0]];
  for (const word of words) {
    let placed = false, attempts = 0;
    while (!placed && attempts < 300) {
      attempts++;
      const dir = dirs[Math.floor(rand() * dirs.length)];
      const maxR = dir[0] ? size - word.length : size - 1;
      const maxC = dir[1] ? size - word.length : size - 1;
      if (maxR < 0 || maxC < 0) break;
      const r = Math.floor(rand() * (maxR + 1));
      const c = Math.floor(rand() * (maxC + 1));
      let ok = true;
      const cells: [number, number][] = [];
      for (let i = 0; i < word.length; i++) {
        const rr = r + dir[0] * i, cc = c + dir[1] * i;
        if (grid[rr][cc] !== null && grid[rr][cc] !== word[i]) { ok = false; break; }
        cells.push([rr, cc]);
      }
      if (ok) {
        cells.forEach(([rr, cc], i) => { grid[rr][cc] = word[i]; found.add(`${rr},${cc}`); });
        placed = true;
      }
    }
  }
  const letters = "BCDFGHJKLMNPRSTVWY";
  for (let r = 0; r < size; r++) for (let c = 0; c < size; c++) {
    if (grid[r][c] === null) grid[r][c] = letters[Math.floor(rand() * letters.length)];
  }
  return { grid: grid as string[][], found };
}
export type WordSearchResult = ReturnType<typeof buildWordSearch>;
