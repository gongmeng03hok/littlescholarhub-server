/**
 * Landing page — mirrors venerable-gnome-807695.netlify.app exactly:
 * Hero · Assessment CTA · Cultural tracks · 9 Subjects · Worksheet preview
 * · Testimonials · Progress cards · Pricing · Community · School licensing
 */
import { useState } from "react";
import { ScrollView, View, Text, TouchableOpacity, TextInput,
         Platform, Linking, Image, StyleSheet, useWindowDimensions } from "react-native";
import { useRouter } from "expo-router";
import { useConfig } from "../../hooks/useConfig";
import { colors, fonts, SUBJECT_META, CULTURAL_TRACKS, GRADES } from "../../constants/theme";
import { i18n, Lang } from "../../constants/i18n";
import { useLangStore } from "../../store/langStore";
import { useDailyWisdom } from "../../hooks/useDailyWisdom";
import { subjectI18n } from "../../constants/subjectI18n";
import { useSubjects, useGrades, useWorksheets, useInterests, useLevels, useRecordView } from "../../hooks/useApi";
import { Modal } from "../../components/ui/Modal";
import { WorksheetPreviewModal } from "../../components/WorksheetPreviewModal";
import { CultureModal, CULTURE_KEYS, type CultureKey } from "../../components/CultureModal";

const isWeb = Platform.OS === "web";

const SOCIAL_LABEL: Record<string, string> = {
  instagram: "📷 Instagram",
  tiktok: "🎵 TikTok",
  teachers: "👩‍🏫 Teachers",
};
function formatCount(n: number | string): string {
  const num = Number(n);
  if (!num) return "0";
  if (num >= 1000) return (num / 1000).toFixed(num >= 10000 ? 0 : 1).replace(/\.0$/, "") + "k";
  return String(num);
}

// ── Tiny primitives ───────────────────────────────────────────────────────────
const H1 = ({ children, style }: any) => (
  <Text style={[s.h1, style]}>{children}</Text>
);
const H2 = ({ children, style }: any) => (
  <Text style={[s.h2, style]}>{children}</Text>
);
const H3 = ({ children, style }: any) => (
  <Text style={[s.h3, style]}>{children}</Text>
);
const Body = ({ children, style }: any) => (
  <Text style={[s.body, style]}>{children}</Text>
);
const Pill = ({ label, bg = "#fff", color = colors.text }: any) => (
  <View style={[s.pill, { backgroundColor: bg }]}>
    <Text style={[s.pillText, { color }]}>{label}</Text>
  </View>
);
const Divider = () => <View style={s.divider} />;
const Section = ({ children, bg = "#fff", webBg, id }: any) => (
  <View
    style={[
      s.sectionOuter,
      { backgroundColor: bg },
      isWeb && webBg ? { backgroundImage: webBg } as any : null,
    ]}
    nativeID={id}
  >
    <View style={s.sectionInner}>
      {children}
    </View>
  </View>
);
const Row = ({ children, style }: any) => (
  <View style={[s.row, style]}>{children}</View>
);
const Card = ({ children, style }: any) => (
  <View style={[s.card, style]}>{children}</View>
);
const Btn = ({ label, onPress, outline, small, style }: any) => (
  <TouchableOpacity
    onPress={onPress}
    style={[s.btn, outline && s.btnOutline, small && s.btnSmall, style]}
    activeOpacity={0.8}
  >
    <Text style={[s.btnText, outline && s.btnOutlineText, small && s.btnSmallText]}>
      {label}
    </Text>
  </TouchableOpacity>
);

// ── Data ─────────────────────────────────────────────────────────────────────

// Screen positions for the 3 clickable hero sample chips (index-aligned with hero.today_items)
const CHIP_POS: any[] = [
  { top: 18, left: -12 },     // 0 · today's story
  { bottom: 56, right: -14 }, // 1 · math practice
  { bottom: -12, left: 32 },  // 2 · art project
];

// Showcase samples opened when a hero chip is tapped — real content for client demos,
// viewable WITHOUT building a plan or signing in. Index-aligned with hero.today_items.
const HERO_SAMPLES: any[] = [
  {
    kind: "story",
    emoji: "📚",
    tag: "Sample story · Reading · Grade 1–2",
    title: "Kai and the Dragon",
    image: "/art/story_dragon.svg",
    intro: "Each day's story is picked to match your child's interests. Here's the opening a 1st–2nd grader would read today:",
    paragraphs: [
      "Kai lived at the foot of a misty mountain where, the old people said, a dragon slept.",
      "\"Dragons aren't real,\" said Kai. But every night a warm wind curled under his door and smelled of rain and ginger.",
      "One morning Kai followed the wind up the mountain path. At the top sat a dragon the color of river stones, reading a very small book.",
      "\"You're late,\" said the dragon, without looking up. \"I've been saving you the best story.\"",
    ],
    footnote: "Comprehension: What did the night wind smell like? Why do you think the dragon was reading?",
    chips: ["Read-aloud audio", "3 comprehension questions", "New words: misty · curled · ginger"],
  },
  {
    kind: "math",
    emoji: "✏️",
    tag: "Sample worksheet · Math · 2nd grade · 12 min",
    title: "Two-Step Word Problems",
    image: "/art/math_worksheet.svg",
    intro: "Every plan builds a short daily set at your child's level. A 2nd-grade set looks like this:",
    problems: [
      { q: "Mei has 24 stickers. She gives 8 to her brother, then buys 5 more. How many does she have now?", a: "21 stickers" },
      { q: "A lantern needs 6 pieces of red paper. How many pieces are needed for 4 lanterns?", a: "24 pieces" },
      { q: "There are 30 minutes of practice. Kai does 12 minutes, then 9 minutes. How many minutes are left?", a: "9 minutes" },
    ],
    footnote: "No red marks or \"smart score.\" Kids check their own work with the answer key; parents see effort and streak, not pass/fail.",
    chips: ["Auto-leveled", "Bar-model hints", "Printable PDF"],
  },
  {
    kind: "art",
    emoji: "🎨",
    tag: "Sample project · Art · All ages",
    title: "Lunar Lantern",
    intro: "Culture-infused art projects pair with the weekly story. This one ties to the Chinese track:",
    image: "https://img.youtube.com/vi/1rQ4ib7pSp4/hqdefault.jpg",
    video: "https://www.youtube.com/watch?v=1rQ4ib7pSp4",
    videoLabel: "Watch the steps (2 min)",
    steps: [
      "Fold a sheet of red paper in half the long way.",
      "Cut straight lines in from the folded edge, stopping before the far side.",
      "Unfold, roll into a tube, and tape the short edges together.",
      "Add a paper handle and a gold tassel, then hang it where the light catches it.",
    ],
    footnote: "Finished projects go into your child's heritage portfolio — a keepsake by year's end.",
    chips: ["Materials list", "Step-by-step photos", "15–20 min"],
  },
];

// Subject copy is language-aware — resolved inside the component via subjectI18n[lang]

// ── Main component ────────────────────────────────────────────────────────────

const LANG_ID: Record<Lang, number> = { en: 1, zh: 2, hi: 3, es: 4 };

