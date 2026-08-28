-- ============================================================
--  Little Scholars Hub — Migration 014
--  Seeds AppConfig with rich "culture.<key>.detail" content used
--  by the landing page's culture-track popup modal (Chinese /
--  Indian / Hispanic programs). Run AFTER 07/08 migrations.
-- ============================================================

USE LittleScholarHub;
GO

MERGE dbo.AppConfig AS t
USING (VALUES
  (N'culture.zh.detail',
   N'{"units":[{"name":"拼音 Pinyin foundations","grade":"TK–K","text":"Initials, finals, and the four tones, with mouth-position diagrams and daily 5-minute audio drills."},{"name":"汉字 First 100 characters","grade":"K–2","text":"Numbers, family, body, nature, action verbs. Stroke-order tracing and a character a day."},{"name":"唐诗 Tang poetry starters","grade":"1–3","text":"Five classic poems kids recite, each with a read-aloud audio and meaning card."},{"name":"唐诗 Capstone (20 poems)","grade":"4–6","text":"Recite 20 poems by 6th grade — to grandparents on a video call."}],"festivals":[{"m":"Jan/Feb","name":"农历新年 Lunar New Year","doText":"Red envelopes, dumplings, zodiac craft"},{"m":"Feb","name":"元宵节 Lantern Festival","doText":"Make a paper lantern, eat tāngyuán"},{"m":"Jun","name":"端午 Dragon Boat","doText":"Eat zòngzi, fold a paper dragon boat"},{"m":"Sep","name":"中秋 Mid-Autumn","doText":"Mooncakes and the moon-goddess story"}],"phrases":[{"t":"你好","translit":"nǐ hǎo","eng":"Hello"},{"t":"谢谢","translit":"xiè xie","eng":"Thank you"},{"t":"我爱你","translit":"wǒ ài nǐ","eng":"I love you"},{"t":"新年快乐","translit":"xīn nián kuài lè","eng":"Happy New Year"}],"project":{"title":"Make a paper lantern for Lunar New Year","desc":"Classic, calming, takes 20 minutes. Hang it in a window.","steps":["Cut red paper into a 6×9 rectangle.","Fold in half, cut slits along the fold.","Unfold and curl into a cylinder, tape the seam.","Add a paper handle and write 福 (good fortune) on it."],"supplies":"Red paper · scissors · tape · gold marker"},"parentTip":"Read Pinyin aloud together — your voice matters more than perfect tones. Once a week, video-call grandparents and have your child recite one Tang poem."}',
   N'json', N'Chinese culture-track modal detail', N'culture'),

  (N'culture.in.detail',
   N'{"units":[{"name":"वर्णमाला Hindi alphabet","grade":"TK–K","text":"Vowels first, then consonants, traced top-to-bottom."},{"name":"Gita stories for kids","grade":"1–3","text":"Arjuna''s doubt, Krishna''s guidance, Hanuman''s strength — one gentle takeaway per story."},{"name":"Character building","grade":"1–6","text":"Steadiness, courage, kindness, doing your duty — one story plus one real-life challenge."},{"name":"Capstone journal","grade":"5–6","text":"Connect each Gita teaching to a moment from your own life, bound at year end."}],"festivals":[{"m":"Mar","name":"Holi","doText":"Color powder craft, Krishna-Radha story"},{"m":"Aug","name":"Raksha Bandhan","doText":"Make a thread bracelet, video-call cousins"},{"m":"Sep","name":"Ganesh Chaturthi","doText":"Clay Ganesha, obstacle-remover reflection"},{"m":"Nov","name":"Diwali","doText":"Rangoli and diya craft, Lakshmi story"}],"phrases":[{"t":"नमस्ते","translit":"namaste","eng":"Hello / I bow to you"},{"t":"धन्यवाद","translit":"dhanyavād","eng":"Thank you"},{"t":"मुझे भूख लगी है","translit":"mujhe bhūkh lagī hai","eng":"I''m hungry"},{"t":"शुभ दीपावली","translit":"shubh dīpāvalī","eng":"Happy Diwali"}],"project":{"title":"Diwali rangoli on a paper plate","desc":"A kid-friendly rangoli that keeps the symmetry without the floor-mess.","steps":["Mark the center of a paper plate.","Draw 8 light pencil lines for equal slices.","Place colored dot stickers along each line, same pattern per slice.","Add a flower motif in the center and display it."],"supplies":"Paper plate · colored dot stickers or markers · pencil"},"parentTip":"Open Gita stories at bedtime, not as homework. Ask ''when did you feel like Arjuna today?'' and let your child find the lesson themselves."}',
   N'json', N'Indian culture-track modal detail', N'culture'),

  (N'culture.es.detail',
   N'{"units":[{"name":"Letras y sonidos","grade":"TK–K","text":"The 27-letter alphabet including ñ, and the five vowel sounds."},{"name":"Acentos & sílaba fuerte","grade":"K–1","text":"When a word needs an accent — mastered in about 6 weeks."},{"name":"Cuentos & folk tales","grade":"1–4","text":"Stories from 12 Spanish-speaking countries, one per month."},{"name":"Capstone portfolio","grade":"5–6","text":"A family tree, a retold folk tale, and an art piece honoring a maestro."}],"festivals":[{"m":"Jan 6","name":"Día de los Reyes Magos","doText":"Leave grass for the camels, Rosca de Reyes bread"},{"m":"May 5","name":"Cinco de Mayo","doText":"Papel picado banner, battle of Puebla story"},{"m":"Sep 15","name":"Hispanic Heritage Month begins","doText":"21-country map, one leader per week"},{"m":"Nov 1–2","name":"Día de los Muertos","doText":"Build an ofrenda, pan de muerto, marigold path"}],"phrases":[{"t":"Hola","translit":"OH-lah","eng":"Hello"},{"t":"Gracias","translit":"GRAH-syas","eng":"Thank you"},{"t":"Tengo hambre","translit":"TENG-go AHM-breh","eng":"I''m hungry"},{"t":"Te quiero","translit":"teh kee-EH-roh","eng":"I love you"}],"project":{"title":"Build an ofrenda for Día de los Muertos","desc":"A small altar honoring someone your family loved — joyful, not sad.","steps":["Cover a small shelf with a colorful cloth.","Add one photo and say the person''s name together.","Place a glass of water and a little bread.","Add marigolds and light one candle on Nov 1."],"supplies":"Cloth · 1 photo · marigolds (paper or real) · 1 candle"},"parentTip":"Don''t ''teach'' culture — live it. Bake the food, sing the song, video-call abuela. Culture sticks when it tastes, smells, and sounds like something."}',
   N'json', N'Hispanic culture-track modal detail', N'culture')
) AS s(config_key, config_value, config_type, label, section)
ON t.config_key = s.config_key
WHEN MATCHED THEN
    UPDATE SET config_value=s.config_value, config_type=s.config_type,
               label=s.label, section=s.section, updated_at=SYSUTCDATETIME()
WHEN NOT MATCHED THEN
    INSERT (config_key, config_value, config_type, label, section)
    VALUES (s.config_key, s.config_value, s.config_type, s.label, s.section);
PRINT 'culture detail AppConfig seeded';
GO
