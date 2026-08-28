/**
 * Admin Worksheet Manager
 * List · search · grade filter · toggle published · edit · create · soft-delete
 */
import React, { useState, useRef } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Modal, Switch, Platform,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi }  from "../../../api/admin";
import { confirmAction } from "../../../utils/confirm";
import { colors, GRADES, SUBJECT_META } from "../../../constants/theme";
import { Input }     from "../../../components/ui/Input";
import { Button }    from "../../../components/ui/Button";

const SUBJECTS = Object.entries(SUBJECT_META).map(([slug, m]) => ({
  slug, label: m.label, icon: m.icon, subjectId: m.subjectId,
}));

const CONTENT_TYPES = [
  { value: "worksheet", label: "📋 Worksheet" },
  { value: "coloring",  label: "🎨 Coloring page" },
  { value: "mini_book", label: "📚 Mini-book" },
  { value: "workbook",  label: "📕 Workbook" },
];

const INTERESTS = [
  { value: "animals",   label: "🦁 Animals" },
  { value: "dinosaurs", label: "🦕 Dinosaurs" },
  { value: "space",     label: "🚀 Space" },
  { value: "ocean",     label: "🌊 Ocean" },
  { value: "fantasy",   label: "🐉 Fantasy" },
  { value: "vehicles",  label: "🚗 Vehicles" },
  { value: "holidays",  label: "🎉 Holidays" },
  { value: "sports",    label: "⚽ Sports" },
  { value: "nature",    label: "🌿 Nature" },
];

const SOCIAL_BADGES = [
  { value: "instagram", label: "📷 Instagram" },
  { value: "tiktok",    label: "🎵 TikTok" },
  { value: "teachers",  label: "🍎 Teachers" },
];

const blank = () => ({
  title: "", description: "", subject_id: 3, grade_id: 2,
  language_id: 1, difficulty_id: 2, estimated_min: 20,
  teacher_name: "", pdf_url: "", thumbnail_url: "", is_published: true,
  content_type: "worksheet", interest_tag: undefined as string | undefined,
  page_count: undefined as number | undefined,
  social_badge: undefined as string | undefined, is_trending: false,
  is_free: false, pdf_generator_key: undefined as string | undefined,
});

