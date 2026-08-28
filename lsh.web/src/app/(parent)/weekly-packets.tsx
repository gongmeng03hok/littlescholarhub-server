/**
 * Parent Weekly Packets — shows the active child's grade-level weekly
 * practice packet automatically (switch children with the chips if you
 * have more than one), with a week picker and a Print button. Rendering is
 * shared with the admin/teacher Weekly Packets screens via
 * components/WeeklyPacketView.tsx.
 */
import { useState } from "react";
import { View, Text, ScrollView, TouchableOpacity, StyleSheet, Platform } from "react-native";
import { usePracticePacket } from "../../hooks/useApi";
import { useChildStore } from "../../store/childStore";
import { useChildren } from "../../hooks/useChildren";
import { WeekPicker } from "../../components/WeekPickerModal";
import { WeeklyPacketBody, printWeeklyPacket, useWeeklyPacketDisplay } from "../../components/WeeklyPacketView";
import { weekContainingToday, WEEK_OPTIONS_2026 } from "../../utils/weeklyPacketWeeks";
import { EmptyState } from "../../components/ui/EmptyState";
import { colors } from "../../constants/theme";

const DEFAULT_WEEK = weekContainingToday(WEEK_OPTIONS_2026) ?? "2026-08-10";

export default function ParentWeeklyPackets() {
  useChildren(); // hydrate the child list so a reload / deep link resolves a child
  const { activeChild, children, setActiveChild } = useChildStore();
  const [weekOf, setWeekOf] = useState(DEFAULT_WEEK);

  const gradeId = activeChild?.grade_id;
  const { data: packet, isLoading, error } = usePracticePacket(gradeId ?? 0, weekOf);
  const { wordSearches } = useWeeklyPacketDisplay(packet);

  if (!activeChild) {
    return (
      <View style={s.root}>
        <EmptyState emoji="👶" title="No child selected"
          body="Add a child from the Family tab to see their weekly practice packet." />
      </View>
    );
  }

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>Weekly Packets 📅</Text>
        <Text style={s.sub}>{activeChild.nickname}'s {activeChild.grade_label} packet, printable each week.</Text>

        {children.length > 1 && (
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 10 }}>
            {children.map(ch => (
              <TouchableOpacity key={ch.child_id}
                onPress={() => setActiveChild(ch)}
                style={[s.childChip, activeChild.child_id === ch.child_id && s.childChipActive]}>
                <Text style={[s.childChipText, activeChild.child_id === ch.child_id && s.childChipTextActive]}>
                  {ch.nickname} · {ch.grade_label}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        )}

        <View style={s.controlsRow}>
          <WeekPicker weekOf={weekOf} onChange={setWeekOf} />
          {packet && Platform.OS === "web" && (
            <TouchableOpacity onPress={() => printWeeklyPacket(packet, wordSearches)} style={s.printBtn}>
              <Text style={s.printBtnText}>🖨️ Print Packet</Text>
            </TouchableOpacity>
          )}
        </View>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        <WeeklyPacketBody
          packet={packet}
          isLoading={isLoading}
          error={error}
          emptyMessage={`No packet content for ${activeChild.grade_label} yet — check back soon!`}
          mascotLine={`🦉 Hi ${activeChild.nickname}, I'm Ollie the Owl — let's practice together!`}
        />
      </ScrollView>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.bg },
  header: {
    backgroundColor: "white",
    paddingTop: Platform.OS === "ios" ? 56 : 20,
    paddingBottom: 16, paddingHorizontal: 20,
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  title: { fontSize: 22, fontWeight: "900", color: colors.text },
  sub:   { fontSize: 13, color: colors.textMuted, marginTop: 2 },

  childChip:   { borderWidth: 2, borderColor: colors.border, borderRadius: 20,
                 paddingHorizontal: 16, paddingVertical: 8, marginRight: 8, backgroundColor: "white" },
  childChipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  childChipText:   { fontSize: 14, fontWeight: "700", color: colors.textMuted },
  childChipTextActive: { color: colors.brand },

  controlsRow: { flexDirection: "row", flexWrap: "wrap", gap: 12, alignItems: "center", marginTop: 14 },
  printBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  printBtnText: { color: "white", fontWeight: "800", fontSize: 13 },

  body: { padding: 18, paddingBottom: 60 },
});
