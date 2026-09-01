# -*- coding: utf-8 -*-
"""
Generates lsh.database/64_sel_cognitive_content.sql from structured Python
data below. Mirrors the DECLARE/INSERT/SCOPE_IDENTITY() authoring pattern
used in 53_tk_content.sql etc. Run with: python gen_migration_64.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]  # TK, K, 1st..6th
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# CATEGORIES: ordered list of category dicts.
# Each has: key, subject_area, category_name, is_core (bool), grades: {grade_id: GradeContent}
# GradeContent = {
#   "target_count": int,
#   "layout_type": "short_answer" | "space_heavy",
#   "intro_text": str | None,
#   "questions": [Question, ...]
# }
# Question = dict with keys: qtype, prompt, choices (list|None), answer, diagram_type (None), diagram_data (dict|None)


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
    """pairs: list of (left_index, right_index) correct matches, aligned to left order."""
    choices = {"left": left, "right": right}
    answer = json.dumps(pairs)
    return {"qtype": "matching", "prompt": prompt, "choices": choices, "answer": answer,
            "diagram_type": None, "diagram_data": None}


def q_seq(prompt, steps, answer):
    return {"qtype": "short_response", "prompt": prompt, "choices": None, "answer": answer,
            "diagram_type": "sequence_steps", "diagram_data": {"steps": steps}}


CATEGORIES = []

# ═══════════════════════════════════════════════════════════════════════
# SEL 1/5: Emotional Regulation — is_core=True (mastery anchor, every week)
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "emoreg", "subject_area": "sel", "category_name": "Emotional Regulation", "is_core": True,
    "grades": {
        0: {  # TK
            "target_count": 7, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_fill("What feeling is this?", "Happy", "emoji", {"emoji": "😊"}),
                q_fill("What feeling is this?", "Sad", "emoji", {"emoji": "😢"}),
                q_fill("What feeling is this?", "Angry", "emoji", {"emoji": "😠"}),
                q_fill("What feeling is this?", "Scared", "emoji", {"emoji": "😨"}),
                q_fill("What feeling is this?", "Surprised", "emoji", {"emoji": "😮"}),
                q_fill("What feeling is this?", "Tired", "emoji", {"emoji": "😴"}),
                q_fill("What feeling is this?", "Calm", "emoji", {"emoji": "😌"}),
                q_mc("If you feel angry, what is a safe first step?", ["Take a slow breath", "Yell loudly", "Throw a toy"], "Take a slow breath"),
                q_mc("When you feel sad, what can help?", ["Tell a grown-up I trust", "Keep it a secret", "Hide and don't tell anyone"], "Tell a grown-up I trust"),
                q_mc("You are having a hard day. What is a kind thing to say to yourself?", ["I can try again", "I am bad at everything", "I should give up"], "I can try again"),
                q_short("Draw or tell a grown-up: what makes YOU feel happy?", "Answers will vary."),
                q_short("Draw or tell a grown-up: what makes YOU feel mad?", "Answers will vary."),
                q_seq("Practice slow breathing. Put the steps in order.", ["Breathe in slowly through your nose", "Hold it for 1 second", "Breathe out slowly through your mouth"], "In, hold, out."),
                q_match("Match the feeling word to the matching face.",
                        ["Happy", "Sad", "Angry", "Scared"], ["😊", "😢", "😠", "😨"],
                        [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("What can you do when you feel too excited to sit still?", ["Take slow breaths and count to 5", "Run around the room", "Yell"], "Take slow breaths and count to 5"),
            ],
        },
        1: {  # K
            "target_count": 7, "layout_type": "short_answer",
            "intro_text": "A feelings check-in: circle how you feel right now, then practice a calm-down step.",
            "questions": [
                q_fill("Check in: what feeling is this?", "Frustrated", "emoji", {"emoji": "😖"}),
                q_fill("Check in: what feeling is this?", "Excited", "emoji", {"emoji": "🤩"}),
                q_fill("Check in: what feeling is this?", "Worried", "emoji", {"emoji": "😟"}),
                q_mc("You feel frustrated because your tower fell down. What should you do first?", ["Stop and take 3 slow breaths", "Kick the blocks", "Cry and give up"], "Stop and take 3 slow breaths"),
                q_mc("A friend takes your crayon without asking. How do you feel?", ["Frustrated or upset", "Happy", "Sleepy"], "Frustrated or upset"),
                q_seq("Simple calm-down steps: put them in order.", ["Notice how your body feels", "Take 3 slow breaths", "Ask for help if you still need it"], "Notice, breathe, ask for help."),
                q_short("What is one thing that helps YOU calm down when you're upset?", "Answers will vary (e.g., breathing, a hug, a quiet corner)."),
                q_mc("Which is a calm-down tool?", ["Counting to 10 slowly", "Throwing your toys", "Yelling at a friend"], "Counting to 10 slowly"),
                q_match("Match the situation to how it might feel.",
                        ["Your ice cream falls on the ground", "You get a new puppy", "You can't find your favorite toy"],
                        ["Sad", "Happy", "Worried"], [[0, 0], [1, 1], [2, 2]]),
                q_mc("Why is it okay to feel angry sometimes?", ["All feelings are okay — it's what we DO with them that matters", "Angry feelings are bad and should be hidden", "Only some people are allowed to feel angry"], "All feelings are okay — it's what we DO with them that matters"),
                q_short("Draw a calm-down wheel: name 3 things that help you feel better.", "Answers will vary."),
                q_fill("Check in: what feeling is this?", "Proud", "emoji", {"emoji": "😊"}),
                q_mc("You made a mistake on your worksheet. What's a helpful thought?", ["Mistakes help me learn", "I always mess everything up", "I should quit trying"], "Mistakes help me learn"),
            ],
        },
        2: {  # 1st
            "target_count": 7, "layout_type": "short_answer",
            "intro_text": "Learn to notice what triggers big feelings, and practice the 'stop-breathe-choose' strategy.",
            "questions": [
                q_short("A trigger is something that causes a big feeling. Write one thing that is a trigger for YOU.", "Answers will vary (e.g., losing a game, being interrupted)."),
                q_mc("What is the FIRST step in 'stop-breathe-choose'?", ["Stop what you're doing", "Choose what to do next", "Take a breath"], "Stop what you're doing"),
                q_mc("What is the SECOND step in 'stop-breathe-choose'?", ["Breathe slowly", "Stop", "Choose"], "Breathe slowly"),
                q_seq("Put the 'stop-breathe-choose' strategy steps in order.", ["Stop what you're doing", "Breathe slowly, in and out", "Choose a helpful next step"], "Stop, breathe, choose."),
                q_short("Your friend loses at a game and gets very upset. What could they try?", "Try the stop-breathe-choose strategy, or take a break."),
                q_mc("Which of these is a TRIGGER, not a feeling?", ["Someone cutting in line", "Angry", "Calm"], "Someone cutting in line"),
                q_match("Match the trigger to a helpful response.",
                        ["Losing a game", "Being teased", "Making a mistake"],
                        ["Remind yourself it's okay to lose sometimes", "Walk away and tell a trusted adult", "Remember mistakes help you learn"],
                        [[0, 0], [1, 1], [2, 2]]),
                q_short("Write about a time you felt a big feeling. What was the trigger?", "Answers will vary."),
                q_mc("Why is it helpful to know your own triggers?", ["You can plan ahead for what might upset you", "So you can avoid ever feeling upset", "Triggers aren't important to know"], "You can plan ahead for what might upset you"),
                q_fill("Fill in the blank: When I feel a big feeling coming, I can stop, ______, then choose.", "breathe"),
                q_short("Make your own 'stop-breathe-choose' card for a trigger you picked above.", "Answers will vary."),
            ],
        },
        3: {  # 2nd
            "target_count": 8, "layout_type": "short_answer",
            "intro_text": "Keep an emotion journal entry, then match tricky situations to good coping strategies.",
            "questions": [
                q_short("Emotion journal: What is a feeling you had today or yesterday, and what caused it?", "Answers will vary."),
                q_match("Match each situation to a good coping strategy.",
                        ["You're nervous about a test", "You're angry at your sibling", "You're sad about a rainy day"],
                        ["Take slow breaths and review what you know", "Take space and talk it out calmly later", "Think of an indoor activity you enjoy"],
                        [[0, 0], [1, 1], [2, 2]]),
                q_mc("Which strategy would NOT help you calm down?", ["Yelling until you feel better", "Deep breathing", "Counting slowly to 10"], "Yelling until you feel better"),
                q_short("Write about a strategy that has helped YOU feel calmer in the past.", "Answers will vary."),
                q_mc("What's a healthy way to handle frustration during homework?", ["Take a short break and come back to it", "Rip up the paper", "Give up completely"], "Take a short break and come back to it"),
                q_fill("An ______ journal helps you notice patterns in your feelings over time.", "emotion"),
                q_short("Why might writing down your feelings help you understand them better?", "It helps you notice patterns and think through what caused the feeling."),
                q_match("Match the feeling to a strategy that could help.",
                        ["Overwhelmed by a big project", "Jealous of a friend's new toy", "Embarrassed after a mistake"],
                        ["Break it into smaller steps", "Remind yourself of things you're grateful for", "Remember everyone makes mistakes"],
                        [[0, 0], [1, 1], [2, 2]]),
                q_short("What situation this week caused a strong feeling for you, and how did you handle it?", "Answers will vary."),
            ],
        },
        4: {  # 3rd
            "target_count": 8, "layout_type": "short_answer",
            "intro_text": "Rate how strong a feeling is on a scale of 1-10, then match the intensity to a fitting strategy.",
            "questions": [
                q_short("On a scale of 1-10, how strong does frustration feel when you lose a game you really wanted to win? Explain your number.", "Answers will vary."),
                q_mc("For a LOW-intensity frustration (2-3 out of 10), what's a good strategy?", ["Take a breath and keep going", "Leave the room immediately", "Give up on the activity"], "Take a breath and keep going"),
                q_mc("For a HIGH-intensity frustration (8-10 out of 10), what's a good strategy?", ["Step away, calm down fully, then return", "Push through no matter what", "Ignore it completely"], "Step away, calm down fully, then return"),
                q_match("Match the frustration level to the best-fitting strategy.",
                        ["Level 2: a small mistake on homework", "Level 5: losing a close game", "Level 9: something breaks that you worked hard on"],
                        ["Take one slow breath and keep working", "Talk it out with a friend or take a short break", "Step away completely, breathe, and revisit it later"],
                        [[0, 0], [1, 1], [2, 2]]),
                q_short("Describe a time your frustration scale was high (8+). What strategy did you use, or what could you try next time?", "Answers will vary."),
                q_fill("A frustration ______ helps you notice HOW big a feeling is, not just that you have it.", "scale"),
                q_short("Why might the same event (like losing a game) feel like a 3 for one person and a 9 for another?", "People experience and react to the same events differently — that's normal."),
                q_mc("What's the benefit of rating your frustration before reacting?", ["It helps you choose a strategy that matches how big the feeling really is", "It makes the feeling disappear instantly", "It's not actually useful"], "It helps you choose a strategy that matches how big the feeling really is"),
            ],
        },
        5: {  # 4th
            "target_count": 8, "layout_type": "space_heavy",
            "intro_text": "Reflect on a hard moment you've had recently, then write about what actually helped.",
            "questions": [
                q_short("Describe a hard moment you had recently (at school, home, or with a friend).", "Answers will vary."),
                q_short("What feeling(s) did you have during that hard moment?", "Answers will vary."),
                q_short("What did you do in the moment? Looking back, did it help or not?", "Answers will vary."),
                q_short("What is ONE thing that actually helped you feel better afterward?", "Answers will vary."),
                q_mc("Reflecting on hard moments AFTER they happen mainly helps you...", ["Learn what strategies work for next time", "Forget the moment completely", "Feel worse about it"], "Learn what strategies work for next time"),
                q_short("If a similar hard moment happened again, what would you try differently?", "Answers will vary."),
                q_mc("Which is a sign a reflection is helpful, not just dwelling on the past?", ["It leads to an idea you can use next time", "It makes you replay the moment over and over with no new insight", "It only focuses on blame"], "It leads to an idea you can use next time"),
                q_short("Write a short note to your future self for the next time you have a hard moment.", "Answers will vary."),
            ],
        },
        6: {  # 5th
            "target_count": 8, "layout_type": "short_answer",
            "intro_text": "Compare healthy and unhealthy ways of coping with the same tough feeling.",
            "questions": [
                q_mc("Which pair correctly matches HEALTHY vs UNHEALTHY coping for anger?", ["Healthy: going for a walk. Unhealthy: yelling at others.", "Healthy: yelling at others. Unhealthy: going for a walk.", "Both are equally healthy."], "Healthy: going for a walk. Unhealthy: yelling at others."),
                q_match("Sort each coping response as healthy or unhealthy.",
                        ["Talking to a trusted friend about a problem", "Bottling up feelings until you explode", "Taking a break to cool down", "Blaming others for how you feel without reflecting"],
                        ["Healthy", "Unhealthy", "Healthy", "Unhealthy"],
                        [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_short("Explain why 'venting online' can sometimes be an unhealthy coping strategy.", "It can escalate feelings, hurt others, or create problems that outlast the original feeling."),
                q_short("Describe a healthy coping strategy you personally rely on, and why it works for you.", "Answers will vary."),
                q_mc("Which is true about unhealthy coping strategies?", ["They might feel good briefly but don't solve the real problem", "They always solve the problem permanently", "They have no downsides"], "They might feel good briefly but don't solve the real problem"),
                q_short("Why might the SAME strategy (like eating a snack) be healthy in one situation and unhealthy in another?", "It depends on how often, why, and whether it's used to avoid dealing with the actual feeling."),
                q_mc("A friend copes with stress by avoiding all their homework. Is this healthy?", ["No — avoidance builds up more stress later", "Yes — avoiding stress is always good", "It doesn't matter either way"], "No — avoidance builds up more stress later"),
                q_short("Write one unhealthy habit you want to replace with a healthier one, and what you'll try instead.", "Answers will vary."),
            ],
        },
        7: {  # 6th
            "target_count": 8, "layout_type": "space_heavy",
            "intro_text": "Design your own personal 'calm-down toolkit' — a real plan you could actually use.",
            "questions": [
                q_short("List 3 strategies for your personal calm-down toolkit, and why you picked each one.", "Answers will vary."),
                q_seq("Put a realistic calm-down plan in order for when you notice a big feeling starting.", ["Notice the early signs (racing heart, tight chest, etc.)", "Use your first go-to strategy (e.g., breathing)", "Check in: do you need a second strategy or more time?", "Return to what you were doing, or ask for help if still needed"], "Notice, use a strategy, check in, return or ask for help."),
                q_short("What are the early warning signs YOUR body gives before a big feeling takes over?", "Answers will vary (e.g., clenched fists, fast breathing, hot face)."),
                q_mc("A good calm-down toolkit should be...", ["Personalized to what actually works for you", "The exact same as everyone else's", "Used only after you've already lost control"], "Personalized to what actually works for you"),
                q_short("Who is one trusted person you could go to if your toolkit strategies aren't enough?", "Answers will vary."),
                q_mc("Why is it useful to practice your calm-down toolkit BEFORE you're upset, not just during?", ["Strategies work better when they're already familiar under stress", "Practicing ahead of time is pointless", "It only matters once you're already upset"], "Strategies work better when they're already familiar under stress"),
                q_short("How will you know if a strategy in your toolkit is actually working for you?", "Answers will vary (e.g., feeling calmer within a few minutes, being able to think clearly again)."),
                q_short("Write your finished calm-down toolkit plan as a short list you could keep in your backpack or notebook.", "Answers will vary."),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# SEL 2/5: Empathy
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "empathy", "subject_area": "sel", "category_name": "Empathy", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_match("Match the face to the feeling.", ["Happy", "Sad", "Angry", "Scared"], ["😊", "😢", "😠", "😨"], [[0, 0], [1, 1], [2, 2], [3, 3]]),
                q_mc("Your friend is crying. How do they probably feel?", ["Sad", "Happy", "Silly"], "Sad"),
                q_mc("Your friend just won a game. How do they probably feel?", ["Happy", "Sad", "Scared"], "Happy"),
                q_short("If your friend feels sad, what could you do to help?", "Answers will vary (e.g., give a hug, ask what's wrong, share a toy)."),
                q_fill("What feeling is this friend showing?", "Scared", "emoji", {"emoji": "😨"}),
                q_mc("A friend drops their ice cream. How might they feel?", ["Sad", "Excited", "Proud"], "Sad"),
                q_short("Draw a face showing how YOU think your best friend feels today.", "Answers will vary."),
                q_mc("Noticing how someone else feels is called...", ["Empathy", "Counting", "Running"], "Empathy"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Look at the picture story, then think about how each character feels.",
            "questions": [
                q_short("A kid drops their lunch tray in the cafeteria and everyone looks. How would they feel?", "Embarrassed or sad."),
                q_short("What could you say to that kid to help them feel better?", "Answers will vary (e.g., 'It's okay, that happens to everyone!')."),
                q_mc("A new student doesn't know anyone at recess. How might they feel?", ["Lonely or nervous", "Excited", "Bored"], "Lonely or nervous"),
                q_short("What could you do if you saw a new student sitting alone?", "Answers will vary (e.g., invite them to play)."),
                q_match("Match the story picture to the likely feeling.",
                        ["A kid gets a surprise birthday party", "A kid's pet is sick", "A kid can't solve a hard puzzle"],
                        ["Happy and surprised", "Worried", "Frustrated"], [[0, 0], [1, 1], [2, 2]]),
                q_short("How would YOU feel if you were the new student with no one to sit with?", "Answers will vary."),
                q_mc("Why is it important to think about how a picture-story character feels?", ["It helps us understand and be kind to others", "It's not important", "Only for fun, no real reason"], "It helps us understand and be kind to others"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read the short story, then retell it from a DIFFERENT character's point of view.",
            "questions": [
                q_short("Story: Mia borrows Jake's pencil without asking and breaks it. Retell this from JAKE's point of view — how does he feel and why?", "Answers will vary (e.g., frustrated, since his pencil was taken without permission and broken)."),
                q_short("Now retell it from MIA's point of view. What might she have been thinking?", "Answers will vary (e.g., she was in a rush and didn't mean to break it)."),
                q_mc("Perspective-taking means...", ["Imagining a situation from someone else's point of view", "Only thinking about your own feelings", "Guessing without any thought"], "Imagining a situation from someone else's point of view"),
                q_short("Why might Mia and Jake see the same event differently?", "They each experienced it from their own point of view with different feelings and intentions."),
                q_short("What could Mia say to Jake to make things better?", "Answers will vary (e.g., 'I'm sorry, I should have asked first.')."),
                q_mc("Retelling a story from another character's view mainly helps you...", ["Understand feelings and reasons you might have missed", "Change what actually happened in the story", "Prove your own view is the only correct one"], "Understand feelings and reasons you might have missed"),
                q_short("Think of a real disagreement you had. Retell it from the OTHER person's point of view.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read the scenario, then write how each person in it probably feels.",
            "questions": [
                q_short("Scenario: Two friends are picked for different teams in gym class and won't be playing together. Write how EACH friend might feel.", "Answers will vary (e.g., disappointed, but maybe also excited to make new teammates)."),
                q_short("Scenario: A student studies hard but still gets a lower grade than a friend who didn't study much. Write how the student feels, and how the friend might feel too.", "Answers will vary."),
                q_mc("Why might two people feel differently about the exact same event?", ["Everyone brings their own experiences and expectations to a situation", "Only one person's feelings are ever 'correct'", "People always feel the same about everything"], "Everyone brings their own experiences and expectations to a situation"),
                q_short("Scenario: A sibling is upset because they have to share their new video game. Write how they might feel, and one thing that could help.", "Answers will vary."),
                q_short("Why is it useful to consider more than one person's feelings in a scenario?", "It helps you respond fairly and kindly to everyone involved, not just yourself."),
                q_mc("What's the best next step after writing how someone feels in a scenario?", ["Think about how you could respond kindly", "Ignore it and move on", "Decide their feelings don't matter"], "Think about how you could respond kindly"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare your own reaction to an event with how a friend reacted to the SAME event.",
            "questions": [
                q_short("Think of a time you and a friend both experienced the same event (a scary movie, a lost game, a surprise). Write how YOU reacted.", "Answers will vary."),
                q_short("Now write how your FRIEND reacted to that same event, as best you remember or can imagine.", "Answers will vary."),
                q_short("What might explain the difference between your reaction and theirs?", "Different personalities, past experiences, or what each of you cares about most."),
                q_mc("If your reaction and a friend's reaction to the same event were very different, that means...", ["Both reactions can be valid, just different", "One of you must be wrong", "You aren't really friends"], "Both reactions can be valid, just different"),
                q_short("How could understanding a friend's different reaction change how you treat them next time?", "Answers will vary (e.g., being more patient or supportive of their specific reaction)."),
                q_mc("Comparing reactions to the SAME event is a good way to practice...", ["Empathy — understanding others don't always feel what you feel", "Memorization", "Arguing about who's right"], "Empathy — understanding others don't always feel what you feel"),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Analyze what really motivates a character's actions in a story you've read.",
            "questions": [
                q_short("Pick a character from a book you've read. What did they WANT, and what did they DO to try to get it?", "Answers will vary."),
                q_short("Was the character's motivation something like fear, love, pride, or fairness? Explain.", "Answers will vary."),
                q_mc("A character's motivation is best described as...", ["The reason behind their actions", "Only their physical appearance", "A random detail with no meaning"], "The reason behind their actions"),
                q_short("Did the character's motivation change by the end of the story? Explain how or why not.", "Answers will vary."),
                q_short("If you were in that character's exact situation, would you have been motivated by the same thing? Why or why not?", "Answers will vary."),
                q_mc("Understanding a character's motivation mostly helps a reader...", ["Understand WHY they act the way they do, not just WHAT they do", "Skip parts of the book", "Predict the page count"], "Understand WHY they act the way they do, not just WHAT they do"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a short letter of support to a character in a story who is going through something hard.",
            "questions": [
                q_short("Pick a struggling character from a book, show, or story. What are they struggling with?", "Answers will vary."),
                q_short("Write a short letter TO that character, showing you understand their feelings and offering encouragement.", "Answers will vary — should reflect genuine empathy for the character's situation."),
                q_mc("A good letter of support should mainly...", ["Acknowledge their feelings before offering encouragement", "Tell them their feelings are wrong", "Only talk about your own experiences"], "Acknowledge their feelings before offering encouragement"),
                q_short("What is one specific detail from the story that shows how the character feels?", "Answers will vary."),
                q_short("How might writing a letter like this help YOU understand the character (or a real person going through something similar) better?", "Answers will vary."),
                q_mc("Which sentence best shows empathy in a letter?", ["'That sounds really hard — I understand why you feel that way.'", "'You should just get over it.'", "'That's not a big deal at all.'"], "'That sounds really hard — I understand why you feel that way.'"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Identify a real, unmet need in your community and think through how you could respond.",
            "questions": [
                q_short("Think of your school or neighborhood. Name one need that isn't being fully met (e.g., a lonely classmate, a littered park, kids without school supplies).", "Answers will vary."),
                q_short("Who is affected by this need, and how might it make them feel?", "Answers will vary."),
                q_short("Write one realistic action you (or a group of kids) could take to help address this need.", "Answers will vary."),
                q_mc("Identifying a community need starts with...", ["Noticing and listening to what's actually missing for people", "Assuming you already know everyone's needs", "Ignoring problems that don't affect you directly"], "Noticing and listening to what's actually missing for people"),
                q_short("Why might an adult and a kid notice DIFFERENT unmet needs in the same community?", "They have different daily experiences and perspectives, so they notice different things."),
                q_mc("Responding to a community need with empathy means...", ["Understanding how it affects people before deciding how to help", "Helping in whatever way is fastest for you, regardless of the need", "Waiting for someone else to notice it first"], "Understanding how it affects people before deciding how to help"),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# SEL 3/5: Conflict Resolution
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "conflict", "subject_area": "sel", "category_name": "Conflict Resolution", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Two friends want the same toy. What should they do?", ["Use their words and take turns", "Grab it and run", "Yell at each other"], "Use their words and take turns"),
                q_short("What are kind words you could say if someone takes your toy?", "Answers will vary (e.g., 'Can I have a turn please?')."),
                q_mc("If you're upset with a friend, what's a good first step?", ["Tell them how you feel using words", "Hit them", "Ignore them forever"], "Tell them how you feel using words"),
                q_fill("Instead of grabbing, I can say: 'Can I have a ______, please?'", "turn"),
                q_short("Draw or tell: two friends both want to be first in line. What could they do?", "Answers will vary (e.g., take turns, do rock-paper-scissors)."),
                q_mc("Which words are 'use your words' words?", ["'Can we share?'", "'That's mine, go away!'", "(silence, then grabbing)"], "'Can we share?'"),
                q_short("Why is using your words better than grabbing or yelling?", "It helps solve the problem without hurting anyone's feelings."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Fill in the 'I feel... because...' sentence starter for each situation.",
            "questions": [
                q_fill("A friend cuts in front of you in line. Complete: 'I feel ______ because they cut in line.'", "frustrated (or upset)"),
                q_fill("A friend won't share the blocks. Complete: 'I feel sad because I want a ______ too.'", "turn"),
                q_short("Write your own 'I feel... because...' sentence about a time someone upset you.", "Answers will vary."),
                q_mc("Why do we say 'I feel...' instead of 'You always...'?", ["It explains your feeling without blaming the other person", "It sounds nicer but means the same thing", "It doesn't matter which one you use"], "It explains your feeling without blaming the other person"),
                q_short("If a friend says 'I feel left out because you didn't ask me to play,' what could you say back?", "Answers will vary (e.g., 'I'm sorry, do you want to play now?')."),
                q_mc("An 'I feel... because...' sentence helps the OTHER person...", ["Understand your feelings instead of just getting blamed", "Know exactly what toy you want", "Guess what happened without being told"], "Understand your feelings instead of just getting blamed"),
                q_short("Practice: write an 'I feel... because...' sentence for feeling happy about something a friend did.", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Role-play script: two kids, Sam and Ali, both want to play with the same toy truck.",
            "questions": [
                q_short("Write what SAM could say to start solving the problem fairly.", "Answers will vary (e.g., 'Let's take turns — you go first, then me.')."),
                q_short("Write what ALI could say back.", "Answers will vary (e.g., 'Okay, that sounds fair.')."),
                q_mc("What is a FAIR solution to the toy truck problem?", ["Taking turns with a timer", "Sam keeps it all day", "Ali grabs it and runs away"], "Taking turns with a timer"),
                q_short("Act out (or write) the ending of the script where Sam and Ali agree on a solution.", "Answers will vary."),
                q_mc("Why is role-playing a conflict helpful before it actually happens?", ["It lets you practice fair, calm solutions ahead of time", "It's just for fun, not useful", "It guarantees you'll never disagree again"], "It lets you practice fair, calm solutions ahead of time"),
                q_short("What could Sam and Ali's teacher say to help if they can't agree?", "Answers will vary (e.g., suggest a timer or a coin flip)."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read the conflict scenario, then brainstorm THREE different fair solutions.",
            "questions": [
                q_short("Scenario: Two students both want to be team captain for the class game. Brainstorm solution #1.", "Answers will vary (e.g., vote as a class)."),
                q_short("Brainstorm solution #2 for the same scenario.", "Answers will vary (e.g., take turns being captain each week)."),
                q_short("Brainstorm solution #3 for the same scenario.", "Answers will vary (e.g., co-captains, splitting responsibilities)."),
                q_mc("Why brainstorm THREE solutions instead of just picking the first idea?", ["More options usually means a fairer solution for everyone", "The first idea is always wrong", "It's required by the rules of brainstorming"], "More options usually means a fairer solution for everyone"),
                q_short("Which of your three solutions do you think is fairest, and why?", "Answers will vary."),
                q_mc("A 'fair' solution to a conflict usually means...", ["Both sides feel reasonably okay with the outcome", "One side gets everything they want", "No one has to compromise at all"], "Both sides feel reasonably okay with the outcome"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Sort each conflict outcome as WIN-WIN or WIN-LOSE.",
            "questions": [
                q_match("Sort each outcome.",
                        ["Two kids split the last snack evenly", "One kid gets the whole prize, the other gets nothing", "Two friends take turns choosing the game each day", "One friend always picks the movie, the other never gets a say"],
                        ["Win-win", "Win-lose", "Win-win", "Win-lose"],
                        [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_short("Rewrite a win-lose outcome from above into a win-win outcome.", "Answers will vary."),
                q_mc("A win-win solution to a conflict means...", ["Both people come away feeling reasonably satisfied", "One person 'wins' the argument", "Neither person gets anything they wanted"], "Both people come away feeling reasonably satisfied"),
                q_short("Describe a real conflict you've had that ended win-lose. How could it have gone win-win instead?", "Answers will vary."),
                q_mc("Why do win-lose solutions often cause MORE conflict later?", ["The 'losing' side often still feels upset or resentful", "They always solve the problem completely", "They're actually the fairest kind of solution"], "The 'losing' side often still feels upset or resentful"),
                q_short("What's one question you could ask during a disagreement to help find a win-win solution?", "Answers will vary (e.g., 'What would make this feel fair to both of us?')."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Practice the mediation steps: listen, restate, solve.",
            "questions": [
                q_seq("Put the mediation steps in the correct order.", ["Listen fully to both sides without interrupting", "Restate what each person said, in your own words", "Work together to find a solution both sides agree to"], "Listen, restate, solve."),
                q_short("Why is 'restating what each person said' an important step, not just extra work?", "It shows both people they were really heard, and helps clear up misunderstandings."),
                q_mc("During mediation, the mediator's job is to...", ["Help both sides communicate and reach a fair solution, not pick a winner", "Decide who is right and who is wrong", "Ignore one side's feelings to save time"], "Help both sides communicate and reach a fair solution, not pick a winner"),
                q_short("Practice: write a 'restatement' sentence a mediator might say after hearing someone's side.", "Answers will vary (e.g., 'So what I hear you saying is...')."),
                q_short("Describe a conflict at school where following these mediation steps could have helped.", "Answers will vary."),
                q_mc("Why is 'listen fully without interrupting' the FIRST step, not the last?", ["You can't fairly help solve a conflict you don't fully understand yet", "Listening isn't actually necessary for mediation", "It's just a formality with no real purpose"], "You can't fairly help solve a conflict you don't fully understand yet"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Analyze a real-world conflict (news, history, or community) and propose a compromise.",
            "questions": [
                q_short("Describe a real-world conflict you've heard about (between two groups, countries, or people). What do both sides want?", "Answers will vary."),
                q_short("Propose ONE realistic compromise that could address both sides' main concerns.", "Answers will vary."),
                q_mc("A realistic compromise usually means...", ["Both sides give up something to gain something else", "One side gets everything it originally wanted", "The conflict is simply ignored"], "Both sides give up something to gain something else"),
                q_short("What makes some real-world conflicts harder to compromise on than a disagreement between two kids over a toy?", "Answers will vary (e.g., higher stakes, long history, many people affected, deeply held values)."),
                q_short("Who would need to agree to your proposed compromise for it to actually work?", "Answers will vary."),
                q_mc("Why is it useful to practice analyzing real-world conflicts, even ones you can't personally solve?", ["It builds skill in seeing multiple perspectives fairly", "It has no real value", "It's only useful for adults, not students"], "It builds skill in seeing multiple perspectives fairly"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write and act out a structured peer-mediator script for a realistic school conflict.",
            "questions": [
                q_short("Write an opening line a peer mediator could use to start a session fairly for both sides.", "Answers will vary (e.g., 'Thanks for being willing to talk this out. Each of you will get a turn to share.')."),
                q_short("Write a line the mediator could use to make sure both sides feel heard before jumping to solutions.", "Answers will vary."),
                q_seq("Put a full peer-mediation script structure in order.", ["Set ground rules (respect, no interrupting)", "Each side shares their perspective", "Mediator restates each side's main point", "Brainstorm possible solutions together", "Agree on one solution and next steps"], "Ground rules, share, restate, brainstorm, agree."),
                q_short("Write a closing line that confirms both sides agree to the solution.", "Answers will vary."),
                q_mc("A peer mediator should remain...", ["Neutral — not taking either side's position", "On the side of whoever is more upset", "In charge of deciding who is right"], "Neutral — not taking either side's position"),
                q_short("What's one skill a peer mediator needs that you think is hardest to practice, and why?", "Answers will vary."),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# SEL 4/5: Collaboration
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "collab", "subject_area": "sel", "category_name": "Collaboration", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("A group mural means everyone...", ["Adds their own part to make one picture together", "Draws on their own separate paper", "Only one person draws, others watch"], "Adds their own part to make one picture together"),
                q_short("What part would YOU like to add to a group mural about your class?", "Answers will vary."),
                q_mc("If a friend wants to add something where you're drawing, what should you do?", ["Make room and share the space", "Tell them to go away", "Cover up their part"], "Make room and share the space"),
                q_short("Why is working together on one big picture fun?", "Answers will vary (e.g., everyone's ideas combine into something bigger)."),
                q_mc("Working together with others to make something is called...", ["Collaboration", "Racing", "Napping"], "Collaboration"),
                q_short("Name one friend you would like to make a group picture with, and why.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Partner puzzle: each partner has half the pieces — you must work together to finish it.",
            "questions": [
                q_mc("If your partner has a piece you need, what should you say?", ["'Can I have that piece, please?'", "Grab it without asking", "Do the puzzle alone instead"], "'Can I have that piece, please?'"),
                q_short("Why does a partner puzzle only work if BOTH people help?", "Each person only has some of the pieces, so it takes both to finish."),
                q_short("What could you say to encourage your partner if the puzzle is tricky?", "Answers will vary (e.g., 'You can do it, let's try together!')."),
                q_mc("If you finish your half first, what's a good next step?", ["Offer to help your partner with their half", "Walk away", "Tell them they're too slow"], "Offer to help your partner with their half"),
                q_short("How did it feel to finish the puzzle together compared to doing one alone?", "Answers will vary."),
                q_mc("A partner puzzle teaches you that working together can be...", ["Faster and more fun than working alone", "Always harder than working alone", "Not necessary at all"], "Faster and more fun than working alone"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Team scavenger hunt: plan how your team will find all the items together.",
            "questions": [
                q_short("Your team has 5 items to find and 3 people. How will you divide the work fairly?", "Answers will vary (e.g., split the list into sections each person searches)."),
                q_short("What should your team do if one person finds an item — should they keep looking alone or tell the team?", "Tell the team right away so everyone knows what's left to find."),
                q_mc("Scavenger hunts work best in teams because...", ["More people searching means finding items faster together", "One person should always do all the work", "Teams always find fewer items than one person"], "More people searching means finding items faster together"),
                q_short("What would you do if a teammate couldn't find their assigned items?", "Answers will vary (e.g., help them search once you finish your own)."),
                q_short("Name one strength each of your teammates might bring to a scavenger hunt (fast runner, good at spotting details, etc.).", "Answers will vary."),
                q_mc("What's most important for a team scavenger hunt to succeed?", ["Communicating about what's been found and what's left", "Racing each other instead of the clock", "Working completely silently"], "Communicating about what's been found and what's left"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan a group project: write down each team member's role.",
            "questions": [
                q_short("List 3 roles a group project might need (e.g., researcher, writer, presenter).", "Answers will vary."),
                q_short("Why does assigning specific roles help a group work better than 'everyone does everything'?", "It avoids confusion and duplicate work, and lets people focus on one task well."),
                q_mc("If a role isn't getting done, the BEST first step is to...", ["Talk to that team member and offer to help", "Do it yourself without saying anything", "Complain to someone outside the group"], "Talk to that team member and offer to help"),
                q_short("Which role would you personally want on a group project, and why?", "Answers will vary."),
                q_short("What's one way your group could check in on progress partway through the project?", "Answers will vary (e.g., a quick team meeting halfway through)."),
                q_mc("A group project planning sheet is most useful for...", ["Making sure everyone knows what they're responsible for", "Deciding who gets the best grade", "Skipping the need to actually talk to teammates"], "Making sure everyone knows what they're responsible for"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Divide a team challenge's tasks based on each person's strengths.",
            "questions": [
                q_short("List 3 teammates (real or made up) and one strength each of them has.", "Answers will vary."),
                q_short("Match each strength to a task in your team challenge that would use it well.", "Answers will vary."),
                q_mc("Dividing tasks by strength usually leads to...", ["Better results, since people work on what they're good at", "Worse results than random assignment", "No difference at all"], "Better results, since people work on what they're good at"),
                q_short("What should a team do if two people both want the same strong-suit task?", "Answers will vary (e.g., split the task, or take turns leading different parts)."),
                q_mc("What should happen if no one on the team is confident about a needed task?", ["The team can learn it together or ask for help", "Skip that part of the project entirely", "One person should be forced to do it alone"], "The team can learn it together or ask for help"),
                q_short("Why is it valuable to know your OWN strengths before joining a team challenge?", "Answers will vary (e.g., you can offer to take on tasks that fit you well)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan a group research project with clearly assigned roles.",
            "questions": [
                q_short("Choose a research topic and list 4 roles needed (e.g., researcher, note-taker, designer, presenter).", "Answers will vary."),
                q_short("Write one specific responsibility for each of the 4 roles.", "Answers will vary."),
                q_mc("A group research project usually fails when...", ["Roles and expectations were never made clear", "Everyone has a clearly assigned role", "The group meets regularly to check progress"], "Roles and expectations were never made clear"),
                q_short("How would your group handle it if new information changed your original plan halfway through?", "Answers will vary (e.g., regroup and adjust roles/timeline as needed)."),
                q_short("What is one way to make sure quieter group members' ideas get heard?", "Answers will vary (e.g., go around and ask each person directly)."),
                q_mc("Assigning roles at the START of a group project mainly helps by...", ["Preventing confusion and duplicated effort later on", "Making the project take longer", "Guaranteeing no disagreements will ever happen"], "Preventing confusion and duplicated effort later on"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Prep for a team debate: divide responsibilities across your team.",
            "questions": [
                q_short("List the responsibilities a debate team needs (e.g., researcher, opening speaker, rebuttal writer, closing speaker).", "Answers will vary."),
                q_short("Assign each responsibility to a (real or made-up) teammate, matching their strengths.", "Answers will vary."),
                q_mc("Why should a debate team divide research AND speaking roles ahead of time?", ["So each person can prepare deeply instead of scrambling last-minute", "Because only one person is allowed to talk", "It doesn't actually matter for a debate"], "So each person can prepare deeply instead of scrambling last-minute"),
                q_short("What should your team do if the opposing side brings up a point you didn't prepare for?", "Answers will vary (e.g., have a team member ready to think on their feet, or regroup briefly)."),
                q_short("How would your team make sure everyone's prep work fits together into one consistent argument?", "Answers will vary (e.g., a team meeting to review everyone's parts together)."),
                q_mc("Good debate-team collaboration mainly shows up as...", ["A consistent, well-supported argument built from everyone's prep", "Everyone arguing a different, unrelated point", "One person doing all the talking with no team input"], "A consistent, well-supported argument built from everyone's prep"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a capstone group project charter: goals, roles, and a timeline.",
            "questions": [
                q_short("Write one clear GOAL statement for a group capstone project of your choice.", "Answers will vary."),
                q_short("List each team member's ROLE and main responsibility.", "Answers will vary."),
                q_short("Sketch a rough TIMELINE with at least 3 milestones and target dates.", "Answers will vary."),
                q_mc("A project charter is mainly useful because it...", ["Gets everyone aligned on goals, roles, and deadlines before work starts", "Is a legal document with no practical use", "Replaces the need for the team to ever communicate again"], "Gets everyone aligned on goals, roles, and deadlines before work starts"),
                q_short("What should your team do if you fall behind one of your charter's milestones?", "Answers will vary (e.g., reassess the timeline together and adjust)."),
                q_mc("Which is the best sign a capstone team is collaborating well?", ["Team members check in, adjust plans together, and support each other", "One person does all the work while others watch", "The charter is written but never referenced again"], "Team members check in, adjust plans together, and support each other"),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# SEL 5/5: Active Listening
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "listen", "subject_area": "sel", "category_name": "Active Listening", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("In Simon Says, when do you follow the direction?", ["Only when 'Simon says' is used", "Every single time", "Never"], "Only when 'Simon says' is used"),
                q_mc("What do good listeners do with their eyes and ears?", ["Look at the speaker and listen closely", "Look away and talk to a friend", "Cover their ears"], "Look at the speaker and listen closely"),
                q_short("Why is it hard to follow directions if you're not listening carefully?", "You might miss an important part of what to do."),
                q_mc("If you're not sure what to do, what's a good thing to say?", ["'Can you say that again, please?'", "Nothing, just guess", "Walk away"], "'Can you say that again, please?'"),
                q_short("Play a mini Simon Says with a grown-up. Write one direction they gave you.", "Answers will vary."),
                q_mc("Good listening helps you...", ["Follow directions correctly", "Finish faster by guessing", "Ignore the speaker"], "Follow directions correctly"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Listen to a grown-up give oral instructions, then draw what you heard.",
            "questions": [
                q_short("Ask a grown-up to describe a simple picture out loud (like 'draw a big yellow sun with 5 rays'). Draw or describe what you drew.", "Answers will vary."),
                q_mc("Why might your drawing look different from what the grown-up imagined?", ["You might have missed or misheard a detail", "Drawing is always wrong", "Listening doesn't matter for drawing"], "You might have missed or misheard a detail"),
                q_short("What could you ask if you weren't sure about a detail while listening?", "Answers will vary (e.g., 'How many rays should the sun have?')."),
                q_mc("Drawing what you heard is a good listening practice because...", ["It shows exactly what details you did or didn't catch", "Drawing has nothing to do with listening", "It's only about art skill"], "It shows exactly what details you did or didn't catch"),
                q_short("Try describing a simple picture out loud to a grown-up and see what they draw. What did they get right or miss?", "Answers will vary."),
                q_short("What's one way to listen even more carefully next time?", "Answers will vary (e.g., look at the speaker, don't interrupt, ask questions)."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Follow 3-step oral directions exactly as given.",
            "questions": [
                q_short("A grown-up says: 'Touch your nose, clap twice, then say your name.' Do it, then write the 3 steps in order.", "Touch nose, clap twice, say your name."),
                q_mc("What's the risk of only remembering step 1 and step 3 of a 3-step direction?", ["You'll miss doing step 2 correctly", "Nothing changes, it's fine to skip steps", "The direction only needed 2 steps anyway"], "You'll miss doing step 2 correctly"),
                q_short("What's a good strategy to remember all 3 steps of an oral direction?", "Answers will vary (e.g., repeat it silently, count on fingers)."),
                q_mc("If you forget the steps partway through, what should you do?", ["Ask for the directions to be repeated", "Guess and hope it's right", "Give up"], "Ask for the directions to be repeated"),
                q_short("Make up your own 3-step direction and give it to a family member. Did they follow all 3 steps?", "Answers will vary."),
                q_mc("Following multi-step directions accurately is an important skill because...", ["Many real tasks (school, chores, games) need several steps done in order", "Only 1-step directions matter in real life", "Steps never need to happen in a specific order"], "Many real tasks (school, chores, games) need several steps done in order"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Interview a partner and record their answers carefully.",
            "questions": [
                q_short("Ask a partner: 'What's your favorite thing to do after school?' Write their answer in their own words.", "Answers will vary."),
                q_short("Ask a partner: 'What's something you're proud of?' Write their answer.", "Answers will vary."),
                q_mc("When recording someone's answer, you should try to...", ["Use their actual words as closely as possible", "Change their answer to something you like better", "Only write down part of what they said"], "Use their actual words as closely as possible"),
                q_short("What could you do if a partner's answer was hard to understand?", "Answers will vary (e.g., politely ask them to explain more)."),
                q_short("Why might it be tempting to think about your OWN answer instead of really listening to your partner's?", "Answers will vary (e.g., you're excited to share your own thoughts) — good listeners resist this."),
                q_mc("A partner interview mainly practices...", ["Listening closely enough to accurately record someone else's words", "Talking as much as possible yourself", "Guessing what the other person will say"], "Listening closely enough to accurately record someone else's words"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Summarize a partner's story in your own words after listening carefully.",
            "questions": [
                q_short("Ask a partner to tell you a short story about their weekend. Summarize it in 2-3 sentences, in YOUR OWN words.", "Answers will vary."),
                q_mc("A good summary should...", ["Capture the main points without copying every word", "Include every single word they said", "Change the meaning of what they said"], "Capture the main points without copying every word"),
                q_short("What part of your partner's story was easiest to remember? Hardest?", "Answers will vary."),
                q_mc("Why is summarizing in your OWN words a better listening check than repeating word-for-word?", ["It proves you actually understood the meaning, not just memorized sounds", "It's exactly the same as repeating word-for-word", "Understanding doesn't matter, only memorization"], "It proves you actually understood the meaning, not just memorized sounds"),
                q_short("Check your summary with your partner — did you capture their story correctly? What did you miss, if anything?", "Answers will vary."),
                q_short("What listening strategy helped you remember the story's main points?", "Answers will vary (e.g., focusing on beginning-middle-end)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Take notes while listening to a short passage read aloud.",
            "questions": [
                q_short("Have someone read a short paragraph aloud to you. Write down 3 key points as notes while listening.", "Answers will vary."),
                q_mc("Good notes while listening should be...", ["Short key words and phrases, not full sentences", "A word-for-word transcript of everything said", "Written only after the passage is completely finished"], "Short key words and phrases, not full sentences"),
                q_short("Compare your notes to the original passage. What did you capture well? What did you miss?", "Answers will vary."),
                q_mc("Why is note-taking WHILE listening harder than note-taking while reading?", ["You can't pause or reread — you have to catch it the first time", "Listening is always easier than reading", "There's no real difference between the two"], "You can't pause or reread — you have to catch it the first time"),
                q_short("What's one strategy that could help you take better notes while listening (abbreviations, symbols, etc.)?", "Answers will vary."),
                q_short("Why might note-taking skills from listening help you in a real classroom lecture?", "Answers will vary (e.g., helps you study later, catch important details)."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Listen to (or read a transcript of) a debate, then summarize BOTH sides fairly.",
            "questions": [
                q_short("Pick a simple debate topic (e.g., 'should school start later?'). Summarize the FOR side's strongest point.", "Answers will vary."),
                q_short("Summarize the AGAINST side's strongest point.", "Answers will vary."),
                q_mc("Summarizing BOTH sides fairly means...", ["Representing each side's argument accurately, even the one you disagree with", "Only summarizing the side you personally agree with", "Making one side sound worse than it actually is"], "Representing each side's argument accurately, even the one you disagree with"),
                q_short("Which side's point did you find more convincing, and why? (Try to explain fairly, not dismiss the other side.)", "Answers will vary."),
                q_mc("Why is fair summarizing an important listening skill in real debates or discussions?", ["It shows you actually understood the disagreement, not just picked a side", "It's not actually necessary — only your own opinion matters", "It means you have to agree with both sides equally"], "It shows you actually understood the disagreement, not just picked a side"),
                q_short("What listening habit helps you stay fair to a side you personally disagree with?", "Answers will vary (e.g., focusing on their reasoning, not your own reaction)."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Interview someone with a different perspective from yours, then write a short report.",
            "questions": [
                q_short("Interview someone (a family member, classmate, or neighbor) about a topic where their perspective might differ from yours. What did you ask?", "Answers will vary."),
                q_short("Write a short report summarizing their perspective, in their own words as closely as possible.", "Answers will vary."),
                q_mc("A good interviewer mainly...", ["Listens more than they talk, and asks follow-up questions", "Talks about their own opinion the whole time", "Only asks questions they already know the answer to"], "Listens more than they talk, and asks follow-up questions"),
                q_short("What surprised you most about their perspective?", "Answers will vary."),
                q_mc("Writing a fair report on someone's perspective means...", ["Representing their views accurately, even if you disagree", "Rewriting their views to match your own opinion", "Leaving out any parts you don't personally like"], "Representing their views accurately, even if you disagree"),
                q_short("How did really listening (instead of just waiting to talk) change what you learned from the interview?", "Answers will vary."),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# COGNITIVE 1/5: Critical Thinking
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "critthink", "subject_area": "cognitive_skills", "category_name": "Critical Thinking", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Is this TRUE or PRETEND: 'Dogs can bark.'", ["True", "Pretend"], "True"),
                q_mc("Is this TRUE or PRETEND: 'Dragons fly to school.'", ["True", "Pretend"], "Pretend"),
                q_mc("Is this TRUE or PRETEND: 'Cats can meow.'", ["True", "Pretend"], "True"),
                q_mc("Is this TRUE or PRETEND: 'A cow can talk on the phone.'", ["True", "Pretend"], "Pretend"),
                q_short("Tell one TRUE thing about the weather today.", "Answers will vary, should be a real fact."),
                q_short("Tell one PRETEND thing that could never really happen.", "Answers will vary."),
                q_mc("Something that is TRUE is also called a...", ["Fact", "Wish", "Song"], "Fact"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Sort each simple sentence as a FACT (can be proven) or an OPINION (someone's feeling).",
            "questions": [
                q_match("Sort each sentence.",
                        ["The sun rises in the east.", "Ice cream is the best food.", "A triangle has 3 sides.", "Winter is the worst season."],
                        ["Fact", "Opinion", "Fact", "Opinion"], [[0, 0], [1, 1], [2, 0], [3, 1]]),
                q_mc("A FACT is something that...", ["Can be proven true", "Is just someone's feeling", "Is always a guess"], "Can be proven true"),
                q_mc("An OPINION is something that...", ["Is someone's feeling or belief", "Can always be proven true", "Is always exactly correct"], "Is someone's feeling or belief"),
                q_short("Write one FACT about animals.", "Answers will vary, should be provable."),
                q_short("Write one OPINION about your favorite animal.", "Answers will vary, should express a feeling/preference."),
                q_mc("'Dogs make the best pets' is a...", ["Fact", "Opinion"], "Opinion"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read the short passage and spot which sentences are facts and which are opinions.",
            "questions": [
                q_short("Passage: 'Sharks live in the ocean. They are the scariest animals in the world.' Which sentence is a FACT?", "'Sharks live in the ocean.'"),
                q_short("Which sentence in that passage is an OPINION?", "'They are the scariest animals in the world.'"),
                q_mc("How can you tell a sentence is an opinion?", ["It expresses a feeling or judgment that not everyone would agree with", "It uses only short words", "It's always the second sentence"], "It expresses a feeling or judgment that not everyone would agree with"),
                q_short("Write your own short passage with 1 fact and 1 opinion about a topic you like.", "Answers will vary."),
                q_mc("Why is it useful to tell facts and opinions apart when you read?", ["It helps you know what's proven vs. what's just someone's view", "Facts and opinions are always the same thing", "It doesn't matter for understanding a passage"], "It helps you know what's proven vs. what's just someone's view"),
                q_short("Find a fact and an opinion in a book or article you're currently reading.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Evaluate two claims about the same topic and decide which is better-supported.",
            "questions": [
                q_short("Claim A: 'Recess should be longer because kids focus better after moving around.' Claim B: 'Recess should be longer because it's more fun.' Which is BETTER-SUPPORTED, and why?", "Claim A — it gives a reason based on evidence (focus), not just a feeling."),
                q_mc("A well-supported claim usually includes...", ["A reason or evidence behind it", "Just a strong opinion with no reason", "The loudest voice in the room"], "A reason or evidence behind it"),
                q_short("Write a well-supported claim about why students should read every day.", "Answers will vary — should include a real reason."),
                q_mc("Which makes a claim MORE convincing?", ["Backing it up with a reason or example", "Saying it louder", "Repeating it many times with no reason"], "Backing it up with a reason or example"),
                q_short("Rewrite this weak claim to make it better-supported: 'Homework is bad.'", "Answers will vary (e.g., 'Too much homework can reduce time for sleep, which affects learning.')."),
                q_mc("When comparing two claims, what should you look for first?", ["Whether each claim has real evidence or reasoning behind it", "Which claim is longer", "Which claim was said first"], "Whether each claim has real evidence or reasoning behind it"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Analyze an advertisement or claim: separate the facts from the persuasion.",
            "questions": [
                q_short("Ad claim: 'This cereal has 10 grams of whole grains per serving — the BEST breakfast ever!' What part is a FACT?", "'10 grams of whole grains per serving.'"),
                q_short("What part of that ad claim is PERSUASION (trying to convince you, not a proven fact)?", "'The BEST breakfast ever!'"),
                q_mc("Ads often use persuasive words like 'best' or 'amazing' because...", ["They try to make you feel excited, even without proof", "Those words are always factually accurate", "Ads are legally required to only state facts"], "They try to make you feel excited, even without proof"),
                q_short("Find a real ad (or make one up) and identify one fact and one persuasive phrase in it.", "Answers will vary."),
                q_mc("Why is it useful to separate facts from persuasion in an ad?", ["It helps you make decisions based on real information, not just excitement", "Ads never contain any real facts", "Persuasion and facts are the exact same thing"], "It helps you make decisions based on real information, not just excitement"),
                q_short("Write one persuasive sentence AND one purely factual sentence about the same product.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Compare two different sources covering the same topic.",
            "questions": [
                q_short("Find (or imagine) two sources about the same event that disagree on a detail. What do they disagree about?", "Answers will vary."),
                q_short("Which source seems more reliable to you, and why (author, evidence, date, etc.)?", "Answers will vary."),
                q_mc("When two sources disagree, a good next step is to...", ["Look for a third source or more evidence to compare", "Automatically believe whichever source you read first", "Assume both sources must be lying"], "Look for a third source or more evidence to compare"),
                q_short("What is one reason two honest sources might still describe the same event differently?", "Different perspectives, different information available, or different focus/emphasis."),
                q_mc("Comparing multiple sources on the same topic mainly helps you...", ["Get a fuller, more balanced understanding", "Waste time since one source is always enough", "Prove that all sources are equally trustworthy"], "Get a fuller, more balanced understanding"),
                q_short("Write one question you'd ask to check if a source is trustworthy.", "Answers will vary (e.g., 'Who wrote this, and do they have evidence?')."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Evaluate how strong the evidence really is in a short article.",
            "questions": [
                q_short("Read (or imagine) a short article's main claim. What evidence does it give to support that claim?", "Answers will vary."),
                q_mc("Strong evidence usually includes...", ["Specific data, expert sources, or clear examples", "Just a strong opinion stated confidently", "No sources at all"], "Specific data, expert sources, or clear examples"),
                q_short("Rate the evidence in your article as strong, medium, or weak, and explain why.", "Answers will vary."),
                q_mc("An article that says 'everyone knows this is true' with no source is...", ["Weak evidence — it provides no actual proof", "Strong evidence, since many people agree", "Impossible to evaluate"], "Weak evidence — it provides no actual proof"),
                q_short("What additional evidence would make this article's claim more convincing?", "Answers will vary."),
                q_mc("Why does it matter whether evidence is strong or weak?", ["Strong evidence makes a claim more trustworthy and worth acting on", "All evidence is equally trustworthy no matter what", "Evidence quality doesn't affect whether a claim is true"], "Strong evidence makes a claim more trustworthy and worth acting on"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Prep for a debate: build an argument with 3 supporting facts.",
            "questions": [
                q_short("Pick a debate topic. Write your main argument (the position you're taking) in one sentence.", "Answers will vary."),
                q_short("List 3 SEPARATE supporting facts or reasons for your argument.", "Answers will vary — should be 3 distinct, real supporting points."),
                q_mc("A strong debate argument needs...", ["Multiple distinct pieces of supporting evidence, not just one", "Just a confident tone of voice", "As many exclamation points as possible"], "Multiple distinct pieces of supporting evidence, not just one"),
                q_short("What's the strongest counter-argument someone could make against your position? How would you respond?", "Answers will vary."),
                q_mc("Why prepare a counter-argument response BEFORE the actual debate?", ["It helps you respond calmly and confidently instead of being caught off guard", "Counter-arguments never come up in real debates", "It's not useful — only your own argument matters"], "It helps you respond calmly and confidently instead of being caught off guard"),
                q_short("Write a strong closing sentence that sums up your 3 supporting facts.", "Answers will vary."),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# COGNITIVE 2/5: Problem-Solving
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "probsolve", "subject_area": "cognitive_skills", "category_name": "Problem-Solving", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_seq("Put the steps of brushing your teeth in order.", ["Put toothpaste on the brush", "Brush all your teeth", "Rinse your mouth with water"], "Toothpaste, brush, rinse."),
                q_seq("Put the steps of making a sandwich in order.", ["Get two pieces of bread", "Add your favorite filling", "Put the bread together"], "Bread, filling, together."),
                q_mc("If your tower of blocks falls down, what should you do?", ["Try building it again", "Give up and walk away", "Kick the blocks"], "Try building it again"),
                q_short("What is a problem you solved today, even a small one?", "Answers will vary."),
                q_seq("Put the steps for getting ready for bed in order.", ["Put on pajamas", "Brush your teeth", "Get into bed"], "Pajamas, brush teeth, bed."),
                q_mc("Breaking a big job into small steps is called...", ["Problem-solving", "Guessing", "Forgetting"], "Problem-solving"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Break a simple task into 4 ordered steps.",
            "questions": [
                q_seq("Break 'cleaning up your room' into 4 steps, in order.", ["Pick up toys and put them in the bin", "Put books back on the shelf", "Put dirty clothes in the hamper", "Make the bed"], "Answers will vary in exact order, should be 4 logical steps."),
                q_seq("Break 'planting a seed' into 4 steps, in order.", ["Fill a pot with soil", "Make a small hole", "Place the seed in and cover it", "Water it gently"], "Answers will vary in exact order, should be 4 logical steps."),
                q_mc("Why break a big task into smaller steps?", ["It's easier to finish one small step at a time", "It makes the task take longer", "It's only useful for chores"], "It's easier to finish one small step at a time"),
                q_short("Pick a task YOU do at home. Write it as 4 ordered steps.", "Answers will vary."),
                q_mc("What happens if you do the steps out of order?", ["The task might not work correctly", "It never matters what order you do things in", "Order is only important for math"], "The task might not work correctly"),
                q_short("What's a task where the ORDER of steps really matters a lot? Why?", "Answers will vary (e.g., baking — ingredients must go in at the right time)."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve a logic puzzle and show your thinking along the way.",
            "questions": [
                q_short("Puzzle: I have 3 pets. One is a dog, one is a cat, and one is a bird. The dog is not named Max. The cat is named Bella. What could the dog's name be? Show your thinking.", "Any name except Max or Bella (the cat's name)."),
                q_mc("When solving a maze, a good strategy is to...", ["Trace the path from start to finish, backing up at dead ends", "Guess randomly with your eyes closed", "Give up as soon as you hit one wrong turn"], "Trace the path from start to finish, backing up at dead ends"),
                q_short("Describe a strategy you'd use to solve a tricky maze.", "Answers will vary (e.g., work backward from the end, mark dead ends)."),
                q_mc("'Showing your work' on a puzzle means...", ["Writing down your thinking steps, not just the final answer", "Erasing everything except the final answer", "Not writing anything at all"], "Writing down your thinking steps, not just the final answer"),
                q_short("Why is showing your work helpful, even if you get the puzzle right?", "It helps you (and others) see HOW you solved it, and catch mistakes faster."),
                q_short("Make up your own simple logic clue puzzle for a friend to solve.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Solve a multi-step word problem by breaking it into parts.",
            "questions": [
                q_short("Word problem: Maria has 24 stickers. She gives 6 to her brother and buys 10 more. How many does she have now? Show each step.", "24 - 6 = 18, then 18 + 10 = 28 stickers."),
                q_mc("The FIRST step in a multi-step word problem is usually to...", ["Figure out what the problem is actually asking", "Guess a number immediately", "Skip to the last sentence only"], "Figure out what the problem is actually asking"),
                q_short("Word problem: A class of 28 students splits into teams of 4. Then 2 students join late. How many teams are there now, and are any teams uneven? Show your steps.", "28 / 4 = 7 teams, then 2 more students need to be added to existing teams or a new team formed — explain reasoning."),
                q_mc("Why break a word problem into smaller parts instead of solving it all at once?", ["It's easier to check each part for mistakes", "It always gives a different, wrong answer", "It takes the exact same effort either way"], "It's easier to check each part for mistakes"),
                q_short("Write your own 2-step word problem for a friend to solve.", "Answers will vary."),
                q_short("After solving a multi-step problem, how can you check if your answer makes sense?", "Answers will vary (e.g., estimate first, then compare; work backward from the answer)."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a solution for a real everyday problem.",
            "questions": [
                q_short("Pick an everyday problem (e.g., forgetting your backpack, losing your water bottle). Describe the problem clearly.", "Answers will vary."),
                q_short("Design ONE realistic solution to that problem.", "Answers will vary."),
                q_mc("A good solution to an everyday problem should be...", ["Something you could realistically actually do", "Impossible to actually carry out", "Someone else's job to fix, not yours"], "Something you could realistically actually do"),
                q_short("What materials or steps would you need to put your solution into action?", "Answers will vary."),
                q_mc("Why is clearly describing the PROBLEM first so important?", ["A solution only works if it actually solves the real problem", "The problem doesn't matter, only the solution does", "Describing the problem wastes time"], "A solution only works if it actually solves the real problem"),
                q_short("How would you know if your solution actually worked?", "Answers will vary (e.g., the problem stops happening)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Find the ROOT CAUSE of a problem before jumping to a solution.",
            "questions": [
                q_short("Problem: 'I keep forgetting my homework.' What might be the ROOT CAUSE (the real reason), not just the surface problem?", "Answers will vary (e.g., no consistent place to put homework, no reminder system)."),
                q_mc("A root cause is different from a symptom because...", ["The root cause is the underlying reason something keeps happening", "A symptom and a root cause are always the same thing", "Root causes don't actually matter for solving problems"], "The root cause is the underlying reason something keeps happening"),
                q_short("Problem: 'Our team keeps missing project deadlines.' What could be a root cause?", "Answers will vary (e.g., unclear roles, no shared timeline, poor communication)."),
                q_mc("Why is finding the root cause BEFORE solving more effective?", ["A solution aimed at the real cause is more likely to actually fix the problem long-term", "It's always faster to guess at a solution first", "Root causes are impossible to find"], "A solution aimed at the real cause is more likely to actually fix the problem long-term"),
                q_short("For the homework problem above, design a solution that targets the ROOT CAUSE, not just the symptom.", "Answers will vary."),
                q_short("What questions could you ask yourself to dig down to a root cause ('why' questions)?", "Answers will vary (e.g., asking 'why' multiple times in a row)."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Work through an engineering-style problem: constraints, plan, test, revise.",
            "questions": [
                q_short("Engineering challenge: design a paper structure that holds a small book off the table. List the CONSTRAINTS (rules/limits) you'd need to follow.", "Answers will vary (e.g., limited materials, must not touch the table with the book, etc.)."),
                q_seq("Put the engineering design process in order.", ["Understand the problem and its constraints", "Plan a possible design", "Build and test the design", "Revise the design based on what you learned"], "Understand, plan, test, revise."),
                q_short("Write your PLAN for the paper-structure challenge before building anything.", "Answers will vary."),
                q_mc("If your first design fails the test, what should you do?", ["Revise it based on what you learned and try again", "Give up completely", "Ignore the test result and submit it anyway"], "Revise it based on what you learned and try again"),
                q_short("What would you TEST to see if your design actually works?", "Answers will vary (e.g., does it hold the book's weight without collapsing?)."),
                q_mc("Why do engineers 'test and revise' instead of just building one final version?", ["Testing reveals problems you couldn't predict just by planning", "The first design is always perfect", "Testing wastes time and should be skipped"], "Testing reveals problems you couldn't predict just by planning"),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Plan an independent project: define the problem, plan, execute, and evaluate.",
            "questions": [
                q_short("Choose a real problem you'd like to solve with an independent project. Define it clearly in 1-2 sentences.", "Answers will vary."),
                q_short("Write a PLAN: what steps will you take, and in what order?", "Answers will vary."),
                q_short("Describe how you would EXECUTE (carry out) your plan.", "Answers will vary."),
                q_short("How would you EVALUATE whether your project actually solved the problem?", "Answers will vary."),
                q_mc("Why is the EVALUATE step often skipped, even though it's important?", ["People often feel done once they've finished executing, but evaluating shows if it actually worked", "Evaluation doesn't matter for independent projects", "You should evaluate before you even start"], "People often feel done once they've finished executing, but evaluating shows if it actually worked"),
                q_short("If your evaluation showed the project didn't fully solve the problem, what would you do next?", "Answers will vary (e.g., revise the plan and try again)."),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# COGNITIVE 3/5: Spatial Awareness
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "spatial", "subject_area": "cognitive_skills", "category_name": "Spatial Awareness", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_mc("Which shape has 3 sides?", ["Triangle", "Circle", "Square"], "Triangle"),
                q_mc("Which shape has 4 equal sides?", ["Square", "Triangle", "Circle"], "Square"),
                q_mc("Which shape is round with no corners?", ["Circle", "Square", "Triangle"], "Circle"),
                q_mc("Which shape has 4 sides but not all equal?", ["Rectangle", "Circle", "Triangle"], "Rectangle"),
                q_match("Match the shape name to how many sides it has.", ["Triangle", "Square", "Circle"], ["3 sides", "4 sides", "0 sides"], [[0, 0], [1, 1], [2, 2]]),
                q_short("Find something in your room shaped like a circle. What is it?", "Answers will vary."),
                q_mc("A puzzle piece that fits in a round hole is probably shaped like a...", ["Circle", "Square", "Triangle"], "Circle"),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Follow a simple picture map using left, right, up, and down.",
            "questions": [
                q_mc("To go from the door to the window, you walk up and then...", ["Right", "Down", "Backward"], "Right"),
                q_mc("If the treasure is UP and to the LEFT of the start, which direction do you go first?", ["Up", "Down", "Right"], "Up"),
                q_short("Draw a simple map of your bedroom with at least 3 objects labeled.", "Answers will vary."),
                q_mc("On a map, which direction is usually toward the top of the page?", ["Up / North", "Down / South", "Sideways"], "Up / North"),
                q_short("Give a friend directions from your classroom door to your desk, using left/right/up/down words.", "Answers will vary."),
                q_mc("Why are maps useful?", ["They help you find your way to a place", "They tell you the weather", "They're only used for treasure hunts"], "They help you find your way to a place"),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Use coordinates to find the spot on a simple grid.",
            "questions": [
                q_fill("On the grid, what is at this point?", "A star", "coordinate_point", {"x": 3, "y": 2}),
                q_fill("On the grid, what is at this point?", "A house", "coordinate_point", {"x": 1, "y": 4}),
                q_short("If a treasure is at point (2, 5), how would you describe getting there from (0, 0)?", "Go right 2 and up 5."),
                q_mc("On a coordinate grid, the FIRST number tells you...", ["How far to move right (across)", "How far to move up (vertically)", "The color of the point"], "How far to move right (across)"),
                q_short("Plot and label a point at (4, 3) on your own grid paper.", "Answers will vary — should show a point 4 across, 3 up."),
                q_mc("Why do maps and games use coordinate grids?", ["They give an exact, reliable way to describe a location", "They make locations harder to find", "Grids are only used in math class"], "They give an exact, reliable way to describe a location"),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Read a simple classroom or neighborhood map and answer questions about it.",
            "questions": [
                q_short("Imagine a map of your classroom. Describe the path from the door to the teacher's desk.", "Answers will vary."),
                q_mc("A map KEY (or legend) is used to...", ["Explain what symbols on the map mean", "Lock the map so no one can read it", "Show the exact temperature"], "Explain what symbols on the map mean"),
                q_short("Draw a simple map of your neighborhood (or a route you know well) with at least 4 labeled landmarks.", "Answers will vary."),
                q_mc("If two routes on a map lead to the same place, how could you tell which is shorter?", ["Compare the distances shown or count grid squares along each route", "Always pick the one that looks prettier", "Routes are always the exact same length"], "Compare the distances shown or count grid squares along each route"),
                q_short("Why might a map use symbols instead of writing out every single word?", "Symbols are quicker to read and take up less space."),
                q_mc("Reading a map accurately mostly requires...", ["Understanding scale, direction, and symbols together", "Only knowing the colors used", "Ignoring the map key"], "Understanding scale, direction, and symbols together"),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Find the area and perimeter of shapes drawn on a grid.",
            "questions": [
                q_fill("A rectangle is 5 units wide and 3 units tall. What is its AREA?", "15 square units", "rectangle_dims", {"width": 5, "height": 3}),
                q_fill("A rectangle is 5 units wide and 3 units tall. What is its PERIMETER?", "16 units", "rectangle_dims", {"width": 5, "height": 3}),
                q_fill("A rectangle is 6 units wide and 2 units tall. What is its AREA?", "12 square units", "rectangle_dims", {"width": 6, "height": 2}),
                q_mc("AREA measures...", ["The space INSIDE a shape", "The distance AROUND a shape", "Only the width of a shape"], "The space INSIDE a shape"),
                q_mc("PERIMETER measures...", ["The distance AROUND a shape", "The space INSIDE a shape", "Only the height of a shape"], "The distance AROUND a shape"),
                q_short("Draw a rectangle on grid paper that has an area of exactly 20 square units. What are its dimensions?", "Answers will vary (e.g., 4x5, 2x10)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Plot and interpret points on a full coordinate plane.",
            "questions": [
                q_fill("Plot this point. What quadrant is it in if both x and y are positive?", "Quadrant I", "coordinate_point", {"x": 4, "y": 3}),
                q_short("Plot the points (2,2), (2,5), (6,5), (6,2) and connect them in order. What shape do you get?", "A rectangle."),
                q_mc("A point at (-3, 4) is located...", ["Left of center and above center", "Right of center and above center", "Exactly at the center"], "Left of center and above center"),
                q_short("Why is a coordinate plane useful for describing exact locations in math and mapping?", "It gives every point a unique, precise address using two numbers."),
                q_fill("What are the coordinates of a point 5 to the right and 2 down from the origin?", "(5, -2)"),
                q_mc("The x-axis and y-axis meet at a point called the...", ["Origin", "Endpoint", "Vertex"], "Origin"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Create a scale drawing or floor plan of a real or imagined room.",
            "questions": [
                q_short("If 1 inch on your drawing = 2 feet in real life, and a wall is 12 feet long, how many inches would you draw it?", "6 inches (12 / 2 = 6)."),
                q_short("Design a simple scale floor plan for a bedroom, labeling the scale you used.", "Answers will vary — must include a clearly stated scale."),
                q_mc("A scale drawing is useful because...", ["It represents something large accurately in a smaller, manageable size", "It's always exactly the same size as the real object", "Scale doesn't matter for floor plans"], "It represents something large accurately in a smaller, manageable size"),
                q_short("If your scale is 1 inch = 3 feet, how long (in real feet) is a piece of furniture drawn as 2 inches?", "6 feet."),
                q_mc("Without a stated scale, a floor plan is...", ["Hard to interpret accurately, since sizes aren't clear", "Just as useful as one with a scale", "Automatically assumed to be full-size"], "Hard to interpret accurately, since sizes aren't clear"),
                q_short("Why do architects and engineers rely on scale drawings instead of full-size sketches?", "Answers will vary (e.g., real buildings are too big to draw at full size)."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Fold a 3D net and estimate the volume of the resulting shape.",
            "questions": [
                q_short("A net is a flat 2D pattern that folds into a 3D shape. Describe what net you'd need to fold to make a cube.", "6 equal squares connected in a cross or row pattern."),
                q_fill("A rectangular box is 4 units long, 3 units wide, and 2 units tall. What is its VOLUME?", "24 cubic units"),
                q_mc("Volume measures...", ["How much space is INSIDE a 3D shape", "The distance around the outside", "Only the height of the shape"], "How much space is INSIDE a 3D shape"),
                q_short("If you doubled the height of the box above (to 4 units), what would the new volume be?", "48 cubic units (4 x 3 x 4)."),
                q_mc("Why is folding a net a good way to understand 3D shapes?", ["It shows how flat faces connect to build a solid shape", "Nets have nothing to do with 3D shapes", "It's only useful for paper crafts"], "It shows how flat faces connect to build a solid shape"),
                q_short("Estimate the volume of a real box near you (a cereal box, a drawer) by measuring its length, width, and height.", "Answers will vary."),
            ],
        },
    },
})


# ═══════════════════════════════════════════════════════════════════════
# COGNITIVE 4/5: Metacognition
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "metacog", "subject_area": "cognitive_skills", "category_name": "Metacognition", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("What helped you learn something new today?", "Answers will vary."),
                q_short("What was your favorite thing you did today?", "Answers will vary."),
                q_mc("If something is tricky, what can you do?", ["Try again or ask for help", "Give up right away", "Get mad and stop"], "Try again or ask for help"),
                q_short("Draw a sticker star for something you're proud of learning today.", "Answers will vary."),
                q_mc("Thinking about how you learn is called...", ["Metacognition", "Recess", "Snack time"], "Metacognition"),
                q_short("Who helped you today, and how?", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Fill in what you learned and what you liked.",
            "questions": [
                q_short("Complete: 'Today I learned...'", "Answers will vary."),
                q_short("Complete: 'Today I liked...'", "Answers will vary."),
                q_mc("Why is it helpful to think about what you learned each day?", ["It helps you remember and notice your own progress", "It doesn't help at all", "It's only for teachers to know, not you"], "It helps you remember and notice your own progress"),
                q_short("What is something that was HARD today, and what helped (or would help) with it?", "Answers will vary."),
                q_mc("If you liked an activity today, that's a clue that...", ["You might enjoy learning that way again", "You should never do anything else", "It has nothing to do with how you learn"], "You might enjoy learning that way again"),
                q_short("What do you want to learn about tomorrow?", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Check off how you learn best: by seeing, hearing, or doing.",
            "questions": [
                q_mc("If you remember things best by looking at pictures or charts, you might be a...", ["See (visual) learner", "Hear (auditory) learner", "Do (hands-on) learner"], "See (visual) learner"),
                q_mc("If you remember things best by listening, you might be a...", ["Hear (auditory) learner", "See (visual) learner", "Do (hands-on) learner"], "Hear (auditory) learner"),
                q_mc("If you remember things best by trying it yourself, you might be a...", ["Do (hands-on) learner", "See (visual) learner", "Hear (auditory) learner"], "Do (hands-on) learner"),
                q_short("Which learning style (see/hear/do) do YOU think fits you best? Give an example.", "Answers will vary."),
                q_mc("Knowing your learning style can help you...", ["Choose study methods that work better for you", "Force yourself to learn only one way forever", "Nothing — learning style doesn't matter"], "Choose study methods that work better for you"),
                q_short("Name one activity at school that matches your learning style.", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Self-rate a recent task: what was easy, what was hard, and why.",
            "questions": [
                q_short("Think of a recent school task. Rate it: easy, medium, or hard — and explain why.", "Answers will vary."),
                q_short("What made the hardest PART of that task difficult?", "Answers will vary."),
                q_mc("Rating a task as 'hard' mainly helps you...", ["Notice where you might need more practice or a different strategy", "Feel bad about yourself", "Avoid that subject forever"], "Notice where you might need more practice or a different strategy"),
                q_short("What strategy could make that hard part easier next time?", "Answers will vary."),
                q_mc("Something that feels 'easy' for you might feel 'hard' for someone else because...", ["Everyone has different strengths and past practice", "Easy and hard mean the exact same thing for everyone", "Only some people are capable of learning"], "Everyone has different strengths and past practice"),
                q_short("What is something that used to be hard for you but feels easy now? What changed?", "Answers will vary (e.g., practice, a new strategy)."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Keep a study strategy log: track which methods actually worked.",
            "questions": [
                q_short("List 2 study strategies you've tried (flashcards, reading aloud, quizzing yourself, etc.).", "Answers will vary."),
                q_short("Which of those strategies worked BETTER for you, and how do you know?", "Answers will vary — should reference an actual result, like a quiz score or how well they remembered."),
                q_mc("A study strategy log is useful because...", ["It helps you notice patterns in what actually works for you over time", "It's just extra homework with no real purpose", "All strategies work exactly the same for everyone"], "It helps you notice patterns in what actually works for you over time"),
                q_short("What's one NEW study strategy you haven't tried yet that you'd like to test?", "Answers will vary."),
                q_mc("How can you tell if a study strategy 'worked'?", ["You remembered or understood the material better afterward", "It felt easy in the moment, regardless of the result", "The strategy took a long time to do"], "You remembered or understood the material better afterward"),
                q_short("Design a simple study strategy log format you could use for your next test.", "Answers will vary."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Set a learning goal, and check your progress toward it.",
            "questions": [
                q_short("Write one specific learning goal for this month (e.g., 'Get faster at multiplication facts').", "Answers will vary."),
                q_short("How will you know if you've made progress toward this goal?", "Answers will vary (e.g., timed quiz scores improving)."),
                q_mc("A good learning goal should be...", ["Specific and something you can actually measure progress on", "Vague, like 'get smarter'", "Impossible to ever check"], "Specific and something you can actually measure progress on"),
                q_short("What is ONE action you'll take this week toward your goal?", "Answers will vary."),
                q_mc("If you check your progress and you're behind on your goal, what should you do?", ["Adjust your plan or effort, not give up on the goal", "Immediately give up on the goal entirely", "Ignore the check-in and hope it fixes itself"], "Adjust your plan or effort, not give up on the goal"),
                q_short("How will you celebrate or acknowledge it when you reach your goal?", "Answers will vary."),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Reflect on a mistake: what strategy will you try differently next time?",
            "questions": [
                q_short("Describe a recent mistake you made on an assignment or test.", "Answers will vary."),
                q_short("What do you think CAUSED the mistake (rushing, misunderstanding, not studying a certain part, etc.)?", "Answers will vary."),
                q_mc("Reflecting on a mistake is most useful when it leads to...", ["A specific strategy you'll try differently next time", "Feeling bad about yourself with no plan to improve", "Blaming the mistake on bad luck"], "A specific strategy you'll try differently next time"),
                q_short("What SPECIFIC strategy will you try next time to avoid a similar mistake?", "Answers will vary."),
                q_mc("Which mindset helps you learn more from mistakes?", ["'Mistakes show me what to work on next.'", "'Mistakes mean I'm just bad at this.'", "'Mistakes should never happen and mean I should quit.'"], "'Mistakes show me what to work on next.'"),
                q_short("Has a mistake ever taught you something you still use today? Explain.", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a personal study plan for an upcoming test.",
            "questions": [
                q_short("List the topics you'll need to study for your next test.", "Answers will vary."),
                q_short("Write a study SCHEDULE — which topic on which day, leading up to the test.", "Answers will vary."),
                q_mc("A good study plan should account for...", ["Which topics you find hardest, giving them more time", "Equal time for every topic no matter how well you know it", "Cramming everything the night before"], "Which topics you find hardest, giving them more time"),
                q_short("What study strategies will you use for your hardest topic, based on what's worked for you before?", "Answers will vary."),
                q_mc("Why plan study time across several days instead of one long session?", ["Spacing out study helps you remember material better over time", "One long session is always more effective", "It doesn't matter how you space out studying"], "Spacing out study helps you remember material better over time"),
                q_short("How will you check, a few days before the test, whether your plan is actually working?", "Answers will vary (e.g., a practice quiz)."),
            ],
        },
    },
})

# ═══════════════════════════════════════════════════════════════════════
# COGNITIVE 5/5: Design Thinking & Innovation
# ═══════════════════════════════════════════════════════════════════════
CATEGORIES.append({
    "key": "designthink", "subject_area": "cognitive_skills", "category_name": "Design Thinking & Innovation", "is_core": False,
    "grades": {
        0: {
            "target_count": 6, "layout_type": "short_answer", "intro_text": None,
            "questions": [
                q_short("Silly problem: your ice cream keeps melting too fast! Draw or describe a solution.", "Answers will vary (e.g., an ice cream hat, a cold lunchbox)."),
                q_short("Silly problem: your shoes keep untying themselves. Draw or describe a solution.", "Answers will vary."),
                q_mc("Inventing a solution to a problem is called...", ["Design thinking", "Sleeping", "Forgetting"], "Design thinking"),
                q_short("What is one problem YOU wish had a solution?", "Answers will vary."),
                q_mc("A silly or fun idea can still be...", ["A helpful step toward a real solution", "Never useful at all", "Against the rules of design"], "A helpful step toward a real solution"),
                q_short("Draw your silly-problem solution and give it a fun name.", "Answers will vary."),
            ],
        },
        1: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Invent a helper tool to solve a problem.",
            "questions": [
                q_short("Invent a tool that would help you clean up toys faster. Draw or describe it.", "Answers will vary."),
                q_short("Invent a tool that would help you reach something high up. Draw or describe it.", "Answers will vary."),
                q_mc("A 'helper tool' is designed to...", ["Make a task easier or faster", "Make a task harder", "Look nice but do nothing"], "Make a task easier or faster"),
                q_short("Give your invented tool a name.", "Answers will vary."),
                q_mc("Why do inventors think about a REAL problem before designing a tool?", ["So the tool actually helps with something people need", "The problem doesn't matter, only the tool's looks", "Inventors never think about problems first"], "So the tool actually helps with something people need"),
                q_short("What would your tool be made of?", "Answers will vary."),
            ],
        },
        2: {
            "target_count": 6, "layout_type": "short_answer",
            "intro_text": "Redesign an everyday object to make it better.",
            "questions": [
                q_short("Pick an everyday object (backpack, water bottle, umbrella). What's one thing that could be improved about it?", "Answers will vary."),
                q_short("Redesign it: describe or draw your improved version.", "Answers will vary."),
                q_mc("A good redesign should...", ["Solve a real annoyance or problem with the original", "Change something that was already working perfectly", "Make the object harder to use"], "Solve a real annoyance or problem with the original"),
                q_short("Who would benefit most from your redesigned object?", "Answers will vary."),
                q_mc("Why is 'redesigning' a useful skill, not just 'inventing something totally new'?", ["Small improvements to existing things can solve real problems too", "Redesigning is not a real form of innovation", "Only brand-new inventions count as innovation"], "Small improvements to existing things can solve real problems too"),
                q_short("What materials would your redesigned object need?", "Answers will vary."),
            ],
        },
        3: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Practice the design thinking mini-process: empathize, ideate, prototype.",
            "questions": [
                q_short("EMPATHIZE: pick a person (a classmate, a parent) and describe a problem they deal with.", "Answers will vary."),
                q_short("IDEATE: brainstorm 2 different ideas that could help solve their problem.", "Answers will vary."),
                q_short("PROTOTYPE: describe (or sketch) a simple first version of your best idea.", "Answers will vary."),
                q_seq("Put the design thinking mini-process in order.", ["Empathize — understand the person and their problem", "Ideate — brainstorm possible solutions", "Prototype — build a simple first version"], "Empathize, ideate, prototype."),
                q_mc("Why does design thinking START with empathizing, not ideating?", ["You need to truly understand the problem before you can solve it well", "Empathizing wastes time and should be skipped", "Ideas are always better without understanding the user first"], "You need to truly understand the problem before you can solve it well"),
                q_short("What would you ask the person from your EMPATHIZE step to find out if your prototype actually helps them?", "Answers will vary."),
            ],
        },
        4: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Design a product with a specific target user in mind.",
            "questions": [
                q_short("Choose a target user (e.g., 'kids who forget their homework'). What product could help them?", "Answers will vary."),
                q_short("Describe your product's main feature and how it solves the user's problem.", "Answers will vary."),
                q_mc("Designing 'for a target user' means...", ["Making choices based on that specific group's needs", "Trying to please absolutely everyone at once", "Ignoring who will actually use the product"], "Making choices based on that specific group's needs"),
                q_short("What is one feature your target user would care about most, and why?", "Answers will vary."),
                q_mc("Why might a product designed for EVERYONE end up not working great for ANYONE?", ["Trying to meet every need at once often means meeting none of them well", "Products for everyone always work best", "Target users don't actually matter in design"], "Trying to meet every need at once often means meeting none of them well"),
                q_short("How would you find out if your target user actually likes your product idea?", "Answers will vary (e.g., ask them, show a sketch and get feedback)."),
            ],
        },
        5: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Write a lemonade-stand style business plan.",
            "questions": [
                q_short("What product or service would your stand sell?", "Answers will vary."),
                q_short("Who is your target customer, and why would they want to buy from you?", "Answers will vary."),
                q_short("List your estimated costs (supplies) and your planned price per item.", "Answers will vary."),
                q_mc("A basic business plan should answer...", ["What you sell, who buys it, and how you'll make more than you spend", "Only what color your sign will be", "Nothing about cost or customers"], "What you sell, who buys it, and how you'll make more than you spend"),
                q_short("What would make a customer choose YOUR stand over a similar one nearby?", "Answers will vary."),
                q_mc("Why is it useful to estimate costs BEFORE you start selling?", ["So you can set a price that actually earns you money", "Costs don't matter until after you've sold things", "You should never think about money in advance"], "So you can set a price that actually earns you money"),
            ],
        },
        6: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Build a prototype idea and describe how you'd use peer feedback to improve it.",
            "questions": [
                q_short("Describe a prototype (a simple first version) of an idea you'd like to build.", "Answers will vary."),
                q_short("Write 2 specific questions you'd ask a peer to get useful feedback on your prototype.", "Answers will vary (e.g., 'What part was confusing?')."),
                q_mc("Useful peer feedback questions are usually...", ["Specific, so the answers give you something actionable", "Vague, like 'do you like it?'", "Unnecessary — feedback never helps"], "Specific, so the answers give you something actionable"),
                q_short("Imagine a peer said your prototype was 'confusing to use.' What would you ask next to understand why?", "Answers will vary (e.g., 'Which part specifically was confusing?')."),
                q_mc("Getting feedback BEFORE building a final version helps you...", ["Fix problems while changes are still easy to make", "Waste time that could be spent building", "Avoid ever having to make changes"], "Fix problems while changes are still easy to make"),
                q_short("How would you revise your prototype based on feedback you imagine receiving?", "Answers will vary."),
            ],
        },
        7: {
            "target_count": 6, "layout_type": "space_heavy",
            "intro_text": "Prepare a short pitch: problem, solution, audience, next steps.",
            "questions": [
                q_short("PROBLEM: state the problem your idea solves in one clear sentence.", "Answers will vary."),
                q_short("SOLUTION: describe your solution in one or two sentences.", "Answers will vary."),
                q_short("AUDIENCE: who specifically needs this solution, and why do they need it?", "Answers will vary."),
                q_short("NEXT STEPS: what would you do first if you got the chance to actually build this?", "Answers will vary."),
                q_mc("A strong pitch is mainly judged by...", ["How clearly it explains the problem and why the solution matters", "How long it is", "How many big words it uses"], "How clearly it explains the problem and why the solution matters"),
                q_mc("Why include 'next steps' at the end of a pitch?", ["It shows you've thought beyond just the idea, toward actually doing it", "Next steps are unnecessary in a pitch", "It should be the very first thing you say"], "It shows you've thought beyond just the idea, toward actually doing it"),
            ],
        },
    },
})


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def rebalance_target_counts():
    """Derive target_count from the ACTUAL authored pool size rather than the
    manually-set value, so weekly NEWID() sampling always has real headroom
    to vary (a pool size ~= target_count means the exact same questions show
    every single week the category is picked, defeating the "repeats but
    stays fresh" design). is_core categories get more headroom since they
    show every week."""
    for cat in CATEGORIES:
        for grade_id, gc in cat["grades"].items():
            n = len(gc["questions"])
            min_target = 6 if cat.get("is_core") else 4
            gc["target_count"] = max(min_target, round(n * 0.65))


def emit():
    rebalance_target_counts()
    out = []
    out.append("-- 64_sel_cognitive_content.sql")
    out.append("-- Whole-Child Curriculum expansion, part 2: content for the 'sel' (Social-")
    out.append("-- Emotional Learning) and 'cognitive_skills' subject_area groups, hand-")
    out.append("-- crafted across all 8 grades (TK-6th) from the curriculum matrix the site")
    out.append("-- owner provided. Schema/rotation logic added in 63_whole_child_rotation.sql")
    out.append("-- must run first. 'Emotional Regulation' is flagged is_core=1 at every grade")
    out.append("-- (mastery-anchor category, appears every week — see 63's proc comments) with")
    out.append("-- a deliberately larger question pool than the other categories so weekly")
    out.append("-- NEWID() sampling still varies meaningfully.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'sel')")
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
    out.append("-- Force existing WeeklyPacketPlans to regenerate under the new rotation +")
    out.append("-- content (matches precedent in 60/61/62).")
    out.append("DELETE FROM dbo.WeeklyPacketPlan;")
    out.append("GO")
    return "\n".join(out)


if __name__ == "__main__":
    import sys
    total_q = sum(len(gc["questions"]) for cat in CATEGORIES for gc in cat["grades"].values())
    total_cat = sum(len(cat["grades"]) for cat in CATEGORIES)
    print(f"Categories: {total_cat}, Questions: {total_q}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\64_sel_cognitive_content.sql", "w", encoding="utf-8") as f:
        f.write(emit())
    print("Wrote 64_sel_cognitive_content.sql", file=sys.stderr)
