import { View, Text, TouchableOpacity, StyleSheet, Platform } from "react-native";
import { useRouter } from "expo-router";
import { colors } from "../../constants/theme";

interface Props {
  title: string;
  subtitle?: string;
  showBack?: boolean;
  rightAction?: { label: string; onPress: () => void };
}

export function ScreenHeader({ title, subtitle, showBack, rightAction }: Props) {
  const router = useRouter();
  return (
    <View style={s.header}>
      <View style={s.row}>
        {showBack && (
          <TouchableOpacity onPress={() => router.back()} style={s.back} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
            <Text style={s.backText}>←</Text>
          </TouchableOpacity>
        )}
        <View style={{ flex: 1 }}>
          <Text style={s.title}>{title}</Text>
          {subtitle && <Text style={s.subtitle}>{subtitle}</Text>}
        </View>
        {rightAction && (
          <TouchableOpacity onPress={rightAction.onPress} style={s.right}>
            <Text style={s.rightText}>{rightAction.label}</Text>
          </TouchableOpacity>
        )}
      </View>
    </View>
  );
}

const s = StyleSheet.create({
  header:    { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 16, paddingBottom: 16, paddingHorizontal: 20, borderBottomWidth: 1, borderBottomColor: colors.border },
  row:       { flexDirection: "row", alignItems: "center" },
  back:      { marginRight: 12 },
  backText:  { fontSize: 22, color: colors.brand, fontWeight: "700" },
  title:     { fontSize: 22, fontWeight: "900", color: colors.text },
  subtitle:  { fontSize: 13, color: colors.textMuted, marginTop: 2 },
  right:     { marginLeft: 12 },
  rightText: { fontSize: 14, fontWeight: "700", color: colors.brand },
});
