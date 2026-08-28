import { create } from "zustand";

interface Child {
  child_id: number;
  nickname: string;
  grade_id: number;
  grade_label: string;
  avatar_url?: string;
}

interface ChildState {
  children: Child[];
  activeChild: Child | null;
  setChildren: (list: Child[]) => void;
  setActiveChild: (child: Child | null) => void;
}

/**
 * The active child is remembered across page loads.
 *
 * Without this the store started empty on every load, so a parent who
 * refreshed — or opened a bookmark / deep link straight to /plan,
 * /progress or /weekly-packets — was told "No child selected" even though
 * their family had children. Those screens read `activeChild` but only the
 * dashboard ever hydrated it, so the child had to be re-picked by visiting
 * Home first. We persist just the id (the records themselves are refetched
 * by `useChildren`, so a renamed or removed child can never go stale here).
 */
const KEY = "lsh.activeChildId";

function readStoredId(): number | null {
  if (typeof localStorage === "undefined") return null;
  const raw = localStorage.getItem(KEY);
  const id  = raw ? parseInt(raw, 10) : NaN;
  return Number.isFinite(id) ? id : null;
}

function writeStoredId(id: number | null) {
  if (typeof localStorage === "undefined") return;
  if (id == null) localStorage.removeItem(KEY);
  else            localStorage.setItem(KEY, String(id));
}

export const useChildStore = create<ChildState>((set, get) => ({
  children: [],
  activeChild: null,

  setChildren: (children) => {
    // Keep the current selection if it is still in the list, otherwise fall
    // back to the id we remembered, otherwise the first child.
    const currentId = get().activeChild?.child_id ?? readStoredId();
    const match     = children.find(c => c.child_id === currentId);
    const activeChild = match ?? (children.length ? children[0] : null);
    writeStoredId(activeChild?.child_id ?? null);
    set({ children, activeChild });
  },

  setActiveChild: (activeChild) => {
    writeStoredId(activeChild?.child_id ?? null);
    set({ activeChild });
  },
}));
