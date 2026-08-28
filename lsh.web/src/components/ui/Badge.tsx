import { View, Text, StyleSheet, ViewStyle } from "react-native";
import { colors } from "../../constants/theme";

interface Props {
  label: string;
  color?: string;
  bg?: string;
  style?: ViewStyle;
}

export function Badge({ label, color = colors.brand, bg = colors.brandLight, style }: Props) {
  return (
    <View style={[s.badge, { backgroundColor: bg }, style]}>
      <Text style={[s.text, { color }]}>{label}</Text>
    </View>
  );
}

const s = StyleSheet.create({
  badge: { borderRadius: 20, paddingHorizontal: 12, paddingVertical: 5, alignSelf: "flex-start" },
  text:  { fontSize: 12, fontWeight: "700" },
});
