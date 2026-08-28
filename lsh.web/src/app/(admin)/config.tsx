/**
 * Admin App Config CMS
 * The master control panel — every string, price, feature flag, and URL
 * that appears on the landing page and throughout the app lives here.
 * Changes are stored in dbo.AppConfig and reflected instantly via /api/config.
 *
 * PUT /api/admin/config/:key
 * GET /api/admin/config  (full list with label + section + type)
 */

import { useState, useEffect } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput,
  StyleSheet, ActivityIndicator, Alert, Switch,
  Platform, Modal,
} from "react-native";
import { useQuery, useMutation, useQueryClient } from "@tanstack/react-query";
import { adminApi } from "../../api/admin";
import { colors }   from "../../constants/theme";
import { Button }   from "../../components/ui/Button";

// ── Section metadata ──────────────────────────────────────────────────────────
const SECTIONS: Record<string, { label: string; emoji: string; desc: string }> = {
  nav:            { label: "Navigation",           emoji: "🧭", desc: "Top nav links and the header CTA" },
  hero:           { label: "Hero section",         emoji: "🦸", desc: "Tagline, CTAs, badges visible on the landing page" },
  dualMode:       { label: "Digital vs print",     emoji: "🖨️", desc: "\"Two ways to learn\" section copy" },
  assessment:     { label: "Assessment",           emoji: "📝", desc: "Wizard copy and step count" },
  culturalTracks: { label: "Culture tracks",       emoji: "🏮", desc: "Chinese/Indian/Hispanic culture-track preview cards" },
  wisdomBanner:   { label: "Wisdom banner",        emoji: "🕉️", desc: "\"Words for Today\" header + attribution" },
  subjects:       { label: "Subjects section",     emoji: "📚", desc: "\"What we cover\" section heading" },
  worksheets:     { label: "Worksheets preview",   emoji: "📋", desc: "Sample worksheet grid heading + CTA" },
  whyUs:          { label: "Why us",               emoji: "⭐", desc: "\"Why families choose us\" 3-item grid" },
  testimonials:   { label: "Testimonials",         emoji: "💬", desc: "Family review cards" },
  progress:       { label: "Progress proof",       emoji: "📈", desc: "Week 1 → Week 12 progress cards" },
  comparison:     { label: "Comparison",           emoji: "⚖️", desc: "Competitor complaint/answer table" },
  pricing:        { label: "Pricing",              emoji: "💰", desc: "Plan prices, savings, and plan feature lists" },
  community:      { label: "Community & office hrs",emoji: "💬", desc: "Office hours details and community group member counts" },
  referral:       { label: "Referral",             emoji: "🎁", desc: "Referral copy and example codes" },
  school:         { label: "School licensing",     emoji: "🏫", desc: "Classroom and district plan prices" },
  social:         { label: "Social media",         emoji: "📱", desc: "Platform handles shown on landing page" },
  footer:         { label: "Footer",               emoji: "🔻", desc: "Footer links, legal, tagline" },
  features:       { label: "Feature flags",        emoji: "🚩", desc: "Toggle product features on/off without a code deploy" },
};

const SECTION_ORDER = [
  "nav","hero","dualMode","assessment","culturalTracks","wisdomBanner","subjects",
  "worksheets","whyUs","testimonials","progress","comparison","pricing","community",
  "referral","school","social","footer","features",
];

const CMS_LANGS = [
  { id: 1, label: "EN" }, { id: 2, label: "中文" },
  { id: 3, label: "हिन्दी" }, { id: 4, label: "ES" },
];

// ── Types ─────────────────────────────────────────────────────────────────────
interface ConfigRow {
  config_key:   string;
  config_value: string;
  config_type:  "text" | "number" | "boolean" | "json";
  label:        string;
  section:      string;
  updated_at:   string;
}

// ── Helpers ───────────────────────────────────────────────────────────────────
function parseValue(row: ConfigRow): any {
  if (row.config_type === "boolean") return row.config_value.trim().toLowerCase() === "true";
  if (row.config_type === "number") return Number(row.config_value);
  if (row.config_type === "json") {
    try { return JSON.parse(row.config_value); } catch { return row.config_value; }
  }
  return row.config_value;
}

