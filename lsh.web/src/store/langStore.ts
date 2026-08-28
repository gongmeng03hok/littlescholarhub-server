import { create } from "zustand";

export type Lang = "en" | "zh" | "hi" | "es";

interface LangState {
  lang: Lang;
  setLang: (lang: Lang) => void;
}

export const useLangStore = create<LangState>((set) => ({
  lang: "en",
  setLang: (lang) => set({ lang }),
}));
