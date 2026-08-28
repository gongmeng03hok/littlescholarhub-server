/**
 * Content Library — featured strip + grade tabs + topic/level/interest
 * filters + card grid. All data (worksheets, featured picks, interests,
 * levels) is fetched live from the API — nothing here is hardcoded content.
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput, Modal,
  StyleSheet, Linking, ActivityIndicator, Platform, Alert,
} from "react-native";
import * as ImagePicker from "expo-image-picker";
import {
  useWorksheets, useFeatured, useInterests, useLevels, useRecordView,
  useAssignWorksheet, useUploadWorksheet,
} from "../../hooks/useApi";
import { useChildren }    from "../../hooks/useChildren";
import { useChildStore }  from "../../store/childStore";
import { useAuthStore }   from "../../store/authStore";
import { EmptyState }     from "../../components/ui/EmptyState";
import { WorksheetPreviewModal } from "../../components/WorksheetPreviewModal";
import { GamePlayerModal } from "../../components/GamePlayerModal";
import { contentApi }     from "../../api/content";
import { colors, GRADES, SUBJECT_META } from "../../constants/theme";

/** Silently sends a same-origin PDF straight to the browser's print dialog
 * via a hidden iframe — no extra tab, no manual "print" click on a PDF viewer. */
function printPdfUrl(url: string) {
  if (Platform.OS !== "web") { Linking.openURL(url); return; }
  const iframe = document.createElement("iframe");
  iframe.style.position = "fixed";
  iframe.style.right = "0";
  iframe.style.bottom = "0";
  iframe.style.width = "0";
  iframe.style.height = "0";
  iframe.style.border = "none";
  iframe.src = url;
  document.body.appendChild(iframe);
  iframe.onload = () => {
    try {
      iframe.contentWindow?.focus();
      iframe.contentWindow?.print();
    } catch {
      window.open(url, "_blank");
    }
    setTimeout(() => document.body.removeChild(iframe), 60_000);
  };
}

/** Same idea, but for a Blob response (the merged multi-worksheet PDF). */
function printPdfBlob(blob: Blob) {
  const url = URL.createObjectURL(blob);
  if (Platform.OS !== "web") { Linking.openURL(url); return; }
  const iframe = document.createElement("iframe");
  iframe.style.position = "fixed";
  iframe.style.right = "0";
  iframe.style.bottom = "0";
  iframe.style.width = "0";
  iframe.style.height = "0";
  iframe.style.border = "none";
  iframe.src = url;
  document.body.appendChild(iframe);
  iframe.onload = () => {
    try {
      iframe.contentWindow?.focus();
      iframe.contentWindow?.print();
    } catch {
      window.open(url, "_blank");
    }
    setTimeout(() => { document.body.removeChild(iframe); URL.revokeObjectURL(url); }, 60_000);
  };
}

const UPLOAD_SUBJECT_CHIPS = ["math", "phonics", "reading", "art", "story", "workbooks", "logic"];

const GRADE_LABELS: Record<number, string> = {
  0: "TK", 1: "Kindergarten", 2: "1st", 3: "2nd",
  4: "3rd", 5: "4th", 6: "5th", 7: "6th",
};

const CONTENT_TYPE_META: Record<string, { label: string; icon: string }> = {
  coloring:  { label: "COLOR",     icon: "🎨" },
  mini_book: { label: "MINI-BOOK", icon: "📚" },
  workbook:  { label: "WORKBOOK",  icon: "📕" },
  worksheet: { label: "WORKSHEET", icon: "📋" },
  game: { label: "GAME", icon: "🎮" },
};

const SOCIAL_META: Record<string, { label: string; icon: string }> = {
  instagram: { label: "Instagram", icon: "📷" },
  tiktok:    { label: "TikTok",    icon: "🎵" },
  teachers:  { label: "Teachers",  icon: "🍎" },
};

type QuickFilter = "all" | "trending" | "coloring" | "mini_book" | "game";

const QUICK_FILTERS: { key: QuickFilter; label: string; icon: string }[] = [
  { key: "trending",      label: "Trending",       icon: "🔥" },
  { key: "coloring",      label: "Coloring",       icon: "🎨" },
  { key: "mini_book",     label: "Mini-Books",     icon: "📚" },
  { key: "game",          label: "Games",          icon: "🎮" },
  { key: "all",           label: "All topics",     icon: "🗂️" },
];

