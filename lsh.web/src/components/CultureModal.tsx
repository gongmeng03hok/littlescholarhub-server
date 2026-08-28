import { View, Text, StyleSheet, Platform } from "react-native";
import { Modal } from "./ui/Modal";
import { colors } from "../constants/theme";
import { Button } from "./ui/Button";

const isWeb = Platform.OS === "web";
const fHeading: any = isWeb ? { fontFamily: "'Fraunces', Georgia, serif" } : {};
const fBody: any = isWeb ? { fontFamily: "'Inter', system-ui, sans-serif" } : {};

export const CULTURE_KEYS = ["zh", "in", "es"] as const;
export type CultureKey = typeof CULTURE_KEYS[number];

const CULTURE_TITLES: Record<CultureKey, { title: string; sub: string; flag: string }> = {
  zh: { title: "Chinese Culture Infused Program", sub: "中文 · 中华文化", flag: "🏮" },
  in: { title: "Indian Culture Infused Program", sub: "भारत · Bhāratīya Saṃskṛti", flag: "🪔" },
  es: { title: "Hispanic Culture Infused Program", sub: "Español · Cultura Hispana", flag: "🌻" },
};

interface DetailUnit { name: string; grade: string; text: string; }
interface DetailFestival { m: string; name: string; doText: string; }
interface DetailPhrase { t: string; translit: string; eng: string; }
interface CultureDetail {
  units: DetailUnit[];
  festivals: DetailFestival[];
  phrases: DetailPhrase[];
  project: { title: string; desc: string; steps: string[]; supplies: string };
  parentTip: string;
}