function displayKey(key: string) {
  return key.split(".").slice(1).join(".").replace(/_/g, " ");
}

// ── Edit modal ────────────────────────────────────────────────────────────────
function EditModal({
  row, visible, onClose, onSave, saving,
}: {
  row: ConfigRow | null;
  visible: boolean;
  onClose: () => void;
  onSave:  (key: string, val: any) => void;
  saving:  boolean;
}) {
  const [draft, setDraft] = useState("");
  const [boolVal, setBoolVal] = useState(false);

  useEffect(() => {
    if (!row) return;
    if (row.config_type === "boolean") {
      setBoolVal(row.config_value.trim().toLowerCase() === "true");
    } else {
      setDraft(row.config_value);
    }
  }, [row]);

  if (!row) return null;

  const submit = () => {
    let val: any = draft;
    if (row.config_type === "boolean") val = boolVal;
    else if (row.config_type === "number") {
      val = parseFloat(draft);
      if (isNaN(val)) { Alert.alert("Invalid", "Enter a valid number"); return; }
    } else if (row.config_type === "json") {
      try { val = JSON.parse(draft); }
      catch { Alert.alert("Invalid JSON", "Check your JSON syntax"); return; }
    }
    onSave(row.config_key, val);
  };

  const isLong = row.config_type === "text" && draft.length > 80;

  return (
    <Modal visible={visible} animationType="slide" presentationStyle="pageSheet" onRequestClose={onClose}>
      <View style={m.root}>
        <View style={m.header}>
          <View style={{ flex: 1 }}>
            <Text style={m.keyLabel}>{row.config_key}</Text>
            <Text style={m.rowLabel}>{row.label}</Text>
          </View>
          <TouchableOpacity onPress={onClose} style={m.closeBtn}>
            <Text style={m.closeTxt}>✕</Text>
          </TouchableOpacity>
        </View>

        <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
          {/* Type badge */}
          <View style={m.typeBadge}>
            <Text style={m.typeText}>type: {row.config_type}</Text>
          </View>

          {/* Input based on type */}
          {row.config_type === "boolean" ? (
            <View style={m.boolRow}>
              <Text style={m.boolLabel}>{boolVal ? "✅  Enabled" : "❌  Disabled"}</Text>
              <Switch
                value={boolVal}
                onValueChange={setBoolVal}
                trackColor={{ true: colors.brand, false: colors.border }}
                thumbColor="white"
              />
            </View>
          ) : (
            <TextInput
              style={[m.input, isLong && m.inputMulti]}
              value={draft}
              onChangeText={setDraft}
              multiline={isLong || row.config_type === "json"}
              numberOfLines={isLong ? 4 : row.config_type === "json" ? 6 : 1}
              autoCapitalize="none"
              keyboardType={row.config_type === "number" ? "decimal-pad" : "default"}
              placeholder={row.config_type === "json" ? '["item1","item2"]' : "Enter value…"}
              placeholderTextColor={colors.textMuted}
            />
          )}

          {/* Last updated */}
          {row.updated_at && (
            <Text style={m.updatedAt}>
              Last updated: {new Date(row.updated_at).toLocaleString()}
            </Text>
          )}

          {/* Preview */}
          {row.config_type !== "boolean" && draft.length > 0 && (
            <View style={m.preview}>
              <Text style={m.previewLabel}>Preview</Text>
              <Text style={m.previewValue} numberOfLines={8}>{draft}</Text>
            </View>
          )}

          <View style={m.btnRow}>
            <Button
              label={saving ? "Saving…" : "Save changes"}
              onPress={submit}
              loading={saving}
              style={{ flex: 1 }}
            />
            <Button
              label="Cancel"
              onPress={onClose}
              variant="outline"
              style={{ flex: 1 }}
            />
          </View>
        </ScrollView>
      </View>
    </Modal>
  );
}

