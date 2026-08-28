-- 71_cultural_wisdom.sql
-- Daily-wisdom pools for the three cultural tracks.
--
-- Chinese (language_id 2) and Spanish (language_id 4) each held only 2 rows,
-- so those families saw the same line every other day; Hindi (language_id 3)
-- had none of its own and fell back to the English-stored Gita rows.
--
-- Sources are classical and public domain: the Daodejing, Zhuangzi, Analects,
-- Xunzi and Mencius; the Bhagavad Gita, the Upanishads and Sanskrit
-- subhashitas; and Cervantes, Machado, Juarez, Marti, Sor Juana and
-- traditional refranes.
--
-- IMPORTANT: every text_english line is OUR OWN plain-language gloss, written
-- for parents of TK-6 children. No modern copyrighted translation is
-- reproduced anywhere in this file.

SET NOCOUNT ON;

-- --------------------------------------------------------------------
-- Chinese - Daoist, Confucian and classical  (18 entries)
-- --------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'千里之行，始于足下')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'千里之行，始于足下', N'A thousand-mile journey starts under your own foot - today''s small page counts.', N'老子 Laozi - 道德经 64');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'合抱之木，生于毫末')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'合抱之木，生于毫末', N'The tree you cannot get your arms around began as a sprout.', N'老子 Laozi - 道德经 64');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'慎终如始，则无败事')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'慎终如始，则无败事', N'Finish as carefully as you began and little goes wrong.', N'老子 Laozi - 道德经 64');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'天下难事，必作于易')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'天下难事，必作于易', N'Every hard thing in the world began as an easy one.', N'老子 Laozi - 道德经 63');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'上善若水')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'上善若水', N'The best way to be is like water - soft, patient, and it still shapes stone.', N'老子 Laozi - 道德经 8');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'知人者智，自知者明')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'知人者智，自知者明', N'Understanding others is clever. Understanding yourself is clear.', N'老子 Laozi - 道德经 33');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'知足者富')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'知足者富', N'The one who knows what is enough is already rich.', N'老子 Laozi - 道德经 33');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'大器晚成')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'大器晚成', N'The greatest vessels are the slowest to finish. So are some children.', N'老子 Laozi - 道德经 41');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'柔弱胜刚强')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'柔弱胜刚强', N'Gentleness outlasts force.', N'老子 Laozi - 道德经 36');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'吾生也有涯，而知也无涯')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'吾生也有涯，而知也无涯', N'Life has an edge; knowing does not. Learn what you love, and learn it well.', N'庄子 Zhuangzi - 养生主');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'学而时习之，不亦说乎')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'学而时习之，不亦说乎', N'To learn something and keep practising it - is that not a pleasure?', N'孔子 Confucius - 论语 1.1');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'温故而知新')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'温故而知新', N'Go back over the old and you will find something new in it.', N'孔子 Confucius - 论语 2.11');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'三人行，必有我师焉')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'三人行，必有我师焉', N'Walk with two others and one of them has something to teach you.', N'孔子 Confucius - 论语 7.22');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'知之为知之，不知为不知，是知也')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'知之为知之，不知为不知，是知也', N'To know what you know, and to know what you don''t - that is knowing.', N'孔子 Confucius - 论语 2.17');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'学而不思则罔，思而不学则殆')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'学而不思则罔，思而不学则殆', N'Learning without thinking leaves you lost; thinking without learning leaves you shaky.', N'孔子 Confucius - 论语 2.15');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'不积跬步，无以至千里')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'不积跬步，无以至千里', N'Without piling up half-steps there is no arriving anywhere far.', N'荀子 Xunzi - 劝学');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'青，取之于蓝，而青于蓝')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'青，取之于蓝，而青于蓝', N'Blue is drawn from the indigo plant and comes out bluer. Children pass their teachers.', N'荀子 Xunzi - 劝学');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=2 AND source_track='chinese' AND text_original=N'不以规矩，不能成方圆')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (2, 'chinese', N'不以规矩，不能成方圆', N'Without the compass and the square you cannot draw a true circle. Practice needs its tools.', N'孟子 Mencius - 离娄上');

