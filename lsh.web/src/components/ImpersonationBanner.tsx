import { View, Text, TouchableOpacity, StyleSheet, Platform } from "react-native";
import { useRouter } from "expo-router";
import { useQueryClient } from "@tanstack/react-query";
import { useAuthStore } from "../store/authStore";
import { useChildStore } from "../store/childStore";
import { colors } from "../constants/theme";

/** Persistent banner shown while an admin is impersonating a parent/teacher
 * account, with a one-tap way back to their own admin session. */
export function ImpersonationBanner() {
  const router = useRouter();
  const qc = useQueryClient();
  const { isImpersonating, family, returnFromImpersonation } = useAuthStore();

  if (!isImpersonating) return null;

  const back = async () => {
    await returnFromImpersonation();
    // Drop every query cached under the impersonated account's identity.
    qc.clear();
    useChildStore.getState().setChildren([]);
    router.replace("/(admin)");
  };

  return (
    <View style={s.banner}>
      <Text style={s.text} numberOfLines={1}>
        👀 Viewing as {family?.email ?? "this account"}
      </Text>
      <TouchableOpacity style={s.btn} onPress={back}>
        <Text style={s.btnText}>← Return to admin</Text>
      </TouchableOpacity>
    </View>
  );
}

const s = StyleSheet.create({
  banner: { position: "absolute", top: Platform.OS === "ios" ? 0 : 0, left: 0, right: 0, zIndex: 999,
            backgroundColor: "#1a1a2e", flexDirection: "row", alignItems: "center", justifyContent: "space-between",
            paddingHorizontal: 14, paddingVertical: 8, paddingTop: Platform.OS === "ios" ? 48 : 8 },
  text: { color: "white", fontSize: 12, fontWeight: "700", flex: 1, marginRight: 10 },
  btn:  { backgroundColor: colors.accent, borderRadius: 8, paddingHorizontal: 10, paddingVertical: 6 },
  btnText: { color: "#1a1a2e", fontSize: 11, fontWeight: "900" },
});
