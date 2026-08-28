/**
 * Admin Question Template Manager
 * GET/PUT /api/admin/questions
 * Edit template_text, params_json, options_json, answer_expr, difficulty, active flag
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Modal, Switch, Platform,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi }  from "../../../api/admin";
import { colors }    from "../../../constants/theme";
import { Input }     from "../../../components/ui/Input";
import { Button }    from "../../../components/ui/Button";

const DIFFICULTIES = ["Easy","Medium","Hard","Challenge"];
const TYPES = ["algorithmic","mcq","fill_blank","open_ended"];

export default function QuestionManager() {
  const qc = useQueryClient();
  const [search,  setSearch]  = useState("");
  const [subject, setSubject] = useState<string | null>(null);
  const [modal,   setModal]   = useState(false);
  const [editing, setEditing] = useState<any>(null);
  const [form,    setForm]    = useState<any>({});
  const [paramsErr, setParamsErr]  = useState("");
  const [optionsErr,setOptionsErr] = useState("");

  const { data: templates = [], isLoading } = useQuery({
    queryKey: ["adminQuestions"],
    queryFn:  () => adminApi.listQuestions(),
    staleTime: 60_000,
    placeholderData: [],
  });

  const invalidate = () => qc.invalidateQueries({ queryKey: ["adminQuestions"] });

  const { mutate: update, isPending: updating } = useMutation({
    mutationFn: ({ id, body }: any) => adminApi.updateQuestion(id, body),
    onSuccess: () => { setModal(false); invalidate(); },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const openEdit = (tmpl: any) => {
    setForm({
      template_text: tmpl.template_text ?? "",
      params_json:   typeof tmpl.params_json === "string"
        ? tmpl.params_json
        : JSON.stringify(tmpl.params_json ?? {}, null, 2),
      options_json:  typeof tmpl.options_json === "string"
        ? tmpl.options_json
        : JSON.stringify(tmpl.options_json ?? [], null, 2),
      answer_expr:   tmpl.answer_expr ?? "",
      template_type: tmpl.template_type ?? "algorithmic",
      is_active:     tmpl.is_active !== false,
    });
    setParamsErr(""); setOptionsErr("");
    setEditing(tmpl);
    setModal(true);
  };

  const save = () => {
    if (!form.template_text.trim()) { Alert.alert("Template text is required"); return; }
    try { JSON.parse(form.params_json || "{}"); setParamsErr(""); }
    catch { setParamsErr("Must be valid JSON object"); return; }
    try { JSON.parse(form.options_json || "[]"); setOptionsErr(""); }
    catch { setOptionsErr("Must be valid JSON array"); return; }
    update({ id: editing.template_id, body: form });
  };

  const allSubjects = [...new Set((templates as any[]).map(t => t.subject))].filter(Boolean);

  const filtered = (templates as any[]).filter(t => {
    const matchSearch = !search || t.template_text?.toLowerCase().includes(search.toLowerCase());
    const matchSub    = !subject || t.subject === subject;
    return matchSearch && matchSub;
  });

  return (
    <View style={s.root}>
      <View style={s.header}>
        <View>
          <Text style={s.title}>❓ Question Templates</Text>
          <Text style={s.sub}>Edit templates · toggle active · adjust params</Text>
        </View>
      </View>

      {/* Search + subject filter */}
      <View style={s.filters}>
        <TextInput style={s.search} placeholder="Search templates…"
          placeholderTextColor={colors.textMuted}
          value={search} onChangeText={setSearch} />
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 8 }}>
          <TouchableOpacity style={[s.subChip, !subject && s.subChipActive]}
            onPress={() => setSubject(null)}>
            <Text style={[s.subChipText, !subject && s.subChipTextActive]}>All</Text>
          </TouchableOpacity>
          {allSubjects.map(sub => (
            <TouchableOpacity key={sub}
              style={[s.subChip, subject === sub && s.subChipActive]}
              onPress={() => setSubject(subject === sub ? null : sub)}
            >
              <Text style={[s.subChipText, subject === sub && s.subChipTextActive]}>{sub}</Text>
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
              <Text style={{ fontSize: 40, marginBottom: 12 }}>❓</Text>
              <Text style={s.emptyText}>No question templates match.</Text>
            </View>
          )}
          {filtered.map((tmpl: any) => (
            <TouchableOpacity key={tmpl.template_id} style={s.row}
              onPress={() => openEdit(tmpl)} activeOpacity={0.85}>
              <View style={s.rowLeft}>
                <View style={s.rowTop}>
                  <View style={s.rowMeta}>
                    <Text style={s.metaTag}>{tmpl.subject}</Text>
                    <Text style={s.metaTag}>Gr {tmpl.grade_id}</Text>
                    <Text style={s.metaTag}>{tmpl.difficulty}</Text>
                    <Text style={s.metaTag}>{tmpl.template_type}</Text>
                  </View>
                  <View style={[s.activeDot, { backgroundColor: tmpl.is_active ? colors.success : "#ccc" }]} />
                </View>
                <Text style={s.rowText} numberOfLines={2}>{tmpl.template_text}</Text>
              </View>
              <Text style={s.rowArrow}>→</Text>
            </TouchableOpacity>
          ))}
          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      {/* Edit Modal */}
      <Modal visible={modal} animationType="slide" presentationStyle="pageSheet">
        <View style={m.root}>
          <View style={m.header}>
            <View>
              <Text style={m.title}>Edit Template</Text>
              {editing && (
                <Text style={m.sub}>#{editing.template_id} · {editing.subject} · Grade {editing.grade_id}</Text>
              )}
            </View>
            <TouchableOpacity onPress={() => setModal(false)}>
              <Text style={m.close}>✕</Text>
            </TouchableOpacity>
          </View>

          <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
            <Input label="Template text * (use {A}, {B} for variables)"
              value={form.template_text}
              onChangeText={v => setForm((f: any) => ({ ...f, template_text: v }))}
              placeholder="e.g. What is {A} + {B}?" multiline
              style={{ minHeight: 80, textAlignVertical: "top" }} />
            <Input label="Answer expression (Python eval, e.g. A+B)"
              value={form.answer_expr}
              onChangeText={v => setForm((f: any) => ({ ...f, answer_expr: v }))}
              placeholder="A + B" autoCapitalize="none" />

            <Text style={m.label}>Params JSON (for algorithmic templates)</Text>
            <TextInput
              style={[m.jsonInput, paramsErr ? m.jsonErr : null]}
              value={form.params_json}
              onChangeText={v => { setForm((f: any) => ({ ...f, params_json: v })); setParamsErr(""); }}
              multiline placeholder={'{"A":{"min":1,"max":10},"B":{"min":1,"max":10}}'}
              placeholderTextColor={colors.textMuted}
            />
            {paramsErr ? <Text style={m.errText}>{paramsErr}</Text> : null}

            <Text style={m.label}>Options JSON (for MCQ — array of strings)</Text>
            <TextInput
              style={[m.jsonInput, optionsErr ? m.jsonErr : null]}
              value={form.options_json}
              onChangeText={v => { setForm((f: any) => ({ ...f, options_json: v })); setOptionsErr(""); }}
              multiline placeholder={'["option 1","option 2","option 3","option 4"]'}
              placeholderTextColor={colors.textMuted}
            />
            {optionsErr ? <Text style={m.errText}>{optionsErr}</Text> : null}

            {/* Type picker */}
            <Text style={m.label}>Template type</Text>
            <View style={m.typeRow}>
              {TYPES.map(t => (
                <TouchableOpacity key={t}
                  style={[m.chip, form.template_type === t && m.chipActive]}
                  onPress={() => setForm((f: any) => ({ ...f, template_type: t }))}
                >
                  <Text style={[m.chipText, form.template_type === t && m.chipTextActive]}>
                    {t}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>

            {/* Active toggle */}
            <View style={m.toggleRow}>
              <Text style={m.label}>Active (shown to users)</Text>
              <Switch
                value={form.is_active}
                onValueChange={v => setForm((f: any) => ({ ...f, is_active: v }))}
                thumbColor={form.is_active ? colors.brand : "#ccc"}
                trackColor={{ false: "#e0e0e0", true: colors.brandLight }}
              />
            </View>

            <Button label={updating ? "Saving…" : "Save template"}
              onPress={save} loading={updating} fullWidth />
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
               borderBottomWidth: 1, borderBottomColor: colors.border },
  title:     { fontSize: 20, fontWeight: "900", color: colors.text },
  sub:       { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  filters:   { backgroundColor: "white", padding: 12,
               borderBottomWidth: 1, borderBottomColor: colors.border },
  search:    { backgroundColor: "#f0f0f0", borderRadius: 10, paddingHorizontal: 14, paddingVertical: 10, fontSize: 14, color: colors.text },
  subChip:        { paddingHorizontal: 12, paddingVertical: 6, borderRadius: 14, marginRight: 6, backgroundColor: "#f0f0f0" },
  subChipActive:  { backgroundColor: colors.brandLight },
  subChipText:    { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  subChipTextActive: { color: colors.brand },
  list:      { padding: 16, gap: 10 },
  row:       { backgroundColor: "white", borderRadius: 14, padding: 16,
               flexDirection: "row", alignItems: "center",
               shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  rowLeft:   { flex: 1 },
  rowTop:    { flexDirection: "row", alignItems: "center", justifyContent: "space-between", marginBottom: 8 },
  rowMeta:   { flexDirection: "row", flexWrap: "wrap", gap: 6 },
  metaTag:   { fontSize: 11, color: colors.textMuted, backgroundColor: "#f0f0f0",
               borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3 },
  activeDot: { width: 10, height: 10, borderRadius: 5 },
  rowText:   { fontSize: 14, color: colors.text, lineHeight: 22 },
  rowArrow:  { fontSize: 18, color: colors.brand, marginLeft: 12 },
});

const m = StyleSheet.create({
  root:    { flex: 1, backgroundColor: "#f8f7ff" },
  header:  { flexDirection: "row", justifyContent: "space-between", alignItems: "flex-start",
             padding: 20, paddingTop: Platform.OS === "ios" ? 56 : 20,
             backgroundColor: "white", borderBottomWidth: 1, borderBottomColor: colors.border },
  title:   { fontSize: 20, fontWeight: "900", color: colors.text },
  sub:     { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  close:   { fontSize: 22, color: colors.textMuted, fontWeight: "700" },
  body:    { padding: 20 },
  label:   { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  typeRow: { flexDirection: "row", flexWrap: "wrap", gap: 8, marginBottom: 16 },
  chip:        { borderWidth: 2, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6 },
  chipActive:  { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText:    { fontSize: 13, fontWeight: "600", color: colors.textMuted },
  chipTextActive: { color: colors.brand },
  toggleRow:   { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 20 },
  jsonInput:   { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10, padding: 12,
                 fontFamily: "monospace", fontSize: 12, color: colors.text,
                 minHeight: 100, textAlignVertical: "top", marginBottom: 4, backgroundColor: "white" },
  jsonErr:     { borderColor: colors.danger },
  errText:     { fontSize: 12, color: colors.danger, marginBottom: 12 },
});