// ── Row item ──────────────────────────────────────────────────────────────────
function ConfigRowItem({ row, onEdit }: { row: ConfigRow; onEdit: (row: ConfigRow) => void }) {
  const val = parseValue(row);
  const isFlag = row.config_type === "boolean";
  const label  = row.label || displayKey(row.config_key);

  return (
    <TouchableOpacity style={r.row} onPress={() => onEdit(row)} activeOpacity={0.8}>
      <View style={r.left}>
        <Text style={r.label}>{label}</Text>
        <Text style={r.key} numberOfLines={1}>{row.config_key}</Text>
      </View>
      <View style={r.right}>
        {isFlag ? (
          <View style={[r.flag, { backgroundColor: val ? "#dcfce7" : "#fee2e2" }]}>
            <Text style={[r.flagText, { color: val ? "#16a34a" : "#dc2626" }]}>
              {val ? "ON" : "OFF"}
            </Text>
          </View>
        ) : (
          <Text style={r.value} numberOfLines={1}>
            {String(val).slice(0, 48)}{String(val).length > 48 ? "…" : ""}
          </Text>
        )}
        <Text style={r.editHint}>Edit →</Text>
      </View>
    </TouchableOpacity>
  );
}

// ── New key modal ─────────────────────────────────────────────────────────────
function NewKeyModal({
  visible, onClose, onSave, saving,
}: {
  visible: boolean;
  onClose: () => void;
  onSave:  (key: string, val: any, type: string, label: string, section: string) => void;
  saving:  boolean;
}) {
  const [key,   setKey]   = useState("");
  const [val,   setVal]   = useState("");
  const [type,  setType]  = useState("text");
  const [label, setLabel] = useState("");
  const [sect,  setSect]  = useState("hero");

  const TYPES = ["text","number","boolean","json"];

  const submit = () => {
    if (!key.trim()) { Alert.alert("Key required"); return; }
    let parsed: any = val;
    if (type === "number") {
      parsed = parseFloat(val);
      if (isNaN(parsed)) { Alert.alert("Enter a valid number"); return; }
    } else if (type === "boolean") {
      parsed = val.toLowerCase() === "true" || val === "1";
    } else if (type === "json") {
      try { parsed = JSON.parse(val); } catch { Alert.alert("Invalid JSON"); return; }
    }
    onSave(key.trim(), parsed, type, label, sect);
  };

  return (
    <Modal visible={visible} animationType="slide" presentationStyle="pageSheet" onRequestClose={onClose}>
      <View style={m.root}>
        <View style={m.header}>
          <Text style={[m.keyLabel, { flex: 1 }]}>Add new config key</Text>
          <TouchableOpacity onPress={onClose} style={m.closeBtn}>
            <Text style={m.closeTxt}>✕</Text>
          </TouchableOpacity>
        </View>
        <ScrollView contentContainerStyle={m.body} keyboardShouldPersistTaps="handled">
          <Text style={m.fieldLabel}>Key (e.g. hero.new_badge)</Text>
          <TextInput style={m.input} value={key} onChangeText={setKey}
            autoCapitalize="none" placeholder="section.key_name"
            placeholderTextColor={colors.textMuted} />

          <Text style={m.fieldLabel}>Label (human-readable)</Text>
          <TextInput style={m.input} value={label} onChangeText={setLabel}
            placeholder="What this setting controls"
            placeholderTextColor={colors.textMuted} />

          <Text style={m.fieldLabel}>Section</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
            <View style={{ flexDirection: "row", gap: 8 }}>
              {SECTION_ORDER.map(s2 => (
                <TouchableOpacity key={s2}
                  onPress={() => setSect(s2)}
                  style={[m.chip, sect === s2 && m.chipActive]}>
                  <Text style={[m.chipText, sect === s2 && m.chipTextActive]}>
                    {SECTIONS[s2]?.emoji} {s2}
                  </Text>
                </TouchableOpacity>
              ))}
            </View>
          </ScrollView>

          <Text style={m.fieldLabel}>Type</Text>
          <View style={{ flexDirection: "row", gap: 8, marginBottom: 16 }}>
            {TYPES.map(t => (
              <TouchableOpacity key={t} onPress={() => setType(t)}
                style={[m.chip, type === t && m.chipActive]}>
                <Text style={[m.chipText, type === t && m.chipTextActive]}>{t}</Text>
              </TouchableOpacity>
            ))}
          </View>

          <Text style={m.fieldLabel}>Value</Text>
          <TextInput style={m.input} value={val} onChangeText={setVal}
            multiline={type === "json"} numberOfLines={type === "json" ? 4 : 1}
            placeholder={type === "boolean" ? "true or false"
              : type === "number" ? "14.99"
              : type === "json"   ? '["item1","item2"]'
              : "Enter value…"}
            placeholderTextColor={colors.textMuted}
            autoCapitalize="none"
            keyboardType={type === "number" ? "decimal-pad" : "default"} />

          <View style={m.btnRow}>
            <Button label={saving ? "Saving…" : "Create key"} onPress={submit} loading={saving} style={{ flex: 1 }} />
            <Button label="Cancel" onPress={onClose} variant="outline" style={{ flex: 1 }} />
          </View>
        </ScrollView>
      </View>
    </Modal>
  );
}

