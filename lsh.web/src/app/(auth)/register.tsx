import { track, useTrackView } from "../../utils/track";
import { readPendingAssessment } from "../../utils/pendingAssessment";
import { useState } from "react";
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView, Alert } from "react-native";
import { useLocalSearchParams, useRouter, Link } from "expo-router";
import { authApi } from "../../api/auth";
import { useAuthStore } from "../../store/authStore";
import { colors } from "../../constants/theme";

const LANGS = [
  { id: 1, label: "English 🇺🇸" },
  { id: 2, label: "中文 🏮" },
  { id: 3, label: "हिन्दी 🪔" },
  { id: 4, label: "Español 🌻" },
];

export default function RegisterScreen() {
  useTrackView("register_view");
  const router = useRouter();
  const { setAuth } = useAuthStore();
  const [email, setEmail]       = useState("");
  const [password, setPassword] = useState("");
  const [langId, setLangId]     = useState(1);
  const [role, setRole]         = useState<"parent" | "teacher">("parent");
  const [teacherName, setTeacherName]     = useState("");
  const [teacherSchool, setTeacherSchool] = useState("");
  // A shared invite arrives as /register?ref=CODE. Prefilling it means the
  // recipient never has to read a code off a message and retype it - the
  // step where most referrals are lost.
  const params = useLocalSearchParams<{ ref?: string }>();
  const [referralCode, setReferralCode]   = useState(
    typeof params.ref === "string" ? params.ref.toUpperCase() : "");
  const [loading, setLoading]   = useState(false);

  const submit = async () => {
    if (!email || password.length < 8) {
      Alert.alert("Please enter a valid email and password (8+ characters)");
      return;
    }
    if (role === "teacher" && !teacherName.trim()) {
      Alert.alert("Please enter your name for teacher registration");
      return;
    }
    setLoading(true);
    try {
      const data = await authApi.register(
        email.trim().toLowerCase(), password, langId, role,
        teacherName.trim() || undefined, teacherSchool.trim() || undefined,
        referralCode.trim() || undefined,
      ) as any;
      if (role === "teacher" && !data.is_approved) {
        Alert.alert(
          "Registration received",
          "Your teacher account is pending admin approval. We'll email you once it's approved.",
        );
        router.replace("/(auth)/login");
        return;
      }
      track("register_success", { meta: role });
      setAuth(data.token, { family_id: data.family_id }, data.role || role);
      if (role === "teacher") { router.replace("/(teacher)"); return; }
      // A parent who arrived from the public assessment still has no child, so
      // the plan they were just shown cannot be saved yet. Send them straight to
      // the add-child form (grade pre-filled) rather than an empty dashboard.
      router.replace(readPendingAssessment() ? "/(parent)/children" : "/(parent)");
    } catch (e: any) {
      Alert.alert("Registration failed", e.message);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView contentContainerStyle={s.root} keyboardShouldPersistTaps="handled">
      <View style={s.card}>
        <Text style={s.logo}>🌟</Text>
        <Text style={s.title}>Start free</Text>
        <Text style={s.sub}>14-day trial · no credit card needed</Text>

        <Text style={s.label}>I am a</Text>
        <View style={s.langs}>
          {(["parent", "teacher"] as const).map(r => (
            <TouchableOpacity key={r} style={[s.langBtn, role === r && s.langBtnActive]}
              onPress={() => setRole(r)}>
              <Text style={[s.langText, role === r && { color: "white" }]}>
                {r === "parent" ? "Parent" : "Teacher"}
              </Text>
            </TouchableOpacity>
          ))}
        </View>

        <TextInput style={s.input} placeholder="Email" value={email}
          onChangeText={setEmail} autoCapitalize="none" keyboardType="email-address" />
        <TextInput style={s.input} placeholder="Password (8+ chars)" value={password}
          onChangeText={setPassword} secureTextEntry />

        {role === "teacher" && (
          <>
            <TextInput style={s.input} placeholder="Your name" value={teacherName}
              onChangeText={setTeacherName} />
            <TextInput style={s.input} placeholder="School name (optional)" value={teacherSchool}
              onChangeText={setTeacherSchool} />
            <Text style={{ color: colors.textMuted, fontSize: 12, marginTop: -6, marginBottom: 14 }}>
              Teacher accounts require admin approval before you can create classrooms.
            </Text>
          </>
        )}

        <Text style={s.label}>Home language</Text>
        <View style={s.langs}>
          {LANGS.map(l => (
            <TouchableOpacity key={l.id} style={[s.langBtn, langId === l.id && s.langBtnActive]}
              onPress={() => setLangId(l.id)}>
              <Text style={[s.langText, langId === l.id && { color: "white" }]}>{l.label}</Text>
            </TouchableOpacity>
          ))}
        </View>

        <TextInput style={s.input} placeholder="Referral code (optional)" value={referralCode}
          onChangeText={setReferralCode} autoCapitalize="characters" />

        <TouchableOpacity style={[s.btn, loading && s.btnDim]} onPress={submit} disabled={loading}>
          <Text style={s.btnText}>{loading ? "Creating account…" : "Create my free account"}</Text>
        </TouchableOpacity>

        <Text style={{ textAlign: "center", color: colors.textMuted, fontSize: 12, marginTop: 12 }}>
          ✓ 14-day free trial ✓ 30-day money back ✓ Cancel anytime
        </Text>

        <Link href="/(auth)/login" style={s.link}>Already have an account? Sign in</Link>
      </View>
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:        { flex: 1, justifyContent: "center", padding: 24, backgroundColor: colors.brand },
  card:        { backgroundColor: "white", borderRadius: 20, padding: 28, shadowColor: "#000", shadowOpacity: 0.15, shadowRadius: 20, elevation: 8 },
  logo:        { fontSize: 48, textAlign: "center", marginBottom: 8 },
  title:       { fontSize: 24, fontWeight: "900", color: colors.text, textAlign: "center" },
  sub:         { fontSize: 14, color: colors.textMuted, textAlign: "center", marginBottom: 28 },
  label:       { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  input:       { borderWidth: 1.5, borderColor: colors.border, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 15, marginBottom: 14, color: colors.text },
  langs:       { flexDirection: "row", flexWrap: "wrap", gap: 8, marginBottom: 20 },
  langBtn:     { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8 },
  langBtnActive:{ backgroundColor: colors.brand, borderColor: colors.brand },
  langText:    { fontSize: 13, fontWeight: "600", color: colors.text },
  btn:         { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 16, alignItems: "center", marginTop: 4 },
  btnDim:      { opacity: 0.6 },
  btnText:     { color: "white", fontWeight: "800", fontSize: 16 },
  link:        { textAlign: "center", color: colors.brand, marginTop: 18, fontSize: 14, fontWeight: "600" },
});
