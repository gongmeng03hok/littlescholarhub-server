/**
 * Returns today's Gita verse from the database via API.
 * The backend rotates by day-of-year so every user sees the same verse on the same day.
 * Falls back to a hardcoded entry while the request is in-flight.
 * Return shape matches GitaVerse so all call-sites (landing page, WisdomCard) work unchanged.
 */
import { useQuery } from "@tanstack/react-query";
import { contentApi } from "../api/content";
import type { GitaVerse } from "../constants/gitaWisdom";

const FALLBACK: GitaVerse = {
  verse: "2.47",
  title: "Do your best. Let go of the rest.",
  body:  "You get to choose how hard you try — but not whether things turn out perfectly. Give your full effort, then release the worry. That is where peace lives.",
};

export function useDailyWisdom(): GitaVerse {
  const { data } = useQuery({
    queryKey: ["wisdom-today"],
    queryFn:  () => contentApi.getDailyWisdom(1),
    staleTime: 24 * 60 * 60 * 1000, // re-fetch once per day
    placeholderData: {
      text_original: FALLBACK.body,
      text_english:  FALLBACK.title,
      author:        `Bhagavad Gita ${FALLBACK.verse}`,
      source_track:  "gita",
    },
  });

  if (!data) return FALLBACK;

  // Map API columns → GitaVerse shape
  return {
    verse: (data.author ?? "").replace("Bhagavad Gita ", "").trim() || FALLBACK.verse,
    title: data.text_english ?? FALLBACK.title,
    body:  data.text_original ?? FALLBACK.body,
  };
}