// ── Main screen ───────────────────────────────────────────────────────────────
export default function ConfigCMS() {
  const qc = useQueryClient();
  const [langId,        setLangId]        = useState(1);
  const [openSections,  setOpenSections]  = useState<Set<string>>(new Set(["hero","pricing"]));
  const [searchQuery,   setSearchQuery]   = useState("");
  const [editingRow,    setEditingRow]    = useState<ConfigRow | null>(null);
  const [showNewModal,  setShowNewModal]  = useState(false);

  const { data: rows = [], isLoading, refetch } = useQuery<ConfigRow[]>({
    queryKey: ["adminConfig", langId],
    queryFn:  () => adminApi.getConfig(langId) as Promise<ConfigRow[]>,
    staleTime: 30_000,
    placeholderData: [],
  });

  const inv = () => {
    qc.invalidateQueries({ queryKey: ["adminConfig"] });
    qc.invalidateQueries({ queryKey: ["appConfig"] }); // bust public cache too
  };

  const { mutate: saveConfig, isPending: saving } = useMutation({
    mutationFn: ({ key, value }: { key: string; value: any }) =>
      adminApi.updateConfig(key, value, langId),
    onSuccess: () => {
      setEditingRow(null);
      inv();
      Alert.alert("✅ Saved", "Change is live — users will see it within 5 minutes.");
    },
    onError: (e: any) => Alert.alert("Error saving", e.message),
  });

  // Group by section
  const bySection: Record<string, ConfigRow[]> = {};
  (rows as ConfigRow[]).forEach(row => {
    const section = row.section || "general";
    if (!bySection[section]) bySection[section] = [];
    bySection[section].push(row);
  });

  // Search filter
  const searchLower = searchQuery.toLowerCase();
  const filteredBySection: Record<string, ConfigRow[]> = {};
  Object.entries(bySection).forEach(([section, sRows]) => {
    const filtered = searchLower
      ? sRows.filter(r =>
          r.config_key.toLowerCase().includes(searchLower) ||
          r.label?.toLowerCase().includes(searchLower) ||
          r.config_value.toLowerCase().includes(searchLower)
        )
      : sRows;
    if (filtered.length) filteredBySection[section] = filtered;
  });

  const toggleSection = (section: string) => {
    setOpenSections(prev => {
      const next = new Set(prev);
      next.has(section) ? next.delete(section) : next.add(section);
      return next;
    });
  };

  const expandAll  = () => setOpenSections(new Set(Object.keys(bySection)));
  const collapseAll= () => setOpenSections(new Set());

  const totalRows = (rows as ConfigRow[]).length;
  const sections  = [...SECTION_ORDER, ...Object.keys(filteredBySection).filter(s => !SECTION_ORDER.includes(s))];

  return (
    <View style={s.root}>
      {/* ── Header ───────────────────────────────────── */}
      <View style={s.header}>
        <View style={{ flex: 1 }}>
          <Text style={s.title}>⚙️ App Config CMS</Text>
          <Text style={s.sub}>{totalRows} keys · changes live in ≤5 min</Text>
        </View>
        <TouchableOpacity style={s.addBtn} onPress={() => setShowNewModal(true)}>
          <Text style={s.addBtnText}>+ New</Text>
        </TouchableOpacity>
      </View>

      {/* ── Language selector ─────────────────────────── */}
      <View style={s.langRow}>
        {CMS_LANGS.map(l => (
          <TouchableOpacity
            key={l.id}
            onPress={() => setLangId(l.id)}
            style={[s.langChip, langId === l.id && s.langChipActive]}
          >
            <Text style={[s.langChipText, langId === l.id && s.langChipTextActive]}>{l.label}</Text>
          </TouchableOpacity>
        ))}
        <Text style={s.langHint}>Editing {langId === 1 ? "English (source)" : "a translation — falls back to English if not set"}</Text>
      </View>

      {/* ── Explainer strip ──────────────────────────── */}
      <View style={s.banner}>
        <Text style={s.bannerText}>
          🔴 Live  ·  Every change here updates the landing page, pricing, and app copy instantly — no code deploy needed. Changes cached for 5 minutes on client.
        </Text>
      </View>

      {/* ── Search ───────────────────────────────────── */}
      <View style={s.searchWrap}>
        <TextInput
          style={s.search}
          value={searchQuery}
          onChangeText={setSearchQuery}
          placeholder="Search keys, labels, or values…"
          placeholderTextColor={colors.textMuted}
          autoCapitalize="none"
          clearButtonMode="while-editing"
        />
      </View>

      {/* ── Expand / collapse all ─────────────────────── */}
      {!searchQuery && (
        <View style={s.expandRow}>
          <TouchableOpacity onPress={expandAll}>
            <Text style={s.expandBtn}>Expand all</Text>
          </TouchableOpacity>
          <Text style={s.expandSep}>·</Text>
          <TouchableOpacity onPress={collapseAll}>
            <Text style={s.expandBtn}>Collapse all</Text>
          </TouchableOpacity>
          <Text style={{ flex: 1 }} />
          <TouchableOpacity onPress={() => refetch()}>
            <Text style={s.expandBtn}>↻ Refresh</Text>
          </TouchableOpacity>
        </View>
      )}

      {isLoading ? (
        <View style={s.center}>
          <ActivityIndicator size="large" color={colors.brand} />
          <Text style={{ color: colors.textMuted, marginTop: 12 }}>Loading config…</Text>
        </View>
      ) : (
        <ScrollView contentContainerStyle={s.list} showsVerticalScrollIndicator={false}>
          {/* Search results notice */}
          {searchQuery && (
            <Text style={s.searchNote}>
              {Object.values(filteredBySection).flat().length} matching keys
            </Text>
          )}

          {sections.map(section => {
            const sRows   = filteredBySection[section];
            if (!sRows?.length) return null;
            const meta    = SECTIONS[section] ?? { label: section, emoji: "⚙️", desc: "" };
            const isOpen  = searchQuery ? true : openSections.has(section);

            return (
              <View key={section} style={s.sectionCard}>
                {/* Section header */}
                <TouchableOpacity
                  style={s.sectionHeader}
                  onPress={() => toggleSection(section)}
                  activeOpacity={0.8}
                >
                  <Text style={s.sectionEmoji}>{meta.emoji}</Text>
                  <View style={{ flex: 1 }}>
                    <Text style={s.sectionTitle}>{meta.label}</Text>
                    {meta.desc ? <Text style={s.sectionDesc}>{meta.desc}</Text> : null}
                  </View>
                  <Text style={s.sectionCount}>{sRows.length} keys</Text>
                  <Text style={s.sectionChevron}>{isOpen ? "▲" : "▼"}</Text>
                </TouchableOpacity>

                {/* Config rows */}
                {isOpen && sRows.map((row, i) => (
                  <View key={row.config_key}>
                    {i > 0 && <View style={s.divider} />}
                    <ConfigRowItem row={row} onEdit={setEditingRow} />
                  </View>
                ))}
              </View>
            );
          })}

          {Object.keys(filteredBySection).length === 0 && (
            <View style={s.center}>
              <Text style={{ fontSize: 40, marginBottom: 12 }}>🔍</Text>
              <Text style={{ color: colors.textMuted, fontSize: 15, textAlign: "center" }}>
                No keys match "{searchQuery}"
              </Text>
            </View>
          )}

          {/* Info footer */}
          <View style={s.footer}>
            <Text style={s.footerText}>
              💡 New keys added here appear immediately in the Config API.{"\n"}
              The public endpoint GET /api/config is cached 5 min client-side.{"\n"}
              Feature flags take effect on next app launch.
            </Text>
          </View>

          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      {/* ── Edit modal ───────────────────────────────── */}
      <EditModal
        row={editingRow}
        visible={!!editingRow}
        onClose={() => setEditingRow(null)}
        onSave={(key, val) => saveConfig({ key, value: val })}
        saving={saving}
      />

      {/* ── New key modal ─────────────────────────────── */}
      <NewKeyModal
        visible={showNewModal}
        onClose={() => setShowNewModal(false)}
        onSave={(key, val, type, label, section) => {
          adminApi.updateConfig(key, val, langId, label)
            .then(() => { inv(); setShowNewModal(false); })
            .catch((e: any) => Alert.alert("Error", e.message));
        }}
        saving={false}
      />
    </View>
  );
}

// ── Styles ────────────────────────────────────────────────────────────────────

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  center: { flex: 1, justifyContent: "center", alignItems: "center", padding: 32, marginTop: 40 },

  header: {
    backgroundColor: "white",
    paddingTop: Platform.OS === "ios" ? 56 : 20,
    paddingBottom: 14, paddingHorizontal: 20,
    flexDirection: "row", alignItems: "center",
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  title: { fontSize: 20, fontWeight: "900", color: colors.text },
  sub:   { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  addBtn: {
    backgroundColor: colors.brand, borderRadius: 10,
    paddingHorizontal: 14, paddingVertical: 8,
  },
  addBtnText: { color: "white", fontWeight: "800", fontSize: 14 },

  banner: {
    backgroundColor: "#fff3cd",
    paddingHorizontal: 16, paddingVertical: 10,
    borderBottomWidth: 1, borderBottomColor: "#fde68a",
  },
  bannerText: { fontSize: 12, color: "#92400e", lineHeight: 18 },

  langRow: {
    flexDirection: "row", alignItems: "center", gap: 8,
    paddingHorizontal: 16, paddingVertical: 10,
    backgroundColor: "white", borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  langChip: {
    borderWidth: 2, borderColor: colors.border, borderRadius: 10,
    paddingHorizontal: 12, paddingVertical: 6,
  },
  langChipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  langChipText: { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  langChipTextActive: { color: colors.brand },
  langHint: { flex: 1, fontSize: 11, color: colors.textMuted, marginLeft: 8, textAlign: "right" },

  searchWrap: {
    backgroundColor: "white", paddingHorizontal: 16, paddingVertical: 10,
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  search: {
    backgroundColor: "#f0f0f0", borderRadius: 10,
    paddingHorizontal: 14, paddingVertical: 10,
    fontSize: 14, color: colors.text,
  },

  expandRow: {
    flexDirection: "row", alignItems: "center", gap: 8,
    paddingHorizontal: 16, paddingVertical: 8,
    backgroundColor: "#f8f7ff",
  },
  expandBtn: { fontSize: 12, color: colors.brand, fontWeight: "700" },
  expandSep: { color: colors.textMuted },

  list: { padding: 16, gap: 12 },

  searchNote: {
    fontSize: 12, color: colors.textMuted, fontWeight: "600",
    marginBottom: 4, paddingHorizontal: 4,
  },

  sectionCard: {
    backgroundColor: "white", borderRadius: 16, overflow: "hidden",
    shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 10, elevation: 2,
  },
  sectionHeader: {
    flexDirection: "row", alignItems: "center", gap: 12,
    padding: 16, backgroundColor: "white",
  },
  sectionEmoji: { fontSize: 26, width: 34 },
  sectionTitle: { fontSize: 15, fontWeight: "800", color: colors.text },
  sectionDesc:  { fontSize: 12, color: colors.textMuted, marginTop: 2 },
  sectionCount: { fontSize: 11, color: colors.textMuted, fontWeight: "600", marginRight: 4 },
  sectionChevron:{ fontSize: 12, color: colors.textMuted },

  divider: { height: 1, backgroundColor: "#f0f0f0", marginHorizontal: 16 },

  footer: {
    backgroundColor: colors.brandLight, borderRadius: 12, padding: 16, marginTop: 8,
  },
  footerText: { fontSize: 12, color: colors.brand, lineHeight: 20 },
});

// Config row styles
const r = StyleSheet.create({
  row: {
    flexDirection: "row", alignItems: "center",
    paddingHorizontal: 16, paddingVertical: 14,
  },
  left:  { flex: 1, marginRight: 12 },
  label: { fontSize: 14, fontWeight: "700", color: colors.text, marginBottom: 2 },
  key:   { fontSize: 11, color: colors.textMuted, fontFamily: Platform.OS === "ios" ? "Menlo" : "monospace" },
  right: { alignItems: "flex-end", maxWidth: 140 },
  value: { fontSize: 13, color: colors.textMuted, textAlign: "right", marginBottom: 4 },
  editHint: { fontSize: 11, color: colors.brand, fontWeight: "700" },
  flag: { borderRadius: 6, paddingHorizontal: 10, paddingVertical: 4, marginBottom: 4 },
  flagText: { fontSize: 12, fontWeight: "800" },
});

// Modal styles
const m = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: {
    backgroundColor: "white",
    paddingTop: Platform.OS === "ios" ? 20 : 16,
    paddingBottom: 16, paddingHorizontal: 20,
    flexDirection: "row", alignItems: "flex-start",
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  keyLabel: {
    fontSize: 13, fontWeight: "800", color: colors.brand,
    fontFamily: Platform.OS === "ios" ? "Menlo" : "monospace",
    marginBottom: 4,
  },
  rowLabel: { fontSize: 18, fontWeight: "900", color: colors.text },
  closeBtn: {
    width: 36, height: 36, borderRadius: 18,
    backgroundColor: "#f0f0f0", justifyContent: "center", alignItems: "center",
    marginLeft: 12, marginTop: 2,
  },
  closeTxt: { fontSize: 16, color: colors.textMuted, fontWeight: "700" },

  body: { padding: 20, paddingBottom: 60 },

  typeBadge: {
    alignSelf: "flex-start", backgroundColor: colors.brandLight,
    borderRadius: 8, paddingHorizontal: 10, paddingVertical: 4, marginBottom: 16,
  },
  typeText: { fontSize: 12, color: colors.brand, fontWeight: "700" },

  fieldLabel: { fontSize: 13, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },

  input: {
    backgroundColor: "white", borderWidth: 2, borderColor: colors.border,
    borderRadius: 12, paddingHorizontal: 16, paddingVertical: 14,
    fontSize: 15, color: colors.text, marginBottom: 16,
  },
  inputMulti: { height: 120, textAlignVertical: "top" },

  boolRow: {
    flexDirection: "row", justifyContent: "space-between", alignItems: "center",
    backgroundColor: "white", borderRadius: 12, padding: 16, marginBottom: 16,
    borderWidth: 2, borderColor: colors.border,
  },
  boolLabel: { fontSize: 16, fontWeight: "700", color: colors.text },

  updatedAt: { fontSize: 12, color: colors.textMuted, marginBottom: 16 },

  preview: {
    backgroundColor: "#f8f7ff", borderRadius: 10, padding: 14,
    marginBottom: 20, borderWidth: 1, borderColor: colors.border,
  },
  previewLabel: { fontSize: 11, fontWeight: "700", color: colors.textMuted, marginBottom: 6 },
  previewValue: { fontSize: 14, color: colors.text, lineHeight: 22 },

  btnRow: { flexDirection: "row", gap: 12, marginTop: 8 },

  chip:       { borderWidth: 2, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 12, paddingVertical: 6 },
  chipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  chipText:   { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  chipTextActive: { color: colors.brand },
});
