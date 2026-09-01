-- 65_life_health_content.sql
-- Whole-Child Curriculum expansion, batch 2: content for the 'life_skills'
-- (Digital Literacy, Financial Literacy, Time Management, Organization) and
-- 'health' (Anatomy, Food & Healthy Eating, Exercise & Fitness, Physical Game
-- Instruction) subject_area groups, hand-crafted across all 8 grades from the
-- curriculum matrix the site owner provided. Requires 63_whole_child_rotation.sql
-- (schema/rotation) to already be applied. See gen_65_life_health_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'life_skills')
BEGIN
    DECLARE @cat_digital_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'life_skills', N'Digital Literacy & Online Safety', 'short_answer', 4, NULL, 0);
    SET @cat_digital_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_0, N'multiple_choice', N'How much screen time is a good amount each day?', N'["A little bit, with a grown-up''s okay", "As much as you want", "All day long"]', N'A little bit, with a grown-up''s okay', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_0, N'multiple_choice', N'Before using a screen, you should...', N'["Ask a grown-up first", "Just start using it", "Hide it from grown-ups"]', N'Ask a grown-up first', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_0, N'short_response', N'Draw or tell: what is your favorite thing to do on a screen?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_0, N'multiple_choice', N'If a screen shows something scary, what should you do?', N'["Tell a grown-up right away", "Keep watching alone", "Hide it"]', N'Tell a grown-up right away', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_0, N'short_response', N'Name one rule your family has about screens.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_0, N'multiple_choice', N'Screens are a tool that should be used...', N'["With grown-up help and limits", "Without any rules", "Only at night"]', N'With grown-up help and limits', 6);

    DECLARE @cat_digital_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'life_skills', N'Digital Literacy & Online Safety', 'short_answer', 4, NULL, 0);
    SET @cat_digital_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_1, N'multiple_choice', N'If something online confuses or worries you, who should you ask?', N'["A grown-up you trust", "A stranger online", "No one"]', N'A grown-up you trust', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_1, N'multiple_choice', N'It''s safe to click on any colorful button online.', N'["False — always check with a grown-up first", "True — colorful buttons are always safe", "It doesn''t matter"]', N'False — always check with a grown-up first', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_1, N'short_response', N'Color or describe a safety poster reminding kids to ''ask a grown-up'' before going online.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_1, N'multiple_choice', N'If a pop-up says you WON a prize, you should...', N'["Close it and tell a grown-up", "Click it right away", "Enter all your information"]', N'Close it and tell a grown-up', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_1, N'short_response', N'Why is it important to ask a grown-up before downloading a game or app?', NULL, N'Grown-ups can check that it''s safe and appropriate.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_1, N'multiple_choice', N'A trusted grown-up online is someone who...', N'["You also know and trust in real life", "Just says they''re nice", "You met only through a game"]', N'You also know and trust in real life', 6);

    DECLARE @cat_digital_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'life_skills', N'Digital Literacy & Online Safety', 'short_answer', 4, N'Sort each website or app example as SAFE or UNSAFE for kids.', 0);
    SET @cat_digital_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_2, N'matching', N'Sort each example.', N'{"left": ["A learning game your teacher assigned", "A site asking for your home address", "An app your parent downloaded for you", "A pop-up asking you to ''chat'' with a stranger"], "right": ["Safe", "Unsafe", "Safe", "Unsafe"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_2, N'multiple_choice', N'A safe website for kids is usually one that...', N'["A trusted adult approved or set up for you", "Has a fun-looking cartoon on it", "Doesn''t ask you to type anything"]', N'A trusted adult approved or set up for you', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_2, N'short_response', N'What is one warning sign that a website might not be safe?', NULL, N'Answers will vary (e.g., asking for personal info, strangers messaging you).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_2, N'short_response', N'Why should you never share your home address online?', NULL, N'Strangers could find out where you live, which isn''t safe.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_2, N'multiple_choice', N'If a website asks for your last name and address to ''play a game,'' you should...', N'["Not enter it and tell a grown-up", "Enter it so you can play", "Make up a fake one"]', N'Not enter it and tell a grown-up', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_2, N'short_response', N'Name one website or app you use that you think is safe, and explain why.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_digital_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'life_skills', N'Digital Literacy & Online Safety', 'short_answer', 4, N'Learn how to keep passwords and personal information safe.', 0);
    SET @cat_digital_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_3, N'multiple_choice', N'A strong password should...', N'["Mix letters, numbers, and be hard to guess", "Be your name spelled backward", "Be ''password123''"]', N'Mix letters, numbers, and be hard to guess', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_3, N'multiple_choice', N'You should share your password with...', N'["Only a parent/guardian, if needed", "All your friends", "Anyone who asks nicely"]', N'Only a parent/guardian, if needed', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_3, N'short_response', N'List 3 pieces of personal information you should NEVER share online without a grown-up''s help.', NULL, N'Answers will vary (e.g., full name, address, school name, phone number).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_3, N'multiple_choice', N'Why shouldn''t you use the same password for everything?', N'["If one account gets hacked, others could be at risk too", "It''s more convenient and has no downside", "Passwords don''t actually matter"]', N'If one account gets hacked, others could be at risk too', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_3, N'short_response', N'Why might it be tempting to share personal info to ''win a prize'' online, and why is that risky?', NULL, N'It feels exciting, but real companies rarely ask for personal info that way — it''s often a scam.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_3, N'multiple_choice', N'If a game asks for your parent''s credit card number, you should...', N'["Stop and ask a grown-up first", "Enter it to keep playing", "Guess a random number"]', N'Stop and ask a grown-up first', 6);

    DECLARE @cat_digital_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'life_skills', N'Digital Literacy & Online Safety', 'space_heavy', 4, N'Learn to spot the warning signs of a scam or phishing email.', 0);
    SET @cat_digital_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_4, N'short_response', N'Example email: ''You''ve WON $1,000! Click here NOW and enter your bank info to claim it!'' What makes this look like a scam?', NULL, N'Urgency, promises of free money, and asking for bank info are classic scam signs.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_4, N'multiple_choice', N'A phishing email often tries to make you feel...', N'["Rushed or excited so you don''t think carefully", "Calm and unhurried", "Bored"]', N'Rushed or excited so you don''t think carefully', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_4, N'short_response', N'List 3 warning signs of a scam or phishing message.', NULL, N'Answers will vary (e.g., urgent language, asking for personal info, too-good-to-be-true offers, weird sender address).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_4, N'multiple_choice', N'If you get a suspicious email, the safest first step is to...', N'["Not click any links and tell a trusted adult", "Reply asking if it''s real", "Click the link to investigate"]', N'Not click any links and tell a trusted adult', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_4, N'short_response', N'Why do scammers often pretend to be someone official, like a bank or a prize company?', NULL, N'People are more likely to trust and respond to messages that seem official.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_4, N'multiple_choice', N'A real company asking for your password by email is a...', N'["Red flag — real companies rarely ask this way", "Normal, safe request", "Required legal process"]', N'Red flag — real companies rarely ask this way', 6);

    DECLARE @cat_digital_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'life_skills', N'Digital Literacy & Online Safety', 'space_heavy', 4, N'Reflect on your digital footprint — what your online activity says about you.', 0);
    SET @cat_digital_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_5, N'short_response', N'What is a ''digital footprint''? Explain in your own words.', NULL, N'The trail of information about you left behind by your online activity.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_5, N'short_response', N'Name one thing you''ve posted or shared online (or would want to) — is it something you''d be okay with a future teacher or employer seeing?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_5, N'multiple_choice', N'Which is TRUE about digital footprints?', N'["Things posted online can be hard to fully delete later", "Everything posted online disappears after a day", "Digital footprints don''t matter for kids"]', N'Things posted online can be hard to fully delete later', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_5, N'short_response', N'Why might it matter what you post online, even years from now?', NULL, N'Future schools, employers, or others might see old posts, so it''s worth being thoughtful.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_5, N'multiple_choice', N'A helpful rule of thumb before posting something is to ask...', N'["''Would I be okay with anyone seeing this?''", "''Will this get the most likes?''", "''Can I delete this in 5 seconds if I want?''"]', N'''Would I be okay with anyone seeing this?''', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_5, N'short_response', N'What''s one change you could make to keep your digital footprint more positive?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_digital_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'life_skills', N'Digital Literacy & Online Safety', 'space_heavy', 4, N'Practice evaluating whether a website is credible (trustworthy).', 0);
    SET @cat_digital_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_6, N'short_response', N'List 3 things you''d check to decide if a website is credible.', NULL, N'Answers will vary (e.g., author/source listed, recent date, matches other trusted sources, not full of ads/errors).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_6, N'multiple_choice', N'A credible website usually...', N'["Clearly states its author or organization and sources", "Has no information about who wrote it", "Uses only ALL CAPS and exclamation points"]', N'Clearly states its author or organization and sources', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_6, N'short_response', N'Why is it risky to trust a claim from just ONE website without checking elsewhere?', NULL, N'That one source could be biased, outdated, or simply wrong.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_6, N'multiple_choice', N'Which is a red flag for a website''s credibility?', N'["No sources, extreme claims, or a strange web address", "A clearly listed publish date", "Links to other reputable sources"]', N'No sources, extreme claims, or a strange web address', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_6, N'short_response', N'Pick a topic you''re curious about. What would you check before trusting a website''s claim about it?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_6, N'multiple_choice', N'Checking a website''s credibility is most important when...', N'["Using the information for something important, like a report or a decision", "Just glancing at a meme", "Never — credibility doesn''t matter"]', N'Using the information for something important, like a report or a decision', 6);

    DECLARE @cat_digital_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'life_skills', N'Digital Literacy & Online Safety', 'space_heavy', 4, N'Identify and respond to a cyberbullying scenario.', 0);
    SET @cat_digital_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_7, N'short_response', N'Scenario: someone keeps sending a classmate mean messages in a group chat. Is this cyberbullying? Explain.', NULL, N'Yes — repeated, intentional mean messages online is cyberbullying.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_7, N'short_response', N'What should the classmate being targeted do first?', NULL, N'Save evidence, don''t respond with more meanness, and tell a trusted adult.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_7, N'multiple_choice', N'If you SEE cyberbullying happening to someone else, a helpful response is to...', N'["Support the person being targeted and tell a trusted adult", "Join in so you''re not the target", "Ignore it completely, it''s not your problem"]', N'Support the person being targeted and tell a trusted adult', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_7, N'short_response', N'Why might someone cyberbully others online more than they would in person?', NULL, N'Answers will vary (e.g., feeling anonymous or less accountable behind a screen).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_7, N'multiple_choice', N'Which is the BEST first step if you''re being cyberbullied?', N'["Don''t respond, save the evidence, and tell a trusted adult", "Respond with an even meaner message", "Delete the app and never mention it"]', N'Don''t respond, save the evidence, and tell a trusted adult', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_digital_7, N'short_response', N'What''s one way schools or families could help prevent cyberbullying?', NULL, N'Answers will vary (e.g., clear rules, open communication, teaching empathy online).', 6);

    DECLARE @cat_finance_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'life_skills', N'Financial Literacy', 'short_answer', 4, NULL, 0);
    SET @cat_finance_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_0, N'multiple_choice', N'Which coin is the penny?', N'["1 cent", "5 cents", "10 cents"]', N'1 cent', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_0, N'multiple_choice', N'Which coin is the nickel?', N'["5 cents", "1 cent", "25 cents"]', N'5 cents', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_0, N'multiple_choice', N'Which coin is the dime?', N'["10 cents", "5 cents", "25 cents"]', N'10 cents', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_0, N'multiple_choice', N'Which coin is the quarter?', N'["25 cents", "10 cents", "1 cent"]', N'25 cents', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_0, N'matching', N'Match the coin name to its value.', N'{"left": ["Penny", "Nickel", "Dime", "Quarter"], "right": ["1¢", "5¢", "10¢", "25¢"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_0, N'short_response', N'Sort some real or pretend coins from smallest value to largest.', NULL, N'Penny, nickel, dime, quarter.', 6);

    DECLARE @cat_finance_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'life_skills', N'Financial Literacy', 'short_answer', 4, N'Sort each item as a NEED or a WANT.', 0);
    SET @cat_finance_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_1, N'matching', N'Sort each item.', N'{"left": ["Food", "A new toy", "A warm coat", "Video games"], "right": ["Need", "Want", "Need", "Want"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_1, N'multiple_choice', N'A NEED is something...', N'["You must have to live and be healthy", "That''s just fun to have", "You always get for free"]', N'You must have to live and be healthy', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_1, N'multiple_choice', N'A WANT is something...', N'["Nice to have but not required", "You must have to survive", "The same thing as a need"]', N'Nice to have but not required', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_1, N'short_response', N'Name one need and one want from your own life.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_1, N'multiple_choice', N'Why is it useful to know the difference between needs and wants?', N'["It helps you make good choices about money and priorities", "It doesn''t matter at all", "Wants are always more important"]', N'It helps you make good choices about money and priorities', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_1, N'short_response', N'Draw or describe a want you''re saving up for.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_finance_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'life_skills', N'Financial Literacy', 'short_answer', 4, N'Set a simple saving goal and track it in a jar.', 0);
    SET @cat_finance_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_2, N'short_response', N'What is something you''d like to save up for? How much does it cost (a guess is fine)?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_2, N'short_response', N'If you save $1 a week, how many weeks would it take to save $5?', NULL, N'5 weeks.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_2, N'multiple_choice', N'Saving money means...', N'["Putting money aside instead of spending it right away", "Spending all your money immediately", "Giving your money away"]', N'Putting money aside instead of spending it right away', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_2, N'short_response', N'Draw a saving jar and mark how full it would be if you''ve saved half of your goal.', NULL, N'Answers will vary — should show the jar about half full.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_2, N'multiple_choice', N'Why might saving a little at a time be easier than saving it all at once?', N'["Small amounts add up over time and are easier to manage", "It''s actually harder to save a little at a time", "Saving slowly never works"]', N'Small amounts add up over time and are easier to manage', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_2, N'short_response', N'What would you do if you really wanted to spend your savings before reaching your goal?', NULL, N'Answers will vary (e.g., remind yourself of the goal, wait a few days before deciding).', 6);

    DECLARE @cat_finance_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'life_skills', N'Financial Literacy', 'short_answer', 4, N'Practice making change for small purchases.', 0);
    SET @cat_finance_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_3, N'fill_blank', N'You pay with a $1 bill for a $0.75 item. How much change do you get?', NULL, N'$0.25 (25 cents)', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_3, N'fill_blank', N'You pay with a $5 bill for a $3.50 item. How much change do you get?', NULL, N'$1.50', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_3, N'fill_blank', N'An item costs $0.60. You pay with 3 quarters. How much change do you get?', NULL, N'$0.15 (15 cents)', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_3, N'short_response', N'Explain, in your own words, how you figure out how much change to give back.', NULL, N'Subtract the price from the amount paid.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_3, N'multiple_choice', N'Why is it important for a cashier to make change correctly?', N'["So the customer pays the right, fair amount", "Change doesn''t actually matter", "To make the register look full"]', N'So the customer pays the right, fair amount', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_3, N'fill_blank', N'You pay with a $10 bill for a $7.25 item. How much change do you get?', NULL, N'$2.75', 6);

    DECLARE @cat_finance_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'life_skills', N'Financial Literacy', 'space_heavy', 4, N'Build a basic budget for a weekly allowance.', 0);
    SET @cat_finance_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_4, N'short_response', N'If you get $5 allowance a week, write a simple budget: how much would you save, spend, and maybe give?', NULL, N'Answers will vary (e.g., $2 save, $2 spend, $1 give).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_4, N'multiple_choice', N'A budget is...', N'["A plan for how you''ll use your money", "A list of things you want to buy", "The total amount of money you have"]', N'A plan for how you''ll use your money', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_4, N'short_response', N'Why might it be smart to plan your budget BEFORE you get your allowance, not after you''ve already spent it?', NULL, N'Planning ahead helps you make thoughtful choices instead of spending impulsively.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_4, N'multiple_choice', N'If you spend your whole allowance right away every week, what might happen?', N'["You won''t have money saved for bigger goals later", "Nothing — spending it all is always fine", "You''ll automatically get more money"]', N'You won''t have money saved for bigger goals later', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_4, N'short_response', N'What''s one thing you''d want to save toward using part of your allowance each week?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_4, N'multiple_choice', N'A good budget usually balances...', N'["Saving, spending, and maybe giving", "Spending on only one single thing", "Ignoring how much money you actually have"]', N'Saving, spending, and maybe giving', 6);

    DECLARE @cat_finance_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'life_skills', N'Financial Literacy', 'space_heavy', 4, N'Plan how you''d spend money on wants vs. needs across a month.', 0);
    SET @cat_finance_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_5, N'short_response', N'List 3 needs and 3 wants you (or a family) might spend money on in a month.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_5, N'short_response', N'If you had $50 for the month, how would you split it between needs, wants, and savings? Explain your choices.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_5, N'multiple_choice', N'A spending plan mainly helps you...', N'["Make sure needs are covered before spending on wants", "Spend as much as possible on wants first", "Avoid ever thinking about money"]', N'Make sure needs are covered before spending on wants', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_5, N'short_response', N'What would you do if an unexpected need (like a broken shoe) came up mid-month?', NULL, N'Answers will vary (e.g., adjust the plan, use savings).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_5, N'multiple_choice', N'Why might someone choose to delay a want in favor of a need?', N'["Needs are essential, so they usually come first", "Wants are always more urgent than needs", "It doesn''t matter which comes first"]', N'Needs are essential, so they usually come first', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_5, N'short_response', N'Reflect: is there a want you''ve bought before that you later wished you''d saved for something else instead?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_finance_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'life_skills', N'Financial Literacy', 'space_heavy', 4, N'Write a simple business plan for a lemonade-stand style venture.', 0);
    SET @cat_finance_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_6, N'short_response', N'What would your stand sell, and at what price per item?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_6, N'short_response', N'List your estimated costs (ingredients, cups, sign) and how you''d make sure you earn more than you spend.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_6, N'multiple_choice', N'Profit is...', N'["The money left after subtracting costs from what you earned", "The total amount of money you took in", "The same thing as your costs"]', N'The money left after subtracting costs from what you earned', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_6, N'short_response', N'If your costs are $10 and you sell $25 worth of lemonade, what is your profit?', NULL, N'$15.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_6, N'multiple_choice', N'Why might a business owner track their costs carefully?', N'["To make sure they''re actually making a profit, not losing money", "Costs don''t matter as long as sales happen", "Tracking costs is only for big companies"]', N'To make sure they''re actually making a profit, not losing money', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_6, N'short_response', N'What would you do with the profit from your stand — save it, spend it, or split it? Explain.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_finance_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'life_skills', N'Financial Literacy', 'space_heavy', 4, N'Compare saving vs. spending scenarios, and get an intro to simple interest.', 0);
    SET @cat_finance_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_7, N'short_response', N'Scenario A: spend $100 today. Scenario B: save $100 in an account earning interest. Explain the trade-off between the two.', NULL, N'Spending gives immediate benefit; saving grows over time but delays the benefit.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_7, N'fill_blank', N'If you save $100 at 5% simple interest for 1 year, how much interest do you earn?', NULL, N'$5 (100 x 0.05)', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_7, N'multiple_choice', N'Simple interest means...', N'["You earn a percentage of your saved amount over time", "Your money never grows in a savings account", "You lose money by saving instead of spending"]', N'You earn a percentage of your saved amount over time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_7, N'short_response', N'Why might a bank pay you interest for keeping your money saved with them?', NULL, N'They use saved money for other things and pay you for letting them use it.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_7, N'multiple_choice', N'Which grows your money over time?', N'["Saving in an account that earns interest", "Keeping cash in a piggy bank with no interest", "Both grow money exactly the same amount"]', N'Saving in an account that earns interest', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_finance_7, N'short_response', N'Would you rather spend $100 now or save it and have more later? Explain your reasoning.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_timemgmt_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'life_skills', N'Time Management', 'short_answer', 4, NULL, 0);
    SET @cat_timemgmt_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_0, N'multiple_choice', N'What do you do first in the morning?', N'["Wake up and get dressed", "Go to bed", "Eat dinner"]', N'Wake up and get dressed', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_0, N'multiple_choice', N'What happens right before bedtime?', N'["Brushing teeth and pajamas", "Eating breakfast", "Going to school"]', N'Brushing teeth and pajamas', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_timemgmt_0, N'short_response', N'Put a morning routine in order.', NULL, N'Wake up, dress, eat, brush teeth.', 3, N'sequence_steps', N'{"steps": ["Wake up", "Get dressed", "Eat breakfast", "Brush teeth"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_timemgmt_0, N'short_response', N'Put a nighttime routine in order.', NULL, N'Bath, pajamas, brush teeth, bed.', 4, N'sequence_steps', N'{"steps": ["Take a bath", "Put on pajamas", "Brush teeth", "Go to bed"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_0, N'short_response', N'Draw your own morning routine in pictures.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_0, N'multiple_choice', N'A routine is...', N'["Things you do in the same order each day", "Something you only do once", "A type of food"]', N'Things you do in the same order each day', 6);

    DECLARE @cat_timemgmt_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'life_skills', N'Time Management', 'short_answer', 4, N'Fill in a simple visual schedule for your day.', 0);
    SET @cat_timemgmt_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_1, N'short_response', N'Write or draw 4 things you do on a typical school day, in order.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_1, N'multiple_choice', N'A schedule helps you...', N'["Know what to do and when", "Forget about time completely", "Do everything all at once"]', N'Know what to do and when', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_1, N'short_response', N'What time do you usually wake up, and what time do you usually go to bed?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_1, N'multiple_choice', N'If your schedule says ''reading time'' after dinner, what should you do then?', N'["Read a book", "Watch TV", "Go outside to play"]', N'Read a book', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_1, N'short_response', N'Why might having a visual schedule help someone who doesn''t read well yet?', NULL, N'Pictures can show the plan without needing to read words.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_1, N'multiple_choice', N'What could you do if something unexpected changes your schedule?', N'["Adjust the plan calmly", "Get upset and refuse to do anything", "Ignore the rest of the day completely"]', N'Adjust the plan calmly', 6);

    DECLARE @cat_timemgmt_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'life_skills', N'Time Management', 'short_answer', 4, N'Fill in a weekly routine chart with school, chores, and play.', 0);
    SET @cat_timemgmt_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_2, N'short_response', N'List one activity you do every single day of the week.', NULL, N'Answers will vary (e.g., homework, brushing teeth).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_2, N'short_response', N'List one activity you only do on weekends.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_2, N'multiple_choice', N'A weekly routine chart is useful because...', N'["It shows the whole week''s plan at a glance", "It only shows one single day", "It replaces the need for any planning"]', N'It shows the whole week''s plan at a glance', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_2, N'short_response', N'What''s a day of your week that feels the busiest? What''s on it?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_2, N'multiple_choice', N'If your chart shows ''chores'' every day but you keep forgetting, what could help?', N'["Put the chart somewhere you''ll see it often", "Stop making a chart at all", "Do chores only when you remember by chance"]', N'Put the chart somewhere you''ll see it often', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_2, N'short_response', N'Fill in your own simple weekly routine chart with at least 3 activities for 3 different days.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_timemgmt_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'life_skills', N'Time Management', 'short_answer', 4, N'Estimate how long a task will take, then compare to how long it actually took.', 0);
    SET @cat_timemgmt_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_3, N'short_response', N'Pick a task (like cleaning your room). Estimate how long you think it will take.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_3, N'short_response', N'After actually doing the task, write how long it ACTUALLY took.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_3, N'multiple_choice', N'If your estimate was way off from the actual time, that means...', N'["You''ve learned something useful for estimating next time", "You did something wrong", "Estimating doesn''t matter at all"]', N'You''ve learned something useful for estimating next time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_3, N'short_response', N'Why is it useful to practice estimating how long tasks take?', NULL, N'It helps you plan your day more realistically and avoid running out of time.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_3, N'multiple_choice', N'People often UNDERESTIMATE how long tasks take. Why might that happen?', N'["They forget about small interruptions or extra steps", "Tasks always take exactly as long as expected", "Estimating too low never causes problems"]', N'They forget about small interruptions or extra steps', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_3, N'short_response', N'Pick a NEW task and estimate its time. Try it and compare — were you closer this time?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_timemgmt_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'life_skills', N'Time Management', 'space_heavy', 4, N'Build a schedule balancing homework, chores, and play.', 0);
    SET @cat_timemgmt_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_4, N'short_response', N'List your homework, chores, and play activities for one day, then arrange them into a schedule.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_4, N'multiple_choice', N'A balanced schedule usually includes...', N'["Time for responsibilities AND time for fun/rest", "Only schoolwork, nothing else", "Only free time, no responsibilities"]', N'Time for responsibilities AND time for fun/rest', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_4, N'short_response', N'What would you do if homework took longer than you planned and cut into your play time?', NULL, N'Answers will vary (e.g., adjust remaining tasks, prioritize what''s most important).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_4, N'multiple_choice', N'Why put chores BEFORE play in a schedule, for many people?', N'["Finishing responsibilities first can make play time feel more relaxed", "Chores should always come last", "The order never matters"]', N'Finishing responsibilities first can make play time feel more relaxed', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_4, N'short_response', N'Design a realistic schedule for a Saturday that includes at least one chore, one homework/study block, and one fun activity.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_4, N'multiple_choice', N'A good schedule should be...', N'["Realistic — something you can actually follow", "As packed as possible with no breaks", "Exactly the same every single day forever"]', N'Realistic — something you can actually follow', 6);

    DECLARE @cat_timemgmt_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'life_skills', N'Time Management', 'space_heavy', 4, N'Sort tasks using a priority matrix: urgent vs. important.', 0);
    SET @cat_timemgmt_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_5, N'matching', N'Sort each task by urgency/importance category.', N'{"left": ["A test tomorrow you haven''t studied for", "Organizing your bookshelf someday", "A permission slip due today", "Learning a new hobby, no deadline"], "right": ["Urgent & important", "Not urgent, less important", "Urgent & important", "Not urgent, less important"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_5, N'multiple_choice', N'''Urgent'' means...', N'["It needs attention very soon", "It''s not very important", "It can wait forever"]', N'It needs attention very soon', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_5, N'multiple_choice', N'''Important'' means...', N'["It really matters for your goals or responsibilities", "It has a strict deadline", "It''s something fun to do"]', N'It really matters for your goals or responsibilities', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_5, N'short_response', N'List one task that''s urgent AND important, and one that''s neither, from your own life.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_5, N'multiple_choice', N'Which should usually get done FIRST?', N'["Tasks that are both urgent and important", "Tasks that are neither urgent nor important", "Whatever task is most fun"]', N'Tasks that are both urgent and important', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_5, N'short_response', N'Why might people waste time on ''not urgent, not important'' tasks instead of important ones?', NULL, N'Answers will vary (e.g., they''re easier or more fun in the moment).', 6);

    DECLARE @cat_timemgmt_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'life_skills', N'Time Management', 'space_heavy', 4, N'Build a weekly planner that tracks deadlines across several classes or activities.', 0);
    SET @cat_timemgmt_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_6, N'short_response', N'List 3 upcoming deadlines (real or made up) across different subjects or activities.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_6, N'short_response', N'Arrange those 3 deadlines into a weekly planner, working backward to figure out when to start each one.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_6, N'multiple_choice', N'Working backward from a deadline helps you...', N'["Figure out when you actually need to start", "Wait until the last minute automatically", "Ignore the deadline until it''s too late"]', N'Figure out when you actually need to start', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_6, N'short_response', N'What would you do if two big deadlines landed on the exact same day?', NULL, N'Answers will vary (e.g., start both earlier, prioritize by importance).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_6, N'multiple_choice', N'A weekly planner with deadlines is most useful when it''s...', N'["Checked and updated regularly, not just made once", "Made once and never looked at again", "Only for very important people"]', N'Checked and updated regularly, not just made once', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_6, N'short_response', N'What''s one strategy you use (or could use) to avoid procrastinating on a deadline?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_timemgmt_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'life_skills', N'Time Management', 'space_heavy', 4, N'Design a multi-project time-blocking planner.', 0);
    SET @cat_timemgmt_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_7, N'short_response', N'List 3 different projects or responsibilities you''re juggling (real or made up).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_7, N'short_response', N'Time-block a single day, assigning specific blocks of time to each project.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_7, N'multiple_choice', N'Time-blocking means...', N'["Assigning specific chunks of time to specific tasks", "Working on everything at once, unplanned", "Avoiding a schedule entirely"]', N'Assigning specific chunks of time to specific tasks', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_7, N'short_response', N'Why might switching between many tasks without blocks of focus actually slow you down?', NULL, N'Constant switching can make it harder to focus deeply on any one task.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_7, N'multiple_choice', N'If one time block runs over, what''s a good response?', N'["Adjust the rest of the day''s blocks realistically", "Panic and abandon the whole schedule", "Pretend the overrun didn''t happen"]', N'Adjust the rest of the day''s blocks realistically', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_timemgmt_7, N'short_response', N'How would you build in buffer time for unexpected interruptions in a time-blocked schedule?', NULL, N'Answers will vary (e.g., leave small gaps between blocks).', 6);

    DECLARE @cat_organize_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'life_skills', N'Organization', 'short_answer', 4, NULL, 0);
    SET @cat_organize_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_0, N'matching', N'Match each item to its ''home''.', N'{"left": ["Backpack", "Lunchbox", "Jacket", "Shoes"], "right": ["Cubby hook", "Lunch shelf", "Coat hook", "Shoe bin"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_0, N'multiple_choice', N'Where should your backpack go when you get home?', N'["Its usual spot, like a hook or shelf", "Anywhere on the floor", "In the kitchen sink"]', N'Its usual spot, like a hook or shelf', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_0, N'short_response', N'Why is it helpful for things to have their own special spot?', NULL, N'It''s easier to find them later.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_0, N'multiple_choice', N'If you can''t find your shoes, what probably happened?', N'["They weren''t put back in their spot", "Shoes disappear on their own", "It doesn''t matter, just wear different ones"]', N'They weren''t put back in their spot', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_0, N'short_response', N'Draw a picture of where 3 of your things belong at home.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_0, N'multiple_choice', N'Putting things back where they belong is called...', N'["Being organized", "Being messy", "Being tired"]', N'Being organized', 6);

    DECLARE @cat_organize_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'life_skills', N'Organization', 'short_answer', 4, N'Make a checklist to help you pack your backpack.', 0);
    SET @cat_organize_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_1, N'short_response', N'List 4 things that should go in your backpack for school.', NULL, N'Answers will vary (e.g., homework, pencil case, lunch, water bottle).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_1, N'multiple_choice', N'A checklist helps you...', N'["Remember everything without forgetting something", "Take longer to get ready", "Skip important steps"]', N'Remember everything without forgetting something', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_1, N'short_response', N'What could happen if you forget your homework at home?', NULL, N'You might not be able to turn it in on time.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_1, N'multiple_choice', N'When is the best time to check your packing checklist?', N'["The night before or morning of, before leaving", "After you''ve already left home", "Only once a month"]', N'The night before or morning of, before leaving', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_1, N'short_response', N'Make your own simple backpack checklist with checkboxes.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_1, N'multiple_choice', N'If you always forget the same item, what could help?', N'["Put it at the top of your checklist as a reminder", "Just accept you''ll always forget it", "Stop using a checklist"]', N'Put it at the top of your checklist as a reminder', 6);

    DECLARE @cat_organize_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'life_skills', N'Organization', 'short_answer', 4, N'Use an assignment tracker to check off homework as you finish it.', 0);
    SET @cat_organize_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_2, N'short_response', N'List 3 assignments (real or made up) you have this week.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_2, N'multiple_choice', N'An assignment tracker mainly helps you...', N'["See what''s done and what''s still left to do", "Do your assignments for you", "Forget about your assignments"]', N'See what''s done and what''s still left to do', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_2, N'short_response', N'Why is it satisfying to check off a finished assignment on a tracker?', NULL, N'It shows real progress and helps you see what''s left.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_2, N'multiple_choice', N'When should you update your assignment tracker?', N'["Right after finishing each assignment", "Only at the very end of the week", "Never — just remember it in your head"]', N'Right after finishing each assignment', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_2, N'short_response', N'Draw or make your own simple assignment tracker with boxes to check off.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_2, N'multiple_choice', N'If your tracker shows 2 assignments still unchecked, what should you do?', N'["Finish them soon so nothing is missed", "Ignore the tracker", "Erase them from the list without doing them"]', N'Finish them soon so nothing is missed', 6);

    DECLARE @cat_organize_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'life_skills', N'Organization', 'short_answer', 4, N'Build a checklist for keeping your weekly folder/binder organized.', 0);
    SET @cat_organize_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_3, N'short_response', N'List 3 things that should be organized in a school binder or folder.', NULL, N'Answers will vary (e.g., homework, graded papers, notes).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_3, N'multiple_choice', N'How often should you clean out and organize your folder?', N'["Regularly, like once a week", "Only at the end of the school year", "Never"]', N'Regularly, like once a week', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_3, N'short_response', N'What problem can happen if papers just get shoved into a folder without any order?', NULL, N'Important papers (like homework due tomorrow) can get lost or hard to find.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_3, N'multiple_choice', N'A good way to organize a binder is to...', N'["Use labeled sections or dividers for different subjects", "Put everything in one big pile", "Never take anything out, ever"]', N'Use labeled sections or dividers for different subjects', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_3, N'short_response', N'Design a simple weekly checklist to keep your binder/folder tidy.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_3, N'multiple_choice', N'Why might a messy folder make homework take longer?', N'["You''d waste time searching for the right paper", "Mess never affects how long things take", "Messy folders are actually faster to use"]', N'You''d waste time searching for the right paper', 6);

    DECLARE @cat_organize_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'life_skills', N'Organization', 'short_answer', 4, N'Use an assignment planner to track due dates.', 0);
    SET @cat_organize_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_4, N'short_response', N'List 3 assignments (real or made up) with their due dates.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_4, N'multiple_choice', N'An assignment planner mainly helps you...', N'["Keep track of what''s due and when", "Do your assignments for you", "Forget about deadlines completely"]', N'Keep track of what''s due and when', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_4, N'short_response', N'How would you decide which assignment to work on FIRST if you had 3 due this week?', NULL, N'Answers will vary (e.g., whichever is due soonest, or takes longest).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_4, N'multiple_choice', N'What should you do right after receiving a new assignment?', N'["Write it in your planner with its due date", "Forget about it until the day it''s due", "Only remember it if a friend reminds you"]', N'Write it in your planner with its due date', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_4, N'short_response', N'Design your own simple assignment planner page for one week.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_4, N'multiple_choice', N'Checking your planner regularly (not just once) helps you...', N'["Notice upcoming deadlines with enough time to prepare", "Waste time for no reason", "Nothing — checking once is always enough"]', N'Notice upcoming deadlines with enough time to prepare', 6);

    DECLARE @cat_organize_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'life_skills', N'Organization', 'space_heavy', 4, N'Design an organized study space.', 0);
    SET @cat_organize_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_5, N'short_response', N'Describe (or draw) your ideal study space. What''s in it?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_5, N'multiple_choice', N'A good study space usually has...', N'["Good lighting, minimal distractions, and needed supplies nearby", "As many distractions as possible", "No supplies at all, just a chair"]', N'Good lighting, minimal distractions, and needed supplies nearby', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_5, N'short_response', N'What''s one distraction in your current study space, and how could you reduce it?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_5, N'multiple_choice', N'Why might having supplies (pencils, paper) already organized nearby help you study?', N'["You won''t waste time getting up to search for them", "Supplies don''t actually matter for studying", "It''s better to search for supplies mid-task"]', N'You won''t waste time getting up to search for them', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_5, N'short_response', N'Design a simple plan to reorganize your current study space, listing 3 changes you''d make.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_5, N'multiple_choice', N'A consistent study space (used regularly) can help because...', N'["Your brain starts to associate that space with focus", "Location never affects focus", "It''s better to study in a different random place every time"]', N'Your brain starts to associate that space with focus', 6);

    DECLARE @cat_organize_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'life_skills', N'Organization', 'space_heavy', 4, N'Track a long-term project using steps and deadlines.', 0);
    SET @cat_organize_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_6, N'short_response', N'Pick a long-term project (real school project or made up). Break it into at least 4 steps.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_6, N'short_response', N'Assign a rough deadline to each of your 4 steps, working backward from the final due date.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_6, N'multiple_choice', N'Breaking a big project into steps with deadlines mainly helps you...', N'["Avoid cramming everything at the very end", "Finish faster with no real planning", "Make the project take longer overall"]', N'Avoid cramming everything at the very end', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_6, N'short_response', N'What would you do if you fell behind on one of your project''s steps?', NULL, N'Answers will vary (e.g., adjust the remaining timeline, focus extra effort).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_6, N'multiple_choice', N'A long-term project tracker is most useful when...', N'["You check and update it regularly as you go", "You make it once and never look at it again", "The project has no real deadline"]', N'You check and update it regularly as you go', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_6, N'short_response', N'Design a simple tracker table with columns for step, deadline, and done/not done.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_organize_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'life_skills', N'Organization', 'space_heavy', 4, N'Design your own personal organization system: planner plus digital calendar.', 0);
    SET @cat_organize_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_7, N'short_response', N'Describe your ideal organization system. What would go in a paper planner vs. a digital calendar?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_7, N'short_response', N'Why might using BOTH a paper planner and a digital calendar work well for some people?', NULL, N'Answers will vary (e.g., paper for quick notes, digital for reminders/alerts).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_7, N'multiple_choice', N'A personal organization system should be...', N'["Something you''ll actually keep using consistently", "As complicated as possible", "Copied exactly from someone else with no changes"]', N'Something you''ll actually keep using consistently', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_7, N'short_response', N'What''s one habit (like a nightly 5-minute check-in) that could help you stick to your system?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_7, N'multiple_choice', N'If a system is too complicated to maintain, what usually happens?', N'["People stop using it", "It automatically becomes more effective", "Complexity never causes problems"]', N'People stop using it', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_organize_7, N'short_response', N'Design your personal system: list the 2-3 tools you''d use and how each one fits into your routine.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_anatomy_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'health', N'Anatomy & the Human Body', 'short_answer', 4, NULL, 0);
    SET @cat_anatomy_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_0, N'multiple_choice', N'Which body part do you see with?', N'["Eyes", "Ears", "Feet"]', N'Eyes', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_0, N'multiple_choice', N'Which body part do you hear with?', N'["Ears", "Eyes", "Hands"]', N'Ears', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_0, N'multiple_choice', N'Which body part do you walk with?', N'["Legs", "Arms", "Head"]', N'Legs', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_0, N'multiple_choice', N'Which body part do you hold things with?', N'["Hands", "Feet", "Ears"]', N'Hands', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_0, N'matching', N'Match the body part to its picture location.', N'{"left": ["Head", "Arms", "Legs", "Tummy"], "right": ["Top of body", "Sides of body", "Bottom of body", "Middle of body"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_0, N'short_response', N'Point to and name 3 body parts on yourself.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_anatomy_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'health', N'Anatomy & the Human Body', 'short_answer', 4, N'Match each of your five senses to the body part that does it.', 0);
    SET @cat_anatomy_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_1, N'matching', N'Match each sense to its body part.', N'{"left": ["See", "Hear", "Smell", "Taste", "Touch"], "right": ["Eyes", "Ears", "Nose", "Tongue", "Skin"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_1, N'multiple_choice', N'How many senses do people have?', N'["5", "3", "10"]', N'5', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_1, N'short_response', N'Which sense do you use to smell fresh cookies baking?', NULL, N'Smell (nose).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_1, N'multiple_choice', N'Which sense helps you know if water is hot or cold?', N'["Touch", "Taste", "Hearing"]', N'Touch', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_1, N'short_response', N'Name your favorite thing to look at, listen to, and taste.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_1, N'multiple_choice', N'Why are our five senses important?', N'["They help us understand and stay safe in the world around us", "They''re just for fun, not useful", "We only really need one sense"]', N'They help us understand and stay safe in the world around us', 6);

    DECLARE @cat_anatomy_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'health', N'Anatomy & the Human Body', 'short_answer', 4, N'Learn what different body parts do — their ''jobs.''', 0);
    SET @cat_anatomy_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_2, N'matching', N'Match the body part to its job.', N'{"left": ["Eyes", "Ears", "Nose", "Mouth", "Legs"], "right": ["See", "Hear", "Smell", "Talk and eat", "Walk and run"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3], [4, 4]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_2, N'short_response', N'What is the job of your lungs?', NULL, N'They help you breathe.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_2, N'multiple_choice', N'What is the job of your heart?', N'["Pump blood through your body", "Help you see", "Help you smell"]', N'Pump blood through your body', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_2, N'short_response', N'Why does your body need many different parts each doing a different job?', NULL, N'Each part has a special task, and together they help your whole body work.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_2, N'multiple_choice', N'What is the job of your brain?', N'["Control your whole body and help you think", "Only help you breathe", "Only help you walk"]', N'Control your whole body and help you think', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_2, N'short_response', N'Pick one body part and describe its job in your own words.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_anatomy_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'health', N'Anatomy & the Human Body', 'short_answer', 4, N'Learn about bones and muscles working together.', 0);
    SET @cat_anatomy_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_3, N'multiple_choice', N'Bones give your body its...', N'["Shape and support", "Ability to smell", "Sense of taste"]', N'Shape and support', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_3, N'multiple_choice', N'Muscles help your body...', N'["Move", "Digest food", "See colors"]', N'Move', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_3, N'short_response', N'Why do bones and muscles need to work TOGETHER for you to move?', NULL, N'Muscles pull on bones to create movement — neither could move you alone.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_3, N'multiple_choice', N'The skeleton is made up of...', N'["All the bones in your body", "All the muscles in your body", "Only the bones in your arms"]', N'All the bones in your body', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_3, N'short_response', N'Name one activity that uses a lot of your muscles.', NULL, N'Answers will vary (e.g., running, climbing).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_3, N'multiple_choice', N'Why is it important to protect your bones (like wearing a helmet)?', N'["Bones can break, and protecting them helps keep your body safe", "Bones can''t ever be hurt", "Bones aren''t actually important"]', N'Bones can break, and protecting them helps keep your body safe', 6);

    DECLARE @cat_anatomy_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'health', N'Anatomy & the Human Body', 'short_answer', 4, N'Learn about major organs and what they do.', 0);
    SET @cat_anatomy_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_4, N'matching', N'Match the organ to its job.', N'{"left": ["Heart", "Lungs", "Stomach", "Brain"], "right": ["Pumps blood", "Helps you breathe", "Digests food", "Controls the body"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_4, N'short_response', N'What happens to food after you swallow it and it reaches your stomach?', NULL, N'Your stomach breaks the food down so your body can use its nutrients.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_4, N'multiple_choice', N'Which organ pumps blood through your whole body?', N'["Heart", "Stomach", "Lungs"]', N'Heart', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_4, N'short_response', N'Why do you need your lungs to breathe?', NULL, N'They take in oxygen from the air and remove carbon dioxide from your blood.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_4, N'multiple_choice', N'Organs are...', N'["Body parts that each do an important job to keep you alive", "Just for decoration inside the body", "Only found in adults, not kids"]', N'Body parts that each do an important job to keep you alive', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_4, N'short_response', N'Pick one major organ and describe why it''s important.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_anatomy_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'health', N'Anatomy & the Human Body', 'space_heavy', 4, N'Follow food''s journey through the digestive system.', 0);
    SET @cat_anatomy_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_anatomy_5, N'short_response', N'Put the steps of digestion in order.', NULL, N'Mouth, esophagus, stomach, intestines, waste.', 1, N'sequence_steps', N'{"steps": ["Food enters your mouth and gets chewed", "Food travels down your esophagus to your stomach", "Your stomach breaks the food down further", "Your intestines absorb nutrients from the food", "Leftover waste leaves your body"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_5, N'short_response', N'Why does your mouth start the digestion process by chewing?', NULL, N'Chewing breaks food into smaller pieces that are easier to digest.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_5, N'multiple_choice', N'The esophagus is the tube that...', N'["Carries food from your mouth to your stomach", "Pumps blood through your body", "Helps you see"]', N'Carries food from your mouth to your stomach', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_5, N'short_response', N'What do your intestines do with the nutrients from digested food?', NULL, N'They absorb the nutrients into your bloodstream so your body can use them.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_5, N'multiple_choice', N'Why does the body need to remove waste after digestion?', N'["The body only keeps what it can use and gets rid of the rest", "Waste is actually more useful than the nutrients", "The body never removes anything"]', N'The body only keeps what it can use and gets rid of the rest', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_5, N'short_response', N'Draw or describe food''s full journey through the digestive system, from mouth to the end.', NULL, N'Answers will vary — should follow the correct sequence.', 6);

    DECLARE @cat_anatomy_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'health', N'Anatomy & the Human Body', 'short_answer', 4, N'Match human body systems to what they do.', 0);
    SET @cat_anatomy_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_6, N'matching', N'Match each body system to its main job.', N'{"left": ["Circulatory system", "Respiratory system", "Skeletal system", "Digestive system"], "right": ["Moves blood around the body", "Handles breathing", "Provides structure and support", "Breaks down food"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_6, N'short_response', N'Which system includes your heart and blood vessels?', NULL, N'The circulatory system.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_6, N'multiple_choice', N'Which system includes your lungs?', N'["Respiratory system", "Skeletal system", "Digestive system"]', N'Respiratory system', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_6, N'short_response', N'How do the circulatory and respiratory systems work together?', NULL, N'The respiratory system brings in oxygen, and the circulatory system carries it through the body in the blood.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_6, N'multiple_choice', N'Why is it useful to think of the body as a set of ''systems''?', N'["It helps organize how different parts work together for a shared purpose", "Systems have nothing to do with each other", "The body doesn''t really have systems"]', N'It helps organize how different parts work together for a shared purpose', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_6, N'short_response', N'Pick one body system and list 2 organs that are part of it.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_anatomy_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'health', N'Anatomy & the Human Body', 'space_heavy', 4, N'Research and write a mini-report on one body system.', 0);
    SET @cat_anatomy_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_7, N'short_response', N'Pick a body system to research (circulatory, respiratory, skeletal, digestive, muscular, or nervous).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_7, N'short_response', N'List 3 facts you learned about your chosen system.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_7, N'short_response', N'What is the MAIN function of your chosen system?', NULL, N'Answers will vary depending on chosen system.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_7, N'multiple_choice', N'A good mini-report should include...', N'["Accurate facts organized clearly", "Only your own opinions with no facts", "Random unrelated information"]', N'Accurate facts organized clearly', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_7, N'short_response', N'How does your chosen system connect or work with at least one other body system?', NULL, N'Answers will vary (e.g., circulatory and respiratory systems work together to deliver oxygen).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_anatomy_7, N'short_response', N'Write a short conclusion: why is your chosen system important for staying healthy?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_nutrition_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'health', N'Food & Healthy Eating Awareness', 'short_answer', 4, NULL, 0);
    SET @cat_nutrition_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_0, N'matching', N'Sort each food as HEALTHY or TREAT.', N'{"left": ["Apple", "Candy", "Carrot", "Cookie"], "right": ["Healthy", "Treat", "Healthy", "Treat"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_0, N'multiple_choice', N'Which is a healthy snack?', N'["An apple", "A candy bar", "A soda"]', N'An apple', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_0, N'multiple_choice', N'Treats should be eaten...', N'["Sometimes, not every meal", "For every meal", "Instead of healthy food"]', N'Sometimes, not every meal', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_0, N'short_response', N'Name one healthy food you like to eat.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_0, N'short_response', N'Name one treat food you enjoy sometimes.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_0, N'multiple_choice', N'Eating healthy foods helps your body...', N'["Grow strong and stay healthy", "Feel worse", "Do nothing at all"]', N'Grow strong and stay healthy', 6);

    DECLARE @cat_nutrition_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'health', N'Food & Healthy Eating Awareness', 'short_answer', 4, N'Learn about MyPlate: fruits, veggies, grains, and protein.', 0);
    SET @cat_nutrition_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_1, N'multiple_choice', N'MyPlate shows food in groups. Name one group.', N'["Fruits", "Candy", "Soda"]', N'Fruits', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_1, N'multiple_choice', N'Which food is a grain?', N'["Bread", "Apple", "Chicken"]', N'Bread', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_1, N'multiple_choice', N'Which food is a protein?', N'["Chicken", "Bread", "Apple"]', N'Chicken', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_1, N'short_response', N'Color a plate showing fruits, veggies, grains, and protein in different sections.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_1, N'multiple_choice', N'Which food is a vegetable?', N'["Carrot", "Cheese", "Bread"]', N'Carrot', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_1, N'short_response', N'Why might a plate with only ONE food group not be very healthy?', NULL, N'Your body needs different nutrients that come from different food groups.', 6);

    DECLARE @cat_nutrition_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'health', N'Food & Healthy Eating Awareness', 'short_answer', 4, N'Build a balanced plate with foods from every group.', 0);
    SET @cat_nutrition_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_2, N'short_response', N'Design a balanced meal with a fruit, a vegetable, a grain, and a protein.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_2, N'multiple_choice', N'A balanced plate includes...', N'["A mix of different food groups", "Only one food group", "Only treats and dessert"]', N'A mix of different food groups', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_2, N'short_response', N'Why might it be unhealthy to eat only protein and no vegetables at every meal?', NULL, N'Your body needs nutrients from many food groups, not just one.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_2, N'multiple_choice', N'Which meal is MORE balanced?', N'["Chicken, rice, and broccoli", "Only candy and soda", "Only chips"]', N'Chicken, rice, and broccoli', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_2, N'short_response', N'Look at a meal you ate recently. Which food groups were included, and which were missing?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_2, N'multiple_choice', N'Building a balanced plate helps your body...', N'["Get a variety of nutrients it needs", "Get bored of the same food", "Only taste sweet things"]', N'Get a variety of nutrients it needs', 6);

    DECLARE @cat_nutrition_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'health', N'Food & Healthy Eating Awareness', 'short_answer', 4, N'Sort foods into groups and practice ''eating the rainbow.''', 0);
    SET @cat_nutrition_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_3, N'matching', N'Sort each food into its food group.', N'{"left": ["Broccoli", "Rice", "Chicken", "Milk"], "right": ["Vegetable", "Grain", "Protein", "Dairy"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_3, N'short_response', N'''Eating the rainbow'' means eating fruits and veggies of different colors. Name 3 different-colored foods.', NULL, N'Answers will vary (e.g., red strawberries, orange carrots, green spinach).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_3, N'multiple_choice', N'Why might different-colored fruits and veggies have different nutrients?', N'["Different colors often come from different vitamins and nutrients", "Color has nothing to do with nutrients", "All fruits and veggies have identical nutrients"]', N'Different colors often come from different vitamins and nutrients', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_3, N'short_response', N'Plan a meal that includes at least 3 different food-group colors.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_3, N'multiple_choice', N'Sorting foods into groups mainly helps you...', N'["Notice if your diet is missing a whole group", "Make food taste different", "Nothing useful"]', N'Notice if your diet is missing a whole group', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_3, N'short_response', N'What''s a colorful fruit or vegetable you haven''t tried before that you''d like to try?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_nutrition_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'health', N'Food & Healthy Eating Awareness', 'short_answer', 4, N'Read a simple nutrition label.', 0);
    SET @cat_nutrition_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_4, N'short_response', N'On a nutrition label, what does ''serving size'' tell you?', NULL, N'How much of the food counts as one serving — all the other numbers are based on that amount.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_4, N'multiple_choice', N'If a label shows 20g of sugar per serving, that number tells you...', N'["How much sugar is in one serving of the food", "How many calories are in the food", "How much the food costs"]', N'How much sugar is in one serving of the food', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_4, N'short_response', N'Why might comparing nutrition labels of two similar snacks help you make a healthier choice?', NULL, N'It lets you see which one has more sugar, fewer nutrients, etc., so you can compare.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_4, N'multiple_choice', N'Nutrition labels usually list ingredients in order of...', N'["Amount — most first, least last", "Alphabetical order", "Random order"]', N'Amount — most first, least last', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_4, N'short_response', N'Look at a food label at home (or imagine one). What''s one thing it tells you about the food?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_4, N'multiple_choice', N'Why is it useful to check nutrition labels before buying packaged food?', N'["It helps you know what''s really in the food", "Labels never have useful information", "Only adults need to read labels"]', N'It helps you know what''s really in the food', 6);

    DECLARE @cat_nutrition_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'health', N'Food & Healthy Eating Awareness', 'space_heavy', 4, N'Plan a healthy lunch using food groups.', 0);
    SET @cat_nutrition_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_5, N'short_response', N'Plan a full healthy lunch, listing one item from each major food group.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_5, N'multiple_choice', N'A healthy lunch plan should balance...', N'["Variety and portion size across food groups", "Only your favorite foods, regardless of group", "As much sugar as possible"]', N'Variety and portion size across food groups', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_5, N'short_response', N'Why might planning your lunch ahead of time lead to healthier choices than deciding last-minute?', NULL, N'Planning ahead avoids grabbing whatever''s fastest or least healthy in the moment.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_5, N'multiple_choice', N'Which is a healthier lunch swap?', N'["Water instead of soda", "More candy instead of fruit", "Chips instead of any vegetable"]', N'Water instead of soda', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_5, N'short_response', N'What''s one small change you could make to your typical lunch to make it more balanced?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_5, N'multiple_choice', N'Why include protein in a lunch plan?', N'["It helps keep you full and gives your body important nutrients", "Protein has no real benefit", "Only dinner needs protein"]', N'It helps keep you full and gives your body important nutrients', 6);

    DECLARE @cat_nutrition_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'health', N'Food & Healthy Eating Awareness', 'space_heavy', 4, N'Compare packaged foods to whole foods.', 0);
    SET @cat_nutrition_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_6, N'short_response', N'Compare a packaged snack (like chips) to a whole food (like an apple). What''s different about their ingredients?', NULL, N'Whole foods usually have one simple ingredient; packaged foods often have many added ones.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_6, N'multiple_choice', N'A ''whole food'' is...', N'["Food in its natural, unprocessed form", "Food that comes in a big package", "Any food with added sugar"]', N'Food in its natural, unprocessed form', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_6, N'short_response', N'Why might a packaged food have a very long ingredient list compared to a whole food?', NULL, N'Processing often adds preservatives, flavors, and other ingredients.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_6, N'multiple_choice', N'Which is generally closer to a whole food?', N'["A fresh orange", "Orange-flavored candy", "Orange soda"]', N'A fresh orange', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_6, N'short_response', N'Does eating packaged foods sometimes mean you''re eating unhealthy? Explain your reasoning.', NULL, N'Not always — some packaged foods are healthy, but it''s worth checking labels and considering whole-food options too.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_6, N'multiple_choice', N'Why might a mix of whole foods AND some packaged convenience foods be realistic for most people?', N'["Whole foods are ideal, but convenience and variety matter too in real life", "Only 100% whole foods should ever be eaten", "Packaged foods are always better"]', N'Whole foods are ideal, but convenience and variety matter too in real life', 6);

    DECLARE @cat_nutrition_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'health', N'Food & Healthy Eating Awareness', 'space_heavy', 4, N'Design a full week of balanced meals with label-reading.', 0);
    SET @cat_nutrition_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_7, N'short_response', N'Plan breakfast, lunch, and dinner for one day, including at least one food from each major group at each meal.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_7, N'short_response', N'Pick one packaged food you''d include in your week''s plan. What would you check on its nutrition label?', NULL, N'Answers will vary (e.g., sugar content, serving size, ingredient list).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_7, N'multiple_choice', N'Planning a full week of meals in advance mainly helps you...', N'["Make sure your diet stays balanced over time, not just one meal", "Guarantee every single meal is perfect", "Avoid ever needing to think about food again"]', N'Make sure your diet stays balanced over time, not just one meal', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_7, N'short_response', N'Why might planning meals for a whole WEEK (not just one day) reveal patterns a single day wouldn''t show?', NULL, N'You might notice you''re repeating unhealthy choices, or missing a food group across several days.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_7, N'multiple_choice', N'A realistic weekly meal plan should include...', N'["Mostly balanced meals, with room for occasional treats", "Only treats, no balanced meals at all", "The exact same meal every single day"]', N'Mostly balanced meals, with room for occasional treats', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_nutrition_7, N'short_response', N'Reflect: what''s one healthy habit from this project you''d actually like to try in real life?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_exercise_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'health', N'Exercise & Fitness', 'short_answer', 4, NULL, 0);
    SET @cat_exercise_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_0, N'multiple_choice', N'How does a bunny move?', N'["Hop", "Slither", "Fly"]', N'Hop', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_0, N'multiple_choice', N'How does a bird move?', N'["Fly", "Hop", "Swim"]', N'Fly', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_0, N'multiple_choice', N'How does a fish move?', N'["Swim", "Hop", "Fly"]', N'Swim', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_0, N'short_response', N'Show or describe how you would move like your favorite animal.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_0, N'multiple_choice', N'Moving your body like an animal is a fun way to...', N'["Exercise and be active", "Stay completely still", "Fall asleep"]', N'Exercise and be active', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_0, N'short_response', N'Name one way you like to move your body and have fun.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_exercise_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'health', N'Exercise & Fitness', 'short_answer', 4, N'Practice a simple stretching routine.', 0);
    SET @cat_exercise_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_1, N'multiple_choice', N'Stretching before exercise helps your body...', N'["Get ready to move safely", "Get more tired", "Fall asleep"]', N'Get ready to move safely', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_1, N'short_response', N'Name one stretch you can do (like touching your toes).', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_1, N'multiple_choice', N'You should stretch...', N'["Slowly and gently", "As fast as possible", "By jumping hard"]', N'Slowly and gently', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_1, N'short_response', N'Draw or describe 3 stretches in a simple stretching routine.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_1, N'multiple_choice', N'If a stretch hurts, what should you do?', N'["Stop and ease off", "Push harder through the pain", "Ignore it"]', N'Stop and ease off', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_1, N'short_response', N'Why is stretching a helpful habit before playing sports or running?', NULL, N'It helps warm up your muscles and can help prevent injury.', 6);

    DECLARE @cat_exercise_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'health', N'Exercise & Fitness', 'short_answer', 4, N'Keep a daily movement log tracking how you move each day.', 0);
    SET @cat_exercise_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_2, N'short_response', N'Log 3 ways you moved your body today (jump, run, dance, walk, etc.).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_2, N'multiple_choice', N'A movement log helps you...', N'["Notice how active you are each day", "Forget about being active", "Track what you eat"]', N'Notice how active you are each day', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_2, N'short_response', N'What''s your favorite way to move and be active?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_2, N'multiple_choice', N'Which counts as ''movement'' for your log?', N'["Dancing, jumping, running, or walking", "Only formal sports practice", "Sitting still"]', N'Dancing, jumping, running, or walking', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_2, N'short_response', N'Why might it be good to move your body in different ways, not just one activity?', NULL, N'Different movements use different muscles and keep exercise fun and varied.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_2, N'multiple_choice', N'How often should kids try to be physically active?', N'["Most days, in fun ways", "Once a year", "Never — rest is always better"]', N'Most days, in fun ways', 6);

    DECLARE @cat_exercise_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'health', N'Exercise & Fitness', 'short_answer', 4, N'Check your heart rate before and after exercise.', 0);
    SET @cat_exercise_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_3, N'short_response', N'Feel your pulse (or place a hand on your chest) while resting. Describe what you notice.', NULL, N'Answers will vary (e.g., a slow, steady beat).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_3, N'multiple_choice', N'After exercising, your heart rate usually...', N'["Goes up (beats faster)", "Goes down (beats slower)", "Stays exactly the same"]', N'Goes up (beats faster)', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_3, N'short_response', N'Why does your heart beat faster when you exercise?', NULL, N'Your muscles need more oxygen, so your heart pumps faster to deliver it.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_3, N'multiple_choice', N'A faster heart rate during exercise means...', N'["Your heart is working harder to help your body move", "Something is wrong with you", "Exercise isn''t working"]', N'Your heart is working harder to help your body move', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_3, N'short_response', N'Do some jumping jacks, then check your heart rate again. How did it change?', NULL, N'Answers will vary — should show an increase after exercise.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_3, N'multiple_choice', N'Why is it healthy to raise your heart rate through exercise regularly?', N'["It helps strengthen your heart over time", "It''s always bad for your heart", "It has no effect on your body"]', N'It helps strengthen your heart over time', 6);

    DECLARE @cat_exercise_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'health', N'Exercise & Fitness', 'space_heavy', 4, N'Build your own warm-up routine before exercise.', 0);
    SET @cat_exercise_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_exercise_4, N'short_response', N'Put a warm-up routine in a sensible order.', NULL, N'Light movement, dynamic stretches, practice moves.', 1, N'sequence_steps', N'{"steps": ["Light movement (like marching in place)", "Dynamic stretches (like arm circles)", "A few practice moves of the activity you''re about to do"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_4, N'multiple_choice', N'A warm-up routine''s main purpose is to...', N'["Prepare your muscles and heart for exercise", "Make you more tired before exercising", "Replace the need to exercise at all"]', N'Prepare your muscles and heart for exercise', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_4, N'short_response', N'Design your own 3-step warm-up routine for before a run or game.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_4, N'short_response', N'Why might skipping a warm-up increase the risk of getting hurt during exercise?', NULL, N'Cold muscles are more likely to strain or get injured than warmed-up ones.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_4, N'multiple_choice', N'A good warm-up gradually...', N'["Increases your heart rate and loosens your muscles", "Exhausts you completely", "Has nothing to do with the activity you''re about to do"]', N'Increases your heart rate and loosens your muscles', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_4, N'short_response', N'How long do you think a warm-up should realistically take before a game or workout?', NULL, N'Answers will vary (e.g., 5-10 minutes).', 6);

    DECLARE @cat_exercise_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'health', N'Exercise & Fitness', 'short_answer', 4, N'Match muscle groups to exercises that work them.', 0);
    SET @cat_exercise_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_5, N'matching', N'Match the muscle group to an exercise that works it.', N'{"left": ["Legs", "Arms", "Core (stomach)", "Back"], "right": ["Squats", "Push-ups", "Sit-ups", "Rows"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_5, N'short_response', N'Name one exercise that works your legs.', NULL, N'Answers will vary (e.g., squats, lunges, running).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_5, N'multiple_choice', N'Working different muscle groups on different days is called...', N'["Balanced training", "Overtraining", "Skipping exercise"]', N'Balanced training', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_5, N'short_response', N'Why might it be helpful to work different muscle groups instead of only one, over and over?', NULL, N'It builds overall strength evenly and gives some muscles time to rest.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_5, N'multiple_choice', N'Push-ups mainly strengthen your...', N'["Arms and chest", "Legs", "Ears"]', N'Arms and chest', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_5, N'short_response', N'Design a simple exercise plan that includes one move for each major muscle group.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_exercise_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'health', N'Exercise & Fitness', 'space_heavy', 4, N'Track a weekly fitness goal.', 0);
    SET @cat_exercise_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_6, N'short_response', N'Set a realistic weekly fitness goal (e.g., ''move for 30 minutes, 4 days this week'').', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_6, N'multiple_choice', N'A good fitness goal should be...', N'["Specific and realistic for you", "Vague, like ''get fitter someday''", "Impossible to actually measure"]', N'Specific and realistic for you', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_6, N'short_response', N'How will you track your progress toward your goal each day?', NULL, N'Answers will vary (e.g., a checklist or log).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_6, N'multiple_choice', N'If you miss a day of your fitness goal, what''s the best response?', N'["Keep going the next day, don''t give up entirely", "Quit the whole goal immediately", "Pretend the goal never existed"]', N'Keep going the next day, don''t give up entirely', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_6, N'short_response', N'What would make your fitness goal enjoyable, not just a chore?', NULL, N'Answers will vary (e.g., picking activities you actually like).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_6, N'multiple_choice', N'Tracking a fitness goal over a WEEK (not just one day) helps you...', N'["See a pattern of consistency, not just a single effort", "Nothing useful, tracking doesn''t matter", "Guarantee instant results"]', N'See a pattern of consistency, not just a single effort', 6);

    DECLARE @cat_exercise_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'health', N'Exercise & Fitness', 'space_heavy', 4, N'Design a personal fitness plan covering strength, cardio, and flexibility.', 0);
    SET @cat_exercise_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_7, N'short_response', N'List one activity for each: strength, cardio (heart-pumping), and flexibility.', NULL, N'Answers will vary (e.g., push-ups, running, stretching).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_7, N'multiple_choice', N'A well-rounded fitness plan includes...', N'["Strength, cardio, AND flexibility work", "Only cardio, nothing else", "Only stretching, nothing else"]', N'Strength, cardio, AND flexibility work', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_7, N'short_response', N'Why might focusing on ONLY one type of fitness (like just strength) leave gaps in your overall health?', NULL, N'Different types of fitness support different parts of health — cardio, strength, and flexibility all matter.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_7, N'multiple_choice', N'Cardio exercise mainly benefits your...', N'["Heart and lungs", "Only your fingernails", "Nothing important"]', N'Heart and lungs', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_7, N'short_response', N'Design a full week''s fitness plan, spreading strength, cardio, and flexibility across different days.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_exercise_7, N'multiple_choice', N'Why include rest days in a fitness plan?', N'["Muscles need time to recover and rebuild", "Rest days have no purpose", "You should never rest at all"]', N'Muscles need time to recover and rebuild', 6);

    DECLARE @cat_gamerules_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'health', N'Physical Game Instruction', 'short_answer', 4, NULL, 0);
    SET @cat_gamerules_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_0, N'multiple_choice', N'In Duck Duck Goose, what do you do when you''re picked as ''Goose''?', N'["Get up and chase the other player", "Sit down and hide", "Leave the game"]', N'Get up and chase the other player', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_0, N'multiple_choice', N'In Freeze Dance, what do you do when the music stops?', N'["Freeze completely still", "Keep dancing", "Sit down"]', N'Freeze completely still', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_0, N'short_response', N'Name a game you like to play with rules.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_0, N'multiple_choice', N'Why do games have rules?', N'["So everyone knows how to play fairly", "Rules don''t matter in games", "To make the game boring"]', N'So everyone knows how to play fairly', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_0, N'short_response', N'Draw a picture of yourself playing your favorite game.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_0, N'multiple_choice', N'If you don''t know a game''s rules, what should you do?', N'["Ask someone to explain them", "Just guess and hope", "Refuse to play"]', N'Ask someone to explain them', 6);

    DECLARE @cat_gamerules_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'health', N'Physical Game Instruction', 'short_answer', 4, N'Follow the rules for a simple playground game.', 0);
    SET @cat_gamerules_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_1, N'short_response', N'Pick a playground game you know. Write one rule of that game.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_1, N'multiple_choice', N'Following rules during a game helps make sure...', N'["The game is fair for everyone playing", "One person always wins", "The game has no point"]', N'The game is fair for everyone playing', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_1, N'short_response', N'What might happen if one player doesn''t follow the rules?', NULL, N'The game could become unfair or confusing for everyone else.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_1, N'multiple_choice', N'If you disagree with a rule during a game, what''s a good response?', N'["Talk it out calmly with the other players", "Yell and quit the game", "Ignore the rule and do what you want"]', N'Talk it out calmly with the other players', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_1, N'short_response', N'List the rules of a simple game you''d teach to a younger kid.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_1, N'multiple_choice', N'Why is it important to follow rules even when you''re losing?', N'["Rules apply to everyone, not just when it''s convenient", "Rules only matter when you''re winning", "You should change the rules to help yourself"]', N'Rules apply to everyone, not just when it''s convenient', 6);

    DECLARE @cat_gamerules_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'health', N'Physical Game Instruction', 'short_answer', 4, N'Sequence the steps of a tag or relay game.', 0);
    SET @cat_gamerules_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_gamerules_2, N'short_response', N'Put the steps of a simple relay race in order.', NULL, N'Line up, run and back, tag, repeat.', 1, N'sequence_steps', N'{"steps": ["Line up teams at the starting line", "First racer runs to the marker and back", "Tag the next teammate", "Repeat until every teammate has gone"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_2, N'short_response', N'In a game of tag, what happens when you get tagged?', NULL, N'Answers will vary depending on the version of tag being played (e.g., you become ''it'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_2, N'multiple_choice', N'Sequencing the steps of a game helps players...', N'["Understand the correct order to play it", "Play the game in a random, confusing order", "Skip steps without noticing"]', N'Understand the correct order to play it', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_2, N'short_response', N'Write the steps for your own version of a tag or relay game.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_2, N'multiple_choice', N'Why does a relay race need clear steps for handing off to the next player?', N'["Without clear handoff rules, the race could become unfair or confusing", "Handoffs don''t matter in relay races", "Every player should just run at the same time"]', N'Without clear handoff rules, the race could become unfair or confusing', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_2, N'short_response', N'What could go wrong if the steps of a relay race weren''t followed in order?', NULL, N'Answers will vary (e.g., unfair advantage, confusion about whose turn it is).', 6);

    DECLARE @cat_gamerules_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'health', N'Physical Game Instruction', 'short_answer', 4, N'Write simple rules for a game you invent.', 0);
    SET @cat_gamerules_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_3, N'short_response', N'Invent a simple physical game. What is the GOAL of your game?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_3, N'short_response', N'Write 3 rules for your invented game.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_3, N'multiple_choice', N'Good game rules should be...', N'["Clear enough that anyone can understand and follow them", "Confusing on purpose", "Only known by the game''s inventor"]', N'Clear enough that anyone can understand and follow them', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_3, N'short_response', N'How would someone WIN your invented game?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_3, N'multiple_choice', N'Why is it important to think through your rules BEFORE playing, not during?', N'["Unclear rules can cause arguments once the game starts", "Rules can always be made up on the spot with no issue", "Thinking ahead doesn''t matter for games"]', N'Unclear rules can cause arguments once the game starts', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_3, N'short_response', N'What equipment (if any) would your invented game need?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_gamerules_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'health', N'Physical Game Instruction', 'space_heavy', 4, N'Practice writing clear instructions for a partner game.', 0);
    SET @cat_gamerules_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_4, N'short_response', N'Pick a partner game. Write clear, step-by-step instructions someone could follow without seeing you play.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_4, N'multiple_choice', N'Clear instructions should avoid...', N'["Vague or confusing wording", "Numbered steps", "Explaining the goal of the game"]', N'Vague or confusing wording', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_4, N'short_response', N'Read your instructions out loud. Is there any part that might confuse someone who''s never played?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_4, N'multiple_choice', N'Why is explaining a game''s GOAL an important part of instructions?', N'["Players need to know what they''re trying to achieve to play well", "The goal doesn''t matter, only the rules do", "Goals should always be kept secret"]', N'Players need to know what they''re trying to achieve to play well', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_4, N'short_response', N'Revise your instructions to fix any confusing parts you noticed.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_4, N'multiple_choice', N'The BEST way to check if your instructions are clear is to...', N'["Have someone else try to follow them", "Assume they''re clear because you understand them", "Never test them at all"]', N'Have someone else try to follow them', 6);

    DECLARE @cat_gamerules_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'health', N'Physical Game Instruction', 'short_answer', 4, N'Learn the basics of a team sport: positions and simple rules.', 0);
    SET @cat_gamerules_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_5, N'short_response', N'Pick a team sport. Name 2 different positions and what each one does.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_5, N'multiple_choice', N'Positions in a team sport exist to...', N'["Give each player a specific role that helps the team", "Confuse the players", "Make everyone do the exact same thing"]', N'Give each player a specific role that helps the team', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_5, N'short_response', N'Why might a team struggle if everyone tried to play the SAME position at once?', NULL, N'Important roles (like defense or offense) would be left uncovered.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_5, N'multiple_choice', N'Learning the basic rules of a sport before playing helps you...', N'["Play fairly and understand what''s happening", "Guess randomly during the game", "Avoid needing to pay attention"]', N'Play fairly and understand what''s happening', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_5, N'short_response', N'Write 2 basic rules of your chosen team sport.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_5, N'multiple_choice', N'Why do team sports usually require players to understand BOTH their own position and the overall rules?', N'["Good teamwork needs both individual roles and shared understanding of the game", "Only knowing your own position matters, rules don''t", "Only knowing the rules matters, positions don''t"]', N'Good teamwork needs both individual roles and shared understanding of the game', 6);

    DECLARE @cat_gamerules_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'health', N'Physical Game Instruction', 'space_heavy', 4, N'Design an original playground game and write its full rules.', 0);
    SET @cat_gamerules_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_6, N'short_response', N'Design an original playground game. Describe the goal and basic setup.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_6, N'short_response', N'Write the complete rules for your game, including how to win and any special moves.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_6, N'multiple_choice', N'A well-designed original game should be...', N'["Fun, fair, and clear enough for others to play", "Impossible to actually understand", "Designed to only benefit the inventor"]', N'Fun, fair, and clear enough for others to play', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_6, N'short_response', N'How many players does your game need, and how would you handle an uneven number?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_6, N'multiple_choice', N'Testing your game with real players before finalizing the rules helps you...', N'["Catch confusing or unfair parts you missed", "Nothing — the first draft is always perfect", "Make the game more confusing on purpose"]', N'Catch confusing or unfair parts you missed', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_6, N'short_response', N'What would you do if playtesting showed a rule in your game was unfair?', NULL, N'Answers will vary (e.g., revise the rule).', 6);

    DECLARE @cat_gamerules_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'health', N'Physical Game Instruction', 'space_heavy', 4, N'Plan a lead-a-game project: write and teach instructions to younger kids.', 0);
    SET @cat_gamerules_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_7, N'short_response', N'Pick a game to teach to younger kids. List the rules in simple, age-appropriate language.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_7, N'short_response', N'How would you explain the rules differently to a 5-year-old than you would to someone your own age?', NULL, N'Answers will vary (e.g., simpler words, more demonstration, shorter rules).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_7, N'multiple_choice', N'Teaching a game to younger kids requires...', N'["Patience and clear, simple explanations", "Using exactly the same explanation as for older kids", "Assuming they already understand everything"]', N'Patience and clear, simple explanations', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_7, N'short_response', N'Plan how you''d demonstrate the game (not just explain it) to make sure younger kids understand.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_7, N'multiple_choice', N'Why might demonstrating a game, not just describing it, help younger kids learn faster?', N'["Seeing an example often makes rules click faster than words alone", "Demonstrating never helps, only words matter", "Younger kids don''t benefit from demonstrations"]', N'Seeing an example often makes rules click faster than words alone', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_gamerules_7, N'short_response', N'What would you do if the younger kids got confused partway through the game?', NULL, N'Answers will vary (e.g., pause, re-explain, simplify further).', 6);

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO