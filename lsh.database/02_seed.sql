-- ============================================================
--  Little Scholars Hub  —  Seed Data
--  Run AFTER 01_schema.sql
-- ============================================================

USE LittleScholarHub;
GO

-- Languages
INSERT INTO dbo.Languages VALUES
(1,'en',   N'English'),
(2,'zh',   N'中文'),
(3,'hi',   N'हिन्दी'),
(4,'es',   N'Español');

-- Grades
INSERT INTO dbo.Grades VALUES
(0,N'TK',0),(1,N'K',1),(2,N'1st',2),(3,N'2nd',3),
(4,N'3rd',4),(5,N'4th',5),(6,N'5th',6),(7,N'6th',7);

-- Difficulty
INSERT INTO dbo.DifficultyLevels VALUES (1,'easy'),(2,'medium'),(3,'hard');

-- Subjects
INSERT INTO dbo.Subjects VALUES
(1,'phonics',   N'English & Phonics',        N'📖',0),
(2,'reading',   N'Reading Comprehension',    N'📚',0),
(3,'math',      N'Math',                     N'🧮',0),
(4,'art',       N'Art & Creativity',         N'🎨',0),
(5,'story',     N'Story Activities',         N'🐉',0),
(6,'workbooks', N'Printable Workbooks',      N'📕',0),
(7,'logic',     N'Logic & Critical Thinking',N'🧩',0),
(8,'feelings',  N'Feelings & Emotions',      N'💛',0),
(9,'manners',   N'Character & Manners',      N'🌱',0),
(10,'pinyin',   N'Pinyin',                   N'🏮',1),
(11,'hanzi',    N'汉字 Hanzi',               N'🏮',1),
(12,'tangshi',  N'唐诗 Tang Poems',          N'🏮',1),
(13,'gita',     N'Gita Stories',             N'🪔',1),
(14,'letras',   N'Letras',                   N'🌻',1),
(15,'fiestas',  N'Fiestas',                  N'🌻',1),
(16,'maestros', N'Maestros',                 N'🌻',1);

-- Question Templates
INSERT INTO dbo.QuestionTemplates
    (subject_id,grade_id,difficulty_id,template_type,template_text,params_json,answer_expr)
VALUES
(3,2,1,'algorithmic',N'What is {A} + {B}?',
 '{"A":{"min":1,"max":10},"B":{"min":1,"max":10}}','{A}+{B}'),
(3,3,2,'algorithmic',N'What is {A} - {B}?',
 '{"A":{"min":10,"max":20},"B":{"min":1,"max":9}}','{A}-{B}'),
(3,4,2,'algorithmic',N'What is {A} × {B}?',
 '{"A":{"min":2,"max":10},"B":{"min":2,"max":10}}','{A}*{B}'),
(3,5,2,'algorithmic',N'What is {A} ÷ {B}?',
 '{"A":{"min":4,"max":81},"B":{"min":2,"max":9}}','{A}/{B}'),
(1,2,1,'fill_blank', N'Fill in the missing letter: c_t','{}','a'),
(1,3,1,'fill_blank', N'Fill in the missing letters: tr__n','{}','ai'),
(7,3,2,'algorithmic',N'What comes next? {A}, {A+2}, {A+4}, {A+6}, ___',
 '{"A":{"min":1,"max":5}}','{A}+8'),
(2,3,2,'mcq',        N'What is the main idea of a paragraph?',
 '{"options":["The first sentence","The central topic","A random detail","The last word"]}',
 'The central topic'),
(10,2,1,'mcq',N'What tone is māo (cat)?',
 '{"options":["1st tone","2nd tone","3rd tone","4th tone"]}','1st tone'),
(13,3,2,'mcq',N'In the Gita, what does it mean to do your duty?',
 '{"options":["Do it for reward","Do it without attachment","Avoid hard tasks","Ask others first"]}',
 'Do it without attachment');

-- Stories
INSERT INTO dbo.Stories
    (grade_id,language_id,title,body_text,read_min,theme_tag,vocab_json)
