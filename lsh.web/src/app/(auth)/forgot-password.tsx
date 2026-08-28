import { useState } from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView, Alert } from "react-native";
import { useRouter, Link } from "expo-router";
import { authApi } from "../../api/auth";
import { colors } from "../../constants/theme";

export default function ForgotPasswordScreen() {
  const router = useRouter();
  const [email, setEmail]     = useState("");
  const [loading, setLoading] = useState(false);
  const [sent, setSent]       = useState(false);

  const submit = async () => {
    if (!email.trim()) { Alert.alert("Please enter your email address"); return; }
    setLoading(true);
    try {
      await authApi.forgotPassword(email.trim().toLowerCase());
      setSent(true);
    } catch (e: any) {
      // The API always responds success for privacy — this only fires on a
      // genuine network/server error, so it's safe to surface directly.
      Alert.alert("Something went wrong", e.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView contentContainerStyle={s.root} keyboardShouldPersistTaps="handled">
      <View style={s.card}>
        <Text style={s.logo}>🔑</Text>
        <Text style={s.title}>Forgot your email or password?</Text>

        {sent ? (
          <>
            <Text style={s.sub}>
              If that email is registered, we've sent a link to reset your password.
              Check your inbox (and spam folder).
            </Text>
            <Text style={s.hint}>
              Your login is always the email address you signed up with — there's no
              separate username to remember.
            </Text>
          </>
        ) : (
          <>
            <Text style={s.sub}>
              Enter the email you signed up with and we'll send you a link to reset your password.
            </Text>
            <TextInput style={s.input} placeholder="Email" value={email}
              onChangeText={setEmail} autoCapitalize="none" keyboardType="email-address" />
            <TouchableOpacity style={[s.btn, loading && s.btnDim]} onPress={submit} disabled={loading}>
              <Text style={s.btnText}>{loading ? "Sending…" : "Send reset link"}</Text>
            </TouchableOpacity>
          </>
        )}

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
  title:  { fontSize: 22, fontWeight: "900", color: colors.text, textAlign: "center" },
  sub:    { fontSize: 14, color: colors.textMuted, textAlign: "center", marginTop: 10, marginBottom: 22, lineHeight: 20 },
  hint:   { fontSize: 13, color: colors.textMuted, textAlign: "center", backgroundColor: colors.brandLight,
            borderRadius: 10, padding: 12, lineHeight: 19 },
  input:  { borderWidth: 1.5, borderColor: colors.border, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 15, marginBottom: 14, color: colors.text },
  btn:    { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 16, alignItems: "center", marginTop: 4 },
  btnDim: { opacity: 0.6 },
  btnText:{ color: "white", fontWeight: "800", fontSize: 16 },
  link:   { textAlign: "center", color: colors.brand, marginTop: 22, fontSize: 15, fontWeight: "600" },
});
