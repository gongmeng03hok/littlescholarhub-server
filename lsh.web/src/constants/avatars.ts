// Avatar buddies + treasure-chest styles for kid registration / customize.
// ORIGINAL, license-safe archetypes only (no branded characters).

export const AVATAR_EMOJI: Record<string, string> = {
  star: "⭐", cat: "🐱", dog: "🐶", bear: "🐻", rabbit: "🐰", panda: "🐼",
  unicorn: "🦄", fox: "🦊", owl: "🦉", frog: "🐸", tiger: "🐯", koala: "🐨",
  lion: "🦁", dragon: "🐲", dino: "🦖", robot: "🤖", rocket: "🚀", bolt: "⚡",
};

export function avatarEmoji(slug?: string): string {
  return (slug && AVATAR_EMOJI[slug]) || "⭐";
}

// Age-tiered suggestions (research-backed: cute animals → adventurous → cooler).
export const AVATAR_CHOICES: { tier: string; ages: string; slugs: string[] }[] = [
  { tier: "Little ones", ages: "4–6",  slugs: ["bear", "rabbit", "cat", "dog", "panda", "unicorn"] },
  { tier: "Explorers",   ages: "7–9",  slugs: ["fox", "owl", "frog", "tiger", "koala", "dragon"] },
  { tier: "Big kids",    ages: "10–12", slugs: ["rocket", "robot", "dino", "bolt", "lion", "dragon"] },
];

export const CHESTS: { id: string; emoji: string; label: string }[] = [
  { id: "classic", emoji: "🧰", label: "Classic" },
  { id: "pirate",  emoji: "💰", label: "Pirate" },
  { id: "gem",     emoji: "💎", label: "Gem vault" },
  { id: "star",    emoji: "⭐", label: "Star box" },
];

export function chestEmoji(id?: string): string {
  const c = CHESTS.find(x => x.id === id);
  return c ? c.emoji : "🧰";
}

// ── Glossy 3D artwork (Pixar-style renders). Metro needs STATIC require() paths. ──
// Drop-in: same slug filenames in assets/avatars & assets/chests. Emoji stays as fallback.
export const AVATAR_IMG: Record<string, any> = {
  star:    require("../assets/avatars/star.png"),
  cat:     require("../assets/avatars/cat.png"),
  dog:     require("../assets/avatars/dog.png"),
  bear:    require("../assets/avatars/bear.png"),
  rabbit:  require("../assets/avatars/rabbit.png"),
  panda:   require("../assets/avatars/panda.png"),
  unicorn: require("../assets/avatars/unicorn.png"),
  fox:     require("../assets/avatars/fox.png"),
  owl:     require("../assets/avatars/owl.png"),
  frog:    require("../assets/avatars/frog.png"),
  tiger:   require("../assets/avatars/tiger.png"),
  koala:   require("../assets/avatars/koala.png"),
  lion:    require("../assets/avatars/lion.png"),
  dragon:  require("../assets/avatars/dragon.png"),
  dino:    require("../assets/avatars/dino.png"),
  robot:   require("../assets/avatars/robot.png"),
  rocket:  require("../assets/avatars/rocket.png"),
  bolt:    require("../assets/avatars/bolt.png"),
};

export const CHEST_IMG: Record<string, any> = {
  classic: require("../assets/chests/classic.png"),
  pirate:  require("../assets/chests/pirate.png"),
  gem:     require("../assets/chests/gem.png"),
  star:    require("../assets/chests/star.png"),
};

export function avatarImage(slug?: string): any {
  return (slug && AVATAR_IMG[slug]) || undefined;
}

export function chestImage(id?: string): any {
  return (id && CHEST_IMG[id]) || undefined;
}
