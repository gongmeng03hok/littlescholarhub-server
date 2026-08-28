/**
 * Admin User Manager
 * List families · filter by role/plan · promote/demote role
 * GET /api/admin/users · PUT /api/admin/users/:id/role
 */
import { useState } from "react";
import {
  View, Text, ScrollView, TouchableOpacity, TextInput, Modal,
  StyleSheet, ActivityIndicator, Alert, Platform,
} from "react-native";
import { useRouter } from "expo-router";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { adminApi }       from "../../api/admin";
import { useAdminUsers }  from "../../hooks/useApi";
import { useAuthStore }   from "../../store/authStore";
import { useChildStore }  from "../../store/childStore";
import { confirmAction }  from "../../utils/confirm";
import { colors, GRADES } from "../../constants/theme";

const ROLE_FILTER = ["all","admin","parent","teacher"] as const;
const PLAN_FILTER = ["all","explorer","family","shipped"] as const;

export default function UserManager() {
  const qc = useQueryClient();
  const [search,      setSearch]      = useState("");
  const [roleFilter,  setRoleFilter]  = useState<string>("all");
  const [planFilter,  setPlanFilter]  = useState<string>("all");
  const [expanding,   setExpanding]   = useState<number | null>(null);

  const { data: users = [], isLoading, refetch } = useAdminUsers();

  const { data: pendingTeachers = [] } = useQuery({
    queryKey: ["adminPendingTeachers"],
    queryFn: () => adminApi.listPendingTeachers(),
  });

  const { mutate: approveTeacher, isPending: approvingTeacher } = useMutation({
    mutationFn: (id: number) => adminApi.approveTeacher(id),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["adminPendingTeachers"] });
      qc.invalidateQueries({ queryKey: ["adminUsers"] });
    },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const { mutate: denyTeacher, isPending: denyingTeacher } = useMutation({
    mutationFn: (id: number) => adminApi.denyTeacher(id),
    onSuccess: () => qc.invalidateQueries({ queryKey: ["adminPendingTeachers"] }),
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const confirmDenyTeacher = (teacher: any) => {
    confirmAction(
      "Deny teacher registration?",
      `${teacher.email}'s pending registration will be removed.`,
      () => denyTeacher(teacher.family_id), "Deny",
    );
  };

  const { mutate: setRole, isPending: settingRole } = useMutation({
    mutationFn: ({ id, role }: { id: number; role: string }) =>
      adminApi.setUserRole(id, role),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["adminUsers"] });
      setExpanding(null);
    },
    onError: (e: any) => Alert.alert("Error", e.message),
  });

  const confirmRoleChange = (user: any, newRole: string) => {
    const label = newRole === "admin" ? "promote to Admin" : "demote to Parent";
    const labelCap = label.charAt(0).toUpperCase() + label.slice(1);
    confirmAction(
      `${labelCap}?`,
      `${user.email} will be ${newRole === "admin" ? "an admin with full CMS access" : "a regular parent account"}.`,
      () => setRole({ id: user.family_id, role: newRole }),
      labelCap, newRole !== "admin",
    );
  };

  // Children under an expanded parent row
  const { data: expandedChildren = [], isLoading: childrenLoading } = useQuery({
    queryKey: ["adminFamilyChildren", expanding],
    queryFn:  () => adminApi.getFamilyChildren(expanding!),
    enabled:  !!expanding,
  });

  // Classrooms/students under an expanded teacher row
  const { data: expandedClassrooms = [], isLoading: classroomsLoading } = useQuery({
    queryKey: ["adminFamilyClassrooms", expanding],
    queryFn:  () => adminApi.getFamilyClassrooms(expanding!),
    enabled:  !!expanding,
  });

  // Edit-child modal
  const [editChild, setEditChild] = useState<any | null>(null);
  const [editNickname, setEditNickname] = useState("");
  const [editGradeId, setEditGradeId] = useState<number>(2);

  const openEditChild = (child: any) => {
    setEditChild(child);
    setEditNickname(child.nickname);
    setEditGradeId(child.grade_id);
  };

  const { mutate: saveChild, isPending: savingChild } = useMutation({
    mutationFn: () => adminApi.updateChild(editChild.child_id, { nickname: editNickname.trim(), grade_id: editGradeId }),
    onSuccess: () => {
      qc.invalidateQueries({ queryKey: ["adminFamilyChildren", expanding] });
      setEditChild(null);
    },
    onError: (e: any) => Alert.alert("Couldn't update child", e.message),
  });

  // Impersonation
  const router = useRouter();
  const { impersonate } = useAuthStore();
  const { mutate: startImpersonate, isPending: impersonating } = useMutation({
    mutationFn: (familyId: number) => adminApi.impersonate(familyId),
    onSuccess: async (data: any) => {
      await impersonate(data.token, { family_id: data.family_id, email: data.email, role: data.role }, data.role);
      // Every cached query (children, assignments, progress, …) was fetched
      // under the admin's own identity/token — none of it applies to the
      // impersonated account, so drop it all and let screens refetch fresh.
      qc.clear();
      useChildStore.getState().setChildren([]);
      router.replace(data.role === "teacher" ? "/(teacher)" : "/(parent)");
    },
    onError: (e: any) => Alert.alert("Couldn't impersonate", e.message),
  });

  const confirmImpersonate = (user: any) => {
    confirmAction(
      "View as this account?",
      `You'll see the app exactly as ${user.email} does. You can return to your admin account anytime.`,
      () => startImpersonate(user.family_id),
      "Impersonate", false,
    );
  };

  const filtered = (users as any[]).filter(u => {
    const matchSearch = !search || u.email?.toLowerCase().includes(search.toLowerCase());
    const matchRole   = roleFilter === "all" || u.role === roleFilter;
    const matchPlan   = planFilter === "all" || u.plann === planFilter;
    return matchSearch && matchRole && matchPlan;
  });

  const planColor: Record<string, string> = {
    explorer: "#f0f0f0",
    family:   colors.brandLight,
    shipped:  "#fef9c3",
  };

  return (
    <View style={s.root}>
      {/* Header */}
      <View style={s.header}>
        <Text style={s.title}>👥 Users</Text>
        <Text style={s.count}>{(users as any[]).length} total</Text>
      </View>

      {/* Pending teacher approvals */}
      {(pendingTeachers as any[]).length > 0 && (
        <View style={s.pendingWrap}>
          <Text style={s.pendingTitle}>🎓 Pending teacher approvals ({(pendingTeachers as any[]).length})</Text>
          {(pendingTeachers as any[]).map((t: any) => (
            <View key={t.family_id} style={s.pendingRow}>
              <View style={{ flex: 1 }}>
                <Text style={s.pendingName}>{t.teacher_name || t.email}</Text>
                <Text style={s.pendingMeta}>{t.email}{t.teacher_school ? ` · ${t.teacher_school}` : ""}</Text>
              </View>
              <TouchableOpacity
                style={s.approveBtn}
                onPress={() => approveTeacher(t.family_id)}
                disabled={approvingTeacher || denyingTeacher}
              >
                <Text style={s.approveBtnText}>Approve</Text>
              </TouchableOpacity>
              <TouchableOpacity
                style={s.denyBtn}
                onPress={() => confirmDenyTeacher(t)}
                disabled={approvingTeacher || denyingTeacher}
              >
                <Text style={s.denyBtnText}>Deny</Text>
              </TouchableOpacity>
            </View>
          ))}
        </View>
      )}

      {/* Search */}
      <View style={s.searchWrap}>
        <TextInput
          style={s.search} placeholder="Search by email…"
          placeholderTextColor={colors.textMuted}
          value={search} onChangeText={setSearch}
          autoCapitalize="none" keyboardType="email-address"
        />
      </View>

      {/* Filters */}
      <View style={s.filterBar}>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          <View style={s.filterGroup}>
            <Text style={s.filterLabel}>Role:</Text>
            {ROLE_FILTER.map(r => (
              <TouchableOpacity key={r}
                style={[s.filterChip, roleFilter === r && s.filterChipActive]}
                onPress={() => setRoleFilter(r)}
              >
                <Text style={[s.filterChipText, roleFilter === r && s.filterChipTextActive]}>
                  {r === "admin" ? "🔑 Admin" : r === "parent" ? "👨‍👩‍👧 Parent" : r === "teacher" ? "🎓 Teacher" : "All roles"}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </ScrollView>
        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginTop: 6 }}>
          <View style={s.filterGroup}>
            <Text style={s.filterLabel}>Plan:</Text>
            {PLAN_FILTER.map(p => (
              <TouchableOpacity key={p}
                style={[s.filterChip, planFilter === p && s.filterChipActive]}
                onPress={() => setPlanFilter(p)}
              >
                <Text style={[s.filterChipText, planFilter === p && s.filterChipTextActive]}>
                  {p === "all" ? "All plans" : p.charAt(0).toUpperCase() + p.slice(1)}
                </Text>
              </TouchableOpacity>
            ))}
          </View>
        </ScrollView>
      </View>

      {/* Results count */}
      <View style={s.resultsBar}>
        <Text style={s.resultsText}>
          {filtered.length} {filtered.length === 1 ? "user" : "users"}
          {(search || roleFilter !== "all" || planFilter !== "all") ? " (filtered)" : ""}
        </Text>
        {(search || roleFilter !== "all" || planFilter !== "all") && (
          <TouchableOpacity onPress={() => { setSearch(""); setRoleFilter("all"); setPlanFilter("all"); }}>
            <Text style={s.clearFilter}>Clear</Text>
          </TouchableOpacity>
        )}
      </View>

      {isLoading ? (
        <View style={s.center}><ActivityIndicator size="large" color={colors.brand} /></View>
      ) : (
        <ScrollView contentContainerStyle={s.list} showsVerticalScrollIndicator={false}>
          {filtered.length === 0 && (
            <View style={s.center}>
              <Text style={{ fontSize: 40, marginBottom: 12 }}>🔍</Text>
              <Text style={s.emptyText}>No users match this filter.</Text>
            </View>
          )}
          {filtered.map((user: any) => {
            const isExpanded = expanding === user.family_id;
            const isAdmin    = user.role === "admin";
            return (
              <TouchableOpacity
                key={user.family_id}
                style={[s.row, isAdmin && s.rowAdmin]}
                onPress={() => setExpanding(isExpanded ? null : user.family_id)}
                activeOpacity={0.85}
              >
                {/* Row summary */}
                <View style={s.rowTop}>
                  <View style={s.rowLeft}>
                    <View style={s.emailRow}>
                      {isAdmin && <Text style={s.adminBadge}>🔑</Text>}
                      <Text style={s.email} numberOfLines={1}>{user.email}</Text>
                    </View>
                    <View style={s.rowMeta}>
                      <Text style={[s.planBadge, { backgroundColor: planColor[user.plann] ?? "#f0f0f0" }]}>
                        {user.plann ?? "explorer"}
                      </Text>
                      <Text style={s.roleBadge}>{user.role ?? "parent"}</Text>
                      {user.created_at && (
                        <Text style={s.dateBadge}>
                          joined {new Date(user.created_at).toLocaleDateString()}
                        </Text>
                      )}
                    </View>
                  </View>
                  <Text style={s.chevron}>{isExpanded ? "▲" : "▼"}</Text>
                </View>

                {/* Expanded actions */}
                {isExpanded && (
                  <View style={s.expanded}>
                    <Text style={s.expandedLabel}>Family ID: {user.family_id}</Text>
                    {user.trial_ends_at && (
                      <Text style={s.expandedLabel}>
                        Trial ends: {new Date(user.trial_ends_at).toLocaleDateString()}
                      </Text>
                    )}

                    {/* Parent → list of kids */}
                    {user.role === "parent" && (
                      <View style={s.subSection}>
                        <Text style={s.subSectionTitle}>👶 Kids</Text>
                        {childrenLoading ? (
                          <ActivityIndicator color={colors.brand} style={{ marginVertical: 8 }} />
                        ) : expandedChildren.length === 0 ? (
                          <Text style={s.subEmpty}>No children added yet.</Text>
                        ) : (
                          (expandedChildren as any[]).map(child => (
                            <TouchableOpacity
                              key={child.child_id}
                              style={s.childRow}
                              onPress={(e: any) => { e.stopPropagation?.(); openEditChild(child); }}
                            >
                              <Text style={s.childName}>{child.nickname}</Text>
                              <Text style={s.childGrade}>{child.grade_label}</Text>
                              <Text style={s.childEdit}>Edit ✎</Text>
                            </TouchableOpacity>
                          ))
                        )}
                      </View>
                    )}

                    {/* Teacher → classrooms + students */}
                    {user.role === "teacher" && (
                      <View style={s.subSection}>
                        <Text style={s.subSectionTitle}>🏫 Classrooms</Text>
                        {classroomsLoading ? (
                          <ActivityIndicator color={colors.brand} style={{ marginVertical: 8 }} />
                        ) : expandedClassrooms.length === 0 ? (
                          <Text style={s.subEmpty}>No classrooms created yet.</Text>
                        ) : (
                          (expandedClassrooms as any[]).map((room: any) => (
                            <View key={room.classroom_id} style={s.classroomBlock}>
                              <Text style={s.classroomName}>
                                {room.classroom_name} · {room.school_name || "No school set"} ({room.classroom_code})
                              </Text>
                              {room.students.length === 0 ? (
                                <Text style={s.subEmpty}>No students yet.</Text>
                              ) : (
                                room.students.map((st: any) => (
                                  <Text key={st.child_id} style={s.studentRow}>
                                    · {st.nickname} ({st.grade_label})
                                  </Text>
                                ))
                              )}
                            </View>
                          ))
                        )}
                      </View>
                    )}

                    <View style={s.actionRow}>
                      {!isAdmin ? (
                        <TouchableOpacity
                          style={s.promoteBtn}
                          onPress={() => confirmRoleChange(user, "admin")}
                          disabled={settingRole}
                        >
                          <Text style={s.promoteBtnText}>🔑 Promote to Admin</Text>
                        </TouchableOpacity>
                      ) : (
                        <TouchableOpacity
                          style={s.demoteBtn}
                          onPress={() => confirmRoleChange(user, "parent")}
                          disabled={settingRole}
                        >
                          <Text style={s.demoteBtnText}>↓ Demote to Parent</Text>
                        </TouchableOpacity>
                      )}
                      {(user.role === "parent" || user.role === "teacher") && (
                        <TouchableOpacity
                          style={s.impersonateBtn}
                          onPress={() => confirmImpersonate(user)}
                          disabled={impersonating}
                        >
                          <Text style={s.impersonateBtnText}>🕵️ View as this account</Text>
                        </TouchableOpacity>
                      )}
                    </View>
                  </View>
                )}
              </TouchableOpacity>
            );
          })}
          <View style={{ height: 40 }} />
        </ScrollView>
      )}

      {/* Edit child modal */}
      <Modal visible={!!editChild} animationType="slide" transparent onRequestClose={() => setEditChild(null)}>
        <View style={s.modalBackdrop}>
          <View style={s.modalSheet}>
            <View style={s.modalHeader}>
              <Text style={s.modalTitle}>Edit child profile</Text>
              <TouchableOpacity onPress={() => setEditChild(null)}>
                <Text style={s.modalClose}>✕</Text>
              </TouchableOpacity>
            </View>

            <Text style={s.label}>Nickname</Text>
            <TextInput style={s.input} value={editNickname} onChangeText={setEditNickname} />

            <Text style={s.label}>Grade</Text>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 16 }}>
              {GRADES.map(g => (
                <TouchableOpacity
                  key={g.grade_id}
                  onPress={() => setEditGradeId(g.grade_id)}
                  style={[s.gradeChip, editGradeId === g.grade_id && s.gradeChipActive]}
                >
                  <Text style={[s.gradeChipText, editGradeId === g.grade_id && s.gradeChipTextActive]}>{g.label}</Text>
                </TouchableOpacity>
              ))}
            </ScrollView>

            <TouchableOpacity
              style={[s.saveBtn, (!editNickname.trim() || savingChild) && s.btnDim]}
              disabled={!editNickname.trim() || savingChild}
              onPress={() => saveChild()}
            >
              <Text style={s.saveBtnText}>{savingChild ? "Saving…" : "Save changes"}</Text>
            </TouchableOpacity>
          </View>
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
               paddingBottom: 14, paddingHorizontal: 20,
               flexDirection: "row", alignItems: "center", justifyContent: "space-between",
               borderBottomWidth: 1, borderBottomColor: colors.border },
  title:     { fontSize: 20, fontWeight: "900", color: colors.text },
  count:     { fontSize: 13, color: colors.textMuted, fontWeight: "600" },

  pendingWrap: { backgroundColor: "#fffbeb", paddingHorizontal: 16, paddingVertical: 12,
                 borderBottomWidth: 1, borderBottomColor: colors.border, gap: 8 },
  pendingTitle:{ fontSize: 13, fontWeight: "800", color: "#92400e", marginBottom: 4 },
  pendingRow:  { flexDirection: "row", alignItems: "center", gap: 8,
                 backgroundColor: "white", borderRadius: 10, padding: 10 },
  pendingName: { fontSize: 13, fontWeight: "700", color: colors.text },
  pendingMeta: { fontSize: 11, color: colors.textMuted, marginTop: 2 },
  approveBtn:  { backgroundColor: colors.brand, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 8 },
  approveBtnText: { color: "white", fontSize: 12, fontWeight: "800" },
  denyBtn:     { backgroundColor: "#fee2e2", borderRadius: 8, paddingHorizontal: 12, paddingVertical: 8,
                 borderWidth: 1, borderColor: colors.danger },
  denyBtnText: { color: colors.danger, fontSize: 12, fontWeight: "800" },

  searchWrap:{ backgroundColor: "white", paddingHorizontal: 16, paddingVertical: 10,
               borderBottomWidth: 1, borderBottomColor: colors.border },
  search:    { backgroundColor: "#f0f0f0", borderRadius: 10, paddingHorizontal: 14,
               paddingVertical: 10, fontSize: 14, color: colors.text },

  filterBar: { backgroundColor: "white", paddingHorizontal: 16, paddingVertical: 10,
               borderBottomWidth: 1, borderBottomColor: colors.border },
  filterGroup:     { flexDirection: "row", alignItems: "center", gap: 6 },
  filterLabel:     { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginRight: 4 },
  filterChip:      { paddingHorizontal: 12, paddingVertical: 6, borderRadius: 14, backgroundColor: "#f0f0f0" },
  filterChipActive:{ backgroundColor: colors.brandLight },
  filterChipText:  { fontSize: 12, fontWeight: "700", color: colors.textMuted },
  filterChipTextActive: { color: colors.brand },

  resultsBar:  { flexDirection: "row", justifyContent: "space-between", alignItems: "center",
                 paddingHorizontal: 16, paddingVertical: 8, backgroundColor: "#f8f7ff" },
  resultsText: { fontSize: 12, color: colors.textMuted, fontWeight: "600" },
  clearFilter: { fontSize: 12, color: colors.brand, fontWeight: "700" },

  list: { padding: 16, gap: 10 },
  row:  { backgroundColor: "white", borderRadius: 14, padding: 16,
          shadowColor: "#000", shadowOpacity: 0.05, shadowRadius: 6, elevation: 2 },
  rowAdmin: { borderWidth: 2, borderColor: colors.accent },
  rowTop:   { flexDirection: "row", alignItems: "center" },
  rowLeft:  { flex: 1 },
  emailRow: { flexDirection: "row", alignItems: "center", gap: 6, marginBottom: 6 },
  adminBadge: { fontSize: 14 },
  email:    { fontSize: 14, fontWeight: "700", color: colors.text, flex: 1 },
  rowMeta:  { flexDirection: "row", flexWrap: "wrap", gap: 6 },
  planBadge:{ fontSize: 11, fontWeight: "700", color: colors.text, borderRadius: 6,
              paddingHorizontal: 8, paddingVertical: 3 },
  roleBadge:{ fontSize: 11, fontWeight: "700", color: colors.brand, backgroundColor: colors.brandLight,
              borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3 },
  dateBadge:{ fontSize: 11, color: colors.textMuted, backgroundColor: "#f0f0f0",
              borderRadius: 6, paddingHorizontal: 8, paddingVertical: 3 },
  chevron:  { fontSize: 14, color: colors.textMuted, marginLeft: 8 },

  expanded:     { borderTopWidth: 1, borderTopColor: colors.border, marginTop: 12, paddingTop: 12 },
  expandedLabel:{ fontSize: 12, color: colors.textMuted, marginBottom: 4 },
  actionRow:    { flexDirection: "row", gap: 10, marginTop: 8 },
  promoteBtn:   { flex: 1, backgroundColor: "#fef9c3", borderRadius: 10,
                  paddingVertical: 10, alignItems: "center",
                  borderWidth: 1, borderColor: "#d97706" },
  promoteBtnText:{ fontSize: 13, fontWeight: "800", color: "#92400e" },
  demoteBtn:    { flex: 1, backgroundColor: "#fee2e2", borderRadius: 10,
                  paddingVertical: 10, alignItems: "center",
                  borderWidth: 1, borderColor: colors.danger },
  demoteBtnText:{ fontSize: 13, fontWeight: "800", color: colors.danger },
  impersonateBtn: { flex: 1, backgroundColor: "#1a1a2e", borderRadius: 10,
                    paddingVertical: 10, alignItems: "center" },
  impersonateBtnText: { fontSize: 13, fontWeight: "800", color: "white" },

  subSection: { marginTop: 8, marginBottom: 8, backgroundColor: "#f8f7ff", borderRadius: 10, padding: 12 },
  subSectionTitle: { fontSize: 12, fontWeight: "800", color: colors.text, marginBottom: 6 },
  subEmpty: { fontSize: 12, color: colors.textMuted },
  childRow: { flexDirection: "row", alignItems: "center", paddingVertical: 8,
              borderBottomWidth: 1, borderBottomColor: colors.border },
  childName: { flex: 1, fontSize: 13, fontWeight: "700", color: colors.text },
  childGrade: { fontSize: 12, color: colors.textMuted, marginRight: 10 },
  childEdit: { fontSize: 12, fontWeight: "700", color: colors.brand },
  classroomBlock: { marginBottom: 10 },
  classroomName: { fontSize: 12, fontWeight: "800", color: colors.text, marginBottom: 4 },
  studentRow: { fontSize: 12, color: colors.textMuted, marginLeft: 6, marginBottom: 2 },

  modalBackdrop: { flex: 1, backgroundColor: "rgba(0,0,0,0.4)", justifyContent: "flex-end" },
  modalSheet:    { backgroundColor: "white", borderTopLeftRadius: 20, borderTopRightRadius: 20, padding: 20 },
  modalHeader:   { flexDirection: "row", justifyContent: "space-between", alignItems: "center", marginBottom: 16 },
  modalTitle:    { fontSize: 18, fontWeight: "900", color: colors.text },
  modalClose:    { fontSize: 20, color: colors.textMuted, padding: 4 },
  label:         { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginBottom: 8 },
  input:         { borderWidth: 1.5, borderColor: colors.border, borderRadius: 10, paddingHorizontal: 14,
                   paddingVertical: 12, fontSize: 14, color: colors.text, marginBottom: 16 },
  gradeChip:     { borderWidth: 1.5, borderColor: colors.border, borderRadius: 20,
                   paddingHorizontal: 14, paddingVertical: 8, marginRight: 8, backgroundColor: "white" },
  gradeChipActive: { borderColor: colors.brand, backgroundColor: colors.brandLight },
  gradeChipText: { fontSize: 13, fontWeight: "700", color: colors.textMuted },
  gradeChipTextActive: { color: colors.brand },
  saveBtn:       { backgroundColor: colors.brand, borderRadius: 10, paddingVertical: 14, alignItems: "center" },
  btnDim:        { opacity: 0.6 },
  saveBtnText:   { color: "white", fontWeight: "800", fontSize: 15 },
});
