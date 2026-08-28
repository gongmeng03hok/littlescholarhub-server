/**
 * Admin Featured Collections manager
 * Curates the top "featured strip" shown on the parent Content Library page.
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Modal, Switch, Platform,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "../../../api/admin";
import { confirmAction } from "../../../utils/confirm";
import { colors }   from "../../../constants/theme";
import { Input }    from "../../../components/ui/Input";
import { Button }   from "../../../components/ui/Button";

const blank = () => ({
  worksheet_id: undefined as number | undefined,
  subtitle_override: "", sort_order: 0, is_active: true,
});

export default function FeaturedManager() {
  const qc = useQueryClient();
  const [modal, setModal]     = useState<"create" | "edit" | null>(null);
  const [editing, setEditing] = useState<any>(null);
  const [form, setForm]       = useState<any>(blank());
  const [search, setSearch]   = useState("");

  const { data: featured = [], isLoading } = useQuery({
    queryKey: ["adminFeatured"],
    queryFn:  () => adminApi.listFeatured(),
    staleTime: 30_000,
    placeholderData: [],
  });

  const { data: worksheets = [] } = useQuery({
    queryKey: ["adminWorksheets"],
    queryFn:  () => adminApi.listWorksheets(),
    staleTime: 30_000,
    placeholderData: [],
  });

  const inv = () => qc.invalidateQueries({ queryKey: ["adminFeatured"] });

  const { mutate: create, isPending: creating } = useMutation({
    mutationFn: (body: any) => adminApi.createFeatured(body),
    onSuccess:  () => { setModal(null); setForm(blank()); inv(); },
    onError:    (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: update, isPending: updating } = useMutation({
    mutationFn: ({ id, body }: any) => adminApi.updateFeatured(id, body),
    onSuccess:  () => { setModal(null); setEditing(null); inv(); },
    onError:    (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: remove } = useMutation({
    mutationFn: (id: number) => adminApi.deleteFeatured(id),
    onSuccess: inv,
    onError:   (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: toggleActive } = useMutation({
    mutationFn: ({ id, val }: any) => adminApi.updateFeatured(id, { is_active: val }),
    onSuccess: inv,
  });

  const openEdit = (f: any) => {
    setForm({
      worksheet_id: f.worksheet_id,
      subtitle_override: f.subtitle_override ?? "",
      sort_order: f.sort_order ?? 0,
      is_active: !!f.is_active,
    });
    setEditing(f); setModal("edit");
  };

  const confirmDelete = (f: any) =>
    Alert.alert(`Remove "${f.title}" from featured?`, undefined, [
      { text: "Cancel", style: "cancel" },
      { text: "Remove", style: "destructive", onPress: () => remove(f.featured_id) },
    ]);

  const save = () => {
    if (!form.worksheet_id) { Alert.alert("Pick a content item first"); return; }
    modal === "edit" && editing
      ? update({ id: editing.featured_id, body: form })
      : create(form);
  };

  const worksheetOptions = (worksheets as any[]).filter(w =>
    !search || w.title?.toLowerCase().includes(search.toLowerCase()));

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>⭐ Featured Collections</Text>
        <TouchableOpacity style={s.addBtn}
          onPress={() => { setForm(blank()); setSearch(""); setModal("create"); }}>
          <Text style={s.addBtnText}>+ New</Text>
        </TouchableOpacity>
      </View>

      {isLoading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.list} showsVerticalScrollIndicator={false}>
          {(featured as any[]).length === 0 && (
            <View style={s.center}>
              <Text style={{ fontSize: 40, marginBottom: 12 }}>⭐</Text>
              <Text style={s.emptyTxt}>Nothing featured yet. Add a coloring page or mini-book to promote it.</Text>
            </View>
          )}
          {(featured as any[]).map(f => (
            <View key={f.featured_id} style={s.row}>
              <View style={s.rowLeft}>
                <View style={s.rowTop}>
                  <Text style={s.rowTitle} numberOfLines={1}>{f.title}</Text>
                  <Switch value={!!f.is_active}
                    onValueChange={val => toggleActive({ id: f.featured_id, val })}
                    thumbColor={f.is_active ? colors.brand : "#ccc"}
                    trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
                </View>
                <View style={s.rowMeta}>
                  <Text style={s.tag}>#{f.sort_order}</Text>
                  {f.subtitle_override && <Text style={s.tag}>{f.subtitle_override}</Text>}
                  <Text style={s.tag}>{f.content_type}</Text>
                </View>
              </View>
              <View style={s.actions}>
                <TouchableOpacity style={s.editBtn} onPress={() => openEdit(f)}>
                  <Text style={s.editTxt}>Edit</Text>
                </TouchableOpacity>
                <TouchableOpacity style={s.delBtn} onPress={() => confirmDelete(f)}>
                  <Text style={s.delTxt}>✕</Text>
                </TouchableOpacity>
              </View>
            </View>
          ))}
          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      <Modal visible={!!modal} animationType="slide" presentationStyle="pageSheet">
        <View style={m.root}>
          <View style={m.header}>
            <Text style={m.title}>{modal === "edit" ? "Edit Featured Item" : "New Featured Item"}</Text>
            <TouchableOpacity onPress={() => { setModal(null); setEditing(null); }}>
              <Text style={m.close}>✕</Text>
            </TouchableOpacity>
          </View>
          <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
            {modal === "create" && (
              <>
                <Text style={m.label}>Pick content item *</Text>
                <TextInput style={m.search} placeholder="Search worksheets…"
                  placeholderTextColor={colors.textMuted}
                  value={search} onChangeText={setSearch} />
                <ScrollView style={{ maxHeight: 220, marginBottom: 16 }}>
                  {worksheetOptions.map(w => (
                    <TouchableOpacity key={w.worksheet_id}
                      style={[m.wsRow, form.worksheet_id === w.worksheet_id && m.wsRowA]}
                      onPress={() => setForm((f: any) => ({ ...f, worksheet_id: w.worksheet_id }))}>
                      <Text style={m.wsRowTxt} numberOfLines={1}>{w.title}</Text>
                      <Text style={m.wsRowSub}>Grade {w.grade_id} · {w.content_type}</Text>
                    </TouchableOpacity>
                  ))}
                </ScrollView>
              </>
            )}

            <Input label="Subtitle (e.g. 'TK · Mother's Day')" value={form.subtitle_override}
              onChangeText={v => setForm((f: any) => ({ ...f, subtitle_override: v }))}
              placeholder="Grade · Theme" />
            <Input label="Sort order" value={String(form.sort_order)}
              onChangeText={v => setForm((f: any) => ({ ...f, sort_order: parseInt(v) || 0 }))}
              keyboardType="number-pad" />

            <View style={m.toggleRow}>
              <Text style={m.label}>Active</Text>
              <Switch value={form.is_active}
                onValueChange={v => setForm((f: any) => ({ ...f, is_active: v }))}
                thumbColor={form.is_active ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
            </View>

            <Button
              label={creating || updating ? "Saving…" : modal === "edit" ? "Save changes" : "Add to featured"}
              onPress={save} loading={creating || updating} fullWidth style={{ marginTop: 8 }} />
            <View style={{ height: 40 }} />
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  center:  { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, marginTop: 40 },
  emptyTxt:{ fontSize: 15, color: colors.textMuted, textAlign: "center" },
  header:  { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
             paddingBottom: 16, paddingHorizontal: 20,
             flexDirection: "row", alignItems: "center", justifyContent: "space-between",
             borderBottomWidth: 1, borderBottomColor: colors.border },
  title:   { fontSize: 20, fontWeight: "900", color: colors.text },
  addBtn:  { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  addBtnText: { color: "white", fontWeight: "800", fontSize: 14 },
  list:    { padding: 16, gap: 10 },
  row:     { backgroundColor: "white", borderRadius: 14, padding: 16,
             flexDirection: "row", alignItems: "center",
             shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  rowLeft: { flex: 1 },
  rowTop:  { flexDirection: "row", alignItems: "center", justifyContent: "space-between", marginBottom: 6 },
  rowTitle:{ fontSize: 15, fontWeight: "800", color: colors.text, flex: 1, marginRight: 8 },
  rowMeta: { flexDirection: "row", flexWrap: "wrap", gap: 6 },
  tag:     { fontSize: 11, color: colors.textMuted, backgroundColor: "#f0f0f0", borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3 },
  actions: { flexDirection: "row", gap: 8, marginLeft: 8 },
  editBtn: { backgroundColor: colors.brandLight, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 7 },
  editTxt: { color: colors.brand, fontWeight: "700", fontSize: 13 },
  delBtn:  { backgroundColor: "#fee2e2", borderRadius: 8, paddingHorizontal: 10, paddingVertical: 7 },
  delTxt:  { color: colors.danger, fontWeight: "800", fontSize: 14 },
});
const m = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { flexDirection: "row", justifyContent: "space-between", alignItems: "center",
            padding: 20, paddingTop: Platform.OS === "ios" ? 56 : 20,
            backgroundColor: "white", borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  close:  { fontSize: 22, color: colors.textMuted, fontWeight: "700" },
  body:   { padding: 20 },
  label:  { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  search: { backgroundColor: "#f0f0f0", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 10,
            fontSize: 14, color: colors.text, marginBottom: 10 },
  wsRow:  { borderWidth: 2, borderColor: colors.border, borderRadius: 10, padding: 12, marginBottom: 8 },
  wsRowA: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  wsRowTxt: { fontSize: 14, fontWeight: "700", color: colors.text },
  wsRowSub: { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  toggleRow: { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 20 },
});