const FALLBACK: Record<CultureKey, CultureDetail> = {
  zh: {
    units: [
      { name: "拼音 Pinyin foundations", grade: "TK–K", text: "Initials, finals, and the four tones, with mouth-position diagrams and daily 5-minute audio drills." },
      { name: "汉字 First 100 characters", grade: "K–2", text: "Numbers, family, body, nature, action verbs. Stroke-order tracing and a character a day." },
      { name: "唐诗 Tang poetry starters", grade: "1–3", text: "Five classic poems kids recite, each with a read-aloud audio and meaning card." },
      { name: "唐诗 Capstone (20 poems)", grade: "4–6", text: "Recite 20 poems by 6th grade — to grandparents on a video call." },
    ],
    festivals: [
      { m: "Jan/Feb", name: "农历新年 Lunar New Year", doText: "Red envelopes, dumplings, zodiac craft" },
      { m: "Feb", name: "元宵节 Lantern Festival", doText: "Make a paper lantern, eat tāngyuán" },
      { m: "Jun", name: "端午 Dragon Boat", doText: "Eat zòngzi, fold a paper dragon boat" },
      { m: "Sep", name: "中秋 Mid-Autumn", doText: "Mooncakes and the moon-goddess story" },
    ],
    phrases: [
      { t: "你好", translit: "nǐ hǎo", eng: "Hello" },
      { t: "谢谢", translit: "xiè xie", eng: "Thank you" },
      { t: "我爱你", translit: "wǒ ài nǐ", eng: "I love you" },
      { t: "新年快乐", translit: "xīn nián kuài lè", eng: "Happy New Year" },
    ],
    project: {
      title: "Make a paper lantern for Lunar New Year",
      desc: "Classic, calming, takes 20 minutes. Hang it in a window.",
      steps: ["Cut red paper into a 6×9 rectangle.", "Fold in half, cut slits along the fold.", "Unfold and curl into a cylinder, tape the seam.", "Add a paper handle and write 福 (good fortune) on it."],
      supplies: "Red paper · scissors · tape · gold marker",
    },
    parentTip: "Read Pinyin aloud together — your voice matters more than perfect tones. Once a week, video-call grandparents and have your child recite one Tang poem.",
  },
  in: {
    units: [
      { name: "वर्णमाला Hindi alphabet", grade: "TK–K", text: "Vowels first, then consonants, traced top-to-bottom." },
      { name: "Gita stories for kids", grade: "1–3", text: "Arjuna's doubt, Krishna's guidance, Hanuman's strength — one gentle takeaway per story." },
      { name: "Character building", grade: "1–6", text: "Steadiness, courage, kindness, doing your duty — one story plus one real-life challenge." },
      { name: "Capstone journal", grade: "5–6", text: "Connect each Gita teaching to a moment from your own life, bound at year end." },
    ],
    festivals: [
      { m: "Mar", name: "Holi", doText: "Color powder craft, Krishna-Radha story" },
      { m: "Aug", name: "Raksha Bandhan", doText: "Make a thread bracelet, video-call cousins" },
      { m: "Sep", name: "Ganesh Chaturthi", doText: "Clay Ganesha, obstacle-remover reflection" },
      { m: "Nov", name: "Diwali", doText: "Rangoli and diya craft, Lakshmi story" },
    ],
    phrases: [
      { t: "नमस्ते", translit: "namaste", eng: "Hello / I bow to you" },
      { t: "धन्यवाद", translit: "dhanyavād", eng: "Thank you" },
      { t: "मुझे भूख लगी है", translit: "mujhe bhūkh lagī hai", eng: "I'm hungry" },
      { t: "शुभ दीपावली", translit: "shubh dīpāvalī", eng: "Happy Diwali" },
    ],
    project: {
      title: "Diwali rangoli on a paper plate",
      desc: "A kid-friendly rangoli that keeps the symmetry without the floor-mess.",
      steps: ["Mark the center of a paper plate.", "Draw 8 light pencil lines for equal slices.", "Place colored dot stickers along each line, same pattern per slice.", "Add a flower motif in the center and display it."],
      supplies: "Paper plate · colored dot stickers or markers · pencil",
    },
    parentTip: "Open Gita stories at bedtime, not as homework. Ask 'when did you feel like Arjuna today?' and let your child find the lesson themselves.",
  },
  es: {
    units: [
      { name: "Letras y sonidos", grade: "TK–K", text: "The 27-letter alphabet including ñ, and the five vowel sounds." },
      { name: "Acentos & sílaba fuerte", grade: "K–1", text: "When a word needs an accent — mastered in about 6 weeks." },
      { name: "Cuentos & folk tales", grade: "1–4", text: "Stories from 12 Spanish-speaking countries, one per month." },
      { name: "Capstone portfolio", grade: "5–6", text: "A family tree, a retold folk tale, and an art piece honoring a maestro." },
    ],
    festivals: [
      { m: "Jan 6", name: "Día de los Reyes Magos", doText: "Leave grass for the camels, Rosca de Reyes bread" },
      { m: "May 5", name: "Cinco de Mayo", doText: "Papel picado banner, battle of Puebla story" },
      { m: "Sep 15", name: "Hispanic Heritage Month begins", doText: "21-country map, one leader per week" },
      { m: "Nov 1–2", name: "Día de los Muertos", doText: "Build an ofrenda, pan de muerto, marigold path" },
    ],
    phrases: [
      { t: "Hola", translit: "OH-lah", eng: "Hello" },
      { t: "Gracias", translit: "GRAH-syas", eng: "Thank you" },
      { t: "Tengo hambre", translit: "TENG-go AHM-breh", eng: "I'm hungry" },
      { t: "Te quiero", translit: "teh kee-EH-roh", eng: "I love you" },
    ],
    project: {
      title: "Build an ofrenda for Día de los Muertos",
      desc: "A small altar honoring someone your family loved — joyful, not sad.",
      steps: ["Cover a small shelf with a colorful cloth.", "Add one photo and say the person's name together.", "Place a glass of water and a little bread.", "Add marigolds and light one candle on Nov 1."],
      supplies: "Cloth · 1 photo · marigolds (paper or real) · 1 candle",
    },
    parentTip: "Don't 'teach' culture — live it. Bake the food, sing the song, video-call abuela. Culture sticks when it tastes, smells, and sounds like something.",
  },
};

interface Props {
  cultureKey: CultureKey | null;
  onClose: () => void;
  onSignup: () => void;
  cfg: Record<string, any>;
}

