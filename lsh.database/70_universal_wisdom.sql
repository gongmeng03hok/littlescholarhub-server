-- 70_universal_wisdom.sql
-- Original English 'Words for Today' entries for Little Scholars Hub.
--
-- Why: dbo.DailyWisdom held 30 rows on the 'gita' track for language_id 1
-- and only 2 on 'universal', and /content/wisdom/today defaulted every
-- caller to 'gita'. A family who chose English as their home language
-- opened their dashboard to Bhagavad Gita scripture as the first block on
-- the page. The Indian track stays exactly as it is -- it is one of the
-- three cultural tracks families choose on purpose -- but English now has
-- a pool of its own to default to.
--
-- All lines below are original to Little Scholars Hub: nothing is quoted,
-- adapted or translated from another author.

SET NOCOUNT ON;

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'A child who is allowed to be slow at something is a child who will still be doing it next year.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'A child who is allowed to be slow at something is a child who will still be doing it next year.', N'Patience now buys persistence later.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Ten quiet minutes at the same time each day will teach more than an hour you both dreaded.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Ten quiet minutes at the same time each day will teach more than an hour you both dreaded.', N'Small and regular beats big and rare.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'When a child says “I can''t”, they often mean “not yet, and I''m afraid you''ll mind”.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'When a child says “I can''t”, they often mean “not yet, and I''m afraid you''ll mind”.', N'Answer the fear, not the sentence.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Reading aloud to a child who can already read is not a step backwards. It is where the love of it is kept.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Reading aloud to a child who can already read is not a step backwards. It is where the love of it is kept.', N'Keep reading aloud.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'The question a child asks at bedtime is usually the one they were carrying all day.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'The question a child asks at bedtime is usually the one they were carrying all day.', N'Late questions deserve real answers.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Praise the choosing, not the cleverness — a child can repeat a choice.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Praise the choosing, not the cleverness — a child can repeat a choice.', N'Effort is something they can do again tomorrow.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'A mistake explained kindly is worth three problems answered correctly.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'A mistake explained kindly is worth three problems answered correctly.', N'Wrong answers are where the teaching lives.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Curiosity does not arrive on schedule. When it shows up, follow it, even if it is not today''s subject.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Curiosity does not arrive on schedule. When it shows up, follow it, even if it is not today''s subject.', N'Take the detour.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Children copy what we do with our own frustration far more than what we say about theirs.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Children copy what we do with our own frustration far more than what we say about theirs.', N'They are watching how you lose patience.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'It is not falling behind. It is arriving in their own order.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'It is not falling behind. It is arriving in their own order.', N'Every child has their own sequence.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'The child who is impossible at four o''clock is often just hungry, tired, or unheard.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'The child who is impossible at four o''clock is often just hungry, tired, or unheard.', N'Check the body before the behaviour.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Finishing something a little worse than you hoped still counts as finishing.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Finishing something a little worse than you hoped still counts as finishing.', N'Done teaches more than perfect.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'A hard word met three times becomes a known word. The first two times feel like failure.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'A hard word met three times becomes a known word. The first two times feel like failure.', N'Repetition is not regression.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Let them be bored for ten minutes before you fill it. The best ideas come out of that gap.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Let them be bored for ten minutes before you fill it. The best ideas come out of that gap.', N'Boredom is where invention starts.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Say the thing you noticed, not the thing you wanted: “you kept going after it got hard”.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Say the thing you noticed, not the thing you wanted: “you kept going after it got hard”.', N'Name what actually happened.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Two short sessions beat one long one, and both beat the one you skipped.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Two short sessions beat one long one, and both beat the one you skipped.', N'Show up more often than you go long.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'When you don''t know, say so, and look it up together. That is the whole lesson.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'When you don''t know, say so, and look it up together. That is the whole lesson.', N'Not knowing is allowed.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Handwriting improves when a hand grows strong, not when a child is told to try harder.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Handwriting improves when a hand grows strong, not when a child is told to try harder.', N'Build the hand, not the willpower.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'The subject they avoid is usually the one where they once felt foolish.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'The subject they avoid is usually the one where they once felt foolish.', N'Avoidance is old embarrassment.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Keeping your home language is not extra work for a child. It is the same love in another key.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Keeping your home language is not extra work for a child. It is the same love in another key.', N'Your language is a gift, not a burden.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Read the story again. The fourth time is when they start noticing the words.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Read the story again. The fourth time is when they start noticing the words.', N'Repetition is how a story is learned.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Counting on fingers is not cheating. It is a child using the tools they have.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Counting on fingers is not cheating. It is a child using the tools they have.', N'Let them use their hands.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Ask “how did you work it out?” more often than “is that right?”')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Ask “how did you work it out?” more often than “is that right?”', N'The method matters more than the answer.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Some days the plan is one page, kindly done, and a walk outside.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Some days the plan is one page, kindly done, and a walk outside.', N'A small day is still a day.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'The child who tidies without being asked has usually been noticed for it before.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'The child who tidies without being asked has usually been noticed for it before.', N'Notice it out loud.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'A rule they helped make is a rule they will argue for.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'A rule they helped make is a rule they will argue for.', N'Let them write one of the rules.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Comparing your child to another family''s child costs you both something and teaches neither.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Comparing your child to another family''s child costs you both something and teaches neither.', N'Measure against last month, not next door.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'Manners are not performance. They are how a child tells a stranger that they are safe.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'Manners are not performance. They are how a child tells a stranger that they are safe.', N'Politeness is a kindness they can give away.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'If you only have five minutes, spend them listening rather than teaching.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'If you only have five minutes, spend them listening rather than teaching.', N'Listening is instruction too.', N'Little Scholars Hub');

IF NOT EXISTS (SELECT 1 FROM dbo.DailyWisdom WHERE language_id=1 AND source_track='universal' AND text_original=N'The goal is not a child who finishes the worksheet. It is a child willing to start the next one.')
  INSERT INTO dbo.DailyWisdom (language_id, source_track, text_original, text_english, author)
  VALUES (1, 'universal', N'The goal is not a child who finishes the worksheet. It is a child willing to start the next one.', N'Protect the willingness.', N'Little Scholars Hub');

SELECT source_track, COUNT(*) AS n FROM dbo.DailyWisdom WHERE language_id=1 GROUP BY source_track;
