/**
 * Kid Dashboard — simplified, large-touch UI.
 * Personalized picks from the weekly plan, all 9 subjects, all 3 culture
 * tracks, streak, badges, and today's story CTA.
 */
import { useEffect, useState } from "react";
import { useQuery } from "@tanstack/react-query";
import {
  ScrollView, View, Text, TouchableOpacity,
  StyleSheet, Platform, RefreshControl, Image,
} from "react-native";
import { useRouter } from "expo-router";
import { useAuthStore }  from "../../store/authStore";
import { useChildStore } from "../../store/childStore";
import { useProgress, useTodayStory, useBadges, useAssignments } from "../../hooks/useApi";
import { gamificationApi, GameProfile, CheckinResult } from "../../api/gamification";
import { LevelBar } from "../../components/LevelBar";
import { DailyRewardModal } from "../../components/DailyRewardModal";
import { TreasureChest } from "../../components/TreasureChest";
import { avatarEmoji, avatarImage } from "../../constants/avatars";
import { assessmentApi } from "../../api/assessment";
import { colors, SUBJECT_META, CULTURAL_TRACKS } from "../../constants/theme";

// Default picks shown until a personalised weekly plan exists
const DEFAULT_SUBJECTS = ["math", "phonics", "story"];

// A kid-plan subject key doesn't always match our real subject catalog slug
const PLAN_SLUG_ALIAS: Record<string, string> = {
  emotions: "feelings",
  writing:  "phonics",
};
const CORE_SUBJECTS = ["math", "phonics", "reading", "art", "story", "workbooks", "logic", "feelings", "manners"];

