import { Modal as RNModal, View, Text, TouchableOpacity, ScrollView, StyleSheet, Platform } from "react-native";
import { colors, fonts } from "../../constants/theme";

const isWeb = Platform.OS === "web";

interface Props {
  visible: boolean;
  onClose: () => void;
  title?: string;
  subtitle?: string;
  children: React.ReactNode;
  maxWidth?: number;
}

export function Modal({ visible, onClose, title, subtitle, children, maxWidth = 560 }: Props) {
  return (
    <RNModal visible={visible} transparent animationType="fade" onRequestClose={onClose}>
      <View style={s.backdrop}>
        <TouchableOpacity style={StyleSheet.absoluteFill} activeOpacity={1} onPress={onClose} />
        <View style={[s.card, { maxWidth }]}>
          <View style={s.head}>
            <View style={{ flex: 1 }}>
              {!!title && <Text style={s.title}>{title}</Text>}
              {!!subtitle && <Text style={s.subtitle}>{subtitle}</Text>}
            </View>
            <TouchableOpacity onPress={onClose} style={s.closeBtn} accessibilityLabel="Close">
              <Text style={s.closeText}>✕</Text>
            </TouchableOpacity>
          </View>
          <ScrollView style={s.body} contentContainerStyle={{ paddingBottom: 24 }}>
            {children}
          </ScrollView>
        </View>
      </View>
    </RNModal>
  );
}

const fHeading: any = isWeb ? { fontFamily: "'Fraunces', Georgia, serif" } : {};
const fBody: any = isWeb ? { fontFamily: "'Inter', system-ui, sans-serif" } : {};

const s = StyleSheet.create({
  backdrop: {
    flex: 1,
    backgroundColor: "rgba(34,30,26,0.55)",
    alignItems: "center",
    justifyContent: "center",
    padding: 20,
  },
  card: {
    width: "100%",
    maxHeight: "88%",
    backgroundColor: colors.bg,
    borderRadius: 22,
    overflow: "hidden",
    shadowColor: "#000",
    shadowOpacity: 0.35,
    shadowRadius: 40,
    shadowOffset: { width: 0, height: 20 },
    elevation: 10,
  },
  head: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: 16,
    padding: 22,
    backgroundColor: "#fff",
    borderBottomWidth: 1,
    borderBottomColor: colors.border,
  },
  title: { fontSize: 20, fontWeight: "800", color: colors.text, marginBottom: 4, ...fHeading },
  subtitle: { fontSize: 13, color: colors.textMuted, ...fBody },
  closeBtn: {
    width: 32, height: 32, borderRadius: 16, backgroundColor: colors.surfaceAlt,
    alignItems: "center", justifyContent: "center", flexShrink: 0,
  },
  closeText: { fontSize: 15, color: colors.text, fontWeight: "700" },
  body: { padding: 22 },
});
