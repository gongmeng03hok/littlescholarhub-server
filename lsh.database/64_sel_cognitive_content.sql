-- 64_sel_cognitive_content.sql
-- Whole-Child Curriculum expansion, part 2: content for the 'sel' (Social-
-- Emotional Learning) and 'cognitive_skills' subject_area groups, hand-
-- crafted across all 8 grades (TK-6th) from the curriculum matrix the site
-- owner provided. Schema/rotation logic added in 63_whole_child_rotation.sql
-- must run first. 'Emotional Regulation' is flagged is_core=1 at every grade
-- (mastery-anchor category, appears every week — see 63's proc comments) with
-- a deliberately larger question pool than the other categories so weekly
-- NEWID() sampling still varies meaningfully.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'sel')
BEGIN
    DECLARE @cat_emoreg_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'sel', N'Emotional Regulation', 'short_answer', 10, NULL, 1);
    SET @cat_emoreg_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Happy', 1, N'emoji', N'{"emoji": "😊"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Sad', 2, N'emoji', N'{"emoji": "😢"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Angry', 3, N'emoji', N'{"emoji": "😠"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Scared', 4, N'emoji', N'{"emoji": "😨"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Surprised', 5, N'emoji', N'{"emoji": "😮"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Tired', 6, N'emoji', N'{"emoji": "😴"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'fill_blank', N'What feeling is this?', NULL, N'Calm', 7, N'emoji', N'{"emoji": "😌"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'multiple_choice', N'If you feel angry, what is a safe first step?', N'["Take a slow breath", "Yell loudly", "Throw a toy"]', N'Take a slow breath', 8);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'multiple_choice', N'When you feel sad, what can help?', N'["Tell a grown-up I trust", "Keep it a secret", "Hide and don''t tell anyone"]', N'Tell a grown-up I trust', 9);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'multiple_choice', N'You are having a hard day. What is a kind thing to say to yourself?', N'["I can try again", "I am bad at everything", "I should give up"]', N'I can try again', 10);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'short_response', N'Draw or tell a grown-up: what makes YOU feel happy?', NULL, N'Answers will vary.', 11);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'short_response', N'Draw or tell a grown-up: what makes YOU feel mad?', NULL, N'Answers will vary.', 12);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_0, N'short_response', N'Practice slow breathing. Put the steps in order.', NULL, N'In, hold, out.', 13, N'sequence_steps', N'{"steps": ["Breathe in slowly through your nose", "Hold it for 1 second", "Breathe out slowly through your mouth"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'matching', N'Match the feeling word to the matching face.', N'{"left": ["Happy", "Sad", "Angry", "Scared"], "right": ["😊", "😢", "😠", "😨"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 14);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_0, N'multiple_choice', N'What can you do when you feel too excited to sit still?', N'["Take slow breaths and count to 5", "Run around the room", "Yell"]', N'Take slow breaths and count to 5', 15);

    DECLARE @cat_emoreg_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'sel', N'Emotional Regulation', 'short_answer', 8, N'A feelings check-in: circle how you feel right now, then practice a calm-down step.', 1);
    SET @cat_emoreg_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_1, N'fill_blank', N'Check in: what feeling is this?', NULL, N'Frustrated', 1, N'emoji', N'{"emoji": "😖"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_1, N'fill_blank', N'Check in: what feeling is this?', NULL, N'Excited', 2, N'emoji', N'{"emoji": "🤩"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_1, N'fill_blank', N'Check in: what feeling is this?', NULL, N'Worried', 3, N'emoji', N'{"emoji": "😟"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'multiple_choice', N'You feel frustrated because your tower fell down. What should you do first?', N'["Stop and take 3 slow breaths", "Kick the blocks", "Cry and give up"]', N'Stop and take 3 slow breaths', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'multiple_choice', N'A friend takes your crayon without asking. How do you feel?', N'["Frustrated or upset", "Happy", "Sleepy"]', N'Frustrated or upset', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_1, N'short_response', N'Simple calm-down steps: put them in order.', NULL, N'Notice, breathe, ask for help.', 6, N'sequence_steps', N'{"steps": ["Notice how your body feels", "Take 3 slow breaths", "Ask for help if you still need it"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'short_response', N'What is one thing that helps YOU calm down when you''re upset?', NULL, N'Answers will vary (e.g., breathing, a hug, a quiet corner).', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'multiple_choice', N'Which is a calm-down tool?', N'["Counting to 10 slowly", "Throwing your toys", "Yelling at a friend"]', N'Counting to 10 slowly', 8);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'matching', N'Match the situation to how it might feel.', N'{"left": ["Your ice cream falls on the ground", "You get a new puppy", "You can''t find your favorite toy"], "right": ["Sad", "Happy", "Worried"]}', N'[[0, 0], [1, 1], [2, 2]]', 9);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'multiple_choice', N'Why is it okay to feel angry sometimes?', N'["All feelings are okay — it''s what we DO with them that matters", "Angry feelings are bad and should be hidden", "Only some people are allowed to feel angry"]', N'All feelings are okay — it''s what we DO with them that matters', 10);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'short_response', N'Draw a calm-down wheel: name 3 things that help you feel better.', NULL, N'Answers will vary.', 11);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_1, N'fill_blank', N'Check in: what feeling is this?', NULL, N'Proud', 12, N'emoji', N'{"emoji": "😊"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_1, N'multiple_choice', N'You made a mistake on your worksheet. What''s a helpful thought?', N'["Mistakes help me learn", "I always mess everything up", "I should quit trying"]', N'Mistakes help me learn', 13);

    DECLARE @cat_emoreg_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'sel', N'Emotional Regulation', 'short_answer', 7, N'Learn to notice what triggers big feelings, and practice the ''stop-breathe-choose'' strategy.', 1);
    SET @cat_emoreg_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'short_response', N'A trigger is something that causes a big feeling. Write one thing that is a trigger for YOU.', NULL, N'Answers will vary (e.g., losing a game, being interrupted).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'multiple_choice', N'What is the FIRST step in ''stop-breathe-choose''?', N'["Stop what you''re doing", "Choose what to do next", "Take a breath"]', N'Stop what you''re doing', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'multiple_choice', N'What is the SECOND step in ''stop-breathe-choose''?', N'["Breathe slowly", "Stop", "Choose"]', N'Breathe slowly', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_2, N'short_response', N'Put the ''stop-breathe-choose'' strategy steps in order.', NULL, N'Stop, breathe, choose.', 4, N'sequence_steps', N'{"steps": ["Stop what you''re doing", "Breathe slowly, in and out", "Choose a helpful next step"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'short_response', N'Your friend loses at a game and gets very upset. What could they try?', NULL, N'Try the stop-breathe-choose strategy, or take a break.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'multiple_choice', N'Which of these is a TRIGGER, not a feeling?', N'["Someone cutting in line", "Angry", "Calm"]', N'Someone cutting in line', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'matching', N'Match the trigger to a helpful response.', N'{"left": ["Losing a game", "Being teased", "Making a mistake"], "right": ["Remind yourself it''s okay to lose sometimes", "Walk away and tell a trusted adult", "Remember mistakes help you learn"]}', N'[[0, 0], [1, 1], [2, 2]]', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'short_response', N'Write about a time you felt a big feeling. What was the trigger?', NULL, N'Answers will vary.', 8);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'multiple_choice', N'Why is it helpful to know your own triggers?', N'["You can plan ahead for what might upset you", "So you can avoid ever feeling upset", "Triggers aren''t important to know"]', N'You can plan ahead for what might upset you', 9);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'fill_blank', N'Fill in the blank: When I feel a big feeling coming, I can stop, ______, then choose.', NULL, N'breathe', 10);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_2, N'short_response', N'Make your own ''stop-breathe-choose'' card for a trigger you picked above.', NULL, N'Answers will vary.', 11);

    DECLARE @cat_emoreg_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'sel', N'Emotional Regulation', 'short_answer', 6, N'Keep an emotion journal entry, then match tricky situations to good coping strategies.', 1);
    SET @cat_emoreg_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'short_response', N'Emotion journal: What is a feeling you had today or yesterday, and what caused it?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'matching', N'Match each situation to a good coping strategy.', N'{"left": ["You''re nervous about a test", "You''re angry at your sibling", "You''re sad about a rainy day"], "right": ["Take slow breaths and review what you know", "Take space and talk it out calmly later", "Think of an indoor activity you enjoy"]}', N'[[0, 0], [1, 1], [2, 2]]', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'multiple_choice', N'Which strategy would NOT help you calm down?', N'["Yelling until you feel better", "Deep breathing", "Counting slowly to 10"]', N'Yelling until you feel better', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'short_response', N'Write about a strategy that has helped YOU feel calmer in the past.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'multiple_choice', N'What''s a healthy way to handle frustration during homework?', N'["Take a short break and come back to it", "Rip up the paper", "Give up completely"]', N'Take a short break and come back to it', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'fill_blank', N'An ______ journal helps you notice patterns in your feelings over time.', NULL, N'emotion', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'short_response', N'Why might writing down your feelings help you understand them better?', NULL, N'It helps you notice patterns and think through what caused the feeling.', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'matching', N'Match the feeling to a strategy that could help.', N'{"left": ["Overwhelmed by a big project", "Jealous of a friend''s new toy", "Embarrassed after a mistake"], "right": ["Break it into smaller steps", "Remind yourself of things you''re grateful for", "Remember everyone makes mistakes"]}', N'[[0, 0], [1, 1], [2, 2]]', 8);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_3, N'short_response', N'What situation this week caused a strong feeling for you, and how did you handle it?', NULL, N'Answers will vary.', 9);

    DECLARE @cat_emoreg_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'sel', N'Emotional Regulation', 'short_answer', 6, N'Rate how strong a feeling is on a scale of 1-10, then match the intensity to a fitting strategy.', 1);
    SET @cat_emoreg_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'short_response', N'On a scale of 1-10, how strong does frustration feel when you lose a game you really wanted to win? Explain your number.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'multiple_choice', N'For a LOW-intensity frustration (2-3 out of 10), what''s a good strategy?', N'["Take a breath and keep going", "Leave the room immediately", "Give up on the activity"]', N'Take a breath and keep going', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'multiple_choice', N'For a HIGH-intensity frustration (8-10 out of 10), what''s a good strategy?', N'["Step away, calm down fully, then return", "Push through no matter what", "Ignore it completely"]', N'Step away, calm down fully, then return', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'matching', N'Match the frustration level to the best-fitting strategy.', N'{"left": ["Level 2: a small mistake on homework", "Level 5: losing a close game", "Level 9: something breaks that you worked hard on"], "right": ["Take one slow breath and keep working", "Talk it out with a friend or take a short break", "Step away completely, breathe, and revisit it later"]}', N'[[0, 0], [1, 1], [2, 2]]', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'short_response', N'Describe a time your frustration scale was high (8+). What strategy did you use, or what could you try next time?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'fill_blank', N'A frustration ______ helps you notice HOW big a feeling is, not just that you have it.', NULL, N'scale', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'short_response', N'Why might the same event (like losing a game) feel like a 3 for one person and a 9 for another?', NULL, N'People experience and react to the same events differently — that''s normal.', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_4, N'multiple_choice', N'What''s the benefit of rating your frustration before reacting?', N'["It helps you choose a strategy that matches how big the feeling really is", "It makes the feeling disappear instantly", "It''s not actually useful"]', N'It helps you choose a strategy that matches how big the feeling really is', 8);

    DECLARE @cat_emoreg_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'sel', N'Emotional Regulation', 'space_heavy', 6, N'Reflect on a hard moment you''ve had recently, then write about what actually helped.', 1);
    SET @cat_emoreg_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'short_response', N'Describe a hard moment you had recently (at school, home, or with a friend).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'short_response', N'What feeling(s) did you have during that hard moment?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'short_response', N'What did you do in the moment? Looking back, did it help or not?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'short_response', N'What is ONE thing that actually helped you feel better afterward?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'multiple_choice', N'Reflecting on hard moments AFTER they happen mainly helps you...', N'["Learn what strategies work for next time", "Forget the moment completely", "Feel worse about it"]', N'Learn what strategies work for next time', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'short_response', N'If a similar hard moment happened again, what would you try differently?', NULL, N'Answers will vary.', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'multiple_choice', N'Which is a sign a reflection is helpful, not just dwelling on the past?', N'["It leads to an idea you can use next time", "It makes you replay the moment over and over with no new insight", "It only focuses on blame"]', N'It leads to an idea you can use next time', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_5, N'short_response', N'Write a short note to your future self for the next time you have a hard moment.', NULL, N'Answers will vary.', 8);

    DECLARE @cat_emoreg_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'sel', N'Emotional Regulation', 'short_answer', 6, N'Compare healthy and unhealthy ways of coping with the same tough feeling.', 1);
    SET @cat_emoreg_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'multiple_choice', N'Which pair correctly matches HEALTHY vs UNHEALTHY coping for anger?', N'["Healthy: going for a walk. Unhealthy: yelling at others.", "Healthy: yelling at others. Unhealthy: going for a walk.", "Both are equally healthy."]', N'Healthy: going for a walk. Unhealthy: yelling at others.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'matching', N'Sort each coping response as healthy or unhealthy.', N'{"left": ["Talking to a trusted friend about a problem", "Bottling up feelings until you explode", "Taking a break to cool down", "Blaming others for how you feel without reflecting"], "right": ["Healthy", "Unhealthy", "Healthy", "Unhealthy"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'short_response', N'Explain why ''venting online'' can sometimes be an unhealthy coping strategy.', NULL, N'It can escalate feelings, hurt others, or create problems that outlast the original feeling.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'short_response', N'Describe a healthy coping strategy you personally rely on, and why it works for you.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'multiple_choice', N'Which is true about unhealthy coping strategies?', N'["They might feel good briefly but don''t solve the real problem", "They always solve the problem permanently", "They have no downsides"]', N'They might feel good briefly but don''t solve the real problem', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'short_response', N'Why might the SAME strategy (like eating a snack) be healthy in one situation and unhealthy in another?', NULL, N'It depends on how often, why, and whether it''s used to avoid dealing with the actual feeling.', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'multiple_choice', N'A friend copes with stress by avoiding all their homework. Is this healthy?', N'["No — avoidance builds up more stress later", "Yes — avoiding stress is always good", "It doesn''t matter either way"]', N'No — avoidance builds up more stress later', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_6, N'short_response', N'Write one unhealthy habit you want to replace with a healthier one, and what you''ll try instead.', NULL, N'Answers will vary.', 8);

    DECLARE @cat_emoreg_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'sel', N'Emotional Regulation', 'space_heavy', 6, N'Design your own personal ''calm-down toolkit'' — a real plan you could actually use.', 1);
    SET @cat_emoreg_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'short_response', N'List 3 strategies for your personal calm-down toolkit, and why you picked each one.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_emoreg_7, N'short_response', N'Put a realistic calm-down plan in order for when you notice a big feeling starting.', NULL, N'Notice, use a strategy, check in, return or ask for help.', 2, N'sequence_steps', N'{"steps": ["Notice the early signs (racing heart, tight chest, etc.)", "Use your first go-to strategy (e.g., breathing)", "Check in: do you need a second strategy or more time?", "Return to what you were doing, or ask for help if still needed"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'short_response', N'What are the early warning signs YOUR body gives before a big feeling takes over?', NULL, N'Answers will vary (e.g., clenched fists, fast breathing, hot face).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'multiple_choice', N'A good calm-down toolkit should be...', N'["Personalized to what actually works for you", "The exact same as everyone else''s", "Used only after you''ve already lost control"]', N'Personalized to what actually works for you', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'short_response', N'Who is one trusted person you could go to if your toolkit strategies aren''t enough?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'multiple_choice', N'Why is it useful to practice your calm-down toolkit BEFORE you''re upset, not just during?', N'["Strategies work better when they''re already familiar under stress", "Practicing ahead of time is pointless", "It only matters once you''re already upset"]', N'Strategies work better when they''re already familiar under stress', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'short_response', N'How will you know if a strategy in your toolkit is actually working for you?', NULL, N'Answers will vary (e.g., feeling calmer within a few minutes, being able to think clearly again).', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_emoreg_7, N'short_response', N'Write your finished calm-down toolkit plan as a short list you could keep in your backpack or notebook.', NULL, N'Answers will vary.', 8);

    DECLARE @cat_empathy_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'sel', N'Empathy', 'short_answer', 5, NULL, 0);
    SET @cat_empathy_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'matching', N'Match the face to the feeling.', N'{"left": ["Happy", "Sad", "Angry", "Scared"], "right": ["😊", "😢", "😠", "😨"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'multiple_choice', N'Your friend is crying. How do they probably feel?', N'["Sad", "Happy", "Silly"]', N'Sad', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'multiple_choice', N'Your friend just won a game. How do they probably feel?', N'["Happy", "Sad", "Scared"]', N'Happy', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'short_response', N'If your friend feels sad, what could you do to help?', NULL, N'Answers will vary (e.g., give a hug, ask what''s wrong, share a toy).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_empathy_0, N'fill_blank', N'What feeling is this friend showing?', NULL, N'Scared', 5, N'emoji', N'{"emoji": "😨"}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'multiple_choice', N'A friend drops their ice cream. How might they feel?', N'["Sad", "Excited", "Proud"]', N'Sad', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'short_response', N'Draw a face showing how YOU think your best friend feels today.', NULL, N'Answers will vary.', 7);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_0, N'multiple_choice', N'Noticing how someone else feels is called...', N'["Empathy", "Counting", "Running"]', N'Empathy', 8);

    DECLARE @cat_empathy_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'sel', N'Empathy', 'space_heavy', 5, N'Look at the picture story, then think about how each character feels.', 0);
    SET @cat_empathy_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'short_response', N'A kid drops their lunch tray in the cafeteria and everyone looks. How would they feel?', NULL, N'Embarrassed or sad.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'short_response', N'What could you say to that kid to help them feel better?', NULL, N'Answers will vary (e.g., ''It''s okay, that happens to everyone!'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'multiple_choice', N'A new student doesn''t know anyone at recess. How might they feel?', N'["Lonely or nervous", "Excited", "Bored"]', N'Lonely or nervous', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'short_response', N'What could you do if you saw a new student sitting alone?', NULL, N'Answers will vary (e.g., invite them to play).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'matching', N'Match the story picture to the likely feeling.', N'{"left": ["A kid gets a surprise birthday party", "A kid''s pet is sick", "A kid can''t solve a hard puzzle"], "right": ["Happy and surprised", "Worried", "Frustrated"]}', N'[[0, 0], [1, 1], [2, 2]]', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'short_response', N'How would YOU feel if you were the new student with no one to sit with?', NULL, N'Answers will vary.', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_1, N'multiple_choice', N'Why is it important to think about how a picture-story character feels?', N'["It helps us understand and be kind to others", "It''s not important", "Only for fun, no real reason"]', N'It helps us understand and be kind to others', 7);

    DECLARE @cat_empathy_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'sel', N'Empathy', 'space_heavy', 5, N'Read the short story, then retell it from a DIFFERENT character''s point of view.', 0);
    SET @cat_empathy_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'short_response', N'Story: Mia borrows Jake''s pencil without asking and breaks it. Retell this from JAKE''s point of view — how does he feel and why?', NULL, N'Answers will vary (e.g., frustrated, since his pencil was taken without permission and broken).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'short_response', N'Now retell it from MIA''s point of view. What might she have been thinking?', NULL, N'Answers will vary (e.g., she was in a rush and didn''t mean to break it).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'multiple_choice', N'Perspective-taking means...', N'["Imagining a situation from someone else''s point of view", "Only thinking about your own feelings", "Guessing without any thought"]', N'Imagining a situation from someone else''s point of view', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'short_response', N'Why might Mia and Jake see the same event differently?', NULL, N'They each experienced it from their own point of view with different feelings and intentions.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'short_response', N'What could Mia say to Jake to make things better?', NULL, N'Answers will vary (e.g., ''I''m sorry, I should have asked first.'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'multiple_choice', N'Retelling a story from another character''s view mainly helps you...', N'["Understand feelings and reasons you might have missed", "Change what actually happened in the story", "Prove your own view is the only correct one"]', N'Understand feelings and reasons you might have missed', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_2, N'short_response', N'Think of a real disagreement you had. Retell it from the OTHER person''s point of view.', NULL, N'Answers will vary.', 7);

    DECLARE @cat_empathy_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'sel', N'Empathy', 'space_heavy', 4, N'Read the scenario, then write how each person in it probably feels.', 0);
    SET @cat_empathy_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_3, N'short_response', N'Scenario: Two friends are picked for different teams in gym class and won''t be playing together. Write how EACH friend might feel.', NULL, N'Answers will vary (e.g., disappointed, but maybe also excited to make new teammates).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_3, N'short_response', N'Scenario: A student studies hard but still gets a lower grade than a friend who didn''t study much. Write how the student feels, and how the friend might feel too.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_3, N'multiple_choice', N'Why might two people feel differently about the exact same event?', N'["Everyone brings their own experiences and expectations to a situation", "Only one person''s feelings are ever ''correct''", "People always feel the same about everything"]', N'Everyone brings their own experiences and expectations to a situation', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_3, N'short_response', N'Scenario: A sibling is upset because they have to share their new video game. Write how they might feel, and one thing that could help.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_3, N'short_response', N'Why is it useful to consider more than one person''s feelings in a scenario?', NULL, N'It helps you respond fairly and kindly to everyone involved, not just yourself.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_3, N'multiple_choice', N'What''s the best next step after writing how someone feels in a scenario?', N'["Think about how you could respond kindly", "Ignore it and move on", "Decide their feelings don''t matter"]', N'Think about how you could respond kindly', 6);

    DECLARE @cat_empathy_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'sel', N'Empathy', 'space_heavy', 4, N'Compare your own reaction to an event with how a friend reacted to the SAME event.', 0);
    SET @cat_empathy_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_4, N'short_response', N'Think of a time you and a friend both experienced the same event (a scary movie, a lost game, a surprise). Write how YOU reacted.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_4, N'short_response', N'Now write how your FRIEND reacted to that same event, as best you remember or can imagine.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_4, N'short_response', N'What might explain the difference between your reaction and theirs?', NULL, N'Different personalities, past experiences, or what each of you cares about most.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_4, N'multiple_choice', N'If your reaction and a friend''s reaction to the same event were very different, that means...', N'["Both reactions can be valid, just different", "One of you must be wrong", "You aren''t really friends"]', N'Both reactions can be valid, just different', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_4, N'short_response', N'How could understanding a friend''s different reaction change how you treat them next time?', NULL, N'Answers will vary (e.g., being more patient or supportive of their specific reaction).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_4, N'multiple_choice', N'Comparing reactions to the SAME event is a good way to practice...', N'["Empathy — understanding others don''t always feel what you feel", "Memorization", "Arguing about who''s right"]', N'Empathy — understanding others don''t always feel what you feel', 6);

    DECLARE @cat_empathy_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'sel', N'Empathy', 'space_heavy', 4, N'Analyze what really motivates a character''s actions in a story you''ve read.', 0);
    SET @cat_empathy_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_5, N'short_response', N'Pick a character from a book you''ve read. What did they WANT, and what did they DO to try to get it?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_5, N'short_response', N'Was the character''s motivation something like fear, love, pride, or fairness? Explain.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_5, N'multiple_choice', N'A character''s motivation is best described as...', N'["The reason behind their actions", "Only their physical appearance", "A random detail with no meaning"]', N'The reason behind their actions', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_5, N'short_response', N'Did the character''s motivation change by the end of the story? Explain how or why not.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_5, N'short_response', N'If you were in that character''s exact situation, would you have been motivated by the same thing? Why or why not?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_5, N'multiple_choice', N'Understanding a character''s motivation mostly helps a reader...', N'["Understand WHY they act the way they do, not just WHAT they do", "Skip parts of the book", "Predict the page count"]', N'Understand WHY they act the way they do, not just WHAT they do', 6);

    DECLARE @cat_empathy_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'sel', N'Empathy', 'space_heavy', 4, N'Write a short letter of support to a character in a story who is going through something hard.', 0);
    SET @cat_empathy_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_6, N'short_response', N'Pick a struggling character from a book, show, or story. What are they struggling with?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_6, N'short_response', N'Write a short letter TO that character, showing you understand their feelings and offering encouragement.', NULL, N'Answers will vary — should reflect genuine empathy for the character''s situation.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_6, N'multiple_choice', N'A good letter of support should mainly...', N'["Acknowledge their feelings before offering encouragement", "Tell them their feelings are wrong", "Only talk about your own experiences"]', N'Acknowledge their feelings before offering encouragement', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_6, N'short_response', N'What is one specific detail from the story that shows how the character feels?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_6, N'short_response', N'How might writing a letter like this help YOU understand the character (or a real person going through something similar) better?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_6, N'multiple_choice', N'Which sentence best shows empathy in a letter?', N'["''That sounds really hard — I understand why you feel that way.''", "''You should just get over it.''", "''That''s not a big deal at all.''"]', N'''That sounds really hard — I understand why you feel that way.''', 6);

    DECLARE @cat_empathy_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'sel', N'Empathy', 'space_heavy', 4, N'Identify a real, unmet need in your community and think through how you could respond.', 0);
    SET @cat_empathy_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_7, N'short_response', N'Think of your school or neighborhood. Name one need that isn''t being fully met (e.g., a lonely classmate, a littered park, kids without school supplies).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_7, N'short_response', N'Who is affected by this need, and how might it make them feel?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_7, N'short_response', N'Write one realistic action you (or a group of kids) could take to help address this need.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_7, N'multiple_choice', N'Identifying a community need starts with...', N'["Noticing and listening to what''s actually missing for people", "Assuming you already know everyone''s needs", "Ignoring problems that don''t affect you directly"]', N'Noticing and listening to what''s actually missing for people', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_7, N'short_response', N'Why might an adult and a kid notice DIFFERENT unmet needs in the same community?', NULL, N'They have different daily experiences and perspectives, so they notice different things.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_empathy_7, N'multiple_choice', N'Responding to a community need with empathy means...', N'["Understanding how it affects people before deciding how to help", "Helping in whatever way is fastest for you, regardless of the need", "Waiting for someone else to notice it first"]', N'Understanding how it affects people before deciding how to help', 6);

    DECLARE @cat_conflict_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'sel', N'Conflict Resolution', 'short_answer', 5, NULL, 0);
    SET @cat_conflict_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'multiple_choice', N'Two friends want the same toy. What should they do?', N'["Use their words and take turns", "Grab it and run", "Yell at each other"]', N'Use their words and take turns', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'short_response', N'What are kind words you could say if someone takes your toy?', NULL, N'Answers will vary (e.g., ''Can I have a turn please?'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'multiple_choice', N'If you''re upset with a friend, what''s a good first step?', N'["Tell them how you feel using words", "Hit them", "Ignore them forever"]', N'Tell them how you feel using words', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'fill_blank', N'Instead of grabbing, I can say: ''Can I have a ______, please?''', NULL, N'turn', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'short_response', N'Draw or tell: two friends both want to be first in line. What could they do?', NULL, N'Answers will vary (e.g., take turns, do rock-paper-scissors).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'multiple_choice', N'Which words are ''use your words'' words?', N'["''Can we share?''", "''That''s mine, go away!''", "(silence, then grabbing)"]', N'''Can we share?''', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_0, N'short_response', N'Why is using your words better than grabbing or yelling?', NULL, N'It helps solve the problem without hurting anyone''s feelings.', 7);

    DECLARE @cat_conflict_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'sel', N'Conflict Resolution', 'short_answer', 5, N'Fill in the ''I feel... because...'' sentence starter for each situation.', 0);
    SET @cat_conflict_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'fill_blank', N'A friend cuts in front of you in line. Complete: ''I feel ______ because they cut in line.''', NULL, N'frustrated (or upset)', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'fill_blank', N'A friend won''t share the blocks. Complete: ''I feel sad because I want a ______ too.''', NULL, N'turn', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'short_response', N'Write your own ''I feel... because...'' sentence about a time someone upset you.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'multiple_choice', N'Why do we say ''I feel...'' instead of ''You always...''?', N'["It explains your feeling without blaming the other person", "It sounds nicer but means the same thing", "It doesn''t matter which one you use"]', N'It explains your feeling without blaming the other person', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'short_response', N'If a friend says ''I feel left out because you didn''t ask me to play,'' what could you say back?', NULL, N'Answers will vary (e.g., ''I''m sorry, do you want to play now?'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'multiple_choice', N'An ''I feel... because...'' sentence helps the OTHER person...', N'["Understand your feelings instead of just getting blamed", "Know exactly what toy you want", "Guess what happened without being told"]', N'Understand your feelings instead of just getting blamed', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_1, N'short_response', N'Practice: write an ''I feel... because...'' sentence for feeling happy about something a friend did.', NULL, N'Answers will vary.', 7);

    DECLARE @cat_conflict_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'sel', N'Conflict Resolution', 'space_heavy', 4, N'Role-play script: two kids, Sam and Ali, both want to play with the same toy truck.', 0);
    SET @cat_conflict_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_2, N'short_response', N'Write what SAM could say to start solving the problem fairly.', NULL, N'Answers will vary (e.g., ''Let''s take turns — you go first, then me.'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_2, N'short_response', N'Write what ALI could say back.', NULL, N'Answers will vary (e.g., ''Okay, that sounds fair.'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_2, N'multiple_choice', N'What is a FAIR solution to the toy truck problem?', N'["Taking turns with a timer", "Sam keeps it all day", "Ali grabs it and runs away"]', N'Taking turns with a timer', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_2, N'short_response', N'Act out (or write) the ending of the script where Sam and Ali agree on a solution.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_2, N'multiple_choice', N'Why is role-playing a conflict helpful before it actually happens?', N'["It lets you practice fair, calm solutions ahead of time", "It''s just for fun, not useful", "It guarantees you''ll never disagree again"]', N'It lets you practice fair, calm solutions ahead of time', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_2, N'short_response', N'What could Sam and Ali''s teacher say to help if they can''t agree?', NULL, N'Answers will vary (e.g., suggest a timer or a coin flip).', 6);

    DECLARE @cat_conflict_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'sel', N'Conflict Resolution', 'space_heavy', 4, N'Read the conflict scenario, then brainstorm THREE different fair solutions.', 0);
    SET @cat_conflict_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_3, N'short_response', N'Scenario: Two students both want to be team captain for the class game. Brainstorm solution #1.', NULL, N'Answers will vary (e.g., vote as a class).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_3, N'short_response', N'Brainstorm solution #2 for the same scenario.', NULL, N'Answers will vary (e.g., take turns being captain each week).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_3, N'short_response', N'Brainstorm solution #3 for the same scenario.', NULL, N'Answers will vary (e.g., co-captains, splitting responsibilities).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_3, N'multiple_choice', N'Why brainstorm THREE solutions instead of just picking the first idea?', N'["More options usually means a fairer solution for everyone", "The first idea is always wrong", "It''s required by the rules of brainstorming"]', N'More options usually means a fairer solution for everyone', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_3, N'short_response', N'Which of your three solutions do you think is fairest, and why?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_3, N'multiple_choice', N'A ''fair'' solution to a conflict usually means...', N'["Both sides feel reasonably okay with the outcome", "One side gets everything they want", "No one has to compromise at all"]', N'Both sides feel reasonably okay with the outcome', 6);

    DECLARE @cat_conflict_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'sel', N'Conflict Resolution', 'space_heavy', 4, N'Sort each conflict outcome as WIN-WIN or WIN-LOSE.', 0);
    SET @cat_conflict_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_4, N'matching', N'Sort each outcome.', N'{"left": ["Two kids split the last snack evenly", "One kid gets the whole prize, the other gets nothing", "Two friends take turns choosing the game each day", "One friend always picks the movie, the other never gets a say"], "right": ["Win-win", "Win-lose", "Win-win", "Win-lose"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_4, N'short_response', N'Rewrite a win-lose outcome from above into a win-win outcome.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_4, N'multiple_choice', N'A win-win solution to a conflict means...', N'["Both people come away feeling reasonably satisfied", "One person ''wins'' the argument", "Neither person gets anything they wanted"]', N'Both people come away feeling reasonably satisfied', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_4, N'short_response', N'Describe a real conflict you''ve had that ended win-lose. How could it have gone win-win instead?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_4, N'multiple_choice', N'Why do win-lose solutions often cause MORE conflict later?', N'["The ''losing'' side often still feels upset or resentful", "They always solve the problem completely", "They''re actually the fairest kind of solution"]', N'The ''losing'' side often still feels upset or resentful', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_4, N'short_response', N'What''s one question you could ask during a disagreement to help find a win-win solution?', NULL, N'Answers will vary (e.g., ''What would make this feel fair to both of us?'').', 6);

    DECLARE @cat_conflict_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'sel', N'Conflict Resolution', 'space_heavy', 4, N'Practice the mediation steps: listen, restate, solve.', 0);
    SET @cat_conflict_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_conflict_5, N'short_response', N'Put the mediation steps in the correct order.', NULL, N'Listen, restate, solve.', 1, N'sequence_steps', N'{"steps": ["Listen fully to both sides without interrupting", "Restate what each person said, in your own words", "Work together to find a solution both sides agree to"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_5, N'short_response', N'Why is ''restating what each person said'' an important step, not just extra work?', NULL, N'It shows both people they were really heard, and helps clear up misunderstandings.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_5, N'multiple_choice', N'During mediation, the mediator''s job is to...', N'["Help both sides communicate and reach a fair solution, not pick a winner", "Decide who is right and who is wrong", "Ignore one side''s feelings to save time"]', N'Help both sides communicate and reach a fair solution, not pick a winner', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_5, N'short_response', N'Practice: write a ''restatement'' sentence a mediator might say after hearing someone''s side.', NULL, N'Answers will vary (e.g., ''So what I hear you saying is...'').', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_5, N'short_response', N'Describe a conflict at school where following these mediation steps could have helped.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_5, N'multiple_choice', N'Why is ''listen fully without interrupting'' the FIRST step, not the last?', N'["You can''t fairly help solve a conflict you don''t fully understand yet", "Listening isn''t actually necessary for mediation", "It''s just a formality with no real purpose"]', N'You can''t fairly help solve a conflict you don''t fully understand yet', 6);

    DECLARE @cat_conflict_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'sel', N'Conflict Resolution', 'space_heavy', 4, N'Analyze a real-world conflict (news, history, or community) and propose a compromise.', 0);
    SET @cat_conflict_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_6, N'short_response', N'Describe a real-world conflict you''ve heard about (between two groups, countries, or people). What do both sides want?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_6, N'short_response', N'Propose ONE realistic compromise that could address both sides'' main concerns.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_6, N'multiple_choice', N'A realistic compromise usually means...', N'["Both sides give up something to gain something else", "One side gets everything it originally wanted", "The conflict is simply ignored"]', N'Both sides give up something to gain something else', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_6, N'short_response', N'What makes some real-world conflicts harder to compromise on than a disagreement between two kids over a toy?', NULL, N'Answers will vary (e.g., higher stakes, long history, many people affected, deeply held values).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_6, N'short_response', N'Who would need to agree to your proposed compromise for it to actually work?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_6, N'multiple_choice', N'Why is it useful to practice analyzing real-world conflicts, even ones you can''t personally solve?', N'["It builds skill in seeing multiple perspectives fairly", "It has no real value", "It''s only useful for adults, not students"]', N'It builds skill in seeing multiple perspectives fairly', 6);

    DECLARE @cat_conflict_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'sel', N'Conflict Resolution', 'space_heavy', 4, N'Write and act out a structured peer-mediator script for a realistic school conflict.', 0);
    SET @cat_conflict_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_7, N'short_response', N'Write an opening line a peer mediator could use to start a session fairly for both sides.', NULL, N'Answers will vary (e.g., ''Thanks for being willing to talk this out. Each of you will get a turn to share.'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_7, N'short_response', N'Write a line the mediator could use to make sure both sides feel heard before jumping to solutions.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_conflict_7, N'short_response', N'Put a full peer-mediation script structure in order.', NULL, N'Ground rules, share, restate, brainstorm, agree.', 3, N'sequence_steps', N'{"steps": ["Set ground rules (respect, no interrupting)", "Each side shares their perspective", "Mediator restates each side''s main point", "Brainstorm possible solutions together", "Agree on one solution and next steps"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_7, N'short_response', N'Write a closing line that confirms both sides agree to the solution.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_7, N'multiple_choice', N'A peer mediator should remain...', N'["Neutral — not taking either side''s position", "On the side of whoever is more upset", "In charge of deciding who is right"]', N'Neutral — not taking either side''s position', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_conflict_7, N'short_response', N'What''s one skill a peer mediator needs that you think is hardest to practice, and why?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_collab_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'sel', N'Collaboration', 'short_answer', 4, NULL, 0);
    SET @cat_collab_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_0, N'multiple_choice', N'A group mural means everyone...', N'["Adds their own part to make one picture together", "Draws on their own separate paper", "Only one person draws, others watch"]', N'Adds their own part to make one picture together', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_0, N'short_response', N'What part would YOU like to add to a group mural about your class?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_0, N'multiple_choice', N'If a friend wants to add something where you''re drawing, what should you do?', N'["Make room and share the space", "Tell them to go away", "Cover up their part"]', N'Make room and share the space', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_0, N'short_response', N'Why is working together on one big picture fun?', NULL, N'Answers will vary (e.g., everyone''s ideas combine into something bigger).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_0, N'multiple_choice', N'Working together with others to make something is called...', N'["Collaboration", "Racing", "Napping"]', N'Collaboration', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_0, N'short_response', N'Name one friend you would like to make a group picture with, and why.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_collab_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'sel', N'Collaboration', 'short_answer', 4, N'Partner puzzle: each partner has half the pieces — you must work together to finish it.', 0);
    SET @cat_collab_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_1, N'multiple_choice', N'If your partner has a piece you need, what should you say?', N'["''Can I have that piece, please?''", "Grab it without asking", "Do the puzzle alone instead"]', N'''Can I have that piece, please?''', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_1, N'short_response', N'Why does a partner puzzle only work if BOTH people help?', NULL, N'Each person only has some of the pieces, so it takes both to finish.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_1, N'short_response', N'What could you say to encourage your partner if the puzzle is tricky?', NULL, N'Answers will vary (e.g., ''You can do it, let''s try together!'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_1, N'multiple_choice', N'If you finish your half first, what''s a good next step?', N'["Offer to help your partner with their half", "Walk away", "Tell them they''re too slow"]', N'Offer to help your partner with their half', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_1, N'short_response', N'How did it feel to finish the puzzle together compared to doing one alone?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_1, N'multiple_choice', N'A partner puzzle teaches you that working together can be...', N'["Faster and more fun than working alone", "Always harder than working alone", "Not necessary at all"]', N'Faster and more fun than working alone', 6);

    DECLARE @cat_collab_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'sel', N'Collaboration', 'space_heavy', 4, N'Team scavenger hunt: plan how your team will find all the items together.', 0);
    SET @cat_collab_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_2, N'short_response', N'Your team has 5 items to find and 3 people. How will you divide the work fairly?', NULL, N'Answers will vary (e.g., split the list into sections each person searches).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_2, N'short_response', N'What should your team do if one person finds an item — should they keep looking alone or tell the team?', NULL, N'Tell the team right away so everyone knows what''s left to find.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_2, N'multiple_choice', N'Scavenger hunts work best in teams because...', N'["More people searching means finding items faster together", "One person should always do all the work", "Teams always find fewer items than one person"]', N'More people searching means finding items faster together', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_2, N'short_response', N'What would you do if a teammate couldn''t find their assigned items?', NULL, N'Answers will vary (e.g., help them search once you finish your own).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_2, N'short_response', N'Name one strength each of your teammates might bring to a scavenger hunt (fast runner, good at spotting details, etc.).', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_2, N'multiple_choice', N'What''s most important for a team scavenger hunt to succeed?', N'["Communicating about what''s been found and what''s left", "Racing each other instead of the clock", "Working completely silently"]', N'Communicating about what''s been found and what''s left', 6);

    DECLARE @cat_collab_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'sel', N'Collaboration', 'space_heavy', 4, N'Plan a group project: write down each team member''s role.', 0);
    SET @cat_collab_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_3, N'short_response', N'List 3 roles a group project might need (e.g., researcher, writer, presenter).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_3, N'short_response', N'Why does assigning specific roles help a group work better than ''everyone does everything''?', NULL, N'It avoids confusion and duplicate work, and lets people focus on one task well.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_3, N'multiple_choice', N'If a role isn''t getting done, the BEST first step is to...', N'["Talk to that team member and offer to help", "Do it yourself without saying anything", "Complain to someone outside the group"]', N'Talk to that team member and offer to help', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_3, N'short_response', N'Which role would you personally want on a group project, and why?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_3, N'short_response', N'What''s one way your group could check in on progress partway through the project?', NULL, N'Answers will vary (e.g., a quick team meeting halfway through).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_3, N'multiple_choice', N'A group project planning sheet is most useful for...', N'["Making sure everyone knows what they''re responsible for", "Deciding who gets the best grade", "Skipping the need to actually talk to teammates"]', N'Making sure everyone knows what they''re responsible for', 6);

    DECLARE @cat_collab_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'sel', N'Collaboration', 'space_heavy', 4, N'Divide a team challenge''s tasks based on each person''s strengths.', 0);
    SET @cat_collab_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_4, N'short_response', N'List 3 teammates (real or made up) and one strength each of them has.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_4, N'short_response', N'Match each strength to a task in your team challenge that would use it well.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_4, N'multiple_choice', N'Dividing tasks by strength usually leads to...', N'["Better results, since people work on what they''re good at", "Worse results than random assignment", "No difference at all"]', N'Better results, since people work on what they''re good at', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_4, N'short_response', N'What should a team do if two people both want the same strong-suit task?', NULL, N'Answers will vary (e.g., split the task, or take turns leading different parts).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_4, N'multiple_choice', N'What should happen if no one on the team is confident about a needed task?', N'["The team can learn it together or ask for help", "Skip that part of the project entirely", "One person should be forced to do it alone"]', N'The team can learn it together or ask for help', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_4, N'short_response', N'Why is it valuable to know your OWN strengths before joining a team challenge?', NULL, N'Answers will vary (e.g., you can offer to take on tasks that fit you well).', 6);

    DECLARE @cat_collab_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'sel', N'Collaboration', 'space_heavy', 4, N'Plan a group research project with clearly assigned roles.', 0);
    SET @cat_collab_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_5, N'short_response', N'Choose a research topic and list 4 roles needed (e.g., researcher, note-taker, designer, presenter).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_5, N'short_response', N'Write one specific responsibility for each of the 4 roles.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_5, N'multiple_choice', N'A group research project usually fails when...', N'["Roles and expectations were never made clear", "Everyone has a clearly assigned role", "The group meets regularly to check progress"]', N'Roles and expectations were never made clear', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_5, N'short_response', N'How would your group handle it if new information changed your original plan halfway through?', NULL, N'Answers will vary (e.g., regroup and adjust roles/timeline as needed).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_5, N'short_response', N'What is one way to make sure quieter group members'' ideas get heard?', NULL, N'Answers will vary (e.g., go around and ask each person directly).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_5, N'multiple_choice', N'Assigning roles at the START of a group project mainly helps by...', N'["Preventing confusion and duplicated effort later on", "Making the project take longer", "Guaranteeing no disagreements will ever happen"]', N'Preventing confusion and duplicated effort later on', 6);

    DECLARE @cat_collab_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'sel', N'Collaboration', 'space_heavy', 4, N'Prep for a team debate: divide responsibilities across your team.', 0);
    SET @cat_collab_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_6, N'short_response', N'List the responsibilities a debate team needs (e.g., researcher, opening speaker, rebuttal writer, closing speaker).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_6, N'short_response', N'Assign each responsibility to a (real or made-up) teammate, matching their strengths.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_6, N'multiple_choice', N'Why should a debate team divide research AND speaking roles ahead of time?', N'["So each person can prepare deeply instead of scrambling last-minute", "Because only one person is allowed to talk", "It doesn''t actually matter for a debate"]', N'So each person can prepare deeply instead of scrambling last-minute', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_6, N'short_response', N'What should your team do if the opposing side brings up a point you didn''t prepare for?', NULL, N'Answers will vary (e.g., have a team member ready to think on their feet, or regroup briefly).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_6, N'short_response', N'How would your team make sure everyone''s prep work fits together into one consistent argument?', NULL, N'Answers will vary (e.g., a team meeting to review everyone''s parts together).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_6, N'multiple_choice', N'Good debate-team collaboration mainly shows up as...', N'["A consistent, well-supported argument built from everyone''s prep", "Everyone arguing a different, unrelated point", "One person doing all the talking with no team input"]', N'A consistent, well-supported argument built from everyone''s prep', 6);

    DECLARE @cat_collab_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'sel', N'Collaboration', 'space_heavy', 4, N'Write a capstone group project charter: goals, roles, and a timeline.', 0);
    SET @cat_collab_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_7, N'short_response', N'Write one clear GOAL statement for a group capstone project of your choice.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_7, N'short_response', N'List each team member''s ROLE and main responsibility.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_7, N'short_response', N'Sketch a rough TIMELINE with at least 3 milestones and target dates.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_7, N'multiple_choice', N'A project charter is mainly useful because it...', N'["Gets everyone aligned on goals, roles, and deadlines before work starts", "Is a legal document with no practical use", "Replaces the need for the team to ever communicate again"]', N'Gets everyone aligned on goals, roles, and deadlines before work starts', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_7, N'short_response', N'What should your team do if you fall behind one of your charter''s milestones?', NULL, N'Answers will vary (e.g., reassess the timeline together and adjust).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_collab_7, N'multiple_choice', N'Which is the best sign a capstone team is collaborating well?', N'["Team members check in, adjust plans together, and support each other", "One person does all the work while others watch", "The charter is written but never referenced again"]', N'Team members check in, adjust plans together, and support each other', 6);

    DECLARE @cat_listen_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'sel', N'Active Listening', 'short_answer', 4, NULL, 0);
    SET @cat_listen_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_0, N'multiple_choice', N'In Simon Says, when do you follow the direction?', N'["Only when ''Simon says'' is used", "Every single time", "Never"]', N'Only when ''Simon says'' is used', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_0, N'multiple_choice', N'What do good listeners do with their eyes and ears?', N'["Look at the speaker and listen closely", "Look away and talk to a friend", "Cover their ears"]', N'Look at the speaker and listen closely', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_0, N'short_response', N'Why is it hard to follow directions if you''re not listening carefully?', NULL, N'You might miss an important part of what to do.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_0, N'multiple_choice', N'If you''re not sure what to do, what''s a good thing to say?', N'["''Can you say that again, please?''", "Nothing, just guess", "Walk away"]', N'''Can you say that again, please?''', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_0, N'short_response', N'Play a mini Simon Says with a grown-up. Write one direction they gave you.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_0, N'multiple_choice', N'Good listening helps you...', N'["Follow directions correctly", "Finish faster by guessing", "Ignore the speaker"]', N'Follow directions correctly', 6);

    DECLARE @cat_listen_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'sel', N'Active Listening', 'short_answer', 4, N'Listen to a grown-up give oral instructions, then draw what you heard.', 0);
    SET @cat_listen_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_1, N'short_response', N'Ask a grown-up to describe a simple picture out loud (like ''draw a big yellow sun with 5 rays''). Draw or describe what you drew.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_1, N'multiple_choice', N'Why might your drawing look different from what the grown-up imagined?', N'["You might have missed or misheard a detail", "Drawing is always wrong", "Listening doesn''t matter for drawing"]', N'You might have missed or misheard a detail', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_1, N'short_response', N'What could you ask if you weren''t sure about a detail while listening?', NULL, N'Answers will vary (e.g., ''How many rays should the sun have?'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_1, N'multiple_choice', N'Drawing what you heard is a good listening practice because...', N'["It shows exactly what details you did or didn''t catch", "Drawing has nothing to do with listening", "It''s only about art skill"]', N'It shows exactly what details you did or didn''t catch', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_1, N'short_response', N'Try describing a simple picture out loud to a grown-up and see what they draw. What did they get right or miss?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_1, N'short_response', N'What''s one way to listen even more carefully next time?', NULL, N'Answers will vary (e.g., look at the speaker, don''t interrupt, ask questions).', 6);

    DECLARE @cat_listen_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'sel', N'Active Listening', 'short_answer', 4, N'Follow 3-step oral directions exactly as given.', 0);
    SET @cat_listen_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_2, N'short_response', N'A grown-up says: ''Touch your nose, clap twice, then say your name.'' Do it, then write the 3 steps in order.', NULL, N'Touch nose, clap twice, say your name.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_2, N'multiple_choice', N'What''s the risk of only remembering step 1 and step 3 of a 3-step direction?', N'["You''ll miss doing step 2 correctly", "Nothing changes, it''s fine to skip steps", "The direction only needed 2 steps anyway"]', N'You''ll miss doing step 2 correctly', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_2, N'short_response', N'What''s a good strategy to remember all 3 steps of an oral direction?', NULL, N'Answers will vary (e.g., repeat it silently, count on fingers).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_2, N'multiple_choice', N'If you forget the steps partway through, what should you do?', N'["Ask for the directions to be repeated", "Guess and hope it''s right", "Give up"]', N'Ask for the directions to be repeated', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_2, N'short_response', N'Make up your own 3-step direction and give it to a family member. Did they follow all 3 steps?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_2, N'multiple_choice', N'Following multi-step directions accurately is an important skill because...', N'["Many real tasks (school, chores, games) need several steps done in order", "Only 1-step directions matter in real life", "Steps never need to happen in a specific order"]', N'Many real tasks (school, chores, games) need several steps done in order', 6);

    DECLARE @cat_listen_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'sel', N'Active Listening', 'space_heavy', 4, N'Interview a partner and record their answers carefully.', 0);
    SET @cat_listen_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_3, N'short_response', N'Ask a partner: ''What''s your favorite thing to do after school?'' Write their answer in their own words.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_3, N'short_response', N'Ask a partner: ''What''s something you''re proud of?'' Write their answer.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_3, N'multiple_choice', N'When recording someone''s answer, you should try to...', N'["Use their actual words as closely as possible", "Change their answer to something you like better", "Only write down part of what they said"]', N'Use their actual words as closely as possible', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_3, N'short_response', N'What could you do if a partner''s answer was hard to understand?', NULL, N'Answers will vary (e.g., politely ask them to explain more).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_3, N'short_response', N'Why might it be tempting to think about your OWN answer instead of really listening to your partner''s?', NULL, N'Answers will vary (e.g., you''re excited to share your own thoughts) — good listeners resist this.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_3, N'multiple_choice', N'A partner interview mainly practices...', N'["Listening closely enough to accurately record someone else''s words", "Talking as much as possible yourself", "Guessing what the other person will say"]', N'Listening closely enough to accurately record someone else''s words', 6);

    DECLARE @cat_listen_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'sel', N'Active Listening', 'space_heavy', 4, N'Summarize a partner''s story in your own words after listening carefully.', 0);
    SET @cat_listen_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_4, N'short_response', N'Ask a partner to tell you a short story about their weekend. Summarize it in 2-3 sentences, in YOUR OWN words.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_4, N'multiple_choice', N'A good summary should...', N'["Capture the main points without copying every word", "Include every single word they said", "Change the meaning of what they said"]', N'Capture the main points without copying every word', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_4, N'short_response', N'What part of your partner''s story was easiest to remember? Hardest?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_4, N'multiple_choice', N'Why is summarizing in your OWN words a better listening check than repeating word-for-word?', N'["It proves you actually understood the meaning, not just memorized sounds", "It''s exactly the same as repeating word-for-word", "Understanding doesn''t matter, only memorization"]', N'It proves you actually understood the meaning, not just memorized sounds', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_4, N'short_response', N'Check your summary with your partner — did you capture their story correctly? What did you miss, if anything?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_4, N'short_response', N'What listening strategy helped you remember the story''s main points?', NULL, N'Answers will vary (e.g., focusing on beginning-middle-end).', 6);

    DECLARE @cat_listen_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'sel', N'Active Listening', 'space_heavy', 4, N'Take notes while listening to a short passage read aloud.', 0);
    SET @cat_listen_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_5, N'short_response', N'Have someone read a short paragraph aloud to you. Write down 3 key points as notes while listening.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_5, N'multiple_choice', N'Good notes while listening should be...', N'["Short key words and phrases, not full sentences", "A word-for-word transcript of everything said", "Written only after the passage is completely finished"]', N'Short key words and phrases, not full sentences', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_5, N'short_response', N'Compare your notes to the original passage. What did you capture well? What did you miss?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_5, N'multiple_choice', N'Why is note-taking WHILE listening harder than note-taking while reading?', N'["You can''t pause or reread — you have to catch it the first time", "Listening is always easier than reading", "There''s no real difference between the two"]', N'You can''t pause or reread — you have to catch it the first time', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_5, N'short_response', N'What''s one strategy that could help you take better notes while listening (abbreviations, symbols, etc.)?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_5, N'short_response', N'Why might note-taking skills from listening help you in a real classroom lecture?', NULL, N'Answers will vary (e.g., helps you study later, catch important details).', 6);

    DECLARE @cat_listen_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'sel', N'Active Listening', 'space_heavy', 4, N'Listen to (or read a transcript of) a debate, then summarize BOTH sides fairly.', 0);
    SET @cat_listen_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_6, N'short_response', N'Pick a simple debate topic (e.g., ''should school start later?''). Summarize the FOR side''s strongest point.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_6, N'short_response', N'Summarize the AGAINST side''s strongest point.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_6, N'multiple_choice', N'Summarizing BOTH sides fairly means...', N'["Representing each side''s argument accurately, even the one you disagree with", "Only summarizing the side you personally agree with", "Making one side sound worse than it actually is"]', N'Representing each side''s argument accurately, even the one you disagree with', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_6, N'short_response', N'Which side''s point did you find more convincing, and why? (Try to explain fairly, not dismiss the other side.)', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_6, N'multiple_choice', N'Why is fair summarizing an important listening skill in real debates or discussions?', N'["It shows you actually understood the disagreement, not just picked a side", "It''s not actually necessary — only your own opinion matters", "It means you have to agree with both sides equally"]', N'It shows you actually understood the disagreement, not just picked a side', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_6, N'short_response', N'What listening habit helps you stay fair to a side you personally disagree with?', NULL, N'Answers will vary (e.g., focusing on their reasoning, not your own reaction).', 6);

    DECLARE @cat_listen_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'sel', N'Active Listening', 'space_heavy', 4, N'Interview someone with a different perspective from yours, then write a short report.', 0);
    SET @cat_listen_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_7, N'short_response', N'Interview someone (a family member, classmate, or neighbor) about a topic where their perspective might differ from yours. What did you ask?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_7, N'short_response', N'Write a short report summarizing their perspective, in their own words as closely as possible.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_7, N'multiple_choice', N'A good interviewer mainly...', N'["Listens more than they talk, and asks follow-up questions", "Talks about their own opinion the whole time", "Only asks questions they already know the answer to"]', N'Listens more than they talk, and asks follow-up questions', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_7, N'short_response', N'What surprised you most about their perspective?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_7, N'multiple_choice', N'Writing a fair report on someone''s perspective means...', N'["Representing their views accurately, even if you disagree", "Rewriting their views to match your own opinion", "Leaving out any parts you don''t personally like"]', N'Representing their views accurately, even if you disagree', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_listen_7, N'short_response', N'How did really listening (instead of just waiting to talk) change what you learned from the interview?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_critthink_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'cognitive_skills', N'Critical Thinking', 'short_answer', 5, NULL, 0);
    SET @cat_critthink_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'multiple_choice', N'Is this TRUE or PRETEND: ''Dogs can bark.''', N'["True", "Pretend"]', N'True', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'multiple_choice', N'Is this TRUE or PRETEND: ''Dragons fly to school.''', N'["True", "Pretend"]', N'Pretend', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'multiple_choice', N'Is this TRUE or PRETEND: ''Cats can meow.''', N'["True", "Pretend"]', N'True', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'multiple_choice', N'Is this TRUE or PRETEND: ''A cow can talk on the phone.''', N'["True", "Pretend"]', N'Pretend', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'short_response', N'Tell one TRUE thing about the weather today.', NULL, N'Answers will vary, should be a real fact.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'short_response', N'Tell one PRETEND thing that could never really happen.', NULL, N'Answers will vary.', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_0, N'multiple_choice', N'Something that is TRUE is also called a...', N'["Fact", "Wish", "Song"]', N'Fact', 7);

    DECLARE @cat_critthink_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'cognitive_skills', N'Critical Thinking', 'short_answer', 4, N'Sort each simple sentence as a FACT (can be proven) or an OPINION (someone''s feeling).', 0);
    SET @cat_critthink_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_1, N'matching', N'Sort each sentence.', N'{"left": ["The sun rises in the east.", "Ice cream is the best food.", "A triangle has 3 sides.", "Winter is the worst season."], "right": ["Fact", "Opinion", "Fact", "Opinion"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_1, N'multiple_choice', N'A FACT is something that...', N'["Can be proven true", "Is just someone''s feeling", "Is always a guess"]', N'Can be proven true', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_1, N'multiple_choice', N'An OPINION is something that...', N'["Is someone''s feeling or belief", "Can always be proven true", "Is always exactly correct"]', N'Is someone''s feeling or belief', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_1, N'short_response', N'Write one FACT about animals.', NULL, N'Answers will vary, should be provable.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_1, N'short_response', N'Write one OPINION about your favorite animal.', NULL, N'Answers will vary, should express a feeling/preference.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_1, N'multiple_choice', N'''Dogs make the best pets'' is a...', N'["Fact", "Opinion"]', N'Opinion', 6);

    DECLARE @cat_critthink_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'cognitive_skills', N'Critical Thinking', 'space_heavy', 4, N'Read the short passage and spot which sentences are facts and which are opinions.', 0);
    SET @cat_critthink_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_2, N'short_response', N'Passage: ''Sharks live in the ocean. They are the scariest animals in the world.'' Which sentence is a FACT?', NULL, N'''Sharks live in the ocean.''', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_2, N'short_response', N'Which sentence in that passage is an OPINION?', NULL, N'''They are the scariest animals in the world.''', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_2, N'multiple_choice', N'How can you tell a sentence is an opinion?', N'["It expresses a feeling or judgment that not everyone would agree with", "It uses only short words", "It''s always the second sentence"]', N'It expresses a feeling or judgment that not everyone would agree with', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_2, N'short_response', N'Write your own short passage with 1 fact and 1 opinion about a topic you like.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_2, N'multiple_choice', N'Why is it useful to tell facts and opinions apart when you read?', N'["It helps you know what''s proven vs. what''s just someone''s view", "Facts and opinions are always the same thing", "It doesn''t matter for understanding a passage"]', N'It helps you know what''s proven vs. what''s just someone''s view', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_2, N'short_response', N'Find a fact and an opinion in a book or article you''re currently reading.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_critthink_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'cognitive_skills', N'Critical Thinking', 'space_heavy', 4, N'Evaluate two claims about the same topic and decide which is better-supported.', 0);
    SET @cat_critthink_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_3, N'short_response', N'Claim A: ''Recess should be longer because kids focus better after moving around.'' Claim B: ''Recess should be longer because it''s more fun.'' Which is BETTER-SUPPORTED, and why?', NULL, N'Claim A — it gives a reason based on evidence (focus), not just a feeling.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_3, N'multiple_choice', N'A well-supported claim usually includes...', N'["A reason or evidence behind it", "Just a strong opinion with no reason", "The loudest voice in the room"]', N'A reason or evidence behind it', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_3, N'short_response', N'Write a well-supported claim about why students should read every day.', NULL, N'Answers will vary — should include a real reason.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_3, N'multiple_choice', N'Which makes a claim MORE convincing?', N'["Backing it up with a reason or example", "Saying it louder", "Repeating it many times with no reason"]', N'Backing it up with a reason or example', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_3, N'short_response', N'Rewrite this weak claim to make it better-supported: ''Homework is bad.''', NULL, N'Answers will vary (e.g., ''Too much homework can reduce time for sleep, which affects learning.'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_3, N'multiple_choice', N'When comparing two claims, what should you look for first?', N'["Whether each claim has real evidence or reasoning behind it", "Which claim is longer", "Which claim was said first"]', N'Whether each claim has real evidence or reasoning behind it', 6);

    DECLARE @cat_critthink_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'cognitive_skills', N'Critical Thinking', 'space_heavy', 4, N'Analyze an advertisement or claim: separate the facts from the persuasion.', 0);
    SET @cat_critthink_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_4, N'short_response', N'Ad claim: ''This cereal has 10 grams of whole grains per serving — the BEST breakfast ever!'' What part is a FACT?', NULL, N'''10 grams of whole grains per serving.''', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_4, N'short_response', N'What part of that ad claim is PERSUASION (trying to convince you, not a proven fact)?', NULL, N'''The BEST breakfast ever!''', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_4, N'multiple_choice', N'Ads often use persuasive words like ''best'' or ''amazing'' because...', N'["They try to make you feel excited, even without proof", "Those words are always factually accurate", "Ads are legally required to only state facts"]', N'They try to make you feel excited, even without proof', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_4, N'short_response', N'Find a real ad (or make one up) and identify one fact and one persuasive phrase in it.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_4, N'multiple_choice', N'Why is it useful to separate facts from persuasion in an ad?', N'["It helps you make decisions based on real information, not just excitement", "Ads never contain any real facts", "Persuasion and facts are the exact same thing"]', N'It helps you make decisions based on real information, not just excitement', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_4, N'short_response', N'Write one persuasive sentence AND one purely factual sentence about the same product.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_critthink_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'cognitive_skills', N'Critical Thinking', 'space_heavy', 4, N'Compare two different sources covering the same topic.', 0);
    SET @cat_critthink_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_5, N'short_response', N'Find (or imagine) two sources about the same event that disagree on a detail. What do they disagree about?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_5, N'short_response', N'Which source seems more reliable to you, and why (author, evidence, date, etc.)?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_5, N'multiple_choice', N'When two sources disagree, a good next step is to...', N'["Look for a third source or more evidence to compare", "Automatically believe whichever source you read first", "Assume both sources must be lying"]', N'Look for a third source or more evidence to compare', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_5, N'short_response', N'What is one reason two honest sources might still describe the same event differently?', NULL, N'Different perspectives, different information available, or different focus/emphasis.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_5, N'multiple_choice', N'Comparing multiple sources on the same topic mainly helps you...', N'["Get a fuller, more balanced understanding", "Waste time since one source is always enough", "Prove that all sources are equally trustworthy"]', N'Get a fuller, more balanced understanding', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_5, N'short_response', N'Write one question you''d ask to check if a source is trustworthy.', NULL, N'Answers will vary (e.g., ''Who wrote this, and do they have evidence?'').', 6);

    DECLARE @cat_critthink_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'cognitive_skills', N'Critical Thinking', 'space_heavy', 4, N'Evaluate how strong the evidence really is in a short article.', 0);
    SET @cat_critthink_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_6, N'short_response', N'Read (or imagine) a short article''s main claim. What evidence does it give to support that claim?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_6, N'multiple_choice', N'Strong evidence usually includes...', N'["Specific data, expert sources, or clear examples", "Just a strong opinion stated confidently", "No sources at all"]', N'Specific data, expert sources, or clear examples', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_6, N'short_response', N'Rate the evidence in your article as strong, medium, or weak, and explain why.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_6, N'multiple_choice', N'An article that says ''everyone knows this is true'' with no source is...', N'["Weak evidence — it provides no actual proof", "Strong evidence, since many people agree", "Impossible to evaluate"]', N'Weak evidence — it provides no actual proof', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_6, N'short_response', N'What additional evidence would make this article''s claim more convincing?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_6, N'multiple_choice', N'Why does it matter whether evidence is strong or weak?', N'["Strong evidence makes a claim more trustworthy and worth acting on", "All evidence is equally trustworthy no matter what", "Evidence quality doesn''t affect whether a claim is true"]', N'Strong evidence makes a claim more trustworthy and worth acting on', 6);

    DECLARE @cat_critthink_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'cognitive_skills', N'Critical Thinking', 'space_heavy', 4, N'Prep for a debate: build an argument with 3 supporting facts.', 0);
    SET @cat_critthink_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_7, N'short_response', N'Pick a debate topic. Write your main argument (the position you''re taking) in one sentence.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_7, N'short_response', N'List 3 SEPARATE supporting facts or reasons for your argument.', NULL, N'Answers will vary — should be 3 distinct, real supporting points.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_7, N'multiple_choice', N'A strong debate argument needs...', N'["Multiple distinct pieces of supporting evidence, not just one", "Just a confident tone of voice", "As many exclamation points as possible"]', N'Multiple distinct pieces of supporting evidence, not just one', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_7, N'short_response', N'What''s the strongest counter-argument someone could make against your position? How would you respond?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_7, N'multiple_choice', N'Why prepare a counter-argument response BEFORE the actual debate?', N'["It helps you respond calmly and confidently instead of being caught off guard", "Counter-arguments never come up in real debates", "It''s not useful — only your own argument matters"]', N'It helps you respond calmly and confidently instead of being caught off guard', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_critthink_7, N'short_response', N'Write a strong closing sentence that sums up your 3 supporting facts.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_probsolve_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'cognitive_skills', N'Problem-Solving', 'short_answer', 4, NULL, 0);
    SET @cat_probsolve_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_probsolve_0, N'short_response', N'Put the steps of brushing your teeth in order.', NULL, N'Toothpaste, brush, rinse.', 1, N'sequence_steps', N'{"steps": ["Put toothpaste on the brush", "Brush all your teeth", "Rinse your mouth with water"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_probsolve_0, N'short_response', N'Put the steps of making a sandwich in order.', NULL, N'Bread, filling, together.', 2, N'sequence_steps', N'{"steps": ["Get two pieces of bread", "Add your favorite filling", "Put the bread together"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_0, N'multiple_choice', N'If your tower of blocks falls down, what should you do?', N'["Try building it again", "Give up and walk away", "Kick the blocks"]', N'Try building it again', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_0, N'short_response', N'What is a problem you solved today, even a small one?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_probsolve_0, N'short_response', N'Put the steps for getting ready for bed in order.', NULL, N'Pajamas, brush teeth, bed.', 5, N'sequence_steps', N'{"steps": ["Put on pajamas", "Brush your teeth", "Get into bed"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_0, N'multiple_choice', N'Breaking a big job into small steps is called...', N'["Problem-solving", "Guessing", "Forgetting"]', N'Problem-solving', 6);

    DECLARE @cat_probsolve_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'cognitive_skills', N'Problem-Solving', 'short_answer', 4, N'Break a simple task into 4 ordered steps.', 0);
    SET @cat_probsolve_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_probsolve_1, N'short_response', N'Break ''cleaning up your room'' into 4 steps, in order.', NULL, N'Answers will vary in exact order, should be 4 logical steps.', 1, N'sequence_steps', N'{"steps": ["Pick up toys and put them in the bin", "Put books back on the shelf", "Put dirty clothes in the hamper", "Make the bed"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_probsolve_1, N'short_response', N'Break ''planting a seed'' into 4 steps, in order.', NULL, N'Answers will vary in exact order, should be 4 logical steps.', 2, N'sequence_steps', N'{"steps": ["Fill a pot with soil", "Make a small hole", "Place the seed in and cover it", "Water it gently"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_1, N'multiple_choice', N'Why break a big task into smaller steps?', N'["It''s easier to finish one small step at a time", "It makes the task take longer", "It''s only useful for chores"]', N'It''s easier to finish one small step at a time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_1, N'short_response', N'Pick a task YOU do at home. Write it as 4 ordered steps.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_1, N'multiple_choice', N'What happens if you do the steps out of order?', N'["The task might not work correctly", "It never matters what order you do things in", "Order is only important for math"]', N'The task might not work correctly', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_1, N'short_response', N'What''s a task where the ORDER of steps really matters a lot? Why?', NULL, N'Answers will vary (e.g., baking — ingredients must go in at the right time).', 6);

    DECLARE @cat_probsolve_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'cognitive_skills', N'Problem-Solving', 'short_answer', 4, N'Solve a logic puzzle and show your thinking along the way.', 0);
    SET @cat_probsolve_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_2, N'short_response', N'Puzzle: I have 3 pets. One is a dog, one is a cat, and one is a bird. The dog is not named Max. The cat is named Bella. What could the dog''s name be? Show your thinking.', NULL, N'Any name except Max or Bella (the cat''s name).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_2, N'multiple_choice', N'When solving a maze, a good strategy is to...', N'["Trace the path from start to finish, backing up at dead ends", "Guess randomly with your eyes closed", "Give up as soon as you hit one wrong turn"]', N'Trace the path from start to finish, backing up at dead ends', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_2, N'short_response', N'Describe a strategy you''d use to solve a tricky maze.', NULL, N'Answers will vary (e.g., work backward from the end, mark dead ends).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_2, N'multiple_choice', N'''Showing your work'' on a puzzle means...', N'["Writing down your thinking steps, not just the final answer", "Erasing everything except the final answer", "Not writing anything at all"]', N'Writing down your thinking steps, not just the final answer', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_2, N'short_response', N'Why is showing your work helpful, even if you get the puzzle right?', NULL, N'It helps you (and others) see HOW you solved it, and catch mistakes faster.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_2, N'short_response', N'Make up your own simple logic clue puzzle for a friend to solve.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_probsolve_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'cognitive_skills', N'Problem-Solving', 'short_answer', 4, N'Solve a multi-step word problem by breaking it into parts.', 0);
    SET @cat_probsolve_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_3, N'short_response', N'Word problem: Maria has 24 stickers. She gives 6 to her brother and buys 10 more. How many does she have now? Show each step.', NULL, N'24 - 6 = 18, then 18 + 10 = 28 stickers.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_3, N'multiple_choice', N'The FIRST step in a multi-step word problem is usually to...', N'["Figure out what the problem is actually asking", "Guess a number immediately", "Skip to the last sentence only"]', N'Figure out what the problem is actually asking', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_3, N'short_response', N'Word problem: A class of 28 students splits into teams of 4. Then 2 students join late. How many teams are there now, and are any teams uneven? Show your steps.', NULL, N'28 / 4 = 7 teams, then 2 more students need to be added to existing teams or a new team formed — explain reasoning.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_3, N'multiple_choice', N'Why break a word problem into smaller parts instead of solving it all at once?', N'["It''s easier to check each part for mistakes", "It always gives a different, wrong answer", "It takes the exact same effort either way"]', N'It''s easier to check each part for mistakes', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_3, N'short_response', N'Write your own 2-step word problem for a friend to solve.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_3, N'short_response', N'After solving a multi-step problem, how can you check if your answer makes sense?', NULL, N'Answers will vary (e.g., estimate first, then compare; work backward from the answer).', 6);

    DECLARE @cat_probsolve_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'cognitive_skills', N'Problem-Solving', 'space_heavy', 4, N'Design a solution for a real everyday problem.', 0);
    SET @cat_probsolve_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_4, N'short_response', N'Pick an everyday problem (e.g., forgetting your backpack, losing your water bottle). Describe the problem clearly.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_4, N'short_response', N'Design ONE realistic solution to that problem.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_4, N'multiple_choice', N'A good solution to an everyday problem should be...', N'["Something you could realistically actually do", "Impossible to actually carry out", "Someone else''s job to fix, not yours"]', N'Something you could realistically actually do', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_4, N'short_response', N'What materials or steps would you need to put your solution into action?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_4, N'multiple_choice', N'Why is clearly describing the PROBLEM first so important?', N'["A solution only works if it actually solves the real problem", "The problem doesn''t matter, only the solution does", "Describing the problem wastes time"]', N'A solution only works if it actually solves the real problem', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_4, N'short_response', N'How would you know if your solution actually worked?', NULL, N'Answers will vary (e.g., the problem stops happening).', 6);

    DECLARE @cat_probsolve_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'cognitive_skills', N'Problem-Solving', 'space_heavy', 4, N'Find the ROOT CAUSE of a problem before jumping to a solution.', 0);
    SET @cat_probsolve_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_5, N'short_response', N'Problem: ''I keep forgetting my homework.'' What might be the ROOT CAUSE (the real reason), not just the surface problem?', NULL, N'Answers will vary (e.g., no consistent place to put homework, no reminder system).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_5, N'multiple_choice', N'A root cause is different from a symptom because...', N'["The root cause is the underlying reason something keeps happening", "A symptom and a root cause are always the same thing", "Root causes don''t actually matter for solving problems"]', N'The root cause is the underlying reason something keeps happening', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_5, N'short_response', N'Problem: ''Our team keeps missing project deadlines.'' What could be a root cause?', NULL, N'Answers will vary (e.g., unclear roles, no shared timeline, poor communication).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_5, N'multiple_choice', N'Why is finding the root cause BEFORE solving more effective?', N'["A solution aimed at the real cause is more likely to actually fix the problem long-term", "It''s always faster to guess at a solution first", "Root causes are impossible to find"]', N'A solution aimed at the real cause is more likely to actually fix the problem long-term', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_5, N'short_response', N'For the homework problem above, design a solution that targets the ROOT CAUSE, not just the symptom.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_5, N'short_response', N'What questions could you ask yourself to dig down to a root cause (''why'' questions)?', NULL, N'Answers will vary (e.g., asking ''why'' multiple times in a row).', 6);

    DECLARE @cat_probsolve_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'cognitive_skills', N'Problem-Solving', 'space_heavy', 4, N'Work through an engineering-style problem: constraints, plan, test, revise.', 0);
    SET @cat_probsolve_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_6, N'short_response', N'Engineering challenge: design a paper structure that holds a small book off the table. List the CONSTRAINTS (rules/limits) you''d need to follow.', NULL, N'Answers will vary (e.g., limited materials, must not touch the table with the book, etc.).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_probsolve_6, N'short_response', N'Put the engineering design process in order.', NULL, N'Understand, plan, test, revise.', 2, N'sequence_steps', N'{"steps": ["Understand the problem and its constraints", "Plan a possible design", "Build and test the design", "Revise the design based on what you learned"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_6, N'short_response', N'Write your PLAN for the paper-structure challenge before building anything.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_6, N'multiple_choice', N'If your first design fails the test, what should you do?', N'["Revise it based on what you learned and try again", "Give up completely", "Ignore the test result and submit it anyway"]', N'Revise it based on what you learned and try again', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_6, N'short_response', N'What would you TEST to see if your design actually works?', NULL, N'Answers will vary (e.g., does it hold the book''s weight without collapsing?).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_6, N'multiple_choice', N'Why do engineers ''test and revise'' instead of just building one final version?', N'["Testing reveals problems you couldn''t predict just by planning", "The first design is always perfect", "Testing wastes time and should be skipped"]', N'Testing reveals problems you couldn''t predict just by planning', 6);

    DECLARE @cat_probsolve_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'cognitive_skills', N'Problem-Solving', 'space_heavy', 4, N'Plan an independent project: define the problem, plan, execute, and evaluate.', 0);
    SET @cat_probsolve_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_7, N'short_response', N'Choose a real problem you''d like to solve with an independent project. Define it clearly in 1-2 sentences.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_7, N'short_response', N'Write a PLAN: what steps will you take, and in what order?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_7, N'short_response', N'Describe how you would EXECUTE (carry out) your plan.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_7, N'short_response', N'How would you EVALUATE whether your project actually solved the problem?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_7, N'multiple_choice', N'Why is the EVALUATE step often skipped, even though it''s important?', N'["People often feel done once they''ve finished executing, but evaluating shows if it actually worked", "Evaluation doesn''t matter for independent projects", "You should evaluate before you even start"]', N'People often feel done once they''ve finished executing, but evaluating shows if it actually worked', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_probsolve_7, N'short_response', N'If your evaluation showed the project didn''t fully solve the problem, what would you do next?', NULL, N'Answers will vary (e.g., revise the plan and try again).', 6);

    DECLARE @cat_spatial_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'cognitive_skills', N'Spatial Awareness', 'short_answer', 5, NULL, 0);
    SET @cat_spatial_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'multiple_choice', N'Which shape has 3 sides?', N'["Triangle", "Circle", "Square"]', N'Triangle', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'multiple_choice', N'Which shape has 4 equal sides?', N'["Square", "Triangle", "Circle"]', N'Square', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'multiple_choice', N'Which shape is round with no corners?', N'["Circle", "Square", "Triangle"]', N'Circle', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'multiple_choice', N'Which shape has 4 sides but not all equal?', N'["Rectangle", "Circle", "Triangle"]', N'Rectangle', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'matching', N'Match the shape name to how many sides it has.', N'{"left": ["Triangle", "Square", "Circle"], "right": ["3 sides", "4 sides", "0 sides"]}', N'[[0, 0], [1, 1], [2, 2]]', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'short_response', N'Find something in your room shaped like a circle. What is it?', NULL, N'Answers will vary.', 6);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_0, N'multiple_choice', N'A puzzle piece that fits in a round hole is probably shaped like a...', N'["Circle", "Square", "Triangle"]', N'Circle', 7);

    DECLARE @cat_spatial_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'cognitive_skills', N'Spatial Awareness', 'short_answer', 4, N'Follow a simple picture map using left, right, up, and down.', 0);
    SET @cat_spatial_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_1, N'multiple_choice', N'To go from the door to the window, you walk up and then...', N'["Right", "Down", "Backward"]', N'Right', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_1, N'multiple_choice', N'If the treasure is UP and to the LEFT of the start, which direction do you go first?', N'["Up", "Down", "Right"]', N'Up', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_1, N'short_response', N'Draw a simple map of your bedroom with at least 3 objects labeled.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_1, N'multiple_choice', N'On a map, which direction is usually toward the top of the page?', N'["Up / North", "Down / South", "Sideways"]', N'Up / North', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_1, N'short_response', N'Give a friend directions from your classroom door to your desk, using left/right/up/down words.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_1, N'multiple_choice', N'Why are maps useful?', N'["They help you find your way to a place", "They tell you the weather", "They''re only used for treasure hunts"]', N'They help you find your way to a place', 6);

    DECLARE @cat_spatial_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'cognitive_skills', N'Spatial Awareness', 'short_answer', 4, N'Use coordinates to find the spot on a simple grid.', 0);
    SET @cat_spatial_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_spatial_2, N'fill_blank', N'On the grid, what is at this point?', NULL, N'A star', 1, N'coordinate_point', N'{"x": 3, "y": 2}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_spatial_2, N'fill_blank', N'On the grid, what is at this point?', NULL, N'A house', 2, N'coordinate_point', N'{"x": 1, "y": 4}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_2, N'short_response', N'If a treasure is at point (2, 5), how would you describe getting there from (0, 0)?', NULL, N'Go right 2 and up 5.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_2, N'multiple_choice', N'On a coordinate grid, the FIRST number tells you...', N'["How far to move right (across)", "How far to move up (vertically)", "The color of the point"]', N'How far to move right (across)', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_2, N'short_response', N'Plot and label a point at (4, 3) on your own grid paper.', NULL, N'Answers will vary — should show a point 4 across, 3 up.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_2, N'multiple_choice', N'Why do maps and games use coordinate grids?', N'["They give an exact, reliable way to describe a location", "They make locations harder to find", "Grids are only used in math class"]', N'They give an exact, reliable way to describe a location', 6);

    DECLARE @cat_spatial_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'cognitive_skills', N'Spatial Awareness', 'space_heavy', 4, N'Read a simple classroom or neighborhood map and answer questions about it.', 0);
    SET @cat_spatial_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_3, N'short_response', N'Imagine a map of your classroom. Describe the path from the door to the teacher''s desk.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_3, N'multiple_choice', N'A map KEY (or legend) is used to...', N'["Explain what symbols on the map mean", "Lock the map so no one can read it", "Show the exact temperature"]', N'Explain what symbols on the map mean', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_3, N'short_response', N'Draw a simple map of your neighborhood (or a route you know well) with at least 4 labeled landmarks.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_3, N'multiple_choice', N'If two routes on a map lead to the same place, how could you tell which is shorter?', N'["Compare the distances shown or count grid squares along each route", "Always pick the one that looks prettier", "Routes are always the exact same length"]', N'Compare the distances shown or count grid squares along each route', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_3, N'short_response', N'Why might a map use symbols instead of writing out every single word?', NULL, N'Symbols are quicker to read and take up less space.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_3, N'multiple_choice', N'Reading a map accurately mostly requires...', N'["Understanding scale, direction, and symbols together", "Only knowing the colors used", "Ignoring the map key"]', N'Understanding scale, direction, and symbols together', 6);

    DECLARE @cat_spatial_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'cognitive_skills', N'Spatial Awareness', 'short_answer', 4, N'Find the area and perimeter of shapes drawn on a grid.', 0);
    SET @cat_spatial_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_spatial_4, N'fill_blank', N'A rectangle is 5 units wide and 3 units tall. What is its AREA?', NULL, N'15 square units', 1, N'rectangle_dims', N'{"width": 5, "height": 3}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_spatial_4, N'fill_blank', N'A rectangle is 5 units wide and 3 units tall. What is its PERIMETER?', NULL, N'16 units', 2, N'rectangle_dims', N'{"width": 5, "height": 3}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_spatial_4, N'fill_blank', N'A rectangle is 6 units wide and 2 units tall. What is its AREA?', NULL, N'12 square units', 3, N'rectangle_dims', N'{"width": 6, "height": 2}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_4, N'multiple_choice', N'AREA measures...', N'["The space INSIDE a shape", "The distance AROUND a shape", "Only the width of a shape"]', N'The space INSIDE a shape', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_4, N'multiple_choice', N'PERIMETER measures...', N'["The distance AROUND a shape", "The space INSIDE a shape", "Only the height of a shape"]', N'The distance AROUND a shape', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_4, N'short_response', N'Draw a rectangle on grid paper that has an area of exactly 20 square units. What are its dimensions?', NULL, N'Answers will vary (e.g., 4x5, 2x10).', 6);

    DECLARE @cat_spatial_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'cognitive_skills', N'Spatial Awareness', 'short_answer', 4, N'Plot and interpret points on a full coordinate plane.', 0);
    SET @cat_spatial_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_spatial_5, N'fill_blank', N'Plot this point. What quadrant is it in if both x and y are positive?', NULL, N'Quadrant I', 1, N'coordinate_point', N'{"x": 4, "y": 3}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_5, N'short_response', N'Plot the points (2,2), (2,5), (6,5), (6,2) and connect them in order. What shape do you get?', NULL, N'A rectangle.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_5, N'multiple_choice', N'A point at (-3, 4) is located...', N'["Left of center and above center", "Right of center and above center", "Exactly at the center"]', N'Left of center and above center', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_5, N'short_response', N'Why is a coordinate plane useful for describing exact locations in math and mapping?', NULL, N'It gives every point a unique, precise address using two numbers.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_5, N'fill_blank', N'What are the coordinates of a point 5 to the right and 2 down from the origin?', NULL, N'(5, -2)', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_5, N'multiple_choice', N'The x-axis and y-axis meet at a point called the...', N'["Origin", "Endpoint", "Vertex"]', N'Origin', 6);

    DECLARE @cat_spatial_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'cognitive_skills', N'Spatial Awareness', 'space_heavy', 4, N'Create a scale drawing or floor plan of a real or imagined room.', 0);
    SET @cat_spatial_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_6, N'short_response', N'If 1 inch on your drawing = 2 feet in real life, and a wall is 12 feet long, how many inches would you draw it?', NULL, N'6 inches (12 / 2 = 6).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_6, N'short_response', N'Design a simple scale floor plan for a bedroom, labeling the scale you used.', NULL, N'Answers will vary — must include a clearly stated scale.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_6, N'multiple_choice', N'A scale drawing is useful because...', N'["It represents something large accurately in a smaller, manageable size", "It''s always exactly the same size as the real object", "Scale doesn''t matter for floor plans"]', N'It represents something large accurately in a smaller, manageable size', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_6, N'short_response', N'If your scale is 1 inch = 3 feet, how long (in real feet) is a piece of furniture drawn as 2 inches?', NULL, N'6 feet.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_6, N'multiple_choice', N'Without a stated scale, a floor plan is...', N'["Hard to interpret accurately, since sizes aren''t clear", "Just as useful as one with a scale", "Automatically assumed to be full-size"]', N'Hard to interpret accurately, since sizes aren''t clear', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_6, N'short_response', N'Why do architects and engineers rely on scale drawings instead of full-size sketches?', NULL, N'Answers will vary (e.g., real buildings are too big to draw at full size).', 6);

    DECLARE @cat_spatial_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'cognitive_skills', N'Spatial Awareness', 'space_heavy', 4, N'Fold a 3D net and estimate the volume of the resulting shape.', 0);
    SET @cat_spatial_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_7, N'short_response', N'A net is a flat 2D pattern that folds into a 3D shape. Describe what net you''d need to fold to make a cube.', NULL, N'6 equal squares connected in a cross or row pattern.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_7, N'fill_blank', N'A rectangular box is 4 units long, 3 units wide, and 2 units tall. What is its VOLUME?', NULL, N'24 cubic units', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_7, N'multiple_choice', N'Volume measures...', N'["How much space is INSIDE a 3D shape", "The distance around the outside", "Only the height of the shape"]', N'How much space is INSIDE a 3D shape', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_7, N'short_response', N'If you doubled the height of the box above (to 4 units), what would the new volume be?', NULL, N'48 cubic units (4 x 3 x 4).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_7, N'multiple_choice', N'Why is folding a net a good way to understand 3D shapes?', N'["It shows how flat faces connect to build a solid shape", "Nets have nothing to do with 3D shapes", "It''s only useful for paper crafts"]', N'It shows how flat faces connect to build a solid shape', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_spatial_7, N'short_response', N'Estimate the volume of a real box near you (a cereal box, a drawer) by measuring its length, width, and height.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'cognitive_skills', N'Metacognition', 'short_answer', 4, NULL, 0);
    SET @cat_metacog_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_0, N'short_response', N'What helped you learn something new today?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_0, N'short_response', N'What was your favorite thing you did today?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_0, N'multiple_choice', N'If something is tricky, what can you do?', N'["Try again or ask for help", "Give up right away", "Get mad and stop"]', N'Try again or ask for help', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_0, N'short_response', N'Draw a sticker star for something you''re proud of learning today.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_0, N'multiple_choice', N'Thinking about how you learn is called...', N'["Metacognition", "Recess", "Snack time"]', N'Metacognition', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_0, N'short_response', N'Who helped you today, and how?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'cognitive_skills', N'Metacognition', 'short_answer', 4, N'Fill in what you learned and what you liked.', 0);
    SET @cat_metacog_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_1, N'short_response', N'Complete: ''Today I learned...''', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_1, N'short_response', N'Complete: ''Today I liked...''', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_1, N'multiple_choice', N'Why is it helpful to think about what you learned each day?', N'["It helps you remember and notice your own progress", "It doesn''t help at all", "It''s only for teachers to know, not you"]', N'It helps you remember and notice your own progress', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_1, N'short_response', N'What is something that was HARD today, and what helped (or would help) with it?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_1, N'multiple_choice', N'If you liked an activity today, that''s a clue that...', N'["You might enjoy learning that way again", "You should never do anything else", "It has nothing to do with how you learn"]', N'You might enjoy learning that way again', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_1, N'short_response', N'What do you want to learn about tomorrow?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'cognitive_skills', N'Metacognition', 'short_answer', 4, N'Check off how you learn best: by seeing, hearing, or doing.', 0);
    SET @cat_metacog_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_2, N'multiple_choice', N'If you remember things best by looking at pictures or charts, you might be a...', N'["See (visual) learner", "Hear (auditory) learner", "Do (hands-on) learner"]', N'See (visual) learner', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_2, N'multiple_choice', N'If you remember things best by listening, you might be a...', N'["Hear (auditory) learner", "See (visual) learner", "Do (hands-on) learner"]', N'Hear (auditory) learner', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_2, N'multiple_choice', N'If you remember things best by trying it yourself, you might be a...', N'["Do (hands-on) learner", "See (visual) learner", "Hear (auditory) learner"]', N'Do (hands-on) learner', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_2, N'short_response', N'Which learning style (see/hear/do) do YOU think fits you best? Give an example.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_2, N'multiple_choice', N'Knowing your learning style can help you...', N'["Choose study methods that work better for you", "Force yourself to learn only one way forever", "Nothing — learning style doesn''t matter"]', N'Choose study methods that work better for you', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_2, N'short_response', N'Name one activity at school that matches your learning style.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'cognitive_skills', N'Metacognition', 'short_answer', 4, N'Self-rate a recent task: what was easy, what was hard, and why.', 0);
    SET @cat_metacog_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_3, N'short_response', N'Think of a recent school task. Rate it: easy, medium, or hard — and explain why.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_3, N'short_response', N'What made the hardest PART of that task difficult?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_3, N'multiple_choice', N'Rating a task as ''hard'' mainly helps you...', N'["Notice where you might need more practice or a different strategy", "Feel bad about yourself", "Avoid that subject forever"]', N'Notice where you might need more practice or a different strategy', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_3, N'short_response', N'What strategy could make that hard part easier next time?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_3, N'multiple_choice', N'Something that feels ''easy'' for you might feel ''hard'' for someone else because...', N'["Everyone has different strengths and past practice", "Easy and hard mean the exact same thing for everyone", "Only some people are capable of learning"]', N'Everyone has different strengths and past practice', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_3, N'short_response', N'What is something that used to be hard for you but feels easy now? What changed?', NULL, N'Answers will vary (e.g., practice, a new strategy).', 6);

    DECLARE @cat_metacog_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'cognitive_skills', N'Metacognition', 'space_heavy', 4, N'Keep a study strategy log: track which methods actually worked.', 0);
    SET @cat_metacog_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_4, N'short_response', N'List 2 study strategies you''ve tried (flashcards, reading aloud, quizzing yourself, etc.).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_4, N'short_response', N'Which of those strategies worked BETTER for you, and how do you know?', NULL, N'Answers will vary — should reference an actual result, like a quiz score or how well they remembered.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_4, N'multiple_choice', N'A study strategy log is useful because...', N'["It helps you notice patterns in what actually works for you over time", "It''s just extra homework with no real purpose", "All strategies work exactly the same for everyone"]', N'It helps you notice patterns in what actually works for you over time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_4, N'short_response', N'What''s one NEW study strategy you haven''t tried yet that you''d like to test?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_4, N'multiple_choice', N'How can you tell if a study strategy ''worked''?', N'["You remembered or understood the material better afterward", "It felt easy in the moment, regardless of the result", "The strategy took a long time to do"]', N'You remembered or understood the material better afterward', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_4, N'short_response', N'Design a simple study strategy log format you could use for your next test.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'cognitive_skills', N'Metacognition', 'space_heavy', 4, N'Set a learning goal, and check your progress toward it.', 0);
    SET @cat_metacog_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_5, N'short_response', N'Write one specific learning goal for this month (e.g., ''Get faster at multiplication facts'').', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_5, N'short_response', N'How will you know if you''ve made progress toward this goal?', NULL, N'Answers will vary (e.g., timed quiz scores improving).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_5, N'multiple_choice', N'A good learning goal should be...', N'["Specific and something you can actually measure progress on", "Vague, like ''get smarter''", "Impossible to ever check"]', N'Specific and something you can actually measure progress on', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_5, N'short_response', N'What is ONE action you''ll take this week toward your goal?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_5, N'multiple_choice', N'If you check your progress and you''re behind on your goal, what should you do?', N'["Adjust your plan or effort, not give up on the goal", "Immediately give up on the goal entirely", "Ignore the check-in and hope it fixes itself"]', N'Adjust your plan or effort, not give up on the goal', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_5, N'short_response', N'How will you celebrate or acknowledge it when you reach your goal?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'cognitive_skills', N'Metacognition', 'space_heavy', 4, N'Reflect on a mistake: what strategy will you try differently next time?', 0);
    SET @cat_metacog_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_6, N'short_response', N'Describe a recent mistake you made on an assignment or test.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_6, N'short_response', N'What do you think CAUSED the mistake (rushing, misunderstanding, not studying a certain part, etc.)?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_6, N'multiple_choice', N'Reflecting on a mistake is most useful when it leads to...', N'["A specific strategy you''ll try differently next time", "Feeling bad about yourself with no plan to improve", "Blaming the mistake on bad luck"]', N'A specific strategy you''ll try differently next time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_6, N'short_response', N'What SPECIFIC strategy will you try next time to avoid a similar mistake?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_6, N'multiple_choice', N'Which mindset helps you learn more from mistakes?', N'["''Mistakes show me what to work on next.''", "''Mistakes mean I''m just bad at this.''", "''Mistakes should never happen and mean I should quit.''"]', N'''Mistakes show me what to work on next.''', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_6, N'short_response', N'Has a mistake ever taught you something you still use today? Explain.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_metacog_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'cognitive_skills', N'Metacognition', 'space_heavy', 4, N'Design a personal study plan for an upcoming test.', 0);
    SET @cat_metacog_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_7, N'short_response', N'List the topics you''ll need to study for your next test.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_7, N'short_response', N'Write a study SCHEDULE — which topic on which day, leading up to the test.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_7, N'multiple_choice', N'A good study plan should account for...', N'["Which topics you find hardest, giving them more time", "Equal time for every topic no matter how well you know it", "Cramming everything the night before"]', N'Which topics you find hardest, giving them more time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_7, N'short_response', N'What study strategies will you use for your hardest topic, based on what''s worked for you before?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_7, N'multiple_choice', N'Why plan study time across several days instead of one long session?', N'["Spacing out study helps you remember material better over time", "One long session is always more effective", "It doesn''t matter how you space out studying"]', N'Spacing out study helps you remember material better over time', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_metacog_7, N'short_response', N'How will you check, a few days before the test, whether your plan is actually working?', NULL, N'Answers will vary (e.g., a practice quiz).', 6);

    DECLARE @cat_designthink_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'cognitive_skills', N'Design Thinking & Innovation', 'short_answer', 4, NULL, 0);
    SET @cat_designthink_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_0, N'short_response', N'Silly problem: your ice cream keeps melting too fast! Draw or describe a solution.', NULL, N'Answers will vary (e.g., an ice cream hat, a cold lunchbox).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_0, N'short_response', N'Silly problem: your shoes keep untying themselves. Draw or describe a solution.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_0, N'multiple_choice', N'Inventing a solution to a problem is called...', N'["Design thinking", "Sleeping", "Forgetting"]', N'Design thinking', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_0, N'short_response', N'What is one problem YOU wish had a solution?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_0, N'multiple_choice', N'A silly or fun idea can still be...', N'["A helpful step toward a real solution", "Never useful at all", "Against the rules of design"]', N'A helpful step toward a real solution', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_0, N'short_response', N'Draw your silly-problem solution and give it a fun name.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_designthink_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'cognitive_skills', N'Design Thinking & Innovation', 'short_answer', 4, N'Invent a helper tool to solve a problem.', 0);
    SET @cat_designthink_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_1, N'short_response', N'Invent a tool that would help you clean up toys faster. Draw or describe it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_1, N'short_response', N'Invent a tool that would help you reach something high up. Draw or describe it.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_1, N'multiple_choice', N'A ''helper tool'' is designed to...', N'["Make a task easier or faster", "Make a task harder", "Look nice but do nothing"]', N'Make a task easier or faster', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_1, N'short_response', N'Give your invented tool a name.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_1, N'multiple_choice', N'Why do inventors think about a REAL problem before designing a tool?', N'["So the tool actually helps with something people need", "The problem doesn''t matter, only the tool''s looks", "Inventors never think about problems first"]', N'So the tool actually helps with something people need', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_1, N'short_response', N'What would your tool be made of?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_designthink_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'cognitive_skills', N'Design Thinking & Innovation', 'short_answer', 4, N'Redesign an everyday object to make it better.', 0);
    SET @cat_designthink_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_2, N'short_response', N'Pick an everyday object (backpack, water bottle, umbrella). What''s one thing that could be improved about it?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_2, N'short_response', N'Redesign it: describe or draw your improved version.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_2, N'multiple_choice', N'A good redesign should...', N'["Solve a real annoyance or problem with the original", "Change something that was already working perfectly", "Make the object harder to use"]', N'Solve a real annoyance or problem with the original', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_2, N'short_response', N'Who would benefit most from your redesigned object?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_2, N'multiple_choice', N'Why is ''redesigning'' a useful skill, not just ''inventing something totally new''?', N'["Small improvements to existing things can solve real problems too", "Redesigning is not a real form of innovation", "Only brand-new inventions count as innovation"]', N'Small improvements to existing things can solve real problems too', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_2, N'short_response', N'What materials would your redesigned object need?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_designthink_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'cognitive_skills', N'Design Thinking & Innovation', 'space_heavy', 4, N'Practice the design thinking mini-process: empathize, ideate, prototype.', 0);
    SET @cat_designthink_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_3, N'short_response', N'EMPATHIZE: pick a person (a classmate, a parent) and describe a problem they deal with.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_3, N'short_response', N'IDEATE: brainstorm 2 different ideas that could help solve their problem.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_3, N'short_response', N'PROTOTYPE: describe (or sketch) a simple first version of your best idea.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_designthink_3, N'short_response', N'Put the design thinking mini-process in order.', NULL, N'Empathize, ideate, prototype.', 4, N'sequence_steps', N'{"steps": ["Empathize — understand the person and their problem", "Ideate — brainstorm possible solutions", "Prototype — build a simple first version"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_3, N'multiple_choice', N'Why does design thinking START with empathizing, not ideating?', N'["You need to truly understand the problem before you can solve it well", "Empathizing wastes time and should be skipped", "Ideas are always better without understanding the user first"]', N'You need to truly understand the problem before you can solve it well', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_3, N'short_response', N'What would you ask the person from your EMPATHIZE step to find out if your prototype actually helps them?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_designthink_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'cognitive_skills', N'Design Thinking & Innovation', 'space_heavy', 4, N'Design a product with a specific target user in mind.', 0);
    SET @cat_designthink_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_4, N'short_response', N'Choose a target user (e.g., ''kids who forget their homework''). What product could help them?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_4, N'short_response', N'Describe your product''s main feature and how it solves the user''s problem.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_4, N'multiple_choice', N'Designing ''for a target user'' means...', N'["Making choices based on that specific group''s needs", "Trying to please absolutely everyone at once", "Ignoring who will actually use the product"]', N'Making choices based on that specific group''s needs', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_4, N'short_response', N'What is one feature your target user would care about most, and why?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_4, N'multiple_choice', N'Why might a product designed for EVERYONE end up not working great for ANYONE?', N'["Trying to meet every need at once often means meeting none of them well", "Products for everyone always work best", "Target users don''t actually matter in design"]', N'Trying to meet every need at once often means meeting none of them well', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_4, N'short_response', N'How would you find out if your target user actually likes your product idea?', NULL, N'Answers will vary (e.g., ask them, show a sketch and get feedback).', 6);

    DECLARE @cat_designthink_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'cognitive_skills', N'Design Thinking & Innovation', 'space_heavy', 4, N'Write a lemonade-stand style business plan.', 0);
    SET @cat_designthink_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_5, N'short_response', N'What product or service would your stand sell?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_5, N'short_response', N'Who is your target customer, and why would they want to buy from you?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_5, N'short_response', N'List your estimated costs (supplies) and your planned price per item.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_5, N'multiple_choice', N'A basic business plan should answer...', N'["What you sell, who buys it, and how you''ll make more than you spend", "Only what color your sign will be", "Nothing about cost or customers"]', N'What you sell, who buys it, and how you''ll make more than you spend', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_5, N'short_response', N'What would make a customer choose YOUR stand over a similar one nearby?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_5, N'multiple_choice', N'Why is it useful to estimate costs BEFORE you start selling?', N'["So you can set a price that actually earns you money", "Costs don''t matter until after you''ve sold things", "You should never think about money in advance"]', N'So you can set a price that actually earns you money', 6);

    DECLARE @cat_designthink_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'cognitive_skills', N'Design Thinking & Innovation', 'space_heavy', 4, N'Build a prototype idea and describe how you''d use peer feedback to improve it.', 0);
    SET @cat_designthink_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_6, N'short_response', N'Describe a prototype (a simple first version) of an idea you''d like to build.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_6, N'short_response', N'Write 2 specific questions you''d ask a peer to get useful feedback on your prototype.', NULL, N'Answers will vary (e.g., ''What part was confusing?'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_6, N'multiple_choice', N'Useful peer feedback questions are usually...', N'["Specific, so the answers give you something actionable", "Vague, like ''do you like it?''", "Unnecessary — feedback never helps"]', N'Specific, so the answers give you something actionable', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_6, N'short_response', N'Imagine a peer said your prototype was ''confusing to use.'' What would you ask next to understand why?', NULL, N'Answers will vary (e.g., ''Which part specifically was confusing?'').', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_6, N'multiple_choice', N'Getting feedback BEFORE building a final version helps you...', N'["Fix problems while changes are still easy to make", "Waste time that could be spent building", "Avoid ever having to make changes"]', N'Fix problems while changes are still easy to make', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_6, N'short_response', N'How would you revise your prototype based on feedback you imagine receiving?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_designthink_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'cognitive_skills', N'Design Thinking & Innovation', 'space_heavy', 4, N'Prepare a short pitch: problem, solution, audience, next steps.', 0);
    SET @cat_designthink_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_7, N'short_response', N'PROBLEM: state the problem your idea solves in one clear sentence.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_7, N'short_response', N'SOLUTION: describe your solution in one or two sentences.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_7, N'short_response', N'AUDIENCE: who specifically needs this solution, and why do they need it?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_7, N'short_response', N'NEXT STEPS: what would you do first if you got the chance to actually build this?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_7, N'multiple_choice', N'A strong pitch is mainly judged by...', N'["How clearly it explains the problem and why the solution matters", "How long it is", "How many big words it uses"]', N'How clearly it explains the problem and why the solution matters', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_designthink_7, N'multiple_choice', N'Why include ''next steps'' at the end of a pitch?', N'["It shows you''ve thought beyond just the idea, toward actually doing it", "Next steps are unnecessary in a pitch", "It should be the very first thing you say"]', N'It shows you''ve thought beyond just the idea, toward actually doing it', 6);

END
GO

-- Force existing WeeklyPacketPlans to regenerate under the new rotation +
-- content (matches precedent in 60/61/62).
DELETE FROM dbo.WeeklyPacketPlan;
GO