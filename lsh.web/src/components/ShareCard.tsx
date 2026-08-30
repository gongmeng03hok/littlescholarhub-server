/**
 * The invite card.
 *
 * Every family already has a referral_code, the register form already accepts
 * one, and the landing page already advertises "give a month, get a month".
 * Nothing surfaced the code to the parent holding it, so in the life of the
 * product exactly zero referrals have been recorded. This is the missing half.
 *
 * Deliberately gives a whole LINK rather than a code to type: a code someone has
 * to remember, retype and spell correctly is a step most people will not take,
 * and /register reads ?ref= straight off the URL.
 */
import { useState } from "react";
import { Platform, Pressable, StyleSheet, Text, View } from "react-native";

import { colors, fonts } from "../constants/theme";
import { track } from "../utils/track";

const SITE = "https://www.littlescholarhub.com";

export function ShareCard({ code }: { code?: string }) {
  const [copied, setCopied] = useState(false);
  if (!code) return null;

  const link = `${SITE}/register?ref=${encodeURIComponent(code)}`;
  const message =
    `We use Little Scholars Hub for the kids - one calm weekly plan, TK to 6th, ` +
    `and it prints if you want screen-free days. Use my link and we each get a free month:\n${link}`;

  const share = async () => {
    track("invite_share");
    // Native share sheet where the browser has one; clipboard everywhere else.
    const nav: any = typeof navigator !== "undefined" ? navigator : null;
    if (Platform.OS === "web" && nav?.share) {
      try {
        await nav.share({ title: "Little Scholars Hub", text: message, url: link });
        return;
      } catch {
        /* dismissed — fall through to copy */
      }
    }
    try {
      await nav?.clipboard?.writeText(message);
      setCopied(true);
      setTimeout(() => setCopied(false), 2400);
    } catch {
      setCopied(false);
    }
  };

  return (
    <View style={s.card}>
      <Text style={s.eyebrow}>🎁  INVITE A FAMILY</Text>
      <Text style={s.title}>Give a month, get a month</Text>
      <Text style={s.body}>
        Send a friend your link. When they start a plan, you both get a free month.
      </Text>

      <View style={s.codeRow}>
        <Text style={s.codeLabel}>Your code</Text>
        <Text style={s.code}>{code}</Text>
      </View>

      <Pressable
        onPress={share}
        style={({ pressed }) => [s.btn, pressed && s.btnPressed]}
        accessibilityRole="button"
        accessibilityLabel="Share your invite link"
      >
        <Text style={s.btnText}>
          {copied ? "✓  Link copied — paste it anywhere" : "Share my invite link"}
        </Text>
      </Pressable>

      <Text style={s.link} numberOfLines={1}>{link}</Text>
    </View>
  );
}

const s = StyleSheet.create({
  card: {
    borderRadius: 18,
    padding: 20,
    marginBottom: 16,
    backgroundColor: "#fff7ed",
    borderWidth: 2,
    borderColor: "#fed7aa",
  },
  eyebrow: { fontSize: 11, fontWeight: "800", letterSpacing: 1.4, color: "#c2410c", marginBottom: 8 },
  title:   { fontSize: 20, fontWeight: "800", fontFamily: fonts.kid, color: colors.text },
  body:    { fontSize: 14, lineHeight: 20, color: colors.textMuted, marginTop: 6 },
  codeRow: {
    flexDirection: "row", alignItems: "center", gap: 10,
    marginTop: 14, marginBottom: 12,
  },
  codeLabel: { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  code: {
    fontSize: 18, fontWeight: "800", letterSpacing: 1.2, color: "#9a3412",
    backgroundColor: "#ffedd5", paddingHorizontal: 12, paddingVertical: 6, borderRadius: 10,
  },
  btn: {
    backgroundColor: "#ea580c",
    paddingVertical: 14, borderRadius: 14, alignItems: "center",
  },
  btnPressed: { opacity: 0.85 },
  btnText: { color: "#fff", fontSize: 16, fontWeight: "800", fontFamily: fonts.kid },
  link: { fontSize: 11, color: colors.textMuted, marginTop: 8, textAlign: "center" },
});
