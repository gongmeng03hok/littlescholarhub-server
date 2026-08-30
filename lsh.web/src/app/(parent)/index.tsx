/**
 * Parent Dashboard — mirrors the reference portal's logged-in home:
 * Greeting · Streak · Wisdom · Recent Activity · Cultural tracks · Story teaser · Quick actions
 */
import { ShareCard }    from "../../components/ShareCard";
import { useEffect } from "react";
import {
  ScrollView, View, Text, TouchableOpacity, Image,
  StyleSheet, Platform, RefreshControl,
} from "react-native";
import { useRouter } from "expo-router";

import { useAuthStore }  from "../../store/authStore";
import { useChildStore } from "../../store/childStore";
import { useChildren }   from "../../hooks/useChildren";
import { useProgress, useTodayStory, useAssignments, useActivities } from "../../hooks/useApi";
import { WisdomCard }    from "../../components/WisdomCard";
import { StreakBadge }   from "../../components/StreakBadge";
import { SubjectCard }   from "../../components/SubjectCard";
import { colors, CULTURAL_TRACKS, SUBJECT_META } from "../../constants/theme";
import { mergeActivities } from "../../utils/activities";
const CORE_SUBJECTS = ["math","phonics","reading","art","story","logic","feelings","manners","workbooks"];

