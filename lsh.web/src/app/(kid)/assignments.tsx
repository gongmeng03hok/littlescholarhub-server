import { useState } from "react";
import {
  View, Text, TouchableOpacity, ScrollView,
  StyleSheet, ActivityIndicator, Platform, Linking,
} from "react-native";
import { useRouter } from "expo-router";
import { useChildStore } from "../../store/childStore";
import { useAssignments, useCompleteAssignment } from "../../hooks/useApi";
import { colors } from "../../constants/theme";
import { GamePlayerModal } from "../../components/GamePlayerModal";

export default function KidAssignmentsScreen() {
  const router = useRouter();
  const { activeChild } = useChildStore();
  const childId = activeChild?.child_id;
  const { data: assignments = [], isLoading } = useAssignments(childId);
  const { mutate: completeAssignment } = useCompleteAssignment();

  const [playingGame, setPlayingGame] = useState<any | null>(null);

  return (
    <View style={s.root}>
      <View style={s.header}>
        <TouchableOpacity onPress={() => router.back()}>
          <Text style={s.back}>← Back</Text>
        </TouchableOpacity>
        <Text style={s.title}>My To-Dos 📝</Text>
      </View>

      <ScrollView contentContainerStyle={s.body}>
        {isLoading ? (
          <ActivityIndicator color={colors.brand} size="large" style={{ marginTop: 32 }} />
        ) : assignments.length === 0 ? (
          <Text style={s.empty}>Nothing to do right now — great job! 🎉</Text>
        ) : (
          (assignments as any[]).map(a => (
            <View key={a.assignment_id} style={s.card}>
              <View style={{ flex: 1 }}>
                <Text style={s.cardTitle}>{a.worksheet_title}</Text>
                {a.note && <Text style={s.cardNote}>{a.note}</Text>}
                <Text style={s.cardMeta}>{a.completed_at ? "✅ Done" : "Not done yet"}</Text>
              </View>
              <View style={{ gap: 8, alignItems: "flex-end" }}>
                {a.content_type === "game" && a.game_data && (
                  <TouchableOpacity onPress={() => setPlayingGame(a)}>
                    <Text style={s.openAction}>🎮 Play</Text>
                  </TouchableOpacity>
                )}
                {a.pdf_url && (
                  <TouchableOpacity onPress={() => Linking.openURL(a.pdf_url)}>
                    <Text style={s.openAction}>Open</Text>
                  </TouchableOpacity>
                )}
                {!a.completed_at && childId && (
                  <TouchableOpacity onPress={() => completeAssignment({ assignmentId: a.assignment_id, childId })}>
                    <Text style={s.doneAction}>Mark done</Text>
                  </TouchableOpacity>
                )}
              </View>
            </View>
          ))
        )}
      </ScrollView>

      <GamePlayerModal
        visible={!!playingGame}
        title={playingGame?.worksheet_title}
        gameData={playingGame?.game_data}
        onClose={() => setPlayingGame(null)}
        onComplete={() => {
          if (childId && playingGame && !playingGame.completed_at) {
            completeAssignment({ assignmentId: playingGame.assignment_id, childId });
          }
        }}
      />
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.brandLight },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20, borderBottomWidth: 1, borderBottomColor: colors.border },
  back: { fontSize: 14, fontWeight: "700", color: colors.brand, marginBottom: 8 },
  title: { fontSize: 22, fontWeight: "900", color: colors.text },

  body: { padding: 20, gap: 12 },
  empty: { textAlign: "center", color: colors.textMuted, marginTop: 32, fontSize: 15 },

  card: { flexDirection: "row", backgroundColor: "white", borderRadius: 16, padding: 18,
          shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  cardTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  cardNote: { fontSize: 12, color: colors.textMuted, marginTop: 4, fontStyle: "italic" },
  cardMeta: { fontSize: 12, color: colors.textMuted, marginTop: 6 },
  openAction: { fontSize: 13, fontWeight: "700", color: colors.brand },
  doneAction: { fontSize: 13, fontWeight: "700", color: colors.text },
});
