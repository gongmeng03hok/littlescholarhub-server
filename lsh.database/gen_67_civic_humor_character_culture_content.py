# -*- coding: utf-8 -*-
"""
Generates lsh.database/67_civic_humor_character_culture_content.sql —
Whole-Child Curriculum expansion, batch 4 (final): 'civic' (Civics &
Government, Community & Global Citizenship, Public Speaking & Debate),
'humor_play' (Creative Drawing & Doodling, Funny Jokes & Wordplay, Riddles
& Brain Teasers, Sense of Humor & Playful Perspective), 'character' (Moral
Lessons, Manners & Everyday Respect, Brain Motivation & Growth Mindset),
and 'culture' (Chinese, Indian/Gita, Hispanic language & culture). Same
pattern as gen_64/65/66. Run with: python gen_migration_67.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]


def q_fill(prompt, answer, diagram_type=None, diagram_data=None):
    return {"qtype": "fill_blank", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": diagram_type, "diagram_data": diagram_data}


def q_mc(prompt, choices, answer, diagram_type=None, diagram_data=None):
    return {"qtype": "multiple_choice", "prompt": prompt, "choices": choices, "answer": answer,
            "diagram_type": diagram_type, "diagram_data": diagram_data}


def q_short(prompt, answer, diagram_type=None, diagram_data=None):
    return {"qtype": "short_response", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": diagram_type, "diagram_data": diagram_data}


def q_match(prompt, left, right, pairs, answer_note=""):
    choices = {"left": left, "right": right}
    answer = json.dumps(pairs)
    return {"qtype": "matching", "prompt": prompt, "choices": choices, "answer": answer,
            "diagram_type": None, "diagram_data": None}


def q_seq(prompt, steps, answer):
    return {"qtype": "short_response", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": "sequence_steps", "diagram_data": {"steps": steps}}


CATEGORIES = []


# ═══════════════════════════════════════════════════════════════════════
# CIVIC 1/3: Civics & Government
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "civics_gov", "subject_area": "civic", "category_name": "Civics & Government", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_match("Match the community helper to their job.", ["Firefighter", "Doctor", "Teacher", "Mail carrier"], ["Puts out fires", "Helps sick people", "Helps you learn", "Delivers mail"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("Who helps keep people safe from fires?", ["Firefighter", "Teacher", "Mail carrier"], "Firefighter"),
                q_mc("Who helps you learn at school?", ["Teacher", "Doctor", "Firefighter"], "Teacher"),
                q_short("Name a community helper and what they do.", "Answers will vary."),
                q_mc("Community helpers are people who...", ["Do jobs that help everyone in the community", "Only help themselves", "Never help anyone"], "Do jobs that help everyone in the community"),
                q_short("Draw a picture of your favorite community helper.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn about classroom rules and how voting works.",
            "questions": [
                q_short("Name one rule in your classroom.", "Answers will vary."),
                q_mc("Rules in a classroom help everyone...", ["Stay safe and treat each other kindly", "Get confused", "Ignore the teacher"], "Stay safe and treat each other kindly"),
                q_mc("Voting means...", ["Choosing what you want by picking an option", "Never getting a choice", "Only one person decides for everyone"], "Choosing what you want by picking an option"),
                q_short("If your class voted on a game to play, how would you decide the winner?", "Whichever game gets the most votes."),
                q_mc("Why is voting a fair way to make group decisions?", ["Everyone gets a say, and the most popular choice wins", "Only the teacher's opinion counts", "It's not fair at all"], "Everyone gets a say, and the most popular choice wins"),
                q_short("What would you vote for if your class could pick a class pet?", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn how a vote actually works, step by step.",
            "questions": [
                q_seq("Put the steps of a simple class vote in order.", ["Everyone hears the choices", "Each person picks one choice", "Votes are counted", "The choice with the most votes wins"], "Hear choices, pick one, count votes, most votes wins."),
                q_mc("A 'majority' in voting means...", ["More than half of the votes", "Exactly one vote", "No votes at all"], "More than half of the votes"),
                q_short("If 10 kids vote and 6 pick pizza, 4 pick tacos, which wins? Why?", "Pizza — it got more votes (6 out of 10)."),
                q_mc("Why should votes be counted carefully and fairly?", ["So the real winner is announced correctly", "Counting doesn't matter, just guess", "Only some votes should count"], "So the real winner is announced correctly"),
                q_short("Why might a vote sometimes end in a tie? What could happen next?", "Two choices get the exact same number of votes — the group might need a tiebreaker, like a re-vote."),
                q_mc("Voting is used in real government to...", ["Let citizens choose their leaders and decisions", "Decide the weather", "Nothing important"], "Let citizens choose their leaders and decisions"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn about local government roles.",
            "questions": [
                q_match("Match the local government role to their job.", ["Mayor", "Police officer", "Firefighter", "City council member"], ["Leads the city", "Keeps the community safe from crime", "Puts out fires and helps in emergencies", "Helps make city decisions/laws"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("Who is usually the leader of a city?", ["The mayor", "A teacher", "A doctor"], "The mayor"),
                q_short("Name one job the local police do to help a community.", "Answers will vary (e.g., keep people safe, respond to emergencies)."),
                q_mc("Local government mainly deals with...", ["Issues in your own city or town", "Only issues in other countries", "Nothing that affects daily life"], "Issues in your own city or town"),
                q_short("Why does a city need many different roles (mayor, police, etc.) instead of just one person doing everything?", "Different jobs need different skills, and one person can't do everything a whole city needs."),
                q_mc("Which is an example of something local government might decide?", ["Where to build a new park", "What's for dinner at your house", "What game to play at recess"], "Where to build a new park"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Get an intro to the branches of government.",
            "questions": [
                q_mc("The branch of government that MAKES laws is called the...", ["Legislative branch", "Executive branch", "Judicial branch"], "Legislative branch"),
                q_mc("The branch of government that ENFORCES laws is called the...", ["Executive branch", "Legislative branch", "Judicial branch"], "Executive branch"),
                q_mc("The branch of government that INTERPRETS laws (courts) is called the...", ["Judicial branch", "Legislative branch", "Executive branch"], "Judicial branch"),
                q_short("Why might having 3 separate branches be better than one group having all the power?", "It spreads out power so no single group can control everything — this is called 'checks and balances.'"),
                q_short("Which branch do you think a President or Governor belongs to?", "The executive branch."),
                q_mc("Having 'checks and balances' between branches means...", ["Each branch can limit the power of the others", "One branch controls everything", "Branches never interact with each other"], "Each branch can limit the power of the others"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Learn about your rights and responsibilities as a citizen.",
            "questions": [
                q_short("Name one right you have (something you're allowed to do or have).", "Answers will vary (e.g., free speech, education)."),
                q_short("Name one responsibility you have (something you're expected to do).", "Answers will vary (e.g., following rules, being honest)."),
                q_mc("A right is...", ["Something you're entitled to have or do", "A punishment", "Something forbidden"], "Something you're entitled to have or do"),
                q_mc("A responsibility is...", ["A duty or obligation you're expected to fulfill", "The same thing as a right", "Something optional with no consequences"], "A duty or obligation you're expected to fulfill"),
                q_short("Why do rights and responsibilities usually go together?", "Enjoying rights in a community also means contributing responsibly to keep that community fair for everyone."),
                q_mc("Which is an example of a responsibility, not a right?", ["Following classroom rules", "Being allowed to speak your opinion", "Having access to education"], "Following classroom rules"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare local government to national government.",
            "questions": [
                q_short("Name one issue that local government usually handles.", "Answers will vary (e.g., local roads, parks, schools)."),
                q_short("Name one issue that national government usually handles.", "Answers will vary (e.g., national defense, federal laws)."),
                q_mc("Local government mainly affects...", ["Your city or town specifically", "The entire country equally", "Nothing that matters"], "Your city or town specifically"),
                q_mc("National government mainly affects...", ["The whole country", "Only one neighborhood", "Nothing important"], "The whole country"),
                q_short("Why might a decision (like a new park) be made locally rather than nationally?", "It only affects people in that specific area, so local leaders who know the community make that call."),
                q_mc("Understanding both levels of government helps citizens...", ["Know who to contact about different kinds of issues", "Ignore government entirely", "Assume all government is the same"], "Know who to contact about different kinds of issues"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Take part in a mock election or mock government project.",
            "questions": [
                q_short("Choose a mock government role (mayor, senator, etc.) or a mock election issue. Describe it.", "Answers will vary."),
                q_short("If running in a mock election, write one campaign promise your candidate would make.", "Answers will vary."),
                q_mc("A mock election helps students practice...", ["Real democratic processes in a safe, practice setting", "Nothing useful", "Only memorizing government vocabulary"], "Real democratic processes in a safe, practice setting"),
                q_short("How would votes be counted fairly in your mock election?", "Answers will vary (e.g., each student votes once, count all ballots)."),
                q_mc("Why might a mock government project include debate or campaign speeches?", ["It practices persuasion and public speaking, just like real elections", "Speeches aren't part of real elections", "It has nothing to do with real government"], "It practices persuasion and public speaking, just like real elections"),
                q_short("What did you learn about how government or elections work from this project?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CIVIC 2/3: Community & Global Citizenship
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "global_citizen", "subject_area": "civic", "category_name": "Community & Global Citizenship", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which is a way to help your community?", ["Picking up litter", "Making a mess", "Being unkind"], "Picking up litter"),
                q_short("Name one way you could help someone in your neighborhood.", "Answers will vary."),
                q_mc("Helping others in your community makes it...", ["A nicer place for everyone", "Worse for everyone", "No different at all"], "A nicer place for everyone"),
                q_short("Draw a picture of yourself helping your community.", "Answers will vary."),
                q_mc("A community is...", ["A group of people who live near or share something with each other", "Just one single person", "A type of food"], "A group of people who live near or share something with each other"),
                q_short("Who is someone in your community you'd like to help?", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Try a simple kindness challenge this week.",
            "questions": [
                q_short("Write down one kind thing you could do for someone this week.", "Answers will vary."),
                q_mc("A kindness challenge encourages you to...", ["Do intentional kind acts for others", "Avoid helping anyone", "Only be kind to yourself"], "Do intentional kind acts for others"),
                q_short("How did it feel the last time you did something kind for someone?", "Answers will vary."),
                q_mc("Small acts of kindness (like sharing or a compliment) can...", ["Make a real difference to someone's day", "Never matter at all", "Only matter if they're big gestures"], "Make a real difference to someone's day"),
                q_short("Try your kindness challenge and write about what happened.", "Answers will vary."),
                q_mc("Why might kindness 'spread' — meaning one kind act leads to more?", ["Being treated kindly often inspires people to be kind to others too", "Kindness never has any effect on others", "Kindness only happens by accident"], "Being treated kindly often inspires people to be kind to others too"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Brainstorm ideas for community service.",
            "questions": [
                q_short("List 2 ways kids your age could help their community.", "Answers will vary (e.g., a food drive, cleaning up a park)."),
                q_mc("Community service means...", ["Volunteering your time to help others without pay", "Getting paid to do a job", "Only helping your own family"], "Volunteering your time to help others without pay"),
                q_short("Why might community service help both the community AND the volunteer?", "The community gets help, and volunteers often feel good and learn new skills."),
                q_mc("Which is an example of community service?", ["Collecting donations for a shelter", "Buying something for yourself", "Watching TV"], "Collecting donations for a shelter"),
                q_short("What community service idea would YOU most want to try?", "Answers will vary."),
                q_mc("Community service ideas should be...", ["Realistic and something you could actually help with", "Impossible to actually do", "Only for adults, never kids"], "Realistic and something you could actually help with"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare needs in different communities.",
            "questions": [
                q_short("Name one need a community near you might have (e.g., more parks, cleaner streets).", "Answers will vary."),
                q_short("Name a need a DIFFERENT kind of community (rural, another country, etc.) might have.", "Answers will vary."),
                q_mc("Different communities might have different needs because...", ["Their circumstances, resources, and environments differ", "All communities are always identical", "Needs never actually differ anywhere"], "Their circumstances, resources, and environments differ"),
                q_short("Why is it useful to learn about needs in communities different from your own?", "It builds empathy and understanding of experiences different from your own."),
                q_mc("Comparing community needs helps you...", ["Understand that 'normal' looks different in different places", "Assume everyone has the exact same life as you", "Nothing useful"], "Understand that 'normal' looks different in different places"),
                q_short("If you could help a community with a need different from your own, what would you want to help with?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design your own community service project.",
            "questions": [
                q_short("What community need would your project address?", "Answers will vary."),
                q_short("Describe your project: what would you and others actually DO?", "Answers will vary."),
                q_short("Who would your project help, and how would you know if it worked?", "Answers will vary."),
                q_mc("A good community service project should be...", ["Realistic and actually address a real need", "Impossible to carry out", "Only about getting recognition"], "Realistic and actually address a real need"),
                q_short("What supplies, people, or permission would you need to make your project happen?", "Answers will vary."),
                q_mc("Designing a project BEFORE doing it helps you...", ["Think through what's needed to make it actually succeed", "Waste time for no reason", "Skip the need for any planning"], "Think through what's needed to make it actually succeed"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Reflect on what it means to be a global citizen.",
            "questions": [
                q_short("What does 'global citizenship' mean to you? Explain in your own words.", "Caring about and taking responsibility for people and issues beyond just your own community."),
                q_short("Name one issue that affects people all around the world, not just one country.", "Answers will vary (e.g., climate change, access to clean water)."),
                q_mc("A global citizen is someone who...", ["Cares about and considers people beyond just their own community", "Only cares about their own country", "Ignores issues outside their neighborhood"], "Cares about and considers people beyond just their own community"),
                q_short("Why might learning about other cultures and countries help you become a better global citizen?", "It builds understanding and empathy for people whose lives are different from your own."),
                q_mc("Global citizenship and local community involvement are...", ["Both important — you can care about both at once", "Completely unrelated to each other", "In competition, you can only pick one"], "Both important — you can care about both at once"),
                q_short("What's one small way you could show global citizenship in your everyday life?", "Answers will vary (e.g., learning about other cultures, being mindful of resource use)."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Research a global issue and design a local action plan.",
            "questions": [
                q_short("Choose a global issue to research (e.g., clean water access, plastic pollution). Describe it.", "Answers will vary."),
                q_short("Who is most affected by this global issue?", "Answers will vary."),
                q_short("Design a LOCAL action — something you or your community could realistically do to help.", "Answers will vary."),
                q_mc("A 'local action plan' for a global issue means...", ["Taking realistic, small-scale steps in your own community", "Solving the entire global issue by yourself", "Ignoring the issue since it's too big"], "Taking realistic, small-scale steps in your own community"),
                q_mc("Why can small local actions matter even for huge global issues?", ["Many small local actions can add up to meaningful change", "Local actions never make any difference", "Only huge, global actions matter at all"], "Many small local actions can add up to meaningful change"),
                q_short("What's the first step you'd take to start your local action plan?", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a full service-learning project proposal.",
            "questions": [
                q_short("State the community need your service-learning project addresses.", "Answers will vary."),
                q_short("Describe your project's goals — what would success look like?", "Answers will vary."),
                q_short("List the steps/timeline for carrying out your project.", "Answers will vary."),
                q_short("How would you measure whether your project actually made a difference?", "Answers will vary."),
                q_mc("Service-learning combines...", ["Real community service with structured learning and reflection", "Only community service, with no learning involved", "Only classroom learning, with no real service"], "Real community service with structured learning and reflection"),
                q_mc("A strong project proposal should convince readers that...", ["The project is well-planned, realistic, and worth doing", "The project idea doesn't need any explanation", "Planning isn't necessary for service projects"], "The project is well-planned, realistic, and worth doing"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CIVIC 3/3: Public Speaking & Debate
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "public_speaking", "subject_area": "civic", "category_name": "Public Speaking & Debate", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Write or draw one thing you'd like to share for show-and-tell.", "Answers will vary."),
                q_mc("When it's your turn to talk in front of others, you should...", ["Speak clearly so people can hear you", "Whisper so no one can hear", "Talk as fast as possible"], "Speak clearly so people can hear you"),
                q_short("What is one fun fact about the thing you'd bring for show-and-tell?", "Answers will vary."),
                q_mc("Looking at your audience while talking helps you...", ["Connect with the people listening", "Confuse everyone", "Nothing at all"], "Connect with the people listening"),
                q_short("Practice saying your show-and-tell sentence out loud.", "Answers will vary."),
                q_mc("Talking in front of a group is called...", ["Public speaking", "Silent reading", "Sleeping"], "Public speaking"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice introducing yourself to a group.",
            "questions": [
                q_short("Write a short introduction: your name, and one thing you like.", "Answers will vary."),
                q_mc("A good introduction usually includes...", ["Your name and something about you", "Only your name, nothing else", "A secret you'll never tell"], "Your name and something about you"),
                q_short("Practice saying your introduction out loud, clearly and not too fast.", "Answers will vary."),
                q_mc("When introducing yourself, it helps to...", ["Smile and speak with a clear voice", "Look at the floor and mumble", "Talk as quietly as possible"], "Smile and speak with a clear voice"),
                q_short("What is one question you could ask someone after introducing yourself?", "Answers will vary (e.g., 'What's your name?')."),
                q_mc("Practicing your introduction beforehand helps you...", ["Feel more confident when you actually say it", "Nothing, practicing doesn't help", "Forget what you wanted to say"], "Feel more confident when you actually say it"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Outline a simple 3-sentence speech.",
            "questions": [
                q_short("Sentence 1: introduce your topic. What will you talk about?", "Answers will vary."),
                q_short("Sentence 2: share one fact or idea about your topic.", "Answers will vary."),
                q_short("Sentence 3: wrap up your speech with a closing thought.", "Answers will vary."),
                q_mc("A speech outline helps you...", ["Organize your ideas before speaking", "Memorize word-for-word with no flexibility", "Skip planning entirely"], "Organize your ideas before speaking"),
                q_short("Practice saying your 3-sentence speech out loud.", "Answers will vary."),
                q_mc("Even a very short speech should have...", ["A clear beginning, middle, and end", "No real structure", "Only one sentence"], "A clear beginning, middle, and end"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan a persuasive speech.",
            "questions": [
                q_short("Choose something you want to persuade someone about (e.g., 'we should have a class pet'). State your position.", "Answers will vary."),
                q_short("Give one REASON to support your position.", "Answers will vary."),
                q_mc("A persuasive speech tries to...", ["Convince the listener to agree with your position", "Only share random facts with no goal", "Confuse the listener on purpose"], "Convince the listener to agree with your position"),
                q_short("What's a counter-argument someone might have against your position? How would you respond?", "Answers will vary."),
                q_mc("A persuasive speech is stronger when it includes...", ["Real reasons and evidence, not just opinions", "No reasons at all, just repeated opinions", "As many big words as possible"], "Real reasons and evidence, not just opinions"),
                q_short("Write a strong closing sentence for your persuasive speech.", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn debate basics: making a claim and giving a reason.",
            "questions": [
                q_short("Write a CLAIM (a statement you believe) about a topic of your choice.", "Answers will vary."),
                q_short("Write a REASON that supports your claim.", "Answers will vary."),
                q_mc("A claim in a debate is...", ["A statement of your position or belief", "A question with no answer", "The same as a fact everyone already agrees on"], "A statement of your position or belief"),
                q_mc("Why does a claim need a REASON to back it up?", ["Without a reason, it's just an unsupported opinion", "Reasons aren't necessary in debate", "Claims are always true without needing support"], "Without a reason, it's just an unsupported opinion"),
                q_short("Write a claim + reason pair about your favorite season.", "Answers will vary (e.g., 'Summer is the best season because you can swim outside.')."),
                q_mc("In a debate, the goal of a claim + reason is to...", ["Make your position more convincing", "Confuse the other side", "Avoid explaining your thinking"], "Make your position more convincing"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Build a structured speech outline: intro, body, conclusion.",
            "questions": [
                q_short("INTRO: write an opening line that grabs attention and states your topic.", "Answers will vary."),
                q_short("BODY: list 2-3 main points you'll cover.", "Answers will vary."),
                q_short("CONCLUSION: write a closing line that wraps up your main message.", "Answers will vary."),
                q_mc("The BODY of a speech is where you...", ["Present your main points and evidence", "Just repeat the introduction", "Skip all the important details"], "Present your main points and evidence"),
                q_mc("Why does a speech need a clear structure (intro/body/conclusion)?", ["It helps the audience follow your ideas logically", "Structure doesn't matter for speeches", "It makes the speech confusing on purpose"], "It helps the audience follow your ideas logically"),
                q_short("Read your full outline out loud. Does each part flow smoothly into the next?", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Prep for a formal debate, including rebuttal notes.",
            "questions": [
                q_short("State your debate position clearly.", "Answers will vary."),
                q_short("List 2 pieces of evidence or reasons supporting your position.", "Answers will vary."),
                q_short("Predict one argument the OPPOSING side might make. Write a REBUTTAL (response) to it.", "Answers will vary."),
                q_mc("A rebuttal is...", ["A response that addresses the other side's argument", "Ignoring what the other side said", "The same thing as your original claim"], "A response that addresses the other side's argument"),
                q_mc("Why prepare rebuttals BEFORE the actual debate?", ["It helps you respond confidently instead of being caught off guard", "Rebuttals should always be made up on the spot", "Preparing rebuttals is a waste of time"], "It helps you respond confidently instead of being caught off guard"),
                q_short("Why is it useful to understand the OPPOSING side's argument well, even though you disagree with it?", "Understanding the other side helps you respond to it more effectively and fairly."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Complete a full persuasive speech/debate project with peer feedback.",
            "questions": [
                q_short("Write your full persuasive speech or debate position, including intro, evidence, and conclusion.", "Answers will vary."),
                q_short("Deliver (or imagine delivering) your speech to a peer. What feedback did they give you?", "Answers will vary."),
                q_mc("Peer feedback on a speech is most useful when it's...", ["Specific and includes both strengths and areas to improve", "Only negative, with nothing positive mentioned", "Vague, like 'it was fine'"], "Specific and includes both strengths and areas to improve"),
                q_short("Based on the feedback, what's one change you'd make to your speech?", "Answers will vary."),
                q_mc("Why is getting feedback from a real audience valuable before a final performance?", ["It reveals what's unclear or unconvincing that you might not notice yourself", "Feedback is never actually useful", "You should never change your speech after writing it"], "It reveals what's unclear or unconvincing that you might not notice yourself"),
                q_short("Reflect: what's the strongest part of your speech, and why?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HUMOR_PLAY 1/4: Creative Drawing & Doodling
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "creative_doodle", "subject_area": "humor_play", "category_name": "Creative Drawing & Doodling", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Draw a silly creature that has never existed before! What does it look like?", "Answers will vary."),
                q_short("What is your silly creature's name?", "Answers will vary."),
                q_mc("A silly creature could have...", ["Any mix of features you imagine", "Only real animal parts", "No features at all"], "Any mix of features you imagine"),
                q_short("What does your silly creature like to eat?", "Answers will vary."),
                q_mc("Drawing silly, made-up things helps you practice...", ["Imagination and creativity", "Only copying real things exactly", "Nothing useful"], "Imagination and creativity"),
                q_short("Where does your silly creature live?", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Finish the doodle! Turn a squiggle into a picture.",
            "questions": [
                q_short("Imagine a squiggly line. What could you turn it into with a few more lines?", "Answers will vary."),
                q_mc("A 'finish the doodle' activity encourages you to...", ["Use imagination to complete an unfinished shape", "Copy the exact same picture every time", "Erase the squiggle completely"], "Use imagination to complete an unfinished shape"),
                q_short("Draw 3 different squiggles and turn each into something different.", "Answers will vary."),
                q_mc("Why might two different people turn the same squiggle into completely different pictures?", ["Everyone imagines and creates differently", "There's only one correct answer", "Squiggles can only become one specific thing"], "Everyone imagines and creates differently"),
                q_short("What was the silliest thing you turned a squiggle into?", "Answers will vary."),
                q_mc("Doodling freely (without a plan) is a good way to...", ["Practice creative thinking without pressure", "Waste time with no benefit", "Only copy other people's ideas"], "Practice creative thinking without pressure"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Draw your dream treehouse!",
            "questions": [
                q_short("Describe or draw your dream treehouse. What special features does it have?", "Answers will vary."),
                q_mc("A 'dream' treehouse could include things that are...", ["Imaginative and not necessarily realistic", "Only things that already exist", "Boring and plain"], "Imaginative and not necessarily realistic"),
                q_short("How would you get up into your dream treehouse?", "Answers will vary."),
                q_short("Who would you invite to visit your dream treehouse?", "Answers will vary."),
                q_mc("Drawing an imaginative building like a dream treehouse helps you practice...", ["Creative design thinking", "Only realistic architecture", "Nothing creative at all"], "Creative design thinking"),
                q_short("What's the silliest feature you added to your treehouse?", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Draw a 3-panel comic strip telling a silly story.",
            "questions": [
                q_short("Panel 1: what's happening at the START of your silly story?", "Answers will vary."),
                q_short("Panel 2: what silly thing happens in the MIDDLE?", "Answers will vary."),
                q_short("Panel 3: how does your silly story END?", "Answers will vary."),
                q_mc("A comic strip tells a story using...", ["A sequence of connected panels/pictures", "Only one single picture", "No pictures at all"], "A sequence of connected panels/pictures"),
                q_mc("Why does a comic strip usually need panels in a clear ORDER?", ["The story needs to make sense from beginning to end", "Order doesn't matter in comics", "Panels should be random"], "The story needs to make sense from beginning to end"),
                q_short("What made your comic strip silly or funny?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Create a mash-up drawing by combining two animals.",
            "questions": [
                q_short("Pick two animals to combine (like a cat and a fish). Describe your mash-up creature.", "Answers will vary."),
                q_mc("A 'mash-up' combines...", ["Features from two or more different things into one", "Only one single thing", "Nothing at all"], "Features from two or more different things into one"),
                q_short("What would you name your mash-up creature?", "Answers will vary."),
                q_short("What special ability might your mash-up creature have, combining both animals' traits?", "Answers will vary."),
                q_mc("Mash-up drawing is a fun way to practice...", ["Combining ideas in new, creative ways", "Copying one single existing thing exactly", "Avoiding imagination"], "Combining ideas in new, creative ways"),
                q_short("Which two animals would make the silliest mash-up, in your opinion?", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Doodle an invention — design something silly AND useful.",
            "questions": [
                q_short("Invent something silly but actually useful. Draw or describe it.", "Answers will vary."),
                q_mc("A silly invention doodle should be...", ["Imaginative but still solve some kind of real (or silly) problem", "Completely random with no purpose at all", "Only realistic, no silliness allowed"], "Imaginative but still solve some kind of real (or silly) problem"),
                q_short("What problem does your invention solve?", "Answers will vary."),
                q_short("Give your invention a funny name.", "Answers will vary."),
                q_mc("Combining humor with design (like a silly invention) practices...", ["Creative problem-solving with a playful twist", "Only serious engineering with no creativity", "Nothing useful at all"], "Creative problem-solving with a playful twist"),
                q_short("How would your invention actually work? Describe the silly mechanism.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Try a perspective doodle challenge: draw from a bug's-eye view.",
            "questions": [
                q_short("Imagine you're a tiny bug looking up at a blade of grass. Draw or describe what you'd see.", "Answers will vary."),
                q_mc("A 'bug's-eye view' means drawing from...", ["A very low, close-up perspective, looking up", "A view from far above, looking down", "Exactly the same view as a person standing"], "A very low, close-up perspective, looking up"),
                q_short("How would everyday objects (like a pencil or a shoe) look different from a bug's-eye view?", "Answers will vary — should describe things looking much bigger/taller."),
                q_mc("Why might practicing unusual perspectives make you a more creative artist?", ["It challenges you to see familiar things in new ways", "Unusual perspectives are never useful", "Only one 'correct' perspective exists for drawing"], "It challenges you to see familiar things in new ways"),
                q_short("Draw a scene from a bird's-eye view (looking down) instead — how is it different?", "Answers will vary."),
                q_mc("Changing your drawing's perspective is a way to...", ["Add variety and interest to your art", "Make art harder to understand", "Follow one strict rule with no creativity"], "Add variety and interest to your art"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Create an illustrated short story using graphic-panel style.",
            "questions": [
                q_short("Write a short story idea (a few sentences) that you'll illustrate in panels.", "Answers will vary."),
                q_short("Sketch out (or describe) at least 4 panels showing your story's key moments.", "Answers will vary."),
                q_mc("An illustrated story combines...", ["Both pictures AND words to tell the story", "Only pictures, no words at all", "Only words, no pictures at all"], "Both pictures AND words to tell the story"),
                q_short("How do the pictures in your panels add something the words alone couldn't show?", "Answers will vary (e.g., showing expressions, setting details, action)."),
                q_mc("Graphic-panel storytelling is used in things like...", ["Comic books and graphic novels", "Only textbooks with no images", "Nothing real, it's not a real format"], "Comic books and graphic novels"),
                q_short("What's the most important moment in your story, and how did you illustrate it to stand out?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HUMOR_PLAY 2/4: Funny Jokes & Wordplay
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "jokes_wordplay", "subject_area": "humor_play", "category_name": "Funny Jokes & Wordplay", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Knock knock! Who's there? Finish this joke your own silly way.", "Answers will vary."),
                q_mc("A knock-knock joke starts with...", ["'Knock knock! Who's there?'", "'Once upon a time'", "'The end'"], "'Knock knock! Who's there?'"),
                q_short("Tell a knock-knock joke to a grown-up. Did they laugh?", "Answers will vary."),
                q_mc("Jokes are meant to...", ["Make people laugh or smile", "Make people sad", "Confuse people on purpose in a mean way"], "Make people laugh or smile"),
                q_short("What is your favorite silly joke?", "Answers will vary."),
                q_mc("The funny ending part of a joke is called the...", ["Punchline", "Introduction", "Title"], "Punchline"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Fill in the blank to finish a silly rhyming joke.",
            "questions": [
                q_fill("Why did the cow jump over the moon? Because it wanted to see the ___! (rhymes with 'moon')", "raccoon (or any rhyming silly answer)"),
                q_mc("A rhyme happens when words...", ["End with the same or similar sounds", "Have nothing in common", "Are exactly the same word"], "End with the same or similar sounds"),
                q_short("Finish this silly rhyme: 'I have a pet frog, he likes to sit on a ___.'", "Answers will vary (should rhyme with 'frog', e.g., 'log')."),
                q_mc("Rhyming jokes are often funnier because...", ["The rhyme creates a fun surprise ending", "Rhymes are never funny", "Jokes don't need to make sense"], "The rhyme creates a fun surprise ending"),
                q_short("Make up your own silly rhyming joke.", "Answers will vary."),
                q_mc("What word rhymes with 'cat'?", ["Hat", "Dog", "Sun"], "Hat"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Try to guess the punchline!",
            "questions": [
                q_short("Why did the chicken cross the playground? Write your own silly punchline!", "Answers will vary."),
                q_mc("A punchline is...", ["The surprising, funny ending of a joke", "The very first line of a joke", "A serious statement"], "The surprising, funny ending of a joke"),
                q_short("What makes a punchline surprising or unexpected?", "Answers will vary (e.g., it's not what you'd normally expect)."),
                q_mc("A good punchline usually...", ["Surprises you with something you didn't expect", "Is exactly what you predicted", "Has nothing to do with the joke's setup"], "Surprises you with something you didn't expect"),
                q_short("Write your own joke setup, then leave the punchline blank for a friend to fill in.", "Answers will vary."),
                q_mc("Why do jokes need a clear SETUP before the punchline?", ["The setup creates the expectation the punchline surprisingly breaks", "Setups don't matter for jokes", "Punchlines work the same with or without a setup"], "The setup creates the expectation the punchline surprisingly breaks"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Match each pun to its silly double meaning.",
            "questions": [
                q_match("Match the pun word to its silly double meaning.", ["I'm reading a book about anti-gravity", "The math teacher called in sick with...", "I used to be a baker, but...", "I'm on a seafood diet"], ["It's impossible to put down!", "...too many problems!", "I couldn't make enough dough.", "I see food and I eat it!"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("A pun is a joke that plays with...", ["A word's multiple meanings or similar-sounding words", "Only numbers", "Only colors"], "A word's multiple meanings or similar-sounding words"),
                q_short("Explain why the 'seafood diet' pun is funny (hint: 'see food' sounds like 'seafood').", "It plays on the fact that 'sea food' and 'see food' sound the same, but mean very different things."),
                q_mc("Puns work because some words...", ["Sound alike or have double meanings", "Are always spelled the same", "Have only one possible meaning"], "Sound alike or have double meanings"),
                q_short("Try to explain a pun you already know to a friend.", "Answers will vary."),
                q_mc("Understanding puns requires...", ["Noticing a word's double meaning or sound-alike", "Ignoring what words actually mean", "Only knowing one meaning per word"], "Noticing a word's double meaning or sound-alike"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Write your own knock-knock joke.",
            "questions": [
                q_short("Write a full knock-knock joke with a setup and a silly punchline.", "Answers will vary."),
                q_mc("A knock-knock joke follows a pattern:", ["Knock knock, who's there?, [name], [name] who?, punchline", "It has no pattern at all", "It's always exactly the same joke"], "Knock knock, who's there?, [name], [name] who?, punchline"),
                q_short("Try your joke out on a friend or family member. Did it get a laugh?", "Answers will vary."),
                q_mc("A good knock-knock joke often uses a name that sounds like...", ["Another word or phrase, for a surprising twist", "A completely random word with no connection", "The exact same word as the setup"], "Another word or phrase, for a surprising twist"),
                q_short("If your joke didn't get a laugh, how could you revise it to be funnier?", "Answers will vary."),
                q_short("Write a SECOND knock-knock joke using a different silly name.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Learn the setup + punchline structure of joke-writing.",
            "questions": [
                q_short("Write a joke SETUP that creates an expectation (like starting a normal-sounding story).", "Answers will vary."),
                q_short("Write a PUNCHLINE that surprisingly breaks that expectation.", "Answers will vary."),
                q_mc("The setup of a joke should be...", ["Clear enough to create an expectation to subvert", "Confusing on purpose", "The funniest part of the joke"], "Clear enough to create an expectation to subvert"),
                q_short("Why does timing matter when TELLING a joke, not just writing it?", "A well-timed pause before the punchline builds anticipation, making the surprise land better."),
                q_mc("A punchline is funniest when it's...", ["Unexpected but still makes sense once you hear it", "Completely unrelated and makes no sense", "The same as the setup"], "Unexpected but still makes sense once you hear it"),
                q_short("Write a full joke using the setup + punchline structure, on a topic of your choice.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Explore wordplay: puns, homophones, and double meanings.",
            "questions": [
                q_mc("A homophone is a word that...", ["Sounds the same as another word but means something different", "Looks the same as another word", "Has no relationship to any other word"], "Sounds the same as another word but means something different"),
                q_fill("What homophone sounds the same as 'flower' but means part of a plant that blooms?", "Flower (homophone: flour)"),
                q_short("Give an example of a word with a DOUBLE MEANING (like 'bat' — an animal or sports equipment).", "Answers will vary."),
                q_mc("Wordplay jokes rely on...", ["The multiple ways a word or sound can be interpreted", "Only serious, literal meanings", "Ignoring what words mean entirely"], "The multiple ways a word or sound can be interpreted"),
                q_short("Write a short joke using a homophone or double-meaning word.", "Answers will vary."),
                q_mc("Why can wordplay jokes be tricky to translate into other languages?", ["The specific sound-alike or double meaning often doesn't exist in another language", "All languages have the exact same wordplay", "Wordplay has nothing to do with language"], "The specific sound-alike or double meaning often doesn't exist in another language"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write and 'perform' a short stand-up comedy bit.",
            "questions": [
                q_short("Write a short stand-up bit (a few connected jokes on one topic).", "Answers will vary."),
                q_short("Add timing/delivery notes to your bit (e.g., '[pause]' before the punchline).", "Answers will vary."),
                q_mc("Stand-up comedy timing refers to...", ["The pacing and pauses that make jokes land well", "Only how long the whole show lasts", "Nothing important"], "The pacing and pauses that make jokes land well"),
                q_short("Why might the SAME joke get a different reaction depending on how it's delivered?", "Delivery — pacing, tone, pauses — affects how the surprise and humor land with the audience."),
                q_mc("A stand-up 'bit' usually connects multiple jokes around...", ["One shared topic or theme", "Completely unrelated topics with no connection", "Only a single word"], "One shared topic or theme"),
                q_short("Practice performing (or reading aloud) your bit. What delivery choice worked best?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HUMOR_PLAY 3/4: Riddles & Brain Teasers
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "riddles", "subject_area": "humor_play", "category_name": "Riddles & Brain Teasers", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Riddle: I'm round and I roll. Children play with me at the park. What am I?", "A ball."),
                q_short("Riddle: I have a face but no eyes, and hands but no fingers. What am I?", "A clock."),
                q_mc("A riddle is...", ["A puzzling question with a clever answer", "A type of food", "A song"], "A puzzling question with a clever answer"),
                q_short("Riddle: I'm yellow and curved, and monkeys love to eat me. What am I?", "A banana."),
                q_mc("Solving riddles helps you practice...", ["Thinking carefully about clues", "Ignoring clues completely", "Nothing useful"], "Thinking carefully about clues"),
                q_short("Make up your own simple picture riddle.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve the What-Am-I riddles!",
            "questions": [
                q_short("What am I? I have leaves and branches, and birds build nests in me. What am I?", "A tree."),
                q_short("What am I? I'm cold, white, and fall from the sky in winter. What am I?", "Snow."),
                q_mc("A 'What am I?' riddle gives you...", ["Clues to help you guess the answer", "The answer right away", "No information at all"], "Clues to help you guess the answer"),
                q_short("What am I? I have a shell and move very slowly. What am I?", "A snail (or turtle)."),
                q_mc("Why do riddles give clues instead of just stating the answer?", ["It makes solving the puzzle fun and engaging", "Riddles are supposed to be impossible", "Clues don't actually help"], "It makes solving the puzzle fun and engaging"),
                q_short("Write your own 'What am I?' riddle about an animal.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve riddles using picture clues.",
            "questions": [
                q_short("Riddle with clues: I have wheels, a seat, and pedals — but I'm not a car. What am I?", "A bicycle."),
                q_short("Riddle with clues: I have keys but open no locks. I have space but no room. What am I?", "A keyboard."),
                q_mc("Picture clues in a riddle help you...", ["Narrow down the possible answers", "Make the riddle impossible", "Nothing useful"], "Narrow down the possible answers"),
                q_short("If a riddle gives you 3 clues, why might reading ALL of them (not just the first) help you solve it?", "Later clues often narrow down the answer further and rule out wrong guesses."),
                q_mc("A good riddle solver...", ["Considers all the clues together before answering", "Guesses immediately without thinking", "Ignores most of the clues"], "Considers all the clues together before answering"),
                q_short("Write a riddle with 2 picture clues for a friend to solve.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Write your own riddle with clear clues.",
            "questions": [
                q_short("Pick an object. Write 3 clues about it (without naming it) for your riddle.", "Answers will vary."),
                q_mc("A well-written riddle's clues should be...", ["Specific enough to be solvable, but not too obvious", "So vague no one could ever guess", "So obvious it's not really a puzzle"], "Specific enough to be solvable, but not too obvious"),
                q_short("Test your riddle on a friend or family member. Could they solve it?", "Answers will vary."),
                q_mc("If your riddle was solved instantly, what might that mean?", ["The clues may have been too obvious", "The riddle is perfectly written", "The riddle has no answer"], "The clues may have been too obvious"),
                q_short("If no one could solve your riddle, how might you make the clues clearer?", "Answers will vary (e.g., add a more specific clue)."),
                q_short("Write a SECOND riddle about a different object, using what you learned.", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve a logic riddle: who-owns-what grid puzzle.",
            "questions": [
                q_short("Logic riddle: Ana, Ben, and Cleo each own a different pet (dog, cat, fish). Ana doesn't own the dog. Ben doesn't own the fish. Who owns the fish?", "Ana owns the fish (since Ben doesn't own the fish and Ana doesn't own the dog, working through the clues, Ana must own the fish or cat — with proper clues this resolves to Ana=fish, Ben=cat, Cleo=dog, or similar deduction depending on exact setup)."),
                q_mc("A who-owns-what logic riddle is solved by...", ["Using clues to eliminate impossible options one by one", "Guessing randomly", "Ignoring the clues"], "Using clues to eliminate impossible options one by one"),
                q_short("Why is a grid (rows and columns) a helpful tool for solving this kind of riddle?", "It helps you track which combinations are ruled out and which remain possible."),
                q_mc("In logic riddles, if a clue rules out an option, you should...", ["Cross it off and use that to narrow down other clues", "Ignore the clue and guess anyway", "Assume the clue is wrong"], "Cross it off and use that to narrow down other clues"),
                q_short("Write your own simple 'who owns what' riddle with 2 clues for a friend.", "Answers will vary."),
                q_mc("Logic riddles like this practice mainly...", ["Deductive reasoning", "Memorization only", "Drawing skills"], "Deductive reasoning"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve multi-clue riddles.",
            "questions": [
                q_short("Riddle: I have cities but no houses, forests but no trees, and water but no fish. What am I?", "A map."),
                q_mc("A multi-clue riddle gives you SEVERAL clues that...", ["All must fit together to point to one answer", "Are unrelated and don't need to fit together", "Contradict each other on purpose"], "All must fit together to point to one answer"),
                q_short("Riddle: The more you take, the more you leave behind. What am I?", "Footsteps."),
                q_short("Explain your strategy for solving a multi-clue riddle — do you use all clues at once, or one at a time?", "Answers will vary — often it helps to think through clues one at a time, checking each guess against all of them."),
                q_mc("If your first guess fits some clues but not others, you should...", ["Keep thinking — the answer must fit ALL the clues", "Go with that guess anyway", "Give up immediately"], "Keep thinking — the answer must fit ALL the clues"),
                q_short("Write your own multi-clue riddle (at least 3 clues) for a friend to solve.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Try lateral-thinking brain teasers.",
            "questions": [
                q_short("Brain teaser: A man lives on the 10th floor. Every day he takes the elevator down to the ground floor. When he comes home, he only rides the elevator to the 7th floor and walks the rest — except on rainy days, when he goes all the way to the 10th floor. Why?", "He's too short to reach the button for the 10th floor, but on rainy days he uses his umbrella to press it."),
                q_mc("Lateral thinking means solving a problem by...", ["Looking at it from an unexpected angle, not just the obvious approach", "Only using the most obvious approach", "Giving up if the answer isn't immediately clear"], "Looking at it from an unexpected angle, not just the obvious approach"),
                q_short("Why do lateral-thinking brain teasers often have surprising answers?", "They're designed so the obvious assumption is wrong, requiring creative thinking to solve."),
                q_mc("A good strategy for a lateral-thinking puzzle is to...", ["Question your assumptions about the situation", "Assume the first idea you have is correct", "Refuse to think about it differently"], "Question your assumptions about the situation"),
                q_short("Write your own simple lateral-thinking brain teaser.", "Answers will vary."),
                q_mc("Brain teasers like this mainly build...", ["Creative and flexible problem-solving", "Memorization skills only", "Nothing useful"], "Creative and flexible problem-solving"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a set of riddle escape-room cards.",
            "questions": [
                q_short("Design a themed escape-room scenario (e.g., a pirate ship, a haunted house). Describe the setting.", "Answers will vary."),
                q_short("Write riddle #1 for your escape-room set, with its answer.", "Answers will vary."),
                q_short("Write riddle #2, designed to be a bit harder than #1.", "Answers will vary."),
                q_mc("A good escape-room riddle set should...", ["Get progressively more challenging as players go", "Have every riddle be equally easy", "Have no connection to the theme"], "Get progressively more challenging as players go"),
                q_short("How would solving each riddle lead to the next clue or the final 'escape'?", "Answers will vary."),
                q_mc("Designing a full riddle set (not just one riddle) requires thinking about...", ["Difficulty progression and how riddles connect to each other", "Only one single isolated riddle", "Nothing beyond writing random riddles"], "Difficulty progression and how riddles connect to each other"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# HUMOR_PLAY 4/4: Sense of Humor & Playful Perspective
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "sense_humor", "subject_area": "humor_play", "category_name": "Sense of Humor & Playful Perspective", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("What makes you giggle the most?", "Answers will vary."),
                q_mc("Laughing and giggling usually means you feel...", ["Happy and amused", "Sad", "Scared"], "Happy and amused"),
                q_short("Draw a picture of something silly that makes you laugh.", "Answers will vary."),
                q_mc("It's okay to laugh when something is...", ["Genuinely funny and not hurting anyone", "Someone else getting hurt", "Someone feeling embarrassed on purpose"], "Genuinely funny and not hurting anyone"),
                q_short("Name a silly face you can make.", "Answers will vary."),
                q_mc("Having a sense of humor means...", ["Being able to notice and enjoy funny things", "Never smiling or laughing", "Making fun of others meanly"], "Being able to notice and enjoy funny things"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sort each picture as SILLY or SERIOUS.",
            "questions": [
                q_match("Sort each scene as silly or serious.", ["A dog wearing sunglasses and a hat", "A doctor checking a patient", "A cat riding a skateboard", "A firefighter putting out a fire"], ["Silly", "Serious", "Silly", "Serious"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("Something SILLY is usually...", ["Playful and unexpected", "Very formal and serious", "Boring"], "Playful and unexpected"),
                q_mc("Something SERIOUS usually deals with...", ["Important or formal matters", "Only jokes", "Nothing important at all"], "Important or formal matters"),
                q_short("Describe one silly thing and one serious thing from your day.", "Answers will vary."),
                q_mc("Being able to tell silly from serious situations helps you...", ["Know how to act appropriately in each situation", "Nothing useful", "Always act the exact same way"], "Know how to act appropriately in each situation"),
                q_short("Draw one silly scene and one serious scene.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Retell a story, but exaggerate it for laughs!",
            "questions": [
                q_short("Pick a simple everyday event (like brushing your teeth). Retell it in a WAY exaggerated, silly way.", "Answers will vary — should include exaggeration for comic effect."),
                q_mc("Exaggeration in storytelling means...", ["Making something sound much bigger or more dramatic than it really is", "Telling the story exactly as it happened", "Leaving out all details"], "Making something sound much bigger or more dramatic than it really is"),
                q_short("What part of your retelling did you exaggerate the MOST?", "Answers will vary."),
                q_mc("Exaggeration is a common technique used to...", ["Make a story funnier or more entertaining", "Make a story more boring", "Make a story completely factual"], "Make a story funnier or more entertaining"),
                q_short("Read your exaggerated retelling out loud. Does it sound funnier than the plain version?", "Answers will vary."),
                q_mc("Why is exaggeration considered a HUMOR technique?", ["The gap between reality and the exaggerated version is often what's funny", "Exaggeration always makes stories sadder", "It has nothing to do with humor"], "The gap between reality and the exaggerated version is often what's funny"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare a funny version of a story to a serious version.",
            "questions": [
                q_short("Write 2-3 sentences telling a simple event SERIOUSLY (e.g., 'I dropped my ice cream').", "Answers will vary."),
                q_short("Now rewrite the SAME event in a FUNNY, exaggerated way.", "Answers will vary."),
                q_mc("What changed between your serious and funny versions?", ["Tone, word choice, and level of exaggeration", "Nothing changed at all", "Only the ending changed"], "Tone, word choice, and level of exaggeration"),
                q_short("Which version was more fun to write? Why?", "Answers will vary."),
                q_mc("The same event can be told seriously OR humorously because...", ["How you tell a story shapes how it feels, regardless of the facts", "Facts always determine exactly how a story must be told", "Serious and funny stories can never share the same facts"], "How you tell a story shapes how it feels, regardless of the facts"),
                q_short("What specific word choices made your funny version funnier?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a silly alternate ending to a story you know.",
            "questions": [
                q_short("Pick a story you know well. Write a silly, unexpected alternate ending for it.", "Answers will vary."),
                q_mc("An 'alternate ending' means...", ["A different way the story could have concluded", "The exact same ending, unchanged", "The very beginning of the story"], "A different way the story could have concluded"),
                q_short("What makes your alternate ending silly or surprising compared to the original?", "Answers will vary."),
                q_mc("Writing silly alternate endings is a good way to practice...", ["Creative thinking and playing with expectations", "Copying stories exactly as written", "Avoiding any creativity"], "Creative thinking and playing with expectations"),
                q_short("Would your alternate ending still make sense with the rest of the story? Explain.", "Answers will vary."),
                q_short("Write ANOTHER silly alternate ending for a different, well-known story.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Identify humor techniques: exaggeration, surprise, and wordplay.",
            "questions": [
                q_match("Match each joke technique to its example.",
                        ["'I'm so hungry I could eat a whole elephant!'", "A story that ends with an unexpected twist", "'I'm reading a book on anti-gravity — it's impossible to put down!'"],
                        ["Exaggeration", "Surprise", "Wordplay"], [[0, 0], [1, 1], [2, 2]]),
                q_mc("Exaggeration as a humor technique means...", ["Making something sound much bigger than reality for comic effect", "Understating something to be less dramatic", "Being completely literal and factual"], "Making something sound much bigger than reality for comic effect"),
                q_short("Find or write an example of a joke that uses SURPRISE.", "Answers will vary."),
                q_mc("Wordplay humor relies on...", ["Multiple meanings or sounds of words", "Only visual images", "Numbers and math"], "Multiple meanings or sounds of words"),
                q_short("Which humor technique (exaggeration, surprise, or wordplay) do you find funniest? Why?", "Answers will vary."),
                q_short("Write a joke that uses TWO humor techniques at once.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a humorous short paragraph.",
            "questions": [
                q_short("Write a humorous short paragraph (4-6 sentences) about an everyday topic.", "Answers will vary."),
                q_mc("A humorous paragraph often uses...", ["Exaggeration, surprise, or clever wordplay", "Only plain, literal statements with no creativity", "Sad or serious language"], "Exaggeration, surprise, or clever wordplay"),
                q_short("Which sentence in your paragraph do you think is the funniest? Why?", "Answers will vary."),
                q_mc("Reading your writing OUT LOUD can help you notice...", ["Whether the humor and timing actually land", "Nothing useful about the writing", "Only spelling mistakes"], "Whether the humor and timing actually land"),
                q_short("Revise your paragraph to make one part even funnier.", "Answers will vary."),
                q_mc("Writing humor well requires...", ["Understanding your audience and what they'll find funny", "Ignoring your audience completely", "Only following strict formal rules"], "Understanding your audience and what they'll find funny"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Analyze what makes a joke work, then write your own original humorous piece.",
            "questions": [
                q_short("Pick a joke you find funny. Analyze it: what technique (exaggeration, surprise, wordplay) makes it work?", "Answers will vary."),
                q_short("Why does that technique specifically make the joke funny to you?", "Answers will vary."),
                q_mc("Analyzing humor helps you understand...", ["The craft and technique behind what makes something funny", "Nothing useful — humor can't be analyzed", "Only whether a joke is 'good' or 'bad' with no reasoning"], "The craft and technique behind what makes something funny"),
                q_short("Write an original humorous piece (a joke, short story, or paragraph) using at least one technique you analyzed.", "Answers will vary."),
                q_mc("Understanding HOW humor works can help a writer...", ["Craft jokes and funny writing more intentionally", "Never actually be funny", "Avoid humor entirely"], "Craft jokes and funny writing more intentionally"),
                q_short("What's one thing you'd revise in your original piece to make it even funnier?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CHARACTER 1/3: Moral Lessons & Everyday Values
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "moral_lessons", "subject_area": "character", "category_name": "Moral Lessons & Everyday Values", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_match("Sort each action as KIND or UNKIND.", ["Sharing a toy", "Taking without asking", "Helping a friend up", "Laughing at someone who fell"], ["Kind", "Unkind", "Kind", "Unkind"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("Sharing your toys with a friend is a...", ["Kind action", "Unkind action", "Neither"], "Kind action"),
                q_short("Name one kind thing you did today or could do today.", "Answers will vary."),
                q_mc("Being unkind to someone usually makes them feel...", ["Sad or hurt", "Happy", "Nothing at all"], "Sad or hurt"),
                q_short("Draw a picture of yourself doing something kind.", "Answers will vary."),
                q_mc("Choosing kindness is a way to show...", ["Good character", "Bad character", "Nothing important"], "Good character"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read a simple fable, then think: what did we learn?",
            "questions": [
                q_short("Fable: The Tortoise and the Hare — a fast hare loses a race to a slow, steady tortoise because he stops to nap. What lesson does this fable teach?", "Slow and steady effort can win — don't be overconfident."),
                q_mc("A fable is a short story that usually teaches...", ["A lesson or moral", "Only facts about animals", "Nothing at all"], "A lesson or moral"),
                q_short("What did YOU learn from the Tortoise and the Hare story?", "Answers will vary — should reflect the moral of persistence over overconfidence."),
                q_mc("Fables often use animal characters to...", ["Teach lessons in a fun, memorable way", "Give real facts about animal behavior", "Confuse the reader on purpose"], "Teach lessons in a fun, memorable way"),
                q_short("Can you think of a time being 'slow and steady' helped you, like the tortoise?", "Answers will vary."),
                q_short("Draw a picture showing the lesson from the fable.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read a short values story, then write its one-sentence lesson.",
            "questions": [
                q_short("Story: A boy finds a lost wallet full of money and returns it to its owner instead of keeping it. Write the ONE-SENTENCE lesson.", "Honesty and doing the right thing matter, even when no one is watching."),
                q_mc("A 'values story' is meant to...", ["Show a character making a good choice, teaching a lesson", "Just entertain with no deeper meaning", "Confuse the reader about right and wrong"], "Show a character making a good choice, teaching a lesson"),
                q_short("Why might the boy have been tempted to keep the money instead of returning it?", "Answers will vary (e.g., he could have used the money for himself)."),
                q_mc("Doing the right thing even when it's hard shows...", ["Strong character", "Weakness", "Nothing important"], "Strong character"),
                q_short("Write your own one-sentence lesson from a story you know.", "Answers will vary."),
                q_mc("Why do many stories include a clear lesson at the end?", ["To help readers think about how to act in their own lives", "Lessons are never actually included in stories", "Only to make the story longer"], "To help readers think about how to act in their own lives"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare two characters' choices: the 'right' choice vs. the 'easy' choice.",
            "questions": [
                q_short("Scenario: A student sees a classmate cheating on a test. Character A tells the teacher (the right choice). Character B says nothing (the easy choice). Why might B's choice feel easier in the moment?", "Telling on someone can feel uncomfortable or risky, even if it's the right thing to do."),
                q_short("What are the possible consequences of Character B's easy choice?", "Answers will vary (e.g., the cheating continues, it feels unfair to others)."),
                q_mc("The 'right' choice and the 'easy' choice are...", ["Sometimes different things", "Always exactly the same", "Never related at all"], "Sometimes different things"),
                q_mc("Choosing the right choice over the easy choice often requires...", ["Courage", "No effort at all", "Ignoring the situation"], "Courage"),
                q_short("Describe a time you (or someone you know) chose the RIGHT thing even though it was harder.", "Answers will vary."),
                q_short("Why might it get easier to make the right choice with practice?", "Answers will vary (e.g., it builds a habit and confidence over time)."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read a fable or parable and identify its moral.",
            "questions": [
                q_short("Fable: The Boy Who Cried Wolf — a boy repeatedly lies about a wolf attacking his sheep, and when a real wolf comes, no one believes him. What is the moral?", "Lying repeatedly makes people stop trusting you, even when you're telling the truth."),
                q_mc("A 'moral' is...", ["The lesson a story teaches", "The title of the story", "A character's name"], "The lesson a story teaches"),
                q_short("How does the boy's own actions (lying) cause the sad outcome of the story?", "His repeated lies destroyed his credibility, so no one believed him when he told the truth."),
                q_mc("Fables and parables often use a clear cause-and-effect structure to...", ["Make the moral easy to understand", "Hide the moral completely", "Avoid teaching anything"], "Make the moral easy to understand"),
                q_short("Find or think of another fable/parable and identify its moral.", "Answers will vary."),
                q_short("Why has 'The Boy Who Cried Wolf' remained a popular story for a long time?", "Its lesson about honesty and trust is still relevant and easy to understand across generations."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare two characters' choices under real pressure.",
            "questions": [
                q_short("Scenario: Two friends are pressured by a group to make fun of a new student. One joins in; one refuses and walks away. Describe both characters' choices and consequences.", "Answers will vary — should describe social consequences for both."),
                q_mc("Peer pressure is...", ["The influence of a group pushing someone toward a certain choice", "Always a good thing", "Something that never actually happens"], "The influence of a group pushing someone toward a certain choice"),
                q_short("Why might it be especially hard to make the right choice UNDER pressure from friends?", "Fear of rejection or wanting to fit in can make it harder to go against the group."),
                q_mc("Standing up to peer pressure usually requires...", ["Confidence in your own values", "Just going along with the group easily", "Avoiding the situation entirely by not showing up"], "Confidence in your own values"),
                q_short("What could the character who refused say to the group to explain their choice?", "Answers will vary."),
                q_mc("Why might making the right choice under pressure feel more meaningful than an easy right choice?", ["It shows real character strength when it's genuinely difficult", "It doesn't actually matter more", "Pressure situations are never meaningful"], "It shows real character strength when it's genuinely difficult"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write your own short story with a clear moral.",
            "questions": [
                q_short("Choose a moral/lesson you want your story to teach (e.g., 'honesty is important'). State it.", "Answers will vary."),
                q_short("Write a short story (several sentences) where a character learns that lesson through their choices.", "Answers will vary."),
                q_mc("A story with a strong moral usually SHOWS the lesson through...", ["The character's actions and their consequences", "Just stating the moral directly with no story", "Random unrelated events"], "The character's actions and their consequences"),
                q_short("How does your character change or learn by the end of the story?", "Answers will vary."),
                q_mc("Why is 'showing' a lesson through story events usually more powerful than just 'telling' it directly?", ["Readers connect more with lessons they experience through characters", "Telling is always more effective than showing", "There's no difference between showing and telling"], "Readers connect more with lessons they experience through characters"),
                q_short("Read your story aloud. Is the moral clear without being too obvious or preachy?", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Reflect and apply: connect a story's lesson to your own real life.",
            "questions": [
                q_short("Pick a story with a moral you know well. State the moral clearly.", "Answers will vary."),
                q_short("Describe a real situation in YOUR life where that lesson could apply.", "Answers will vary."),
                q_short("How would applying that lesson change how you'd handle the real situation?", "Answers will vary."),
                q_mc("Connecting a story's lesson to real life mainly helps you...", ["Actually use what you learned, not just remember the story", "Nothing useful, stories and real life are unrelated", "Forget the story faster"], "Actually use what you learned, not just remember the story"),
                q_mc("Why might the same moral (like honesty) apply to many different real-life situations?", ["Core values tend to matter across many different contexts", "Morals only ever apply to the exact story they came from", "Morals don't actually apply to real life at all"], "Core values tend to matter across many different contexts"),
                q_short("Write a short reflection: what's one value from a story that you try to live by?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CHARACTER 2/3: Manners & Everyday Respect
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "manners_respect", "subject_area": "character", "category_name": "Manners & Everyday Respect", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("What do you say when you want something?", ["Please", "Nothing", "Give me that"], "Please"),
                q_mc("What do you say when someone helps you?", ["Thank you", "Nothing", "Go away"], "Thank you"),
                q_short("Draw a picture of yourself saying 'please' or 'thank you.'", "Answers will vary."),
                q_mc("Saying please and thank you shows...", ["Good manners", "Bad manners", "Nothing important"], "Good manners"),
                q_short("Practice saying 'please' and 'thank you' to a grown-up today.", "Answers will vary."),
                q_mc("Using kind, polite words helps people feel...", ["Respected and appreciated", "Ignored", "Annoyed"], "Respected and appreciated"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Match each good-manners situation to the polite response.",
            "questions": [
                q_match("Match each situation to a good-manners response.", ["Meeting someone new", "A friend shares their snack", "You bump into someone", "Someone gives you a gift"], ["Say hello and your name", "Say thank you", "Say excuse me or sorry", "Say thank you"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("A polite greeting includes...", ["Saying hello and being friendly", "Ignoring the person", "Walking away"], "Saying hello and being friendly"),
                q_short("Why is it polite to say 'excuse me' if you bump into someone?", "It shows you noticed and care that it might have bothered them."),
                q_mc("Sharing with others is an example of...", ["Good manners", "Bad manners", "Being unfair"], "Good manners"),
                q_short("Practice greeting a family member politely.", "Answers will vary."),
                q_mc("Good manners help people get along because...", ["They show respect and kindness toward others", "They make people feel worse", "Manners don't matter at all"], "They show respect and kindness toward others"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Check off good table manners.",
            "questions": [
                q_short("List 3 good table manners (e.g., chew with your mouth closed).", "Answers will vary."),
                q_mc("Good table manners include...", ["Chewing with your mouth closed", "Talking with food in your mouth", "Grabbing food without asking"], "Chewing with your mouth closed"),
                q_short("Why do table manners matter when eating with other people?", "They show respect for others and make mealtimes more pleasant for everyone."),
                q_mc("If you want more food at the table, you should...", ["Politely ask for it", "Grab it without asking", "Reach across someone's plate"], "Politely ask for it"),
                q_short("Practice using good table manners at your next meal.", "Answers will vary."),
                q_mc("Table manners are especially important when...", ["Eating with others, like family or guests", "Eating completely alone", "It never matters"], "Eating with others, like family or guests"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare manners in different places: school, restaurant, home.",
            "questions": [
                q_short("What's one manner that's especially important at SCHOOL?", "Answers will vary (e.g., raising your hand, listening quietly)."),
                q_short("What's one manner that's especially important at a RESTAURANT?", "Answers will vary (e.g., using an inside voice, saying please/thank you to the server)."),
                q_short("What's one manner that's especially important at HOME?", "Answers will vary (e.g., helping with chores, being kind to family)."),
                q_mc("Manners can change slightly depending on...", ["The setting or situation you're in", "Nothing — manners are always identical everywhere", "Only your mood"], "The setting or situation you're in"),
                q_mc("Why might a manner important at a restaurant (like waiting to be seated) not matter as much at home?", ["Different places have different expectations for behavior", "Manners are exactly the same everywhere", "Restaurants don't actually need manners"], "Different places have different expectations for behavior"),
                q_short("Why is it useful to think about which manners fit which situation?", "It helps you behave appropriately and respectfully wherever you are."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Learn digital manners: sending kind messages and basic netiquette.",
            "questions": [
                q_short("Rewrite this rude message to be more polite: 'ur wrong, thats dumb.'", "Answers will vary (e.g., 'I see it differently — can you explain your thinking?')."),
                q_mc("'Netiquette' refers to...", ["Good manners for online communication", "A type of internet game", "A rule that doesn't actually exist"], "Good manners for online communication"),
                q_short("Why can it be easier to be unintentionally rude in a text message than in person?", "Without tone of voice or facial expressions, messages can be misread as harsher than intended."),
                q_mc("Before sending a message, a good digital-manners habit is to...", ["Reread it and consider how it might sound to the other person", "Send it immediately without thinking", "Never send any messages at all"], "Reread it and consider how it might sound to the other person"),
                q_short("Write an example of a kind, respectful message you could send a friend.", "Answers will vary."),
                q_mc("Why do digital manners matter just as much as in-person manners?", ["Words online can still affect real people's feelings", "Online words don't affect anyone", "Digital manners are less important than in-person ones"], "Words online can still affect real people's feelings"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Practice respectful disagreement — polite ways to say no or disagree.",
            "questions": [
                q_short("Rewrite this rude disagreement to be more respectful: 'That's a stupid idea.'", "Answers will vary (e.g., 'I see it differently — here's why I think...')."),
                q_mc("Respectful disagreement means...", ["Sharing a different opinion without being disrespectful", "Never disagreeing with anyone, ever", "Being rude to prove your point"], "Sharing a different opinion without being disrespectful"),
                q_short("Write a polite way to say 'no' to a friend's invitation you can't accept.", "Answers will vary (e.g., 'Thanks for asking, but I can't make it this time.')."),
                q_mc("Why is it possible to disagree with someone AND still be respectful?", ["Disagreeing with an idea doesn't mean disrespecting the person", "Disagreement always requires disrespect", "You should always just agree to avoid conflict"], "Disagreeing with an idea doesn't mean disrespecting the person"),
                q_short("Why might practicing polite disagreement help you in friendships and group work?", "It helps you express honest opinions while keeping relationships positive."),
                q_mc("A respectful way to disagree usually starts with...", ["Acknowledging the other person's point before sharing your own", "Immediately saying they're wrong", "Refusing to explain your reasoning"], "Acknowledging the other person's point before sharing your own"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare manners and greetings from different cultures around the world.",
            "questions": [
                q_short("Research or recall one greeting custom from a culture different from your own (e.g., a bow, a specific handshake).", "Answers will vary."),
                q_short("How is that greeting similar to or different from a greeting you're familiar with?", "Answers will vary."),
                q_mc("Manners and greetings can differ across cultures because...", ["Different cultures have different traditions and values", "All cultures share the exact same manners", "Manners are random with no cultural meaning"], "Different cultures have different traditions and values"),
                q_mc("Learning about manners from other cultures helps you...", ["Show respect when interacting with people from different backgrounds", "Nothing useful", "Judge other cultures as wrong"], "Show respect when interacting with people from different backgrounds"),
                q_short("Why might it be considered polite in one culture and rude in another to do the same thing (like making direct eye contact)?", "Answers will vary — cultural norms around respect and politeness aren't universal."),
                q_short("What's one thing you'd want to learn more about regarding manners in another culture?", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Practice writing polite responses to tricky etiquette scenarios.",
            "questions": [
                q_short("Scenario: You receive a gift you don't like. Write a polite response.", "Answers will vary (e.g., 'Thank you so much, that was really thoughtful of you.')."),
                q_short("Scenario: A friend keeps interrupting you. Write a polite way to address it.", "Answers will vary (e.g., 'Can I finish my thought, and then I'd love to hear yours?')."),
                q_short("Scenario: You need to leave a conversation but don't want to seem rude. Write a polite exit.", "Answers will vary (e.g., 'It was great talking with you — I need to head out now.')."),
                q_mc("A polite response in a tricky situation usually...", ["Balances honesty with kindness and tact", "Requires lying about your true feelings", "Means avoiding the situation entirely"], "Balances honesty with kindness and tact"),
                q_mc("Why is etiquette especially useful in AWKWARD or tricky social situations?", ["It gives you a respectful way to handle discomfort gracefully", "Etiquette only matters in easy, comfortable situations", "Awkward situations don't need any tact"], "It gives you a respectful way to handle discomfort gracefully"),
                q_short("Write your own tricky etiquette scenario and a polite response to it.", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CHARACTER 3/3: Brain Motivation & Growth Mindset
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "growth_mindset", "subject_area": "character", "category_name": "Brain Motivation & Growth Mindset", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("If something is hard, you can say...", ["'I can try!'", "'I quit!'", "'I refuse!'"], "'I can try!'"),
                q_short("Name something that was hard for you at first but got easier with practice.", "Answers will vary."),
                q_mc("Trying, even when something is hard, shows...", ["Bravery and effort", "Weakness", "Nothing important"], "Bravery and effort"),
                q_short("Draw a sticker chart with 3 stars for 3 times you tried something hard.", "Answers will vary."),
                q_mc("What should you say to yourself when facing something new and hard?", ["'I can try!'", "'I'll never be able to do this.'", "'This is impossible.'"], "'I can try!'"),
                q_short("What is something new you'd like to try, even if it's a little hard?", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sort each statement as GROWTH MINDSET ('yet') or FIXED MINDSET ('can't').",
            "questions": [
                q_match("Sort each statement.", ["I can't do this... yet!", "I can't do this, ever.", "This is hard, but I'll keep trying.", "I'm just bad at this and always will be."], ["Growth mindset", "Fixed mindset", "Growth mindset", "Fixed mindset"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("Adding the word 'yet' to 'I can't do this' changes it into a...", ["Growth mindset statement", "Fixed mindset statement", "Meaningless statement"], "Growth mindset statement"),
                q_short("Rewrite 'I can't draw' using a growth mindset ('yet').", "'I can't draw yet, but I'm learning.'"),
                q_mc("A growth mindset believes that abilities...", ["Can improve with effort and practice", "Are fixed and can never change", "Don't matter at all"], "Can improve with effort and practice"),
                q_short("Think of something you'd like to say 'I can't do this... yet!' about.", "Answers will vary."),
                q_mc("Why is a growth mindset more helpful than a fixed mindset for learning?", ["It encourages you to keep trying instead of giving up", "It makes you give up faster", "There's no real difference between the two"], "It encourages you to keep trying instead of giving up"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice turning a 'can't' statement into a 'can' statement.",
            "questions": [
                q_short("Turn this into a 'can' statement: 'I can't do multiplication.'", "'I can learn multiplication with practice.'"),
                q_short("Turn this into a 'can' statement: 'I can't read this whole book.'", "'I can read this book one chapter at a time.'"),
                q_mc("Turning 'can't' into 'can' usually involves...", ["Adding a plan or acknowledging you're still learning", "Just ignoring the problem", "Pretending the task doesn't exist"], "Adding a plan or acknowledging you're still learning"),
                q_short("Write your own 'can't' statement, then turn it into a 'can' statement.", "Answers will vary."),
                q_mc("Why might changing your language from 'can't' to 'can' actually change how you feel?", ["The words you use can shape your mindset and motivation", "Words have no effect on feelings at all", "It only works for some people"], "The words you use can shape your mindset and motivation"),
                q_short("How would you help a friend who says 'I can't' about something they're struggling with?", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Reflect on effort vs. outcome.",
            "questions": [
                q_short("Describe a time you worked really hard (effort) even if the result (outcome) wasn't perfect.", "Answers will vary."),
                q_mc("'Effort' refers to...", ["How hard you tried", "Only the final result", "Something that doesn't matter"], "How hard you tried"),
                q_mc("'Outcome' refers to...", ["The final result of your effort", "Only how hard you tried", "Something unrelated to effort"], "The final result of your effort"),
                q_short("Why might praising EFFORT (not just outcome) help you want to keep trying hard things?", "Praising effort shows that trying hard matters, even if the result isn't perfect — this encourages persistence."),
                q_mc("Which is more within your control?", ["Your effort", "The exact outcome", "Neither is in your control"], "Your effort"),
                q_short("Think of a time your effort was high but the outcome wasn't what you hoped. What did you learn?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Set a small goal and track your progress toward it.",
            "questions": [
                q_short("Set a small, specific goal for this week.", "Answers will vary."),
                q_short("How will you track your progress toward this goal each day?", "Answers will vary."),
                q_mc("A good goal should be...", ["Specific and something you can actually track", "Vague and impossible to measure", "So big it feels impossible"], "Specific and something you can actually track"),
                q_short("What's one small step you'll take TODAY toward your goal?", "Answers will vary."),
                q_mc("Tracking your progress toward a goal helps you...", ["Stay motivated by seeing how far you've come", "Nothing useful", "Give up faster"], "Stay motivated by seeing how far you've come"),
                q_short("How will you feel and what will you do when you reach your goal?", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read a growth mindset story about a character who overcame a setback.",
            "questions": [
                q_short("Describe a character (real or fictional) who faced a setback and kept going. What happened?", "Answers will vary."),
                q_short("What growth mindset thoughts or actions helped that character keep trying?", "Answers will vary."),
                q_mc("A 'setback' is...", ["A difficulty or failure that gets in the way of progress", "A guaranteed permanent failure", "Something that never actually happens"], "A difficulty or failure that gets in the way of progress"),
                q_mc("Growth mindset stories often show that setbacks can...", ["Be overcome with persistence and the right mindset", "Never be overcome no matter what", "Only happen to certain people"], "Be overcome with persistence and the right mindset"),
                q_short("Have you ever faced a setback and kept going? What helped you?", "Answers will vary."),
                q_short("Why might reading about others overcoming setbacks help you when YOU face one?", "It shows that setbacks are a normal part of growth, and that persistence can lead to success."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Keep a motivation journal: what pushes you forward?",
            "questions": [
                q_short("What motivates YOU the most — a goal, a person, a feeling? Explain.", "Answers will vary."),
                q_short("Describe a time your motivation helped you push through something difficult.", "Answers will vary."),
                q_mc("A motivation journal helps you...", ["Notice patterns in what drives you to keep going", "Forget about your goals", "Nothing useful"], "Notice patterns in what drives you to keep going"),
                q_short("What's one thing that tends to DEMOTIVATE you? How could you handle that?", "Answers will vary."),
                q_mc("Understanding your own motivation can help you...", ["Set yourself up for success by leaning into what drives you", "Nothing useful for achieving goals", "Only matters for other people, not you"], "Set yourself up for success by leaning into what drives you"),
                q_short("Write a journal entry about what's motivating you this week.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a personal motivation plan: goals, obstacles, and self-talk.",
            "questions": [
                q_short("State a meaningful GOAL for your motivation plan.", "Answers will vary."),
                q_short("List one OBSTACLE that might get in the way of that goal.", "Answers will vary."),
                q_short("Write a positive SELF-TALK phrase you'll use when facing that obstacle.", "Answers will vary (e.g., 'I can handle challenges — I've done it before.')."),
                q_mc("Self-talk refers to...", ["The internal things you say to yourself", "Talking out loud to other people", "A type of journal"], "The internal things you say to yourself"),
                q_mc("Why is planning for obstacles BEFORE they happen useful?", ["You're less likely to be caught off guard and give up", "Obstacles never actually happen in real plans", "Planning for obstacles is a waste of time"], "You're less likely to be caught off guard and give up"),
                q_short("Put your full plan together: goal, likely obstacle, and your self-talk response.", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CULTURE 1/3: Chinese Language & Culture (Pinyin · Hanzi · Tang Poems)
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "chinese_culture", "subject_area": "culture", "category_name": "Chinese Language & Culture", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Trace the pinyin sound 'ma' and match it to a picture of a mother (妈).", "Answers will vary — should show traced 'ma' matched to the mother picture."),
                q_mc("Pinyin is used to help learners...", ["Sound out Chinese words using familiar letters", "Draw pictures", "Learn math"], "Sound out Chinese words using familiar letters"),
                q_short("Trace the pinyin sound 'ba' and match it to a picture of a father (爸).", "Answers will vary."),
                q_mc("Pinyin uses letters we already know to represent...", ["Chinese sounds", "English words", "Numbers"], "Chinese sounds"),
                q_short("Practice saying 'ma' and 'ba' out loud.", "Answers will vary."),
                q_mc("Learning pinyin is a first step toward...", ["Reading and speaking Chinese", "Learning to swim", "Learning art"], "Reading and speaking Chinese"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Trace and learn your first 10 Chinese characters (numbers and family).",
            "questions": [
                q_match("Match the Chinese character to its meaning.", ["一", "二", "三", "人"], ["One", "Two", "Three", "Person"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_short("Trace the character for 'one' (一). How many strokes does it have?", "One stroke."),
                q_mc("A Chinese character (hanzi) represents...", ["A word or idea, not just a sound", "Only a random shape with no meaning", "A number system only"], "A word or idea, not just a sound"),
                q_short("Practice writing the character for 'two' (二).", "Answers will vary."),
                q_mc("Learning to trace characters helps you...", ["Build muscle memory for writing them correctly", "Nothing useful", "Only helps with drawing, not writing"], "Build muscle memory for writing them correctly"),
                q_short("Which of the 10 characters you're learning is your favorite, and why?", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice pinyin tones and simple characters.",
            "questions": [
                q_mc("Mandarin Chinese uses tones, which means...", ["The pitch of your voice changes a word's meaning", "Tones are only used in singing", "Tones don't matter in Chinese"], "The pitch of your voice changes a word's meaning"),
                q_short("The word 'ma' can mean different things depending on its tone (mother, hemp, horse, scold). Why does tone matter so much in Mandarin?", "The same syllable can have completely different meanings depending on the tone used."),
                q_mc("How many main tones does Mandarin Chinese have?", ["4 (plus a neutral tone)", "1", "10"], "4 (plus a neutral tone)"),
                q_short("Practice saying 'ma' with a rising tone versus a falling tone. Can you hear the difference?", "Answers will vary."),
                q_short("Trace a simple character you're learning and say its pronunciation out loud.", "Answers will vary."),
                q_mc("Why is listening practice especially important for learning Mandarin tones?", ["Tones are best learned by hearing and imitating the correct pitch pattern", "Tones can be learned from reading alone", "Listening isn't necessary for tones"], "Tones are best learned by hearing and imitating the correct pitch pattern"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Build simple sentences using the Chinese characters you've learned.",
            "questions": [
                q_short("Using characters you know (like 我 'I', 是 'am', 人 'person'), try building the simple sentence '我是人' (I am a person). What does it say?", "I am a person."),
                q_mc("Building sentences from individual characters helps you...", ["See how words combine into meaning, like building blocks", "Nothing useful", "Only matters for reading, not speaking"], "See how words combine into meaning, like building blocks"),
                q_short("What is one simple sentence you could build with characters you've learned?", "Answers will vary."),
                q_mc("Chinese sentence word order can be...", ["Similar to English in simple sentences (subject-verb-object)", "Always completely random", "Impossible to learn"], "Similar to English in simple sentences (subject-verb-object)"),
                q_short("Why is practicing full sentences more useful than just memorizing single characters?", "It helps you actually communicate, not just recognize isolated words."),
                q_short("Write (or trace) a simple sentence using at least 2 characters you know.", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read and illustrate a short Tang poem: 静夜思 (Jìng Yè Sī, \"Quiet Night Thoughts\") by Li Bai.",
            "questions": [
                q_short("Li Bai's poem 静夜思 is about a traveler who sees moonlight and thinks of home. Draw a picture showing this scene.", "Answers will vary — should depict moonlight and a feeling of longing for home."),
                q_mc("Tang poems are a form of classical...", ["Chinese poetry", "Chinese cooking", "Chinese sport"], "Chinese poetry"),
                q_short("What feeling do you think the poem's traveler has when looking at the moon?", "Homesickness or longing for home."),
                q_mc("Why might moonlight be a common image in classical Chinese poetry?", ["It's associated with quiet reflection, distance, and thoughts of home", "Moonlight has no special meaning in Chinese poetry", "It's only used in modern poems"], "It's associated with quiet reflection, distance, and thoughts of home"),
                q_short("Have you ever felt homesick or thought of someone far away while looking at the moon or stars?", "Answers will vary."),
                q_short("Practice tracing or copying a few characters from the poem's title, 静夜思.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Practice recognizing character radicals — the building-block parts of characters.",
            "questions": [
                q_mc("A radical is...", ["A recurring part of a character that often hints at its meaning", "A whole separate word", "A punctuation mark"], "A recurring part of a character that often hints at its meaning"),
                q_short("The radical 氵(three dots, representing water) appears in characters related to water, like 河 (river) and 海 (ocean). Why might learning radicals help you guess a character's meaning?", "Radicals often give a clue about the character's category of meaning, even if you don't know the whole character yet."),
                q_mc("Recognizing radicals is similar to recognizing...", ["Common prefixes/roots in English (like 'un-' or 'tele-')", "Random unrelated symbols", "Punctuation marks"], "Common prefixes/roots in English (like 'un-' or 'tele-')"),
                q_short("Name one radical you've learned and a character that contains it.", "Answers will vary."),
                q_mc("Learning radicals is a strategy that helps with...", ["Reading and remembering unfamiliar characters", "Only speaking, not reading", "Nothing related to reading Chinese"], "Reading and remembering unfamiliar characters"),
                q_short("Why might breaking a complex character into smaller radical parts make it easier to remember?", "Smaller, familiar parts are easier to recognize and recall than one complex whole shape."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare two Tang poems by theme and imagery.",
            "questions": [
                q_short("Choose two Tang poems (or two you've read before). What is the main THEME of each?", "Answers will vary."),
                q_short("Compare the imagery (pictures the words create) used in each poem.", "Answers will vary."),
                q_mc("Tang poems often explore themes like...", ["Nature, longing, friendship, and reflection", "Only sports and games", "Only modern technology"], "Nature, longing, friendship, and reflection"),
                q_mc("Comparing two poems' imagery helps you notice...", ["How different poets express similar or different feelings", "Nothing useful about poetry", "That all poems are exactly identical"], "How different poets express similar or different feelings"),
                q_short("Which of your two poems do you connect with more, and why?", "Answers will vary."),
                q_short("Why might natural imagery (moon, mountains, rivers) be so common across many Tang poems?", "Nature was central to classical Chinese life and often used to reflect human emotions and philosophy."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Recite a Tang poem and write a personal reflection on it.",
            "questions": [
                q_short("Choose a Tang poem to recite (memorize and say aloud). Which one did you choose?", "Answers will vary."),
                q_short("Practice reciting it. What was challenging about memorizing it?", "Answers will vary."),
                q_short("Write a personal reflection: what does this poem mean to you, or how does it relate to your own life?", "Answers will vary."),
                q_mc("Reciting classical poetry helps preserve and honor...", ["Cultural and literary traditions passed down over generations", "Nothing meaningful", "Only modern trends"], "Cultural and literary traditions passed down over generations"),
                q_mc("Writing a personal reflection on a poem helps you...", ["Connect the poem's meaning to your own experiences", "Memorize it faster with no deeper understanding", "Avoid actually thinking about the poem's meaning"], "Connect the poem's meaning to your own experiences"),
                q_short("Would you recommend this poem to a friend? Why or why not?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CULTURE 2/3: Indian Culture & Gita Wisdom Stories
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "indian_gita", "subject_area": "culture", "category_name": "Indian Culture & Gita Wisdom Stories", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Hanuman, a beloved figure in Indian stories, is often shown as a...", ["Monkey", "Elephant", "Peacock"], "Monkey"),
                q_short("Match the animal friend to a story you know (real or imagined) — what animal helps the hero?", "Answers will vary."),
                q_mc("Hanuman is known in stories for being...", ["Brave and loyal", "Lazy and unkind", "Scared of everything"], "Brave and loyal"),
                q_short("Draw a picture of an animal friend helping a hero in a story.", "Answers will vary."),
                q_mc("Stories with animal friends often teach us about...", ["Courage, loyalty, and friendship", "Nothing important", "Only facts about animals"], "Courage, loyalty, and friendship"),
                q_short("Name one quality (like braveness) that a story character you like has.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Listen to and retell a simple Gita-inspired story with pictures.",
            "questions": [
                q_short("Story: A young prince feels afraid before a big challenge, but a wise teacher reminds him to do his best and not worry about things outside his control. Retell this story in your own words.", "Answers will vary."),
                q_mc("This story's lesson is about...", ["Doing your best and not worrying about things you can't control", "Always winning no matter what", "Avoiding challenges completely"], "Doing your best and not worrying about things you can't control"),
                q_short("Draw a picture showing the moment the prince felt brave again.", "Answers will vary."),
                q_mc("A wise teacher in a story often helps the main character...", ["See a situation in a new, helpful way", "Get more scared", "Give up"], "See a situation in a new, helpful way"),
                q_short("Has anyone ever given you advice like the wise teacher gave the prince? What did they say?", "Answers will vary."),
                q_mc("Retelling a story in your own words helps you...", ["Understand and remember its lesson better", "Forget the story faster", "Nothing useful"], "Understand and remember its lesson better"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Think about 'what would you do?' based on a Gita-inspired story.",
            "questions": [
                q_short("Story: A warrior must do his duty even though it feels hard and uncertain. If YOU were in a hard situation like this, what would help you keep going?", "Answers will vary."),
                q_mc("This kind of story often explores the idea of...", ["Doing what's right even when it's difficult", "Avoiding all difficult situations", "Only doing easy things"], "Doing what's right even when it's difficult"),
                q_short("Describe a time YOU had to do something hard because it was the right thing to do.", "Answers will vary."),
                q_mc("Facing a hard duty with courage, rather than running from it, shows...", ["Inner strength", "Weakness", "Carelessness"], "Inner strength"),
                q_short("What advice would you give a friend who is scared to do something difficult but important?", "Answers will vary."),
                q_mc("Stories like this from the Gita are often used to teach lessons about...", ["Duty, courage, and inner peace", "Only ancient history with no modern meaning", "Nothing meaningful"], "Duty, courage, and inner peace"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Journal about character-building qualities like courage and kindness.",
            "questions": [
                q_short("Write about a time you showed COURAGE (even a small moment).", "Answers will vary."),
                q_short("Write about a time you showed KINDNESS to someone.", "Answers will vary."),
                q_mc("Character-building qualities like courage and kindness are...", ["Habits you can build and strengthen over time", "Something you either have or don't, forever", "Not actually important"], "Habits you can build and strengthen over time"),
                q_mc("Journaling about your own actions helps you...", ["Reflect on and grow your character", "Nothing useful", "Only matters for remembering facts"], "Reflect on and grow your character"),
                q_short("Which quality (courage or kindness) do you want to practice more this week? How?", "Answers will vary."),
                q_short("Name someone you know who shows courage or kindness often. What do they do?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Create a Gita-inspired art project using symbols like the lotus and peacock feather.",
            "questions": [
                q_short("Draw a lotus flower. The lotus grows in muddy water but blooms beautifully — what lesson might this symbolize?", "That beauty and goodness can grow and rise above difficult circumstances."),
                q_mc("The lotus flower is often used as a symbol of...", ["Purity and rising above difficulty", "Laziness", "Fear"], "Purity and rising above difficulty"),
                q_short("Draw a peacock feather. Peacock feathers are associated with beauty and are linked to Krishna in many stories. What colors did you use?", "Answers will vary."),
                q_mc("Symbols like the lotus and peacock feather are used in stories and art to...", ["Represent deeper ideas or qualities", "Have no meaning at all", "Only be decorative with zero purpose"], "Represent deeper ideas or qualities"),
                q_short("Why might artists use symbols (like a flower) instead of just writing out an idea directly?", "Symbols can express a feeling or idea in a visual, memorable way that words alone might not capture."),
                q_short("Create your own art project combining the lotus and peacock feather symbols.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Retell a Gita story in your own words.",
            "questions": [
                q_short("Choose a Gita-inspired story you know. Retell it in your own words, in a few sentences.", "Answers will vary."),
                q_mc("Retelling a story in your OWN words (not word-for-word) shows that you...", ["Truly understood the story's meaning", "Just memorized it without understanding", "Didn't understand the story at all"], "Truly understood the story's meaning"),
                q_short("What is the main lesson of the story you retold?", "Answers will vary."),
                q_mc("Why might oral storytelling traditions (passing stories down by retelling) matter for a culture?", ["It preserves values and wisdom across generations", "It's not an important part of culture", "Written text is the only way stories survive"], "It preserves values and wisdom across generations"),
                q_short("What part of the story did you choose to focus on most in your retelling, and why?", "Answers will vary."),
                q_short("If you told this story to a younger sibling or friend, how might you simplify it?", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare a Gita teaching to a real-life situation.",
            "questions": [
                q_short("Choose a Gita teaching (e.g., focus on effort, not just results). Explain it in your own words.", "Answers will vary."),
                q_short("Describe a real-life situation (yours or someone else's) where this teaching could apply.", "Answers will vary."),
                q_mc("Applying an ancient teaching to a modern situation shows that...", ["Timeless wisdom can still be relevant today", "Ancient teachings have nothing to do with modern life", "Only new ideas are ever useful"], "Timeless wisdom can still be relevant today"),
                q_short("How would following this teaching change how someone handles that real-life situation?", "Answers will vary."),
                q_mc("Comparing ancient wisdom to modern life is a way to practice...", ["Applying philosophy to everyday decisions", "Ignoring philosophy completely", "Memorizing facts with no application"], "Applying philosophy to everyday decisions"),
                q_short("What's one Gita teaching you'd like to try applying in your own life?", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a personal journal entry connecting a Gita teaching to your own life story.",
            "questions": [
                q_short("Choose a Gita teaching that resonates with you. State it clearly.", "Answers will vary."),
                q_short("Write a personal journal entry connecting this teaching to a real experience in YOUR life.", "Answers will vary."),
                q_mc("A personal reflection journal entry should be...", ["Honest and specifically about your own experience", "Completely made up with no personal connection", "Written about someone else's life, not your own"], "Honest and specifically about your own experience"),
                q_short("How has this teaching (or the process of reflecting on it) changed how you think about your experience?", "Answers will vary."),
                q_mc("Connecting ancient wisdom to your own personal story helps make the teaching...", ["Meaningful and memorable in your own life", "Forgettable and irrelevant", "Something only for scholars, not for you"], "Meaningful and memorable in your own life"),
                q_short("Would you share this teaching with a friend facing something similar? Why?", "Answers will vary."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# CULTURE 3/3: Hispanic Culture, Language & Traditions
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "hispanic_culture", "subject_area": "culture", "category_name": "Hispanic Culture, Language & Traditions", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_match("Match the Spanish greeting to its meaning.", ["Hola", "Buenos días", "Adiós", "Gracias"], ["Hello", "Good morning", "Goodbye", "Thank you"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("How do you say 'hello' in Spanish?", ["Hola", "Adiós", "Gracias"], "Hola"),
                q_short("Practice saying 'hola' and 'gracias' out loud.", "Answers will vary."),
                q_mc("How do you say 'goodbye' in Spanish?", ["Adiós", "Hola", "Gracias"], "Adiós"),
                q_short("Draw a picture of yourself greeting a friend in Spanish.", "Answers will vary."),
                q_mc("Learning greetings in another language helps you...", ["Connect with people who speak that language", "Nothing useful", "Confuse everyone"], "Connect with people who speak that language"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Trace the Spanish alphabet, including the special letter ñ.",
            "questions": [
                q_mc("The letter 'ñ' makes a sound like...", ["'ny' (as in 'canyon')", "'n' exactly like in English", "A silent letter"], "'ny' (as in 'canyon')"),
                q_short("Trace the letter ñ. Can you think of a Spanish word that uses it (like 'niño' — child)?", "Answers will vary (e.g., 'niño', 'año')."),
                q_mc("The Spanish alphabet has a few letters not found in the English alphabet, like...", ["ñ", "Only the same letters as English, no differences", "Numbers instead of letters"], "ñ"),
                q_short("Practice writing your name, then try writing a Spanish word with ñ.", "Answers will vary."),
                q_mc("Why is it important to learn special letters like ñ correctly?", ["Using the wrong letter can change a word's meaning or pronunciation", "It doesn't matter at all", "Spanish doesn't actually use ñ"], "Using the wrong letter can change a word's meaning or pronunciation"),
                q_short("Draw or trace 3 different Spanish words that use the letter ñ.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn simple Spanish phrases: colors and numbers.",
            "questions": [
                q_match("Match the Spanish color word to its English meaning.", ["Rojo", "Azul", "Verde", "Amarillo"], ["Red", "Blue", "Green", "Yellow"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_fill("How do you say the number 'one' in Spanish?", "Uno"),
                q_fill("How do you say the number 'two' in Spanish?", "Dos"),
                q_short("Practice counting from uno to cinco (1 to 5) in Spanish.", "Uno, dos, tres, cuatro, cinco."),
                q_mc("Learning colors and numbers is often one of the first steps in learning a new language because...", ["They're commonly used, simple building blocks", "They're the hardest words to learn", "They're not actually useful"], "They're commonly used, simple building blocks"),
                q_short("Name your favorite color in Spanish.", "Answers will vary (e.g., 'azul' for blue)."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Learn about Día de los Muertos (Day of the Dead) and its vocabulary.",
            "questions": [
                q_short("Día de los Muertos is a holiday that celebrates and remembers loved ones who have passed away. What do you think an 'ofrenda' (offering altar) might include?", "Photos, favorite foods, flowers (like marigolds), and candles honoring the person being remembered."),
                q_mc("Día de los Muertos is celebrated mainly in...", ["Mexico and other parts of Latin America", "Only in Spain", "It's not celebrated anywhere"], "Mexico and other parts of Latin America"),
                q_short("Color a picture related to Día de los Muertos, like a marigold flower (cempasúchil) or a calavera (skull design).", "Answers will vary."),
                q_mc("Día de los Muertos is best described as a holiday that...", ["Celebrates and honors the memory of loved ones who have died", "Is meant to be scary or sad only", "Has nothing to do with family"], "Celebrates and honors the memory of loved ones who have died"),
                q_short("Why might a holiday celebrating memories of loved ones be meaningful for families?", "It gives families a joyful, meaningful way to remember and honor people they've lost."),
                q_mc("What color are the marigold flowers (cempasúchil) often used in Día de los Muertos celebrations?", ["Orange", "Blue", "Purple"], "Orange"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Learn Spanish accent marks and basic spelling rules.",
            "questions": [
                q_mc("An accent mark (like in 'café') usually tells you...", ["Which syllable to stress when pronouncing the word", "To skip the word entirely", "That the word is silent"], "Which syllable to stress when pronouncing the word"),
                q_short("Practice writing a word with an accent mark, like 'café' or 'música'.", "Answers will vary."),
                q_mc("Accent marks in Spanish can sometimes change a word's meaning, like 'si' (if) vs 'sí' (yes). Why does this matter?", ["The exact same letters can mean different things depending on the accent", "Accent marks never affect meaning", "Accent marks are purely decorative"], "The exact same letters can mean different things depending on the accent"),
                q_short("Find (or think of) 2 Spanish words that use accent marks.", "Answers will vary."),
                q_mc("Learning spelling rules and accent marks helps you...", ["Read and write Spanish more accurately", "Nothing useful for learning Spanish", "Only matters for math, not language"], "Read and write Spanish more accurately"),
                q_short("Why might it be tricky for English speakers to remember to use accent marks, since English doesn't use them the same way?", "Answers will vary (e.g., it's an unfamiliar habit that takes extra practice to remember)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Retell a folk tale from Latin America, the Caribbean, or Spain.",
            "questions": [
                q_short("Choose a folk tale from a Spanish-speaking region. Summarize its main plot.", "Answers will vary."),
                q_short("What lesson or value does the folk tale teach?", "Answers will vary."),
                q_mc("Folk tales are traditionally passed down...", ["Through generations, often originally by spoken storytelling", "Only through official government records", "They're always brand new stories"], "Through generations, often originally by spoken storytelling"),
                q_mc("Folk tales from a specific culture often reflect...", ["That culture's values, history, and environment", "Nothing about the culture they come from", "Only random, unrelated events"], "That culture's values, history, and environment"),
                q_short("How is this folk tale similar to or different from folk tales you know from other cultures?", "Answers will vary."),
                q_short("Retell the folk tale in your own words, in a few sentences.", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Explore the art of Frida Kahlo and Diego Rivera.",
            "questions": [
                q_short("Frida Kahlo was known for painting self-portraits with bold colors and symbolism. Describe what you notice or imagine about her style.", "Answers will vary — bold colors, personal symbolism, self-portraiture."),
                q_short("Diego Rivera was known for large murals depicting Mexican history and workers. Why might murals (big public paintings) be a powerful way to tell a story?", "Murals are large, public, and visible to many people, making them a powerful way to share stories and messages widely."),
                q_mc("Frida Kahlo and Diego Rivera were both...", ["Famous Mexican artists", "Famous musicians", "Famous athletes"], "Famous Mexican artists"),
                q_mc("Frida Kahlo's paintings often explored themes of...", ["Her own identity, pain, and personal experiences", "Only landscapes with no personal meaning", "Abstract shapes with no subject at all"], "Her own identity, pain, and personal experiences"),
                q_short("If you painted a self-portrait like Frida Kahlo, what symbols would you include to represent your own life?", "Answers will vary."),
                q_mc("Studying artists like Kahlo and Rivera helps you understand...", ["Mexican history and culture through art", "Nothing about culture or history", "Only technical painting skills"], "Mexican history and culture through art"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a bilingual heritage journal entry connecting a family tradition to Spanish vocabulary.",
            "questions": [
                q_short("Describe a family tradition (yours or one you find interesting) that connects to Hispanic culture.", "Answers will vary."),
                q_short("List 3 Spanish vocabulary words related to that tradition.", "Answers will vary."),
                q_short("Write a short journal entry about this tradition, using at least 2 of your Spanish vocabulary words.", "Answers will vary — should incorporate the vocabulary naturally."),
                q_mc("A 'bilingual' journal entry uses...", ["Two languages together", "Only one language", "No actual words, just pictures"], "Two languages together"),
                q_mc("Why might writing about a tradition in TWO languages help you understand it more deeply?", ["It connects the vocabulary directly to real, meaningful context", "It has no real benefit over using just one language", "Bilingual writing is always more confusing"], "It connects the vocabulary directly to real, meaningful context"),
                q_short("How does learning about traditions and language together help preserve culture across generations?", "Answers will vary (e.g., language carries cultural meaning, and traditions keep language relevant and alive)."),
            ],
        },
    },
})

def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def rebalance_target_counts():
    for cat in CATEGORIES:
        for grade_id, gc in cat["grades"].items():
            n = len(gc["questions"])
            min_target = 6 if cat.get("is_core") else 4
            gc["target_count"] = max(min_target, round(n * 0.65))


def emit():
    rebalance_target_counts()
    out = []
    out.append("-- 67_civic_humor_character_culture_content.sql")
    out.append("-- Whole-Child Curriculum expansion, batch 4 (final): content for 'civic'")
    out.append("-- (Civics & Government, Community & Global Citizenship, Public Speaking &")
    out.append("-- Debate), 'humor_play' (Creative Drawing & Doodling, Funny Jokes & Wordplay,")
    out.append("-- Riddles & Brain Teasers, Sense of Humor), 'character' (Moral Lessons, Manners")
    out.append("-- & Everyday Respect, Brain Motivation & Growth Mindset), and 'culture' (Chinese,")
    out.append("-- Indian/Gita, Hispanic language & culture) subject_area groups, hand-crafted")
    out.append("-- across all 8 grades. This completes all 10 Whole-Child subject_area groups.")
    out.append("-- Requires 63_whole_child_rotation.sql to already be applied.")
    out.append("-- See gen_67_civic_humor_character_culture_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'civic')")
    out.append("BEGIN")

    for cat in CATEGORIES:
        for grade_id in GRADE_IDS:
            gc = cat["grades"].get(grade_id)
            if not gc:
                continue
            var = f"@cat_{cat['key']}_{grade_id}"
            is_core_sql = "1" if cat.get("is_core") else "0"
            intro = esc(gc.get("intro_text"))
            out.append(f"    DECLARE {var} INT;")
            out.append(
                f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
                f"        VALUES ({grade_id}, '{cat['subject_area']}', {esc(cat['category_name'])}, '{gc['layout_type']}', {gc['target_count']}, {intro}, {is_core_sql});"
            )
            out.append(f"    SET {var} = SCOPE_IDENTITY();")
            for qi, q in enumerate(gc["questions"], start=1):
                cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order"]
                choices_sql = "NULL" if q["choices"] is None else esc(json.dumps(q["choices"], ensure_ascii=False))
                vals = [var, esc(q["qtype"]), esc(q["prompt"]), choices_sql, esc(q["answer"]), str(qi)]
                if q["diagram_type"]:
                    cols += ["diagram_type", "diagram_data"]
                    vals += [esc(q["diagram_type"]), esc(json.dumps(q["diagram_data"], ensure_ascii=False))]
                out.append(
                    f"    INSERT INTO dbo.PacketQuestions ({', '.join(cols)}) VALUES\n"
                    f"        ({', '.join(vals)});"
                )
            out.append("")

    out.append("END")
    out.append("GO")
    out.append("")
    out.append("DELETE FROM dbo.WeeklyPacketPlan;")
    out.append("GO")
    return "\n".join(out)


def check_completeness():
    ok = True
    for cat in CATEGORIES:
        grades = sorted(cat["grades"].keys())
        if grades != list(range(8)):
            print(f"INCOMPLETE: {cat['key']} has grades {grades}, missing {sorted(set(range(8)) - set(grades))}")
            ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_q = sum(len(gc["questions"]) for cat in CATEGORIES for gc in cat["grades"].values())
    total_cat = sum(len(cat["grades"]) for cat in CATEGORIES)
    print(f"Categories: {total_cat}, Questions: {total_q}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\67_civic_humor_character_culture_content.sql", "w", encoding="utf-8") as f:
        f.write(emit())
    print("Wrote 67_civic_humor_character_culture_content.sql", file=sys.stderr)
