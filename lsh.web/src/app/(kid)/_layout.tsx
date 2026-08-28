import { Redirect } from "expo-router";
import { Tabs } from "expo-router";
import { Text, Platform, View, ActivityIndicator } from "react-native";
import { useAuthStore } from "../../store/authStore";
import { colors } from "../../constants/theme";

export default function KidLayout() {
  const { token, role, isLoaded } = useAuthStore();
  // Guards against redirecting to login before the stored session has
  // finished restoring — without this, a refresh can bounce a genuinely
  // logged-in user out before `token` is populated from storage.
  if (!isLoaded) {
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center", backgroundColor: colors.brand }}>
        <ActivityIndicator color="white" size="large" />
      </View>
    );
  }
  if (!token) return <Redirect href="/(auth)/login" />;
  if (role !== "kid") return <Redirect href="/(parent)" />;

  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: colors.brand,
        tabBarInactiveTintColor: colors.textMuted,
        tabBarStyle: {
          borderTopWidth: 1,
          borderTopColor: colors.border,
          paddingBottom: Platform.OS === "ios" ? 20 : 8,
          paddingTop: 8,
          height: Platform.OS === "ios" ? 84 : 64,
        },
        tabBarLabelStyle: { fontSize: 13, fontWeight: "700" },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: "Home",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 28 : 24, opacity: focused ? 1 : 0.5 }}>🏠</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="story"
        options={{
          title: "Story",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 28 : 24, opacity: focused ? 1 : 0.5 }}>📖</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="rewards"
        options={{
          title: "Rewards",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 28 : 24, opacity: focused ? 1 : 0.5 }}>🎁</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="assignments"
        options={{ href: null }}
      />
      <Tabs.Screen
        name="practice/[subject]"
        options={{ href: null }}
      />
      <Tabs.Screen
        name="leaderboard"
        options={{ href: null }}
      />
      <Tabs.Screen
        name="customize"
        options={{ href: null }}
      />
    </Tabs>
  );
}