export default function LandingPage() {
  const router = useRouter();
  const { lang, setLang } = useLangStore();
  const languageId = LANG_ID[lang] ?? 1;
  const { data: cfg = {} } = useConfig(languageId);
  const t = i18n[lang];
  const sc = subjectI18n[lang];
  const { width: winW } = useWindowDimensions();
  const wide = !isWeb || winW >= 768;   // language-aware subject labels + descriptions
  const wisdom = useDailyWisdom();

  // All copy is DB-backed (AppConfig, per language_id) via /api/config — the
  // static i18n.ts values below are only used as a fallback if a key hasn't
  // been seeded yet, or the API is unreachable.
  const getConfig = (key: string, fallback: any) => cfg[key] !== undefined ? cfg[key] : fallback;
  const getArray = <T,>(key: string, fallback: T[]) =>
    Array.isArray(cfg[key]) ? cfg[key] as T[] : fallback;
  const getText = (key: string, fallback: string) =>
    cfg[key] !== undefined ? cfg[key] : fallback;

  const heroTitle = getText("hero.tagline", t.hero.title);
  const heroSubtitle = getText("hero.subtagline", t.hero.subtitle);
  const heroPrimaryCta = getText("hero.cta_primary", t.hero.ctaPrimary);
  const heroSecondaryCta = getText("hero.cta_secondary", t.hero.ctaSecondary);
  const heroTrust = getArray<string>("hero.trust", t.hero.trust);
  const heroBadges = getArray<{ num: string; label: string }>("hero.badges", t.hero.badges);
  const heroTodayItems = getArray<{ icon: string; label: string; sub: string }>("hero.today_items", t.hero.todayItems);

  const dualModeEyebrow = getText("dualMode.eyebrow", t.dualMode.eyebrow);
  const dualModeTitle = getText("dualMode.title", t.dualMode.title);
  const dualModeTitleHighlight = getText("dualMode.title_highlight", t.dualMode.titleHighlight);
  const dualModeSubtitle = getText("dualMode.subtitle", t.dualMode.subtitle);
  const dualModeDivider = getText("dualMode.divider", t.dualMode.dividerLabel);
  const dualModeCards = getArray<{ icon: string; title: string; body: string; features: string[] }>("dualMode.cards", t.dualMode.cards);
  const dualModeStats = getArray<{ num: string; label: string }>("dualMode.stats", t.dualMode.stats);
  const dualModeDisclaimer = getText("dualMode.disclaimer", t.dualMode.disclaimer);

  // ── Worksheet library (DB-backed via /api/content) ──────────────────────────
  const [wsGrade, setWsGrade] = useState(0);
  const [wsTopic, setWsTopic] = useState<string>("all");
  const [wsLevel, setWsLevel] = useState<string>("all");
  const [wsInterest, setWsInterest] = useState<string>("all");
  const [selectedWorksheet, setSelectedWorksheet] = useState<any>(null);
  const [cultureModal, setCultureModal] = useState<CultureKey | null>(null);
  const [sample, setSample] = useState<any>(null);   // hero chip sample preview

  const { data: gradesData } = useGrades();
  const { data: subjectsData } = useSubjects();
  const { data: levelsData } = useLevels();
  const { data: interestsData } = useInterests();
  const recordView = useRecordView();

  const gradesList = gradesData && gradesData.length ? gradesData : GRADES;
  const subjectsList = subjectsData || [];
  const levelsList = levelsData || [];
  const interestsList = interestsData || [];

  const { data: worksheetsData, isLoading: worksheetsLoading } = useWorksheets({
    grade: wsGrade,
    subject: wsTopic !== "all" && wsTopic !== "trending" ? wsTopic : undefined,
    trending: wsTopic === "trending" ? true : undefined,
    level: wsLevel !== "all" ? wsLevel : undefined,
    interest: wsInterest !== "all" ? wsInterest : undefined,
  });
  const worksheetsList = worksheetsData || [];

  const openWorksheet = (w: any) => {
    setSelectedWorksheet(w);
    if (w.worksheet_id) recordView.mutate(w.worksheet_id);
  };
  const gradeLabelFor = (gradeId: number) => gradesList.find((g: any) => g.grade_id === gradeId)?.label ?? gradeId;

  const whyUsItems = getArray<{ n: string; title: string; body: string }>("whyUs.items", t.whyUs.items);
  const testimonials = getArray<any>("testimonials.items", t.testimonials.items);
  const progressCards = getArray<any>("progress.cards", t.progress.cards);
  const comparisonItems = getArray<any>("comparison.items", t.comparison.items);

  const schoolPlans = getArray<any>("school.plans", t.schools.plans);
  const socialCards = getArray<any>("social.cards", t.social.cards);

  const referralCode = getConfig("referral.code_example", "LSH-FAM-2026");
  const referralDescription = getText("referral.description", t.community.referral.body);

  const communityGroups = getArray<any>("community.groups", t.community.groups);
  const communityOfficeTopic = getConfig("community.officehours_topic", getConfig("community.office_hours_topic", "How to introduce Tang Shi to a 1st grader without overwhelming them"));
  const communityOfficeHost = getConfig("community.officehours_host", getConfig("community.office_hours_host", "Ms. Chen · credentialed bilingual teacher"));
  const communityOfficeTime = getConfig("community.officehours_time", getConfig("community.office_hours_time", "7:00 pm PT"));

  const socialXhsHandle = getConfig("social.xiaohongshu_handle", getConfig("social.xhs_handle", "小学霸中心 · LittleScholarsHub"));

  const footerLinks = getArray<string>("footer.links", t.footer.links);
  const footerCompanyLinks = getArray<string>("footer.company_links", t.footer.companyLinks);
  const footerSocialLinks = getArray<string>("footer.social_links", t.footer.socialLinks);
  const footerLegal = getArray<string>("footer.legal", t.footer.legal);
  const footerCopy = getText("footer.copy", t.footer.copy);
  const footerTagline = getText("footer.tagline", t.footer.tagline);

  const familyPrice  = getConfig("pricing.family_price", 14.99);
  const familyAnnual = getConfig("pricing.family_annual", 129);
  const shippedPrice = getConfig("pricing.shipped_price", 29.99);
  const shippedAnnual= getConfig("pricing.shipped_annual", 299);
  const familySave  = getConfig("pricing.family_save", 51);
  const shippedSave = getConfig("pricing.shipped_save", 61);
  const paymentLogos = getArray<string>("pricing.payment_logos", ["💳 Visa · Mastercard · Amex", "🅿️ PayPal", "支 Alipay", "微 WeChat Pay", "UPI / Paytm", "🍎 Apple Pay", "us USD · billed monthly or annually"]);

  // ── Remaining sections, now fully DB-driven with i18n.ts as fallback ──────
  const navSubjects    = getText("nav.subjects", t.nav.subjects);
  const navByGrade     = getText("nav.byGrade", t.nav.byGrade);
  const navWorksheets  = getText("nav.worksheets", t.nav.worksheets);
  const navPricing     = getText("nav.pricing", t.nav.pricing);
  const navCommunity   = getText("nav.community", t.nav.community);
  const navStartFree   = getText("nav.startFree", t.nav.startFree);

  const heroEyebrow           = getText("hero.eyebrow", t.hero.eyebrow);
  const heroLangStripTagline  = getText("hero.langStripTagline", t.hero.langStripTagline);

  const assessEyebrow     = getText("assessment.eyebrow", t.assessment.eyebrow);
  const assessTitle       = getText("assessment.title", t.assessment.title);
  const assessSubtitle    = getText("assessment.subtitle", t.assessment.subtitle);
  const assessChips       = getArray<string>("assessment.chips", t.assessment.chips);
  const assessCta         = getText("assessment.cta", t.assessment.cta);
  const assessWizardStep  = getText("assessment.wizardStep", t.assessment.wizardStep);
  const assessWizardBack  = getText("assessment.wizardBack", t.assessment.wizardBack);
  const assessWizardSkip  = getText("assessment.wizardSkip", t.assessment.wizardSkip);
  const assessWizardNext  = getText("assessment.wizardNext", t.assessment.wizardNext);

  const culturalEyebrow      = getText("culturalTracks.eyebrow", t.cultural.eyebrow);
  const culturalTitle        = getText("culturalTracks.title", t.cultural.title);
  const culturalSubtitle     = getText("culturalTracks.subtitle", t.cultural.subtitle);
  const culturalNote         = getText("culturalTracks.note", t.cultural.note);
  const culturalEndGoalLabel = getText("culturalTracks.endGoalLabel", t.cultural.endGoalLabel);
  const culturalOpenCta      = getText("culturalTracks.openCta", t.cultural.openCta);
  const culturalTracksList   = getArray<any>("culturalTracks.tracks", t.cultural.tracks);

  const wisdomBannerHeader      = getText("wisdomBanner.header", t.wisdom.header);
  const wisdomBannerAttribution = getText("wisdomBanner.attribution", t.wisdom.attribution);

  const subjectsEyebrow  = getText("subjects.eyebrow", t.subjects.eyebrow);
  const subjectsTitle    = getText("subjects.title", t.subjects.title);
  const subjectsSubtitle = getText("subjects.subtitle", t.subjects.subtitle);

  const worksheetsEyebrow  = getText("worksheets.eyebrow", t.worksheets.eyebrow);
  const worksheetsTitle    = getText("worksheets.title", t.worksheets.title);
  const worksheetsSubtitle = getText("worksheets.subtitle", t.worksheets.subtitle);
  const worksheetsCta      = getText("worksheets.cta", t.worksheets.cta);

  const whyUsEyebrow = getText("whyUs.eyebrow", t.whyUs.eyebrow);
  const whyUsTitle   = getText("whyUs.title", t.whyUs.title);

  const testimonialsEyebrow = getText("testimonials.eyebrow", t.testimonials.eyebrow);
  const testimonialsTitle   = getText("testimonials.title", t.testimonials.title);

  const progressEyebrow      = getText("progress.eyebrow", t.progress.eyebrow);
  const progressTitle        = getText("progress.title", t.progress.title);
  const progressSubtitle     = getText("progress.subtitle", t.progress.subtitle);
  const progressVerifiedLabel= getText("progress.verifiedLabel", t.progress.verifiedLabel);
  const progressWeek1Label   = getText("progress.week1Label", t.progress.week1Label);
  const progressWeek12Label  = getText("progress.week12Label", t.progress.week12Label);

  const comparisonEyebrow  = getText("comparison.eyebrow", t.comparison.eyebrow);
  const comparisonTitle    = getText("comparison.title", t.comparison.title);
  const comparisonSubtitle = getText("comparison.subtitle", t.comparison.subtitle);

  const pricingEyebrow           = getText("pricing.eyebrow", t.pricing.eyebrow);
  const pricingTitle             = getText("pricing.title", t.pricing.title);
  const pricingSubtitle          = getText("pricing.subtitle", t.pricing.subtitle);
  const pricingMostPopular       = getText("pricing.mostPopular", t.pricing.mostPopular);
  const pricingAnnualSaveFamily  = getText("pricing.annualSaveFamily", t.pricing.annualSaveFamily);
  const pricingAnnualSaveShipped = getText("pricing.annualSaveShipped", t.pricing.annualSaveShipped);
  const pricingScholarship       = getText("pricing.scholarship", t.pricing.scholarship);
  const pricingPlans             = getArray<any>("pricing.plans", t.pricing.plans);

  const communityEyebrow    = getText("community.eyebrow", t.community.eyebrow);
  const communityTitle      = getText("community.title", t.community.title);
  const communitySubtitle   = getText("community.subtitle", t.community.subtitle);
  const ohLabel          = getText("community.officeHours.label", t.community.officeHours.label);
  const ohTitleText       = getText("community.officeHours.title", t.community.officeHours.title);
  const ohBody            = getText("community.officeHours.body", t.community.officeHours.body);
  const ohThisWeekLabel   = getText("community.officeHours.thisWeekLabel", t.community.officeHours.thisWeekLabel);
  const ohHostLabel       = getText("community.officeHours.hostLabel", t.community.officeHours.hostLabel);
  const ohRsvp            = getText("community.officeHours.rsvp", t.community.officeHours.rsvp);
  const communityGroupsTitle = getText("community.groupsTitle", t.community.groupsTitle);
  const communityGroupsSub   = getText("community.groupsSub", t.community.groupsSub);
  const referralTitle    = getText("referral.title", t.community.referral.title);
  const referralCta      = getText("referral.cta", t.community.referral.cta);
  const referralCodeNote = getText("referral.codeNote", t.community.referral.codeNote);

  const schoolsEyebrow  = getText("school.eyebrow", t.schools.eyebrow);
  const schoolsTitle    = getText("school.title", t.schools.title);
  const schoolsSubtitle = getText("school.subtitle", t.schools.subtitle);
  const schoolsCta      = getText("school.cta", t.schools.cta);
  const schoolsNote     = getText("school.note", t.schools.note);

  const socialEyebrow  = getText("social.eyebrow", t.social.eyebrow);
  const socialTitle    = getText("social.title", t.social.title);
  const socialSubtitle = getText("social.subtitle", t.social.subtitle);

  const emailEyebrow     = getText("emailCapture.eyebrow", t.emailCapture.eyebrow);
  const emailTitle       = getText("emailCapture.title", t.emailCapture.title);
  const emailSubtitle    = getText("emailCapture.subtitle", t.emailCapture.subtitle);
  const emailPlaceholder = getText("emailCapture.placeholder", t.emailCapture.placeholder);
  const emailCta         = getText("emailCapture.cta", t.emailCapture.cta);
  const emailNote        = getText("emailCapture.note", t.emailCapture.note);

  const footerColLearn   = getText("footer.colLearn", t.footer.colLearn);
  const footerColCompany = getText("footer.colCompany", t.footer.colCompany);
  const footerColFollow  = getText("footer.colFollow", t.footer.colFollow);

  const goSignup = () => router.push("/(auth)/register");

  const scrollTo = (id: string) => {
    if (isWeb) {
      document.getElementById(id)?.scrollIntoView({ behavior: "smooth", block: "start" });
    }
  };

  const goAssessment = () => router.push("/(auth)/assessment");
  const goPricing    = () => scrollTo("pricing");

  return (
    <ScrollView style={s.root} contentContainerStyle={s.rootContent} showsVerticalScrollIndicator={false}>

      {/* ── NAVBAR ─────────────────────────────────────────────────── */}
      <View style={s.navbar}>
        <Text style={s.navBrand}>🌟 Little Scholars Hub</Text>
        <View style={s.navLinks}>
          {([
            [navSubjects,    "subjects"],
            [navByGrade,     "worksheets"],
            [navWorksheets,  "worksheets"],
            [navPricing,     "pricing"],
            [navCommunity,   "social"],
          ] as [string, string][]).map(([label, id]) => (
            <TouchableOpacity key={label} onPress={() => scrollTo(id)}>
              <Text style={s.navLink}>{label}</Text>
            </TouchableOpacity>
          ))}
        </View>
        <View style={s.navLangs}>
          {([["en","EN"],["zh","中文"],["hi","हिन्दी"],["es","ES"]] as [Lang,string][]).map(([code, label]) => (
            <TouchableOpacity key={code} onPress={() => setLang(code)}
              style={[s.navLangBtn, lang === code && s.navLangBtnActive]}>
              <Text style={[s.navLang, lang === code && s.navLangActive]}>{label}</Text>
            </TouchableOpacity>
          ))}
          <Btn label={navStartFree} onPress={goSignup} small />
        </View>
      </View>

      {/* ── HERO ───────────────────────────────────────────────────── */}
      <Section bg={colors.bg}>
        <View style={s.heroGrad}>
          <View style={[s.heroRow, !wide && { flexDirection: "column" }]}>
            {/* ── Left: text content ── */}
            <View style={s.heroLeft}>
              <Text style={s.heroEyebrow}>{heroEyebrow}</Text>
              <H1 style={s.heroTitle}>
                {(heroTitle.includes("\n") ? heroTitle.split("\n") : heroTitle.trim().split(/\.\s+/).map((line: string, i: number, arr: string[]) => i < arr.length - 1 ? `${line}.` : line))
                  .map((line: string, i: number, arr: string[]) => (
                    <Text key={i} style={i === 1 ? { color: colors.brand } : undefined}>
                      {line}{i < arr.length - 1 ? "\n" : ""}
                    </Text>
                  ))}
              </H1>
              <Body style={s.heroSub}>{heroSubtitle}</Body>
              <Row style={{ gap: 12, marginTop: 28, flexWrap: "wrap" }}>
                <Btn label={heroPrimaryCta} onPress={goAssessment} />
                <Btn label={heroSecondaryCta} onPress={goPricing} outline />
              </Row>
              <Row style={{ gap: 10, marginTop: 28, flexWrap: "wrap" }}>
                {heroBadges.map(b => (
                  <View key={b.label} style={s.heroBadge}>
                    <Text style={s.heroBadgeNum}>{b.num}</Text>
                    <Text style={s.heroBadgeLabel}>{b.label}</Text>
                  </View>
                ))}
              </Row>
              <Row style={{ gap: 8, marginTop: 20, flexWrap: "wrap" }}>
                {heroTrust.map(item => <Pill key={item} label={item} />)}
              </Row>
              
              {/* banner moved to full-width strip below the hero section */}
            </View>

            {/* ── Right: illustrated scene ── */}
            {wide && (
              <View style={s.heroRight}>
              <View style={s.heroScene}>
                {/* Decorative elements */}
                <View style={s.sceneSun} />
                <Text style={s.scenePencil}>✏️</Text>
                <Text style={[s.sceneStar, { top: 72, left: 44 }]}>★</Text>
                <Text style={[s.sceneStar, { top: 170, right: 60, fontSize: 13, color: "#7a96b2" }]}>★</Text>

                {/* Book + figure illustration */}
                <View style={s.sceneBook}>
                  <View style={s.sceneBookLeft}>
                    <View style={s.sceneBookLine} />
                    <View style={[s.sceneBookLine, { width: "70%" }]} />
                    <View style={[s.sceneBookLine, { width: "85%" }]} />
                  </View>
                  <View style={s.sceneBookRight}>
                    <View style={s.sceneFigureHead} />
                    <View style={s.sceneFigureBody} />
                  </View>
                </View>

                {/* Floating chips — tappable sample previews. Only on wide screens;
                    on mobile they bleed over the stacked text. */}
                {wide && (
                  <>
                    {heroTodayItems.slice(0, CHIP_POS.length).map((item, i) => (
                      <TouchableOpacity
                        key={i}
                        accessibilityRole="button"
                        accessibilityLabel={`Preview sample: ${item.sub}`}
                        activeOpacity={0.85}
                        onPress={() => setSample(HERO_SAMPLES[i] ?? HERO_SAMPLES[0])}
                        style={[s.floatingChip, CHIP_POS[i], isWeb && ({ cursor: "pointer" } as any)]}
                      >
                        <Text style={s.chipEmoji}>{item.icon}</Text>
                        <View>
                          <Text style={s.chipLabel}>{item.label}</Text>
                          <Text style={s.chipValue}>{item.sub}</Text>
                        </View>
                        <View style={s.chipPeek}><Text style={s.chipPeekText}>🔍</Text></View>
                      </TouchableOpacity>
                    ))}
                  </>
                )}
              </View>
              <Text style={s.heroSampleHint}>👆 Tap a card to preview a real sample</Text>
            </View>
            )}
          </View>
        </View>
      </Section>

      {/* ── LANGUAGE STRIP ─────────────────────────────────────────── */}
      <View style={s.langBar}>
        <View style={[s.langBarRow, !wide && { flexDirection: "column", gap: 4 }]}>
          {(["🌟 English", "中文", "हिन्दी", "Español"] as const).map((name, i) => (
            <View key={name} style={s.langBarItem}>
              {i > 0 && <Text style={s.langBarDot}>·</Text>}
              <Text style={s.langBarName}>{name}</Text>
            </View>
          ))}
          <Text style={s.langBarSep}>—</Text>
          <Text style={s.langBarTagline}>{heroLangStripTagline}</Text>
        </View>
      </View>

      {/* ── DUAL MODE — digital vs. print ────────────────────────────── */}
      <Section bg="#fff" id="dualMode">
        <View style={{ alignItems: "center" }}>
          <View style={s.dualEyebrowPill}>
            <Text style={s.dualEyebrowText}>{dualModeEyebrow}</Text>
          </View>
          <H2 style={{ textAlign: "center", marginBottom: 12, maxWidth: 640 }}>
            {dualModeTitle}{" "}
            <Text style={{ color: colors.brand }}>{dualModeTitleHighlight}</Text>
          </H2>
          <Body style={{ color: colors.textMuted, textAlign: "center", marginBottom: 36, maxWidth: 620 }}>
            {dualModeSubtitle}
          </Body>
        </View>

        <View style={[s.dualGrid, !wide && { flexDirection: "column" }]}>
          {dualModeCards.flatMap((card, i) => [
            <View key={card.title} style={s.dualCard}>
              <View style={s.dualIconBadge}>
                <Text style={s.dualIconText}>{card.icon}</Text>
              </View>
              <H3 style={{ marginBottom: 8 }}>{card.title}</H3>
              <Body style={{ color: colors.textMuted, marginBottom: 16 }}>{card.body}</Body>
              <View style={{ gap: 10 }}>
                {card.features.map(f => (
                  <View key={f} style={s.dualFeatureRow}>
                    <Text style={s.dualFeatureCheck}>✓</Text>
                    <Text style={s.dualFeatureText}>{f}</Text>
                  </View>
                ))}
              </View>
            </View>,
            wide && i < dualModeCards.length - 1 ? (
              <Text key={`divider-${card.title}`} style={s.dualDivider}>— {dualModeDivider} —</Text>
            ) : null,
          ])}
        </View>

        <View style={s.dualStatsRow}>
          {dualModeStats.map(stat => (
            <View key={stat.label} style={s.dualStatCol}>
              <Text style={s.dualStatNum}>{stat.num}</Text>
              <Text style={s.dualStatLabel}>{stat.label}</Text>
            </View>
          ))}
        </View>

        <Body style={[s.note, { marginTop: 20, textAlign: "center" }]}>{dualModeDisclaimer}</Body>
      </Section>

      {/* ── ASSESSMENT TEASER ──────────────────────────────────────── */}
      <Section bg={colors.surfaceAlt} id="assessment">
        <View style={s.assessCard}>
          {/* Eyebrow with green live-dot */}
          <View style={s.assessEyebrowRow}>
            <View style={s.assessDot} />
            <Text style={s.assessEyebrowText}>{assessEyebrow}</Text>
          </View>

          <H2 style={{ textAlign: "center", marginBottom: 16 }}>{assessTitle}</H2>
          <Body style={{ color: colors.textMuted, marginBottom: 20, textAlign: "center" }}>
            {assessSubtitle}
          </Body>

          {/* Chip pills — centered */}
          <View style={s.assessChipsRow}>
            {assessChips.map(c => <Pill key={c} label={c} />)}
          </View>

          {/* Wizard nav bar */}
          <View style={s.assessWizardPreview}>
            <Text style={s.assessStep}>{assessWizardStep}</Text>
            <Text style={s.assessBack}>{assessWizardBack}</Text>
            <Text style={s.assessSkip}>{assessWizardSkip}</Text>
            <Text style={s.assessNext}>{assessWizardNext}</Text>
          </View>

          <Btn label={assessCta} onPress={goAssessment} style={{ alignSelf: "center" }} />
        </View>
      </Section>

      {/* ── CULTURAL TRACKS ────────────────────────────────────────── */}
      <Section id="cultural">
        <Text style={s.eyebrow}>{culturalEyebrow}</Text>
        <H2>{culturalTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 24 }}>{culturalSubtitle}</Body>

        <View style={[s.culturalGrid, !wide && { flexDirection: "column" }]}>
          {(["🏮", "🪔", "🌻"] as const).map((emoji, i) => {
            const track = culturalTracksList[i];
            const cultureKey = CULTURE_KEYS[i];
            return (
              <TouchableOpacity
                key={i}
                activeOpacity={0.85}
                onPress={() => setCultureModal(cultureKey)}
                style={[s.culturalCard, !wide && { flex: undefined }]}
              >
                <Card style={{ flex: 1 }}>
                  <Text style={s.trackEmoji}>{emoji}</Text>
                  <H3 style={{ marginBottom: 6 }}>{track.title}</H3>
                  <Text style={s.trackSubtitle}>{track.subtitle}</Text>
                  <View style={{ flex: 1 }}>
                    {track.steps.map((step: any, si: number) => (
                      <View key={si} style={s.trackStep}>
                        <View style={s.trackNum}><Text style={s.trackNumText}>{si + 1}</Text></View>
                        <View style={{ flex: 1 }}>
                          <Text style={s.trackStepTitle}>{step.title}</Text>
                          <Text style={s.trackStepBody}>{step.body}</Text>
                        </View>
                      </View>
                    ))}
                  </View>
                  <View style={s.trackGoalDark}>
                    <Text style={s.trackGoalLabel}>{culturalEndGoalLabel}</Text>
                    <Text style={s.trackGoalTitleDark}>{track.goalTitle}</Text>
                    <Text style={s.trackGoalBodyDark}>{track.goalBody}</Text>
                  </View>
                  <Text style={s.trackOpenCta}>{culturalOpenCta} →</Text>
                </Card>
              </TouchableOpacity>
            );
          })}
        </View>

        <Body style={[s.note, { marginTop: 16 }]}>{culturalNote}</Body>
      </Section>

      <CultureModal cultureKey={cultureModal} onClose={() => setCultureModal(null)} onSignup={goSignup} cfg={cfg} />

      {/* ── HERO SAMPLE PREVIEW MODAL ─────────────────────────────────── */}
      <Modal
        visible={sample !== null}
        onClose={() => setSample(null)}
        title={sample ? `${sample.emoji}  ${sample.title}` : undefined}
        subtitle={sample?.tag}
      >
        {sample && (
          <View>
            <Body style={{ color: colors.textMuted, marginBottom: 18 }}>{sample.intro}</Body>

            {sample.image ? (
              <TouchableOpacity
                activeOpacity={sample.video ? 0.9 : 1}
                onPress={() => sample.video && Linking.openURL(sample.video)}
                style={s.sampleMediaWrap}
              >
                <Image source={{ uri: sample.image }} style={s.sampleMedia} resizeMode="cover" />
                {sample.video ? (
                  <>
                    <View style={s.sampleMediaTag}><Text style={s.sampleMediaTagText}>DEMONSTRATION</Text></View>
                    <View style={s.samplePlay}><Text style={s.samplePlayIcon}>▶</Text></View>
                  </>
                ) : null}
              </TouchableOpacity>
            ) : null}

            {sample.kind === "story" && sample.paragraphs.map((p: string, i: number) => (
              <Text key={i} style={s.sampleStoryPara}>{p}</Text>
            ))}

            {sample.kind === "math" && sample.problems.map((p: any, i: number) => (
              <View key={i} style={s.sampleProblem}>
                <Text style={s.sampleProblemQ}>
                  <Text style={{ fontWeight: "800", color: colors.brand }}>{i + 1}. </Text>{p.q}
                </Text>
                <Text style={s.sampleProblemA}>Answer: {p.a}</Text>
              </View>
            ))}

            {sample.kind === "art" && sample.steps.map((st: string, i: number) => (
              <View key={i} style={s.sampleStep}>
                <View style={s.sampleStepNum}><Text style={s.sampleStepNumText}>{i + 1}</Text></View>
                <Text style={s.sampleStepText}>{st}</Text>
              </View>
            ))}

            {sample.kind === "worksheet" && sample.tasks.map((tk: string, i: number) => (
              <View key={i} style={s.sampleTask}>
                <View style={s.sampleTaskBox}><Text style={s.sampleTaskBoxText}>{i + 1}</Text></View>
                <Text style={s.sampleTaskText}>{tk}</Text>
              </View>
            ))}

            <Text style={s.sampleFootnote}>{sample.footnote}</Text>

            <Row style={{ gap: 6, flexWrap: "wrap", marginTop: 14 }}>
              {(sample.chips ?? []).map((c: string) => (
                <View key={c} style={s.sampleChip}><Text style={s.sampleChipText}>{c}</Text></View>
              ))}
            </Row>

            {sample.video ? (
              <TouchableOpacity
                onPress={() => Linking.openURL(sample.video)}
                style={s.sampleVideoBtn}
                activeOpacity={0.85}
              >
                <Text style={s.sampleVideoBtnIcon}>▶</Text>
                <Text style={s.sampleVideoBtnText}>{sample.videoLabel || "Watch the steps on YouTube"}</Text>
              </TouchableOpacity>
            ) : null}

            <Btn
              label={heroPrimaryCta}
              onPress={() => { setSample(null); goAssessment(); }}
              style={{ alignSelf: "flex-start", marginTop: 22 }}
            />
          </View>
        )}
      </Modal>

      {/* ── DAILY WISDOM TEASER ─────────────────────────────────────── */}
      <Section bg={colors.surfaceAlt}>
        <View style={s.wisdomCard}>
          {/* Left: golden ॐ icon */}
          <View style={s.wisdomIconBox}>
            <Text style={s.wisdomIconText}>ॐ</Text>
          </View>
          {/* Right: content */}
          <View style={s.wisdomContent}>
            <Text style={s.wisdomEyebrow}>{wisdomBannerHeader}</Text>
            <Text style={s.wisdomTitle}>{wisdom.title}</Text>
            <Text style={s.wisdomBody}>{wisdom.body}</Text>
            <Text style={s.wisdomAttrib}>{wisdomBannerAttribution}</Text>
          </View>
        </View>
      </Section>

      {/* ── 9 SUBJECTS ─────────────────────────────────────────────── */}
      <Section id="subjects">
        <Text style={s.eyebrow}>{subjectsEyebrow}</Text>
        <H2>{subjectsTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 24 }}>{subjectsSubtitle}</Body>
        <View style={[s.subjectGrid, !wide && { flexDirection: "column" }]}>
          {Object.keys(sc.descriptions).map(slug => {
            const meta = SUBJECT_META[slug];
            if (!meta) return null;
            return (
              <TouchableOpacity
                key={slug}
                activeOpacity={0.8}
                style={[s.card, s.subjectCard, !wide && { width: "100%", minHeight: undefined }]}
                onPress={() => { setWsTopic(slug); scrollTo("worksheets"); }}
              >
                <View style={[s.subjectIcon, { backgroundColor: meta.color }]}>
                  <Text style={s.subjectIconText}>{meta.icon}</Text>
                </View>
                <H3 style={{ marginBottom: 6 }}>
                  {sc.labels[slug] || meta.label}
                </H3>
                <Body style={{ color: colors.textMuted, fontSize: 13 }}>{sc.descriptions[slug]}</Body>
              </TouchableOpacity>
            );
          })}
        </View>
      </Section>

      {/* ── WORKSHEET PREVIEW ──────────────────────────────────────── */}
      <Section bg={colors.surfaceAlt} id="worksheets">
        <Text style={s.eyebrow}>{worksheetsEyebrow}</Text>
        <H2>{worksheetsTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 16 }}>{worksheetsSubtitle}</Body>

        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 10 }}>
          <Row style={{ gap: 8 }}>
            {gradesList.map((g: any) => (
              <TouchableOpacity key={g.grade_id} onPress={() => setWsGrade(g.grade_id)}>
                <Pill
                  label={g.label}
                  bg={wsGrade === g.grade_id ? colors.text : "#fff"}
                  color={wsGrade === g.grade_id ? "#fff" : colors.text}
                />
              </TouchableOpacity>
            ))}
          </Row>
        </ScrollView>

        <ScrollView horizontal showsHorizontalScrollIndicator={false} style={{ marginBottom: 10 }}>
          <Row style={{ gap: 8 }}>
            <TouchableOpacity onPress={() => setWsTopic("trending")}>
              <Pill label="🔥 Trending" bg={wsTopic === "trending" ? colors.brand : "#ffe1d4"} color={wsTopic === "trending" ? "#fff" : colors.brandDark} />
            </TouchableOpacity>
            <TouchableOpacity onPress={() => setWsTopic("all")}>
              <Pill label="All topics" bg={wsTopic === "all" ? colors.text : "#fff"} color={wsTopic === "all" ? "#fff" : colors.text} />
            </TouchableOpacity>
            {subjectsList.map((sub: any) => (
              <TouchableOpacity key={sub.slug} onPress={() => setWsTopic(sub.slug)}>
                <Pill
                  label={`${sub.icon} ${sub.label}`}
                  bg={wsTopic === sub.slug ? colors.text : "#fff"}
                  color={wsTopic === sub.slug ? "#fff" : colors.text}
                />
              </TouchableOpacity>
            ))}
          </Row>
        </ScrollView>

        <Row style={{ gap: 16, flexWrap: "wrap", marginBottom: 20 }}>
          <Row style={{ gap: 6, flexWrap: "wrap" }}>
            <Text style={s.wsFilterLabel}>Level:</Text>
            <TouchableOpacity onPress={() => setWsLevel("all")}>
              <Pill label="All" bg={wsLevel === "all" ? colors.text : "#fff"} color={wsLevel === "all" ? "#fff" : colors.text} />
            </TouchableOpacity>
            {levelsList.map((lv: any) => (
              <TouchableOpacity key={lv.slug} onPress={() => setWsLevel(lv.slug)}>
                <Pill label={lv.label} bg={wsLevel === lv.slug ? colors.text : "#fff"} color={wsLevel === lv.slug ? "#fff" : colors.text} />
              </TouchableOpacity>
            ))}
          </Row>
          <Row style={{ gap: 6, flexWrap: "wrap" }}>
            <Text style={s.wsFilterLabel}>Interest:</Text>
            <TouchableOpacity onPress={() => setWsInterest("all")}>
              <Pill label="All" bg={wsInterest === "all" ? colors.text : "#fff"} color={wsInterest === "all" ? "#fff" : colors.text} />
            </TouchableOpacity>
            {interestsList.map((it: any) => (
              <TouchableOpacity key={it.slug} onPress={() => setWsInterest(it.slug)}>
                <Pill label={`${it.icon} ${it.label}`} bg={wsInterest === it.slug ? colors.text : "#fff"} color={wsInterest === it.slug ? "#fff" : colors.text} />
              </TouchableOpacity>
            ))}
          </Row>
        </Row>

        {worksheetsLoading ? (
          <Body style={{ color: colors.textMuted, textAlign: "center" }}>Loading worksheets…</Body>
        ) : worksheetsList.length === 0 ? (
          <Body style={{ color: colors.textMuted, textAlign: "center", fontStyle: "italic" }}>
            No samples in this combination yet — try a different grade or topic.
          </Body>
        ) : (
          <View style={[s.wsGrid, !wide && { flexDirection: "column" }]}>
            {worksheetsList.map((w: any) => {
              const meta = SUBJECT_META[w.subject] || { icon: "📄", color: colors.surfaceAlt, label: w.subject };
              return (
                <TouchableOpacity
                  key={w.worksheet_id}
                  activeOpacity={0.85}
                  style={[s.wsCard, !wide && { width: "100%" }]}
                  onPress={() => openWorksheet(w)}
                >
                  <View style={[s.wsThumb, { backgroundColor: meta.color }]}>
                    <Text style={s.wsThumbIcon}>{meta.icon}</Text>
                    {!!w.is_free && <View style={s.wsFreeBadge}><Text style={s.wsFreeBadgeText}>FREE</Text></View>}
                    {w.is_trending && <View style={s.wsTrendBadge}><Text style={s.wsTrendBadgeText}>🔥 Trending</Text></View>}
                    {!!w.social_badge && (
                      <View style={s.wsSocialBadge}>
                        <Text style={s.wsSocialBadgeText}>{SOCIAL_LABEL[w.social_badge] || w.social_badge}</Text>
                      </View>
                    )}
                  </View>
                  <View style={{ padding: 14 }}>
                    <Text style={s.wsCardTitle} numberOfLines={2}>{w.title}</Text>
                    <Row style={{ gap: 6, marginTop: 6, flexWrap: "wrap" }}>
                      <Pill label={meta.label} bg="#e9e5ff" />
                      {!!w.estimated_min && <Text style={s.wsMeta}>{w.estimated_min} min</Text>}
                    </Row>
                    <Row style={{ gap: 12, marginTop: 8 }}>
                      {!!w.rating_avg && Number(w.rating_avg) > 0 && (
                        <Text style={s.wsStat}>⭐ {Number(w.rating_avg).toFixed(1)}</Text>
                      )}
                      {!!w.view_count && Number(w.view_count) > 0 && (
                        <Text style={s.wsStat}>⬇ {formatCount(w.view_count)}</Text>
                      )}
                    </Row>
                  </View>
                </TouchableOpacity>
              );
            })}
          </View>
        )}

        <Btn label={worksheetsCta} onPress={goSignup} style={{ alignSelf: "center", marginTop: 28 }} />
      </Section>

      <WorksheetPreviewModal
        visible={!!selectedWorksheet}
        worksheet={selectedWorksheet}
        gradeLabel={selectedWorksheet ? gradeLabelFor(selectedWorksheet.grade_id) : undefined}
        playLabel="Play a sample"
        onClose={() => setSelectedWorksheet(null)}
        onPlay={() => {
          const w = selectedWorksheet;
          setSelectedWorksheet(null);
          router.push({
            pathname: "/(auth)/sample",
            // id lets /sample look the worksheet up and decide whether it is a
            // quiz or a demonstration; without it the screen can only guess
            // from the subject.
            params: {
              subject: w?.subject ?? "math",
              grade: String(w?.grade_id ?? 2),
              title: w?.title ?? "",
              ...(w?.worksheet_id ? { id: String(w.worksheet_id) } : {}),
            },
          });
        }}
        onSignup={() => { setSelectedWorksheet(null); goSignup(); }}
      />

      {/* ── WHY FAMILIES CHOOSE US — 3-column grid ───────────────────── */}
      <Section bg="#fff">
        <Text style={s.eyebrow}>{whyUsEyebrow}</Text>
        <H2 style={{ marginBottom: 32 }}>{whyUsTitle}</H2>
        <View style={[s.valuesGrid, !wide && { flexDirection: "column" }]}>
          {whyUsItems.map(item => (
            <View key={item.n} style={s.valueCol}>
              <Text style={s.valueNum}>{item.n}</Text>
              <Text style={s.valueTitle}>{item.title}</Text>
              <Body style={{ color: colors.textMuted, margin: 0 }}>{item.body}</Body>
            </View>
          ))}
        </View>
      </Section>

      {/* ── TESTIMONIALS — 3-column grid ────────────────────────────── */}
      <Section bg={colors.surfaceAlt}>
        <Text style={s.eyebrow}>{testimonialsEyebrow}</Text>
        <H2 style={{ marginBottom: 28 }}>{testimonialsTitle}</H2>
        <View style={[s.testiGrid, !wide && { flexDirection: "column" }]}> 
          {testimonials.map((item, i) => (
            <View key={i} style={s.testiCard}>
              <Text style={s.stars}>{"★".repeat(item.stars)}</Text>
              <Text style={s.badge}>{item.badge}</Text>
              <Body style={{ fontStyle: "italic", fontSize: 15, lineHeight: 26, marginVertical: 10 }}>
                "{item.quote}"
              </Body>
              <View style={s.testiWho}>
                <View style={[s.testiAvatar, {
                  backgroundColor: i === 0 ? "#a89cb3" : i === 1 ? "#9fb298" : "#e4a5a3"
                }]}> 
                  <Text style={{ color: "#fff", fontWeight: "700", fontSize: 15 }}>
                    {item.name.charAt(0)}
                  </Text>
                </View>
                <View>
                  <Text style={s.tName}>{item.name}</Text>
                  <Text style={s.tLoc}>{item.location}</Text>
                </View>
              </View>
            </View>
          ))}
        </View>
      </Section>

      {/* ── PROGRESS CARDS — 3-column grid ───────────────────────────── */}
      <Section bg={colors.surfaceAlt}>
        <Text style={s.eyebrow}>{progressEyebrow}</Text>
        <H2 style={{ textAlign: "center", marginBottom: 12 }}>{progressTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 36, textAlign: "center" }}>{progressSubtitle}</Body>

        <View style={[s.progressGrid, !wide && { flexDirection: "column" }]}> 
          {progressCards.map((pc, i) => (
            <View key={i} style={s.progressCard}>
              <Row style={{ justifyContent: "space-between", alignItems: "center", marginBottom: 16 }}>
                <Text style={s.progressSubject}>{pc.subject}</Text>
                <View style={s.verifiedBadge}>
                  <Text style={s.verifiedText}>{progressVerifiedLabel}</Text>
                </View>
              </Row>

              <View style={s.weekCompare}>
                <View style={s.weekCard1}>
                  <View style={s.weekPill1}><Text style={s.weekPillText}>{progressWeek1Label}</Text></View>
                  <View style={s.weekLines}>
                    <View style={s.weekLine} />
                    <View style={[s.weekLine, { width: "55%" }]} />
                    {i === 2 && <View style={s.weekLine} />}
                  </View>
                  <Text style={s.weekVal1} numberOfLines={2}>{pc.w1}</Text>
                </View>
                <View style={s.weekCard12}>
                  <View style={s.weekPill12}><Text style={s.weekPillText}>{progressWeek12Label}</Text></View>
                  <Text style={s.weekVal12} numberOfLines={3}>{pc.w12}</Text>
                </View>
              </View>

              <Text style={s.progressName}>{pc.name}</Text>
              <Text style={s.progressDesc}>{pc.desc}</Text>
              <Text style={s.progressQuote}>"{pc.quote}"</Text>
            </View>
          ))}
        </View>
      </Section>

      {/* ── COMPARISON — 2-column card grid ──────────────────────────── */}
      <Section bg="#fff">
        <Text style={s.eyebrow}>{comparisonEyebrow}</Text>
        <H2 style={{ textAlign: "center", marginBottom: 12 }}>{comparisonTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 36, textAlign: "center" }}>{comparisonSubtitle}</Body>

        {/* Two explicit columns so each item fills its column */}
        <View style={[s.compGrid, !wide && { flexDirection: "column" }]}>
          <View style={{ flex: 1, gap: 16 }}>
            {comparisonItems.filter((_, i) => i % 2 === 0).map((c, i) => (
              <View key={i} style={s.compCard}>
                <View style={s.compXBadge}><Text style={s.compXIcon}>✕</Text></View>
                <Text style={s.compQuestion}>{c.complaint}</Text>
                <Text style={s.compAnswer}>{c.answer}</Text>
              </View>
            ))}
          </View>
          <View style={{ flex: 1, gap: 16 }}>
            {comparisonItems.filter((_, i) => i % 2 === 1).map((c, i) => (
              <View key={i} style={s.compCard}>
                <View style={s.compXBadge}><Text style={s.compXIcon}>✕</Text></View>
                <Text style={s.compQuestion}>{c.complaint}</Text>
                <Text style={s.compAnswer}>{c.answer}</Text>
              </View>
            ))}
          </View>
        </View>
      </Section>

      {/* ── PRICING — 3-column grid ─────────────────────────────────── */}
      <Section id="pricing" bg={colors.bg}>
        <Text style={s.eyebrow}>{pricingEyebrow}</Text>
        <H2 style={{ textAlign: "center", marginBottom: 12 }}>{pricingTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 40, textAlign: "center" }}>{pricingSubtitle}</Body>

        <View style={[s.pricingGrid, !wide && { flexDirection: "column" }]}>
          {pricingPlans.map((plan, i) => (
            <View key={i} style={[s.priceCard, plan.featured && s.priceCardFeatured]}>
              {/* "Most popular" badge — centred, overhanging the top border */}
              {plan.featured && (
                <View style={s.popularBadgeWrap}>
                  <View style={s.popularBadge}>
                    <Text style={s.popularBadgeText}>{pricingMostPopular}</Text>
                  </View>
                </View>
              )}

              <View style={{ flex: 1 }}>
                <H3 style={s.priceCardTitle}>{plan.name}</H3>

                {/* Price */}
                <View style={s.priceRow}>
                  <Text style={s.priceBig}>
                    {i === 1 ? `$${familyPrice}` : i === 2 ? `$${shippedPrice}` : plan.price}
                  </Text>
                  <Text style={s.pricePeriod}>{plan.period}</Text>
                </View>

                {/* Annual sub-line */}
                {i === 1 && (
                  <Text style={[s.priceAnnual, { color: colors.brand }]}>
                    {pricingAnnualSaveFamily.replace("${y}", String(familyAnnual)).replace("${s}", String(familySave))}
                  </Text>
                )}
                {i === 2 && (
                  <Text style={s.priceAnnual}>
                    {pricingAnnualSaveShipped.replace("${y}", String(shippedAnnual)).replace("${s}", String(shippedSave))}
                  </Text>
                )}

                <Text style={[s.priceDesc, plan.featured && { color: colors.brand }]}>{plan.desc}</Text>

                {/* Feature list */}
                <View style={s.featuresList}>
                  {plan.features.map((f: string) => (
                    <View key={f} style={s.featureItem}>
                      <Text style={[s.featureCheck, plan.featured && { color: colors.brand }]}>✓</Text>
                      <Text style={[s.featureText, plan.featured && { color: colors.brand }]}>{f}</Text>
                    </View>
                  ))}
                </View>
              </View>

              {/* CTA pinned to bottom */}
              <Btn
                label={plan.cta}
                onPress={goSignup}
                outline={!plan.featured}
                style={[s.priceBtn, plan.featured && { backgroundColor: colors.brand }]}
              />
            </View>
          ))}
        </View>

        {/* Scholarship + payment row */}
        <Text style={s.pricingNote}>{pricingScholarship}</Text>
        <View style={s.payLogosRow}>
          {paymentLogos.map(p => (
            <View key={p} style={s.payChip}>
              <Text style={s.payChipText}>{p}</Text>
            </View>
          ))}
        </View>
      </Section>

      {/* ── COMMUNITY ─────────────────────────────────────────────── */}
      <Section bg={colors.bg} id="social">
        <Text style={s.eyebrow}>{communityEyebrow}</Text>
        <H2 style={{ textAlign: "center", marginBottom: 12 }}>{communityTitle}</H2>
        <Body style={{ color: colors.textMuted, marginBottom: 36, textAlign: "center" }}>{communitySubtitle}</Body>

        {/* Two-column: dark office hours card + white groups card */}
        <View style={[s.communityRow, !wide && { flexDirection: "column" }]}>

          {/* LEFT — dark charcoal office hours */}
          <View style={s.ohCard}>
            <View style={s.ohLiveRow}>
              <View style={s.ohLiveDot} />
              <Text style={s.ohLiveText}>{ohLabel}</Text>
            </View>
            <Text style={s.ohTitle}>{ohTitleText}</Text>
            <Text style={s.ohBody}>{ohBody}</Text>

            {/* Nested white event card */}
            <View style={s.ohEventCard}>
              <View style={s.ohDateBox}>
                <Text style={s.ohDateSmall}>MAY · 7PM PT</Text>
                <View style={s.ohDatePill}>
                  <Text style={s.ohDatePillText}>Wed 27</Text>
                </View>
              </View>
              <View style={{ flex: 1 }}>
                <Text style={s.ohQuote}>
                  {ohThisWeekLabel} "{communityOfficeTopic}"
                </Text>
                <Text style={s.ohHost}>
                  {ohHostLabel} {communityOfficeHost} · {communityOfficeTime}
                </Text>
              </View>
              <TouchableOpacity style={s.rsvpBtn} onPress={goSignup}>
                <Text style={s.rsvpBtnText}>{ohRsvp}</Text>
              </TouchableOpacity>
            </View>
          </View>

          {/* RIGHT — white community groups */}
          <View style={s.groupsCard}>
            <Text style={s.groupsTitle}>{communityGroupsTitle}</Text>
            <Text style={s.groupsSub}>{communityGroupsSub}</Text>
            {communityGroups.map((c, i) => (
              <TouchableOpacity key={c.label} style={[s.groupRow, i === 0 && { borderTopWidth: 0 }]} onPress={goSignup}>
                <Text style={{ fontSize: 20, width: 28 }}>{c.flag}</Text>
                <Text style={[s.groupLabel, { flex: 1 }]}>{c.label}</Text>
                <Text style={s.groupMeta}>{c.platform} · {c.members}</Text>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Full-width referral card — sand background */}
        <View style={[s.referralCard, !wide && { flexDirection: "column" }]}>
          <View style={s.referralLeft}>
            <Text style={s.referralTitle}>{referralTitle}</Text>
            <Body style={{ color: colors.textMuted, marginBottom: 20 }}>{referralDescription}</Body>
            <Btn label={referralCta} onPress={goSignup} style={{ alignSelf: "flex-start" }} />
          </View>
          <View style={s.referralCodeBox}>
            <Text style={s.referralCode}>{referralCode}</Text>
            <Text style={s.referralCodeNote}>{referralCodeNote}</Text>
          </View>
        </View>
      </Section>

      {/* ── SCHOOL LICENSING — dark section ──────────────────────── */}
      <Section id="schools" bg="#3a322a" webBg="linear-gradient(160deg, #3a322a 0%, #2b2420 60%, #231e1c 100%)">
        {/* eyebrow pill on dark bg */}
        <View style={{ alignItems: "center", marginBottom: 14 }}>
          <View style={s.darkEyebrow}>
            <Text style={s.darkEyebrowText}>{schoolsEyebrow}</Text>
          </View>
        </View>
        <Text style={[s.darkH2, { textAlign: "center", marginBottom: 12 }]}>{schoolsTitle}</Text>
        <Body style={{ color: "rgba(245,237,220,0.7)", marginBottom: 36, textAlign: "center" }}>{schoolsSubtitle}</Body>

        {/* 3-column school plan cards */}
        <View style={[s.darkGrid, !wide && { flexDirection: "column" }]}>
          {schoolPlans.map(plan => {
            const [priceNum, ...priceParts] = plan.price.split("/");
            return (
              <View key={plan.label} style={s.darkCard}>
                <Text style={s.darkCardTitle}>{plan.label}</Text>
                <View style={{ flexDirection: "row", alignItems: "flex-end", gap: 2, marginBottom: 6 }}>
                  <Text style={s.darkPrice}>{priceNum}</Text>
                  {priceParts.length > 0 && (
                    <Text style={s.darkPriceUnit}>/{priceParts.join("/")}</Text>
                  )}
                </View>
                <Text style={s.darkCardDesc}>{plan.desc}</Text>
                <View style={{ marginTop: 14 }}>
                  {plan.features.map((f: string) => (
                    <View key={f} style={s.darkFeatureItem}>
                      <Text style={s.darkFeatureCheck}>✓</Text>
                      <Text style={s.darkFeatureText}>{f}</Text>
                    </View>
                  ))}
                </View>
              </View>
            );
          })}
        </View>

        <View style={{ alignItems: "center", marginTop: 32 }}>
          <TouchableOpacity style={s.darkCta} onPress={goSignup}>
            <Text style={s.darkCtaText}>{schoolsCta}</Text>
          </TouchableOpacity>
        </View>
        <Text style={{ textAlign: "center", color: "rgba(245,237,220,0.45)", fontSize: 13, marginTop: 14, ...fBody }}>
          {schoolsNote}
        </Text>
      </Section>

      {/* ── SOCIAL MEDIA — same dark section ─────────────────────── */}
      <Section bg="#2b2420" webBg="linear-gradient(160deg, #2b2420 0%, #231e1c 100%)">
        <View style={{ alignItems: "center", marginBottom: 14 }}>
          <View style={s.darkEyebrow}>
            <Text style={s.darkEyebrowText}>{socialEyebrow}</Text>
          </View>
        </View>
        <Text style={[s.darkH2, { textAlign: "center", marginBottom: 14 }]}>{socialTitle}</Text>
        <Body style={{ color: "rgba(245,237,220,0.7)", marginBottom: 36, textAlign: "center" }}>
          {socialSubtitle}
        </Body>

        <View style={[s.darkGrid, !wide && { flexDirection: "column" }]}>
          {[
            { icon: "♪",  iconBg: "#1a1a1a", name: "TikTok",
              desc: socialCards[0]?.desc,
              handle: cfg["social.tiktok_handle"] || "@littlescholarshub" },
            { icon: "📷", iconBg: "#c13584", name: "Instagram",
              desc: socialCards[1]?.desc,
              handle: cfg["social.instagram_handle"] || "@littlescholarshub" },
            { icon: "📕", iconBg: "#ff2442", name: "Xiaohongshu · 小红书",
              desc: socialCards[2]?.desc,
              handle: socialXhsHandle },
          ].map(item => (
            <View key={item.name} style={s.darkCard}>
              <View style={s.socialPlatformRow}>
                <View style={[s.socialIcon, { backgroundColor: item.iconBg }]}>
                  <Text style={{ fontSize: 16, color: "#fff" }}>{item.icon}</Text>
                </View>
                <Text style={s.socialName}>{item.name}</Text>
              </View>
              <Text style={s.socialDesc}>{item.desc}</Text>
              <Text style={s.socialHandle}>{item.handle}</Text>
            </View>
          ))}
        </View>
      </Section>

      {/* ── EMAIL CAPTURE — CTA wrap card on cream bg ──────────────── */}
      <Section bg={colors.bg}>
        <View style={s.ctaWrap}>
          <View style={s.ctaEyebrowPill}>
            <Text style={s.ctaEyebrowText}>{emailEyebrow}</Text>
          </View>
          <H2 style={{ textAlign: "center", marginBottom: 12, marginTop: 16 }}>{emailTitle}</H2>
          <Body style={{ color: colors.textMuted, textAlign: "center", marginBottom: 28, maxWidth: 480 }}>
            {emailSubtitle}
          </Body>
          <View style={[s.ctaForm, !wide && { flexDirection: "column" }]}>
            <TextInput
              placeholder={emailPlaceholder}
              placeholderTextColor={colors.textMuted}
              style={s.ctaInput}
            />
            <TouchableOpacity style={s.ctaBtn} onPress={goSignup}>
              <Text style={s.ctaBtnText}>{emailCta}</Text>
            </TouchableOpacity>
          </View>
          <Text style={s.ctaNote}>{emailNote}</Text>
        </View>
      </Section>

      {/* ── FOOTER — 4-column grid ───────────────────────────────────── */}
      <View style={s.footer}>
        <View style={s.footerInner}>
          {/* Grid */}
          <View style={[s.footerGrid, !wide && { flexDirection: "column" }]}>
            {/* Col 1: logomark + tagline */}
            <View style={s.footerCol1}>
              <View style={s.footerLogoRow}>
                <View style={s.footerLogoMark}>
                  <Text style={{ color: "#fff", fontWeight: "800", fontSize: 13 }}>LS</Text>
                </View>
                <Text style={s.footerBrandName}>Little Scholars Hub</Text>
              </View>
              <Text style={s.footerTagline}>{footerTagline}</Text>
            </View>

            {/* Col 2: Learn */}
            <View style={s.footerCol}>
              <Text style={s.footerColHead}>{footerColLearn}</Text>
              {footerLinks.slice(0, 3).map(l => (
                <Text key={l} style={s.footerLink}>{l}</Text>
              ))}
            </View>

            {/* Col 3: Company */}
            <View style={s.footerCol}>
              <Text style={s.footerColHead}>{footerColCompany}</Text>
              {footerCompanyLinks.map(l => (
                <Text key={l} style={s.footerLink}>{l}</Text>
              ))}
            </View>

            {/* Col 4: Follow */}
            <View style={s.footerCol}>
              <Text style={s.footerColHead}>{footerColFollow}</Text>
              {footerSocialLinks.map(l => (
                <Text key={l} style={s.footerLink}>{l}</Text>
              ))}
            </View>
          </View>

          {/* Bottom copyright row */}
          <View style={s.footerCopyRow}>
            <Text style={s.footerCopyText}>{footerCopy}</Text>
            <Row style={{ gap: 16 }}>
              {footerLegal.map(l => (
                <Text key={l} style={[s.footerLink, { textDecorationLine: "underline" }]}>{l}</Text>
              ))}
            </Row>
          </View>
        </View>
      </View>

    </ScrollView>
  );
}

