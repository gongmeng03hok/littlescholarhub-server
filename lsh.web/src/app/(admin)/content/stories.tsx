/**
 * Admin Story Manager
 * List · create · edit · soft-delete
 * POST/PUT/DELETE /api/admin/stories
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Modal, Switch, Platform,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi }    from "../../../api/admin";
import { confirmAction } from "../../../utils/confirm";
import { colors, GRADES } from "../../../constants/theme";
import { Input }       from "../../../components/ui/Input";
import { Button }      from "../../../components/ui/Button";

const TRACKS = ["universal","gita","chinese","hispanic"];
const LANGS  = [
  { id: 1, label: "English" }, { id: 2, label: "中文" },
  { id: 3, label: "हिन्दी" },  { id: 4, label: "Español" },
];

const blank = () => ({
  title: "", body_text: "", grade_id: 2, language_id: 1,
  read_min: 5, theme_tag: "", vocab_json: "[]",
  audio_url: "", is_published: true,
});

export default function StoryManager() {
  const qc = useQueryClient();
  const [search,  setSearch]  = useState("");
  const [modal,   setModal]   = useState<"create"|"edit"|null>(null);
  const [editing, setEditing] = useState<any>(null);
  const [form,    setForm]    = useState<any>(blank());
  const [vocabErr,setVocabErr]= useState("");

  const { data: stories = [], isLoading } = useQuery({
    queryKey: ["adminStories"],
    queryFn:  () => adminApi.listStories(),
    staleTime: 30_000,
    placeholderData: [],
  });

  const invalidate = () => qc.invalidateQueries({ queryKey: ["adminStories"] });

  const { mutate: create, isPending: creating } = useMutation({
    mutationFn: (body: any) => adminApi.createStory(body),
    onSuccess: () => { setModal(null); setForm(blank()); invalidate(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const { mutate: update, isPending: updating } = useMutation({
    mutationFn: ({ id, body }: any) => adminApi.updateStory(id, body),
    onSuccess: () => { setModal(null); setEditing(null); invalidate(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const { mutate: remove } = useMutation({
    mutationFn: (id: number) => adminApi.deleteStory(id),
    onSuccess: invalidate,
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const { mutate: generateAudio, isPending: generatingAudio } = useMutation({
    mutationFn: (id: number) => adminApi.generateStoryAudio(id),
    onSuccess: (res: any) => {
      setForm((f: any) => ({ ...f, audio_url: res.audio_url }));
      invalidate();
      Alert.alert("Read-aloud generated!", "The narration audio has been attached to this story.");
    },
    onError: (e: any) => Alert.alert("Couldn't generate audio", e.message),
  });

  // Upload a real PDF story — text is extracted server-side and read-aloud
  // audio is generated automatically.
  const [uploadOpen, setUploadOpen] = useState(false);
  const [uploadFile, setUploadFile] = useState<{ file: any; name: string } | null>(null);
  const [uploadTitle, setUploadTitle] = useState("");
  const [uploadGradeId, setUploadGradeId] = useState(2);
  const [uploadTheme, setUploadTheme] = useState("");

  const { mutate: uploadPdf, isPending: uploadingPdf } = useMutation({
    mutationFn: () => adminApi.uploadStoryPdf({
      file: uploadFile!.file, filename: uploadFile!.name,
      title: uploadTitle.trim(), grade_id: uploadGradeId, theme_tag: uploadTheme.trim() || undefined,
    }),
    onSuccess: (res: any) => {
      setUploadOpen(false);
      invalidate();
      Alert.alert(
        "Story uploaded!",
        res.audio_url
          ? "Text was extracted and read-aloud audio was generated automatically."
          : "Text was extracted, but audio generation failed — you can retry it from Edit."
      );
    },
    onError: (e: any) => Alert.alert("Upload failed", e.message),
  });

  const openUpload = () => {
    setUploadFile(null);
    setUploadTitle("");
    setUploadGradeId(2);
    setUploadTheme("");
    setUploadOpen(true);
  };

  const pickPdf = () => {
    if (Platform.OS === "web") {
      const input = document.createElement("input");
      input.type = "file";
      input.accept = "application/pdf";
      input.onchange = () => {
        const f = input.files?.[0];
        if (f) setUploadFile({ file: f, name: f.name });
      };
      input.click();
      return;
    }
    Alert.alert("Web only for now", "PDF story upload is available on the web admin panel.");
  };

  const submitUpload = () => {
    if (!uploadFile)          { Alert.alert("Choose a PDF file first"); return; }
    if (!uploadTitle.trim())  { Alert.alert("Title is required"); return; }
    uploadPdf();
  };

  const openEdit = (story: any) => {
    setForm({
      title: story.title ?? "",
      body_text: story.body_text ?? "",
      grade_id: story.grade_id ?? 2,
      language_id: story.language_id ?? 1,
      read_min: story.read_min ?? 5,
      theme_tag: story.theme_tag ?? "",
      vocab_json: Array.isArray(story.vocab_json)
        ? JSON.stringify(story.vocab_json, null, 2)
        : (story.vocab_json ?? "[]"),
      audio_url: story.audio_url ?? "",
      is_published: !!story.is_published,
    });
    setEditing(story);
    setModal("edit");
  };

  const confirmDelete = (story: any) => {
    Alert.alert(`Unpublish "${story.title}"?`, "Users won't see it any more.", [
      { text: "Cancel", style: "cancel" },
      { text: "Unpublish", style: "destructive", onPress: () => remove(story.story_id) },
    ]);
  };

  const save = () => {
    if (!form.title.trim())     { Alert.alert("Title is required"); return; }
    if (!form.body_text.trim()) { Alert.alert("Body text is required"); return; }
    // Validate vocab JSON
    try {
      JSON.parse(form.vocab_json || "[]");
      setVocabErr("");
    } catch {
      setVocabErr("Vocab must be valid JSON array");
      return;
    }
    const body = { ...form, vocab_json: form.vocab_json };
    if (modal === "edit" && editing) {
      update({ id: editing.story_id, body });
    } else {
      create(body);
    }
  };

  const filtered = (stories as any[]).filter(s =>
    !search || s.title?.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <View style={s.root}>
      {/* Header */}
      <View style={s.header}>
        <Text style={s.title}>📖 Stories</Text>
        <View style={{ flexDirection: "row", gap: 8 }}>
          <TouchableOpacity style={s.uploadBtn} onPress={openUpload}>
            <Text style={s.uploadBtnText}>📄 Upload PDF</Text>
          </TouchableOpacity>
          <TouchableOpacity style={s.addBtn} onPress={() => { setForm(blank()); setModal("create"); }}>
            <Text style={s.addBtnText}>+ New</Text>
          </TouchableOpacity>
        </View>
      </View>

      {/* Search */}
      <View style={s.searchWrap}>
        <TextInput
          style={s.search} placeholder="Search stories…"
          placeholderTextColor={colors.textMuted}
          value={search} onChangeText={setSearch}
        />
      </View>

      {/* List */}
      {isLoading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.list} showsVerticalScrollIndicator={false}>
          {filtered.length === 0 && (
            <View style={s.center}>
              <Text style={{ fontSize: 40, marginBottom: 12 }}>📭</Text>
              <Text style={s.emptyText}>No stories yet. Create the first one!</Text>
            </View>
          )}
          {filtered.map((story: any) => (
            <View key={story.story_id} style={s.row}>
              <View style={s.rowLeft}>
                <Text style={s.rowTitle} numberOfLines={1}>{story.title}</Text>
                <View style={s.rowMeta}>
                  <Text style={s.metaTag}>Grade {story.grade_id}</Text>
                  {story.read_min  && <Text style={s.metaTag}>⏱ {story.read_min}m</Text>}
                  {story.theme_tag && <Text style={s.metaTag}>🏷 {story.theme_tag}</Text>}
                  {story.audio_url && <Text style={s.metaTag}>🔊 Audio</Text>}
                  {story.pdf_url && <Text style={s.metaTag}>📄 PDF</Text>}
                  <Text style={[s.metaTag, story.is_published ? s.published : s.unpublished]}>
                    {story.is_published ? "Published" : "Hidden"}
                  </Text>
                </View>
              </View>
              <View style={s.rowActions}>
                <TouchableOpacity style={s.editBtn} onPress={() => openEdit(story)}>
                  <Text style={s.editBtnText}>Edit</Text>
                </TouchableOpacity>
                <TouchableOpacity style={s.delBtn} onPress={() => confirmDelete(story)}>
                  <Text style={s.delBtnText}>✕</Text>
                </TouchableOpacity>
              </View>
            </View>
          ))}
          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      {/* Modal */}
      <Modal visible={!!modal} animationType="slide" presentationStyle="pageSheet">
        <View style={m.root}>
          <View style={m.header}>
            <Text style={m.title}>{modal === "edit" ? "Edit Story" : "New Story"}</Text>
            <TouchableOpacity onPress={() => { setModal(null); setEditing(null); }}>
              <Text style={m.close}>✕</Text>
            </TouchableOpacity>
          </View>
          <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
            <Input label="Title *" value={form.title}
              onChangeText={v => setForm((f: any) => ({ ...f, title: v }))}
              placeholder="e.g. Kai and the Dragon" />
            <Input label="Body text *" value={form.body_text}
              onChangeText={v => setForm((f: any) => ({ ...f, body_text: v }))}
              placeholder="Story content…" multiline
              style={{ minHeight: 160, textAlignVertical: "top" }} />
            <Input label="Theme tag" value={form.theme_tag}
              onChangeText={v => setForm((f: any) => ({ ...f, theme_tag: v }))}
              placeholder="e.g. lunar-new-year" />
            <Input label="Audio URL (optional)" value={form.audio_url}
              onChangeText={v => setForm((f: any) => ({ ...f, audio_url: v }))}
              placeholder="https://…/audio.mp3" autoCapitalize="none" keyboardType="url" />
            {modal === "edit" && editing && (
              <TouchableOpacity
                style={[m.audioBtn, generatingAudio && m.audioBtnDim]}
                disabled={generatingAudio}
                onPress={() => generateAudio(editing.story_id)}
              >
                <Text style={m.audioBtnText}>
                  {generatingAudio ? "Generating…" : "🔊 Generate Read-Aloud from Body Text"}
                </Text>
              </TouchableOpacity>
            )}
            <Input label="Read time (minutes)" value={String(form.read_min)}
              onChangeText={v => setForm((f: any) => ({ ...f, read_min: parseInt(v) || 5 }))}
              keyboardType="number-pad" />

            {/* Vocab JSON editor */}
            <Text style={m.label}>Vocab JSON (array of {"{word, definition}"})</Text>
            <TextInput
              style={[m.jsonInput, vocabErr ? m.jsonInputErr : null]}
              value={form.vocab_json}
              onChangeText={v => { setForm((f: any) => ({ ...f, vocab_json: v })); setVocabErr(""); }}
              multiline placeholder={'[\n  {"word":"radiant","definition":"bright and glowing"}\n]'}
              placeholderTextColor={colors.textMuted}
            />
            {vocabErr ? <Text style={m.jsonErr}>{vocabErr}</Text> : null}

            {/* Grade */}
            <Text style={m.label}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id}
                  style={[m.chip, form.grade_id === g.grade_id && m.chipActive]}
                  onPress={() => setForm((f: any) => ({ ...f, grade_id: g.grade_id }))}
                >
                  <Text style={[m.chipText, form.grade_id === g.grade_id && m.chipTextActive]}>
                    {g.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            {/* Language */}
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

            {/* Published */}
            <View style={m.toggleRow}>
              <Text style={m.label}>Published</Text>
              <Switch
                value={form.is_published}
                onValueChange={v => setForm((f: any) => ({ ...f, is_published: v }))}
                thumbColor={form.is_published ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }}
              />
            </View>

            <Button label={creating || updating ? "Saving…" : modal === "edit" ? "Save changes" : "Create story"}
              onPress={save} loading={creating || updating} fullWidth />
            <View style={{ height: 40 }} />
          </ScrollView>
        </View>
      </Modal>

      {/* Upload PDF modal */}
      <Modal visible={uploadOpen} animationType="slide" presentationStyle="pageSheet">
        <View style={m.root}>
          <View style={m.header}>
            <Text style={m.title}>Upload PDF Story</Text>
            <TouchableOpacity onPress={() => setUploadOpen(false)}>
              <Text style={m.close}>✕</Text>
            </TouchableOpacity>
          </View>
          <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
            <Text style={m.uploadHint}>
              Text is extracted from the PDF automatically and read-aloud audio is generated
              right after upload — no manual typing needed.
            </Text>

            <TouchableOpacity style={m.filePickBtn} onPress={pickPdf}>
              <Text style={m.filePickBtnText}>
                {uploadFile ? `📄 ${uploadFile.name}` : "Choose a PDF file…"}
              </Text>
            </TouchableOpacity>

            <Input label="Title *" value={uploadTitle} onChangeText={setUploadTitle}
              placeholder="e.g. The Brave Little Boat" />
            <Input label="Theme tag (optional)" value={uploadTheme} onChangeText={setUploadTheme}
              placeholder="e.g. lunar-new-year" />

            <Text style={m.label}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity key={g.grade_id}
                  style={[m.chip, uploadGradeId === g.grade_id && m.chipActive]}
                  onPress={() => setUploadGradeId(g.grade_id)}
                >
                  <Text style={[m.chipText, uploadGradeId === g.grade_id && m.chipTextActive]}>
                    {g.label}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <Button label={uploadingPdf ? "Uploading…" : "Upload & Generate Read-Aloud"}
              onPress={submitUpload} loading={uploadingPdf} fullWidth />
            <View style={{ height: 40 }} />
          </ScrollView>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root: { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, marginTop: 40 },
  emptyText: { fontSize: 15, color: colors.textMuted, textAlign: "center" },
  header: { backgroundColor: "white", paddingTop: Platform.OS === "ios" ? 56 : 20,
            paddingBottom: 16, paddingHorizontal: 20,
            flexDirection: "row", alignItems: "center", justifyContent: "space-between",
            borderBottomWidth: 1, borderBottomColor: colors.border },
  title:  { fontSize: 20, fontWeight: "900", color: colors.text },
  addBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 8 },
  addBtnText: { color: "white", fontWeight: "800", fontSize: 14 },
  uploadBtn: { backgroundColor: "white", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 8,
               borderWidth: 1.5, borderColor: colors.brand },
  uploadBtnText: { color: colors.brand, fontWeight: "800", fontSize: 14 },
  searchWrap: { backgroundColor: "white", paddingHorizontal: 16, paddingVertical: 10,
                borderBottomWidth: 1, borderBottomColor: colors.border },
  search: { backgroundColor: "#f0f0f0", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 10, fontSize: 14, color: colors.text },
  list:   { padding: 16, gap: 10 },
  row:    { backgroundColor: "white", borderRadius: 14, padding: 16,
            flexDirection: "row", alignItems: "center",
            shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  rowLeft: { flex: 1 },
  rowTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginBottom: 6 },
  rowMeta:  { flexDirection: "row", flexWrap: "wrap", gap: 6 },
  metaTag:  { fontSize: 11, color: colors.textMuted, backgroundColor: "#f0f0f0",
              borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3 },
  published:   { backgroundColor: "#dcfce7", color: "#16a34a" },
  unpublished: { backgroundColor: "#fee2e2", color: "#dc2626" },
  rowActions: { flexDirection: "row", gap: 8, marginLeft: 8 },
  editBtn:    { backgroundColor: colors.brandLight, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 7 },
  editBtnText:{ color: colors.brand, fontWeight: "700", fontSize: 13 },
  delBtn:     { backgroundColor: "#fee2e2", borderRadius: 8, paddingHorizontal: 10, paddingVertical: 7 },
  delBtnText: { color: colors.danger, fontWeight: "800", fontSize: 14 },
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
  langRow:{ flexDirection: "row", flexWrap: "wrap", gap: 8, marginBottom: 16 },
  chip:        { borderWidth: 2, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6, marginRight: 6 },
  chipActive:  { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText:    { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  chipTextActive: { color: colors.brand },
  toggleRow:   { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 20 },
  jsonInput:   { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10, padding: 12,
                 fontFamily: "monospace", fontSize: 12, color: colors.text, minHeight: 120,
                 textAlignVertical: "top", marginBottom: 4, backgroundColor: "white" },
  jsonInputErr:{ borderColor: colors.danger },
  jsonErr:     { fontSize: 12, color: colors.danger, marginBottom: 12 },
  audioBtn:    { backgroundColor: colors.brandLight, borderRadius: 10, paddingVertical: 12,
                 alignItems: "center", marginTop: -8, marginBottom: 16 },
  audioBtnDim: { opacity: 0.6 },
  audioBtnText:{ color: colors.brand, fontWeight: "800", fontSize: 13 },
  uploadHint:  { fontSize: 12, color: colors.textMuted, marginBottom: 14, lineHeight: 18 },
  filePickBtn: { borderWidth: 1.5, borderColor: colors.border, borderStyle: "dashed", borderRadius: 12,
                 paddingVertical: 18, alignItems: "center", marginBottom: 12, backgroundColor: "#f8f7ff" },
  filePickBtnText: { fontSize: 14, fontWeight: "700", color: colors.text },
});
