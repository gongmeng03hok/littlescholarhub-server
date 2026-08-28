import { TouchableOpacity, View, Text, StyleSheet } from "react-native";
import { useRouter } from "expo-router";
import { colors, SUBJECT_META } from "../constants/theme";

interface Props {
  slug: string;
  gradeId?: number;
  kidMode?: boolean;
}

export function SubjectCard({ slug, gradeId = 2, kidMode }: Props) {
  const router  = useRouter();
  const meta    = SUBJECT_META[slug];
  if (!meta) return null;

  const go = () =>
    router.push(kidMode
      ? { pathname: "/(kid)/practice/[subject]",   params: { subject: slug, grade: gradeId } }
      : { pathname: "/(parent)/practice/[subject]", params: { subject: slug, grade: gradeId } }
    );

  return (
    <TouchableOpacity
      onPress={go}
      activeOpacity={0.85}
      style={[s.card, { backgroundColor: meta.color }, kidMode && s.kidCard]}
    >
      <Text style={[s.icon, kidMode && s.kidIcon]}>{meta.icon}</Text>
      <Text style={[s.label, kidMode && s.kidLabel]}>{meta.label}</Text>
    </TouchableOpacity>
  );
}

const s = StyleSheet.create({
  card:     { flex: 1, borderRadius: 16, padding: 16, alignItems: "center", justifyContent: "center", minHeight: 100 },
  icon:     { fontSize: 32, marginBottom: 8 },
  label:    { fontSize: 13, fontWeight: "700", color: colors.text, textAlign: "center" },
  kidCard:  { minHeight: 130, borderRadius: 20 },
  kidIcon:  { fontSize: 44, marginBottom: 10 },
  kidLabel: { fontSize: 16, fontWeight: "800" },
});