-- --------------------------------------------------------------------
-- Hindi - Bhagavad Gita, Upanishads, subhashitas  (17 entries)
-- --------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'कर्मण्येवाधिकारस्ते मा फलेषु कदाचन', N'Your part is the work itself; the result is not yours to hold.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 2.47');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'योगः कर्मसु कौशलम्')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'योगः कर्मसु कौशलम्', N'Doing your work well, with a steady mind, is itself the practice.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 2.50');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'समत्वं योग उच्यते')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'समत्वं योग उच्यते', N'An even mind - in a good week and a bad one - is what steadiness means.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 2.48');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'उद्धरेदात्मनात्मानं नात्मानमवसादयेत्')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'उद्धरेदात्मनात्मानं नात्मानमवसादयेत्', N'Lift yourself up by yourself; do not be the one who pulls yourself down.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 6.5');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'अभ्यासेन तु कौन्तेय वैराग्येण च गृह्यते')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'अभ्यासेन तु कौन्तेय वैराग्येण च गृह्यते', N'It is held by practice and by letting go - not by wanting it badly.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 6.35');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'न हि ज्ञानेन सदृशं पवित्रमिह विद्यते')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'न हि ज्ञानेन सदृशं पवित्रमिह विद्यते', N'Nothing in this world cleans a person the way understanding does.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 4.38');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'श्रद्धावाँल्लभते ज्ञानम्')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'श्रद्धावाँल्लभते ज्ञानम्', N'The one who trusts the work is the one who ends up understanding it.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 4.39');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'यद्यदाचरति श्रेष्ठस्तत्तदेवेतरो जनः')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'यद्यदाचरति श्रेष्ठस्तत्तदेवेतरो जनः', N'Whatever the respected one does, everyone else quietly copies. Children most of all.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 3.21');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'श्रेयान्स्वधर्मो विगुणः परधर्मात्स्वनुष्ठितात्')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'श्रेयान्स्वधर्मो विगुणः परधर्मात्स्वनुष्ठितात्', N'Your own work done imperfectly beats someone else''s done well.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 3.35');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'न कर्मणामनारम्भान्नैष्कर्म्यं पुरुषोऽश्नुते')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'न कर्मणामनारम्भान्नैष्कर्म्यं पुरुषोऽश्नुते', N'Skipping the work is not the same as being free of it.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 3.4');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'सर्वं ज्ञानप्लवेनैव वृजिनं संतरिष्यसि')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'सर्वं ज्ञानप्लवेनैव वृजिनं संतरिष्यसि', N'Understanding is the raft; you can cross rough water on it.', N'श्रीमद्भगवद्गीता - Bhagavad Gita 4.36');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'उत्तिष्ठत जाग्रत प्राप्य वरान्निबोधत')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'उत्तिष्ठत जाग्रत प्राप्य वरान्निबोधत', N'Get up, stay awake, and keep learning from those who know.', N'कठोपनिषद् - Katha Upanishad 1.3.14');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'सत्यमेव जयते')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'सत्यमेव जयते', N'In the end it is the truth that wins.', N'मुण्डकोपनिषद् - Mundaka Upanishad 3.1.6');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'विद्या ददाति विनयम्')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'विद्या ददाति विनयम्', N'Real learning makes a person humbler, not louder.', N'सुभाषित - Sanskrit Subhashita');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'उद्यमेन हि सिध्यन्ति कार्याणि न मनोरथैः')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'उद्यमेन हि सिध्यन्ति कार्याणि न मनोरथैः', N'Things get done by effort, not by wishing for them.', N'सुभाषित - Sanskrit Subhashita');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'अल्पविद्या भयङ्करी')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'अल्पविद्या भयङ्करी', N'A little learning, held too confidently, is the risky kind.', N'सुभाषित - Sanskrit Subhashita');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=3 AND source_track='gita' AND text_original=N'काकचेष्टा बकोध्यानं श्वाननिद्रा तथैव च')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (3, 'gita', N'काकचेष्टा बकोध्यानं श्वाननिद्रा तथैव च', N'Work like the crow, focus like the heron, sleep light like the dog - the old list of a student''s habits.', N'सुभाषित - Sanskrit Subhashita');

-- --------------------------------------------------------------------
-- Spanish - Golden Age, Latin American, refranes  (17 entries)
-- --------------------------------------------------------------------

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Caminante, no hay camino, se hace camino al andar.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Caminante, no hay camino, se hace camino al andar.', N'There is no path waiting for you; you make it by walking.', N'Antonio Machado - Proverbios y cantares');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'El respeto al derecho ajeno es la paz.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'El respeto al derecho ajeno es la paz.', N'Respecting what belongs to someone else is what peace actually is.', N'Benito Juárez');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Ser culto es el único modo de ser libre.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Ser culto es el único modo de ser libre.', N'Learning is the one thing that makes a person free.', N'José Martí');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Yo no estudio para saber más, sino para ignorar menos.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Yo no estudio para saber más, sino para ignorar menos.', N'I do not study to know more, but to not-know less.', N'Sor Juana Inés de la Cruz');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Cada uno es hijo de sus obras.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Cada uno es hijo de sus obras.', N'Each of us is the child of what we do.', N'Miguel de Cervantes - Don Quijote');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'La diligencia es madre de la buena ventura.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'La diligencia es madre de la buena ventura.', N'Steady effort is the mother of good luck.', N'Miguel de Cervantes - Don Quijote');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'El que lee mucho y anda mucho, ve mucho y sabe mucho.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'El que lee mucho y anda mucho, ve mucho y sabe mucho.', N'Read a lot and go a lot of places, and you will see and know a lot.', N'Miguel de Cervantes - Don Quijote');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'No hay atajo sin trabajo.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'No hay atajo sin trabajo.', N'There is no shortcut that does not cost you the work anyway.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Poco a poco se anda lejos.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Poco a poco se anda lejos.', N'Little by little, you get a long way.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Gota a gota se llena la copa.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Gota a gota se llena la copa.', N'Drop by drop the cup fills.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Más vale maña que fuerza.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Más vale maña que fuerza.', N'Skill beats strength.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Quien mucho abarca, poco aprieta.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Quien mucho abarca, poco aprieta.', N'Grab at everything and you hold on to very little.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'No dejes para mañana lo que puedas hacer hoy.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'No dejes para mañana lo que puedas hacer hoy.', N'Do not leave for tomorrow what you could do today.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Al mal tiempo, buena cara.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Al mal tiempo, buena cara.', N'When the weather turns, meet it with a good face.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'A quien madruga, Dios le ayuda.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'A quien madruga, Dios le ayuda.', N'The early riser gets the help.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'Aprendiz de mucho, maestro de nada.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'Aprendiz de mucho, maestro de nada.', N'Apprentice to everything, master of nothing.', N'Refrán español');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=4 AND source_track='hispanic' AND text_original=N'La constancia vence lo que la dicha no alcanza.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (4, 'hispanic', N'La constancia vence lo que la dicha no alcanza.', N'Sticking with it reaches what luck never does.', N'Refrán español');

SELECT language_id, source_track, COUNT(*) AS n FROM dbo.DailyWisdom GROUP BY language_id, source_track ORDER BY language_id, source_track;
