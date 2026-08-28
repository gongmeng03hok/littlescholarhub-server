import { View, StyleSheet, ViewStyle } from "react-native";
import { colors } from "../../constants/theme";

interface Props {
  children: React.ReactNode;
  style?: ViewStyle;
  padded?: boolean;
}

export function Card({ children, style, padded = true }: Props) {
  return (
    <View style={[s.card, padded && s.padded, style]}>
      {children}
    </View>
  );
}

const s = StyleSheet.create({
  card: {
    backgroundColor: colors.surface,
    borderRadius: 16,
    shadowColor: "#000",
    shadowOpacity: 0.07,
    shadowRadius: 12,
    shadowOffset: { width: 0, height: 4 },
    elevation: 3,
  },
  padded: { padding: 20 },
});
