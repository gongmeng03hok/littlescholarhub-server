import { View, Text, StyleSheet } from "react-native";
import { colors } from "../../constants/theme";
import { Button } from "./Button";

interface Props {
  emoji?: string;
  title: string;
  body?: string;
  actionLabel?: string;
  onAction?: () => void;
}

export function EmptyState({ emoji = "📭", title, body, actionLabel, onAction }: Props) {
  return (
    <View style={s.wrap}>
      <Text style={s.emoji}>{emoji}</Text>
      <Text style={s.title}>{title}</Text>
      {body && <Text style={s.body}>{body}</Text>}
      {actionLabel && onAction && (
        <Button label={actionLabel} onPress={onAction} style={{ marginTop: 16 }} />
      )}
    </View>
  );
}

const s = StyleSheet.create({
  wrap:  { flex: 1, justifyContent: "center", alignItems: "center", padding: 40 },
  emoji: { fontSize: 52, marginBottom: 16 },
  title: { fontSize: 20, fontWeight: "800", color: colors.text, textAlign: "center", marginBottom: 8 },
  body:  { fontSize: 14, color: colors.textMuted, textAlign: "center", lineHeight: 22 },
});