VALUES
(2,1,N'Kai and the Dragon',
N'Once in a valley ringed by mountains lived a boy named Kai. Every morning he watched a silver dragon glide over the peaks. One day the dragon landed beside him. "I have flown ten thousand miles," said the dragon, "but never found a child so curious." Kai smiled. "Where do you go?" "Everywhere learning begins," the dragon answered. From that day, Kai read one page before sunrise — and the dragon always circled to check.',
5,N'chinese_culture',
N'[{"word":"curious","definition":"eager to learn or know things"},{"word":"valley","definition":"low land between hills"}]'),

(3,1,N'Arjuna Asks Why',
N'Before a great test, Arjuna put down his pencil. "What if I fail?" he asked. His teacher smiled. "You already know the answer. Your job is not to win — your job is to try with your whole heart. The effort is yours. The result belongs to the universe." Arjuna picked up his pencil and began.',
5,N'gita',
N'[{"word":"effort","definition":"trying hard to do something"},{"word":"result","definition":"what happens because of an action"}]'),

(2,4,N'La Tortuga y el Conejo',
N'Había una vez una tortuga y un conejo. El conejo siempre corría muy rápido y se burlaba de la tortuga. Un día hicieron una carrera. El conejo se durmió en el camino. La tortuga siguió caminando despacio pero sin parar. ¡La tortuga llegó primero! El conejo aprendió que la constancia es más importante que la velocidad.',
5,N'hispanic',
N'[{"word":"tortuga","definition":"turtle"},{"word":"conejo","definition":"rabbit"},{"word":"constancia","definition":"persistence"}]');

-- Daily Wisdom
INSERT INTO dbo.DailyWisdom
    (language_id,source_track,text_original,text_english,author)
VALUES
(1,'gita',
 N'You have the right to perform your actions, but not to the fruits of your actions.',
 NULL,N'Bhagavad Gita 2.47'),
(1,'gita',
 N'The soul is neither born nor dies at any time.',
 NULL,N'Bhagavad Gita 2.20'),
(2,'chinese',
 N'学而时习之，不亦说乎',
 N'Is it not pleasant to learn with constant perseverance?',
 N'Confucius — Analects 1.1'),
(2,'chinese',
 N'己所不欲，勿施于人',
 N'Do not impose on others what you do not want done to yourself.',
 N'Confucius — Analects 15.24'),
(4,'hispanic',
 N'Dime con quién andas y te diré quién eres.',
 N'Tell me who you walk with and I will tell you who you are.',
 N'Spanish Proverb'),
(4,'hispanic',
 N'Camarón que se duerme, se lo lleva la corriente.',
 N'The shrimp that falls asleep is carried away by the current.',
 N'Spanish Proverb'),
(1,'universal',
 N'Every expert was once a beginner.',
 NULL,N'Unknown'),
(1,'universal',
 N'Mistakes are proof that you are trying.',
 NULL,N'Unknown');

-- Sample Worksheets
INSERT INTO dbo.Worksheets
    (subject_id,grade_id,language_id,difficulty_id,title,description,estimated_min,teacher_name)
VALUES
(3,2,1,1,N'Addition Hop 1–10',
 N'Practice single-digit addition with number line support.',10,N'Mrs. Patel'),
(3,3,1,2,N'Two-Digit Subtraction',
 N'Subtract two-digit numbers without borrowing.',15,N'Mr. Chen'),
(1,2,1,1,N'Short Vowel Sounds',
 N'Identify CVC words with short a, e, i, o, u.',10,N'Ms. Rivera'),
(7,4,1,2,N'Pattern Power — Level 3',
 N'Identify and extend number and shape patterns.',20,N'Mrs. Kim'),
(10,2,2,1,N'声调练习 Tone Practice',
 N'Match Pinyin syllables to the correct tone mark.',15,N'老师 Wang'),
(13,3,3,2,N'Gita Values Coloring Book',
 N'Color scenes illustrating courage, kindness, and duty.',25,N'Priya Auntie'),
(14,2,4,1,N'Mis Primeras Palabras',
 N'Match Spanish words to pictures for common objects.',10,N'Sra. Gomez');
GO
