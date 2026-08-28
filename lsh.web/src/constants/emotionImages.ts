// Emotion illustrations for the Feelings & Emotions questions (kids are visual).
// AI-generated (Canva), one flat-cartoon face per emotion, color-coded background.
// Metro requires static literal require() paths, so keep this as a fixed map.

export const EMOTION_IMAGES: Record<string, any> = {
  happy:  require("../assets/emotions/happy.png"),
  sad:    require("../assets/emotions/sad.png"),
  angry:  require("../assets/emotions/angry.png"),
  proud:  require("../assets/emotions/proud.png"),
  scared: require("../assets/emotions/scared.png"),
  calm:   require("../assets/emotions/calm.png"),
};

/** Return the illustration for an emotion option (case/space-insensitive), or undefined. */
export function emotionImage(option?: string): any | undefined {
  if (!option) return undefined;
  return EMOTION_IMAGES[option.trim().toLowerCase()];
}
