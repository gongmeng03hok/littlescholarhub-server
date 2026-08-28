import { useState } from "react";
import { View, Text, TouchableOpacity, StyleSheet, FlatList, TextInput, Alert, ActivityIndicator } from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { useAuthStore } from "../../store/authStore";
import { useChildren } from "../../hooks/useChildren";
import { authApi } from "../../api/auth";
import { colors } from "../../constants/theme";

const AVATARS = ["🐉","🦋","🦁","🐼","🦄","🐬","🦊","🌟","🚀","🎨"];

export default function KidSelectScreen() {
  const router = useRouter();
  const { children, setActiveChild } = useChildStore();
  const { isLoading: loadingChildren } = useChildren();
  const { setAuth, token, family } = useAuthStore();
  const [selected, setSelected]   = useState<number | null>(null);
  const [pin, setPin]             = useState("");
  const [pinRequired, setPinRequired] = useState(false);
  const [loading, setLoading]     = useState(false);

  const pick = async (childId: number, requirePin = false) => {
    if (requirePin && !pin) {
      setSelected(childId);
      setPinRequired(true);
      return;
    }
    setLoading(true);
    try {
      const data = await authApi.kidLogin(childId, pin || undefined) as any;
      setAuth(data.token, family, "kid", data.kid_id);
      const child = children.find(c => c.child_id === childId);
      if (child) setActiveChild(child);
      router.replace("/(kid)");
    } catch (e: any) {
      if (e.message?.includes("PIN required")) {
        setSelected(childId);
        setPinRequired(true);
      } else {
        Alert.alert("Error", e.message);
      }
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={s.root}>
      <Text style={s.title}>Who's learning today? 🌟</Text>
      {loadingChildren ? (
        <ActivityIndicator color={colors.brand} size="large" style={{ marginTop: 48 }} />
      ) : children.length === 0 ? (
        <View style={{ padding: 32, alignItems: "center" }}>
          <Text style={{ color: colors.textMuted, textAlign: "center", marginBottom: 12 }}>
            No child profiles yet. Add one from your parent dashboard first.
          </Text>
          <TouchableOpacity onPress={() => router.replace("/(parent)/children")}>
            <Text style={{ color: colors.brand, fontWeight: "700" }}>Go to Children →</Text>
          </TouchableOpacity>
        </View>
      ) : (
      <FlatList
        data={children}
        numColumns={2}
        keyExtractor={item => String(item.child_id)}
        contentContainerStyle={{ gap: 16, padding: 24 }}
        columnWrapperStyle={{ gap: 16 }}
        renderItem={({ item, index }) => (
          <TouchableOpacity
            style={[s.card, selected === item.child_id && s.cardActive]}
            onPress={() => pick(item.child_id)}
            activeOpacity={0.8}
          >
            <Text style={s.avatar}>{AVATARS[index % AVATARS.length]}</Text>
            <Text style={s.name}>{item.nickname}</Text>
            <Text style={s.grade}>{item.grade_label}</Text>
          </TouchableOpacity>
        )}
      />
      )}

      {pinRequired && selected && (
        <View style={s.pinOverlay}>
          <View style={s.pinCard}>
            <Text style={s.pinTitle}>Enter PIN 🔐</Text>
            <TextInput style={s.pinInput} placeholder="4-digit PIN"
              value={pin} onChangeText={setPin}
              keyboardType="number-pad" maxLength={4} secureTextEntry />
            <TouchableOpacity style={s.pinBtn} onPress={() => pick(selected, true)} disabled={loading}>
              <Text style={s.pinBtnText}>{loading ? "Checking…" : "Go!"}</Text>
            </TouchableOpacity>
            <TouchableOpacity onPress={() => { setPinRequired(false); setPin(""); setSelected(null); }}>
              <Text style={{ textAlign: "center", color: colors.textMuted, marginTop: 12 }}>Cancel</Text>
            </TouchableOpacity>
          </View>
        </View>
      )}

      <TouchableOpacity style={s.parentBtn} onPress={() => router.replace("/(parent)")}>
        <Text style={s.parentBtnText}>← Parent view</Text>
      </TouchableOpacity>
    </View>
  );
}

const s = StyleSheet.create({
  root:       { flex: 1, backgroundColor: colors.brandLight },
  title:      { fontSize: 24, fontWeight: "900", color: colors.brand, textAlign: "center", marginTop: 48 },
  card:       { flex: 1, backgroundColor: "white", borderRadius: 20, padding: 24, alignItems: "center",
                shadowColor: "#000", shadowOpacity: 0.08, shadowRadius: 10, elevation: 3 },
  cardActive: { borderWidth: 3, borderColor: colors.brand },
  avatar:     { fontSize: 48, marginBottom: 8 },
  name:       { fontSize: 18, fontWeight: "800", color: colors.text },
  grade:      { fontSize: 13, color: colors.textMuted },
  pinOverlay: { ...StyleSheet.absoluteFillObject, backgroundColor: "rgba(0,0,0,0.5)", justifyContent: "center", padding: 32 },
  pinCard:    { backgroundColor: "white", borderRadius: 20, padding: 28 },
  pinTitle:   { fontSize: 20, fontWeight: "800", textAlign: "center", marginBottom: 16, color: colors.text },
  pinInput:   { borderWidth: 2, borderColor: colors.brand, borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14, fontSize: 24, textAlign: "center", letterSpacing: 8, marginBottom: 16 },
  pinBtn:     { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 14, alignItems: "center" },
  pinBtnText: { color: "white", fontWeight: "800", fontSize: 17 },
  parentBtn:  { margin: 24, padding: 14, alignItems: "center" },
  parentBtnText:{ color: colors.brand, fontSize: 15, fontWeight: "700" },
});
