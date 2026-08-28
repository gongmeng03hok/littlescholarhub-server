import { useState } from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView, Alert } from "react-native";
import { useRouter, useLocalSearchParams, Link } from "expo-router";
import { authApi } from "../../api/auth";
import { colors } from "../../constants/theme";

export default function ResetPasswordScreen() {
  const router = useRouter();
  const { token } = useLocalSearchParams<{ token: string }>();
  const [password, setPassword]   = useState("");
  const [confirm, setConfirm]     = useState("");
  const [loading, setLoading]     = useState(false);
  const [done, setDone]           = useState(false);

  const submit = async () => {
    if (!token) { Alert.alert("Missing reset link", "Please use the link from your email."); return; }
    if (password.length < 8) { Alert.alert("Password too short", "Use at least 8 characters."); return; }
    if (password !== confirm) { Alert.alert("Passwords don't match"); return; }

    setLoading(true);
    try {
      await authApi.resetPassword(token, password);
      setDone(true);
    } catch (e: any) {
      Alert.alert("Couldn't reset password", e.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView contentContainerStyle={s.root} keyboardShouldPersistTaps="handled">
      <View style={s.card}>
        <Text style={s.logo}>🔑</Text>
        <Text style={s.title}>{done ? "Password updated!" : "Set a new password"}</Text>

        {!token && !done && (
          <Text style={s.warn}>
            This page needs a reset link — open the link from your email, or request a new one.
          </Text>
        )}

        {done ? (
          <>
            <Text style={s.sub}>You can now sign in with your new password.</Text>
            <TouchableOpacity style={s.btn} onPress={() => router.replace("/(auth)/login")}>
              <Text style={s.btnText}>Go to sign in</Text>
            </TouchableOpacity>
          </>
        ) : (
          <>
            <TextInput style={s.input} placeholder="New password" value={password}
              onChangeText={setPassword} secureTextEntry editable={!!token} />
            <TextInput style={s.input} placeholder="Confirm new password" value={confirm}
              onChangeText={setConfirm} secureTextEntry editable={!!token} />
            <TouchableOpacity
              style={[s.btn, (loading || !token) && s.btnDim]}
              onPress={submit}
              disabled={loading || !token}
            >
              <Text style={s.btnText}>{loading ? "Saving…" : "Reset password"}</Text>
            </TouchableOpacity>
          </>
        )}

        <Link href="/(auth)/forgot-password" style={s.link}>
          Request a new reset link
        </Link>
        <Link href="/(auth)/login" style={s.link}>
          ← Back to sign in
        </Link>
      </View>
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, justifyContent: "center", padding: 24, backgroundColor: colors.brand },
  card:   { backgroundColor: "white", borderRadius: 20, padding: 28, shadowColor: "#000", shadowOpacity: 0.15, shadowRadius: 20, elevation: 8 },
  logo:   { fontSize: 48, textAlign: "center", marginBottom: 8 },
  title:  { fontSize: 22, fontWeight: "900", color: colors.text, textAlign: "center", marginBottom: 10 },
  sub:    { fontSize: 14, color: colors.textMuted, textAlign: "center", marginBottom: 22, lineHeight: 20 },
  warn:   { fontSize: 13, color: "#dc2626", textAlign: "center", backgroundColor: "#fee2e2",
            borderRadius: 10, padding: 12, marginBottom: 18, lineHeight: 19 },
  input:  { borderWidth: 1.5, borderColor: colors.border, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 15, marginBottom: 14, color: colors.text },
  btn:    { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 16, alignItems: "center", marginTop: 4 },
  btnDim: { opacity: 0.6 },
  btnText:{ color: "white", fontWeight: "800", fontSize: 16 },
  link:   { textAlign: "center", color: colors.brand, marginTop: 18, fontSize: 15, fontWeight: "600" },
});
