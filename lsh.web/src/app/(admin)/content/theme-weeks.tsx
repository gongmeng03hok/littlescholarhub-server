/**
 * Admin Weekly Story Packs Manager
 * A themed bundle: one story + a set of worksheets (vocab/math/art/workbook)
 * + a journal prompt. List · create · edit · curate worksheets · soft-delete.
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Modal, Switch, Platform,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "../../../api/admin";
import { confirmAction } from "../../../utils/confirm";
import { colors, GRADES } from "../../../constants/theme";
import { Input } from "../../../components/ui/Input";
import { Button } from "../../../components/ui/Button";

const ROLES = ["vocab", "math", "art", "workbook", "worksheet"];

const blank = () => ({
  title: "", theme_slug: "", description: "", grade_id: undefined as number | undefined,
  story_id: undefined as number | undefined, journal_prompt: "", is_published: true,
});

const slugify = (s: string) => s.trim().toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, "");

export default function ThemeWeeksManager() {
  const qc = useQueryClient();
  const [modal, setModal] = useState<"create" | "edit" | null>(null);
  const [editing, setEditing] = useState<any>(null);
  const [form, setForm] = useState<any>(blank());
  const [expanded, setExpanded] = useState<number | null>(null);
  const [wsSearch, setWsSearch] = useState("");
  const [wsRole, setWsRole] = useState("worksheet");

  const { data: weeks = [], isLoading } = useQuery({
    queryKey: ["adminThemeWeeks"],
    queryFn: () => adminApi.listThemeWeeks(),
    staleTime: 15_000,
    placeholderData: [],
  });
  const { data: stories = [] } = useQuery({
    queryKey: ["adminStories"],
    queryFn: () => adminApi.listStories(),
    staleTime: 60_000,
    placeholderData: [],
  });
  const { data: worksheets = [] } = useQuery({
    queryKey: ["adminWorksheets"],
    queryFn: () => adminApi.listWorksheets(),
    staleTime: 60_000,
    placeholderData: [],
  });

  const inv = () => qc.invalidateQueries({ queryKey: ["adminThemeWeeks"] });

  const { mutate: create, isPending: creating } = useMutation({
    mutationFn: (body: any) => adminApi.createThemeWeek(body),
    onSuccess: () => { setModal(null); setForm(blank()); inv(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: update, isPending: updating } = useMutation({
    mutationFn: ({ id, body }: any) => adminApi.updateThemeWeek(id, body),
    onSuccess: () => { setModal(null); setEditing(null); inv(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: remove } = useMutation({
    mutationFn: (id: number) => adminApi.deleteThemeWeek(id),
    onSuccess: inv,
    onError: (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: addWorksheet } = useMutation({
    mutationFn: ({ weekId, worksheetId, role }: any) =>
      adminApi.addThemeWeekWorksheet(weekId, worksheetId, role),
    onSuccess: () => { setWsSearch(""); inv(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: removeWorksheet } = useMutation({
    mutationFn: ({ weekId, linkId }: any) => adminApi.removeThemeWeekWorksheet(weekId, linkId),
    onSuccess: inv,
  });

  const openEdit = (w: any) => {
    setForm({
      title: w.title, theme_slug: w.theme_slug, description: w.description ?? "",
      grade_id: w.grade_id ?? undefined, story_id: w.story_id ?? undefined,
      journal_prompt: w.journal_prompt ?? "", is_published: !!w.is_published,
    });
    setEditing(w); setModal("edit");
  };

  const save = () => {
    if (!form.title.trim()) { Alert.alert("Title is required"); return; }
    const body = { ...form, theme_slug: form.theme_slug || slugify(form.title) };
    modal === "edit" && editing ? update({ id: editing.theme_week_id, body }) : create(body);
  };

  const confirmDelete = (w: any) =>
    confirmAction(`Unpublish "${w.title}"?`, "Families won't see it.", () => remove(w.theme_week_id), "Unpublish");

  const matchingWorksheets = wsSearch.trim()
    ? (worksheets as any[]).filter(w => w.title.toLowerCase().includes(wsSearch.toLowerCase())).slice(0, 8)
    : [];

  return (
    <View style={s.root}>
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>🗓️ Weekly Story Packs</Text>
          <Text style={s.sub}>{(weeks as any[]).length} packs</Text>
        </View>
        <TouchableOpacity style={s.addBtn} onPress={() => { setForm(blank()); setModal("create"); }}>
          <Text style={s.addBtnText}>+ New</Text>
        </TouchableOpacity>
      </View>

      {isLoading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.list}>
          {(weeks as any[]).map(w => {
            const isOpen = expanded === w.theme_week_id;
            return (
              <View key={w.theme_week_id} style={s.card}>
                <TouchableOpacity style={s.cardTop} onPress={() => setExpanded(isOpen ? null : w.theme_week_id)}>
                  <View style={{ flex: 1 }}>
                    <Text style={s.cardTitle}>{w.title}</Text>
                    <Text style={s.cardMeta}>
                      {w.story_title ? `📖 ${w.story_title} · ` : ""}{w.worksheets?.length ?? 0} worksheets
                      {w.is_published ? "" : " · Hidden"}
                    </Text>
                  </View>
                  <Text style={s.chevron}>{isOpen ? "▲" : "▼"}</Text>
                </TouchableOpacity>

                <View style={s.cardActions}>
                  <TouchableOpacity onPress={() => openEdit(w)}><Text style={s.actionLink}>Edit</Text></TouchableOpacity>
                  <TouchableOpacity onPress={() => confirmDelete(w)}><Text style={[s.actionLink, { color: colors.danger }]}>Unpublish</Text></TouchableOpacity>
                </View>

                {isOpen && (
                  <View style={s.wsPanel}>
                    {(w.worksheets ?? []).map((link: any) => (
                      <View key={link.link_id} style={s.wsRow}>
                        <Text style={s.wsRole}>{link.role}</Text>
                        <Text style={s.wsRowTitle} numberOfLines={1}>{link.worksheet_title}</Text>
                        <TouchableOpacity onPress={() => removeWorksheet({ weekId: w.theme_week_id, linkId: link.link_id })}>
                          <Text style={s.removeLink}>✕</Text>
                        </TouchableOpacity>
                      </View>
                    ))}

                    <Text style={s.addWsLabel}>Add a worksheet</Text>
                    <View style={{ flexDirection: "row", gap: 6, marginBottom: 8, flexWrap: "wrap" }}>
                      {ROLES.map(r => (
                        <TouchableOpacity key={r} onPress={() => setWsRole(r)}
                          style={[s.roleChip, wsRole === r && s.roleChipActive]}>
                          <Text style={[s.roleChipText, wsRole === r && s.roleChipTextActive]}>{r}</Text>
                        </TouchableOpacity>
                      ))}
                    </View>
                    <TextInput style={s.wsSearchInput} placeholder="Search worksheets by title…"
                      value={wsSearch} onChangeText={setWsSearch} />
                    {matchingWorksheets.map(mw => (
                      <TouchableOpacity key={mw.worksheet_id} style={s.wsOption}
                        onPress={() => addWorksheet({ weekId: w.theme_week_id, worksheetId: mw.worksheet_id, role: wsRole })}>
                        <Text style={s.wsOptionText}>+ {mw.title}</Text>
                      </TouchableOpacity>
                    ))}
                  </View>
                )}
              </View>
            );
          })}
          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      {/* Create / Edit modal */}
      <Modal visible={!!modal} animationType="slide" presentationStyle="pageSheet" onRequestClose={() => setModal(null)}>
        <View style={m.root}>
          <View style={m.header}>
            <Text style={m.headerTitle}>{modal === "edit" ? "Edit story pack" : "New story pack"}</Text>
            <TouchableOpacity onPress={() => setModal(null)}><Text style={m.close}>✕</Text></TouchableOpacity>
          </View>
          <ScrollView contentContainerStyle={m.body}>
            <Input label="Title" value={form.title}
              onChangeText={(v: string) => setForm((f: any) => ({ ...f, title: v }))} placeholder="e.g. Ocean Week" />
            <Input label="Slug (auto from title if left blank)" value={form.theme_slug}
              onChangeText={(v: string) => setForm((f: any) => ({ ...f, theme_slug: slugify(v) }))} placeholder="ocean-week" />
            <Input label="Description" value={form.description}
              onChangeText={(v: string) => setForm((f: any) => ({ ...f, description: v }))} placeholder="One sentence about this week's theme" />

            <Text style={m.fieldLabel}>Grade (optional — leave blank for all grades)</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              <View style={{ flexDirection: "row", gap: 8 }}>
                <TouchableOpacity onPress={() => setForm((f: any) => ({ ...f, grade_id: undefined }))}
                  style={[m.chip, form.grade_id === undefined && m.chipActive]}>
                  <Text style={[m.chipText, form.grade_id === undefined && m.chipTextActive]}>All</Text>
                </TouchableOpacity>
                {GRADES.map(g => (
                  <TouchableOpacity key={g.grade_id} onPress={() => setForm((f: any) => ({ ...f, grade_id: g.grade_id }))}
                    style={[m.chip, form.grade_id === g.grade_id && m.chipActive]}>
                    <Text style={[m.chipText, form.grade_id === g.grade_id && m.chipTextActive]}>{g.label}</Text>
                  </TouchableOpacity>
                ))}
              </View>
            </ScrollView>

            <Text style={m.fieldLabel}>Story</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              <View style={{ flexDirection: "row", gap: 8 }}>
                {(stories as any[]).slice(0, 30).map(story => (
                  <TouchableOpacity key={story.story_id} onPress={() => setForm((f: any) => ({ ...f, story_id: story.story_id }))}
                    style={[m.chip, form.story_id === story.story_id && m.chipActive]}>
                    <Text style={[m.chipText, form.story_id === story.story_id && m.chipTextActive]} numberOfLines={1}>{story.title}</Text>
                  </TouchableOpacity>
                ))}
              </View>
            </ScrollView>

            <Input label="Journal prompt" value={form.journal_prompt}
              onChangeText={(v: string) => setForm((f: any) => ({ ...f, journal_prompt: v }))}
              placeholder="e.g. Write about your favorite sea creature and why." />

            <View style={m.toggleRow}>
              <Text style={m.fieldLabel}>Published</Text>
              <Switch value={form.is_published}
                onValueChange={(v: boolean) => setForm((f: any) => ({ ...f, is_published: v }))}
                thumbColor={form.is_published ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
            </View>

            <Button label={creating || updating ? "Saving…" : modal === "edit" ? "Save changes" : "Create pack"}
              onPress={save} loading={creating || updating} fullWidth style={{ marginTop: 8 }} />
            <View style={{ height: 40 }} />
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center", marginTop: 40 },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 14, paddingHorizontal: 20, flexDirection: "row", alignItems: "center",
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title: { fontSize: 20, fontWeight: "900", color: colors.text },
  sub: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  addBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8 },
  addBtnText: { color: "white", fontWeight: "800", fontSize: 14 },

  list: { padding: 16, gap: 12 },
  card: { backgroundColor: "white", borderRadius: 14, padding: 16,
          shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  cardTop: { flexDirection: "row", alignItems: "center" },
  cardTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  cardMeta: { fontSize: 12, color: colors.textMuted, marginTop: 4 },
  chevron: { fontSize: 12, color: colors.textMuted, marginLeft: 8 },
  cardActions: { flexDirection: "row", gap: 16, marginTop: 10 },
  actionLink: { fontSize: 12, fontWeight: "700", color: colors.brand },

  wsPanel: { marginTop: 12, borderTopWidth: 1, borderTopColor: colors.border, paddingTop: 12, gap: 6 },
  wsRow: { flexDirection: "row", alignItems: "center", gap: 8 },
  wsRole: { fontSize: 10, fontWeight: "800", color: colors.brand, textTransform: "uppercase", width: 64 },
  wsRowTitle: { flex: 1, fontSize: 13, color: colors.text },
  removeLink: { fontSize: 13, color: colors.danger, fontWeight: "700", padding: 4 },
  addWsLabel: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginTop: 10, marginBottom: 6 },
  roleChip: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 8, paddingHorizontal: 10, paddingVertical: 4 },
  roleChipActive: { backgroundColor: colors.brand, borderColor: colors.brand },
  roleChipText: { fontSize: 11, fontWeight: "700", color: colors.textMuted },
  roleChipTextActive: { color: "white" },
  wsSearchInput: { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10,
                   paddingHorizontal: 12, paddingVertical: 8, fontSize: 13, marginBottom: 6 },
  wsOption: { paddingVertical: 8, paddingHorizontal: 10, backgroundColor: "#f8f7ff", borderRadius: 8, marginBottom: 4 },
  wsOptionText: { fontSize: 13, color: colors.brand, fontWeight: "600" },
});

const m = StyleSheet.create({
  root: { flex: 1, backgroundColor: "#f8f7ff" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 20 : 16,
            paddingBottom: 16, paddingHorizontal: 20, flexDirection: "row", alignItems: "center",
            justifyContent: "space-between", borderBottomWidth: 1, borderBottomColor: colors.border },
  headerTitle: { fontSize: 18, fontWeight: "900", color: colors.text },
  close: { fontSize: 18, color: colors.textMuted, fontWeight: "700" },
  body: { padding: 20 },
  fieldLabel: { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  chip: { borderWidth: 2, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6, maxWidth: 180 },
  chipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText: { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  chipTextActive: { color: colors.brand },
  toggleRow: { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 16 },
});
