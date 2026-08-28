/**
 * SpeakButton — the 🔊 control used by question cards, answer choices and
 * craft steps. Renders nothing when the browser has no speech engine or the
 * parent has switched read-aloud off in settings, so callers can drop it in
 * without guarding.
 */
import { TouchableOpacity, Text, StyleSheet, type ViewStyle } from "react-native";
import { colors } from "../constants/theme";
import { useSpeech } from "../hooks/useSpeech";

interface Props {
  /** One phrase, or several to be read in order with a pause between them. */
  text: string | string[];
  /** `small` sits inside an answer choice; `large` heads a question. */
  size?: "small" | "large";
  /** Visible next to the icon at `large` size. */
  label?: string;
  /** Announced to screen readers; falls back to `label`. */
  accessibilityLabel?: string;
  style?: ViewStyle;
}

export function SpeakButton({ text, size = "small", label, accessibilityLabel, style }: Props) {
  const { speak, speaking, stop, supported, enabled } = useSpeech();
  if (!supported || !enabled) return null;

  const big = size === "large";
  return (
    <TouchableOpacity
      onPress={() => (speaking ? stop() : speak(text))}
      style={[big ? s.large : s.small, style]}
      accessibilityRole="button"
      accessibilityLabel={accessibilityLabel ?? label ?? "Read this out loud"}
      // Young children aim badly — widen the tap target well past the circle.
      hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
      activeOpacity={0.7}
    >
      <Text style={big ? s.largeIcon : s.smallIcon}>{speaking ? "⏸" : "🔊"}</Text>
      {big && !!label && <Text style={s.largeLabel}>{label}</Text>}
    </TouchableOpacity>
  );
}

const s = StyleSheet.create({
  small: {
    width: 34, height: 34, borderRadius: 17,
    alignItems: "center", justifyContent: "center",
    backgroundColor: colors.brandLight,
    flexShrink: 0,
  },
  smallIcon: { fontSize: 16 },

  large: {
    flexDirection: "row", alignItems: "center", gap: 8,
    alignSelf: "flex-start",
    paddingVertical: 8, paddingHorizontal: 14,
    borderRadius: 999,
    backgroundColor: colors.brandLight,
  },
  largeIcon:  { fontSize: 18 },
  largeLabel: { fontSize: 14, fontWeight: "800", color: colors.brand },
});