function formatCount(n?: number) {
  if (!n) return "0";
  if (n >= 1000) return `${(n / 1000).toFixed(n % 1000 === 0 ? 0 : 1)}k`;
  return String(n);
}

export default function ContentScreen() {
  const { activeChild } = useChildStore();
  const { family }      = useAuthStore();
  const [gradeId, setGradeId]           = useState<number>(activeChild?.grade_id ?? 2);
  const [quickFilter, setQuickFilter]   = useState<QuickFilter>("all");
  const [subject, setSubject]           = useState<string | undefined>(undefined);
  const [level, setLevel]               = useState<string | undefined>(undefined);
  const [interest, setInterest]         = useState<string | undefined>(undefined);

  const { data: featured = [] }  = useFeatured();
  const { data: interests = [] } = useInterests();
  const { data: levels = [] }    = useLevels();
  const { data: children = [] }  = useChildren();
  const { mutate: recordView }   = useRecordView();
  const { mutate: assignWorksheet, isPending: assigning } = useAssignWorksheet();
  const { mutate: uploadWorksheet, isPending: uploadingFile } = useUploadWorksheet();

  const { data: worksheets = [], isLoading } = useWorksheets({
    grade: gradeId,
    subject: quickFilter === "all" ? subject : undefined,
    content_type: quickFilter === "coloring" ? "coloring" : quickFilter === "mini_book" ? "mini_book"
                 : quickFilter === "game" ? "game" : undefined,
    trending: quickFilter === "trending" ? true : undefined,
    level,
    interest,
    language_id: family?.language_id ?? 1,
  });

  const [previewWorksheet, setPreviewWorksheet] = useState<any | null>(null);
  const [playingGame, setPlayingGame] = useState<any | null>(null);
  const openItem = (ws: any) => {
    recordView(ws.worksheet_id);
    if (ws.content_type === "game") { setPlayingGame(ws); return; }
    setPreviewWorksheet(ws);
  };

  // ── Multi-select + batch print ──────────────────────────────────
  const [selectMode, setSelectMode] = useState(false);
  const [selectedIds, setSelectedIds] = useState<Set<number>>(new Set());
  const [printingBatch, setPrintingBatch] = useState(false);

  const toggleSelectMode = () => {
    setSelectMode(m => !m);
    setSelectedIds(new Set());
  };

  const toggleSelected = (id: number) => {
    setSelectedIds(prev => {
      const next = new Set(prev);
      next.has(id) ? next.delete(id) : next.add(id);
      return next;
    });
  };

  const printSelected = async () => {
    if (selectedIds.size === 0) return;
    setPrintingBatch(true);
    try {
      const blob = await contentApi.printBatch(Array.from(selectedIds));
      printPdfBlob(blob);
      setSelectMode(false);
      setSelectedIds(new Set());
    } catch (e: any) {
      Alert.alert("Couldn't print", e.message);
    } finally {
      setPrintingBatch(false);
    }
  };

  const [assignTarget, setAssignTarget] = useState<any | null>(null);
  const [assignChildId, setAssignChildId] = useState<number | null>(activeChild?.child_id ?? null);
  const [assignNote, setAssignNote] = useState("");

  const openAssign = (ws: any) => {
    if (children.length === 0) { Alert.alert("Add a child first", "Add a child profile before assigning worksheets."); return; }
    setAssignTarget(ws);
    setAssignChildId(activeChild?.child_id ?? (children as any[])[0]?.child_id ?? null);
    setAssignNote("");
  };

  const submitAssign = () => {
    if (!assignTarget || !assignChildId) return;
    assignWorksheet(
      { childId: assignChildId, worksheetId: assignTarget.worksheet_id, note: assignNote.trim() || undefined },
      {
        onSuccess: () => {
          const child = (children as any[]).find(c => c.child_id === assignChildId);
          setAssignTarget(null);
          Alert.alert("Assigned!", `"${assignTarget.title}" was added to ${child?.nickname ?? "your child"}'s assignments.`);
        },
        onError: (e: any) => Alert.alert("Couldn't assign", e.message),
      }
    );
  };

  // ── Upload your own worksheet (PDF/image) ──────────────────────
  const [uploadOpen, setUploadOpen] = useState(false);
  const [uploadFile, setUploadFile] = useState<{ file: any; name: string; type: string } | null>(null);
  const [uploadChildId, setUploadChildId] = useState<number | null>(null);
  const [uploadTitle, setUploadTitle] = useState("");
  const [uploadSubject, setUploadSubject] = useState<string | null>(null);
  const [uploadNote, setUploadNote] = useState("");

  const openUpload = () => {
    if (children.length === 0) { Alert.alert("Add a child first", "Add a child profile before uploading a worksheet."); return; }
    setUploadFile(null);
    setUploadTitle("");
    setUploadSubject(null);
    setUploadNote("");
    setUploadChildId(activeChild?.child_id ?? (children as any[])[0]?.child_id ?? null);
    setUploadOpen(true);
  };

  const pickUploadFile = async () => {
    if (Platform.OS === "web") {
      const input = document.createElement("input");
      input.type = "file";
      input.accept = "application/pdf,image/*";
      input.onchange = () => {
        const f = input.files?.[0];
        if (f) setUploadFile({ file: f, name: f.name, type: f.type || "application/octet-stream" });
      };
      input.click();
      return;
    }
    const perm = await ImagePicker.requestMediaLibraryPermissionsAsync();
    if (!perm.granted) { Alert.alert("Permission needed", "Please allow access to continue."); return; }
    const result = await ImagePicker.launchImageLibraryAsync({ mediaTypes: ["images"], quality: 0.8 });
    if (!result.canceled && result.assets?.[0]) {
      setUploadFile({ file: result.assets[0].uri, name: `worksheet-${Date.now()}.jpg`, type: "image/jpeg" });
    }
  };

  const submitUpload = () => {
    if (!uploadChildId || !uploadFile) return;
    const subjectId = uploadSubject ? SUBJECT_META[uploadSubject]?.subjectId : undefined;
    uploadWorksheet(
      {
        child_id: uploadChildId,
        file: uploadFile.file,
        filename: uploadFile.name,
        mime: uploadFile.type,
        title: uploadTitle.trim() || undefined,
        subject_id: subjectId,
        note: uploadNote.trim() || undefined,
      },
      {
        onSuccess: () => {
          const child = (children as any[]).find(c => c.child_id === uploadChildId);
          setUploadOpen(false);
          Alert.alert("Uploaded!", `Added to ${child?.nickname ?? "your child"}'s assignments.`);
        },
        onError: (e: any) => Alert.alert("Couldn't upload", e.message),
      }
    );
  };

  return (
    <View style={s.root}>
      {/* Header */}
      <View style={s.header}>
        <View style={{ flexDirection: "row", alignItems: "flex-start", justifyContent: "space-between" }}>
          <View style={{ flex: 1 }}>
            <Text style={s.title}>Content Library 📚</Text>
            <Text style={s.sub}>Hand-picked by our teachers, refreshed monthly.</Text>
          </View>
          <View style={{ flexDirection: "row", gap: 8 }}>
            <TouchableOpacity style={[s.uploadHeaderBtn, selectMode && s.uploadHeaderBtnActive]} onPress={toggleSelectMode}>
              <Text style={[s.uploadHeaderBtnText, selectMode && s.uploadHeaderBtnTextActive]}>
                {selectMode ? "✕ Cancel" : "🖨️ Print multiple"}
              </Text>
            </TouchableOpacity>
            <TouchableOpacity style={s.uploadHeaderBtn} onPress={openUpload}>
              <Text style={s.uploadHeaderBtnText}>📤 Upload worksheet</Text>
            </TouchableOpacity>
          </View>
        </View>
        {selectMode && (
          <Text style={s.selectHint}>Tap worksheets to select them, then print them all in one job.</Text>
        )}
      </View>

      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Featured strip */}
        {featured.length > 0 && (
          <ScrollView horizontal showsHorizontalScrollIndicator={false}
            style={s.featuredScroll} contentContainerStyle={{ paddingHorizontal: 16, gap: 12 }}>
            {featured.map((f: any) => {
              const meta = SUBJECT_META[f.subject];
              return (
                <TouchableOpacity key={f.featured_id} style={s.featuredCard} activeOpacity={0.85}
                  onPress={() => { setGradeId(f.grade_id); setQuickFilter("all"); setSubject(f.subject); }}>
                  <View style={[s.featuredIconWrap, { backgroundColor: meta?.color ?? colors.brandLight }]}>
                    <Text style={s.featuredIcon}>{meta?.icon ?? "⭐"}</Text>
                  </View>
                  <Text style={s.featuredTitle} numberOfLines={2}>{f.title}</Text>
                  <Text style={s.featuredSub} numberOfLines={1}>{f.subtitle_override}</Text>
                </TouchableOpacity>
              );
            })}
          </ScrollView>
        )}

        {/* Grade tabs */}
        <ScrollView horizontal showsHorizontalScrollIndicator={false}
          style={s.gradeScroll} contentContainerStyle={{ paddingHorizontal: 12 }}>
          {GRADES.map(g => (
            <TouchableOpacity key={g.grade_id}
              onPress={() => setGradeId(g.grade_id)}
              style={[s.gradeTab, gradeId === g.grade_id && s.gradeTabActive]}>
              <Text style={[s.gradeTabText, gradeId === g.grade_id && s.gradeTabTextActive]}>
                {GRADE_LABELS[g.grade_id] ?? g.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {/* Quick filters: Trending / Coloring / Mini-Books / All topics */}
        <ScrollView horizontal showsHorizontalScrollIndicator={false}
          style={s.filterScroll} contentContainerStyle={{ paddingHorizontal: 12 }}>
          {QUICK_FILTERS.map(f => (
            <TouchableOpacity key={f.key}
              onPress={() => { setQuickFilter(f.key); if (f.key !== "all") setSubject(undefined); }}
              style={[s.quickChip, quickFilter === f.key && s.quickChipActive]}>
              <Text style={[s.filterText, quickFilter === f.key && s.filterTextActive]}>
                {f.icon} {f.label}
              </Text>
            </TouchableOpacity>
          ))}
        </ScrollView>

        {/* Subject / topic pills — only meaningful while "All topics" is selected */}
        {quickFilter === "all" && (
          <ScrollView horizontal showsHorizontalScrollIndicator={false}
            style={s.filterScroll} contentContainerStyle={{ paddingHorizontal: 12 }}>
            <TouchableOpacity onPress={() => setSubject(undefined)}
              style={[s.filterChip, !subject && s.filterChipActive]}>
              <Text style={[s.filterText, !subject && s.filterTextActive]}>All</Text>
            </TouchableOpacity>
            {Object.entries(SUBJECT_META).map(([slug, meta]) => (
              <TouchableOpacity key={slug} onPress={() => setSubject(slug)}
                style={[s.filterChip, subject === slug && s.filterChipActive]}>
                <Text style={[s.filterText, subject === slug && s.filterTextActive]}>
                  {meta.icon} {meta.label}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        )}

        {/* Level filter */}
        <View style={s.metaFilterRow}>
          <Text style={s.metaFilterLabel}>BY LEVEL:</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            <TouchableOpacity onPress={() => setLevel(undefined)}
              style={[s.pill, !level && s.pillActiveDark]}>
              <Text style={[s.pillText, !level && s.pillTextLight]}>All levels</Text>
            </TouchableOpacity>
            {levels.map((lv: any) => (
              <TouchableOpacity key={lv.slug} onPress={() => setLevel(lv.slug)}
                style={[s.pill, level === lv.slug && s.pillActiveDark]}>
                <Text style={[s.pillText, level === lv.slug && s.pillTextLight]}>{lv.label}</Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>

        {/* Interest filter */}
        <View style={s.metaFilterRow}>
          <Text style={s.metaFilterLabel}>BY INTEREST:</Text>
          <ScrollView horizontal showsHorizontalScrollIndicator={false}>
            <TouchableOpacity onPress={() => setInterest(undefined)}
              style={[s.pill, !interest && s.pillActiveDark]}>
              <Text style={[s.pillText, !interest && s.pillTextLight]}>All</Text>
            </TouchableOpacity>
            {interests.map((it: any) => (
              <TouchableOpacity key={it.slug} onPress={() => setInterest(it.slug)}
                style={[s.pill, interest === it.slug && s.pillActiveDark]}>
                <Text style={[s.pillText, interest === it.slug && s.pillTextLight]}>
                  {it.icon} {it.label}
                </Text>
              </TouchableOpacity>
            ))}
          </ScrollView>
        </View>

        {/* Content grid */}
        {isLoading ? (
          <View style={s.center}><ActivityIndicator color={colors.brand} size="large" /></View>
        ) : worksheets.length === 0 ? (
          <EmptyState emoji="📭" title="No items match these filters"
            body="Try a different grade, topic, or interest." />
        ) : (
          <View style={s.grid}>
            {worksheets.map((ws: any) => {
              const ctMeta   = CONTENT_TYPE_META[ws.content_type] ?? CONTENT_TYPE_META.worksheet;
              const social   = ws.social_badge ? SOCIAL_META[ws.social_badge] : null;
              const subjMeta = SUBJECT_META[ws.subject];
              const selected = selectedIds.has(ws.worksheet_id);
              return (
                <TouchableOpacity key={ws.worksheet_id} style={[s.card, selectMode && selected && s.cardSelected]}
                  onPress={() => selectMode ? toggleSelected(ws.worksheet_id) : openItem(ws)} activeOpacity={0.88}>
                  <View style={[s.thumb, { backgroundColor: subjMeta?.color ?? colors.brandLight }]}>
                    <Text style={s.thumbIcon}>{ws.content_type === "game" ? ctMeta.icon : (subjMeta?.icon ?? ctMeta.icon)}</Text>
                    <View style={s.typeBadge}>
                      <Text style={s.typeBadgeText}>{ctMeta.icon} {ctMeta.label}</Text>
                    </View>
                    {social && (
                      <View style={s.socialBadge}>
                        <Text style={s.socialBadgeText}>{social.icon} {social.label}</Text>
                      </View>
                    )}
                    {ws.is_trending && (
                      <View style={s.trendingBadge}>
                        <Text style={s.trendingBadgeText}>🔥 TRENDING</Text>
                      </View>
                    )}
                    {selectMode && (
                      <View style={[s.selectCheck, selected && s.selectCheckActive]}>
                        {selected && <Text style={s.selectCheckMark}>✓</Text>}
                      </View>
                    )}
                  </View>

                  <Text style={s.cardTitle} numberOfLines={2}>{ws.title}</Text>
                  <View style={s.cardMetaRow}>
                    <Text style={s.cardMetaTag}>
                      {subjMeta?.label ?? ws.subject}
                    </Text>
                    <Text style={s.cardMetaDim}>
                      {ws.page_count ? `${ws.page_count} pages · ` : ""}{ws.estimated_min} min
                    </Text>
                  </View>
                  <View style={s.cardStatsRow}>
                    <Text style={s.cardStat}>⭐ {Number(ws.rating_avg ?? 0).toFixed(1)}</Text>
                    <Text style={s.cardStat}>👁 {formatCount(ws.view_count)}</Text>
                    {ws.is_trending && <Text style={s.cardStat}>🔥 viral</Text>}
                  </View>

                  {!selectMode && (
                    <TouchableOpacity
                      style={s.assignBtn}
                      activeOpacity={0.8}
                      onPress={() => openAssign(ws)}
                    >
                      <Text style={s.assignBtnText}>📌 Assign to Kid</Text>
                    </TouchableOpacity>
                  )}
                </TouchableOpacity>
              );
            })}
          </View>
        )}
        <View style={{ height: selectMode ? 90 : 40 }} />
      </ScrollView>

      {/* Floating batch-print bar */}
      {selectMode && selectedIds.size > 0 && (
        <View style={s.printBar}>
          <Text style={s.printBarText}>{selectedIds.size} selected</Text>
          <TouchableOpacity
            style={[s.printBarBtn, printingBatch && s.btnDim]}
            disabled={printingBatch}
            onPress={printSelected}
          >
            <Text style={s.printBarBtnText}>{printingBatch ? "Preparing…" : `🖨️ Print ${selectedIds.size} worksheet${selectedIds.size === 1 ? "" : "s"}`}</Text>
          </TouchableOpacity>
        </View>
      )}

      {/* Worksheet preview — Play, Print, Assign, Download */}
      <WorksheetPreviewModal
        visible={!!previewWorksheet}
        worksheet={previewWorksheet}
        gradeLabel={GRADE_LABELS[previewWorksheet?.grade_id]}
        playLabel="Preview"
        assignLabel={`Assign to Kid`}
        onClose={() => setPreviewWorksheet(null)}
        onPlay={() => {
          if (previewWorksheet?.pdf_url) Linking.openURL(previewWorksheet.pdf_url);
        }}
        onPrint={() => {
          if (previewWorksheet?.pdf_url) printPdfUrl(previewWorksheet.pdf_url);
        }}
        onAssign={() => {
          const ws = previewWorksheet;
          setPreviewWorksheet(null);
          if (ws) openAssign(ws);
        }}
      />

      {/* Interactive game player */}
      <GamePlayerModal
        visible={!!playingGame}
        title={playingGame?.title}
        gameData={playingGame?.game_data}
        onClose={() => setPlayingGame(null)}
      />

      {/* Assign-to-student modal */}
      <Modal visible={!!assignTarget} animationType="slide" transparent onRequestClose={() => setAssignTarget(null)}>
        <View style={s.modalBackdrop}>
          <View style={s.modalSheet}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Assign worksheet</Text>
              <TouchableOpacity onPress={() => setAssignTarget(null)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>
            <Text style={s.modalWsTitle} numberOfLines={2}>{assignTarget?.title}</Text>

            <Text style={s.label}>Assign to:</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 14 }}>
              {(children as any[]).map(c => (
                <TouchableOpacity
                  key={c.child_id}
                  onPress={() => setAssignChildId(c.child_id)}
                  style={[s.childChipModal, assignChildId === c.child_id && s.childChipModalActive]}
                >
                  <Text style={[s.childChipText, assignChildId === c.child_id && s.childChipTextActive]}>
                    {c.nickname}
                  </Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <TextInput
              style={s.noteInput}
              placeholder={'Optional note (e.g. "Do this after dinner")'}
              value={assignNote}
              onChangeText={setAssignNote}
            />

            <TouchableOpacity
              style={[s.submitBtn, (!assignChildId || assigning) && s.btnDim]}
              disabled={!assignChildId || assigning}
              onPress={submitAssign}
            >
              <Text style={s.submitBtnText}>{assigning ? "Assigning…" : "Assign"}</Text>
            </TouchableOpacity>
          </View>
        </View>
      </Modal>

      {/* Upload-your-own-worksheet modal */}
      <Modal visible={uploadOpen} animationType="slide" transparent onRequestClose={() => setUploadOpen(false)}>
        <View style={s.modalBackdrop}>
          <View style={s.modalSheet}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Upload a worksheet</Text>
              <TouchableOpacity onPress={() => setUploadOpen(false)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>

            <ScrollView>
              <Text style={s.uploadHint}>PDF or image (jpg/png) — up to 15MB</Text>
              <TouchableOpacity style={s.filePickBtn} onPress={pickUploadFile}>
                <Text style={s.filePickBtnText}>
                  {uploadFile ? `📎 ${uploadFile.name}` : "Choose a file…"}
                </Text>
              </TouchableOpacity>

              <Text style={s.label}>Assign to:</Text>
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 14 }}>
                {(children as any[]).map(c => (
                  <TouchableOpacity
                    key={c.child_id}
                    onPress={() => setUploadChildId(c.child_id)}
                    style={[s.childChipModal, uploadChildId === c.child_id && s.childChipModalActive]}
                  >
                    <Text style={[s.childChipText, uploadChildId === c.child_id && s.childChipTextActive]}>
                      {c.nickname}
                    </Text>
                  </TouchableOpacity>
                ))}
              </ScrollView>

              <TextInput
                style={s.noteInput}
                placeholder="Title (optional — defaults to filename)"
                value={uploadTitle}
                onChangeText={setUploadTitle}
              />

              <Text style={s.label}>Subject (optional)</Text>
              <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 14 }}>
                <TouchableOpacity
                  onPress={() => setUploadSubject(null)}
                  style={[s.childChipModal, uploadSubject === null && s.childChipModalActive]}
                >
                  <Text style={[s.childChipText, uploadSubject === null && s.childChipTextActive]}>Workbooks</Text>
                </TouchableOpacity>
                {UPLOAD_SUBJECT_CHIPS.map(slug => (
                  <TouchableOpacity
                    key={slug}
                    onPress={() => setUploadSubject(slug)}
                    style={[s.childChipModal, uploadSubject === slug && s.childChipModalActive]}
                  >
                    <Text style={[s.childChipText, uploadSubject === slug && s.childChipTextActive]}>
                      {SUBJECT_META[slug]?.icon} {SUBJECT_META[slug]?.label}
                    </Text>
                  </TouchableOpacity>
                ))}
              </ScrollView>

              <TextInput
                style={s.noteInput}
                placeholder={'Optional note (e.g. "From grandma")'}
                value={uploadNote}
                onChangeText={setUploadNote}
              />

              <TouchableOpacity
                style={[s.submitBtn, (!uploadFile || !uploadChildId || uploadingFile) && s.btnDim]}
                disabled={!uploadFile || !uploadChildId || uploadingFile}
                onPress={submitUpload}
              >
                <Text style={s.submitBtnText}>{uploadingFile ? "Uploading…" : "Upload & assign"}</Text>
              </TouchableOpacity>
            </ScrollView>
          </View>
        </View>
      </Modal>
    </View>
  );
}

const s = StyleSheet.create({
  root:   { flex: 1, backgroundColor: "#f8f7ff" },
  header: {
    backgroundColor: "white",
    paddingTop: Platform.OS === "ios" ? 56 : 20,
    paddingBottom: 16, paddingHorizontal: 20,
    borderBottomWidth: 1, borderBottomColor: colors.border,
  },
  title: { fontSize: 22, fontWeight: "900", color: colors.text },
  sub:   { fontSize: 13, color: colors.textMuted, marginTop: 2 },

  featuredScroll: { backgroundColor: colors.brandLight, paddingVertical: 16 },
  featuredCard:   { width: 150, backgroundColor: "white", borderRadius: 16, padding: 12,
                    shadowColor: "#000", shadowOpacity: 0.06, shadowRadius: 8, elevation: 2 },
  featuredIconWrap: { width: "100%", height: 80, borderRadius: 12, alignItems: "center",
                      justifyContent: "center", marginBottom: 8 },
  featuredIcon:   { fontSize: 36 },
  featuredTitle:  { fontSize: 13, fontWeight: "800", color: colors.text, marginBottom: 2 },
  featuredSub:    { fontSize: 11, color: colors.textMuted, fontWeight: "600" },

  gradeScroll:        { backgroundColor: "white", paddingVertical: 10,
                        borderBottomWidth: 1, borderBottomColor: colors.border },
  gradeTab:           { paddingHorizontal: 16, paddingVertical: 8, borderRadius: 20,
                        marginRight: 6, backgroundColor: "#f0f0f0" },
  gradeTabActive:     { backgroundColor: colors.brand },
  gradeTabText:       { fontSize: 13, fontWeight: "700", color: colors.textMuted },
  gradeTabTextActive: { color: "white" },

  filterScroll:        { backgroundColor: "white", paddingVertical: 10,
                         borderBottomWidth: 1, borderBottomColor: colors.border },
  quickChip:           { paddingHorizontal: 14, paddingVertical: 7, borderRadius: 16,
                         marginRight: 6, backgroundColor: colors.brand + "1a" },
  quickChipActive:     { backgroundColor: colors.brand },
  filterChip:          { paddingHorizontal: 14, paddingVertical: 6, borderRadius: 16,
                         marginRight: 6, backgroundColor: "#f0f0f0" },
  filterChipActive:    { backgroundColor: colors.brandLight },
  filterText:          { fontSize: 12, fontWeight: "600", color: colors.textMuted },
  filterTextActive:    { color: "white" },

  metaFilterRow:   { flexDirection: "row", alignItems: "center", backgroundColor: "white",
                     paddingVertical: 8, paddingHorizontal: 12, gap: 10,
                     borderBottomWidth: 1, borderBottomColor: colors.border },
  metaFilterLabel: { fontSize: 10, fontWeight: "800", color: colors.textMuted, letterSpacing: 0.5 },
  pill:            { paddingHorizontal: 12, paddingVertical: 5, borderRadius: 14,
                     marginRight: 6, backgroundColor: "#f0f0f0" },
  pillActiveDark:  { backgroundColor: colors.text },
  pillText:        { fontSize: 12, fontWeight: "600", color: colors.textMuted },
  pillTextLight:   { color: "white" },

  center: { paddingVertical: 60, justifyContent: "center", alignItems: "center" },

  grid: { flexDirection: "row", flexWrap: "wrap", padding: 12, gap: 12 },
  card: { width: "47%", backgroundColor: "white", borderRadius: 16, padding: 10,
          shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 8, elevation: 2 },
  thumb: { height: 110, borderRadius: 12, alignItems: "center", justifyContent: "center",
           marginBottom: 8, position: "relative" },
  thumbIcon: { fontSize: 40 },
  typeBadge: { position: "absolute", top: 6, right: 6, backgroundColor: "rgba(255,255,255,0.92)",
               borderRadius: 10, paddingHorizontal: 8, paddingVertical: 3 },
  typeBadgeText: { fontSize: 10, fontWeight: "800", color: colors.text },
  socialBadge: { position: "absolute", top: 6, left: 6, backgroundColor: "rgba(43,42,39,0.75)",
                 borderRadius: 10, paddingHorizontal: 8, paddingVertical: 3 },
  socialBadgeText: { fontSize: 10, fontWeight: "700", color: "white" },
  trendingBadge: { position: "absolute", bottom: 6, left: 6, backgroundColor: colors.brand,
                   borderRadius: 10, paddingHorizontal: 8, paddingVertical: 3 },
  trendingBadgeText: { fontSize: 10, fontWeight: "800", color: "white" },

  cardTitle:    { fontSize: 14, fontWeight: "800", color: colors.text, marginBottom: 6, lineHeight: 18 },
  cardMetaRow:  { flexDirection: "row", alignItems: "center", justifyContent: "space-between", marginBottom: 6 },
  cardMetaTag:  { fontSize: 11, fontWeight: "700", color: colors.brand },
  cardMetaDim:  { fontSize: 11, color: colors.textMuted },
  cardStatsRow: { flexDirection: "row", gap: 10 },
  cardStat:     { fontSize: 11, fontWeight: "700", color: colors.textMuted },

  assignBtn:     { marginTop: 10, borderWidth: 1.5, borderColor: colors.brand, borderRadius: 10,
                   paddingVertical: 8, alignItems: "center" },
  assignBtnText: { fontSize: 12, fontWeight: "800", color: colors.brand },

  cardSelected:  { borderWidth: 2, borderColor: colors.brand },
  selectCheck:   { position: "absolute", top: 8, right: 8, width: 24, height: 24, borderRadius: 12,
                   backgroundColor: "rgba(255,255,255,0.85)", borderWidth: 2, borderColor: colors.brand,
                   alignItems: "center", justifyContent: "center" },
  selectCheckActive: { backgroundColor: colors.brand },
  selectCheckMark:   { color: "white", fontWeight: "900", fontSize: 13 },

  printBar:     { position: "absolute", left: 16, right: 16, bottom: 16, backgroundColor: colors.text,
                  borderRadius: 16, padding: 16, flexDirection: "row", alignItems: "center", justifyContent: "space-between",
                  shadowColor: "#000", shadowOpacity: 0.25, shadowRadius: 16, elevation: 6 },
  printBarText: { color: "white", fontWeight: "700", fontSize: 13 },
  printBarBtn:  { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 16, paddingVertical: 10 },
  printBarBtnText: { color: "white", fontWeight: "800", fontSize: 13 },

  modalBackdrop: { flex: 1, backgroundColor: "rgba(0,0,0,0.4)", justifyContent: "flex-end" },
  modalSheet:    { backgroundColor: "white", borderTopLeftRadius: 20, borderTopRightRadius: 20, padding: 20 },
  modalHeader:   { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 10 },
  modalTitle:    { fontSize: 18, fontWeight: "900", color: colors.text },
  modalClose:    { fontSize: 20, color: colors.textMuted, padding: 4 },
  modalWsTitle:  { fontSize: 14, color: colors.textMuted, marginBottom: 16, lineHeight: 20 },
  label:         { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  childChipModal:{ borderWidth: 1.5, borderColor: colors.border, borderRadius: 20,
                   paddingHorizontal: 16, paddingVertical: 9, marginRight: 8, backgroundColor: "white" },
  childChipModalActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  childChipText: { fontSize: 13, fontWeight: "700", color: colors.textMuted },
  childChipTextActive: { color: colors.brand },
  noteInput:     { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 14,
                   paddingVertical: 12, fontSize: 14, color: colors.text, marginBottom: 14 },
  submitBtn:     { backgroundColor: colors.brand, borderRadius: 10, paddingVertical: 14, alignItems: "center" },
  btnDim:        { opacity: 0.6 },
  submitBtnText: { color: "white", fontWeight: "800", fontSize: 15 },

  selectHint: { fontSize: 12, color: colors.textMuted, marginTop: 8 },
  uploadHeaderBtnActive: { backgroundColor: colors.text },
  uploadHeaderBtnTextActive: { color: "white" },
  uploadHeaderBtn: { backgroundColor: colors.brand, borderRadius: 10, paddingHorizontal: 14,
                     paddingVertical: 10, marginLeft: 12 },
  uploadHeaderBtnText: { color: "white", fontWeight: "800", fontSize: 12 },
  uploadHint: { fontSize: 12, color: colors.textMuted, marginBottom: 10 },
  filePickBtn: { borderWidth: 1.5, borderColor: colors.border, borderStyle: "dashed", borderRadius: 12,
                 paddingVertical: 18, alignItems: "center", marginBottom: 14, backgroundColor: "#f8f7ff" },
  filePickBtnText: { fontSize: 14, fontWeight: "700", color: colors.text },
});
