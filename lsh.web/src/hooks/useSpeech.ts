/**
 * Read-aloud for questions, answer choices and craft steps.
 *
 * Uses the browser's Web Speech API rather than the gTTS pipeline in
 * lsh.api/app/services/tts_service.py. That pipeline is right for Stories —
 * long, authored once, worth storing an mp3 for — but wrong here: questions are
 * generated on the fly by services/question_generator.py, so there is no stable
 * text to pre-render audio for. speechSynthesis also covers all four language
 * tracks, where _LANG_CODES in tts_service.py is English-only today.
 *
 * Everything degrades quietly: if the API is missing (older browser, native
 * build) `supported` is false and callers hide their 🔊 controls.
 */
import { useCallback, useEffect, useRef, useState } from "react";
import { useLangStore, type Lang } from "../store/langStore";
import { useSpeechStore } from "../store/speechStore";

/** App language → BCP-47 tag the speech engine expects. */
const VOICE_LANG: Record<Lang, string> = {
  en: "en-US",
  zh: "zh-CN",
  hi: "hi-IN",
  es: "es-ES",
};

function synth(): SpeechSynthesis | null {
  if (typeof window === "undefined") return null;
  return window.speechSynthesis ?? null;
}

/** Strip things that read badly: fill-in blanks, markup, decorative glyphs. */
export function cleanForSpeech(text: string): string {
  return String(text ?? "")
    .replace(/<[^>]+>/g, " ")
    .replace(/_{2,}/g, " blank ")
    .replace(/\s*[_]\s*/g, " blank ")     // single-letter blanks: 'd_g'
    .replace(/[▲●■◆★]/g, " shape ")
    .replace(/×/g, " times ")
    .replace(/÷/g, " divided by ")
    .replace(/−/g, " minus ")
    .replace(/\s+/g, " ")
    .trim();
}

export function useSpeech() {
  const lang     = useLangStore((s) => s.lang);
  const enabled  = useSpeechStore((s) => s.enabled);
  const [speaking, setSpeaking] = useState(false);
  const mounted = useRef(true);

  const supported = !!synth();

  useEffect(() => {
    mounted.current = true;
    return () => {
      mounted.current = false;
      // Never let a sentence follow the child to the next screen.
      synth()?.cancel();
    };
  }, []);

  const stop = useCallback(() => {
    synth()?.cancel();
    if (mounted.current) setSpeaking(false);
  }, []);

  /**
   * Speak one or more phrases in order. Passing several strings inserts a
   * natural pause between them, so a question and its choices don't run
   * together into one breathless sentence.
   */
  const speak = useCallback((input: string | string[]) => {
    const s = synth();
    if (!s || !enabled) return;

    const parts = (Array.isArray(input) ? input : [input])
      .map(cleanForSpeech)
      .filter(Boolean);
    if (!parts.length) return;

    // Tapping 🔊 again restarts rather than queueing on top of itself.
    s.cancel();
    setSpeaking(true);

    parts.forEach((part, i) => {
      const u = new SpeechSynthesisUtterance(part);
      u.lang = VOICE_LANG[lang] ?? VOICE_LANG.en;
      u.rate = 0.9;   // a touch slower than default — these are early readers
      u.pitch = 1.05;
      if (i === parts.length - 1) {
        u.onend   = () => mounted.current && setSpeaking(false);
        u.onerror = () => mounted.current && setSpeaking(false);
      }
      s.speak(u);
    });
  }, [enabled, lang]);

  return { speak, stop, speaking, supported, enabled };
}
