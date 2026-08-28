import { Alert, Platform } from "react-native";

/**
 * Cross-platform confirm dialog. React Native Web's Alert.alert with a
 * button array is a no-op — it never renders anything and never calls the
 * button callbacks — so on web this falls back to window.confirm instead.
 */
export function confirmAction(
  title: string,
  message: string | undefined,
  onConfirm: () => void,
  confirmLabel: string = "Delete",
  destructive: boolean = true,
) {
  if (Platform.OS === "web") {
    if (window.confirm(message ? `${title}\n\n${message}` : title)) onConfirm();
    return;
  }
  Alert.alert(title, message, [
    { text: "Cancel", style: "cancel" },
    { text: confirmLabel, style: destructive ? "destructive" : "default", onPress: onConfirm },
  ]);
}
