import { Redirect } from "expo-router";
import { Tabs } from "expo-router";
import { Text, Platform, View, ActivityIndicator } from "react-native";
import { useAuthStore } from "../../store/authStore";
import { colors } from "../../constants/theme";

export default function AdminLayout() {
  const { token, role, isLoaded } = useAuthStore();
  // Guards against redirecting to login before the stored session has
  // finished restoring — without this, a refresh can bounce a genuinely
  // logged-in user out before `token` is populated from storage.
  if (!isLoaded) {
    return (
      <View style={{ flex: 1, justifyContent: "center", alignItems: "center", backgroundColor: "#1a1a2e" }}>
        <ActivityIndicator color="white" size="large" />
      </View>
    );
  }
  if (!token) return <Redirect href="/(auth)/login" />;
  if (role !== "admin") return <Redirect href="/(parent)" />;

  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: colors.accent,
        tabBarInactiveTintColor: "rgba(255,255,255,0.4)",
        tabBarStyle: {
          borderTopWidth: 1,
          borderTopColor: "#2d2d4e",
          paddingBottom: Platform.OS === "ios" ? 20 : 8,
          paddingTop: 6,
          height: Platform.OS === "ios" ? 84 : 62,
          backgroundColor: "#1a1a2e",
        },
        tabBarLabelStyle: { fontSize: 11, fontWeight: "600" },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: "Dashboard",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>📊</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="content/worksheets"
        options={{
          title: "Worksheets",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>📋</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="content/stories"
        options={{
          title: "Stories",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>📖</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="users"
        options={{
          title: "Users",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>👥</Text>
          ),
        }}
      />
      <Tabs.Screen
        name="config"
        options={{
          title: "Config",
          tabBarIcon: ({ focused }) => (
            <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>⚙️</Text>
          ),
        }}
      />
      {/* Hidden screens */}
      <Tabs.Screen name="content/wisdom"    options={{ href: null }} />
      <Tabs.Screen name="content/questions" options={{ href: null }} />
      <Tabs.Screen name="content/featured"  options={{ href: null }} />
      <Tabs.Screen name="content/theme-weeks" options={{ href: null }} />
      <Tabs.Screen name="content/weekly-packets" options={{ href: null }} />
    </Tabs>
  );
}