export function CultureModal({ cultureKey, onClose, onSignup, cfg }: Props) {
  if (!cultureKey) return <Modal visible={false} onClose={onClose}>{null}</Modal>;

  const meta = CULTURE_TITLES[cultureKey];
  const detail: CultureDetail = cfg[`culture.${cultureKey}.detail`] || FALLBACK[cultureKey];

  return (
    <Modal visible={!!cultureKey} onClose={onClose} title={`${meta.flag} ${meta.title}`} subtitle={meta.sub} maxWidth={640}>
      <Text style={st.sectionHead}>Curriculum units</Text>
      {detail.units.map((u, i) => (
        <View key={i} style={st.unitRow}>
          <View style={st.unitDot}><Text style={st.unitDotText}>{i + 1}</Text></View>
          <View style={{ flex: 1 }}>
            <Text style={st.unitName}>{u.name} <Text style={st.unitGrade}>· {u.grade}</Text></Text>
            <Text style={st.unitText}>{u.text}</Text>
          </View>
        </View>
      ))}

      <Text style={st.sectionHead}>Festival calendar</Text>
      <View style={st.festivalGrid}>
        {detail.festivals.map((f, i) => (
          <View key={i} style={st.festivalCard}>
            <Text style={st.festivalMonth}>{f.m}</Text>
            <Text style={st.festivalName}>{f.name}</Text>
            <Text style={st.festivalDo}>{f.doText}</Text>
          </View>
        ))}
      </View>

      <Text style={st.sectionHead}>5 phrases to start today</Text>
      {detail.phrases.map((p, i) => (
        <View key={i} style={st.phraseRow}>
          <Text style={st.phraseText}>{p.t}</Text>
          <Text style={st.phraseTranslit}>{p.translit}</Text>
          <Text style={st.phraseEng}>{p.eng}</Text>
        </View>
      ))}

      <Text style={st.sectionHead}>One project this weekend</Text>
      <View style={st.projectBox}>
        <Text style={st.projectTitle}>{detail.project.title}</Text>
        <Text style={st.projectDesc}>{detail.project.desc}</Text>
        {detail.project.steps.map((step, i) => (
          <Text key={i} style={st.projectStep}>{i + 1}. {step}</Text>
        ))}
        <Text style={st.projectSupplies}>Supplies: {detail.project.supplies}</Text>
      </View>

      <View style={st.parentBox}>
        <Text style={st.parentLabel}>For parents</Text>
        <Text style={st.parentText}>{detail.parentTip}</Text>
      </View>

      <Button label="Start free trial →" onPress={onSignup} style={{ marginTop: 20 }} />
    </Modal>
  );
}

const st = StyleSheet.create({
  sectionHead: { fontSize: 15, fontWeight: "800", color: colors.text, marginTop: 20, marginBottom: 10, ...fHeading },
  unitRow: { flexDirection: "row", gap: 12, marginBottom: 10, backgroundColor: "#fff", borderRadius: 12, padding: 12, borderWidth: 1, borderColor: colors.border },
  unitDot: { width: 24, height: 24, borderRadius: 12, backgroundColor: colors.text, alignItems: "center", justifyContent: "center", flexShrink: 0 },
  unitDotText: { color: "#fff", fontSize: 11, fontWeight: "800" },
  unitName: { fontSize: 13, fontWeight: "700", color: colors.text, ...fBody },
  unitGrade: { color: colors.textMuted, fontWeight: "600" },
  unitText: { fontSize: 12, color: colors.textMuted, marginTop: 2, lineHeight: 17, ...fBody },
  festivalGrid: { flexDirection: "row", flexWrap: "wrap", gap: 8 },
  festivalCard: { width: "48%", backgroundColor: "#fdf9ef", borderRadius: 10, padding: 10 },
  festivalMonth: { fontSize: 10, fontWeight: "800", color: colors.brandDark, textTransform: "uppercase", letterSpacing: 0.4 },
  festivalName: { fontSize: 12, fontWeight: "700", color: colors.text, marginTop: 2 },
  festivalDo: { fontSize: 11, color: colors.textMuted, marginTop: 2, lineHeight: 15 },
  phraseRow: { flexDirection: "row", alignItems: "center", gap: 10, paddingVertical: 7, borderBottomWidth: 1, borderBottomColor: colors.border },
  phraseText: { fontSize: 15, fontWeight: "700", color: colors.text, minWidth: 90, ...fHeading },
  phraseTranslit: { fontSize: 12, color: colors.textMuted, fontStyle: "italic", minWidth: 90 },
  phraseEng: { fontSize: 12, color: colors.text, flex: 1 },
  projectBox: { backgroundColor: "#fff", borderRadius: 14, padding: 16, borderWidth: 1, borderColor: colors.border },
  projectTitle: { fontSize: 15, fontWeight: "800", color: colors.text, marginBottom: 4, ...fHeading },
  projectDesc: { fontSize: 12, color: colors.textMuted, marginBottom: 8, lineHeight: 17 },
  projectStep: { fontSize: 12, color: colors.text, marginBottom: 4, lineHeight: 17 },
  projectSupplies: { fontSize: 11, color: colors.textMuted, marginTop: 8, fontStyle: "italic" },
  parentBox: { backgroundColor: colors.surfaceAlt, borderRadius: 14, padding: 16, marginTop: 20 },
  parentLabel: { fontSize: 11, fontWeight: "800", color: colors.brandDark, textTransform: "uppercase", letterSpacing: 0.6, marginBottom: 6 },
  parentText: { fontSize: 13, color: colors.text, lineHeight: 19, fontStyle: "italic" },
});
