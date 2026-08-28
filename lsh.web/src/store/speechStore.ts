import { create } from "zustand";

/**
 * Read-aloud preference.
 *
 * On by default: the platform serves TK–6, and the youngest children cannot
 * read the questions they are being asked. Turning it off hides every 🔊
 * control — it never auto-plays, so "on" only means the buttons are offered.
 *
 * Persisted by hand rather than with zustand/persist to stay consistent with
 * the other stores here, which are all plain `create()`.
 */
const KEY = "lsh.readAloud";

function load(): boolean {
  try {
    if (typeof localStorage === "undefined") return true;
    const raw = localStorage.getItem(KEY);
    return raw === null ? true : raw === "1";
  } catch {
    return true; // private mode / storage disabled — just offer the buttons
  }
}

function save(on: boolean) {
  try {
    if (typeof localStorage !== "undefined") localStorage.setItem(KEY, on ? "1" : "0");
  } catch {
    /* non-fatal: the preference simply won't survive a reload */
  }
}

interface SpeechState {
  enabled: boolean;
  setEnabled: (on: boolean) => void;
}

export const useSpeechStore = create<SpeechState>((set) => ({
  enabled: load(),
  setEnabled: (on) => {
    save(on);
    set({ enabled: on });
  },
}));
