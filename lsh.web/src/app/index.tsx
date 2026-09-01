import { useEffect } from "react";
import { useRouter } from "expo-router";
import { View, ActivityIndicator } from "react-native";
import { useAuthStore } from "../store/authStore";
import { colors } from "../constants/theme";

/** Route guard — redirects based on auth state */
export default function Index() {
  const { token, role, isLoaded } = useAuthStore();
  const router = useRouter();

  useEffect(() => {
    if (!isLoaded) return;
    if (!token) {
      router.replace("/(auth)/landing");
    } else if (role === "admin") {
      router.replace("/(admin)");
    } else if (role === "kid") {
      router.replace("/(kid)");
    } else {
      router.replace("/(parent)");
    }
  }, [isLoaded, token, role]);

  return (
    <View style={{ flex: 1, justifyContent: "center", alignItems: "center", backgroundColor: colors.brand }}>
      <ActivityIndicator color="white" size="large" />
    </View>
  );
}
