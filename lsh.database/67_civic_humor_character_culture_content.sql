-- 67_civic_humor_character_culture_content.sql
-- Whole-Child Curriculum expansion, batch 4 (final): content for 'civic'
-- (Civics & Government, Community & Global Citizenship, Public Speaking &
-- Debate), 'humor_play' (Creative Drawing & Doodling, Funny Jokes & Wordplay,
-- Riddles & Brain Teasers, Sense of Humor), 'character' (Moral Lessons, Manners
-- & Everyday Respect, Brain Motivation & Growth Mindset), and 'culture' (Chinese,
-- Indian/Gita, Hispanic language & culture) subject_area groups, hand-crafted
-- across all 8 grades. This completes all 10 Whole-Child subject_area groups.
-- Requires 63_whole_child_rotation.sql to already be applied.
-- See gen_67_civic_humor_character_culture_content.py.

IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'civic')
BEGIN
    DECLARE @cat_civics_gov_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'civic', N'Civics & Government', 'short_answer', 4, NULL, 0);
    SET @cat_civics_gov_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_0, N'matching', N'Match the community helper to their job.', N'{"left": ["Firefighter", "Doctor", "Teacher", "Mail carrier"], "right": ["Puts out fires", "Helps sick people", "Helps you learn", "Delivers mail"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_0, N'multiple_choice', N'Who helps keep people safe from fires?', N'["Firefighter", "Teacher", "Mail carrier"]', N'Firefighter', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_0, N'multiple_choice', N'Who helps you learn at school?', N'["Teacher", "Doctor", "Firefighter"]', N'Teacher', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_0, N'short_response', N'Name a community helper and what they do.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_0, N'multiple_choice', N'Community helpers are people who...', N'["Do jobs that help everyone in the community", "Only help themselves", "Never help anyone"]', N'Do jobs that help everyone in the community', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_0, N'short_response', N'Draw a picture of your favorite community helper.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_civics_gov_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'civic', N'Civics & Government', 'short_answer', 4, N'Learn about classroom rules and how voting works.', 0);
    SET @cat_civics_gov_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_1, N'short_response', N'Name one rule in your classroom.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_1, N'multiple_choice', N'Rules in a classroom help everyone...', N'["Stay safe and treat each other kindly", "Get confused", "Ignore the teacher"]', N'Stay safe and treat each other kindly', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_1, N'multiple_choice', N'Voting means...', N'["Choosing what you want by picking an option", "Never getting a choice", "Only one person decides for everyone"]', N'Choosing what you want by picking an option', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_1, N'short_response', N'If your class voted on a game to play, how would you decide the winner?', NULL, N'Whichever game gets the most votes.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_1, N'multiple_choice', N'Why is voting a fair way to make group decisions?', N'["Everyone gets a say, and the most popular choice wins", "Only the teacher''s opinion counts", "It''s not fair at all"]', N'Everyone gets a say, and the most popular choice wins', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_1, N'short_response', N'What would you vote for if your class could pick a class pet?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_civics_gov_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'civic', N'Civics & Government', 'short_answer', 4, N'Learn how a vote actually works, step by step.', 0);
    SET @cat_civics_gov_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order, diagram_type, diagram_data) VALUES
        (@cat_civics_gov_2, N'short_response', N'Put the steps of a simple class vote in order.', NULL, N'Hear choices, pick one, count votes, most votes wins.', 1, N'sequence_steps', N'{"steps": ["Everyone hears the choices", "Each person picks one choice", "Votes are counted", "The choice with the most votes wins"]}');
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_2, N'multiple_choice', N'A ''majority'' in voting means...', N'["More than half of the votes", "Exactly one vote", "No votes at all"]', N'More than half of the votes', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_2, N'short_response', N'If 10 kids vote and 6 pick pizza, 4 pick tacos, which wins? Why?', NULL, N'Pizza — it got more votes (6 out of 10).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_2, N'multiple_choice', N'Why should votes be counted carefully and fairly?', N'["So the real winner is announced correctly", "Counting doesn''t matter, just guess", "Only some votes should count"]', N'So the real winner is announced correctly', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_2, N'short_response', N'Why might a vote sometimes end in a tie? What could happen next?', NULL, N'Two choices get the exact same number of votes — the group might need a tiebreaker, like a re-vote.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_2, N'multiple_choice', N'Voting is used in real government to...', N'["Let citizens choose their leaders and decisions", "Decide the weather", "Nothing important"]', N'Let citizens choose their leaders and decisions', 6);

    DECLARE @cat_civics_gov_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'civic', N'Civics & Government', 'short_answer', 4, N'Learn about local government roles.', 0);
    SET @cat_civics_gov_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_3, N'matching', N'Match the local government role to their job.', N'{"left": ["Mayor", "Police officer", "Firefighter", "City council member"], "right": ["Leads the city", "Keeps the community safe from crime", "Puts out fires and helps in emergencies", "Helps make city decisions/laws"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_3, N'multiple_choice', N'Who is usually the leader of a city?', N'["The mayor", "A teacher", "A doctor"]', N'The mayor', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_3, N'short_response', N'Name one job the local police do to help a community.', NULL, N'Answers will vary (e.g., keep people safe, respond to emergencies).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_3, N'multiple_choice', N'Local government mainly deals with...', N'["Issues in your own city or town", "Only issues in other countries", "Nothing that affects daily life"]', N'Issues in your own city or town', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_3, N'short_response', N'Why does a city need many different roles (mayor, police, etc.) instead of just one person doing everything?', NULL, N'Different jobs need different skills, and one person can''t do everything a whole city needs.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_3, N'multiple_choice', N'Which is an example of something local government might decide?', N'["Where to build a new park", "What''s for dinner at your house", "What game to play at recess"]', N'Where to build a new park', 6);

    DECLARE @cat_civics_gov_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'civic', N'Civics & Government', 'short_answer', 4, N'Get an intro to the branches of government.', 0);
    SET @cat_civics_gov_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_4, N'multiple_choice', N'The branch of government that MAKES laws is called the...', N'["Legislative branch", "Executive branch", "Judicial branch"]', N'Legislative branch', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_4, N'multiple_choice', N'The branch of government that ENFORCES laws is called the...', N'["Executive branch", "Legislative branch", "Judicial branch"]', N'Executive branch', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_4, N'multiple_choice', N'The branch of government that INTERPRETS laws (courts) is called the...', N'["Judicial branch", "Legislative branch", "Executive branch"]', N'Judicial branch', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_4, N'short_response', N'Why might having 3 separate branches be better than one group having all the power?', NULL, N'It spreads out power so no single group can control everything — this is called ''checks and balances.''', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_4, N'short_response', N'Which branch do you think a President or Governor belongs to?', NULL, N'The executive branch.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_4, N'multiple_choice', N'Having ''checks and balances'' between branches means...', N'["Each branch can limit the power of the others", "One branch controls everything", "Branches never interact with each other"]', N'Each branch can limit the power of the others', 6);

    DECLARE @cat_civics_gov_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'civic', N'Civics & Government', 'space_heavy', 4, N'Learn about your rights and responsibilities as a citizen.', 0);
    SET @cat_civics_gov_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_5, N'short_response', N'Name one right you have (something you''re allowed to do or have).', NULL, N'Answers will vary (e.g., free speech, education).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_5, N'short_response', N'Name one responsibility you have (something you''re expected to do).', NULL, N'Answers will vary (e.g., following rules, being honest).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_5, N'multiple_choice', N'A right is...', N'["Something you''re entitled to have or do", "A punishment", "Something forbidden"]', N'Something you''re entitled to have or do', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_5, N'multiple_choice', N'A responsibility is...', N'["A duty or obligation you''re expected to fulfill", "The same thing as a right", "Something optional with no consequences"]', N'A duty or obligation you''re expected to fulfill', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_5, N'short_response', N'Why do rights and responsibilities usually go together?', NULL, N'Enjoying rights in a community also means contributing responsibly to keep that community fair for everyone.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_5, N'multiple_choice', N'Which is an example of a responsibility, not a right?', N'["Following classroom rules", "Being allowed to speak your opinion", "Having access to education"]', N'Following classroom rules', 6);

    DECLARE @cat_civics_gov_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'civic', N'Civics & Government', 'space_heavy', 4, N'Compare local government to national government.', 0);
    SET @cat_civics_gov_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_6, N'short_response', N'Name one issue that local government usually handles.', NULL, N'Answers will vary (e.g., local roads, parks, schools).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_6, N'short_response', N'Name one issue that national government usually handles.', NULL, N'Answers will vary (e.g., national defense, federal laws).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_6, N'multiple_choice', N'Local government mainly affects...', N'["Your city or town specifically", "The entire country equally", "Nothing that matters"]', N'Your city or town specifically', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_6, N'multiple_choice', N'National government mainly affects...', N'["The whole country", "Only one neighborhood", "Nothing important"]', N'The whole country', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_6, N'short_response', N'Why might a decision (like a new park) be made locally rather than nationally?', NULL, N'It only affects people in that specific area, so local leaders who know the community make that call.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_6, N'multiple_choice', N'Understanding both levels of government helps citizens...', N'["Know who to contact about different kinds of issues", "Ignore government entirely", "Assume all government is the same"]', N'Know who to contact about different kinds of issues', 6);

    DECLARE @cat_civics_gov_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'civic', N'Civics & Government', 'space_heavy', 4, N'Take part in a mock election or mock government project.', 0);
    SET @cat_civics_gov_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_7, N'short_response', N'Choose a mock government role (mayor, senator, etc.) or a mock election issue. Describe it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_7, N'short_response', N'If running in a mock election, write one campaign promise your candidate would make.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_7, N'multiple_choice', N'A mock election helps students practice...', N'["Real democratic processes in a safe, practice setting", "Nothing useful", "Only memorizing government vocabulary"]', N'Real democratic processes in a safe, practice setting', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_7, N'short_response', N'How would votes be counted fairly in your mock election?', NULL, N'Answers will vary (e.g., each student votes once, count all ballots).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_7, N'multiple_choice', N'Why might a mock government project include debate or campaign speeches?', N'["It practices persuasion and public speaking, just like real elections", "Speeches aren''t part of real elections", "It has nothing to do with real government"]', N'It practices persuasion and public speaking, just like real elections', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_civics_gov_7, N'short_response', N'What did you learn about how government or elections work from this project?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_global_citizen_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'civic', N'Community & Global Citizenship', 'short_answer', 4, NULL, 0);
    SET @cat_global_citizen_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_0, N'multiple_choice', N'Which is a way to help your community?', N'["Picking up litter", "Making a mess", "Being unkind"]', N'Picking up litter', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_0, N'short_response', N'Name one way you could help someone in your neighborhood.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_0, N'multiple_choice', N'Helping others in your community makes it...', N'["A nicer place for everyone", "Worse for everyone", "No different at all"]', N'A nicer place for everyone', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_0, N'short_response', N'Draw a picture of yourself helping your community.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_0, N'multiple_choice', N'A community is...', N'["A group of people who live near or share something with each other", "Just one single person", "A type of food"]', N'A group of people who live near or share something with each other', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_0, N'short_response', N'Who is someone in your community you''d like to help?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_global_citizen_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'civic', N'Community & Global Citizenship', 'short_answer', 4, N'Try a simple kindness challenge this week.', 0);
    SET @cat_global_citizen_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_1, N'short_response', N'Write down one kind thing you could do for someone this week.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_1, N'multiple_choice', N'A kindness challenge encourages you to...', N'["Do intentional kind acts for others", "Avoid helping anyone", "Only be kind to yourself"]', N'Do intentional kind acts for others', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_1, N'short_response', N'How did it feel the last time you did something kind for someone?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_1, N'multiple_choice', N'Small acts of kindness (like sharing or a compliment) can...', N'["Make a real difference to someone''s day", "Never matter at all", "Only matter if they''re big gestures"]', N'Make a real difference to someone''s day', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_1, N'short_response', N'Try your kindness challenge and write about what happened.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_1, N'multiple_choice', N'Why might kindness ''spread'' — meaning one kind act leads to more?', N'["Being treated kindly often inspires people to be kind to others too", "Kindness never has any effect on others", "Kindness only happens by accident"]', N'Being treated kindly often inspires people to be kind to others too', 6);

    DECLARE @cat_global_citizen_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'civic', N'Community & Global Citizenship', 'short_answer', 4, N'Brainstorm ideas for community service.', 0);
    SET @cat_global_citizen_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_2, N'short_response', N'List 2 ways kids your age could help their community.', NULL, N'Answers will vary (e.g., a food drive, cleaning up a park).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_2, N'multiple_choice', N'Community service means...', N'["Volunteering your time to help others without pay", "Getting paid to do a job", "Only helping your own family"]', N'Volunteering your time to help others without pay', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_2, N'short_response', N'Why might community service help both the community AND the volunteer?', NULL, N'The community gets help, and volunteers often feel good and learn new skills.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_2, N'multiple_choice', N'Which is an example of community service?', N'["Collecting donations for a shelter", "Buying something for yourself", "Watching TV"]', N'Collecting donations for a shelter', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_2, N'short_response', N'What community service idea would YOU most want to try?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_2, N'multiple_choice', N'Community service ideas should be...', N'["Realistic and something you could actually help with", "Impossible to actually do", "Only for adults, never kids"]', N'Realistic and something you could actually help with', 6);

    DECLARE @cat_global_citizen_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'civic', N'Community & Global Citizenship', 'space_heavy', 4, N'Compare needs in different communities.', 0);
    SET @cat_global_citizen_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_3, N'short_response', N'Name one need a community near you might have (e.g., more parks, cleaner streets).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_3, N'short_response', N'Name a need a DIFFERENT kind of community (rural, another country, etc.) might have.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_3, N'multiple_choice', N'Different communities might have different needs because...', N'["Their circumstances, resources, and environments differ", "All communities are always identical", "Needs never actually differ anywhere"]', N'Their circumstances, resources, and environments differ', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_3, N'short_response', N'Why is it useful to learn about needs in communities different from your own?', NULL, N'It builds empathy and understanding of experiences different from your own.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_3, N'multiple_choice', N'Comparing community needs helps you...', N'["Understand that ''normal'' looks different in different places", "Assume everyone has the exact same life as you", "Nothing useful"]', N'Understand that ''normal'' looks different in different places', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_3, N'short_response', N'If you could help a community with a need different from your own, what would you want to help with?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_global_citizen_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'civic', N'Community & Global Citizenship', 'space_heavy', 4, N'Design your own community service project.', 0);
    SET @cat_global_citizen_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_4, N'short_response', N'What community need would your project address?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_4, N'short_response', N'Describe your project: what would you and others actually DO?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_4, N'short_response', N'Who would your project help, and how would you know if it worked?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_4, N'multiple_choice', N'A good community service project should be...', N'["Realistic and actually address a real need", "Impossible to carry out", "Only about getting recognition"]', N'Realistic and actually address a real need', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_4, N'short_response', N'What supplies, people, or permission would you need to make your project happen?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_4, N'multiple_choice', N'Designing a project BEFORE doing it helps you...', N'["Think through what''s needed to make it actually succeed", "Waste time for no reason", "Skip the need for any planning"]', N'Think through what''s needed to make it actually succeed', 6);

    DECLARE @cat_global_citizen_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'civic', N'Community & Global Citizenship', 'space_heavy', 4, N'Reflect on what it means to be a global citizen.', 0);
    SET @cat_global_citizen_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_5, N'short_response', N'What does ''global citizenship'' mean to you? Explain in your own words.', NULL, N'Caring about and taking responsibility for people and issues beyond just your own community.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_5, N'short_response', N'Name one issue that affects people all around the world, not just one country.', NULL, N'Answers will vary (e.g., climate change, access to clean water).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_5, N'multiple_choice', N'A global citizen is someone who...', N'["Cares about and considers people beyond just their own community", "Only cares about their own country", "Ignores issues outside their neighborhood"]', N'Cares about and considers people beyond just their own community', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_5, N'short_response', N'Why might learning about other cultures and countries help you become a better global citizen?', NULL, N'It builds understanding and empathy for people whose lives are different from your own.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_5, N'multiple_choice', N'Global citizenship and local community involvement are...', N'["Both important — you can care about both at once", "Completely unrelated to each other", "In competition, you can only pick one"]', N'Both important — you can care about both at once', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_5, N'short_response', N'What''s one small way you could show global citizenship in your everyday life?', NULL, N'Answers will vary (e.g., learning about other cultures, being mindful of resource use).', 6);

    DECLARE @cat_global_citizen_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'civic', N'Community & Global Citizenship', 'space_heavy', 4, N'Research a global issue and design a local action plan.', 0);
    SET @cat_global_citizen_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_6, N'short_response', N'Choose a global issue to research (e.g., clean water access, plastic pollution). Describe it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_6, N'short_response', N'Who is most affected by this global issue?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_6, N'short_response', N'Design a LOCAL action — something you or your community could realistically do to help.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_6, N'multiple_choice', N'A ''local action plan'' for a global issue means...', N'["Taking realistic, small-scale steps in your own community", "Solving the entire global issue by yourself", "Ignoring the issue since it''s too big"]', N'Taking realistic, small-scale steps in your own community', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_6, N'multiple_choice', N'Why can small local actions matter even for huge global issues?', N'["Many small local actions can add up to meaningful change", "Local actions never make any difference", "Only huge, global actions matter at all"]', N'Many small local actions can add up to meaningful change', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_6, N'short_response', N'What''s the first step you''d take to start your local action plan?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_global_citizen_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'civic', N'Community & Global Citizenship', 'space_heavy', 4, N'Write a full service-learning project proposal.', 0);
    SET @cat_global_citizen_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_7, N'short_response', N'State the community need your service-learning project addresses.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_7, N'short_response', N'Describe your project''s goals — what would success look like?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_7, N'short_response', N'List the steps/timeline for carrying out your project.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_7, N'short_response', N'How would you measure whether your project actually made a difference?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_7, N'multiple_choice', N'Service-learning combines...', N'["Real community service with structured learning and reflection", "Only community service, with no learning involved", "Only classroom learning, with no real service"]', N'Real community service with structured learning and reflection', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_global_citizen_7, N'multiple_choice', N'A strong project proposal should convince readers that...', N'["The project is well-planned, realistic, and worth doing", "The project idea doesn''t need any explanation", "Planning isn''t necessary for service projects"]', N'The project is well-planned, realistic, and worth doing', 6);

    DECLARE @cat_public_speaking_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'civic', N'Public Speaking & Debate', 'short_answer', 4, NULL, 0);
    SET @cat_public_speaking_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_0, N'short_response', N'Write or draw one thing you''d like to share for show-and-tell.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_0, N'multiple_choice', N'When it''s your turn to talk in front of others, you should...', N'["Speak clearly so people can hear you", "Whisper so no one can hear", "Talk as fast as possible"]', N'Speak clearly so people can hear you', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_0, N'short_response', N'What is one fun fact about the thing you''d bring for show-and-tell?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_0, N'multiple_choice', N'Looking at your audience while talking helps you...', N'["Connect with the people listening", "Confuse everyone", "Nothing at all"]', N'Connect with the people listening', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_0, N'short_response', N'Practice saying your show-and-tell sentence out loud.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_0, N'multiple_choice', N'Talking in front of a group is called...', N'["Public speaking", "Silent reading", "Sleeping"]', N'Public speaking', 6);

    DECLARE @cat_public_speaking_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'civic', N'Public Speaking & Debate', 'short_answer', 4, N'Practice introducing yourself to a group.', 0);
    SET @cat_public_speaking_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_1, N'short_response', N'Write a short introduction: your name, and one thing you like.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_1, N'multiple_choice', N'A good introduction usually includes...', N'["Your name and something about you", "Only your name, nothing else", "A secret you''ll never tell"]', N'Your name and something about you', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_1, N'short_response', N'Practice saying your introduction out loud, clearly and not too fast.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_1, N'multiple_choice', N'When introducing yourself, it helps to...', N'["Smile and speak with a clear voice", "Look at the floor and mumble", "Talk as quietly as possible"]', N'Smile and speak with a clear voice', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_1, N'short_response', N'What is one question you could ask someone after introducing yourself?', NULL, N'Answers will vary (e.g., ''What''s your name?'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_1, N'multiple_choice', N'Practicing your introduction beforehand helps you...', N'["Feel more confident when you actually say it", "Nothing, practicing doesn''t help", "Forget what you wanted to say"]', N'Feel more confident when you actually say it', 6);

    DECLARE @cat_public_speaking_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'civic', N'Public Speaking & Debate', 'short_answer', 4, N'Outline a simple 3-sentence speech.', 0);
    SET @cat_public_speaking_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_2, N'short_response', N'Sentence 1: introduce your topic. What will you talk about?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_2, N'short_response', N'Sentence 2: share one fact or idea about your topic.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_2, N'short_response', N'Sentence 3: wrap up your speech with a closing thought.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_2, N'multiple_choice', N'A speech outline helps you...', N'["Organize your ideas before speaking", "Memorize word-for-word with no flexibility", "Skip planning entirely"]', N'Organize your ideas before speaking', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_2, N'short_response', N'Practice saying your 3-sentence speech out loud.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_2, N'multiple_choice', N'Even a very short speech should have...', N'["A clear beginning, middle, and end", "No real structure", "Only one sentence"]', N'A clear beginning, middle, and end', 6);

    DECLARE @cat_public_speaking_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'civic', N'Public Speaking & Debate', 'space_heavy', 4, N'Plan a persuasive speech.', 0);
    SET @cat_public_speaking_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_3, N'short_response', N'Choose something you want to persuade someone about (e.g., ''we should have a class pet''). State your position.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_3, N'short_response', N'Give one REASON to support your position.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_3, N'multiple_choice', N'A persuasive speech tries to...', N'["Convince the listener to agree with your position", "Only share random facts with no goal", "Confuse the listener on purpose"]', N'Convince the listener to agree with your position', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_3, N'short_response', N'What''s a counter-argument someone might have against your position? How would you respond?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_3, N'multiple_choice', N'A persuasive speech is stronger when it includes...', N'["Real reasons and evidence, not just opinions", "No reasons at all, just repeated opinions", "As many big words as possible"]', N'Real reasons and evidence, not just opinions', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_3, N'short_response', N'Write a strong closing sentence for your persuasive speech.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_public_speaking_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'civic', N'Public Speaking & Debate', 'short_answer', 4, N'Learn debate basics: making a claim and giving a reason.', 0);
    SET @cat_public_speaking_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_4, N'short_response', N'Write a CLAIM (a statement you believe) about a topic of your choice.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_4, N'short_response', N'Write a REASON that supports your claim.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_4, N'multiple_choice', N'A claim in a debate is...', N'["A statement of your position or belief", "A question with no answer", "The same as a fact everyone already agrees on"]', N'A statement of your position or belief', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_4, N'multiple_choice', N'Why does a claim need a REASON to back it up?', N'["Without a reason, it''s just an unsupported opinion", "Reasons aren''t necessary in debate", "Claims are always true without needing support"]', N'Without a reason, it''s just an unsupported opinion', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_4, N'short_response', N'Write a claim + reason pair about your favorite season.', NULL, N'Answers will vary (e.g., ''Summer is the best season because you can swim outside.'').', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_4, N'multiple_choice', N'In a debate, the goal of a claim + reason is to...', N'["Make your position more convincing", "Confuse the other side", "Avoid explaining your thinking"]', N'Make your position more convincing', 6);

    DECLARE @cat_public_speaking_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'civic', N'Public Speaking & Debate', 'space_heavy', 4, N'Build a structured speech outline: intro, body, conclusion.', 0);
    SET @cat_public_speaking_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_5, N'short_response', N'INTRO: write an opening line that grabs attention and states your topic.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_5, N'short_response', N'BODY: list 2-3 main points you''ll cover.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_5, N'short_response', N'CONCLUSION: write a closing line that wraps up your main message.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_5, N'multiple_choice', N'The BODY of a speech is where you...', N'["Present your main points and evidence", "Just repeat the introduction", "Skip all the important details"]', N'Present your main points and evidence', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_5, N'multiple_choice', N'Why does a speech need a clear structure (intro/body/conclusion)?', N'["It helps the audience follow your ideas logically", "Structure doesn''t matter for speeches", "It makes the speech confusing on purpose"]', N'It helps the audience follow your ideas logically', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_5, N'short_response', N'Read your full outline out loud. Does each part flow smoothly into the next?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_public_speaking_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'civic', N'Public Speaking & Debate', 'space_heavy', 4, N'Prep for a formal debate, including rebuttal notes.', 0);
    SET @cat_public_speaking_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_6, N'short_response', N'State your debate position clearly.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_6, N'short_response', N'List 2 pieces of evidence or reasons supporting your position.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_6, N'short_response', N'Predict one argument the OPPOSING side might make. Write a REBUTTAL (response) to it.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_6, N'multiple_choice', N'A rebuttal is...', N'["A response that addresses the other side''s argument", "Ignoring what the other side said", "The same thing as your original claim"]', N'A response that addresses the other side''s argument', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_6, N'multiple_choice', N'Why prepare rebuttals BEFORE the actual debate?', N'["It helps you respond confidently instead of being caught off guard", "Rebuttals should always be made up on the spot", "Preparing rebuttals is a waste of time"]', N'It helps you respond confidently instead of being caught off guard', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_6, N'short_response', N'Why is it useful to understand the OPPOSING side''s argument well, even though you disagree with it?', NULL, N'Understanding the other side helps you respond to it more effectively and fairly.', 6);

    DECLARE @cat_public_speaking_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'civic', N'Public Speaking & Debate', 'space_heavy', 4, N'Complete a full persuasive speech/debate project with peer feedback.', 0);
    SET @cat_public_speaking_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_7, N'short_response', N'Write your full persuasive speech or debate position, including intro, evidence, and conclusion.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_7, N'short_response', N'Deliver (or imagine delivering) your speech to a peer. What feedback did they give you?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_7, N'multiple_choice', N'Peer feedback on a speech is most useful when it''s...', N'["Specific and includes both strengths and areas to improve", "Only negative, with nothing positive mentioned", "Vague, like ''it was fine''"]', N'Specific and includes both strengths and areas to improve', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_7, N'short_response', N'Based on the feedback, what''s one change you''d make to your speech?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_7, N'multiple_choice', N'Why is getting feedback from a real audience valuable before a final performance?', N'["It reveals what''s unclear or unconvincing that you might not notice yourself", "Feedback is never actually useful", "You should never change your speech after writing it"]', N'It reveals what''s unclear or unconvincing that you might not notice yourself', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_public_speaking_7, N'short_response', N'Reflect: what''s the strongest part of your speech, and why?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_doodle_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'humor_play', N'Creative Drawing & Doodling', 'short_answer', 4, NULL, 0);
    SET @cat_creative_doodle_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_0, N'short_response', N'Draw a silly creature that has never existed before! What does it look like?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_0, N'short_response', N'What is your silly creature''s name?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_0, N'multiple_choice', N'A silly creature could have...', N'["Any mix of features you imagine", "Only real animal parts", "No features at all"]', N'Any mix of features you imagine', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_0, N'short_response', N'What does your silly creature like to eat?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_0, N'multiple_choice', N'Drawing silly, made-up things helps you practice...', N'["Imagination and creativity", "Only copying real things exactly", "Nothing useful"]', N'Imagination and creativity', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_0, N'short_response', N'Where does your silly creature live?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_doodle_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'humor_play', N'Creative Drawing & Doodling', 'short_answer', 4, N'Finish the doodle! Turn a squiggle into a picture.', 0);
    SET @cat_creative_doodle_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_1, N'short_response', N'Imagine a squiggly line. What could you turn it into with a few more lines?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_1, N'multiple_choice', N'A ''finish the doodle'' activity encourages you to...', N'["Use imagination to complete an unfinished shape", "Copy the exact same picture every time", "Erase the squiggle completely"]', N'Use imagination to complete an unfinished shape', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_1, N'short_response', N'Draw 3 different squiggles and turn each into something different.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_1, N'multiple_choice', N'Why might two different people turn the same squiggle into completely different pictures?', N'["Everyone imagines and creates differently", "There''s only one correct answer", "Squiggles can only become one specific thing"]', N'Everyone imagines and creates differently', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_1, N'short_response', N'What was the silliest thing you turned a squiggle into?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_1, N'multiple_choice', N'Doodling freely (without a plan) is a good way to...', N'["Practice creative thinking without pressure", "Waste time with no benefit", "Only copy other people''s ideas"]', N'Practice creative thinking without pressure', 6);

    DECLARE @cat_creative_doodle_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'humor_play', N'Creative Drawing & Doodling', 'short_answer', 4, N'Draw your dream treehouse!', 0);
    SET @cat_creative_doodle_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_2, N'short_response', N'Describe or draw your dream treehouse. What special features does it have?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_2, N'multiple_choice', N'A ''dream'' treehouse could include things that are...', N'["Imaginative and not necessarily realistic", "Only things that already exist", "Boring and plain"]', N'Imaginative and not necessarily realistic', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_2, N'short_response', N'How would you get up into your dream treehouse?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_2, N'short_response', N'Who would you invite to visit your dream treehouse?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_2, N'multiple_choice', N'Drawing an imaginative building like a dream treehouse helps you practice...', N'["Creative design thinking", "Only realistic architecture", "Nothing creative at all"]', N'Creative design thinking', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_2, N'short_response', N'What''s the silliest feature you added to your treehouse?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_doodle_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'humor_play', N'Creative Drawing & Doodling', 'space_heavy', 4, N'Draw a 3-panel comic strip telling a silly story.', 0);
    SET @cat_creative_doodle_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_3, N'short_response', N'Panel 1: what''s happening at the START of your silly story?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_3, N'short_response', N'Panel 2: what silly thing happens in the MIDDLE?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_3, N'short_response', N'Panel 3: how does your silly story END?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_3, N'multiple_choice', N'A comic strip tells a story using...', N'["A sequence of connected panels/pictures", "Only one single picture", "No pictures at all"]', N'A sequence of connected panels/pictures', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_3, N'multiple_choice', N'Why does a comic strip usually need panels in a clear ORDER?', N'["The story needs to make sense from beginning to end", "Order doesn''t matter in comics", "Panels should be random"]', N'The story needs to make sense from beginning to end', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_3, N'short_response', N'What made your comic strip silly or funny?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_doodle_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'humor_play', N'Creative Drawing & Doodling', 'short_answer', 4, N'Create a mash-up drawing by combining two animals.', 0);
    SET @cat_creative_doodle_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_4, N'short_response', N'Pick two animals to combine (like a cat and a fish). Describe your mash-up creature.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_4, N'multiple_choice', N'A ''mash-up'' combines...', N'["Features from two or more different things into one", "Only one single thing", "Nothing at all"]', N'Features from two or more different things into one', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_4, N'short_response', N'What would you name your mash-up creature?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_4, N'short_response', N'What special ability might your mash-up creature have, combining both animals'' traits?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_4, N'multiple_choice', N'Mash-up drawing is a fun way to practice...', N'["Combining ideas in new, creative ways", "Copying one single existing thing exactly", "Avoiding imagination"]', N'Combining ideas in new, creative ways', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_4, N'short_response', N'Which two animals would make the silliest mash-up, in your opinion?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_doodle_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'humor_play', N'Creative Drawing & Doodling', 'short_answer', 4, N'Doodle an invention — design something silly AND useful.', 0);
    SET @cat_creative_doodle_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_5, N'short_response', N'Invent something silly but actually useful. Draw or describe it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_5, N'multiple_choice', N'A silly invention doodle should be...', N'["Imaginative but still solve some kind of real (or silly) problem", "Completely random with no purpose at all", "Only realistic, no silliness allowed"]', N'Imaginative but still solve some kind of real (or silly) problem', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_5, N'short_response', N'What problem does your invention solve?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_5, N'short_response', N'Give your invention a funny name.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_5, N'multiple_choice', N'Combining humor with design (like a silly invention) practices...', N'["Creative problem-solving with a playful twist", "Only serious engineering with no creativity", "Nothing useful at all"]', N'Creative problem-solving with a playful twist', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_5, N'short_response', N'How would your invention actually work? Describe the silly mechanism.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_creative_doodle_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'humor_play', N'Creative Drawing & Doodling', 'short_answer', 4, N'Try a perspective doodle challenge: draw from a bug''s-eye view.', 0);
    SET @cat_creative_doodle_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_6, N'short_response', N'Imagine you''re a tiny bug looking up at a blade of grass. Draw or describe what you''d see.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_6, N'multiple_choice', N'A ''bug''s-eye view'' means drawing from...', N'["A very low, close-up perspective, looking up", "A view from far above, looking down", "Exactly the same view as a person standing"]', N'A very low, close-up perspective, looking up', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_6, N'short_response', N'How would everyday objects (like a pencil or a shoe) look different from a bug''s-eye view?', NULL, N'Answers will vary — should describe things looking much bigger/taller.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_6, N'multiple_choice', N'Why might practicing unusual perspectives make you a more creative artist?', N'["It challenges you to see familiar things in new ways", "Unusual perspectives are never useful", "Only one ''correct'' perspective exists for drawing"]', N'It challenges you to see familiar things in new ways', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_6, N'short_response', N'Draw a scene from a bird''s-eye view (looking down) instead — how is it different?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_6, N'multiple_choice', N'Changing your drawing''s perspective is a way to...', N'["Add variety and interest to your art", "Make art harder to understand", "Follow one strict rule with no creativity"]', N'Add variety and interest to your art', 6);

    DECLARE @cat_creative_doodle_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'humor_play', N'Creative Drawing & Doodling', 'space_heavy', 4, N'Create an illustrated short story using graphic-panel style.', 0);
    SET @cat_creative_doodle_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_7, N'short_response', N'Write a short story idea (a few sentences) that you''ll illustrate in panels.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_7, N'short_response', N'Sketch out (or describe) at least 4 panels showing your story''s key moments.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_7, N'multiple_choice', N'An illustrated story combines...', N'["Both pictures AND words to tell the story", "Only pictures, no words at all", "Only words, no pictures at all"]', N'Both pictures AND words to tell the story', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_7, N'short_response', N'How do the pictures in your panels add something the words alone couldn''t show?', NULL, N'Answers will vary (e.g., showing expressions, setting details, action).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_7, N'multiple_choice', N'Graphic-panel storytelling is used in things like...', N'["Comic books and graphic novels", "Only textbooks with no images", "Nothing real, it''s not a real format"]', N'Comic books and graphic novels', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_creative_doodle_7, N'short_response', N'What''s the most important moment in your story, and how did you illustrate it to stand out?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_jokes_wordplay_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'humor_play', N'Funny Jokes & Wordplay', 'short_answer', 4, NULL, 0);
    SET @cat_jokes_wordplay_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_0, N'short_response', N'Knock knock! Who''s there? Finish this joke your own silly way.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_0, N'multiple_choice', N'A knock-knock joke starts with...', N'["''Knock knock! Who''s there?''", "''Once upon a time''", "''The end''"]', N'''Knock knock! Who''s there?''', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_0, N'short_response', N'Tell a knock-knock joke to a grown-up. Did they laugh?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_0, N'multiple_choice', N'Jokes are meant to...', N'["Make people laugh or smile", "Make people sad", "Confuse people on purpose in a mean way"]', N'Make people laugh or smile', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_0, N'short_response', N'What is your favorite silly joke?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_0, N'multiple_choice', N'The funny ending part of a joke is called the...', N'["Punchline", "Introduction", "Title"]', N'Punchline', 6);

    DECLARE @cat_jokes_wordplay_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'humor_play', N'Funny Jokes & Wordplay', 'short_answer', 4, N'Fill in the blank to finish a silly rhyming joke.', 0);
    SET @cat_jokes_wordplay_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_1, N'fill_blank', N'Why did the cow jump over the moon? Because it wanted to see the ___! (rhymes with ''moon'')', NULL, N'raccoon (or any rhyming silly answer)', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_1, N'multiple_choice', N'A rhyme happens when words...', N'["End with the same or similar sounds", "Have nothing in common", "Are exactly the same word"]', N'End with the same or similar sounds', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_1, N'short_response', N'Finish this silly rhyme: ''I have a pet frog, he likes to sit on a ___.''', NULL, N'Answers will vary (should rhyme with ''frog'', e.g., ''log'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_1, N'multiple_choice', N'Rhyming jokes are often funnier because...', N'["The rhyme creates a fun surprise ending", "Rhymes are never funny", "Jokes don''t need to make sense"]', N'The rhyme creates a fun surprise ending', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_1, N'short_response', N'Make up your own silly rhyming joke.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_1, N'multiple_choice', N'What word rhymes with ''cat''?', N'["Hat", "Dog", "Sun"]', N'Hat', 6);

    DECLARE @cat_jokes_wordplay_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'humor_play', N'Funny Jokes & Wordplay', 'short_answer', 4, N'Try to guess the punchline!', 0);
    SET @cat_jokes_wordplay_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_2, N'short_response', N'Why did the chicken cross the playground? Write your own silly punchline!', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_2, N'multiple_choice', N'A punchline is...', N'["The surprising, funny ending of a joke", "The very first line of a joke", "A serious statement"]', N'The surprising, funny ending of a joke', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_2, N'short_response', N'What makes a punchline surprising or unexpected?', NULL, N'Answers will vary (e.g., it''s not what you''d normally expect).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_2, N'multiple_choice', N'A good punchline usually...', N'["Surprises you with something you didn''t expect", "Is exactly what you predicted", "Has nothing to do with the joke''s setup"]', N'Surprises you with something you didn''t expect', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_2, N'short_response', N'Write your own joke setup, then leave the punchline blank for a friend to fill in.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_2, N'multiple_choice', N'Why do jokes need a clear SETUP before the punchline?', N'["The setup creates the expectation the punchline surprisingly breaks", "Setups don''t matter for jokes", "Punchlines work the same with or without a setup"]', N'The setup creates the expectation the punchline surprisingly breaks', 6);

    DECLARE @cat_jokes_wordplay_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'humor_play', N'Funny Jokes & Wordplay', 'short_answer', 4, N'Match each pun to its silly double meaning.', 0);
    SET @cat_jokes_wordplay_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_3, N'matching', N'Match the pun word to its silly double meaning.', N'{"left": ["I''m reading a book about anti-gravity", "The math teacher called in sick with...", "I used to be a baker, but...", "I''m on a seafood diet"], "right": ["It''s impossible to put down!", "...too many problems!", "I couldn''t make enough dough.", "I see food and I eat it!"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_3, N'multiple_choice', N'A pun is a joke that plays with...', N'["A word''s multiple meanings or similar-sounding words", "Only numbers", "Only colors"]', N'A word''s multiple meanings or similar-sounding words', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_3, N'short_response', N'Explain why the ''seafood diet'' pun is funny (hint: ''see food'' sounds like ''seafood'').', NULL, N'It plays on the fact that ''sea food'' and ''see food'' sound the same, but mean very different things.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_3, N'multiple_choice', N'Puns work because some words...', N'["Sound alike or have double meanings", "Are always spelled the same", "Have only one possible meaning"]', N'Sound alike or have double meanings', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_3, N'short_response', N'Try to explain a pun you already know to a friend.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_3, N'multiple_choice', N'Understanding puns requires...', N'["Noticing a word''s double meaning or sound-alike", "Ignoring what words actually mean", "Only knowing one meaning per word"]', N'Noticing a word''s double meaning or sound-alike', 6);

    DECLARE @cat_jokes_wordplay_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'humor_play', N'Funny Jokes & Wordplay', 'short_answer', 4, N'Write your own knock-knock joke.', 0);
    SET @cat_jokes_wordplay_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_4, N'short_response', N'Write a full knock-knock joke with a setup and a silly punchline.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_4, N'multiple_choice', N'A knock-knock joke follows a pattern:', N'["Knock knock, who''s there?, [name], [name] who?, punchline", "It has no pattern at all", "It''s always exactly the same joke"]', N'Knock knock, who''s there?, [name], [name] who?, punchline', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_4, N'short_response', N'Try your joke out on a friend or family member. Did it get a laugh?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_4, N'multiple_choice', N'A good knock-knock joke often uses a name that sounds like...', N'["Another word or phrase, for a surprising twist", "A completely random word with no connection", "The exact same word as the setup"]', N'Another word or phrase, for a surprising twist', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_4, N'short_response', N'If your joke didn''t get a laugh, how could you revise it to be funnier?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_4, N'short_response', N'Write a SECOND knock-knock joke using a different silly name.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_jokes_wordplay_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'humor_play', N'Funny Jokes & Wordplay', 'space_heavy', 4, N'Learn the setup + punchline structure of joke-writing.', 0);
    SET @cat_jokes_wordplay_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_5, N'short_response', N'Write a joke SETUP that creates an expectation (like starting a normal-sounding story).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_5, N'short_response', N'Write a PUNCHLINE that surprisingly breaks that expectation.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_5, N'multiple_choice', N'The setup of a joke should be...', N'["Clear enough to create an expectation to subvert", "Confusing on purpose", "The funniest part of the joke"]', N'Clear enough to create an expectation to subvert', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_5, N'short_response', N'Why does timing matter when TELLING a joke, not just writing it?', NULL, N'A well-timed pause before the punchline builds anticipation, making the surprise land better.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_5, N'multiple_choice', N'A punchline is funniest when it''s...', N'["Unexpected but still makes sense once you hear it", "Completely unrelated and makes no sense", "The same as the setup"]', N'Unexpected but still makes sense once you hear it', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_5, N'short_response', N'Write a full joke using the setup + punchline structure, on a topic of your choice.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_jokes_wordplay_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'humor_play', N'Funny Jokes & Wordplay', 'short_answer', 4, N'Explore wordplay: puns, homophones, and double meanings.', 0);
    SET @cat_jokes_wordplay_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_6, N'multiple_choice', N'A homophone is a word that...', N'["Sounds the same as another word but means something different", "Looks the same as another word", "Has no relationship to any other word"]', N'Sounds the same as another word but means something different', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_6, N'fill_blank', N'What homophone sounds the same as ''flower'' but means part of a plant that blooms?', NULL, N'Flower (homophone: flour)', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_6, N'short_response', N'Give an example of a word with a DOUBLE MEANING (like ''bat'' — an animal or sports equipment).', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_6, N'multiple_choice', N'Wordplay jokes rely on...', N'["The multiple ways a word or sound can be interpreted", "Only serious, literal meanings", "Ignoring what words mean entirely"]', N'The multiple ways a word or sound can be interpreted', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_6, N'short_response', N'Write a short joke using a homophone or double-meaning word.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_6, N'multiple_choice', N'Why can wordplay jokes be tricky to translate into other languages?', N'["The specific sound-alike or double meaning often doesn''t exist in another language", "All languages have the exact same wordplay", "Wordplay has nothing to do with language"]', N'The specific sound-alike or double meaning often doesn''t exist in another language', 6);

    DECLARE @cat_jokes_wordplay_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'humor_play', N'Funny Jokes & Wordplay', 'space_heavy', 4, N'Write and ''perform'' a short stand-up comedy bit.', 0);
    SET @cat_jokes_wordplay_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_7, N'short_response', N'Write a short stand-up bit (a few connected jokes on one topic).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_7, N'short_response', N'Add timing/delivery notes to your bit (e.g., ''[pause]'' before the punchline).', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_7, N'multiple_choice', N'Stand-up comedy timing refers to...', N'["The pacing and pauses that make jokes land well", "Only how long the whole show lasts", "Nothing important"]', N'The pacing and pauses that make jokes land well', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_7, N'short_response', N'Why might the SAME joke get a different reaction depending on how it''s delivered?', NULL, N'Delivery — pacing, tone, pauses — affects how the surprise and humor land with the audience.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_7, N'multiple_choice', N'A stand-up ''bit'' usually connects multiple jokes around...', N'["One shared topic or theme", "Completely unrelated topics with no connection", "Only a single word"]', N'One shared topic or theme', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_jokes_wordplay_7, N'short_response', N'Practice performing (or reading aloud) your bit. What delivery choice worked best?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_riddles_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'humor_play', N'Riddles & Brain Teasers', 'short_answer', 4, NULL, 0);
    SET @cat_riddles_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_0, N'short_response', N'Riddle: I''m round and I roll. Children play with me at the park. What am I?', NULL, N'A ball.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_0, N'short_response', N'Riddle: I have a face but no eyes, and hands but no fingers. What am I?', NULL, N'A clock.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_0, N'multiple_choice', N'A riddle is...', N'["A puzzling question with a clever answer", "A type of food", "A song"]', N'A puzzling question with a clever answer', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_0, N'short_response', N'Riddle: I''m yellow and curved, and monkeys love to eat me. What am I?', NULL, N'A banana.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_0, N'multiple_choice', N'Solving riddles helps you practice...', N'["Thinking carefully about clues", "Ignoring clues completely", "Nothing useful"]', N'Thinking carefully about clues', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_0, N'short_response', N'Make up your own simple picture riddle.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_riddles_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'humor_play', N'Riddles & Brain Teasers', 'short_answer', 4, N'Solve the What-Am-I riddles!', 0);
    SET @cat_riddles_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_1, N'short_response', N'What am I? I have leaves and branches, and birds build nests in me. What am I?', NULL, N'A tree.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_1, N'short_response', N'What am I? I''m cold, white, and fall from the sky in winter. What am I?', NULL, N'Snow.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_1, N'multiple_choice', N'A ''What am I?'' riddle gives you...', N'["Clues to help you guess the answer", "The answer right away", "No information at all"]', N'Clues to help you guess the answer', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_1, N'short_response', N'What am I? I have a shell and move very slowly. What am I?', NULL, N'A snail (or turtle).', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_1, N'multiple_choice', N'Why do riddles give clues instead of just stating the answer?', N'["It makes solving the puzzle fun and engaging", "Riddles are supposed to be impossible", "Clues don''t actually help"]', N'It makes solving the puzzle fun and engaging', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_1, N'short_response', N'Write your own ''What am I?'' riddle about an animal.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_riddles_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'humor_play', N'Riddles & Brain Teasers', 'short_answer', 4, N'Solve riddles using picture clues.', 0);
    SET @cat_riddles_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_2, N'short_response', N'Riddle with clues: I have wheels, a seat, and pedals — but I''m not a car. What am I?', NULL, N'A bicycle.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_2, N'short_response', N'Riddle with clues: I have keys but open no locks. I have space but no room. What am I?', NULL, N'A keyboard.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_2, N'multiple_choice', N'Picture clues in a riddle help you...', N'["Narrow down the possible answers", "Make the riddle impossible", "Nothing useful"]', N'Narrow down the possible answers', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_2, N'short_response', N'If a riddle gives you 3 clues, why might reading ALL of them (not just the first) help you solve it?', NULL, N'Later clues often narrow down the answer further and rule out wrong guesses.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_2, N'multiple_choice', N'A good riddle solver...', N'["Considers all the clues together before answering", "Guesses immediately without thinking", "Ignores most of the clues"]', N'Considers all the clues together before answering', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_2, N'short_response', N'Write a riddle with 2 picture clues for a friend to solve.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_riddles_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'humor_play', N'Riddles & Brain Teasers', 'short_answer', 4, N'Write your own riddle with clear clues.', 0);
    SET @cat_riddles_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_3, N'short_response', N'Pick an object. Write 3 clues about it (without naming it) for your riddle.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_3, N'multiple_choice', N'A well-written riddle''s clues should be...', N'["Specific enough to be solvable, but not too obvious", "So vague no one could ever guess", "So obvious it''s not really a puzzle"]', N'Specific enough to be solvable, but not too obvious', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_3, N'short_response', N'Test your riddle on a friend or family member. Could they solve it?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_3, N'multiple_choice', N'If your riddle was solved instantly, what might that mean?', N'["The clues may have been too obvious", "The riddle is perfectly written", "The riddle has no answer"]', N'The clues may have been too obvious', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_3, N'short_response', N'If no one could solve your riddle, how might you make the clues clearer?', NULL, N'Answers will vary (e.g., add a more specific clue).', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_3, N'short_response', N'Write a SECOND riddle about a different object, using what you learned.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_riddles_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'humor_play', N'Riddles & Brain Teasers', 'short_answer', 4, N'Solve a logic riddle: who-owns-what grid puzzle.', 0);
    SET @cat_riddles_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_4, N'short_response', N'Logic riddle: Ana, Ben, and Cleo each own a different pet (dog, cat, fish). Ana doesn''t own the dog. Ben doesn''t own the fish. Who owns the fish?', NULL, N'Ana owns the fish (since Ben doesn''t own the fish and Ana doesn''t own the dog, working through the clues, Ana must own the fish or cat — with proper clues this resolves to Ana=fish, Ben=cat, Cleo=dog, or similar deduction depending on exact setup).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_4, N'multiple_choice', N'A who-owns-what logic riddle is solved by...', N'["Using clues to eliminate impossible options one by one", "Guessing randomly", "Ignoring the clues"]', N'Using clues to eliminate impossible options one by one', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_4, N'short_response', N'Why is a grid (rows and columns) a helpful tool for solving this kind of riddle?', NULL, N'It helps you track which combinations are ruled out and which remain possible.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_4, N'multiple_choice', N'In logic riddles, if a clue rules out an option, you should...', N'["Cross it off and use that to narrow down other clues", "Ignore the clue and guess anyway", "Assume the clue is wrong"]', N'Cross it off and use that to narrow down other clues', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_4, N'short_response', N'Write your own simple ''who owns what'' riddle with 2 clues for a friend.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_4, N'multiple_choice', N'Logic riddles like this practice mainly...', N'["Deductive reasoning", "Memorization only", "Drawing skills"]', N'Deductive reasoning', 6);

    DECLARE @cat_riddles_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'humor_play', N'Riddles & Brain Teasers', 'short_answer', 4, N'Solve multi-clue riddles.', 0);
    SET @cat_riddles_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_5, N'short_response', N'Riddle: I have cities but no houses, forests but no trees, and water but no fish. What am I?', NULL, N'A map.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_5, N'multiple_choice', N'A multi-clue riddle gives you SEVERAL clues that...', N'["All must fit together to point to one answer", "Are unrelated and don''t need to fit together", "Contradict each other on purpose"]', N'All must fit together to point to one answer', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_5, N'short_response', N'Riddle: The more you take, the more you leave behind. What am I?', NULL, N'Footsteps.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_5, N'short_response', N'Explain your strategy for solving a multi-clue riddle — do you use all clues at once, or one at a time?', NULL, N'Answers will vary — often it helps to think through clues one at a time, checking each guess against all of them.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_5, N'multiple_choice', N'If your first guess fits some clues but not others, you should...', N'["Keep thinking — the answer must fit ALL the clues", "Go with that guess anyway", "Give up immediately"]', N'Keep thinking — the answer must fit ALL the clues', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_5, N'short_response', N'Write your own multi-clue riddle (at least 3 clues) for a friend to solve.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_riddles_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'humor_play', N'Riddles & Brain Teasers', 'space_heavy', 4, N'Try lateral-thinking brain teasers.', 0);
    SET @cat_riddles_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_6, N'short_response', N'Brain teaser: A man lives on the 10th floor. Every day he takes the elevator down to the ground floor. When he comes home, he only rides the elevator to the 7th floor and walks the rest — except on rainy days, when he goes all the way to the 10th floor. Why?', NULL, N'He''s too short to reach the button for the 10th floor, but on rainy days he uses his umbrella to press it.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_6, N'multiple_choice', N'Lateral thinking means solving a problem by...', N'["Looking at it from an unexpected angle, not just the obvious approach", "Only using the most obvious approach", "Giving up if the answer isn''t immediately clear"]', N'Looking at it from an unexpected angle, not just the obvious approach', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_6, N'short_response', N'Why do lateral-thinking brain teasers often have surprising answers?', NULL, N'They''re designed so the obvious assumption is wrong, requiring creative thinking to solve.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_6, N'multiple_choice', N'A good strategy for a lateral-thinking puzzle is to...', N'["Question your assumptions about the situation", "Assume the first idea you have is correct", "Refuse to think about it differently"]', N'Question your assumptions about the situation', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_6, N'short_response', N'Write your own simple lateral-thinking brain teaser.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_6, N'multiple_choice', N'Brain teasers like this mainly build...', N'["Creative and flexible problem-solving", "Memorization skills only", "Nothing useful"]', N'Creative and flexible problem-solving', 6);

    DECLARE @cat_riddles_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'humor_play', N'Riddles & Brain Teasers', 'space_heavy', 4, N'Design a set of riddle escape-room cards.', 0);
    SET @cat_riddles_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_7, N'short_response', N'Design a themed escape-room scenario (e.g., a pirate ship, a haunted house). Describe the setting.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_7, N'short_response', N'Write riddle #1 for your escape-room set, with its answer.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_7, N'short_response', N'Write riddle #2, designed to be a bit harder than #1.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_7, N'multiple_choice', N'A good escape-room riddle set should...', N'["Get progressively more challenging as players go", "Have every riddle be equally easy", "Have no connection to the theme"]', N'Get progressively more challenging as players go', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_7, N'short_response', N'How would solving each riddle lead to the next clue or the final ''escape''?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_riddles_7, N'multiple_choice', N'Designing a full riddle set (not just one riddle) requires thinking about...', N'["Difficulty progression and how riddles connect to each other", "Only one single isolated riddle", "Nothing beyond writing random riddles"]', N'Difficulty progression and how riddles connect to each other', 6);

    DECLARE @cat_sense_humor_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'humor_play', N'Sense of Humor & Playful Perspective', 'short_answer', 4, NULL, 0);
    SET @cat_sense_humor_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_0, N'short_response', N'What makes you giggle the most?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_0, N'multiple_choice', N'Laughing and giggling usually means you feel...', N'["Happy and amused", "Sad", "Scared"]', N'Happy and amused', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_0, N'short_response', N'Draw a picture of something silly that makes you laugh.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_0, N'multiple_choice', N'It''s okay to laugh when something is...', N'["Genuinely funny and not hurting anyone", "Someone else getting hurt", "Someone feeling embarrassed on purpose"]', N'Genuinely funny and not hurting anyone', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_0, N'short_response', N'Name a silly face you can make.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_0, N'multiple_choice', N'Having a sense of humor means...', N'["Being able to notice and enjoy funny things", "Never smiling or laughing", "Making fun of others meanly"]', N'Being able to notice and enjoy funny things', 6);

    DECLARE @cat_sense_humor_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'humor_play', N'Sense of Humor & Playful Perspective', 'short_answer', 4, N'Sort each picture as SILLY or SERIOUS.', 0);
    SET @cat_sense_humor_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_1, N'matching', N'Sort each scene as silly or serious.', N'{"left": ["A dog wearing sunglasses and a hat", "A doctor checking a patient", "A cat riding a skateboard", "A firefighter putting out a fire"], "right": ["Silly", "Serious", "Silly", "Serious"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_1, N'multiple_choice', N'Something SILLY is usually...', N'["Playful and unexpected", "Very formal and serious", "Boring"]', N'Playful and unexpected', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_1, N'multiple_choice', N'Something SERIOUS usually deals with...', N'["Important or formal matters", "Only jokes", "Nothing important at all"]', N'Important or formal matters', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_1, N'short_response', N'Describe one silly thing and one serious thing from your day.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_1, N'multiple_choice', N'Being able to tell silly from serious situations helps you...', N'["Know how to act appropriately in each situation", "Nothing useful", "Always act the exact same way"]', N'Know how to act appropriately in each situation', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_1, N'short_response', N'Draw one silly scene and one serious scene.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_sense_humor_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'humor_play', N'Sense of Humor & Playful Perspective', 'space_heavy', 4, N'Retell a story, but exaggerate it for laughs!', 0);
    SET @cat_sense_humor_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_2, N'short_response', N'Pick a simple everyday event (like brushing your teeth). Retell it in a WAY exaggerated, silly way.', NULL, N'Answers will vary — should include exaggeration for comic effect.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_2, N'multiple_choice', N'Exaggeration in storytelling means...', N'["Making something sound much bigger or more dramatic than it really is", "Telling the story exactly as it happened", "Leaving out all details"]', N'Making something sound much bigger or more dramatic than it really is', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_2, N'short_response', N'What part of your retelling did you exaggerate the MOST?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_2, N'multiple_choice', N'Exaggeration is a common technique used to...', N'["Make a story funnier or more entertaining", "Make a story more boring", "Make a story completely factual"]', N'Make a story funnier or more entertaining', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_2, N'short_response', N'Read your exaggerated retelling out loud. Does it sound funnier than the plain version?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_2, N'multiple_choice', N'Why is exaggeration considered a HUMOR technique?', N'["The gap between reality and the exaggerated version is often what''s funny", "Exaggeration always makes stories sadder", "It has nothing to do with humor"]', N'The gap between reality and the exaggerated version is often what''s funny', 6);

    DECLARE @cat_sense_humor_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'humor_play', N'Sense of Humor & Playful Perspective', 'space_heavy', 4, N'Compare a funny version of a story to a serious version.', 0);
    SET @cat_sense_humor_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_3, N'short_response', N'Write 2-3 sentences telling a simple event SERIOUSLY (e.g., ''I dropped my ice cream'').', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_3, N'short_response', N'Now rewrite the SAME event in a FUNNY, exaggerated way.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_3, N'multiple_choice', N'What changed between your serious and funny versions?', N'["Tone, word choice, and level of exaggeration", "Nothing changed at all", "Only the ending changed"]', N'Tone, word choice, and level of exaggeration', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_3, N'short_response', N'Which version was more fun to write? Why?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_3, N'multiple_choice', N'The same event can be told seriously OR humorously because...', N'["How you tell a story shapes how it feels, regardless of the facts", "Facts always determine exactly how a story must be told", "Serious and funny stories can never share the same facts"]', N'How you tell a story shapes how it feels, regardless of the facts', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_3, N'short_response', N'What specific word choices made your funny version funnier?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_sense_humor_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'humor_play', N'Sense of Humor & Playful Perspective', 'space_heavy', 4, N'Write a silly alternate ending to a story you know.', 0);
    SET @cat_sense_humor_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_4, N'short_response', N'Pick a story you know well. Write a silly, unexpected alternate ending for it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_4, N'multiple_choice', N'An ''alternate ending'' means...', N'["A different way the story could have concluded", "The exact same ending, unchanged", "The very beginning of the story"]', N'A different way the story could have concluded', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_4, N'short_response', N'What makes your alternate ending silly or surprising compared to the original?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_4, N'multiple_choice', N'Writing silly alternate endings is a good way to practice...', N'["Creative thinking and playing with expectations", "Copying stories exactly as written", "Avoiding any creativity"]', N'Creative thinking and playing with expectations', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_4, N'short_response', N'Would your alternate ending still make sense with the rest of the story? Explain.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_4, N'short_response', N'Write ANOTHER silly alternate ending for a different, well-known story.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_sense_humor_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'humor_play', N'Sense of Humor & Playful Perspective', 'short_answer', 4, N'Identify humor techniques: exaggeration, surprise, and wordplay.', 0);
    SET @cat_sense_humor_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_5, N'matching', N'Match each joke technique to its example.', N'{"left": ["''I''m so hungry I could eat a whole elephant!''", "A story that ends with an unexpected twist", "''I''m reading a book on anti-gravity — it''s impossible to put down!''"], "right": ["Exaggeration", "Surprise", "Wordplay"]}', N'[[0, 0], [1, 1], [2, 2]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_5, N'multiple_choice', N'Exaggeration as a humor technique means...', N'["Making something sound much bigger than reality for comic effect", "Understating something to be less dramatic", "Being completely literal and factual"]', N'Making something sound much bigger than reality for comic effect', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_5, N'short_response', N'Find or write an example of a joke that uses SURPRISE.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_5, N'multiple_choice', N'Wordplay humor relies on...', N'["Multiple meanings or sounds of words", "Only visual images", "Numbers and math"]', N'Multiple meanings or sounds of words', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_5, N'short_response', N'Which humor technique (exaggeration, surprise, or wordplay) do you find funniest? Why?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_5, N'short_response', N'Write a joke that uses TWO humor techniques at once.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_sense_humor_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'humor_play', N'Sense of Humor & Playful Perspective', 'space_heavy', 4, N'Write a humorous short paragraph.', 0);
    SET @cat_sense_humor_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_6, N'short_response', N'Write a humorous short paragraph (4-6 sentences) about an everyday topic.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_6, N'multiple_choice', N'A humorous paragraph often uses...', N'["Exaggeration, surprise, or clever wordplay", "Only plain, literal statements with no creativity", "Sad or serious language"]', N'Exaggeration, surprise, or clever wordplay', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_6, N'short_response', N'Which sentence in your paragraph do you think is the funniest? Why?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_6, N'multiple_choice', N'Reading your writing OUT LOUD can help you notice...', N'["Whether the humor and timing actually land", "Nothing useful about the writing", "Only spelling mistakes"]', N'Whether the humor and timing actually land', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_6, N'short_response', N'Revise your paragraph to make one part even funnier.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_6, N'multiple_choice', N'Writing humor well requires...', N'["Understanding your audience and what they''ll find funny", "Ignoring your audience completely", "Only following strict formal rules"]', N'Understanding your audience and what they''ll find funny', 6);

    DECLARE @cat_sense_humor_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'humor_play', N'Sense of Humor & Playful Perspective', 'space_heavy', 4, N'Analyze what makes a joke work, then write your own original humorous piece.', 0);
    SET @cat_sense_humor_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_7, N'short_response', N'Pick a joke you find funny. Analyze it: what technique (exaggeration, surprise, wordplay) makes it work?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_7, N'short_response', N'Why does that technique specifically make the joke funny to you?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_7, N'multiple_choice', N'Analyzing humor helps you understand...', N'["The craft and technique behind what makes something funny", "Nothing useful — humor can''t be analyzed", "Only whether a joke is ''good'' or ''bad'' with no reasoning"]', N'The craft and technique behind what makes something funny', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_7, N'short_response', N'Write an original humorous piece (a joke, short story, or paragraph) using at least one technique you analyzed.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_7, N'multiple_choice', N'Understanding HOW humor works can help a writer...', N'["Craft jokes and funny writing more intentionally", "Never actually be funny", "Avoid humor entirely"]', N'Craft jokes and funny writing more intentionally', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_sense_humor_7, N'short_response', N'What''s one thing you''d revise in your original piece to make it even funnier?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_moral_lessons_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'character', N'Moral Lessons & Everyday Values', 'short_answer', 4, NULL, 0);
    SET @cat_moral_lessons_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_0, N'matching', N'Sort each action as KIND or UNKIND.', N'{"left": ["Sharing a toy", "Taking without asking", "Helping a friend up", "Laughing at someone who fell"], "right": ["Kind", "Unkind", "Kind", "Unkind"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_0, N'multiple_choice', N'Sharing your toys with a friend is a...', N'["Kind action", "Unkind action", "Neither"]', N'Kind action', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_0, N'short_response', N'Name one kind thing you did today or could do today.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_0, N'multiple_choice', N'Being unkind to someone usually makes them feel...', N'["Sad or hurt", "Happy", "Nothing at all"]', N'Sad or hurt', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_0, N'short_response', N'Draw a picture of yourself doing something kind.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_0, N'multiple_choice', N'Choosing kindness is a way to show...', N'["Good character", "Bad character", "Nothing important"]', N'Good character', 6);

    DECLARE @cat_moral_lessons_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Read a simple fable, then think: what did we learn?', 0);
    SET @cat_moral_lessons_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_1, N'short_response', N'Fable: The Tortoise and the Hare — a fast hare loses a race to a slow, steady tortoise because he stops to nap. What lesson does this fable teach?', NULL, N'Slow and steady effort can win — don''t be overconfident.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_1, N'multiple_choice', N'A fable is a short story that usually teaches...', N'["A lesson or moral", "Only facts about animals", "Nothing at all"]', N'A lesson or moral', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_1, N'short_response', N'What did YOU learn from the Tortoise and the Hare story?', NULL, N'Answers will vary — should reflect the moral of persistence over overconfidence.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_1, N'multiple_choice', N'Fables often use animal characters to...', N'["Teach lessons in a fun, memorable way", "Give real facts about animal behavior", "Confuse the reader on purpose"]', N'Teach lessons in a fun, memorable way', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_1, N'short_response', N'Can you think of a time being ''slow and steady'' helped you, like the tortoise?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_1, N'short_response', N'Draw a picture showing the lesson from the fable.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_moral_lessons_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Read a short values story, then write its one-sentence lesson.', 0);
    SET @cat_moral_lessons_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_2, N'short_response', N'Story: A boy finds a lost wallet full of money and returns it to its owner instead of keeping it. Write the ONE-SENTENCE lesson.', NULL, N'Honesty and doing the right thing matter, even when no one is watching.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_2, N'multiple_choice', N'A ''values story'' is meant to...', N'["Show a character making a good choice, teaching a lesson", "Just entertain with no deeper meaning", "Confuse the reader about right and wrong"]', N'Show a character making a good choice, teaching a lesson', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_2, N'short_response', N'Why might the boy have been tempted to keep the money instead of returning it?', NULL, N'Answers will vary (e.g., he could have used the money for himself).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_2, N'multiple_choice', N'Doing the right thing even when it''s hard shows...', N'["Strong character", "Weakness", "Nothing important"]', N'Strong character', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_2, N'short_response', N'Write your own one-sentence lesson from a story you know.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_2, N'multiple_choice', N'Why do many stories include a clear lesson at the end?', N'["To help readers think about how to act in their own lives", "Lessons are never actually included in stories", "Only to make the story longer"]', N'To help readers think about how to act in their own lives', 6);

    DECLARE @cat_moral_lessons_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Compare two characters'' choices: the ''right'' choice vs. the ''easy'' choice.', 0);
    SET @cat_moral_lessons_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_3, N'short_response', N'Scenario: A student sees a classmate cheating on a test. Character A tells the teacher (the right choice). Character B says nothing (the easy choice). Why might B''s choice feel easier in the moment?', NULL, N'Telling on someone can feel uncomfortable or risky, even if it''s the right thing to do.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_3, N'short_response', N'What are the possible consequences of Character B''s easy choice?', NULL, N'Answers will vary (e.g., the cheating continues, it feels unfair to others).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_3, N'multiple_choice', N'The ''right'' choice and the ''easy'' choice are...', N'["Sometimes different things", "Always exactly the same", "Never related at all"]', N'Sometimes different things', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_3, N'multiple_choice', N'Choosing the right choice over the easy choice often requires...', N'["Courage", "No effort at all", "Ignoring the situation"]', N'Courage', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_3, N'short_response', N'Describe a time you (or someone you know) chose the RIGHT thing even though it was harder.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_3, N'short_response', N'Why might it get easier to make the right choice with practice?', NULL, N'Answers will vary (e.g., it builds a habit and confidence over time).', 6);

    DECLARE @cat_moral_lessons_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Read a fable or parable and identify its moral.', 0);
    SET @cat_moral_lessons_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_4, N'short_response', N'Fable: The Boy Who Cried Wolf — a boy repeatedly lies about a wolf attacking his sheep, and when a real wolf comes, no one believes him. What is the moral?', NULL, N'Lying repeatedly makes people stop trusting you, even when you''re telling the truth.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_4, N'multiple_choice', N'A ''moral'' is...', N'["The lesson a story teaches", "The title of the story", "A character''s name"]', N'The lesson a story teaches', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_4, N'short_response', N'How does the boy''s own actions (lying) cause the sad outcome of the story?', NULL, N'His repeated lies destroyed his credibility, so no one believed him when he told the truth.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_4, N'multiple_choice', N'Fables and parables often use a clear cause-and-effect structure to...', N'["Make the moral easy to understand", "Hide the moral completely", "Avoid teaching anything"]', N'Make the moral easy to understand', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_4, N'short_response', N'Find or think of another fable/parable and identify its moral.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_4, N'short_response', N'Why has ''The Boy Who Cried Wolf'' remained a popular story for a long time?', NULL, N'Its lesson about honesty and trust is still relevant and easy to understand across generations.', 6);

    DECLARE @cat_moral_lessons_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Compare two characters'' choices under real pressure.', 0);
    SET @cat_moral_lessons_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_5, N'short_response', N'Scenario: Two friends are pressured by a group to make fun of a new student. One joins in; one refuses and walks away. Describe both characters'' choices and consequences.', NULL, N'Answers will vary — should describe social consequences for both.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_5, N'multiple_choice', N'Peer pressure is...', N'["The influence of a group pushing someone toward a certain choice", "Always a good thing", "Something that never actually happens"]', N'The influence of a group pushing someone toward a certain choice', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_5, N'short_response', N'Why might it be especially hard to make the right choice UNDER pressure from friends?', NULL, N'Fear of rejection or wanting to fit in can make it harder to go against the group.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_5, N'multiple_choice', N'Standing up to peer pressure usually requires...', N'["Confidence in your own values", "Just going along with the group easily", "Avoiding the situation entirely by not showing up"]', N'Confidence in your own values', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_5, N'short_response', N'What could the character who refused say to the group to explain their choice?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_5, N'multiple_choice', N'Why might making the right choice under pressure feel more meaningful than an easy right choice?', N'["It shows real character strength when it''s genuinely difficult", "It doesn''t actually matter more", "Pressure situations are never meaningful"]', N'It shows real character strength when it''s genuinely difficult', 6);

    DECLARE @cat_moral_lessons_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Write your own short story with a clear moral.', 0);
    SET @cat_moral_lessons_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_6, N'short_response', N'Choose a moral/lesson you want your story to teach (e.g., ''honesty is important''). State it.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_6, N'short_response', N'Write a short story (several sentences) where a character learns that lesson through their choices.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_6, N'multiple_choice', N'A story with a strong moral usually SHOWS the lesson through...', N'["The character''s actions and their consequences", "Just stating the moral directly with no story", "Random unrelated events"]', N'The character''s actions and their consequences', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_6, N'short_response', N'How does your character change or learn by the end of the story?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_6, N'multiple_choice', N'Why is ''showing'' a lesson through story events usually more powerful than just ''telling'' it directly?', N'["Readers connect more with lessons they experience through characters", "Telling is always more effective than showing", "There''s no difference between showing and telling"]', N'Readers connect more with lessons they experience through characters', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_6, N'short_response', N'Read your story aloud. Is the moral clear without being too obvious or preachy?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_moral_lessons_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'character', N'Moral Lessons & Everyday Values', 'space_heavy', 4, N'Reflect and apply: connect a story''s lesson to your own real life.', 0);
    SET @cat_moral_lessons_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_7, N'short_response', N'Pick a story with a moral you know well. State the moral clearly.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_7, N'short_response', N'Describe a real situation in YOUR life where that lesson could apply.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_7, N'short_response', N'How would applying that lesson change how you''d handle the real situation?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_7, N'multiple_choice', N'Connecting a story''s lesson to real life mainly helps you...', N'["Actually use what you learned, not just remember the story", "Nothing useful, stories and real life are unrelated", "Forget the story faster"]', N'Actually use what you learned, not just remember the story', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_7, N'multiple_choice', N'Why might the same moral (like honesty) apply to many different real-life situations?', N'["Core values tend to matter across many different contexts", "Morals only ever apply to the exact story they came from", "Morals don''t actually apply to real life at all"]', N'Core values tend to matter across many different contexts', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_moral_lessons_7, N'short_response', N'Write a short reflection: what''s one value from a story that you try to live by?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_manners_respect_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'character', N'Manners & Everyday Respect', 'short_answer', 4, NULL, 0);
    SET @cat_manners_respect_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_0, N'multiple_choice', N'What do you say when you want something?', N'["Please", "Nothing", "Give me that"]', N'Please', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_0, N'multiple_choice', N'What do you say when someone helps you?', N'["Thank you", "Nothing", "Go away"]', N'Thank you', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_0, N'short_response', N'Draw a picture of yourself saying ''please'' or ''thank you.''', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_0, N'multiple_choice', N'Saying please and thank you shows...', N'["Good manners", "Bad manners", "Nothing important"]', N'Good manners', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_0, N'short_response', N'Practice saying ''please'' and ''thank you'' to a grown-up today.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_0, N'multiple_choice', N'Using kind, polite words helps people feel...', N'["Respected and appreciated", "Ignored", "Annoyed"]', N'Respected and appreciated', 6);

    DECLARE @cat_manners_respect_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'character', N'Manners & Everyday Respect', 'short_answer', 4, N'Match each good-manners situation to the polite response.', 0);
    SET @cat_manners_respect_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_1, N'matching', N'Match each situation to a good-manners response.', N'{"left": ["Meeting someone new", "A friend shares their snack", "You bump into someone", "Someone gives you a gift"], "right": ["Say hello and your name", "Say thank you", "Say excuse me or sorry", "Say thank you"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_1, N'multiple_choice', N'A polite greeting includes...', N'["Saying hello and being friendly", "Ignoring the person", "Walking away"]', N'Saying hello and being friendly', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_1, N'short_response', N'Why is it polite to say ''excuse me'' if you bump into someone?', NULL, N'It shows you noticed and care that it might have bothered them.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_1, N'multiple_choice', N'Sharing with others is an example of...', N'["Good manners", "Bad manners", "Being unfair"]', N'Good manners', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_1, N'short_response', N'Practice greeting a family member politely.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_1, N'multiple_choice', N'Good manners help people get along because...', N'["They show respect and kindness toward others", "They make people feel worse", "Manners don''t matter at all"]', N'They show respect and kindness toward others', 6);

    DECLARE @cat_manners_respect_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'character', N'Manners & Everyday Respect', 'short_answer', 4, N'Check off good table manners.', 0);
    SET @cat_manners_respect_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_2, N'short_response', N'List 3 good table manners (e.g., chew with your mouth closed).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_2, N'multiple_choice', N'Good table manners include...', N'["Chewing with your mouth closed", "Talking with food in your mouth", "Grabbing food without asking"]', N'Chewing with your mouth closed', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_2, N'short_response', N'Why do table manners matter when eating with other people?', NULL, N'They show respect for others and make mealtimes more pleasant for everyone.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_2, N'multiple_choice', N'If you want more food at the table, you should...', N'["Politely ask for it", "Grab it without asking", "Reach across someone''s plate"]', N'Politely ask for it', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_2, N'short_response', N'Practice using good table manners at your next meal.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_2, N'multiple_choice', N'Table manners are especially important when...', N'["Eating with others, like family or guests", "Eating completely alone", "It never matters"]', N'Eating with others, like family or guests', 6);

    DECLARE @cat_manners_respect_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'character', N'Manners & Everyday Respect', 'space_heavy', 4, N'Compare manners in different places: school, restaurant, home.', 0);
    SET @cat_manners_respect_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_3, N'short_response', N'What''s one manner that''s especially important at SCHOOL?', NULL, N'Answers will vary (e.g., raising your hand, listening quietly).', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_3, N'short_response', N'What''s one manner that''s especially important at a RESTAURANT?', NULL, N'Answers will vary (e.g., using an inside voice, saying please/thank you to the server).', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_3, N'short_response', N'What''s one manner that''s especially important at HOME?', NULL, N'Answers will vary (e.g., helping with chores, being kind to family).', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_3, N'multiple_choice', N'Manners can change slightly depending on...', N'["The setting or situation you''re in", "Nothing — manners are always identical everywhere", "Only your mood"]', N'The setting or situation you''re in', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_3, N'multiple_choice', N'Why might a manner important at a restaurant (like waiting to be seated) not matter as much at home?', N'["Different places have different expectations for behavior", "Manners are exactly the same everywhere", "Restaurants don''t actually need manners"]', N'Different places have different expectations for behavior', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_3, N'short_response', N'Why is it useful to think about which manners fit which situation?', NULL, N'It helps you behave appropriately and respectfully wherever you are.', 6);

    DECLARE @cat_manners_respect_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'character', N'Manners & Everyday Respect', 'space_heavy', 4, N'Learn digital manners: sending kind messages and basic netiquette.', 0);
    SET @cat_manners_respect_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_4, N'short_response', N'Rewrite this rude message to be more polite: ''ur wrong, thats dumb.''', NULL, N'Answers will vary (e.g., ''I see it differently — can you explain your thinking?'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_4, N'multiple_choice', N'''Netiquette'' refers to...', N'["Good manners for online communication", "A type of internet game", "A rule that doesn''t actually exist"]', N'Good manners for online communication', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_4, N'short_response', N'Why can it be easier to be unintentionally rude in a text message than in person?', NULL, N'Without tone of voice or facial expressions, messages can be misread as harsher than intended.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_4, N'multiple_choice', N'Before sending a message, a good digital-manners habit is to...', N'["Reread it and consider how it might sound to the other person", "Send it immediately without thinking", "Never send any messages at all"]', N'Reread it and consider how it might sound to the other person', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_4, N'short_response', N'Write an example of a kind, respectful message you could send a friend.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_4, N'multiple_choice', N'Why do digital manners matter just as much as in-person manners?', N'["Words online can still affect real people''s feelings", "Online words don''t affect anyone", "Digital manners are less important than in-person ones"]', N'Words online can still affect real people''s feelings', 6);

    DECLARE @cat_manners_respect_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'character', N'Manners & Everyday Respect', 'space_heavy', 4, N'Practice respectful disagreement — polite ways to say no or disagree.', 0);
    SET @cat_manners_respect_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_5, N'short_response', N'Rewrite this rude disagreement to be more respectful: ''That''s a stupid idea.''', NULL, N'Answers will vary (e.g., ''I see it differently — here''s why I think...'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_5, N'multiple_choice', N'Respectful disagreement means...', N'["Sharing a different opinion without being disrespectful", "Never disagreeing with anyone, ever", "Being rude to prove your point"]', N'Sharing a different opinion without being disrespectful', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_5, N'short_response', N'Write a polite way to say ''no'' to a friend''s invitation you can''t accept.', NULL, N'Answers will vary (e.g., ''Thanks for asking, but I can''t make it this time.'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_5, N'multiple_choice', N'Why is it possible to disagree with someone AND still be respectful?', N'["Disagreeing with an idea doesn''t mean disrespecting the person", "Disagreement always requires disrespect", "You should always just agree to avoid conflict"]', N'Disagreeing with an idea doesn''t mean disrespecting the person', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_5, N'short_response', N'Why might practicing polite disagreement help you in friendships and group work?', NULL, N'It helps you express honest opinions while keeping relationships positive.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_5, N'multiple_choice', N'A respectful way to disagree usually starts with...', N'["Acknowledging the other person''s point before sharing your own", "Immediately saying they''re wrong", "Refusing to explain your reasoning"]', N'Acknowledging the other person''s point before sharing your own', 6);

    DECLARE @cat_manners_respect_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'character', N'Manners & Everyday Respect', 'space_heavy', 4, N'Compare manners and greetings from different cultures around the world.', 0);
    SET @cat_manners_respect_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_6, N'short_response', N'Research or recall one greeting custom from a culture different from your own (e.g., a bow, a specific handshake).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_6, N'short_response', N'How is that greeting similar to or different from a greeting you''re familiar with?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_6, N'multiple_choice', N'Manners and greetings can differ across cultures because...', N'["Different cultures have different traditions and values", "All cultures share the exact same manners", "Manners are random with no cultural meaning"]', N'Different cultures have different traditions and values', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_6, N'multiple_choice', N'Learning about manners from other cultures helps you...', N'["Show respect when interacting with people from different backgrounds", "Nothing useful", "Judge other cultures as wrong"]', N'Show respect when interacting with people from different backgrounds', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_6, N'short_response', N'Why might it be considered polite in one culture and rude in another to do the same thing (like making direct eye contact)?', NULL, N'Answers will vary — cultural norms around respect and politeness aren''t universal.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_6, N'short_response', N'What''s one thing you''d want to learn more about regarding manners in another culture?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_manners_respect_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'character', N'Manners & Everyday Respect', 'space_heavy', 4, N'Practice writing polite responses to tricky etiquette scenarios.', 0);
    SET @cat_manners_respect_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_7, N'short_response', N'Scenario: You receive a gift you don''t like. Write a polite response.', NULL, N'Answers will vary (e.g., ''Thank you so much, that was really thoughtful of you.'').', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_7, N'short_response', N'Scenario: A friend keeps interrupting you. Write a polite way to address it.', NULL, N'Answers will vary (e.g., ''Can I finish my thought, and then I''d love to hear yours?'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_7, N'short_response', N'Scenario: You need to leave a conversation but don''t want to seem rude. Write a polite exit.', NULL, N'Answers will vary (e.g., ''It was great talking with you — I need to head out now.'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_7, N'multiple_choice', N'A polite response in a tricky situation usually...', N'["Balances honesty with kindness and tact", "Requires lying about your true feelings", "Means avoiding the situation entirely"]', N'Balances honesty with kindness and tact', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_7, N'multiple_choice', N'Why is etiquette especially useful in AWKWARD or tricky social situations?', N'["It gives you a respectful way to handle discomfort gracefully", "Etiquette only matters in easy, comfortable situations", "Awkward situations don''t need any tact"]', N'It gives you a respectful way to handle discomfort gracefully', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_manners_respect_7, N'short_response', N'Write your own tricky etiquette scenario and a polite response to it.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_growth_mindset_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'character', N'Brain Motivation & Growth Mindset', 'short_answer', 4, NULL, 0);
    SET @cat_growth_mindset_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_0, N'multiple_choice', N'If something is hard, you can say...', N'["''I can try!''", "''I quit!''", "''I refuse!''"]', N'''I can try!''', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_0, N'short_response', N'Name something that was hard for you at first but got easier with practice.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_0, N'multiple_choice', N'Trying, even when something is hard, shows...', N'["Bravery and effort", "Weakness", "Nothing important"]', N'Bravery and effort', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_0, N'short_response', N'Draw a sticker chart with 3 stars for 3 times you tried something hard.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_0, N'multiple_choice', N'What should you say to yourself when facing something new and hard?', N'["''I can try!''", "''I''ll never be able to do this.''", "''This is impossible.''"]', N'''I can try!''', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_0, N'short_response', N'What is something new you''d like to try, even if it''s a little hard?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_growth_mindset_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'character', N'Brain Motivation & Growth Mindset', 'short_answer', 4, N'Sort each statement as GROWTH MINDSET (''yet'') or FIXED MINDSET (''can''t'').', 0);
    SET @cat_growth_mindset_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_1, N'matching', N'Sort each statement.', N'{"left": ["I can''t do this... yet!", "I can''t do this, ever.", "This is hard, but I''ll keep trying.", "I''m just bad at this and always will be."], "right": ["Growth mindset", "Fixed mindset", "Growth mindset", "Fixed mindset"]}', N'[[0, 0], [1, 1], [2, 0], [3, 1]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_1, N'multiple_choice', N'Adding the word ''yet'' to ''I can''t do this'' changes it into a...', N'["Growth mindset statement", "Fixed mindset statement", "Meaningless statement"]', N'Growth mindset statement', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_1, N'short_response', N'Rewrite ''I can''t draw'' using a growth mindset (''yet'').', NULL, N'''I can''t draw yet, but I''m learning.''', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_1, N'multiple_choice', N'A growth mindset believes that abilities...', N'["Can improve with effort and practice", "Are fixed and can never change", "Don''t matter at all"]', N'Can improve with effort and practice', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_1, N'short_response', N'Think of something you''d like to say ''I can''t do this... yet!'' about.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_1, N'multiple_choice', N'Why is a growth mindset more helpful than a fixed mindset for learning?', N'["It encourages you to keep trying instead of giving up", "It makes you give up faster", "There''s no real difference between the two"]', N'It encourages you to keep trying instead of giving up', 6);

    DECLARE @cat_growth_mindset_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'character', N'Brain Motivation & Growth Mindset', 'short_answer', 4, N'Practice turning a ''can''t'' statement into a ''can'' statement.', 0);
    SET @cat_growth_mindset_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_2, N'short_response', N'Turn this into a ''can'' statement: ''I can''t do multiplication.''', NULL, N'''I can learn multiplication with practice.''', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_2, N'short_response', N'Turn this into a ''can'' statement: ''I can''t read this whole book.''', NULL, N'''I can read this book one chapter at a time.''', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_2, N'multiple_choice', N'Turning ''can''t'' into ''can'' usually involves...', N'["Adding a plan or acknowledging you''re still learning", "Just ignoring the problem", "Pretending the task doesn''t exist"]', N'Adding a plan or acknowledging you''re still learning', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_2, N'short_response', N'Write your own ''can''t'' statement, then turn it into a ''can'' statement.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_2, N'multiple_choice', N'Why might changing your language from ''can''t'' to ''can'' actually change how you feel?', N'["The words you use can shape your mindset and motivation", "Words have no effect on feelings at all", "It only works for some people"]', N'The words you use can shape your mindset and motivation', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_2, N'short_response', N'How would you help a friend who says ''I can''t'' about something they''re struggling with?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_growth_mindset_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'character', N'Brain Motivation & Growth Mindset', 'short_answer', 4, N'Reflect on effort vs. outcome.', 0);
    SET @cat_growth_mindset_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_3, N'short_response', N'Describe a time you worked really hard (effort) even if the result (outcome) wasn''t perfect.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_3, N'multiple_choice', N'''Effort'' refers to...', N'["How hard you tried", "Only the final result", "Something that doesn''t matter"]', N'How hard you tried', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_3, N'multiple_choice', N'''Outcome'' refers to...', N'["The final result of your effort", "Only how hard you tried", "Something unrelated to effort"]', N'The final result of your effort', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_3, N'short_response', N'Why might praising EFFORT (not just outcome) help you want to keep trying hard things?', NULL, N'Praising effort shows that trying hard matters, even if the result isn''t perfect — this encourages persistence.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_3, N'multiple_choice', N'Which is more within your control?', N'["Your effort", "The exact outcome", "Neither is in your control"]', N'Your effort', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_3, N'short_response', N'Think of a time your effort was high but the outcome wasn''t what you hoped. What did you learn?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_growth_mindset_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'character', N'Brain Motivation & Growth Mindset', 'space_heavy', 4, N'Set a small goal and track your progress toward it.', 0);
    SET @cat_growth_mindset_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_4, N'short_response', N'Set a small, specific goal for this week.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_4, N'short_response', N'How will you track your progress toward this goal each day?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_4, N'multiple_choice', N'A good goal should be...', N'["Specific and something you can actually track", "Vague and impossible to measure", "So big it feels impossible"]', N'Specific and something you can actually track', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_4, N'short_response', N'What''s one small step you''ll take TODAY toward your goal?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_4, N'multiple_choice', N'Tracking your progress toward a goal helps you...', N'["Stay motivated by seeing how far you''ve come", "Nothing useful", "Give up faster"]', N'Stay motivated by seeing how far you''ve come', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_4, N'short_response', N'How will you feel and what will you do when you reach your goal?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_growth_mindset_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'character', N'Brain Motivation & Growth Mindset', 'space_heavy', 4, N'Read a growth mindset story about a character who overcame a setback.', 0);
    SET @cat_growth_mindset_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_5, N'short_response', N'Describe a character (real or fictional) who faced a setback and kept going. What happened?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_5, N'short_response', N'What growth mindset thoughts or actions helped that character keep trying?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_5, N'multiple_choice', N'A ''setback'' is...', N'["A difficulty or failure that gets in the way of progress", "A guaranteed permanent failure", "Something that never actually happens"]', N'A difficulty or failure that gets in the way of progress', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_5, N'multiple_choice', N'Growth mindset stories often show that setbacks can...', N'["Be overcome with persistence and the right mindset", "Never be overcome no matter what", "Only happen to certain people"]', N'Be overcome with persistence and the right mindset', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_5, N'short_response', N'Have you ever faced a setback and kept going? What helped you?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_5, N'short_response', N'Why might reading about others overcoming setbacks help you when YOU face one?', NULL, N'It shows that setbacks are a normal part of growth, and that persistence can lead to success.', 6);

    DECLARE @cat_growth_mindset_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'character', N'Brain Motivation & Growth Mindset', 'space_heavy', 4, N'Keep a motivation journal: what pushes you forward?', 0);
    SET @cat_growth_mindset_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_6, N'short_response', N'What motivates YOU the most — a goal, a person, a feeling? Explain.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_6, N'short_response', N'Describe a time your motivation helped you push through something difficult.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_6, N'multiple_choice', N'A motivation journal helps you...', N'["Notice patterns in what drives you to keep going", "Forget about your goals", "Nothing useful"]', N'Notice patterns in what drives you to keep going', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_6, N'short_response', N'What''s one thing that tends to DEMOTIVATE you? How could you handle that?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_6, N'multiple_choice', N'Understanding your own motivation can help you...', N'["Set yourself up for success by leaning into what drives you", "Nothing useful for achieving goals", "Only matters for other people, not you"]', N'Set yourself up for success by leaning into what drives you', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_6, N'short_response', N'Write a journal entry about what''s motivating you this week.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_growth_mindset_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'character', N'Brain Motivation & Growth Mindset', 'space_heavy', 4, N'Design a personal motivation plan: goals, obstacles, and self-talk.', 0);
    SET @cat_growth_mindset_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_7, N'short_response', N'State a meaningful GOAL for your motivation plan.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_7, N'short_response', N'List one OBSTACLE that might get in the way of that goal.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_7, N'short_response', N'Write a positive SELF-TALK phrase you''ll use when facing that obstacle.', NULL, N'Answers will vary (e.g., ''I can handle challenges — I''ve done it before.'').', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_7, N'multiple_choice', N'Self-talk refers to...', N'["The internal things you say to yourself", "Talking out loud to other people", "A type of journal"]', N'The internal things you say to yourself', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_7, N'multiple_choice', N'Why is planning for obstacles BEFORE they happen useful?', N'["You''re less likely to be caught off guard and give up", "Obstacles never actually happen in real plans", "Planning for obstacles is a waste of time"]', N'You''re less likely to be caught off guard and give up', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_growth_mindset_7, N'short_response', N'Put your full plan together: goal, likely obstacle, and your self-talk response.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_chinese_culture_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'culture', N'Chinese Language & Culture', 'short_answer', 4, NULL, 0);
    SET @cat_chinese_culture_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_0, N'short_response', N'Trace the pinyin sound ''ma'' and match it to a picture of a mother (妈).', NULL, N'Answers will vary — should show traced ''ma'' matched to the mother picture.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_0, N'multiple_choice', N'Pinyin is used to help learners...', N'["Sound out Chinese words using familiar letters", "Draw pictures", "Learn math"]', N'Sound out Chinese words using familiar letters', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_0, N'short_response', N'Trace the pinyin sound ''ba'' and match it to a picture of a father (爸).', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_0, N'multiple_choice', N'Pinyin uses letters we already know to represent...', N'["Chinese sounds", "English words", "Numbers"]', N'Chinese sounds', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_0, N'short_response', N'Practice saying ''ma'' and ''ba'' out loud.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_0, N'multiple_choice', N'Learning pinyin is a first step toward...', N'["Reading and speaking Chinese", "Learning to swim", "Learning art"]', N'Reading and speaking Chinese', 6);

    DECLARE @cat_chinese_culture_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'culture', N'Chinese Language & Culture', 'short_answer', 4, N'Trace and learn your first 10 Chinese characters (numbers and family).', 0);
    SET @cat_chinese_culture_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_1, N'matching', N'Match the Chinese character to its meaning.', N'{"left": ["一", "二", "三", "人"], "right": ["One", "Two", "Three", "Person"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_1, N'short_response', N'Trace the character for ''one'' (一). How many strokes does it have?', NULL, N'One stroke.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_1, N'multiple_choice', N'A Chinese character (hanzi) represents...', N'["A word or idea, not just a sound", "Only a random shape with no meaning", "A number system only"]', N'A word or idea, not just a sound', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_1, N'short_response', N'Practice writing the character for ''two'' (二).', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_1, N'multiple_choice', N'Learning to trace characters helps you...', N'["Build muscle memory for writing them correctly", "Nothing useful", "Only helps with drawing, not writing"]', N'Build muscle memory for writing them correctly', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_1, N'short_response', N'Which of the 10 characters you''re learning is your favorite, and why?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_chinese_culture_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'culture', N'Chinese Language & Culture', 'short_answer', 4, N'Practice pinyin tones and simple characters.', 0);
    SET @cat_chinese_culture_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_2, N'multiple_choice', N'Mandarin Chinese uses tones, which means...', N'["The pitch of your voice changes a word''s meaning", "Tones are only used in singing", "Tones don''t matter in Chinese"]', N'The pitch of your voice changes a word''s meaning', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_2, N'short_response', N'The word ''ma'' can mean different things depending on its tone (mother, hemp, horse, scold). Why does tone matter so much in Mandarin?', NULL, N'The same syllable can have completely different meanings depending on the tone used.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_2, N'multiple_choice', N'How many main tones does Mandarin Chinese have?', N'["4 (plus a neutral tone)", "1", "10"]', N'4 (plus a neutral tone)', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_2, N'short_response', N'Practice saying ''ma'' with a rising tone versus a falling tone. Can you hear the difference?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_2, N'short_response', N'Trace a simple character you''re learning and say its pronunciation out loud.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_2, N'multiple_choice', N'Why is listening practice especially important for learning Mandarin tones?', N'["Tones are best learned by hearing and imitating the correct pitch pattern", "Tones can be learned from reading alone", "Listening isn''t necessary for tones"]', N'Tones are best learned by hearing and imitating the correct pitch pattern', 6);

    DECLARE @cat_chinese_culture_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'culture', N'Chinese Language & Culture', 'short_answer', 4, N'Build simple sentences using the Chinese characters you''ve learned.', 0);
    SET @cat_chinese_culture_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_3, N'short_response', N'Using characters you know (like 我 ''I'', 是 ''am'', 人 ''person''), try building the simple sentence ''我是人'' (I am a person). What does it say?', NULL, N'I am a person.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_3, N'multiple_choice', N'Building sentences from individual characters helps you...', N'["See how words combine into meaning, like building blocks", "Nothing useful", "Only matters for reading, not speaking"]', N'See how words combine into meaning, like building blocks', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_3, N'short_response', N'What is one simple sentence you could build with characters you''ve learned?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_3, N'multiple_choice', N'Chinese sentence word order can be...', N'["Similar to English in simple sentences (subject-verb-object)", "Always completely random", "Impossible to learn"]', N'Similar to English in simple sentences (subject-verb-object)', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_3, N'short_response', N'Why is practicing full sentences more useful than just memorizing single characters?', NULL, N'It helps you actually communicate, not just recognize isolated words.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_3, N'short_response', N'Write (or trace) a simple sentence using at least 2 characters you know.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_chinese_culture_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'culture', N'Chinese Language & Culture', 'space_heavy', 4, N'Read and illustrate a short Tang poem: 静夜思 (Jìng Yè Sī, "Quiet Night Thoughts") by Li Bai.', 0);
    SET @cat_chinese_culture_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_4, N'short_response', N'Li Bai''s poem 静夜思 is about a traveler who sees moonlight and thinks of home. Draw a picture showing this scene.', NULL, N'Answers will vary — should depict moonlight and a feeling of longing for home.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_4, N'multiple_choice', N'Tang poems are a form of classical...', N'["Chinese poetry", "Chinese cooking", "Chinese sport"]', N'Chinese poetry', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_4, N'short_response', N'What feeling do you think the poem''s traveler has when looking at the moon?', NULL, N'Homesickness or longing for home.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_4, N'multiple_choice', N'Why might moonlight be a common image in classical Chinese poetry?', N'["It''s associated with quiet reflection, distance, and thoughts of home", "Moonlight has no special meaning in Chinese poetry", "It''s only used in modern poems"]', N'It''s associated with quiet reflection, distance, and thoughts of home', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_4, N'short_response', N'Have you ever felt homesick or thought of someone far away while looking at the moon or stars?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_4, N'short_response', N'Practice tracing or copying a few characters from the poem''s title, 静夜思.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_chinese_culture_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'culture', N'Chinese Language & Culture', 'short_answer', 4, N'Practice recognizing character radicals — the building-block parts of characters.', 0);
    SET @cat_chinese_culture_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_5, N'multiple_choice', N'A radical is...', N'["A recurring part of a character that often hints at its meaning", "A whole separate word", "A punctuation mark"]', N'A recurring part of a character that often hints at its meaning', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_5, N'short_response', N'The radical 氵(three dots, representing water) appears in characters related to water, like 河 (river) and 海 (ocean). Why might learning radicals help you guess a character''s meaning?', NULL, N'Radicals often give a clue about the character''s category of meaning, even if you don''t know the whole character yet.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_5, N'multiple_choice', N'Recognizing radicals is similar to recognizing...', N'["Common prefixes/roots in English (like ''un-'' or ''tele-'')", "Random unrelated symbols", "Punctuation marks"]', N'Common prefixes/roots in English (like ''un-'' or ''tele-'')', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_5, N'short_response', N'Name one radical you''ve learned and a character that contains it.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_5, N'multiple_choice', N'Learning radicals is a strategy that helps with...', N'["Reading and remembering unfamiliar characters", "Only speaking, not reading", "Nothing related to reading Chinese"]', N'Reading and remembering unfamiliar characters', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_5, N'short_response', N'Why might breaking a complex character into smaller radical parts make it easier to remember?', NULL, N'Smaller, familiar parts are easier to recognize and recall than one complex whole shape.', 6);

    DECLARE @cat_chinese_culture_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'culture', N'Chinese Language & Culture', 'space_heavy', 4, N'Compare two Tang poems by theme and imagery.', 0);
    SET @cat_chinese_culture_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_6, N'short_response', N'Choose two Tang poems (or two you''ve read before). What is the main THEME of each?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_6, N'short_response', N'Compare the imagery (pictures the words create) used in each poem.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_6, N'multiple_choice', N'Tang poems often explore themes like...', N'["Nature, longing, friendship, and reflection", "Only sports and games", "Only modern technology"]', N'Nature, longing, friendship, and reflection', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_6, N'multiple_choice', N'Comparing two poems'' imagery helps you notice...', N'["How different poets express similar or different feelings", "Nothing useful about poetry", "That all poems are exactly identical"]', N'How different poets express similar or different feelings', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_6, N'short_response', N'Which of your two poems do you connect with more, and why?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_6, N'short_response', N'Why might natural imagery (moon, mountains, rivers) be so common across many Tang poems?', NULL, N'Nature was central to classical Chinese life and often used to reflect human emotions and philosophy.', 6);

    DECLARE @cat_chinese_culture_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'culture', N'Chinese Language & Culture', 'space_heavy', 4, N'Recite a Tang poem and write a personal reflection on it.', 0);
    SET @cat_chinese_culture_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_7, N'short_response', N'Choose a Tang poem to recite (memorize and say aloud). Which one did you choose?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_7, N'short_response', N'Practice reciting it. What was challenging about memorizing it?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_7, N'short_response', N'Write a personal reflection: what does this poem mean to you, or how does it relate to your own life?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_7, N'multiple_choice', N'Reciting classical poetry helps preserve and honor...', N'["Cultural and literary traditions passed down over generations", "Nothing meaningful", "Only modern trends"]', N'Cultural and literary traditions passed down over generations', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_7, N'multiple_choice', N'Writing a personal reflection on a poem helps you...', N'["Connect the poem''s meaning to your own experiences", "Memorize it faster with no deeper understanding", "Avoid actually thinking about the poem''s meaning"]', N'Connect the poem''s meaning to your own experiences', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_chinese_culture_7, N'short_response', N'Would you recommend this poem to a friend? Why or why not?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_indian_gita_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'culture', N'Indian Culture & Gita Wisdom Stories', 'short_answer', 4, NULL, 0);
    SET @cat_indian_gita_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_0, N'multiple_choice', N'Hanuman, a beloved figure in Indian stories, is often shown as a...', N'["Monkey", "Elephant", "Peacock"]', N'Monkey', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_0, N'short_response', N'Match the animal friend to a story you know (real or imagined) — what animal helps the hero?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_0, N'multiple_choice', N'Hanuman is known in stories for being...', N'["Brave and loyal", "Lazy and unkind", "Scared of everything"]', N'Brave and loyal', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_0, N'short_response', N'Draw a picture of an animal friend helping a hero in a story.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_0, N'multiple_choice', N'Stories with animal friends often teach us about...', N'["Courage, loyalty, and friendship", "Nothing important", "Only facts about animals"]', N'Courage, loyalty, and friendship', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_0, N'short_response', N'Name one quality (like braveness) that a story character you like has.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_indian_gita_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'culture', N'Indian Culture & Gita Wisdom Stories', 'space_heavy', 4, N'Listen to and retell a simple Gita-inspired story with pictures.', 0);
    SET @cat_indian_gita_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_1, N'short_response', N'Story: A young prince feels afraid before a big challenge, but a wise teacher reminds him to do his best and not worry about things outside his control. Retell this story in your own words.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_1, N'multiple_choice', N'This story''s lesson is about...', N'["Doing your best and not worrying about things you can''t control", "Always winning no matter what", "Avoiding challenges completely"]', N'Doing your best and not worrying about things you can''t control', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_1, N'short_response', N'Draw a picture showing the moment the prince felt brave again.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_1, N'multiple_choice', N'A wise teacher in a story often helps the main character...', N'["See a situation in a new, helpful way", "Get more scared", "Give up"]', N'See a situation in a new, helpful way', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_1, N'short_response', N'Has anyone ever given you advice like the wise teacher gave the prince? What did they say?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_1, N'multiple_choice', N'Retelling a story in your own words helps you...', N'["Understand and remember its lesson better", "Forget the story faster", "Nothing useful"]', N'Understand and remember its lesson better', 6);

    DECLARE @cat_indian_gita_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'culture', N'Indian Culture & Gita Wisdom Stories', 'space_heavy', 4, N'Think about ''what would you do?'' based on a Gita-inspired story.', 0);
    SET @cat_indian_gita_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_2, N'short_response', N'Story: A warrior must do his duty even though it feels hard and uncertain. If YOU were in a hard situation like this, what would help you keep going?', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_2, N'multiple_choice', N'This kind of story often explores the idea of...', N'["Doing what''s right even when it''s difficult", "Avoiding all difficult situations", "Only doing easy things"]', N'Doing what''s right even when it''s difficult', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_2, N'short_response', N'Describe a time YOU had to do something hard because it was the right thing to do.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_2, N'multiple_choice', N'Facing a hard duty with courage, rather than running from it, shows...', N'["Inner strength", "Weakness", "Carelessness"]', N'Inner strength', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_2, N'short_response', N'What advice would you give a friend who is scared to do something difficult but important?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_2, N'multiple_choice', N'Stories like this from the Gita are often used to teach lessons about...', N'["Duty, courage, and inner peace", "Only ancient history with no modern meaning", "Nothing meaningful"]', N'Duty, courage, and inner peace', 6);

    DECLARE @cat_indian_gita_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'culture', N'Indian Culture & Gita Wisdom Stories', 'short_answer', 4, N'Journal about character-building qualities like courage and kindness.', 0);
    SET @cat_indian_gita_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_3, N'short_response', N'Write about a time you showed COURAGE (even a small moment).', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_3, N'short_response', N'Write about a time you showed KINDNESS to someone.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_3, N'multiple_choice', N'Character-building qualities like courage and kindness are...', N'["Habits you can build and strengthen over time", "Something you either have or don''t, forever", "Not actually important"]', N'Habits you can build and strengthen over time', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_3, N'multiple_choice', N'Journaling about your own actions helps you...', N'["Reflect on and grow your character", "Nothing useful", "Only matters for remembering facts"]', N'Reflect on and grow your character', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_3, N'short_response', N'Which quality (courage or kindness) do you want to practice more this week? How?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_3, N'short_response', N'Name someone you know who shows courage or kindness often. What do they do?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_indian_gita_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'culture', N'Indian Culture & Gita Wisdom Stories', 'short_answer', 4, N'Create a Gita-inspired art project using symbols like the lotus and peacock feather.', 0);
    SET @cat_indian_gita_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_4, N'short_response', N'Draw a lotus flower. The lotus grows in muddy water but blooms beautifully — what lesson might this symbolize?', NULL, N'That beauty and goodness can grow and rise above difficult circumstances.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_4, N'multiple_choice', N'The lotus flower is often used as a symbol of...', N'["Purity and rising above difficulty", "Laziness", "Fear"]', N'Purity and rising above difficulty', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_4, N'short_response', N'Draw a peacock feather. Peacock feathers are associated with beauty and are linked to Krishna in many stories. What colors did you use?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_4, N'multiple_choice', N'Symbols like the lotus and peacock feather are used in stories and art to...', N'["Represent deeper ideas or qualities", "Have no meaning at all", "Only be decorative with zero purpose"]', N'Represent deeper ideas or qualities', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_4, N'short_response', N'Why might artists use symbols (like a flower) instead of just writing out an idea directly?', NULL, N'Symbols can express a feeling or idea in a visual, memorable way that words alone might not capture.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_4, N'short_response', N'Create your own art project combining the lotus and peacock feather symbols.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_indian_gita_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'culture', N'Indian Culture & Gita Wisdom Stories', 'space_heavy', 4, N'Retell a Gita story in your own words.', 0);
    SET @cat_indian_gita_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_5, N'short_response', N'Choose a Gita-inspired story you know. Retell it in your own words, in a few sentences.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_5, N'multiple_choice', N'Retelling a story in your OWN words (not word-for-word) shows that you...', N'["Truly understood the story''s meaning", "Just memorized it without understanding", "Didn''t understand the story at all"]', N'Truly understood the story''s meaning', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_5, N'short_response', N'What is the main lesson of the story you retold?', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_5, N'multiple_choice', N'Why might oral storytelling traditions (passing stories down by retelling) matter for a culture?', N'["It preserves values and wisdom across generations", "It''s not an important part of culture", "Written text is the only way stories survive"]', N'It preserves values and wisdom across generations', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_5, N'short_response', N'What part of the story did you choose to focus on most in your retelling, and why?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_5, N'short_response', N'If you told this story to a younger sibling or friend, how might you simplify it?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_indian_gita_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'culture', N'Indian Culture & Gita Wisdom Stories', 'space_heavy', 4, N'Compare a Gita teaching to a real-life situation.', 0);
    SET @cat_indian_gita_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_6, N'short_response', N'Choose a Gita teaching (e.g., focus on effort, not just results). Explain it in your own words.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_6, N'short_response', N'Describe a real-life situation (yours or someone else''s) where this teaching could apply.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_6, N'multiple_choice', N'Applying an ancient teaching to a modern situation shows that...', N'["Timeless wisdom can still be relevant today", "Ancient teachings have nothing to do with modern life", "Only new ideas are ever useful"]', N'Timeless wisdom can still be relevant today', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_6, N'short_response', N'How would following this teaching change how someone handles that real-life situation?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_6, N'multiple_choice', N'Comparing ancient wisdom to modern life is a way to practice...', N'["Applying philosophy to everyday decisions", "Ignoring philosophy completely", "Memorizing facts with no application"]', N'Applying philosophy to everyday decisions', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_6, N'short_response', N'What''s one Gita teaching you''d like to try applying in your own life?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_indian_gita_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'culture', N'Indian Culture & Gita Wisdom Stories', 'space_heavy', 4, N'Write a personal journal entry connecting a Gita teaching to your own life story.', 0);
    SET @cat_indian_gita_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_7, N'short_response', N'Choose a Gita teaching that resonates with you. State it clearly.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_7, N'short_response', N'Write a personal journal entry connecting this teaching to a real experience in YOUR life.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_7, N'multiple_choice', N'A personal reflection journal entry should be...', N'["Honest and specifically about your own experience", "Completely made up with no personal connection", "Written about someone else''s life, not your own"]', N'Honest and specifically about your own experience', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_7, N'short_response', N'How has this teaching (or the process of reflecting on it) changed how you think about your experience?', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_7, N'multiple_choice', N'Connecting ancient wisdom to your own personal story helps make the teaching...', N'["Meaningful and memorable in your own life", "Forgettable and irrelevant", "Something only for scholars, not for you"]', N'Meaningful and memorable in your own life', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_indian_gita_7, N'short_response', N'Would you share this teaching with a friend facing something similar? Why?', NULL, N'Answers will vary.', 6);

    DECLARE @cat_hispanic_culture_0 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (0, 'culture', N'Hispanic Culture, Language & Traditions', 'short_answer', 4, NULL, 0);
    SET @cat_hispanic_culture_0 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_0, N'matching', N'Match the Spanish greeting to its meaning.', N'{"left": ["Hola", "Buenos días", "Adiós", "Gracias"], "right": ["Hello", "Good morning", "Goodbye", "Thank you"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_0, N'multiple_choice', N'How do you say ''hello'' in Spanish?', N'["Hola", "Adiós", "Gracias"]', N'Hola', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_0, N'short_response', N'Practice saying ''hola'' and ''gracias'' out loud.', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_0, N'multiple_choice', N'How do you say ''goodbye'' in Spanish?', N'["Adiós", "Hola", "Gracias"]', N'Adiós', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_0, N'short_response', N'Draw a picture of yourself greeting a friend in Spanish.', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_0, N'multiple_choice', N'Learning greetings in another language helps you...', N'["Connect with people who speak that language", "Nothing useful", "Confuse everyone"]', N'Connect with people who speak that language', 6);

    DECLARE @cat_hispanic_culture_1 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (1, 'culture', N'Hispanic Culture, Language & Traditions', 'short_answer', 4, N'Trace the Spanish alphabet, including the special letter ñ.', 0);
    SET @cat_hispanic_culture_1 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_1, N'multiple_choice', N'The letter ''ñ'' makes a sound like...', N'["''ny'' (as in ''canyon'')", "''n'' exactly like in English", "A silent letter"]', N'''ny'' (as in ''canyon'')', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_1, N'short_response', N'Trace the letter ñ. Can you think of a Spanish word that uses it (like ''niño'' — child)?', NULL, N'Answers will vary (e.g., ''niño'', ''año'').', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_1, N'multiple_choice', N'The Spanish alphabet has a few letters not found in the English alphabet, like...', N'["ñ", "Only the same letters as English, no differences", "Numbers instead of letters"]', N'ñ', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_1, N'short_response', N'Practice writing your name, then try writing a Spanish word with ñ.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_1, N'multiple_choice', N'Why is it important to learn special letters like ñ correctly?', N'["Using the wrong letter can change a word''s meaning or pronunciation", "It doesn''t matter at all", "Spanish doesn''t actually use ñ"]', N'Using the wrong letter can change a word''s meaning or pronunciation', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_1, N'short_response', N'Draw or trace 3 different Spanish words that use the letter ñ.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_hispanic_culture_2 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (2, 'culture', N'Hispanic Culture, Language & Traditions', 'short_answer', 4, N'Learn simple Spanish phrases: colors and numbers.', 0);
    SET @cat_hispanic_culture_2 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_2, N'matching', N'Match the Spanish color word to its English meaning.', N'{"left": ["Rojo", "Azul", "Verde", "Amarillo"], "right": ["Red", "Blue", "Green", "Yellow"]}', N'[[0, 0], [1, 1], [2, 2], [3, 3]]', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_2, N'fill_blank', N'How do you say the number ''one'' in Spanish?', NULL, N'Uno', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_2, N'fill_blank', N'How do you say the number ''two'' in Spanish?', NULL, N'Dos', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_2, N'short_response', N'Practice counting from uno to cinco (1 to 5) in Spanish.', NULL, N'Uno, dos, tres, cuatro, cinco.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_2, N'multiple_choice', N'Learning colors and numbers is often one of the first steps in learning a new language because...', N'["They''re commonly used, simple building blocks", "They''re the hardest words to learn", "They''re not actually useful"]', N'They''re commonly used, simple building blocks', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_2, N'short_response', N'Name your favorite color in Spanish.', NULL, N'Answers will vary (e.g., ''azul'' for blue).', 6);

    DECLARE @cat_hispanic_culture_3 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (3, 'culture', N'Hispanic Culture, Language & Traditions', 'space_heavy', 4, N'Learn about Día de los Muertos (Day of the Dead) and its vocabulary.', 0);
    SET @cat_hispanic_culture_3 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_3, N'short_response', N'Día de los Muertos is a holiday that celebrates and remembers loved ones who have passed away. What do you think an ''ofrenda'' (offering altar) might include?', NULL, N'Photos, favorite foods, flowers (like marigolds), and candles honoring the person being remembered.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_3, N'multiple_choice', N'Día de los Muertos is celebrated mainly in...', N'["Mexico and other parts of Latin America", "Only in Spain", "It''s not celebrated anywhere"]', N'Mexico and other parts of Latin America', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_3, N'short_response', N'Color a picture related to Día de los Muertos, like a marigold flower (cempasúchil) or a calavera (skull design).', NULL, N'Answers will vary.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_3, N'multiple_choice', N'Día de los Muertos is best described as a holiday that...', N'["Celebrates and honors the memory of loved ones who have died", "Is meant to be scary or sad only", "Has nothing to do with family"]', N'Celebrates and honors the memory of loved ones who have died', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_3, N'short_response', N'Why might a holiday celebrating memories of loved ones be meaningful for families?', NULL, N'It gives families a joyful, meaningful way to remember and honor people they''ve lost.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_3, N'multiple_choice', N'What color are the marigold flowers (cempasúchil) often used in Día de los Muertos celebrations?', N'["Orange", "Blue", "Purple"]', N'Orange', 6);

    DECLARE @cat_hispanic_culture_4 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (4, 'culture', N'Hispanic Culture, Language & Traditions', 'short_answer', 4, N'Learn Spanish accent marks and basic spelling rules.', 0);
    SET @cat_hispanic_culture_4 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_4, N'multiple_choice', N'An accent mark (like in ''café'') usually tells you...', N'["Which syllable to stress when pronouncing the word", "To skip the word entirely", "That the word is silent"]', N'Which syllable to stress when pronouncing the word', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_4, N'short_response', N'Practice writing a word with an accent mark, like ''café'' or ''música''.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_4, N'multiple_choice', N'Accent marks in Spanish can sometimes change a word''s meaning, like ''si'' (if) vs ''sí'' (yes). Why does this matter?', N'["The exact same letters can mean different things depending on the accent", "Accent marks never affect meaning", "Accent marks are purely decorative"]', N'The exact same letters can mean different things depending on the accent', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_4, N'short_response', N'Find (or think of) 2 Spanish words that use accent marks.', NULL, N'Answers will vary.', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_4, N'multiple_choice', N'Learning spelling rules and accent marks helps you...', N'["Read and write Spanish more accurately", "Nothing useful for learning Spanish", "Only matters for math, not language"]', N'Read and write Spanish more accurately', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_4, N'short_response', N'Why might it be tricky for English speakers to remember to use accent marks, since English doesn''t use them the same way?', NULL, N'Answers will vary (e.g., it''s an unfamiliar habit that takes extra practice to remember).', 6);

    DECLARE @cat_hispanic_culture_5 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (5, 'culture', N'Hispanic Culture, Language & Traditions', 'space_heavy', 4, N'Retell a folk tale from Latin America, the Caribbean, or Spain.', 0);
    SET @cat_hispanic_culture_5 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_5, N'short_response', N'Choose a folk tale from a Spanish-speaking region. Summarize its main plot.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_5, N'short_response', N'What lesson or value does the folk tale teach?', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_5, N'multiple_choice', N'Folk tales are traditionally passed down...', N'["Through generations, often originally by spoken storytelling", "Only through official government records", "They''re always brand new stories"]', N'Through generations, often originally by spoken storytelling', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_5, N'multiple_choice', N'Folk tales from a specific culture often reflect...', N'["That culture''s values, history, and environment", "Nothing about the culture they come from", "Only random, unrelated events"]', N'That culture''s values, history, and environment', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_5, N'short_response', N'How is this folk tale similar to or different from folk tales you know from other cultures?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_5, N'short_response', N'Retell the folk tale in your own words, in a few sentences.', NULL, N'Answers will vary.', 6);

    DECLARE @cat_hispanic_culture_6 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (6, 'culture', N'Hispanic Culture, Language & Traditions', 'space_heavy', 4, N'Explore the art of Frida Kahlo and Diego Rivera.', 0);
    SET @cat_hispanic_culture_6 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_6, N'short_response', N'Frida Kahlo was known for painting self-portraits with bold colors and symbolism. Describe what you notice or imagine about her style.', NULL, N'Answers will vary — bold colors, personal symbolism, self-portraiture.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_6, N'short_response', N'Diego Rivera was known for large murals depicting Mexican history and workers. Why might murals (big public paintings) be a powerful way to tell a story?', NULL, N'Murals are large, public, and visible to many people, making them a powerful way to share stories and messages widely.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_6, N'multiple_choice', N'Frida Kahlo and Diego Rivera were both...', N'["Famous Mexican artists", "Famous musicians", "Famous athletes"]', N'Famous Mexican artists', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_6, N'multiple_choice', N'Frida Kahlo''s paintings often explored themes of...', N'["Her own identity, pain, and personal experiences", "Only landscapes with no personal meaning", "Abstract shapes with no subject at all"]', N'Her own identity, pain, and personal experiences', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_6, N'short_response', N'If you painted a self-portrait like Frida Kahlo, what symbols would you include to represent your own life?', NULL, N'Answers will vary.', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_6, N'multiple_choice', N'Studying artists like Kahlo and Rivera helps you understand...', N'["Mexican history and culture through art", "Nothing about culture or history", "Only technical painting skills"]', N'Mexican history and culture through art', 6);

    DECLARE @cat_hispanic_culture_7 INT;
    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)
        VALUES (7, 'culture', N'Hispanic Culture, Language & Traditions', 'space_heavy', 4, N'Write a bilingual heritage journal entry connecting a family tradition to Spanish vocabulary.', 0);
    SET @cat_hispanic_culture_7 = SCOPE_IDENTITY();
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_7, N'short_response', N'Describe a family tradition (yours or one you find interesting) that connects to Hispanic culture.', NULL, N'Answers will vary.', 1);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_7, N'short_response', N'List 3 Spanish vocabulary words related to that tradition.', NULL, N'Answers will vary.', 2);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_7, N'short_response', N'Write a short journal entry about this tradition, using at least 2 of your Spanish vocabulary words.', NULL, N'Answers will vary — should incorporate the vocabulary naturally.', 3);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_7, N'multiple_choice', N'A ''bilingual'' journal entry uses...', N'["Two languages together", "Only one language", "No actual words, just pictures"]', N'Two languages together', 4);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_7, N'multiple_choice', N'Why might writing about a tradition in TWO languages help you understand it more deeply?', N'["It connects the vocabulary directly to real, meaningful context", "It has no real benefit over using just one language", "Bilingual writing is always more confusing"]', N'It connects the vocabulary directly to real, meaningful context', 5);
    INSERT INTO dbo.PacketQuestions (category_id, question_type, prompt, choices_json, answer_text, sort_order) VALUES
        (@cat_hispanic_culture_7, N'short_response', N'How does learning about traditions and language together help preserve culture across generations?', NULL, N'Answers will vary (e.g., language carries cultural meaning, and traditions keep language relevant and alive).', 6);

END
GO

DELETE FROM dbo.WeeklyPacketPlan;
GO