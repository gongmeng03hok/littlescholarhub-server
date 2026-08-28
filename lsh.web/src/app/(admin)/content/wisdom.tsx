/**
 * Admin Wisdom Manager — Daily wisdom CRUD
 * GET/POST/PUT/DELETE /api/admin/wisdom
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Modal, Platform,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi }  from "../../../api/admin";
import { confirmAction } from "../../../utils/confirm";
import { colors }    from "../../../constants/theme";
import { Input }     from "../../../components/ui/Input";
import { Button }    from "../../../components/ui/Button";

const TRACKS = [
  { key: "gita",     label: "🪔 Gita",     bg: "#fce4ec" },
  { key: "chinese",  label: "🏮 Chinese",  bg: "#fff3e0" },
  { key: "hispanic", label: "🌻 Hispanic", bg: "#e8f5e9" },
  { key: "universal",label: "✦ Universal", bg: "#fffbf0" },
];
const LANGS = [
  { id: 1, label: "EN" }, { id: 2, label: "中文" },
  { id: 3, label: "हिन्दी" }, { id: 4, label: "ES" },
];

const blank = () => ({
  text_original: "", text_english: "", author: "",
  source_track: "universal", language_id: 1, active_date: "",
});

export default function WisdomManager() {
  const qc = useQueryClient();
  const [search,  setSearch]  = useState("");
  const [track,   setTrack]   = useState<string | null>(null);
  const [modal,   setModal]   = useState<"create"|"edit"|null>(null);
  const [editing, setEditing] = useState<any>(null);
  const [form,    setForm]    = useState<any>(blank());

  const { data: items = [], isLoading } = useQuery({
    queryKey: ["adminWisdomList"],
    queryFn:  () => adminApi.listWisdom(),
    staleTime: 30_000,
    placeholderData: [],
  });

  const invalidate = () => qc.invalidateQueries({ queryKey: ["adminWisdomList"] });

  const { mutate: create, isPending: creating } = useMutation({
    mutationFn: (body: any) => adminApi.createWisdom(body),
    onSuccess: () => { setModal(null); setForm(blank()); invalidate(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const { mutate: update, isPending: updating } = useMutation({
    mutationFn: ({ id, body }: any) => adminApi.updateWisdom(id, body),
    onSuccess: () => { setModal(null); setEditing(null); invalidate(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const { mutate: remove } = useMutation({
    mutationFn: (id: number) => adminApi.deleteWisdom(id),
    onSuccess: invalidate,
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const openEdit = (item: any) => {
    setForm({
      text_original: item.text_original ?? "",
      text_english:  item.text_english  ?? "",
      author:        item.author        ?? "",
      source_track:  item.source_track  ?? "universal",
      language_id:   item.language_id   ?? 1,
      active_date:   item.active_date   ?? "",
    });
    setEditing(item);
    setModal("edit");
  };

  const confirmDelete = (item: any) => {
    Alert.alert("Delete wisdom entry?", "This cannot be undone.", [
      { text: "Cancel", style: "cancel" },
      { text: "Delete", style: "destructive", onPress: () => remove(item.wisdom_id) },
    ]);
  };

  const save = () => {
    if (!form.text_original.trim()) { Alert.alert("Original text is required"); return; }
    if (modal === "edit" && editing) {
      update({ id: editing.wisdom_id, body: form });
    } else {
      create(form);
    }
  };

  const filtered = (items as any[]).filter(item => {
    const matchSearch = !search || item.text_original?.toLowerCase().includes(search.toLowerCase())
      || item.author?.toLowerCase().includes(search.toLowerCase());
    const matchTrack  = !track  || item.source_track === track;
    return matchSearch && matchTrack;
  });

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>ॐ Wisdom</Text>
        <TouchableOpacity style={s.addBtn} onPress={() => { setForm(blank()); setModal("create"); }}>
          <Text style={s.addBtnText}>+ New</Text>
        </TouchableOpacity>
      </View>

      {/* Search + track filter */}
      <View style={s.filters}>
        <TextInput style={s.search} placeholder="Search wisdom…"
          placeholderTextColor={colors.textMuted}
          value={search} onChangeText={setSearch} />
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 8 }}>
          <TouchableOpacity style={[s.trackChip, !track && s.trackChipActive]}
            onPress={() => setTrack(null)}>
            <Text style={[s.trackChipText, !track && s.trackChipTextActive]}>All</Text>
          </TouchableOpacity>
          {TRACKS.map(t => (
            <TouchableOpacity key={t.key}
              style={[s.trackChip, { backgroundColor: t.bg }, track === t.key && s.trackChipActive]}
              onPress={() => setTrack(track === t.key ? null : t.key)}
            >
              <Text style={[s.trackChipText, track === t.key && s.trackChipTextActive]}>
                {t.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      {isLoading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.list} showsVerticalScrollIndicator={false}>
          {filtered.length === 0 && (
            <View style={s.center}>
              <Text style={{ fontSize: 40, marginBottom: 12 }}>📭</Text>
              <Text style={s.emptyText}>No wisdom entries yet.</Text>
            </View>
          )}
          {filtered.map((item: any) => {
            const trackMeta = TRACKS.find(t => t.key === item.source_track);
            return (
              <View key={item.wisdom_id} style={[s.row, { borderLeftWidth: 4, borderLeftColor: colors.brand }]}>
                <View style={[s.trackBadge, { backgroundColor: trackMeta?.bg ?? colors.surfaceAlt }]}>
                  <Text style={s.trackBadgeText}>
                    {TRACKS.find(t => t.key === item.source_track)?.label ?? item.source_track}
                  </Text>
                </View>
                <Text style={s.rowQuote} numberOfLines={3}>"{item.text_original}"</Text>
                {item.text_english && item.text_english !== item.text_original && (
                  <Text style={s.rowTranslation} numberOfLines={2}>{item.text_english}</Text>
                )}
                <Text style={s.rowAuthor}>— {item.author}</Text>
                {item.active_date && (
                  <Text style={s.rowDate}>📅 {item.active_date}</Text>
                )}
                <View style={s.rowActions}>
                  <TouchableOpacity style={s.editBtn} onPress={() => openEdit(item)}>
                    <Text style={s.editBtnText}>Edit</Text>
                  </TouchableOpacity>
                  <TouchableOpacity style={s.delBtn} onPress={() => confirmDelete(item)}>
                    <Text style={s.delBtnText}>Delete</Text>
                  </TouchableOpacity>
                </View>
              </View>
            );
          })}
          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      {/* Modal */}
      <Modal visible={!!modal} animationType="slide" presentationStyle="pageSheet">
        <View style={m.root}>
          <View style={m.header}>
            <Text style={m.title}>{modal === "edit" ? "Edit Wisdom" : "New Wisdom"}</Text>
            <TouchableOpacity onPress={() => { setModal(null); setEditing(null); }}>
              <Text style={m.close}>✕</Text>
            </TouchableOpacity>
          </View>
          <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
            <Input label="Original text *" value={form.text_original}
              onChangeText={v => setForm((f: any) => ({ ...f, text_original: v }))}
              placeholder="Original quote (any language)" multiline
              style={{ minHeight: 80, textAlignVertical: "top" }} />
            <Input label="English translation (if original is non-English)"
              value={form.text_english}
              onChangeText={v => setForm((f: any) => ({ ...f, text_english: v }))}
              placeholder="Leave blank if original is in English" multiline />
            <Input label="Author / Source" value={form.author}
              onChangeText={v => setForm((f: any) => ({ ...f, author: v }))}
              placeholder="e.g. Bhagavad Gita 2.47" />
            <Input label="Active date (YYYY-MM-DD, optional)"
              value={form.active_date}
              onChangeText={v => setForm((f: any) => ({ ...f, active_date: v }))}
              placeholder="Leave blank to rotate automatically" />

            <Text style={m.label}>Culture track</Text>
            <View style={m.trackRow}>
              {TRACKS.map(t => (
                <TouchableOpacity key={t.key}
                  style={[m.chip, { backgroundColor: t.bg }, form.source_track === t.key && m.chipActive]}
                  onPress={() => setForm((f: any) => ({ ...f, source_track: t.key }))}
                >
                  <Text style={[m.chipText, form.source_track === t.key && m.chipTextActive]}>
                    {t.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>

            <Text style={m.label}>Language</Text>
            <View style={m.langRow}>
              {LANGS.map(l => (
                <TouchableOpacity key={l.id}
                  style={[m.chip, form.language_id === l.id && m.chipActive]}
                  onPress={() => setForm((f: any) => ({ ...f, language_id: l.id }))}
                >
                  <Text style={[m.chipText, form.language_id === l.id && m.chipTextActive]}>
                    {l.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>

            <Button label={creating || updating ? "Saving…" : modal === "edit" ? "Save" : "Create"}
              onPress={save} loading={creating || updating} fullWidth style={{ marginTop: 8 }} />
            <View style={{ height: 40 }} />
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root:      { flex: 1, backgroundColor: "#f8f7ff" },
  center:    { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, marginTop: 40 },
  emptyText: { fontSize: 15, color: colors.textMuted, textAlign: "center" },
  header:    { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
               paddingBottom: 16, paddingHorizontal: 20,
               flexDirection: "row", alignItems: "center", justifyContent: "space-between",
               borderBottomWidth: 1, borderBottomColor: colors.border },
  title:     { fontSize: 20, fontWeight: "900", color: colors.text },
  addBtn:    { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  addBtnText:{ color: "white", fontWeight: "800", fontSize: 14 },
  filters:   { backgroundColor: "white", padding: 12, borderBottomWidth: 1, borderBottomColor: colors.border },
  search:    { backgroundColor: "#f0f0f0", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 10, fontSize: 14, color: colors.text },
  trackChip:      { paddingHorizontal: 14, paddingVertical: 6, borderRadius: 14, marginRight: 8, backgroundColor: "#f0f0f0" },
  trackChipActive:{ borderWidth: 2, borderColor: colors.brand },
  trackChipText:  { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  trackChipTextActive: { color: colors.brand },
  list:      { padding: 16, gap: 12 },
  row:       { backgroundColor: "white", borderRadius: 14, padding: 16,
               shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  trackBadge:    { alignSelf: "flex-start", borderRadius: 8, paddingHorizontal: 10, paddingVertical: 4, marginBottom: 10 },
  trackBadgeText:{ fontSize: 12, fontWeight: "700", color: colors.text },
  rowQuote:      { fontSize: 15, fontStyle: "italic", color: colors.text, lineHeight: 24, marginBottom: 6 },
  rowTranslation:{ fontSize: 13, color: colors.textMuted, fontStyle: "italic", marginBottom: 6 },
  rowAuthor:     { fontSize: 12, fontWeight: "700", color: colors.brand, marginBottom: 4 },
  rowDate:       { fontSize: 11, color: colors.textMuted, marginBottom: 8 },
  rowActions:    { flexDirection: "row", gap: 8, marginTop: 4 },
  editBtn:    { backgroundColor: colors.brandLight, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 6 },
  editBtnText:{ color: colors.brand, fontWeight: "700", fontSize: 13 },
  delBtn:     { backgroundColor: "#fee2e2", borderRadius: 8, paddingHorizontal: 12, paddingVertical: 6 },
  delBtnText: { color: colors.danger, fontWeight: "700", fontSize: 13 },
});

const m = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  header:  { flexDirection: "row", justifyContent: "space-between", alignItems: "center",
             padding: 20, paddingTop: Platform.OS === "ios" ? 56 : 20,
             backgroundColor: "white", borderBottomWidth: 1, borderBottomColor: colors.border },
  title:   { fontSize: 20, fontWeight: "900", color: colors.text },
  close:   { fontSize: 22, color: colors.textMuted, fontWeight: "700" },
  body:    { padding: 20 },
  label:   { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  trackRow:{ flexDirection: "row", flexWrap: "wrap", gap: 8, marginBottom: 16 },
  langRow: { flexDirection: "row", flexWrap: "wrap", gap: 8, marginBottom: 16 },
  chip:        { borderWidth: 2, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6 },
  chipActive:  { borderColor: colors.brand },
  chipText:    { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  chipTextActive: { color: colors.brand },
});
