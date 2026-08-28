import { Redirect } from "expo-router";
import { Tabs } from "expo-router";
import { Text, Platform, View, ActivityIndicator } from "react-native";
import { useAuthStore } from "../../store/authStore";
import { colors } from "../../constants/theme";

function TabIcon({ emoji, label, focused }: { emoji: string; label: string; focused: boolean }) {
  return (
    <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>
      {emoji}
    </Text>
  );
}

export default function ParentLayout() {
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
  if (role === "admin")   return <Redirect href="/(admin)" />;
  if (role === "kid")     return <Redirect href="/(kid)" />;
  if (role === "teacher") return <Redirect href="/(teacher)" />;

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
        tabBarLabelStyle: { fontSize: 11, fontWeight: "600", marginTop: 2 },
      }}
    >
      <Tabs.Screen
        name="index"
        options={{
          title: "Home",
          tabBarIcon: ({ focused }) => <TabIcon emoji="🏠" label="Home" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="content"
        options={{
          title: "Worksheets",
          tabBarIcon: ({ focused }) => <TabIcon emoji="📋" label="Worksheets" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="story"
        options={{
          title: "Story",
          tabBarIcon: ({ focused }) => <TabIcon emoji="📖" label="Story" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="progress"
        options={{
          title: "Progress",
          tabBarIcon: ({ focused }) => <TabIcon emoji="📈" label="Progress" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="settings"
        options={{
          title: "Family",
          tabBarIcon: ({ focused }) => <TabIcon emoji="👨‍👩‍👧" label="Family" focused={focused} />,
        }}
      />
      {/* Hidden tabs — accessible via navigation, not tab bar */}
      <Tabs.Screen name="weekly-packets"      options={{ href: null }} />
      <Tabs.Screen name="practice/[subject]" options={{ href: null }} />
      <Tabs.Screen name="assessment"         options={{ href: null }} />
      <Tabs.Screen name="plan"               options={{ href: null }} />
      <Tabs.Screen name="math"               options={{ href: null }} />
      <Tabs.Screen name="children"           options={{ href: null }} />
      <Tabs.Screen name="assignments"        options={{ href: null }} />
      <Tabs.Screen name="rewards"            options={{ href: null }} />
      <Tabs.Screen name="homework"           options={{ href: null }} />
      <Tabs.Screen name="community"          options={{ href: null }} />
      <Tabs.Screen name="storypacks"         options={{ href: null }} />
    </Tabs>
  );
}
