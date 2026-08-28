import { useEffect } from "react";
import { View, ActivityIndicator, StatusBar } from "react-native";
import { Stack, Redirect } from "expo-router";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import {
  useFonts,
  Nunito_400Regular,
  Nunito_600SemiBold,
  Nunito_700Bold,
  Nunito_800ExtraBold,
  Nunito_900Black,
} from "@expo-google-fonts/nunito";
import { useAuthStore } from "../store/authStore";
import { colors } from "../constants/theme";
import { ImpersonationBanner } from "../components/ImpersonationBanner";

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 1,
      staleTime: 2 * 60 * 1000,
    },
  },
});

export default function RootLayout() {
  const { token, role, isLoaded, loadFromStorage } = useAuthStore();

  const [fontsLoaded] = useFonts({
    Nunito_400Regular,
    Nunito_600SemiBold,
    Nunito_700Bold,
    Nunito_800ExtraBold,
    Nunito_900Black,
  });

  useEffect(() => {
    loadFromStorage();
  }, []);

  // Show branded splash while fonts load and auth state restores
  if (!fontsLoaded || !isLoaded) {
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center", backgroundColor: colors.brand }}>
        <StatusBar barStyle="light-content" backgroundColor={colors.brand} />
        <ActivityIndicator color="white" size="large" />
      </View>
    );
  }

  return (
    <QueryClientProvider client={queryClient}>
      <GestureHandlerRootView style={{ flex: 1 }}>
        <StatusBar barStyle="dark-content" backgroundColor="#fff" />
        <ImpersonationBanner />
        <Stack screenOptions={{ headerShown: false, animation: "fade" }}>
          <Stack.Screen name="index"    />
          <Stack.Screen name="(auth)"   />
          <Stack.Screen name="(parent)" />
          <Stack.Screen name="(kid)"    />
          <Stack.Screen name="(admin)"  />
          <Stack.Screen name="(teacher)"/>
        </Stack>
      </GestureHandlerRootView>
    </QueryClientProvider>
  );
}
