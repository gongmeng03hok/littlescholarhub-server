import { TextInput, View, Text, StyleSheet, TextInputProps, ViewStyle } from "react-native";
import { colors } from "../../constants/theme";

interface Props extends TextInputProps {
  label?: string;
  error?: string;
  containerStyle?: ViewStyle;
}

export function Input({ label, error, containerStyle, style, ...rest }: Props) {
  return (
    <View style={[s.wrap, containerStyle]}>
      {label && <Text style={s.label}>{label}</Text>}
      <TextInput
        style={[s.input, error && s.inputError, style]}
        placeholderTextColor={colors.textMuted}
        {...rest}
      />
      {error && <Text style={s.error}>{error}</Text>}
    </View>
  );
}

const s = StyleSheet.create({
  wrap:       { marginBottom: 14 },
  label:      { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 6 },
  input:      { borderWidth: 1.5, borderColor: colors.border, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 15, color: colors.text, backgroundColor: "white" },
  inputError: { borderColor: colors.danger },
  error:      { fontSize: 12, color: colors.danger, marginTop: 4 },
});
