/**
 * Community — weekly teacher office hours (RSVP) + language-specific parent groups.
 * Content (schedule, group listings) comes from AppConfig; RSVPs are tracked per family.
 */
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, ActivityIndicator, Platform, Linking, Alert,
} from "react-native";
import { useRouter } from "expo-router";
import { useConfig } from "../../hooks/useConfig";
import { communityApi } from "../../api/community";
import { colors } from "../../constants/theme";

export default function CommunityScreen() {
  const router = useRouter();
  const qc = useQueryClient();
  const { data: config } = useConfig();

  const sessionLabel = config?.["community.officehours_next"] ?? "this week";

  const { data: rsvpStatus, isLoading } = useQuery({
    queryKey: ["officeHoursRsvp", sessionLabel],
    queryFn:  () => communityApi.getRsvp(sessionLabel),
    staleTime: 30_000,
  });

  const { mutate: rsvp, isPending: rsvping } = useMutation({
    mutationFn: () => communityApi.rsvp(sessionLabel),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["officeHoursRsvp", sessionLabel] }),
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const groups: any[] = config?.["community.groups"] ?? [];
  const discordUrl = config?.["community.discord_url"];

  return (
    <View style={s.root}>
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
          <Text style={s.backBtn}>← </Text>
        </TouchableOpacity>
        <Text style={s.title}>💬 Community</Text>
      </View>

      <ScrollView contentContainerStyle={s.body} showsVerticalScrollIndicator={false}>
        {/* Office hours */}
        <View style={s.card}>
          <Text style={s.liveTag}>LIVE THIS WEEK</Text>
          <Text style={s.cardTitle}>Weekly teacher office hours</Text>
          <Text style={s.ohMeta}>
            {config?.["community.officehours_day"] ?? "Wednesday"} · {config?.["community.officehours_time"] ?? "7:00 pm PT"}
          </Text>
          <Text style={s.ohHost}>Host: {config?.["community.officehours_host"] ?? "Our credentialed teacher"}</Text>
          {!!config?.["community.officehours_topic"] && (
            <Text style={s.ohTopic}>This week: {config["community.officehours_topic"]}</Text>
          )}

          {isLoading ? (
            <ActivityIndicator color={colors.brand} style={{ marginTop: 14 }} />
          ) : rsvpStatus?.rsvped ? (
            <View style={s.rsvpedBadge}>
              <Text style={s.rsvpedText}>✓ You're RSVP'd for {sessionLabel}</Text>
            </View>
          ) : (
            <TouchableOpacity style={[s.rsvpBtn, rsvping && s.btnDim]} onPress={() => rsvp()} disabled={rsvping}>
              <Text style={s.rsvpBtnText}>{rsvping ? "Saving…" : "RSVP for this week"}</Text>
            </TouchableOpacity>
          )}
        </View>

        {/* Parent groups */}
        <Text style={s.sectionTitle}>Parent community, by language</Text>
        <Text style={s.sectionSub}>Small, moderated, ad-free. No cold takes, no judgment — just parents in the same boat.</Text>

        {groups.map((g: any) => (
          <View key={g.label} style={s.groupCard}>
            <Text style={s.groupFlag}>{g.flag}</Text>
            <View style={{ flex: 1 }}>
              <Text style={s.groupLabel}>{g.label}</Text>
              <Text style={s.groupMeta}>{g.platform} · {g.members} members</Text>
            </View>
            {g.platform === "Discord" && discordUrl && discordUrl !== "#" ? (
              <TouchableOpacity style={s.joinBtn} onPress={() => Linking.openURL(discordUrl)}>
                <Text style={s.joinBtnText}>Join</Text>
              </TouchableOpacity>
            ) : (
              <Text style={s.askText}>Ask in office hours →</Text>
            )}
          </View>
        ))}

        <View style={{ height: 40 }} />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20, flexDirection: "row", alignItems: "center",
            borderBottomWidth: 1, borderBottomColor: colors.border },
  backBtn:{ fontSize: 20, fontWeight: "700", color: colors.brand, marginRight: 4 },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },

  body: { padding: 20, gap: 4 },

  card: { backgroundColor: "white", borderRadius: 16, padding: 20, marginBottom: 24,
          shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 10, elevation: 2 },
  liveTag:  { fontSize: 11, fontWeight: "800", color: colors.brand, letterSpacing: 1, marginBottom: 8 },
  cardTitle:{ fontSize: 18, fontWeight: "900", color: colors.text, marginBottom: 6 },
  ohMeta:   { fontSize: 14, fontWeight: "700", color: colors.text, marginBottom: 4 },
  ohHost:   { fontSize: 13, color: colors.textMuted, marginBottom: 4 },
  ohTopic:  { fontSize: 13, color: colors.textMuted, fontStyle: "italic", marginBottom: 8 },

  rsvpBtn:    { backgroundColor: colors.brand, borderRadius: 12, paddingVertical: 14,
                alignItems: "center", marginTop: 10 },
  btnDim:     { opacity: 0.6 },
  rsvpBtnText:{ color: "white", fontWeight: "800", fontSize: 14 },
  rsvpedBadge:{ backgroundColor: colors.brandLight, borderRadius: 12, paddingVertical: 12,
                alignItems: "center", marginTop: 10 },
  rsvpedText: { color: colors.brand, fontWeight: "800", fontSize: 14 },

  sectionTitle:{ fontSize: 16, fontWeight: "900", color: colors.text, marginBottom: 4 },
  sectionSub:  { fontSize: 13, color: colors.textMuted, marginBottom: 14, lineHeight: 19 },

  groupCard: { flexDirection: "row", alignItems: "center", backgroundColor: "white",
               borderRadius: 14, padding: 14, marginBottom: 10,
               shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 4, elevation: 1 },
  groupFlag: { fontSize: 26, marginRight: 12 },
  groupLabel:{ fontSize: 14, fontWeight: "700", color: colors.text },
  groupMeta: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  joinBtn:     { backgroundColor: colors.brandLight, borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8 },
  joinBtnText: { color: colors.brand, fontWeight: "800", fontSize: 13 },
  askText:     { fontSize: 12, color: colors.textMuted, fontWeight: "600", maxWidth: 90, textAlign: "right" },
});