// ── Styles ── matches venerable-gnome-807695.netlify.app ──────────────────────
const maxW    = 1180;
const sidePad = isWeb ? 24 : 20;

// Font families — Fraunces (serif) for headings, Inter for body on web
const fHeading: any = isWeb ? { fontFamily: "'Fraunces', Georgia, serif" } : {};
const fBody:    any = isWeb ? { fontFamily: "'Inter', system-ui, sans-serif" } : {};

const s = StyleSheet.create({
  root:        { flex: 1, backgroundColor: colors.bg },
  rootContent: { alignItems: "center" },

  // Hero 2-column layout
  heroRow:   { flexDirection: isWeb ? "row" : "column", gap: isWeb ? 56 : 40, alignItems: "center" },
  heroLeft:  { flex: isWeb ? 1.1 : undefined },
  heroRight: { flex: isWeb ? 0.9 : undefined, alignItems: "center", width: isWeb ? undefined : "100%" },

  // Illustrated hero scene
  heroScene: {
    width: isWeb ? "100%" : 320,
    aspectRatio: 1,
    backgroundColor: "#ead9c9",
    borderRadius: 28,
    borderWidth: 1,
    borderColor: "#e8d9c8",
    shadowColor: "rgba(60,45,30,1)",
    shadowOpacity: 0.07,
    shadowRadius: 40,
    shadowOffset: { width: 0, height: 12 },
    elevation: 3,
    overflow: "visible",
    position: "relative",
  },
  sceneSun: {
    position: "absolute", top: 36, right: 72,
    width: 58, height: 58, borderRadius: 29,
    backgroundColor: "#e6c76a",
  },
  scenePencil: {
    position: "absolute", top: 86, right: 44,
    fontSize: 28,
    transform: [{ rotate: "-30deg" }],
  },
  sceneStar: {
    position: "absolute",
    fontSize: 18, fontWeight: "700", color: "#e4a5a3",
  },
  // Book illustration
  sceneBook: {
    position: "absolute",
    top: "38%", left: "26%",
    backgroundColor: "#fff",
    borderRadius: 12,
    padding: 14,
    flexDirection: "row",
    gap: 12,
    alignItems: "center",
    shadowColor: "#000", shadowOpacity: 0.08, shadowRadius: 10, shadowOffset: { width: 0, height: 4 },
  },
  sceneBookLeft: { gap: 5, width: 60 },
  sceneBookLine: { height: 5, backgroundColor: "#e8e0d2", borderRadius: 3, width: "100%" },
  sceneBookRight: { alignItems: "center", gap: 4 },
  sceneFigureHead: { width: 18, height: 18, borderRadius: 9, backgroundColor: "#e4a5a3" },
  sceneFigureBody: { width: 24, height: 22, borderRadius: 8, backgroundColor: "#a89cb3" },

  // Floating chips (absolutely positioned over scene)
  floatingChip: {
    position: "absolute",
    backgroundColor: "#fff",
    borderRadius: 16,
    borderWidth: 1,
    borderColor: "#e8e0d2",
    paddingVertical: 10,
    paddingHorizontal: 14,
    flexDirection: "row",
    gap: 10,
    alignItems: "center",
    shadowColor: "rgba(60,45,30,1)",
    shadowOpacity: 0.1,
    shadowRadius: 20,
    shadowOffset: { width: 0, height: 6 },
    elevation: 4,
  },
  chipEmoji: { fontSize: 20 },
  chipLabel: { fontSize: 10, color: colors.textMuted, fontWeight: "600", ...fBody },
  chipValue: { fontSize: 13, fontWeight: "700", color: colors.text, ...fBody },
  chipPeek: {
    marginLeft: 4, width: 20, height: 20, borderRadius: 10,
    backgroundColor: colors.surfaceAlt, alignItems: "center", justifyContent: "center",
  },
  chipPeekText: { fontSize: 10 },
  heroSampleHint: {
    marginTop: 18, textAlign: "center", fontSize: 12.5,
    color: colors.textMuted, fontWeight: "600", ...fBody,
  },

  // Hero sample-preview modal content
  sampleStoryPara: { fontSize: 15.5, lineHeight: 27, color: colors.text, marginBottom: 12, ...fBody },
  sampleProblem: {
    backgroundColor: colors.surfaceAlt, borderRadius: 14,
    padding: 14, marginBottom: 10,
  },
  sampleProblemQ: { fontSize: 14.5, lineHeight: 23, color: colors.text, ...fBody },
  sampleProblemA: { fontSize: 12.5, fontWeight: "700", color: colors.brand, marginTop: 6, ...fBody },
  sampleStep: { flexDirection: "row", gap: 12, alignItems: "flex-start", marginBottom: 12 },
  sampleStepNum: {
    width: 26, height: 26, borderRadius: 13, backgroundColor: colors.brand,
    alignItems: "center", justifyContent: "center", marginTop: 1,
  },
  sampleStepNumText: { color: "#fff", fontWeight: "800", fontSize: 13 },
  sampleStepText: { flex: 1, fontSize: 15, lineHeight: 24, color: colors.text, ...fBody },
  sampleFootnote: {
    marginTop: 8, fontSize: 13, lineHeight: 21, fontStyle: "italic",
    color: colors.textMuted, ...fBody,
  },
  sampleChip: {
    backgroundColor: "#e9e5ff", borderRadius: 999,
    paddingHorizontal: 11, paddingVertical: 5,
  },
  sampleChipText: { fontSize: 11.5, fontWeight: "600", color: "#5a4b8a", ...fBody },
  sampleTask: {
    flexDirection: "row", gap: 12, alignItems: "flex-start", marginBottom: 10,
    backgroundColor: colors.surfaceAlt, borderRadius: 12, padding: 12,
  },
  sampleTaskBox: {
    width: 24, height: 24, borderRadius: 7, backgroundColor: "#fff",
    borderWidth: 1.5, borderColor: colors.brand,
    alignItems: "center", justifyContent: "center", marginTop: 1,
  },
  sampleTaskBoxText: { color: colors.brand, fontWeight: "800", fontSize: 12 },
  sampleTaskText: { flex: 1, fontSize: 14, lineHeight: 22, color: colors.text, ...fBody },
  // Demonstration image + video button (art projects)
  sampleMediaWrap: {
    position: "relative", marginBottom: 18, borderRadius: 14, overflow: "hidden",
    borderWidth: 1, borderColor: colors.border,
    ...(isWeb ? ({ cursor: "pointer" } as any) : {}),
  },
  sampleMedia: { width: "100%", aspectRatio: 16 / 9, backgroundColor: colors.surfaceAlt },
  samplePlay: {
    position: "absolute", top: "50%", left: "50%",
    width: 58, height: 58, borderRadius: 29, marginLeft: -29, marginTop: -29,
    backgroundColor: "rgba(216,120,95,0.94)", alignItems: "center", justifyContent: "center",
  },
  samplePlayIcon: { color: "#fff", fontSize: 22, marginLeft: 4 },
  sampleMediaTag: {
    position: "absolute", top: 10, left: 10, backgroundColor: "rgba(43,36,32,0.72)",
    borderRadius: 999, paddingHorizontal: 10, paddingVertical: 4,
  },
  sampleMediaTagText: { color: "#fff", fontSize: 10, fontWeight: "800", letterSpacing: 0.5 },
  sampleVideoBtn: {
    flexDirection: "row", alignItems: "center", gap: 10, alignSelf: "flex-start",
    backgroundColor: "#fff", borderWidth: 1.5, borderColor: "#e0453a",
    borderRadius: 12, paddingVertical: 12, paddingHorizontal: 18, marginTop: 18,
    ...(isWeb ? ({ cursor: "pointer" } as any) : {}),
  },
  sampleVideoBtnIcon: {
    color: "#fff", backgroundColor: "#e0453a", width: 22, height: 22, borderRadius: 5,
    textAlign: "center", lineHeight: 22, fontSize: 10, overflow: "hidden",
  },
  sampleVideoBtnText: { color: colors.text, fontWeight: "700", fontSize: 14, ...fBody },

  // Navbar — sticky, frosted, warm cream
  navbar:      { width: "100%", maxWidth: maxW, flexDirection: "row", alignItems: "center",
                 paddingHorizontal: 24, paddingVertical: 14, gap: 24, flexWrap: "wrap" },
  navBrand:    { fontWeight: "800", fontSize: 22, color: colors.text, flex: 1, ...fHeading },
  navLinks:    { flexDirection: "row", gap: 22, alignItems: "center" },
  navLink:     { color: colors.text, fontSize: 14, fontWeight: "500", ...fBody },
  navLangs:      { flexDirection: "row", gap: 4, alignItems: "center",
                   backgroundColor: "#fff", borderWidth: 1, borderColor: colors.border,
                   borderRadius: 999, paddingHorizontal: 4, paddingVertical: 4 },
  navLangBtn:    { borderRadius: 999 },
  navLangBtnActive: { backgroundColor: colors.text },
  navLang:       { color: colors.textMuted, fontSize: 13, fontWeight: "600",
                   paddingHorizontal: 12, paddingVertical: 6, borderRadius: 999 },
  navLangActive: { color: "#fff" },

  // Sections — outer stretches full width for bg, inner constrains to maxW with 24px gutters
  sectionOuter: { width: "100%" },
  sectionInner: { maxWidth: maxW, width: "100%", alignSelf: "center",
                  paddingHorizontal: sidePad, paddingVertical: 80 },
  section:      { width: "100%" }, // legacy alias kept for safety
  heroGrad:    { paddingVertical: 72 },
  heroEyebrow: { color: colors.brandDark, fontSize: 13, fontWeight: "600", marginBottom: 16,
                 alignSelf: "flex-start", backgroundColor: "#fff",
                 borderWidth: 1, borderColor: colors.border,
                 borderRadius: 999, paddingHorizontal: 14, paddingVertical: 6 },
  heroTitle:   { fontSize: isWeb ? 52 : 30, fontWeight: "800", color: colors.text,
                 lineHeight: isWeb ? 60 : 38, marginBottom: 18, letterSpacing: -1, ...fHeading },
  heroSub:     { color: colors.textMuted, fontSize: 17, lineHeight: 27, marginBottom: 8, ...fBody },
  // Full-width language strip — sand background, border top+bottom, dot-separated items
  langBar:     { width: "100%", backgroundColor: "#fff",
                 borderTopWidth: 1, borderBottomWidth: 1, borderColor: colors.border,
                 paddingVertical: 14 },
  langBarRow:  { flexDirection: "row", alignItems: "center", justifyContent: "center",
                 flexWrap: "wrap", paddingHorizontal: sidePad, gap: 0 },
  langBarItem: { flexDirection: "row", alignItems: "center" },
  langBarName: { fontSize: 14, color: colors.text, fontWeight: "600",
                 letterSpacing: 0.2, paddingHorizontal: 10, ...fBody },
  langBarDot:  { fontSize: 14, color: colors.textMuted, opacity: 0.4 },
  langBarSep:  { fontSize: 14, color: colors.textMuted, opacity: 0.5, paddingHorizontal: 10 },
  langBarTagline: { fontSize: 13, color: colors.textMuted, letterSpacing: 0.1, fontStyle: "italic", ...fBody },
  heroBanner:  { fontSize: 13, color: colors.textMuted, textAlign: "center" }, // kept as alias

  // Text hierarchy — Fraunces headings, Inter body
  h1:   { fontSize: isWeb ? 42 : 28, fontWeight: "800", color: colors.text, marginBottom: 14,
           lineHeight: isWeb ? 50 : 36, letterSpacing: -0.5, ...fHeading },
  h2:   { fontSize: isWeb ? 36 : 24, fontWeight: "800", color: colors.text, marginBottom: 14,
           letterSpacing: -0.5, ...fHeading },
  h3:   { fontSize: 20, fontWeight: "700", color: colors.text, marginBottom: 6, ...fHeading },
  body: { fontSize: 16, color: colors.text, lineHeight: 26, ...fBody },
  eyebrow: {
    fontSize: 13, fontWeight: "600", letterSpacing: 0.3, color: colors.brandDark,
    alignSelf: "flex-start", backgroundColor: "#fff",
    borderWidth: 1, borderColor: colors.border, borderRadius: 999,
    paddingHorizontal: 14, paddingVertical: 6, marginBottom: 14,
    overflow: "hidden",
    ...fBody,
  },
  eyebrow2: { fontSize: 12, fontWeight: "700", letterSpacing: 1, color: "rgba(255,255,255,0.75)",
              textTransform: "uppercase", marginBottom: 8 },
  note:        { color: colors.textMuted, fontSize: 13, textAlign: "center", lineHeight: 20, ...fBody },

  // Daily wisdom card — horizontal layout matching reference
  wisdomCard:    { flexDirection: isWeb ? "row" : "column", gap: isWeb ? 24 : 16, alignItems: isWeb ? "center" : "flex-start",
                   backgroundColor: "#fff", borderRadius: 20, borderWidth: 1, borderColor: colors.border,
                   padding: 24,
                   shadowColor: "rgba(60,45,30,1)", shadowOpacity: 0.05, shadowRadius: 24, shadowOffset: { width: 0, height: 8 } },
  wisdomIconBox: { width: 72, height: 72, borderRadius: 16, backgroundColor: "#e6c76a",
                   justifyContent: "center", alignItems: "center", flexShrink: 0 },
  wisdomIconText:{ fontSize: 34, color: "#fff" },
  wisdomContent: { flex: 1 },
  wisdomEyebrow: { fontSize: 11, fontWeight: "700", letterSpacing: 1.2, color: colors.brand,
                   textTransform: "uppercase", marginBottom: 8, ...fBody },
  wisdomTitle:   { fontSize: isWeb ? 20 : 18, fontWeight: "800", color: colors.text,
                   marginBottom: 8, lineHeight: isWeb ? 28 : 26, ...fHeading },
  wisdomBody:    { fontSize: 14, color: colors.brand, lineHeight: 22, marginBottom: 10, ...fBody },
  wisdomAttrib:  { fontSize: 12, color: colors.textMuted, fontStyle: "italic", ...fBody },

  // Layout
  row:     { flexDirection: "row", alignItems: "center" },
  divider: { height: 1, backgroundColor: colors.border, marginVertical: 24 },

  // Card — white, border, soft shadow
  card: { backgroundColor: "#fff", borderRadius: 20, padding: 28, borderWidth: 1, borderColor: colors.border,
          shadowColor: "rgba(60,45,30,1)", shadowOpacity: 0.06, shadowRadius: 40, shadowOffset: { width: 0, height: 12 },
          elevation: 2, marginBottom: 4 },

  // Pill — trust chips / tags
  pill:     { backgroundColor: "#fff", borderRadius: 999, borderWidth: 1, borderColor: colors.border,
              paddingHorizontal: 14, paddingVertical: 6, marginRight: 6, marginBottom: 6 },
  pillText: { color: colors.text, fontSize: 13, fontWeight: "600", ...fBody },

  // Button — pill shape like the reference
  btn:           { backgroundColor: colors.brand, borderRadius: 999,
                   paddingHorizontal: 22, paddingVertical: 13 },
  btnOutline:    { backgroundColor: "#fff", borderWidth: 1, borderColor: colors.border },
  btnSmall:      { paddingHorizontal: 16, paddingVertical: 8 },
  btnText:       { color: "#fff", fontWeight: "700", fontSize: 15, textAlign: "center", ...fBody },
  btnOutlineText:{ color: colors.text },
  btnSmallText:  { fontSize: 13 },

  // Subjects grid — white cards, border
  subjectGrid: { flexDirection: "row", flexWrap: "wrap", gap: 16 },
  subjectCard: { width: isWeb ? "31%" : "47%", borderRadius: 20, padding: 28,
                 borderWidth: 1, borderColor: colors.border, minHeight: 160 },
  subjectIcon: { width: 52, height: 52, borderRadius: 14, alignItems: "center",
                 justifyContent: "center", marginBottom: 14 },
  subjectIconText: { fontSize: 26 },

  // Dual mode — digital vs. print
  dualEyebrowPill: { backgroundColor: colors.surfaceAlt, borderRadius: 999,
                     paddingHorizontal: 14, paddingVertical: 6, marginBottom: 16 },
  dualEyebrowText: { fontSize: 12, fontWeight: "700", color: colors.textMuted,
                     letterSpacing: 0.4, ...fBody },
  dualGrid:      { flexDirection: isWeb ? "row" : "column", gap: 20,
                   alignItems: isWeb ? "stretch" : "flex-start", marginBottom: 32 },
  dualCard:      { flex: isWeb ? 1 : undefined, minWidth: isWeb ? 0 : undefined,
                   backgroundColor: "#fff", borderRadius: 18, borderWidth: 1,
                   borderColor: colors.border, padding: 24 },
  dualIconBadge: { width: 48, height: 48, borderRadius: 14, backgroundColor: colors.surfaceAlt,
                   alignItems: "center", justifyContent: "center", marginBottom: 14 },
  dualIconText:  { fontSize: 22 },
  dualFeatureRow:  { flexDirection: "row", gap: 8, alignItems: "flex-start" },
  dualFeatureCheck:{ color: colors.brand, fontWeight: "700", fontSize: 13, marginTop: 1 },
  dualFeatureText: { flex: 1, color: colors.text, fontSize: 13, lineHeight: 19, ...fBody },
  dualDivider:   { alignSelf: "center", color: colors.textMuted, fontSize: 13,
                   fontWeight: "600", ...fBody },
  dualStatsRow:  { flexDirection: "row", justifyContent: "center", gap: isWeb ? 56 : 28,
                   flexWrap: "wrap", paddingTop: 24, borderTopWidth: 1,
                   borderTopColor: colors.border, marginBottom: 20 },
  dualStatCol:   { alignItems: "center" },
  dualStatNum:   { fontSize: 24, fontWeight: "800", color: colors.text, ...fHeading },
  dualStatLabel: { fontSize: 12, color: colors.textMuted, marginTop: 2, ...fBody },

  // Cultural tracks — 3-column grid
  culturalGrid: { flexDirection: isWeb ? "row" : "column", gap: 16, alignItems: isWeb ? "stretch" : "flex-start" },
  culturalCard: { flex: isWeb ? 1 : undefined, minWidth: isWeb ? 0 : undefined, flexDirection: "column" },
  trackEmoji:    { fontSize: 36, marginBottom: 12 },
  trackSubtitle: { color: colors.textMuted, fontSize: 13, marginBottom: 16, lineHeight: 20, ...fBody },
  trackStep:     { flexDirection: "row", gap: 12, marginBottom: 10,
                   backgroundColor: "#f9f5ed", borderRadius: 12, padding: 14 },
  trackNum:      { width: 28, height: 28, borderRadius: 14, backgroundColor: colors.text,
                   justifyContent: "center", alignItems: "center", flexShrink: 0 },
  trackNumText:  { color: "#fff", fontWeight: "800", fontSize: 13 },
  trackStepTitle:{ fontWeight: "700", color: colors.text, fontSize: 14, marginBottom: 3, ...fBody },
  trackStepBody: { color: colors.textMuted, fontSize: 12, lineHeight: 18, ...fBody },
  // Dark END GOAL card — pushed to bottom with marginTop: "auto"
  trackGoalDark:      { backgroundColor: "#3a322a", borderRadius: 14, padding: 18, marginTop: "auto" as any },
  trackGoalLabel:     { fontSize: 11, fontWeight: "700", letterSpacing: 1.5,
                        color: colors.brand, textTransform: "uppercase", marginBottom: 8 },
  trackGoalTitleDark: { fontSize: 17, fontWeight: "800", color: "#f5eddc", marginBottom: 6, lineHeight: 24, ...fHeading },
  trackGoalBodyDark:  { color: "rgba(245,237,220,0.7)", fontSize: 13, lineHeight: 20, ...fBody },
  trackOpenCta: { color: colors.brandDark, fontWeight: "700", fontSize: 13, marginTop: 14, ...fBody },

  // Worksheet library — filters, cards, modal
  wsFilterLabel: { fontSize: 12, fontWeight: "700", color: colors.textMuted, marginRight: 4, alignSelf: "center", ...fBody },
  wsGrid: { flexDirection: "row", flexWrap: "wrap", gap: 16 },
  wsCard: { width: isWeb ? "23%" : "100%", minWidth: isWeb ? 220 : undefined,
            backgroundColor: "#fff", borderRadius: 16, borderWidth: 1, borderColor: colors.border,
            overflow: "hidden" },
  wsThumb: { aspectRatio: 4 / 3, alignItems: "center", justifyContent: "center", position: "relative" },
  wsThumbIcon: { fontSize: 40 },
  wsTrendBadge: { position: "absolute", bottom: 8, left: 8, backgroundColor: colors.brand,
                  borderRadius: 999, paddingHorizontal: 8, paddingVertical: 3 },
  wsTrendBadgeText: { color: "#fff", fontSize: 10, fontWeight: "800" },
  wsFreeBadge: { position: "absolute", top: 8, left: 8, backgroundColor: "#16a34a",
                 borderRadius: 999, paddingHorizontal: 8, paddingVertical: 3 },
  wsFreeBadgeText: { color: "#fff", fontSize: 10, fontWeight: "800" },
  wsSocialBadge: { position: "absolute", top: 8, right: 8, backgroundColor: "#fff",
                   borderRadius: 999, paddingHorizontal: 8, paddingVertical: 3,
                   borderWidth: 1, borderColor: colors.border },
  wsSocialBadgeText: { fontSize: 10, fontWeight: "700", color: colors.text },
  wsCardTitle: { fontSize: 14, fontWeight: "700", color: colors.text, ...fBody },
  wsMeta: { fontSize: 11, color: colors.textMuted, alignSelf: "center", ...fBody },
  wsStat: { fontSize: 12, color: colors.textMuted, fontWeight: "600", ...fBody },
  wsModalThumb: { width: "100%", aspectRatio: 16 / 9, borderRadius: 16, alignItems: "center", justifyContent: "center" },
  wsModalIcon: { fontSize: 56 },
  // kept for any other uses
  trackGoal:     { borderLeftWidth: 4, borderLeftColor: colors.brand, paddingLeft: 14, marginTop: 14 },
  trackGoalTitle:{ fontSize: 16, fontWeight: "800", color: colors.text, marginVertical: 4, ...fHeading },
  trackGoalBody: { color: colors.textMuted, fontSize: 13, lineHeight: 20, ...fBody },

  // Values grid — 3 columns matching reference
  valuesGrid: { flexDirection: isWeb ? "row" : "column", gap: 32 },
  valueCol:   { flex: isWeb ? 1 : undefined },
  valueNum:   { fontSize: 40, fontWeight: "800", color: colors.brand, marginBottom: 6, ...fHeading },
  valueTitle: { fontSize: 18, fontWeight: "700", color: colors.text, marginBottom: 8, ...fBody },

  // Testimonials grid — 3 columns
  testiGrid:   { flexDirection: isWeb ? "row" : "column", gap: 20, alignItems: isWeb ? "stretch" : undefined },
  testiCard:   { flex: isWeb ? 1 : undefined, backgroundColor: "#fff", borderRadius: 18,
                 borderWidth: 1, borderColor: colors.border, padding: 26 },
  testiWho:    { marginTop: 18, flexDirection: "row", gap: 12, alignItems: "center" },
  testiAvatar: { width: 40, height: 40, borderRadius: 20, justifyContent: "center", alignItems: "center", flexShrink: 0 },

  // legacy kept for potential use
  featureRow: { flexDirection: "row", gap: 18, marginBottom: 24 },
  featureN:   { fontSize: 36, fontWeight: "800", color: "#e8e0d2", width: 52, ...fHeading },

  // Testimonials
  stars: { color: "#f5a623", fontSize: 16, marginBottom: 6, letterSpacing: 2 },
  badge: { backgroundColor: "#f2eadf", borderRadius: 999, paddingHorizontal: 10, paddingVertical: 4,
           fontSize: 12, color: colors.brandDark, fontWeight: "600",
           alignSelf: "flex-start", marginBottom: 6, ...fBody },
  tName: { fontWeight: "700", color: colors.text, marginTop: 8, ...fBody },
  tLoc:  { color: colors.textMuted, fontSize: 13, ...fBody },

  // Progress cards — 3-column grid
  progressGrid:    { flexDirection: isWeb ? "row" : "column", gap: 20,
                     alignItems: isWeb ? "stretch" : undefined },
  progressCard:    { flex: isWeb ? 1 : undefined, backgroundColor: "#fff", borderRadius: 18,
                     borderWidth: 1, borderColor: "#e8e2d9", padding: 22,
                     shadowColor: "rgba(60,45,30,1)", shadowOpacity: 0.05,
                     shadowRadius: 16, shadowOffset: { width: 0, height: 4 }, elevation: 1 },
  progressSubject: { fontSize: 13, color: colors.textMuted, fontWeight: "500", ...fBody },
  verifiedBadge:   { borderWidth: 1, borderColor: colors.green, borderRadius: 999,
                     paddingHorizontal: 10, paddingVertical: 4 },
  verifiedText:    { fontSize: 12, color: colors.green, fontWeight: "600", ...fBody },
  // Week comparison mini cards
  weekCompare:  { flexDirection: "row", gap: 8, marginBottom: 20,
                  backgroundColor: "#ede6da", borderRadius: 14, padding: 10 },
  // Week 1: warm tan bg (NOT dark), pill badge IS dark for contrast
  weekCard1:    { flex: 1, backgroundColor: "#c4b09a", borderRadius: 10, padding: 12, minHeight: 110 },
  // Week 12: sage green
  weekCard12:   { flex: 1, backgroundColor: "#9fb298", borderRadius: 10, padding: 12, minHeight: 110 },
  weekPill1:    { backgroundColor: "#3a322a", borderRadius: 999,
                  paddingHorizontal: 8, paddingVertical: 3, alignSelf: "flex-start", marginBottom: 10 },
  weekPill12:   { backgroundColor: "rgba(0,0,0,0.2)", borderRadius: 999,
                  paddingHorizontal: 8, paddingVertical: 3, alignSelf: "flex-start", marginBottom: 10 },
  weekPillText: { color: "#fff", fontSize: 9, fontWeight: "800", letterSpacing: 0.3, ...fBody },
  weekLines:    { gap: 7, marginBottom: 10 },
  weekLine:     { height: 5, backgroundColor: colors.brand, borderRadius: 3,
                  opacity: 0.8, width: "100%" },
  weekVal1:     { fontSize: 10, color: "rgba(60,40,20,0.55)", lineHeight: 14, ...fBody },
  weekVal12:    { fontSize: 16, fontWeight: "800", color: "#fff", lineHeight: 22, ...fHeading },
  weekLabel:    { fontSize: 9, color: colors.textMuted, ...fBody },
  // Card text
  progressName: { fontSize: 18, fontWeight: "800", color: colors.text,
                  marginBottom: 4, letterSpacing: -0.3, ...fHeading },
  progressDesc: { fontSize: 13, color: colors.textMuted, marginBottom: 10, lineHeight: 18, ...fBody },
  progressQuote:{ fontSize: 13, fontStyle: "italic", color: colors.brand,
                  lineHeight: 20, ...fBody },

  // Comparison — 2-column card grid
  compGrid:     { flexDirection: isWeb ? "row" : "column", gap: 16 },
  compCard:     { backgroundColor: "#f9f5ed", borderRadius: 16, padding: 22,
                  borderWidth: 1, borderColor: colors.border },
  compXBadge:   { width: 28, height: 28, borderRadius: 6, borderWidth: 1, borderColor: colors.border,
                  justifyContent: "center", alignItems: "center", marginBottom: 12 },
  compXIcon:    { fontSize: 12, color: colors.textMuted, fontWeight: "700" },
  compQuestion: { fontSize: 15, fontWeight: "700", color: colors.text, fontStyle: "italic",
                  marginBottom: 10, lineHeight: 22, ...fBody },
  compAnswer:   { fontSize: 13, color: colors.textMuted, lineHeight: 20, ...fBody },

  // legacy kept
  progressWeek:  { flex: 1, borderRadius: 12, padding: 14 },
  progressLabel: { fontSize: 11, fontWeight: "700", color: colors.textMuted, marginBottom: 4,
                   textTransform: "uppercase", letterSpacing: 0.5, ...fBody },
  progressVal:   { fontSize: 14, fontWeight: "700", color: colors.text, ...fBody },
  compRow:      { flexDirection: "row", gap: 14, marginBottom: 22, paddingBottom: 22,
                  borderBottomWidth: 1, borderBottomColor: colors.border },
  compX:        { fontSize: 20, color: colors.brand, width: 30 },
  compComplaint:{ fontWeight: "700", color: colors.text, fontSize: 14, fontStyle: "italic", ...fBody },

  // Pricing — 3-column grid
  pricingGrid:       { flexDirection: isWeb ? "row" : "column", gap: 20,
                       alignItems: isWeb ? "stretch" : undefined, marginTop: 16 },
  priceCard:         { flex: isWeb ? 1 : undefined, flexDirection: "column",
                       backgroundColor: "#fff", borderRadius: 22,
                       borderWidth: 1, borderColor: colors.border,
                       padding: 28, position: "relative" },
  priceCardFeatured: { borderWidth: 2, borderColor: colors.brand },

  // "Most popular" badge — absolutely centred at the top
  popularBadgeWrap:  { position: "absolute", top: -14, left: 0, right: 0, alignItems: "center", zIndex: 2 },
  popularBadge:      { backgroundColor: colors.brand, borderRadius: 999,
                       paddingHorizontal: 14, paddingVertical: 4 },
  popularBadgeText:  { color: "#fff", fontWeight: "700", fontSize: 12, ...fBody },

  priceCardTitle:    { fontSize: 22, marginBottom: 6, ...fHeading },
  priceRow:          { flexDirection: "row", alignItems: "flex-end", gap: 4, marginTop: 8, marginBottom: 4 },
  priceBig:          { fontSize: 44, fontWeight: "800", color: colors.text, lineHeight: 50, ...fHeading },
  pricePeriod:       { fontSize: 14, color: colors.textMuted, fontWeight: "400", marginBottom: 8, ...fBody },
  priceAnnual:       { fontSize: 13, color: colors.textMuted, marginBottom: 8, ...fBody },
  priceDesc:         { fontSize: 14, color: colors.textMuted, marginBottom: 18, ...fBody },

  // Feature list with ✓ checkmarks
  featuresList:  { flex: 1 },
  featureItem:   { flexDirection: "row", gap: 10, paddingVertical: 8, alignItems: "flex-start",
                   borderTopWidth: 0 },
  featureCheck:  { color: colors.green, fontWeight: "800", fontSize: 14, width: 16, marginTop: 1 },
  featureText:   { flex: 1, fontSize: 14, color: colors.text, lineHeight: 20, ...fBody },
  priceBtn:      { marginTop: 20, borderRadius: 999 },

  // Scholarship note + payment logos
  pricingNote:   { textAlign: "center", color: colors.brand, fontSize: 13, marginTop: 24, ...fBody },
  payLogosRow:   { flexDirection: "row", flexWrap: "wrap", gap: 8, justifyContent: "center", marginTop: 14 },
  payChip:       { backgroundColor: "#fff", borderRadius: 999, borderWidth: 1, borderColor: colors.border,
                   paddingHorizontal: 12, paddingVertical: 6 },
  payChipText:   { fontSize: 12, color: colors.text, ...fBody },

  // legacy
  price:      { fontSize: 40, fontWeight: "800", color: colors.text, marginVertical: 6, ...fHeading },
  priceUnit:  { fontSize: 15, fontWeight: "400", color: colors.textMuted },
  priceSub:   { fontSize: 13, color: colors.textMuted, marginBottom: 14, ...fBody },
  feature:    { fontSize: 14, color: colors.text, marginBottom: 8, paddingLeft: 20, ...fBody },
  mostPopular:{ backgroundColor: colors.brand, borderRadius: 999,
                paddingHorizontal: 14, paddingVertical: 4, alignSelf: "flex-start", marginBottom: 10 },
  payLogo:    { backgroundColor: colors.surfaceAlt, borderRadius: 8, paddingHorizontal: 12, paddingVertical: 8 },

  // Community — 2-column layout
  communityRow:  { flexDirection: isWeb ? "row" : "column", gap: 20, marginBottom: 20,
                   alignItems: isWeb ? "stretch" : undefined },

  // Dark charcoal office hours card
  ohCard:        { flex: isWeb ? 1.2 : undefined, backgroundColor: "#3a322a", borderRadius: 22, padding: 28 },
  ohLiveRow:     { flexDirection: "row", alignItems: "center", gap: 6, marginBottom: 14 },
  ohLiveDot:     { width: 8, height: 8, borderRadius: 4, backgroundColor: colors.brand },
  ohLiveText:    { fontSize: 11, fontWeight: "700", color: colors.brand,
                   letterSpacing: 1.2, textTransform: "uppercase", ...fBody },
  ohTitle:       { fontSize: 22, fontWeight: "800", color: "#f5eddc", marginBottom: 10, ...fHeading },
  ohBody:        { fontSize: 13, color: "rgba(245,237,220,0.65)", lineHeight: 20, marginBottom: 20, ...fBody },
  ohEventCard:   { backgroundColor: "#fff", borderRadius: 14, padding: 14,
                   flexDirection: "row", gap: 12, alignItems: "center" },
  ohDateBox:     { alignItems: "center", width: 58 },
  ohDateSmall:   { fontSize: 9, color: colors.textMuted, letterSpacing: 0.5, marginBottom: 5,
                   textTransform: "uppercase", textAlign: "center", ...fBody },
  ohDatePill:    { backgroundColor: colors.brand, borderRadius: 8, paddingHorizontal: 8, paddingVertical: 5 },
  ohDatePillText:{ color: "#fff", fontWeight: "800", fontSize: 13, ...fBody },
  ohQuote:       { fontSize: 13, fontStyle: "italic", color: colors.text, lineHeight: 19, marginBottom: 5, ...fBody },
  ohHost:        { fontSize: 11, color: colors.textMuted, ...fBody },
  rsvpBtn:       { backgroundColor: colors.brand, borderRadius: 999,
                   paddingHorizontal: 16, paddingVertical: 10, flexShrink: 0 },
  rsvpBtnText:   { color: "#fff", fontWeight: "700", fontSize: 13, ...fBody },

  // White community groups card
  groupsCard:    { flex: isWeb ? 1 : undefined, backgroundColor: "#fff", borderRadius: 22,
                   borderWidth: 1, borderColor: colors.border, padding: 24 },
  groupsTitle:   { fontSize: 18, fontWeight: "800", color: colors.text, marginBottom: 6, ...fHeading },
  groupsSub:     { fontSize: 13, color: colors.textMuted, lineHeight: 20, marginBottom: 6, ...fBody },
  groupRow:      { flexDirection: "row", alignItems: "center", gap: 10,
                   paddingVertical: 12, borderTopWidth: 1, borderTopColor: colors.border },
  groupLabel:    { fontSize: 13, fontWeight: "600", color: colors.text, ...fBody },
  groupMeta:     { fontSize: 12, color: colors.brand, fontWeight: "600", ...fBody },

  // Referral card — sand bg, dashed code box
  referralCard:     { backgroundColor: colors.surfaceAlt, borderRadius: 22, borderWidth: 1,
                      borderColor: colors.border, padding: 28, marginTop: 0,
                      flexDirection: isWeb ? "row" : "column", gap: 24, alignItems: "center" },
  referralLeft:     { flex: 1 },
  referralTitle:    { fontSize: 24, fontWeight: "800", color: colors.text, marginBottom: 10, ...fHeading },
  referralCodeBox:  { borderWidth: 2, borderColor: colors.brand,
                      borderStyle: "dashed" as any,
                      borderRadius: 14, padding: 24, alignItems: "center",
                      minWidth: isWeb ? 220 : undefined, width: isWeb ? undefined : "100%" },
  referralCode:     { fontSize: 18, fontWeight: "800", color: colors.brand,
                      letterSpacing: 3, fontFamily: "monospace", marginBottom: 8 },
  referralCodeNote: { fontSize: 12, color: colors.textMuted, textAlign: "center", ...fBody },

  // legacy
  ohRow:        { marginTop: 14 },
  communityLink:{ flexDirection: "row", alignItems: "center", gap: 14, padding: 16, borderRadius: 14,
                  backgroundColor: "#fff", borderWidth: 1, borderColor: colors.border, marginBottom: 10 },
  refCode:      { marginTop: 16, padding: 16, backgroundColor: colors.surfaceAlt,
                  borderRadius: 12, borderWidth: 1, borderColor: colors.border },

  // ── Dark section shared styles (schools + social) ────────────────
  darkEyebrow:     { backgroundColor: "transparent", borderWidth: 1, borderColor: colors.brand,
                     borderRadius: 999, paddingHorizontal: 14, paddingVertical: 5 },
  darkEyebrowText: { fontSize: 12, fontWeight: "600", color: colors.brand, ...fBody },
  darkH2:          { fontSize: isWeb ? 36 : 26, fontWeight: "800", color: "#f5eddc",
                     lineHeight: isWeb ? 44 : 34, letterSpacing: -0.5, ...fHeading },
  darkGrid:        { flexDirection: isWeb ? "row" : "column", gap: 16,
                     alignItems: isWeb ? "stretch" : undefined },
  darkCard:        { flex: isWeb ? 1 : undefined, backgroundColor: "rgba(255,255,255,0.07)",
                     borderWidth: 1, borderColor: "rgba(255,255,255,0.12)",
                     borderRadius: 18, padding: 24 },
  darkCardTitle:   { fontSize: 18, fontWeight: "700", color: "#f5eddc", marginBottom: 8, ...fHeading },
  darkPrice:       { fontSize: 32, fontWeight: "800", color: "#e6c76a", lineHeight: 38, ...fHeading },
  darkPriceUnit:   { fontSize: 13, color: "rgba(245,237,220,0.6)", marginBottom: 6, ...fBody },
  darkCardDesc:    { fontSize: 13, color: colors.brand, fontStyle: "italic", ...fBody },
  darkFeatureItem: { flexDirection: "row", gap: 8, paddingVertical: 5, alignItems: "flex-start" },
  darkFeatureCheck:{ color: colors.brand, fontWeight: "800", fontSize: 13, width: 14 },
  darkFeatureText: { flex: 1, fontSize: 13, color: "rgba(245,237,220,0.8)", lineHeight: 19, ...fBody },
  darkCta:         { backgroundColor: "#e6c76a", borderRadius: 999, paddingHorizontal: 24, paddingVertical: 14 },
  darkCtaText:     { color: "#2b2420", fontWeight: "700", fontSize: 15, ...fBody },

  // Social cards
  socialPlatformRow: { flexDirection: "row", alignItems: "center", gap: 10, marginBottom: 14 },
  socialIcon:        { width: 32, height: 32, borderRadius: 8, justifyContent: "center", alignItems: "center" },
  socialName:        { fontSize: 16, fontWeight: "700", color: "#f5eddc", ...fHeading },
  socialDesc:        { fontSize: 14, color: "rgba(255,255,255,0.8)", lineHeight: 20, marginBottom: 6, ...fBody },
  socialHandle:      { fontSize: 13, color: "rgba(255,255,255,0.45)", ...fBody },

  // CTA wrap card — gradient-like sand rounded card on cream bg
  ctaWrap:        { backgroundColor: "#f2e8d9", borderRadius: 28, borderWidth: 1, borderColor: colors.border,
                    padding: isWeb ? 56 : 32, paddingHorizontal: isWeb ? 40 : 24,
                    alignItems: "center", width: "100%" },
  ctaEyebrowPill: { borderRadius: 999, borderWidth: 1, borderColor: colors.brand,
                    paddingHorizontal: 14, paddingVertical: 5 },
  ctaEyebrowText: { color: colors.brand, fontSize: 12, fontWeight: "600", ...fBody },
  ctaForm:        { flexDirection: isWeb ? "row" : "column", gap: 8,
                    maxWidth: 480, width: "100%", justifyContent: "center" },
  ctaInput:       { flex: 1, minWidth: isWeb ? 240 : undefined,
                    backgroundColor: "#fff", borderRadius: 999,
                    borderWidth: 1, borderColor: colors.border,
                    paddingHorizontal: 18, paddingVertical: 14, fontSize: 15, ...fBody },
  ctaBtn:         { backgroundColor: colors.brand, borderRadius: 999,
                    paddingHorizontal: 22, paddingVertical: 14, alignItems: "center" },
  ctaBtnText:     { color: "#fff", fontWeight: "700", fontSize: 15, ...fBody },
  ctaNote:        { color: colors.brand, fontSize: 13, marginTop: 12,
                    textAlign: "center", fontStyle: "italic", ...fBody },

  // Footer — 4-column grid
  footer:         { width: "100%", backgroundColor: colors.text, paddingVertical: 56,
                    ...(isWeb ? { backgroundImage: "linear-gradient(160deg, #2b2a27 0%, #1e1c1a 100%)" } as any : {}) },
  footerInner:    { maxWidth: maxW, width: "100%", alignSelf: "center", paddingHorizontal: sidePad },
  footerGrid:     { flexDirection: isWeb ? "row" : "column", gap: isWeb ? 40 : 28, marginBottom: 40 },
  footerCol1:     { flex: isWeb ? 2 : undefined },
  footerCol:      { flex: isWeb ? 1 : undefined },
  footerLogoRow:  { flexDirection: "row", alignItems: "center", gap: 10, marginBottom: 14 },
  footerLogoMark: { width: 36, height: 36, borderRadius: 10, backgroundColor: colors.brand,
                    justifyContent: "center", alignItems: "center" },
  footerBrandName:{ fontSize: 20, fontWeight: "800", color: "#fff", ...fHeading },
  footerTagline:  { fontSize: 14, color: colors.brand, lineHeight: 21,
                    maxWidth: isWeb ? 280 : undefined, ...fBody },
  footerColHead:  { fontSize: 12, fontWeight: "700", color: "#fff", letterSpacing: 1,
                    textTransform: "uppercase", marginBottom: 14, ...fBody },
  footerLink:     { color: "rgba(255,255,255,0.65)", fontSize: 14, paddingVertical: 3, ...fBody },
  footerCopyRow:  { borderTopWidth: 1, borderTopColor: "rgba(255,255,255,0.12)",
                    paddingTop: 20, flexDirection: isWeb ? "row" : "column",
                    justifyContent: "space-between", alignItems: "center", gap: 10 },
  footerCopyText: { fontSize: 13, color: "rgba(255,255,255,0.45)", flex: 1, ...fBody },

  // legacy kept
  footerBrand:{ color: "#fff", fontWeight: "800", fontSize: 20, marginBottom: 10, ...fHeading },
  footerSub:  { color: "rgba(255,255,255,0.6)", fontSize: 14, lineHeight: 22, ...fBody },
  footerCopy: { color: "rgba(255,255,255,0.4)", fontSize: 13, marginTop: 24, ...fBody },
  emailRow:   { flexDirection: isWeb ? "row" : "column", gap: 10, width: "100%", maxWidth: 480 },
  emailInput: { flex: 1, backgroundColor: "rgba(255,255,255,0.12)", borderRadius: 999,
                paddingHorizontal: 20, paddingVertical: 14, color: "#fff", fontSize: 15,
                borderWidth: 1, borderColor: "rgba(255,255,255,0.2)" },
  emailBtn:   { backgroundColor: "#fff", borderRadius: 999, paddingHorizontal: 22,
                paddingVertical: 14, alignItems: "center" },

  // Hero stat badges
  heroBadge:      { backgroundColor: "#fff", borderRadius: 14, borderWidth: 1, borderColor: colors.border,
                    paddingHorizontal: 16, paddingVertical: 10, alignItems: "center", minWidth: 90 },
  heroBadgeNum:   { fontSize: 22, fontWeight: "800", color: colors.text, ...fHeading },
  heroBadgeLabel: { fontSize: 12, color: colors.textMuted, marginTop: 2, textAlign: "center", ...fBody },

  // Assessment card layout
  assessCard: {
    backgroundColor: "#fff",
    borderRadius: 24,
    borderWidth: 1,
    borderColor: colors.border,
    padding: isWeb ? 56 : 32,
    alignItems: "center",
    maxWidth: 640,
    width: "100%",
    alignSelf: "center",
    shadowColor: "rgba(60,45,30,1)",
    shadowOpacity: 0.07,
    shadowRadius: 32,
    shadowOffset: { width: 0, height: 8 },
  },
  assessEyebrowRow: {
    flexDirection: "row", alignItems: "center", gap: 8,
    marginBottom: 20,
    backgroundColor: "#fff",
    borderWidth: 1, borderColor: colors.border,
    borderRadius: 999, paddingHorizontal: 14, paddingVertical: 6,
  },
  assessDot: {
    width: 8, height: 8, borderRadius: 4,
    backgroundColor: "#3cb97a",
  },
  assessEyebrowText: {
    fontSize: 13, fontWeight: "600", color: colors.brandDark, ...fBody,
  },
  assessChipsRow: {
    flexDirection: "row", flexWrap: "wrap", gap: 8, justifyContent: "center",
    marginBottom: 24,
  },

  // Assessment wizard preview
  assessWizardPreview: { flexDirection: "row", flexWrap: "wrap", gap: 12, marginBottom: 28,
                         padding: 16, backgroundColor: "#fff8f1", borderRadius: 14,
                         borderWidth: 1, borderColor: colors.border, alignSelf: "stretch",
                         justifyContent: "center" },
  assessStep: { fontSize: 13, fontWeight: "700", color: colors.brand, ...fBody },
  assessBack: { fontSize: 13, color: colors.textMuted, ...fBody },
  assessSkip: { fontSize: 13, color: colors.textMuted, ...fBody },
  assessNext: { fontSize: 13, fontWeight: "700", color: colors.brand, ...fBody },
});
