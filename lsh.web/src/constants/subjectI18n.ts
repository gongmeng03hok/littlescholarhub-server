import { Lang } from "./i18n";

export interface SubjectCopy {
  labels: Record<string, string>;
  descriptions: Record<string, string>;
}

const en: SubjectCopy = {
  labels: {
    phonics:   "English & Phonics",
    reading:   "Reading Comprehension",
    math:      "Math",
    art:       "Art & Creativity",
    story:     "Story Activities",
    workbooks: "Printable Workbooks",
    logic:     "Logic & Critical Thinking",
    feelings:  "Feelings & Emotions",
    manners:   "Character & Manners",
  },
  descriptions: {
    phonics:   "Letter tracing, decodable stories, blending ladders, and sight-word packs from TK through 3rd grade.",
    reading:   "Leveled passages A–Z with inference questions, vocabulary lists, and optional audio narration.",
    math:      "Spiral review, Singapore bar models, fluency drills, and word problems in four languages.",
    art:       "Low-supply art projects, cultural traditions (Lunar New Year, Rangoli, Papel Picado), timelapse demos.",
    story:     "Weekly story pack: one read-aloud, plus vocabulary, math problem, art craft, and journal prompt — all on one theme.",
    workbooks: "Full 40–60 page quarterly workbooks per grade. Download at home or ship the print version.",
    logic:     "Visual logic puzzles, pattern grids, riddles, and chess mini-lessons — the Beast-Academy style thinking practice parents ask for.",
    feelings:  "Feelings-wheel cards, calm-down strategies, big-emotion stories, and \"name it to tame it\" journaling — SEL built into every week.",
    manners:   "Values-based short stories, table manners practice, friendship scripts, and everyday kindness challenges — in your family's cultural style.",
  },
};

const zh: SubjectCopy = {
  labels: {
    phonics:   "英语与拼读",
    reading:   "阅读理解",
    math:      "数学",
    art:       "艺术与创意",
    story:     "故事活动",
    workbooks: "可印刷练习本",
    logic:     "逻辑与批判性思维",
    feelings:  "情感与情绪",
    manners:   "品格与礼仪",
  },
  descriptions: {
    phonics:   "字母描摹、可解码故事、拼读练习和高频字词包，适合TK至三年级。",
    reading:   "A–Z分级阅读文章，附推理问题、词汇表和可选音频旁白。",
    math:      "螺旋复习、新加坡数学模型、流利度训练和四种语言版本的应用题。",
    art:       "低材料艺术项目，包含文化传统（农历新年、Rangoli花纹、papel picado），慢动作演示。",
    story:     "每周故事包：一篇朗读故事，加上词汇、数学题、艺术手工和日记主题——围绕一个主题。",
    workbooks: "每年级完整40–60页季度练习本。可在家下载或邮寄印刷版。",
    logic:     "视觉逻辑谜题、图案格、谜语和国际象棋小课——家长们追捧的Beast Academy思维训练风格。",
    feelings:  "情感轮卡片、平静策略、大情绪故事，以及「命名来驯服」日记——每周都有SEL情感教育。",
    manners:   "价值观短故事、餐桌礼仪练习、友谊脚本和日常善意挑战——以你家庭的文化方式呈现。",
  },
};

const hi: SubjectCopy = {
  labels: {
    phonics:   "अंग्रेज़ी & फोनिक्स",
    reading:   "पढ़ाई की समझ",
    math:      "गणित",
    art:       "कला & रचनात्मकता",
    story:     "कहानी गतिविधियाँ",
    workbooks: "प्रिंट करने योग्य वर्कबुक",
    logic:     "तर्क & आलोचनात्मक सोच",
    feelings:  "भावनाएँ & संवेदनाएँ",
    manners:   "चरित्र & शिष्टाचार",
  },
  descriptions: {
    phonics:   "TK से तीसरी कक्षा तक के लिए अक्षर ट्रेसिंग, पठनीय कहानियाँ, ब्लेंडिंग अभ्यास और दृष्टि-शब्द पैक।",
    reading:   "A–Z स्तर के अंश जिनमें अनुमान के प्रश्न, शब्द सूचियाँ और वैकल्पिक ऑडियो नैरेशन शामिल हैं।",
    math:      "चार भाषाओं में स्पाइरल समीक्षा, सिंगापुर बार मॉडल, प्रवाह अभ्यास और शब्द समस्याएँ।",
    art:       "कम सामग्री की कला परियोजनाएँ, सांस्कृतिक परंपराएँ (लूनर न्यू ईयर, रंगोली, पेपर पिकादो), टाइमलैप्स डेमो।",
    story:     "साप्ताहिक कहानी पैक: एक रीड-अलाउड, साथ में शब्दावली, गणित, कला और जर्नल प्रॉम्प्ट — सब एक थीम पर।",
    workbooks: "प्रति कक्षा पूर्ण 40–60 पृष्ठ की त्रैमासिक वर्कबुक। घर पर डाउनलोड करें या प्रिंट संस्करण मँगवाएँ।",
    logic:     "दृश्य तर्क पहेलियाँ, पैटर्न ग्रिड, पहेलियाँ और शतरंज मिनी-पाठ — Beast Academy शैली की सोच अभ्यास।",
    feelings:  "भावना-चक्र कार्ड, शांत होने की रणनीतियाँ, बड़ी भावनाओं की कहानियाँ और 'नाम लो, काबू पाओ' जर्नलिंग — हर हफ्ते SEL।",
    manners:   "मूल्य-आधारित लघु कहानियाँ, खाने-पीने के शिष्टाचार अभ्यास, दोस्ती के संवाद — आपके परिवार की सांस्कृतिक शैली में।",
  },
};

const es: SubjectCopy = {
  labels: {
    phonics:   "Inglés & Fonética",
    reading:   "Comprensión lectora",
    math:      "Matemáticas",
    art:       "Arte & Creatividad",
    story:     "Actividades de cuentos",
    workbooks: "Cuadernos imprimibles",
    logic:     "Lógica & Pensamiento crítico",
    feelings:  "Sentimientos & Emociones",
    manners:   "Carácter & Modales",
  },
  descriptions: {
    phonics:   "Trazado de letras, historias decodificables, escaleras de mezcla y packs de palabras de vista para TK hasta 3.° grado.",
    reading:   "Pasajes nivelados A–Z con preguntas de inferencia, listas de vocabulario y narración de audio opcional.",
    math:      "Revisión espiral, modelos de barras de Singapur, ejercicios de fluidez y problemas de palabras en cuatro idiomas.",
    art:       "Proyectos de arte con pocos materiales, tradiciones culturales (Año Nuevo Lunar, Rangoli, Papel Picado), demos en timelapse.",
    story:     "Pack semanal de cuentos: una lectura en voz alta, más vocabulario, problema de matemáticas, manualidad de arte y diario — todo en un tema.",
    workbooks: "Cuadernos completos de 40–60 páginas por grado y trimestre. Descarga en casa o solicita la versión impresa.",
    logic:     "Puzzles de lógica visual, cuadrículas de patrones, acertijos y mini-lecciones de ajedrez — práctica de pensamiento estilo Beast Academy.",
    feelings:  "Tarjetas de rueda de emociones, estrategias para calmarse, historias de emociones grandes y diario 'nómbralo para domarlo' — SEL cada semana.",
    manners:   "Cuentos cortos basados en valores, práctica de modales en la mesa, guiones de amistad y desafíos de bondad diaria — al estilo cultural de tu familia.",
  },
};

export const subjectI18n: Record<Lang, SubjectCopy> = { en, zh, hi, es };
