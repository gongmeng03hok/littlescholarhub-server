import { TouchableOpacity, Text, ActivityIndicator, StyleSheet, ViewStyle } from "react-native";
import { colors } from "../../constants/theme";

interface Props {
  label: string;
  onPress: () => void;
  variant?: "primary" | "outline" | "ghost" | "danger";
  size?: "sm" | "md" | "lg";
  loading?: boolean;
  disabled?: boolean;
  style?: ViewStyle;
  fullWidth?: boolean;
}

export function Button({ label, onPress, variant = "primary", size = "md", loading, disabled, style, fullWidth }: Props) {
  const vs = variantStyles[variant];
  const ss = sizeStyles[size];
  return (
    <TouchableOpacity
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.82}
      style={[s.base, vs.btn, ss.btn, fullWidth && s.fullWidth, (disabled || loading) && s.dim, style]}
    >
      {loading
        ? <ActivityIndicator color={variant === "primary" || variant === "danger" ? "white" : colors.brand} size="small" />
        : <Text style={[s.text, vs.text, ss.text]}>{label}</Text>
      }
    </TouchableOpacity>
  );
}

const s = StyleSheet.create({
  base:      { borderRadius: 12, alignItems: "center", justifyContent: "center" },
  fullWidth: { width: "100%" },
  text:      { fontWeight: "800" },
  dim:       { opacity: 0.55 },
});

const variantStyles = {
  primary: {
    btn:  { backgroundColor: colors.brand },
    text: { color: "white" },
  },
  outline: {
    btn:  { backgroundColor: "transparent", borderWidth: 2, borderColor: colors.brand },
    text: { color: colors.brand },
  },
  ghost: {
    btn:  { backgroundColor: "transparent" },
    text: { color: colors.brand },
  },
  danger: {
    btn:  { backgroundColor: colors.danger },
    text: { color: "white" },
  },
};

const sizeStyles = {
  sm: { btn: { paddingHorizontal: 14, paddingVertical: 8  }, text: { fontSize: 13 } },
  md: { btn: { paddingHorizontal: 20, paddingVertical: 14 }, text: { fontSize: 15 } },
  lg: { btn: { paddingHorizontal: 28, paddingVertical: 18 }, text: { fontSize: 17 } },
};