export default function ParentDashboard() {
  const router  = useRouter();
  // The family profile carries referral_code, which the invite card needs.
  const { family } = useAuthStore();
  const { activeChild, setActiveChild, children } = useChildStore();
  const { data: childList, isRefetching, refetch } = useChildren();

  const grade   = activeChild?.grade_id ?? 2;
  const childId = activeChild?.child_id;

  const { data: prog }  = useProgress(childId);
  const { data: story } = useTodayStory(grade);
  const { data: assignments = [] } = useAssignments(childId);
  const pendingAssignments = (assignments as any[]).filter(a => !a.completed_at);
  const { data: activityData } = useActivities(childId, 5);
  const recentActivity = mergeActivities(activityData).slice(0, 5);

  // sync children list into store
  useEffect(() => {
    if (childList?.length && !activeChild) setActiveChild(childList[0]);
  }, [childList]);

  const streak     = prog?.streak?.current_streak ?? 0;
  const weeklyMins = prog?.weekly?.mins ?? 0;
  const totalHours = prog?.streak?.total_hours ?? 0;

  const greetingHour = new Date().getHours();
  const greeting = greetingHour < 12 ? "Good morning" : greetingHour < 17 ? "Good afternoon" : "Good evening";

  return (
    <ScrollView
      style={s.root}
      contentContainerStyle={s.content}
      showsVerticalScrollIndicator={false}
      refreshControl={
        <RefreshControl refreshing={isRefetching} onRefresh={refetch} tintColor={colors.brand} />
      }
    >
      {/* ── Header ─────────────────────────────────────────── */}
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.greeting}>{greeting} 👋</Text>
          <Text style={s.familyName}>
            {activeChild ? activeChild.nickname + "'s plan" : "Little Scholars Hub"}
          </Text>
        </View>
        <TouchableOpacity style={s.avatar} onPress={() => router.push("/(parent)/settings")}>
          <Text style={{ fontSize: 22 }}>👨‍👩‍👧</Text>
        </TouchableOpacity>
      </View>

      {/* ── Child switcher ──────────────────────────────────── */}
      {children.length > 1 && (
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={s.childScroll}>
          {children.map(child => (
            <TouchableOpacity
              key={child.child_id}
              onPress={() => setActiveChild(child)}
              style={[s.childChip, activeChild?.child_id === child.child_id && s.childChipActive]}
            >
              <Text style={[s.childChipText, activeChild?.child_id === child.child_id && s.childChipTextActive]}>
                {child.nickname}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      )}

      {/* ── No child yet CTA ───────────────────────────────── */}
      {children.length === 0 && (
        <TouchableOpacity style={s.addChildBanner} onPress={() => router.push("/(parent)/children")}>
          <Text style={s.addChildText}>➕ Add your first child to get started</Text>
        </TouchableOpacity>
      )}

      {/* ── Streak row ─────────────────────────────────────── */}
      {childId && (
        <View style={s.section}>
          <StreakBadge streak={streak} weeklyMins={weeklyMins} totalHours={totalHours} />
        </View>
      )}

      {/* ── Daily Wisdom ───────────────────────────────────── */}
      <View style={s.section}>
        <WisdomCard />
        <ShareCard code={(family as any)?.referral_code} />
      </View>

      {/* ── Pending assignment reminder ──────────────────────── */}
      {childId && pendingAssignments.length > 0 && (
        <TouchableOpacity
          style={s.assessmentBanner}
          onPress={() => router.push("/(parent)/assignments")}
          activeOpacity={0.88}
        >
          <View style={s.assessmentBannerLeft}>
            <Text style={s.assessmentBannerEmoji}>⏰</Text>
            <View style={{ flex: 1 }}>
              <Text style={s.assessmentBannerTitle}>
                {pendingAssignments.length} assignment{pendingAssignments.length > 1 ? "s" : ""} to finish
              </Text>
              <Text style={s.assessmentBannerSub}>
                {activeChild?.nickname} still needs to complete {pendingAssignments.length > 1 ? "these" : "this"}
              </Text>
            </View>
          </View>
          <Text style={s.assessmentBannerArrow}>→</Text>
        </TouchableOpacity>
      )}

      {/* ── Quick actions ──────────────────────────────────── */}
      <View style={s.section}>
        <Text style={s.sectionTitle}>Quick start</Text>
        <View style={s.quickRow}>
          {[
            { emoji:"📋", label:"Weekly plan",    route:"/(parent)/plan"       },
            { emoji:"📅", label:"Weekly Packets", route:"/(parent)/weekly-packets" },
            { emoji:"📝", label:"Assignments",    route:"/(parent)/assignments"},
            { emoji:"🎁", label:"Rewards",        route:"/(parent)/rewards"    },
            { emoji:"🗓️", label:"Story packs",    route:"/(parent)/storypacks" },
            { emoji:"📊", label:"Progress",       route:"/(parent)/progress"   },
          ].map(item => (
            <TouchableOpacity key={item.label} style={s.quickCard}
              onPress={() => router.push(item.route as any)}>
              <Text style={s.quickEmoji}>{item.emoji}</Text>
              <Text style={s.quickLabel}>{item.label}</Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* ── Today's story teaser ───────────────────────────── */}
      {story && (
        <TouchableOpacity style={s.storyCard} onPress={() => router.push("/(parent)/story")} activeOpacity={0.88}>
          <View style={s.storyLeft}>
            <Text style={s.storyEyebrow}>📖  TODAY'S STORY</Text>
            <Text style={s.storyTitle}>{story.title}</Text>
            <Text style={s.storyMeta}>{story.read_min} min · {story.theme_tag}</Text>
          </View>
          <Text style={s.storyArrow}>→</Text>
        </TouchableOpacity>
      )}
      {/* ── 9 Subjects ─────────────────────────────────────── */}
      <View style={s.section}>
        <Text style={s.sectionTitle}>Practice a subject</Text>
        <View style={s.subjectGrid}>
          {CORE_SUBJECTS.map((slug) => (
            <View key={slug} style={s.subjectCell}>
              <SubjectCard slug={slug} gradeId={grade} />
            </View>
          ))}
        </View>
      </View>

      {/* ── Recent activity — what your kid has been doing ──── */}
      {childId && (
        <View style={s.section}>
          <View style={{ flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 12 }}>
            <Text style={[s.sectionTitle, { marginBottom: 0 }]}>Recent activity</Text>
            <TouchableOpacity onPress={() => router.push("/(parent)/progress")}>
              <Text style={s.seeAllLink}>See all →</Text>
            </TouchableOpacity>
          </View>
          {recentActivity.length === 0 ? (
            <View style={s.activityEmpty}>
              <Text style={s.activityEmptyText}>
                No completed activities yet. Once {activeChild?.nickname ?? "your child"} answers questions or
                submits homework, you'll see their answer sheet here.
              </Text>
            </View>
          ) : (
            recentActivity.map(item => (
              <View key={item.key} style={s.activityRow}>
                {item.type === "quiz" ? (
                  <>
                    <View style={[s.activityIcon, item.is_correct ? s.activityIconOk : s.activityIconErr]}>
                      <Text style={s.activityIconText}>{item.is_correct ? "✓" : "✗"}</Text>
                    </View>
                    <View style={{ flex: 1 }}>
                      <Text style={s.activityQuestion} numberOfLines={2}>{item.question_text}</Text>
                      <Text style={s.activityAnswer}>
                        Answered "{item.given_answer}"{!item.is_correct ? ` · correct: "${item.correct_answer}"` : ""}
                      </Text>
                    </View>
                  </>
                ) : (
                  <>
                    {item.image_url ? (
                      <Image source={{ uri: item.image_url }} style={s.activityThumb} resizeMode="cover" />
                    ) : (
                      <View style={[s.activityIcon, { backgroundColor: colors.brandLight }]}>
                        <Text style={s.activityIconText}>📸</Text>
                      </View>
                    )}
                    <View style={{ flex: 1 }}>
                      <Text style={s.activityQuestion} numberOfLines={1}>
                        {item.worksheet_title ?? "Homework submission"}
                      </Text>
                      <Text style={s.activityAnswer}>
                        {item.score != null ? `Scored ${item.score}/100` : "Awaiting review"}
                      </Text>
                    </View>
                  </>
                )}
              </View>
            ))
          )}
        </View>
      )}

      {/* ── Cultural tracks ────────────────────────────────── */}
      <View style={s.section}>
        <Text style={s.sectionTitle}>Cultural tracks</Text>
        {CULTURAL_TRACKS.map(track => (
          <View key={track.title} style={[s.trackCard, { backgroundColor: track.bg }]}>
            <Text style={s.trackEmoji}>{track.emoji}</Text>
            <View style={{ flex: 1 }}>
              <Text style={s.trackTitle}>{track.title}</Text>
              <Text style={s.trackDesc}>{track.desc}</Text>
            </View>
            <View style={s.trackSubjects}>
              {track.subjects.map(slug => (
                <TouchableOpacity key={slug}
                  onPress={() => router.push({ pathname:"/(parent)/practice/[subject]", params:{ subject:slug, grade } })}
                  style={s.trackSubjectBtn}>
                  <Text style={s.trackSubjectText}>{SUBJECT_META[slug]?.icon} {SUBJECT_META[slug]?.label}</Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>
        ))}
      </View>

      {/* ── Kid mode CTA ───────────────────────────────────── */}
      <TouchableOpacity style={s.kidModeCta} onPress={() => router.push("/(auth)/kid-select")}>
        <Text style={s.kidModeText}>🎮  Switch to Kid Mode</Text>
        <Text style={s.kidModeSub}>Let your child learn with a simplified view</Text>
      </TouchableOpacity>

      <View style={{ height: 32 }} />
    </ScrollView>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  content: { paddingBottom: 40 },

  header:  { flexDirection: "row", alignItems: "center", backgroundColor: "white",
             paddingTop: Platform.OS === "ios" ? 56 : 20, paddingBottom: 20,
             paddingHorizontal: 20, borderBottomWidth: 1, borderBottomColor: colors.border },
  greeting:    { fontSize: 13, color: colors.textMuted, fontWeight: "600" },
  familyName:  { fontSize: 22, fontWeight: "900", color: colors.text, marginTop: 2 },
  avatar:      { width: 44, height: 44, borderRadius: 22, backgroundColor: colors.brandLight,
                 justifyContent: "center", alignItems: "center" },

  childScroll: { paddingHorizontal: 20, paddingVertical: 12 },
  childChip:   { borderWidth: 2, borderColor: colors.border, borderRadius: 20,
                 paddingHorizontal: 16, paddingVertical: 8, marginRight: 8, backgroundColor: "white" },
  childChipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  childChipText:   { fontSize: 14, fontWeight: "700", color: colors.textMuted },
  childChipTextActive: { color: colors.brand },

  addChildBanner: { margin: 20, backgroundColor: colors.brandLight, borderRadius: 14,
                    padding: 16, alignItems: "center" },
  addChildText:   { color: colors.brand, fontWeight: "700", fontSize: 15 },

  section:      { paddingHorizontal: 20, marginTop: 20 },
  sectionTitle: { fontSize: 16, fontWeight: "800", color: colors.text, marginBottom: 12 },

  quickRow:  { flexDirection: "row", gap: 10 },
  quickCard: { flex: 1, backgroundColor: "white", borderRadius: 14, padding: 14,
               alignItems: "center", shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  quickEmoji:{ fontSize: 26, marginBottom: 6 },
  quickLabel:{ fontSize: 12, fontWeight: "700", color: colors.text, textAlign: "center" },

  storyCard: { marginHorizontal: 20, marginTop: 20, backgroundColor: colors.brand,
               borderRadius: 16, padding: 20, flexDirection: "row", alignItems: "center" },
  storyLeft: { flex: 1 },
  storyEyebrow: { fontSize: 10, fontWeight: "800", color: "rgba(255,255,255,0.7)", letterSpacing: 1.5, marginBottom: 6 },
  storyTitle:   { fontSize: 18, fontWeight: "900", color: "white", marginBottom: 4 },
  storyMeta:    { fontSize: 12, color: "rgba(255,255,255,0.7)" },
  storyArrow:   { fontSize: 24, color: "white", marginLeft: 12 },
  subjectGrid: { flexDirection: "row", flexWrap: "wrap", gap: 10 },
  subjectCell: { width: "48%" },

  seeAllLink: { fontSize: 13, fontWeight: "700", color: colors.brand },
  activityEmpty: { backgroundColor: "white", borderRadius: 14, padding: 20 },
  activityEmptyText: { fontSize: 13, color: colors.textMuted, lineHeight: 20 },
  activityRow: { flexDirection: "row", alignItems: "center", gap: 12, backgroundColor: "white",
                 borderRadius: 14, padding: 14, marginBottom: 8,
                 shadowColor: "#000", shadowOpacity: 0.04, shadowRadius: 6, elevation: 1 },
  activityIcon: { width: 40, height: 40, borderRadius: 20, alignItems: "center", justifyContent: "center" },
  activityIconOk: { backgroundColor: "#dcfce7" },
  activityIconErr: { backgroundColor: "#fee2e2" },
  activityIconText: { fontSize: 18, fontWeight: "900" },
  activityThumb: { width: 40, height: 40, borderRadius: 10, backgroundColor: colors.brandLight },
  activityQuestion: { fontSize: 13, fontWeight: "700", color: colors.text },
  activityAnswer: { fontSize: 12, color: colors.textMuted, marginTop: 2 },

  trackCard:    { borderRadius: 16, padding: 16, marginBottom: 12 },
  trackEmoji:   { fontSize: 30, marginBottom: 8 },
  trackTitle:   { fontSize: 16, fontWeight: "800", color: colors.text },
  trackDesc:    { fontSize: 13, color: colors.textMuted, marginTop: 2, marginBottom: 10 },
  trackSubjects:{ flexDirection: "row", flexWrap: "wrap", gap: 8 },
  trackSubjectBtn: { backgroundColor: "rgba(255,255,255,0.7)", borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6 },
  trackSubjectText:{ fontSize: 12, fontWeight: "700", color: colors.text },

  kidModeCta:  { marginHorizontal: 20, marginTop: 20, backgroundColor: "white", borderRadius: 16,
                 padding: 18, borderWidth: 2, borderColor: colors.brandLight, alignItems: "center" },
  kidModeText: { fontSize: 16, fontWeight: "800", color: colors.brand },
  kidModeSub:  { fontSize: 13, color: colors.textMuted, marginTop: 4 },

  // ── Start Assessment CTA banner (first-time users) ──────
  assessmentBanner: {
    marginHorizontal: 20, marginTop: 16,
    backgroundColor: colors.brand, borderRadius: 16, padding: 18,
    flexDirection: "row", alignItems: "center", justifyContent: "space-between",
  },
  assessmentBannerLeft:  { flexDirection: "row", alignItems: "center", gap: 14, flex: 1 },
  assessmentBannerEmoji: { fontSize: 32 },
  assessmentBannerTitle: { fontSize: 16, fontWeight: "900", color: "white" },
  assessmentBannerSub:   { fontSize: 12, color: "rgba(255,255,255,0.8)", marginTop: 3 },
  assessmentBannerArrow: { fontSize: 22, color: "white", fontWeight: "700", marginLeft: 8 },
});
