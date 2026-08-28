import { Redirect } from "expo-router";
import { Tabs } from "expo-router";
import { View, Text, Platform, StyleSheet, ActivityIndicator } from "react-native";
import { useAuthStore } from "../../store/authStore";
import { colors } from "../../constants/theme";

function TabIcon({ emoji, focused }: { emoji: string; focused: boolean }) {
  return (
    <Text style={{ fontSize: focused ? 22 : 20, opacity: focused ? 1 : 0.5 }}>
      {emoji}
    </Text>
  );
}

export default function TeacherLayout() {
  const { token, role, isApproved, isLoaded } = useAuthStore();
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
  if (role === "admin")  return <Redirect href="/(admin)" />;
  if (role === "kid")    return <Redirect href="/(kid)" />;
  if (role === "parent") return <Redirect href="/(parent)" />;

  if (!isApproved) {
    return (
      <View style={s.pendingRoot}>
        <Text style={s.pendingEmoji}>🎓</Text>
        <Text style={s.pendingTitle}>Your teacher account is pending approval</Text>
        <Text style={s.pendingBody}>
          An admin needs to approve your registration before you can create classrooms.
          We'll email you once you're approved.
        </Text>
      </View>
    );
  }

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
          title: "Classrooms",
          tabBarIcon: ({ focused }) => <TabIcon emoji="🏫" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="assignments"
        options={{
          title: "Assignments",
          tabBarIcon: ({ focused }) => <TabIcon emoji="📝" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="students"
        options={{
          title: "Students",
          tabBarIcon: ({ focused }) => <TabIcon emoji="🎓" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="gradebook"
        options={{
          title: "Gradebook",
          tabBarIcon: ({ focused }) => <TabIcon emoji="📊" focused={focused} />,
        }}
      />
      <Tabs.Screen
        name="weekly-packets"
        options={{
          title: "Weekly Packets",
          tabBarIcon: ({ focused }) => <TabIcon emoji="📅" focused={focused} />,
        }}
      />
      {/* Hidden — accessible via navigation, not tab bar */}
      <Tabs.Screen name="students/[childId]" options={{ href: null }} />
    </Tabs>
  );
}

const s = StyleSheet.create({
  pendingRoot:  { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, backgroundColor: "#fff" },
  pendingEmoji: { fontSize: 56, marginBottom: 16 },
  pendingTitle: { fontSize: 18, fontWeight: "800", color: colors.text, textAlign: "center", marginBottom: 8 },
  pendingBody:  { fontSize: 14, color: colors.textMuted, textAlign: "center", lineHeight: 20 },
});