export default function KidDashboard() {
  const router  = useRouter();
  const { logout } = useAuthStore();
  const { activeChild } = useChildStore();

  const grade   = activeChild?.grade_id ?? 2;
  const childId = activeChild?.child_id;
  const name    = activeChild?.nickname ?? "Scholar";

  const { data: prog, refetch, isRefetching } = useProgress(childId);
  const { data: story } = useTodayStory(grade);
  const { data: badges = [] } = useBadges(childId);
  const { data: assignments = [] } = useAssignments(childId);
  const pendingAssignments = (assignments as any[]).filter(a => !a.completed_at);

  const { data: plan } = useQuery({
    queryKey: ["plan", childId],
    queryFn:  () => assessmentApi.getPlan(childId!),
    enabled:  !!childId,
    staleTime: 15 * 60 * 1000,
    retry: false,
  });

  const streak     = prog?.streak?.current_streak ?? 0;
  const weeklyMins = prog?.weekly?.mins ?? 0;
  // Gamification: daily check-in reward + XP/level bar
  const [game, setGame]     = useState<GameProfile | null>(null);
  const [reward, setReward] = useState<CheckinResult | null>(null);
  useEffect(() => {
    if (!childId) return;
    let alive = true;
    (async () => {
      try { const r = await gamificationApi.checkin(childId); if (alive && r?.claimed) setReward(r); } catch {}
      try { const p = await gamificationApi.profile(childId); if (alive) setGame(p); } catch {}
    })();
    return () => { alive = false; };
  }, [childId]);
  // Personalised top picks from the weekly plan, mapped onto real subject slugs
  const planJson = plan?.plan_json;
  const planSubjects: string[] = Array.isArray(planJson?.subjects)
    ? planJson.subjects
        .map((s: any) => PLAN_SLUG_ALIAS[s.key] ?? s.key)
        .filter((slug: string) => !!SUBJECT_META[slug])
    : [];
  const uniquePlanSubjects = Array.from(new Set(planSubjects));
  const topPicks = (uniquePlanSubjects.length > 0 ? uniquePlanSubjects : DEFAULT_SUBJECTS).slice(0, 4);

  const hour = new Date().getHours();
  const greeting = hour < 12 ? "Good morning" : hour < 17 ? "Good afternoon" : "Good evening";

  const goPractice = (slug: string) => router.push({
    pathname: "/(kid)/practice/[subject]",
    params: { subject: slug, grade },
  });

  return (
    <ScrollView
      style={s.root}
      contentContainerStyle={s.content}
      showsVerticalScrollIndicator={false}
      refreshControl={<RefreshControl refreshing={isRefetching} onRefresh={refetch} tintColor={colors.brand} />}
    >
      {/* Big greeting header */}
      <View style={s.header}>
        <Text style={s.wave}>👋</Text>
        <Text style={s.greeting}>{greeting},</Text>
        <Text style={s.name}>{name}!</Text>
      </View>

      {/* Streak + minutes */}
      <View style={s.statsRow}>
        <View style={s.statBadge}>
          <Text style={s.statEmoji}>🔥</Text>
          <Text style={s.statNum}>{streak}</Text>
          <Text style={s.statLabel}>day streak</Text>
        </View>
        <View style={s.statBadge}>
          <Text style={s.statEmoji}>⏱️</Text>
          <Text style={s.statNum}>{weeklyMins}</Text>
          <Text style={s.statLabel}>min this week</Text>
        </View>
      </View>
       {/* XP / level progress */}
      {game && (
        <LevelBar
          level={game.level}
          xpIntoLevel={game.xp_into_level}
          xpForNext={game.xp_for_next}
          coins={game.coins}
        />
      )}

      {/* Treasure chest — gems & stars */}
      {game && (
        <TreasureChest gems={game.gems} stars={game.stars} chestStyle={game.chest_style} />
      )}

      {/* Customize buddy & chest */}
      <TouchableOpacity
        style={s.leaderBtn}
        onPress={() => router.push("/(kid)/customize")}
        activeOpacity={0.88}
      >
        {game && avatarImage(game.avatar_slug)
          ? <Image source={avatarImage(game.avatar_slug)} style={s.leaderAvatarImg} resizeMode="contain" />
          : <Text style={s.leaderEmoji}>{game ? avatarEmoji(game.avatar_slug) : "✨"}</Text>}
        <Text style={s.leaderText}>Customize my buddy &amp; chest</Text>
        <Text style={s.leaderArrow}>→</Text>
      </TouchableOpacity>

      {/* Pending assignment reminder */}
      {pendingAssignments.length > 0 && (
        <TouchableOpacity
          style={s.reminderBtn}
          onPress={() => router.push("/(kid)/assignments")}
          activeOpacity={0.88}
        >
          <Text style={s.reminderEmoji}>⏰</Text>
          <Text style={s.reminderText}>
            {pendingAssignments.length} thing{pendingAssignments.length > 1 ? "s" : ""} to finish!
          </Text>
          <Text style={s.reminderArrow}>→</Text>
        </TouchableOpacity>
      )}

      {/* Leaderboard entry */}
      <TouchableOpacity
        style={s.leaderBtn}
        onPress={() => router.push("/(kid)/leaderboard")}
        activeOpacity={0.88}
      >
        <Text style={s.leaderEmoji}>🏆</Text>
        <Text style={s.leaderText}>See the Leaderboard</Text>
        <Text style={s.leaderArrow}>→</Text>
      </TouchableOpacity>

      {/* Personalised top picks from the weekly plan */}
      <Text style={s.sectionTitle}>What do you want to do?</Text>
      <View style={s.subjectGrid}>
        {topPicks.map((slug: string) => {
          const meta = SUBJECT_META[slug];
          return (
            <TouchableOpacity
              key={slug}
              style={[s.subjectBtn, { backgroundColor: meta.color }]}
              onPress={() => goPractice(slug)}
              activeOpacity={0.85}
            >
              <Text style={s.subjectEmoji}>{meta.icon}</Text>
              <Text style={s.subjectLabel}>{meta.label}</Text>
            </TouchableOpacity>
          );
        })}
      </View>

      {/* Badges */}
      {badges.length > 0 && (
        <>
          <Text style={s.sectionTitle}>My badges 🏅</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={s.badgeRow}>
            {badges.map((b: any) => (
              <View key={b.badge_slug} style={s.badgeChip}>
                <Text style={s.badgeIcon}>{b.icon}</Text>
                <Text style={s.badgeLabel} numberOfLines={2}>{b.label}</Text>
              </View>
            ))}
          </ScrollView>
        </>
      )}

      {/* All subjects */}
      <Text style={s.sectionTitle}>All subjects</Text>
      <View style={s.smallGrid}>
        {CORE_SUBJECTS.map(slug => {
          const meta = SUBJECT_META[slug];
          return (
            <TouchableOpacity
              key={slug}
              style={[s.smallBtn, { backgroundColor: meta.color }]}
              onPress={() => goPractice(slug)}
              activeOpacity={0.85}
            >
              <Text style={s.smallEmoji}>{meta.icon}</Text>
              <Text style={s.smallLabel}>{meta.label}</Text>
            </TouchableOpacity>
          );
        })}
      </View>

      {/* Culture tracks */}
      <Text style={s.sectionTitle}>Culture & heritage</Text>
      {CULTURAL_TRACKS.map(track => (
        <View key={track.title} style={[s.cultureCard, { backgroundColor: track.bg }]}>
          <Text style={s.cultureTitle}>{track.emoji} {track.title}</Text>
          <Text style={s.cultureDesc}>{track.desc}</Text>
          <View style={s.cultureBtnRow}>
            {track.subjects.map(slug => {
              const meta = SUBJECT_META[slug];
              if (!meta) return null;
              return (
                <TouchableOpacity key={slug} style={s.cultureBtn} onPress={() => goPractice(slug)}>
                  <Text style={s.cultureBtnText}>{meta.icon} {meta.label}</Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </View>
      ))}

      {/* Today's story teaser */}
      {story && (
        <TouchableOpacity
          style={s.storyCard}
          onPress={() => router.push("/(kid)/story")}
          activeOpacity={0.88}
        >
          <Text style={s.storyEyebrow}>📖  TODAY'S STORY</Text>
          <Text style={s.storyTitle}>{story.title}</Text>
          <Text style={s.storyMeta}>{story.read_min} min · Tap to read →</Text>
        </TouchableOpacity>
      )}

      {/* Encouragement */}
      <View style={s.encourageCard}>
        <Text style={s.encourageEmoji}>⭐</Text>
        <Text style={s.encourageText}>Every day you learn, you grow!</Text>
      </View>

      {/* Switch back to parent */}
      <TouchableOpacity style={s.parentBtn} onPress={async () => { await logout(); router.replace("/(auth)/login"); }}>
        <Text style={s.parentBtnText}>← Back to parent view</Text>
      </TouchableOpacity>

      <DailyRewardModal
        visible={!!reward?.claimed}
        coins={reward?.coins}
        xp={reward?.xp}
        streak={reward?.checkin_streak}
        onClose={() => setReward(null)}
      />

      <View style={{ height: 40 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: colors.brandLight },
  content: { paddingBottom: 40 },

  header:   { alignItems: "center", paddingTop: Platform.OS === "ios" ? 60 : 32,
              paddingBottom: 24, paddingHorizontal: 24, backgroundColor: colors.brand },
  wave:     { fontSize: 48, marginBottom: 4 },
  greeting: { fontSize: 20, color: "rgba(255,255,255,0.8)", fontWeight: "600" },
  name:     { fontSize: 36, fontWeight: "900", color: "white" },

  statsRow: { flexDirection: "row", gap: 16, margin: 20, marginBottom: 8 },
  statBadge:{ flex: 1, backgroundColor: "white", borderRadius: 20, padding: 20,
              alignItems: "center", shadowColor: "#000", shadowOpacity: 0.07, shadowRadius: 10, elevation: 3 },
  statEmoji:{ fontSize: 32, marginBottom: 6 },
  statNum:  { fontSize: 32, fontWeight: "900", color: colors.brand },
  statLabel:{ fontSize: 14, color: colors.textMuted, fontWeight: "600", marginTop: 2 },

  leaderBtn:   { flexDirection: "row", alignItems: "center", gap: 12, marginHorizontal: 20, marginBottom: 8,
                 backgroundColor: "white", borderRadius: 18, padding: 16,
                 shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  leaderEmoji: { fontSize: 28 },
  leaderAvatarImg: { width: 40, height: 40 },
  leaderText:  { flex: 1, fontSize: 17, fontWeight: "800", color: colors.text },
  leaderArrow: { fontSize: 20, fontWeight: "900", color: colors.brand },

  reminderBtn:  { flexDirection: "row", alignItems: "center", gap: 12, marginHorizontal: 20, marginBottom: 8,
                  backgroundColor: "#fef3c7", borderRadius: 18, padding: 16 },
  reminderEmoji:{ fontSize: 26 },
  reminderText: { flex: 1, fontSize: 16, fontWeight: "800", color: "#92400e" },
  reminderArrow:{ fontSize: 20, fontWeight: "900", color: "#92400e" },

  sectionTitle: { fontSize: 20, fontWeight: "900", color: colors.text,
                  marginHorizontal: 20, marginTop: 16, marginBottom: 12 },

  subjectGrid: { flexDirection: "row", flexWrap: "wrap", gap: 14, paddingHorizontal: 20, marginBottom: 20 },
  subjectBtn:  { width: "47%", borderRadius: 24, padding: 24, alignItems: "center",
                 minHeight: 140, justifyContent: "center",
                 shadowColor: "#000", shadowOpacity: 0.08, shadowRadius: 12, elevation: 3 },
  subjectEmoji:{ fontSize: 52, marginBottom: 10 },
  subjectLabel:{ fontSize: 18, fontWeight: "900", color: colors.text, textAlign: "center" },

  badgeRow:   { paddingHorizontal: 20, gap: 10 },
  badgeChip:  { width: 88, alignItems: "center", backgroundColor: "white", borderRadius: 18,
                paddingVertical: 14, paddingHorizontal: 6,
                shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  badgeIcon:  { fontSize: 30, marginBottom: 6 },
  badgeLabel: { fontSize: 11, fontWeight: "800", color: colors.text, textAlign: "center" },

  smallGrid:  { flexDirection: "row", flexWrap: "wrap", gap: 10, paddingHorizontal: 20, marginBottom: 20 },
  smallBtn:   { width: "30%", borderRadius: 18, paddingVertical: 16, alignItems: "center",
                shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  smallEmoji: { fontSize: 30, marginBottom: 6 },
  smallLabel: { fontSize: 12, fontWeight: "800", color: colors.text, textAlign: "center" },

  cultureCard:  { marginHorizontal: 20, marginBottom: 14, borderRadius: 20, padding: 18 },
  cultureTitle: { fontSize: 17, fontWeight: "900", color: colors.text, marginBottom: 4 },
  cultureDesc:  { fontSize: 13, color: colors.textMuted, fontWeight: "600", marginBottom: 12 },
  cultureBtnRow:{ flexDirection: "row", flexWrap: "wrap", gap: 8 },
  cultureBtn:   { backgroundColor: "white", borderRadius: 14, paddingHorizontal: 12, paddingVertical: 10 },
  cultureBtnText:{ fontSize: 13, fontWeight: "800", color: colors.text },

  storyCard:   { marginHorizontal: 20, marginBottom: 16, backgroundColor: colors.brand,
                 borderRadius: 20, padding: 24 },
  storyEyebrow:{ fontSize: 11, fontWeight: "800", color: "rgba(255,255,255,0.7)",
                 letterSpacing: 1.5, marginBottom: 8 },
  storyTitle:  { fontSize: 22, fontWeight: "900", color: "white", marginBottom: 6, lineHeight: 30 },
  storyMeta:   { fontSize: 14, color: "rgba(255,255,255,0.8)" },

  encourageCard:{ marginHorizontal: 20, backgroundColor: colors.surfaceAlt, borderRadius: 20,
                  padding: 20, alignItems: "center", flexDirection: "row", gap: 14 },
  encourageEmoji:{ fontSize: 40 },
  encourageText: { fontSize: 18, fontWeight: "800", color: colors.text, flex: 1, lineHeight: 26 },

  parentBtn:     { marginHorizontal: 20, marginTop: 20, padding: 16, alignItems: "center" },
  parentBtnText: { fontSize: 15, color: colors.brand, fontWeight: "700" },
});