export default function WorksheetManager() {
  const qc = useQueryClient();
  const [search,   setSearch]   = useState("");
  const [modal,    setModal]    = useState<"create"|"edit"|null>(null);
  const [editing,  setEditing]  = useState<any>(null);
  const [form,     setForm]     = useState<any>(blank());
  const [gradeTab, setGradeTab] = useState<number|null>(null);
  const [uploading, setUploading] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  const { data: worksheets = [], isLoading } = useQuery({
    queryKey: ["adminWorksheets"],
    queryFn:  () => adminApi.listWorksheets(),
    staleTime: 30_000,
    placeholderData: [],
  });

  const inv = () => qc.invalidateQueries({ queryKey: ["adminWorksheets"] });

  const { mutate: create, isPending: creating } = useMutation({
    mutationFn: (body: any) => adminApi.createWorksheet(body),
    onSuccess:  () => { setModal(null); setForm(blank()); inv(); },
    onError:    (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: update, isPending: updating } = useMutation({
    mutationFn: ({ id, body }: any) => adminApi.updateWorksheet(id, body),
    onSuccess:  () => { setModal(null); setEditing(null); inv(); },
    onError:    (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: remove } = useMutation({
    mutationFn: (id: number) => adminApi.deleteWorksheet(id),
    onSuccess: inv,
    onError:   (e: any) => Alert.alert("Error", e.message),
  });
  const { mutate: togglePublish } = useMutation({
    mutationFn: ({ id, val }: any) => adminApi.updateWorksheet(id, { is_published: val }),
    onSuccess: inv,
  });
  const { mutate: toggleFree } = useMutation({
    mutationFn: ({ id, val }: any) => adminApi.updateWorksheet(id, { is_free: val }),
    onSuccess: inv,
  });

  const filtered = (worksheets as any[]).filter(w => {
    const matchS = !search   || w.title?.toLowerCase().includes(search.toLowerCase());
    const matchG = gradeTab === null || w.grade_id === gradeTab;
    return matchS && matchG;
  });

  const openEdit = (ws: any) => {
    setForm({
      title: ws.title ?? "", description: ws.description ?? "",
      subject_id: ws.subject_id ?? 3, grade_id: ws.grade_id ?? 2,
      language_id: ws.language_id ?? 1, difficulty_id: ws.difficulty_id ?? 2,
      estimated_min: ws.estimated_min ?? 20,
      teacher_name: ws.teacher_name ?? "", pdf_url: ws.pdf_url ?? "",
      thumbnail_url: ws.thumbnail_url ?? "", is_published: !!ws.is_published,
      content_type: ws.content_type ?? "worksheet", interest_tag: ws.interest_tag ?? undefined,
      page_count: ws.page_count ?? undefined,
      social_badge: ws.social_badge ?? undefined, is_trending: !!ws.is_trending,
      is_free: !!ws.is_free, pdf_generator_key: ws.pdf_generator_key ?? undefined,
    });
    setEditing(ws); setModal("edit");
  };

  const confirmDelete = (ws: any) =>
    Alert.alert(`Unpublish "${ws.title}"?`, "Users won't see it.", [
      { text: "Cancel", style: "cancel" },
      { text: "Unpublish", style: "destructive",
        onPress: () => remove(ws.worksheet_id) },
    ]);

  const save = () => {
    if (!form.title.trim()) { Alert.alert("Title is required"); return; }
    modal === "edit" && editing
      ? update({ id: editing.worksheet_id, body: form })
      : create(form);
  };

  const pickFile = () => {
    if (Platform.OS !== "web") {
      Alert.alert("Not available", "File upload is only available on the web admin panel right now. Paste a PDF URL instead.");
      return;
    }
    fileInputRef.current?.click();
  };

  const onFileSelected = async (e: any) => {
    const file: File | undefined = e.target.files?.[0];
    e.target.value = "";
    if (!file) return;
    if (file.type !== "application/pdf") {
      Alert.alert("Invalid file", "Please choose a PDF file.");
      return;
    }
    if (file.size > 20 * 1024 * 1024) {
      Alert.alert("File too large", "Max size is 20MB.");
      return;
    }
    setUploading(true);
    try {
      const res = await adminApi.uploadFile(file);
      setForm((f: any) => ({ ...f, pdf_url: res.url }));
    } catch (err: any) {
      Alert.alert("Upload failed", err.message);
    } finally {
      setUploading(false);
    }
  };

  return (
    <View style={s.root}>
      <View style={s.header}>
        <Text style={s.title}>📋 Worksheets</Text>
        <TouchableOpacity style={s.addBtn}
          onPress={() => { setForm(blank()); setModal("create"); }}>
          <Text style={s.addBtnText}>+ New</Text>
        </TouchableOpacity>
      </View>

      <View style={s.searchWrap}>
        <TextInput style={s.search} placeholder="Search worksheets…"
          placeholderTextColor={colors.textMuted}
          value={search} onChangeText={setSearch} />
      </View>

      <ScrollView horizontal showsHorizontalScrollIndicator={false}
        style={s.gradeScroll} contentContainerStyle={s.gradeScrollContent}>
        <TouchableOpacity style={[s.gradeTab, gradeTab===null && s.gradeTabActive]}
          onPress={() => setGradeTab(null)}>
          <Text style={[s.gradeTabTxt, gradeTab===null && s.gradeTabTxtA]}>All</Text>
        </TouchableOpacity>
        {GRADES.map(g => (
          <TouchableOpacity key={g.grade_id}
            style={[s.gradeTab, gradeTab===g.grade_id && s.gradeTabActive]}
            onPress={() => setGradeTab(g.grade_id)}>
            <Text style={[s.gradeTabTxt, gradeTab===g.grade_id && s.gradeTabTxtA]}>
              {g.label}
            </Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {isLoading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.list} showsVerticalScrollIndicator={false}>
          {filtered.length === 0 && (
            <View style={s.center}>
              <Text style={{ fontSize: 40, marginBottom: 12 }}>📭</Text>
              <Text style={s.emptyTxt}>No worksheets match this filter.</Text>
            </View>
          )}
          {filtered.map((ws: any) => (
            <View key={ws.worksheet_id} style={s.row}>
              <View style={s.rowLeft}>
                <View style={s.rowTop}>
                  <Text style={s.rowTitle} numberOfLines={1}>{ws.title}</Text>
                  <Switch value={!!ws.is_published}
                    onValueChange={val => togglePublish({ id: ws.worksheet_id, val })}
                    thumbColor={ws.is_published ? colors.brand : "#ccc"}
                    trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
                </View>
                <View style={s.rowMeta}>
                  <Text style={s.tag}>Grade {ws.grade_id}</Text>
                  {ws.content_type && ws.content_type !== "worksheet" && (
                    <Text style={s.tag}>{CONTENT_TYPES.find(c => c.value === ws.content_type)?.label ?? ws.content_type}</Text>
                  )}
                  {ws.estimated_min && <Text style={s.tag}>⏱ {ws.estimated_min}m</Text>}
                  {ws.teacher_name  && <Text style={s.tag}>👩‍🏫 {ws.teacher_name}</Text>}
                  {!!ws.is_trending && <Text style={s.tag}>🔥 Trending</Text>}
                  <Text style={[s.tag, ws.is_published ? s.pub : s.unpub]}>
                    {ws.is_published ? "Published" : "Hidden"}
                  </Text>
                  {!ws.pdf_url && !ws.pdf_generator_key && (
                    <Text style={[s.tag, s.unpub]}>No PDF</Text>
                  )}
                </View>
                <View style={[s.rowMeta, { marginTop: 6 }]}>
                  <TouchableOpacity onPress={() => toggleFree({ id: ws.worksheet_id, val: !ws.is_free })}>
                    <Text style={[s.tag, ws.is_free ? s.pub : s.unpub]}>
                      {ws.is_free ? "✓ Free (printable without signup)" : "Mark as free"}
                    </Text>
                  </TouchableOpacity>
                </View>
              </View>
              <View style={s.actions}>
                <TouchableOpacity style={s.editBtn} onPress={() => openEdit(ws)}>
                  <Text style={s.editTxt}>Edit</Text>
                </TouchableOpacity>
                <TouchableOpacity style={s.delBtn} onPress={() => confirmDelete(ws)}>
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
            <Text style={m.title}>{modal === "edit" ? "Edit Worksheet" : "New Worksheet"}</Text>
            <TouchableOpacity onPress={() => { setModal(null); setEditing(null); }}>
              <Text style={m.close}>✕</Text>
            </TouchableOpacity>
          </View>
          <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
            <Input label="Title *" value={form.title}
              onChangeText={v => setForm((f: any) => ({ ...f, title: v }))}
              placeholder="e.g. 2-Digit Addition Review" />
            <Input label="Description" value={form.description}
              onChangeText={v => setForm((f: any) => ({ ...f, description: v }))}
              placeholder="Short description for parents" multiline />
            <Input label="PDF URL" value={form.pdf_url}
              onChangeText={v => setForm((f: any) => ({ ...f, pdf_url: v }))}
              placeholder="https://…/worksheet.pdf"
              autoCapitalize="none" keyboardType="url" />
            <View style={m.uploadRow}>
              <TouchableOpacity style={m.uploadBtn} onPress={pickFile} disabled={uploading}>
                <Text style={m.uploadBtnText}>{uploading ? "Uploading…" : "📁 Upload PDF from device"}</Text>
              </TouchableOpacity>
              {form.pdf_url ? (
                <Text style={m.uploadHint} numberOfLines={1}>{form.pdf_url}</Text>
              ) : null}
            </View>
            {Platform.OS === "web" && React.createElement("input", {
              ref: fileInputRef,
              type: "file",
              accept: "application/pdf",
              style: { display: "none" },
              onChange: onFileSelected,
            })}
            <Input label="Teacher name" value={form.teacher_name}
              onChangeText={v => setForm((f: any) => ({ ...f, teacher_name: v }))}
              placeholder="e.g. Ms. Chen" />
            <Input label="Estimated minutes" value={String(form.estimated_min)}
              onChangeText={v => setForm((f: any) => ({ ...f, estimated_min: parseInt(v)||20 }))}
              keyboardType="number-pad" />

            <Text style={m.label}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id}
                  style={[m.chip, form.grade_id===g.grade_id && m.chipA]}
                  onPress={() => setForm((f: any) => ({ ...f, grade_id: g.grade_id }))}>
                  <Text style={[m.chipTxt, form.grade_id===g.grade_id && m.chipTxtA]}>{g.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <Text style={m.label}>Subject</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {SUBJECTS.map(sub => (
                <TouchableOpacity key={sub.slug}
                  style={[m.chip, form.subject_id===sub.subjectId && m.chipA]}
                  onPress={() => setForm((f: any) => ({ ...f, subject_id: sub.subjectId }))}>
                  <Text style={[m.chipTxt, form.subject_id===sub.subjectId && m.chipTxtA]}>
                    {sub.icon} {sub.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <Text style={m.label}>Content type</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {CONTENT_TYPES.map(ct => (
                <TouchableOpacity key={ct.value}
                  style={[m.chip, form.content_type===ct.value && m.chipA]}
                  onPress={() => setForm((f: any) => ({ ...f, content_type: ct.value }))}>
                  <Text style={[m.chipTxt, form.content_type===ct.value && m.chipTxtA]}>{ct.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <Text style={m.label}>Interest tag (optional)</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              <TouchableOpacity
                style={[m.chip, !form.interest_tag && m.chipA]}
                onPress={() => setForm((f: any) => ({ ...f, interest_tag: undefined }))}>
                <Text style={[m.chipTxt, !form.interest_tag && m.chipTxtA]}>None</Text>
              </TouchableOpacity>
              {INTERESTS.map(it => (
                <TouchableOpacity key={it.value}
                  style={[m.chip, form.interest_tag===it.value && m.chipA]}
                  onPress={() => setForm((f: any) => ({ ...f, interest_tag: it.value }))}>
                  <Text style={[m.chipTxt, form.interest_tag===it.value && m.chipTxtA]}>{it.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <Text style={m.label}>Social badge (optional)</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              <TouchableOpacity
                style={[m.chip, !form.social_badge && m.chipA]}
                onPress={() => setForm((f: any) => ({ ...f, social_badge: undefined }))}>
                <Text style={[m.chipTxt, !form.social_badge && m.chipTxtA]}>None</Text>
              </TouchableOpacity>
              {SOCIAL_BADGES.map(sb => (
                <TouchableOpacity key={sb.value}
                  style={[m.chip, form.social_badge===sb.value && m.chipA]}
                  onPress={() => setForm((f: any) => ({ ...f, social_badge: sb.value }))}>
                  <Text style={[m.chipTxt, form.social_badge===sb.value && m.chipTxtA]}>{sb.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <Input label="Page count (optional)" value={form.page_count ? String(form.page_count) : ""}
              onChangeText={v => setForm((f: any) => ({ ...f, page_count: v ? parseInt(v) || undefined : undefined }))}
              keyboardType="number-pad" placeholder="e.g. 8" />

            <View style={m.toggleRow}>
              <Text style={m.label}>Trending</Text>
              <Switch value={!!form.is_trending}
                onValueChange={v => setForm((f: any) => ({ ...f, is_trending: v }))}
                thumbColor={form.is_trending ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
            </View>

            <View style={m.toggleRow}>
              <Text style={m.label}>Published</Text>
              <Switch value={form.is_published}
                onValueChange={v => setForm((f: any) => ({ ...f, is_published: v }))}
                thumbColor={form.is_published ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
            </View>

            <View style={m.toggleRow}>
              <Text style={m.label}>Free — printable without signup</Text>
              <Switch value={!!form.is_free}
                onValueChange={v => setForm((f: any) => ({ ...f, is_free: v }))}
                thumbColor={form.is_free ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }} />
            </View>
            {form.is_free && !form.pdf_url && !form.pdf_generator_key && (
              <Text style={{ fontSize: 12, color: colors.danger, marginTop: -8, marginBottom: 12 }}>
                ⚠️ No PDF uploaded yet — this worksheet won't actually be printable until you attach one above.
              </Text>
            )}

            <Button
              label={creating||updating ? "Saving…" : modal==="edit" ? "Save changes" : "Create worksheet"}
              onPress={save} loading={creating||updating} fullWidth style={{ marginTop: 8 }} />
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
  header:  { backgroundColor: "white", paddingTop: Platform.OS==="ios" ? 56 : 20,
             paddingBottom: 16, paddingHorizontal: 20,
             flexDirection: "row", alignItems: "center", justifyContent: "space-between",
             borderBottomWidth: 1, borderBottomColor: colors.border },
  title:   { fontSize: 20, fontWeight: "900", color: colors.text },
  addBtn:  { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  addBtnText: { color: "white", fontWeight: "800", fontSize: 14 },
  searchWrap: { backgroundColor: "white", paddingHorizontal: 16, paddingVertical: 10,
                borderBottomWidth: 1, borderBottomColor: colors.border },
  search:     { backgroundColor: "#f0f0f0", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 10, fontSize: 14, color: colors.text },
  gradeScroll: { backgroundColor: "white",
                 borderBottomWidth: 1, borderBottomColor: colors.border },
  gradeScrollContent: { paddingVertical: 8, paddingHorizontal: 12, alignItems: "center" },
  gradeTab:    { paddingHorizontal: 14, paddingVertical: 6, borderRadius: 16, marginRight: 6, backgroundColor: "#f0f0f0" },
  gradeTabActive: { backgroundColor: colors.brand },
  gradeTabTxt: { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  gradeTabTxtA:{ color: "white" },
  list:    { padding: 16, gap: 10 },
  row:     { backgroundColor: "white", borderRadius: 14, padding: 16,
             flexDirection: "row", alignItems: "center",
             shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  rowLeft: { flex: 1 },
  rowTop:  { flexDirection: "row", alignItems: "center", justifyContent: "space-between", marginBottom: 6 },
  rowTitle:{ fontSize: 15, fontWeight: "800", color: colors.text, flex: 1, marginRight: 8 },
  rowMeta: { flexDirection: "row", flexWrap: "wrap", gap: 6 },
  tag:     { fontSize: 11, color: colors.textMuted, backgroundColor: "#f0f0f0", borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3 },
  pub:     { backgroundColor: "#dcfce7", color: "#16a34a" },
  unpub:   { backgroundColor: "#fee2e2", color: "#dc2626" },
  actions: { flexDirection: "row", gap: 8, marginLeft: 8 },
  editBtn: { backgroundColor: colors.brandLight, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 7 },
  editTxt: { color: colors.brand, fontWeight: "700", fontSize: 13 },
  delBtn:  { backgroundColor: "#fee2e2", borderRadius: 8, paddingHorizontal: 10, paddingVertical: 7 },
  delTxt:  { color: colors.danger, fontWeight: "800", fontSize: 14 },
});
const m = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: { flexDirection: "row", justifyContent: "space-between", alignItems: "center",
            padding: 20, paddingTop: Platform.OS==="ios" ? 56 : 20,
            backgroundColor: "white", borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  close:  { fontSize: 22, color: colors.textMuted, fontWeight: "700" },
  body:   { padding: 20 },
  label:  { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  chip:    { borderWidth: 2, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6, marginRight: 6 },
  chipA:   { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipTxt: { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  chipTxtA:{ color: colors.brand },
  toggleRow: { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 20 },
  uploadRow: { flexDirection: "row", alignItems: "center", gap: 10, marginTop: -8, marginBottom: 16, flexWrap: "wrap" },
  uploadBtn: { backgroundColor: colors.brandLight, borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8 },
  uploadBtnText: { color: colors.brand, fontWeight: "700", fontSize: 13 },
  uploadHint: { fontSize: 12, color: colors.textMuted, flexShrink: 1 },
});
