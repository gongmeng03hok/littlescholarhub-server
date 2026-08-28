import { useState } from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView, Alert } from "react-native";
import { useRouter, Link } from "expo-router";
import { authApi } from "../../api/auth";
import { useAuthStore } from "../../store/authStore";
import { colors } from "../../constants/theme";

export default function LoginScreen() {
  const router = useRouter();
  const { setAuth } = useAuthStore();
  const [email, setEmail]       = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading]   = useState(false);

  const submit = async () => {
    if (!email || !password) { Alert.alert("Please fill in all fields"); return; }
    setLoading(true);
    try {
      const data = await authApi.login(email.trim().toLowerCase(), password) as any;
      // Fetch /me to get full family object
      const { authApi: a2 } = await import("../../api/auth");
      setAuth(data.token, { family_id: data.family_id }, data.role);
      if (data.role === "admin")  router.replace("/(admin)");
      else                        router.replace("/(parent)");
    } catch (e: any) {
      Alert.alert("Login failed", e.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView contentContainerStyle={s.root} keyboardShouldPersistTaps="handled">
      <View style={s.card}>
        <Text style={s.logo}>🌟</Text>
        <Text style={s.title}>Welcome back</Text>
        <Text style={s.sub}>Little Scholars Hub</Text>

        <TextInput style={s.input} placeholder="Email" value={email}
          onChangeText={setEmail} autoCapitalize="none" keyboardType="email-address" />
        <TextInput style={s.input} placeholder="Password" value={password}
          onChangeText={setPassword} secureTextEntry />

        <Link href="/(auth)/forgot-password" style={s.forgotLink}>
          Forgot your email or password?
        </Link>

        <TouchableOpacity style={[s.btn, loading && s.btnDim]} onPress={submit} disabled={loading}>
          <Text style={s.btnText}>{loading ? "Signing in…" : "Sign in"}</Text>
        </TouchableOpacity>

        <Link href="/(auth)/register" style={s.link}>
          No account? Start free →
        </Link>
      </View>
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, justifyContent: "center", padding: 24, backgroundColor: colors.brand },
  card:   { backgroundColor: "white", borderRadius: 20, padding: 28, shadowColor: "#000", shadowOpacity: 0.15, shadowRadius: 20, elevation: 8 },
  logo:   { fontSize: 48, textAlign: "center", marginBottom: 8 },
  title:  { fontSize: 24, fontWeight: "900", color: colors.text, textAlign: "center" },
  sub:    { fontSize: 14, color: colors.textMuted, textAlign: "center", marginBottom: 28 },
  input:  { borderWidth: 1.5, borderColor: colors.border, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 15, marginBottom: 14, color: colors.text },
  forgotLink: { textAlign: "right", color: colors.textMuted, fontSize: 13, fontWeight: "600", marginBottom: 18, marginTop: -6 },
  btn:    { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 16, alignItems: "center", marginTop: 4 },
  btnDim: { opacity: 0.6 },
  btnText:{ color: "white", fontWeight: "800", fontSize: 16 },
  link:   { textAlign: "center", color: colors.brand, marginTop: 18, fontSize: 15, fontWeight: "600" },
});
