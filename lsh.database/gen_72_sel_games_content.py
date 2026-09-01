# -*- coding: utf-8 -*-
"""
Generates lsh.database/72_sel_games_content.sql -- adds an "SEL
Skill-Building Games" category to the existing always-on 'sel' subject_area
for every grade TK-6. Each grade gets a pool of 14 hand-crafted games; the
existing rotation samples 7 of them (via target_count=7, ORDER BY NEWID())
fresh each week a grade's sel category is picked, so consecutive weeks show
a different set without any manual "week 1 / week 2" authoring.

This script follows gen_68_outdoor_games_content.py (the proven template for
this kind of content batch) structurally: same esc() helper, same " | "
pipe materials separator, same emit_sql() SQL shape, same
check_completeness() guard, same critical newline="" file-write.

Run with: python gen_72_sel_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "\U0001F3AD Feeling Faces Freeze",
        "objective": "Practice naming a feeling by making a matching face and body when the music stops.",
        "materials": ["Music player (phone or speaker)"],
        "steps": [
            "Grown-up plays music while everyone dances around.",
            "When the music stops, grown-up calls out a feeling word like 'happy!'",
            "Everyone freezes and makes that feeling face with their whole body.",
            "Turn the music back on and try a new feeling next time!",
        ],
        "tip": "There's no wrong way to show a feeling -- every face counts.",
    },
    {
        "name": "\U0001F442 Listening Ears Game",
        "objective": "Practice listening carefully to a sound and copying it back together.",
        "materials": ["None -- just a grown-up and a quiet space"],
        "steps": [
            "Everyone sits in a circle and closes their eyes.",
            "Grown-up makes a soft sound (a clap, a tap, a hum).",
            "Everyone opens their eyes and copies the same sound back together.",
            "Try a new sound each round!",
        ],
        "tip": "Quiet ears help us hear all the little sounds around us.",
    },
    {
        "name": "\U0001F91D Pass the Squeeze",
        "objective": "Practice taking turns and working together as a group.",
        "materials": ["None -- just a group holding hands"],
        "steps": [
            "Everyone holds hands in a circle.",
            "Grown-up gently squeezes the hand of the child next to them.",
            "That squeeze gets passed hand to hand all the way around the circle.",
            "See how fast the squeeze can travel all the way around!",
        ],
        "tip": "Teamwork means everyone helps the squeeze keep going.",
    },
    {
        "name": "\U0001F9F8 Share the Teddy",
        "objective": "Practice taking turns sharing something with a friend.",
        "materials": ["1 soft stuffed animal or toy"],
        "steps": [
            "Sit in a small circle with a soft toy in the middle.",
            "Grown-up asks a simple question, like 'What made you smile today?'",
            "Whoever is holding the toy gets to answer, then gently passes it to the next friend.",
            "Keep passing until everyone has had a turn.",
        ],
        "tip": "Waiting for your turn is a way of being kind to your friends.",
    },
    {
        "name": "\U0001F422 Turtle Breathing",
        "objective": "Practice slow breathing to feel calm, like a turtle tucking into its shell.",
        "materials": ["None"],
        "steps": [
            "Stand tall with arms stretched out like a turtle's head and legs.",
            "Take a big slow breath in while pulling your arms and head in like a shell.",
            "Breathe out slowly while opening back up.",
            "Repeat 3 times together!",
        ],
        "tip": "Turtle breathing is a trick you can use anytime you feel a big feeling.",
    },
    {
        "name": "\U0001F308 Kind Words Toss",
        "objective": "Practice saying kind words to a friend while playing a gentle toss game.",
        "materials": ["1 soft ball or beanbag"],
        "steps": [
            "Sit or stand in a circle.",
            "Gently roll or toss the ball to a friend while saying something kind, like 'I like your smile.'",
            "That friend rolls it to someone new with a kind word.",
            "Keep going until everyone has gotten a kind word!",
        ],
        "tip": "Kind words are like little gifts we give with our voice.",
    },
    {
        "name": "\U0001F440 Watch and Wait",
        "objective": "Practice waiting quietly and watching for a turn signal.",
        "materials": ["1 soft ball"],
        "steps": [
            "Two children sit facing each other with a grown-up nearby.",
            "Grown-up holds up a hand as the 'go' signal.",
            "Take turns rolling the ball back and forth only when the hand goes up.",
            "Practice waiting patiently for your turn to come!",
        ],
        "tip": "Waiting quietly is its own kind of listening.",
    },
    {
        "name": "\U0001FAC2 Gentle Hug Circle",
        "objective": "Practice offering comfort to a friend who feels sad.",
        "materials": ["None"],
        "steps": [
            "Stand in a circle with a grown-up.",
            "Grown-up pretends to feel sad and makes a sad face.",
            "Everyone takes a turn giving a gentle hug or pat on the back to help.",
            "Talk about how it feels to help a friend feel better.",
        ],
        "tip": "A gentle hug can help a sad feeling feel smaller.",
    },
    {
        "name": "\U0001F9E9 Build It Together",
        "objective": "Practice working together to build something as a team.",
        "materials": ["Soft blocks or stacking cups"],
        "steps": [
            "Sit together with a small pile of blocks.",
            "Take turns adding one block at a time to build a tower.",
            "Talk about where to put the next piece together.",
            "Cheer together when the tower is finished!",
        ],
        "tip": "Great towers are built one turn at a time.",
    },
    {
        "name": "\U0001F324\uFE0F Sun and Cloud Feelings",
        "objective": "Practice noticing whether a feeling feels sunny or cloudy inside.",
        "materials": ["Paper and crayons (optional)"],
        "steps": [
            "Grown-up asks, 'How do you feel right now -- sunny or cloudy?'",
            "Stretch arms up wide like sunshine for a happy feeling, or curl up small like a cloud for a quiet or sad feeling.",
            "Show your sunny or cloudy pose to the group.",
            "Talk about what might turn a cloudy feeling a little more sunny.",
        ],
        "tip": "Every kind of weather feeling is okay to have.",
    },
    {
        "name": "\U0001F423 Peekaboo Patience",
        "objective": "Practice waiting calmly for a fun surprise.",
        "materials": ["A blanket or scarf"],
        "steps": [
            "One player hides behind a blanket held by a grown-up.",
            "Everyone waits quietly and counts to five.",
            "Grown-up lowers the blanket for a big 'peekaboo!'",
            "Take turns being the one who hides.",
        ],
        "tip": "Waiting can be part of the fun, not just the hard part.",
    },
    {
        "name": "\U0001F388 Balloon Feelings Pop",
        "objective": "Practice noticing a feeling word and acting it out together as a group.",
        "materials": ["1 balloon (or soft ball)"],
        "steps": [
            "Grown-up names a feeling for the pretend 'balloon,' like excited or mad.",
            "Everyone acts out that feeling together -- stomping for mad, jumping for excited, slumping for sad.",
            "Pop back to a calm, still pose after each feeling.",
            "Try a new feeling balloon each round!",
        ],
        "tip": "Feelings come and go, just like a balloon floating by.",
    },
    {
        "name": "\U0001F91D Helping Hands Hunt",
        "objective": "Practice noticing small ways to help a friend.",
        "materials": ["None"],
        "steps": [
            "Walk around the room or yard with a grown-up.",
            "Look for a friend who might need a little help, like picking up a dropped toy.",
            "Offer to help and say a kind word.",
            "Talk together about how it felt to help.",
        ],
        "tip": "Even tiny helps make a big difference to a friend.",
    },
    {
        "name": "\U0001F5E3\uFE0F Whisper Down the Circle",
        "objective": "Practice listening closely and passing along a simple message.",
        "materials": ["None"],
        "steps": [
            "Sit in a circle with a grown-up.",
            "Grown-up whispers a short, simple word to the first friend.",
            "Each friend whispers it to the next, all the way around.",
            "Say the word out loud at the end and see if it matched!",
        ],
        "tip": "Careful listening helps messages travel true.",
    },
]


GAMES[1] = [
    {
        "name": "\U0001F3AD Guess My Feeling",
        "objective": "Practice reading a friend's face to guess how they feel.",
        "materials": ["None"],
        "steps": [
            "One player makes a feeling face (happy, sad, surprised, mad).",
            "Friends look closely and guess the feeling out loud.",
            "The maker says whether they guessed right.",
            "Take turns being the feeling-face maker.",
        ],
        "tip": "Faces can tell us a lot about how someone feels inside.",
    },
    {
        "name": "\U0001F32C\uFE0F Pinwheel Breaths",
        "objective": "Practice slow breathing to calm down using a pretend or real pinwheel.",
        "materials": ["A pinwheel (or just pretend to hold one)"],
        "steps": [
            "Hold up your pretend pinwheel in front of your face.",
            "Take a deep breath in through your nose.",
            "Blow out slowly and gently to make the pinwheel spin.",
            "Do it three times until you feel calm and steady.",
        ],
        "tip": "Slow breaths help big feelings get smaller and easier to handle.",
    },
    {
        "name": "\U0001F9F5 Yarn Web of Kindness",
        "objective": "Practice giving compliments while building a web together as a group.",
        "materials": ["1 ball of yarn or string"],
        "steps": [
            "Stand in a circle, and the first player holds the end of the yarn.",
            "Say something kind about a friend, then toss the ball to them while holding your piece.",
            "That friend says something kind and tosses it to someone new.",
            "See the web you all made together when everyone has had a turn!",
        ],
        "tip": "Kind words connect us just like the yarn does.",
    },
    {
        "name": "\U0001F6A6 Feelings Stoplight",
        "objective": "Practice noticing if a feeling is calm, getting big, or too big.",
        "materials": ["Paper circles or a drawn stoplight (optional)"],
        "steps": [
            "Grown-up explains a stoplight: green means calm, yellow means a feeling is growing, red means STOP and breathe.",
            "Act out each color with your body -- green is standing tall and relaxed, yellow is wiggly, red is freeze and take a breath.",
            "Practice moving from red back down to green with slow breaths.",
            "Talk about a time you felt yellow or red.",
        ],
        "tip": "Every color on the stoplight is a normal stop along the way to calm.",
    },
    {
        "name": "\U0001F91D Handshake Hello",
        "objective": "Practice greeting a friend warmly and paying attention to them.",
        "materials": ["None"],
        "steps": [
            "Pair up with a friend.",
            "Make eye contact and say hello using their name.",
            "Invent a silly two-step handshake together, like a high five and a fist bump.",
            "Try your new handshake with a different friend!",
        ],
        "tip": "A friendly hello helps everyone feel noticed.",
    },
    {
        "name": "\U0001F9E6 Odd Sock Sharing",
        "objective": "Practice solving a simple problem about sharing fairly.",
        "materials": ["A few mismatched socks or small toys"],
        "steps": [
            "Grown-up presents a pretend problem: only one fun toy, but two friends want it.",
            "Talk together about fair ideas, like taking turns or trading.",
            "Try out the idea the group agrees on.",
            "Talk about how the fair solution felt.",
        ],
        "tip": "Fair doesn't always mean the same -- it means everyone feels okay.",
    },
    {
        "name": "\U0001F412 Copy Cat Listening",
        "objective": "Practice listening and copying a friend's actions exactly.",
        "materials": ["None"],
        "steps": [
            "Pair up, facing each other.",
            "One friend does 3 simple moves in a row, like clap, spin, wave.",
            "The other friend watches closely, then copies all 3 moves in order.",
            "Switch roles and try a new set of moves!",
        ],
        "tip": "Watching and listening closely helps you remember more.",
    },
    {
        "name": "\U0001FAE7 Bubble Breath Calm Down",
        "objective": "Practice calming breathing using real or pretend bubbles.",
        "materials": ["Bubble wand and solution (optional)"],
        "steps": [
            "Take a slow breath in.",
            "Blow out gently to make one big, slow bubble, real or pretend.",
            "Watch the bubble float away, carrying a little bit of a big feeling with it.",
            "Try again with a new bubble whenever you need to calm down.",
        ],
        "tip": "Slow bubble breaths remind our body it's safe to relax.",
    },
    {
        "name": "\U0001F9ED Helper of the Day",
        "objective": "Practice looking for chances to help others throughout playtime.",
        "materials": ["None"],
        "steps": [
            "Pick one friend to be Helper of the Day.",
            "That friend looks for small ways to help others during playtime.",
            "At the end, everyone shares one kind thing the Helper did.",
            "Take turns so everyone gets a turn to be Helper.",
        ],
        "tip": "Helping others is a skill that grows stronger every time you use it.",
    },
    {
        "name": "\U0001F3B6 Mirror Move Along",
        "objective": "Practice working together by moving in sync with a partner.",
        "materials": ["Music player (optional)"],
        "steps": [
            "Face a partner and decide who moves first.",
            "The first friend makes a slow movement; the partner mirrors it like a reflection.",
            "Switch who leads after a minute.",
            "Try moving together at the very same time without a leader!",
        ],
        "tip": "Working well together means watching and adjusting to each other.",
    },
    {
        "name": "\U0001F64B Raise a Quiet Hand",
        "objective": "Practice waiting for a turn to talk by raising a hand.",
        "materials": ["None"],
        "steps": [
            "Sit together in a group.",
            "Grown-up asks a fun question, like 'What's your favorite animal?'",
            "Raise a quiet hand and wait to be called on before answering.",
            "Practice listening to each answer before the next person talks.",
        ],
        "tip": "A raised hand is a polite way to say 'I have something to share.'",
    },
    {
        "name": "\U0001F9FA Sorry and Solved",
        "objective": "Practice saying sorry and fixing a small problem with a friend.",
        "materials": ["None"],
        "steps": [
            "Act out a pretend problem, like accidentally bumping into a friend's tower.",
            "The player who bumped says 'I'm sorry' and asks how to help.",
            "Work together to fix or rebuild what happened.",
            "Give each other a high five when it's fixed!",
        ],
        "tip": "Saying sorry and helping fix things shows you care.",
    },
    {
        "name": "\U0001F381 Compliment Basket",
        "objective": "Practice giving and receiving kind compliments.",
        "materials": ["A basket or box (optional)"],
        "steps": [
            "Sit in a circle with a pretend basket of kind words.",
            "Take turns picking a friend and giving them one kind compliment.",
            "The friend receiving it says thank you.",
            "Keep going until everyone has given and gotten a compliment.",
        ],
        "tip": "Compliments are little gifts that don't cost anything to give.",
    },
    {
        "name": "\U0001F40C Slow Motion Feelings Walk",
        "objective": "Practice noticing body feelings by moving in slow motion.",
        "materials": ["None"],
        "steps": [
            "Grown-up calls out a feeling, like excited or sleepy.",
            "Walk in super slow motion, showing what that feeling looks like in your body.",
            "Freeze in your slow-motion pose when the grown-up says 'freeze.'",
            "Try a new feeling and walk again!",
        ],
        "tip": "Slowing down can help you notice how a feeling really feels.",
    },
]


GAMES[2] = [
    {
        "name": "\U0001F3AD Feelings Charades",
        "objective": "Practice recognizing feelings by acting them out without words.",
        "materials": ["Index cards with feeling words (or just call them out)"],
        "steps": [
            "Write or say feeling words like surprised, proud, or worried.",
            "One player acts out the feeling using only their face and body -- no talking.",
            "The group guesses the feeling.",
            "Take turns until everyone has acted one out.",
        ],
        "tip": "You can tell a lot about a feeling just by watching someone's body.",
    },
    {
        "name": "\U0001F300 Calm Down Countdown",
        "objective": "Practice a simple breathing routine to settle a big feeling.",
        "materials": ["None"],
        "steps": [
            "Stand still and notice how your body feels.",
            "Breathe in for 4 counts, hold for 2, breathe out for 4.",
            "Repeat the countdown breathing three times.",
            "Notice if your body feels any calmer afterward.",
        ],
        "tip": "Counting your breath gives a big feeling something steady to hold onto.",
    },
    {
        "name": "\U0001F9E9 Puzzle Partners",
        "objective": "Practice working together to solve a simple puzzle using only words.",
        "materials": ["A simple jigsaw puzzle or a picture cut into pieces"],
        "steps": [
            "Split the puzzle pieces evenly between two partners.",
            "Take turns describing your pieces without showing them.",
            "Work together to figure out where each piece goes.",
            "Put the finished puzzle together as a team!",
        ],
        "tip": "Describing clearly and listening carefully both matter for teamwork.",
    },
    {
        "name": "\u2696\uFE0F Fair Trade Talk",
        "objective": "Practice negotiating a fair solution when two people want the same thing.",
        "materials": ["Two different toys or items"],
        "steps": [
            "Pretend both partners want the same item.",
            "Take turns suggesting fair ideas, like taking turns, splitting time, or trading.",
            "Agree on one idea together.",
            "Try it out and check in: did it feel fair to both of you?",
        ],
        "tip": "A good solution usually means both people give a little and get a little.",
    },
    {
        "name": "\U0001F442 Listening Detective",
        "objective": "Practice listening closely enough to retell what a partner said.",
        "materials": ["None"],
        "steps": [
            "One partner talks for 30 seconds about their weekend or a favorite thing.",
            "The listener stays quiet and pays close attention.",
            "The listener retells back three details they remember.",
            "Switch roles and try again!",
        ],
        "tip": "Great listeners can repeat back what they heard, not just wait for their turn.",
    },
    {
        "name": "\U0001FAC2 Comfort Corner Role-Play",
        "objective": "Practice comforting a friend who is upset.",
        "materials": ["None"],
        "steps": [
            "One player pretends to feel sad about something small, like losing a game.",
            "Another player practices comforting them with kind words or a listening ear.",
            "Switch roles so everyone practices comforting and being comforted.",
            "Talk about which kind words felt the most helpful.",
        ],
        "tip": "Sometimes just being there for a friend is the most helpful thing.",
    },
    {
        "name": "\U0001F3AF Feelings Bullseye",
        "objective": "Practice rating how big a feeling is on a simple scale.",
        "materials": ["Paper and a pencil or crayon (optional)"],
        "steps": [
            "Think of a recent feeling, like being frustrated or excited.",
            "Rate how big it felt: small, medium, or huge.",
            "Think of one thing that helped (or could help) that feeling feel smaller or celebrated.",
            "Share your feeling and idea with a partner if you'd like.",
        ],
        "tip": "Naming the size of a feeling helps you know what to do next.",
    },
    {
        "name": "\U0001F939 Balance the Turn Circle",
        "objective": "Practice sharing a group activity so everyone gets an equal turn.",
        "materials": ["1 soft ball or beanbag"],
        "steps": [
            "Sit in a circle and pass a ball around while saying one idea for a story out loud.",
            "Keep the story going, one sentence per turn, all the way around.",
            "Notice if anyone hasn't had a turn yet, and make sure they do.",
            "See what silly story the whole group created together!",
        ],
        "tip": "Great group work means noticing who hasn't had a turn yet.",
    },
    {
        "name": "\U0001F6AA Walk Away and Try Again",
        "objective": "Practice calmly stepping away from a disagreement before trying to solve it.",
        "materials": ["None"],
        "steps": [
            "Act out a small disagreement, like both wanting to go first.",
            "Practice saying 'I need a minute' and stepping back calmly.",
            "Take a few breaths, then come back together to talk it out.",
            "Agree on a solution once you're both calm.",
        ],
        "tip": "Stepping away for a moment isn't giving up -- it's making room for a better solution.",
    },
    {
        "name": "\U0001F575\uFE0F Feelings Detective Walk",
        "objective": "Practice noticing feelings in others by watching body language.",
        "materials": ["None"],
        "steps": [
            "Walk around the classroom or yard with a partner.",
            "Quietly notice how classmates seem to be feeling from their faces and bodies.",
            "Compare notes with your partner about what you noticed.",
            "Pick one person to check in with and ask how they're really feeling.",
        ],
        "tip": "Checking in with a friend shows you're paying attention to more than just words.",
    },
    {
        "name": "\U0001F3A4 One Mic Rule",
        "objective": "Practice waiting for your turn to speak and giving full attention to whoever is talking.",
        "materials": ["An object to act as a pretend microphone, like a marker or block"],
        "steps": [
            "Sit in a small group and pass around a pretend microphone.",
            "Only the person holding the mic gets to talk.",
            "Everyone else listens without interrupting.",
            "Pass the mic to the next speaker when they're done.",
        ],
        "tip": "Whoever has the mic deserves everyone's full attention.",
    },
    {
        "name": "\U0001F9D7 Trust Walk Trail",
        "objective": "Practice trusting a partner's guidance while navigating with limited sight.",
        "materials": ["A blindfold or closed eyes", "A few soft obstacles (cushions, cones)"],
        "steps": [
            "Set up a few soft obstacles in a small safe area.",
            "One partner closes their eyes while the other gives calm spoken directions to navigate around them.",
            "Switch roles after reaching the end.",
            "Talk about what made you trust (or not trust) your partner's directions.",
        ],
        "tip": "Trust grows when directions are clear, calm, and honest.",
    },
    {
        "name": "\U0001F3B2 Scenario Spinner",
        "objective": "Practice responding kindly and fairly to different social scenarios.",
        "materials": ["A few written scenario cards (or spoken prompts)"],
        "steps": [
            "Take turns picking a scenario, like 'A friend accidentally breaks your toy.'",
            "Act out a kind, fair response with a partner.",
            "The group discusses if the response felt fair and kind.",
            "Try a different scenario and switch roles.",
        ],
        "tip": "Practicing tricky moments ahead of time makes them easier to handle for real.",
    },
    {
        "name": "\U0001F31F Strength Spotlight",
        "objective": "Practice noticing and naming a specific strength in a classmate.",
        "materials": ["None"],
        "steps": [
            "Sit in a circle; each player picks the person to their right.",
            "Say one specific strength you notice in them, like 'You're really patient when we build things.'",
            "The person receiving it says thank you.",
            "Continue until everyone has given and received a spotlight.",
        ],
        "tip": "Specific compliments mean more than general ones like 'you're nice.'",
    },
]


GAMES[3] = [
    {
        "name": "\U0001F3AD Silent Feelings Freeze",
        "objective": "Practice recognizing feelings from body language without any words or sounds.",
        "materials": ["None"],
        "steps": [
            "One player silently poses their whole body to show a feeling.",
            "Everyone else studies the pose and quietly whispers their guess to a neighbor.",
            "Reveal the feeling and compare guesses.",
            "Take turns being the silent poser.",
        ],
        "tip": "Bodies can 'speak' feelings just as clearly as words can.",
    },
    {
        "name": "\U0001F30A Wave Breathing Buddy",
        "objective": "Practice syncing calm breathing with a partner to settle down together.",
        "materials": ["None"],
        "steps": [
            "Sit back-to-back with a partner.",
            "Breathe in slowly together, feeling each other's backs rise.",
            "Breathe out slowly together, like a gentle wave rolling out.",
            "Repeat for 5 breaths and notice how calm feels when you share it.",
        ],
        "tip": "Calm can be contagious -- breathing together helps both people settle.",
    },
    {
        "name": "\U0001F3D7\uFE0F Blindfolded Builders",
        "objective": "Practice giving and following clear instructions to build something as a team.",
        "materials": ["Building blocks or cups", "A blindfold or closed eyes"],
        "steps": [
            "One partner closes their eyes; the other can see the blocks.",
            "The seeing partner gives step-by-step spoken directions to build a small tower.",
            "The blindfolded partner follows only the words, not any hints.",
            "Open your eyes together and see how close you got!",
        ],
        "tip": "Clear, patient directions make teamwork possible even without seeing.",
    },
    {
        "name": "\U0001F9EE Two Sides, One Solution",
        "objective": "Practice hearing both sides of a disagreement before deciding on a fair solution.",
        "materials": ["None"],
        "steps": [
            "Act out a disagreement, like two friends both wanting to pick the game.",
            "Each side calmly explains their reason without interrupting the other.",
            "A third player (or the pair together) suggests a compromise.",
            "Try the compromise and check if it feels fair to both sides.",
        ],
        "tip": "Understanding both sides of a story is the first step to a fair fix.",
    },
    {
        "name": "\U0001F399\uFE0F Echo Listening Circle",
        "objective": "Practice active listening by restating what a speaker says in your own words.",
        "materials": ["None"],
        "steps": [
            "Sit in a circle; one player shares a short thought or opinion.",
            "The next player repeats it back in their own words before sharing their own thought.",
            "Continue around the circle, each person echoing before adding something new.",
            "Talk about how it felt to be really heard.",
        ],
        "tip": "Repeating back what you heard shows a friend you were truly listening.",
    },
    {
        "name": "\U0001F917 Comfort Coach",
        "objective": "Practice offering specific, helpful comfort instead of just saying 'it's okay.'",
        "materials": ["None"],
        "steps": [
            "One partner acts out a real-feeling problem, like being left out of a game.",
            "The other partner practices asking a caring question, like 'What happened?', before offering comfort.",
            "Offer one specific helpful idea, not just 'don't worry about it.'",
            "Switch roles and try a different scenario.",
        ],
        "tip": "Specific, curious comfort helps more than a quick 'it's fine.'",
    },
    {
        "name": "\U0001F321\uFE0F Feelings Thermometer Check",
        "objective": "Practice rating and describing feeling intensity using a thermometer scale.",
        "materials": ["Paper and pencil (optional)"],
        "steps": [
            "Draw or picture a thermometer from 1 (very calm) to 5 (very big feeling).",
            "Think of a recent moment and mark where your feeling landed.",
            "Think of one strategy that could help move a hot feeling down a notch.",
            "Share your thermometer reading with a partner if you want to.",
        ],
        "tip": "Naming exactly how big a feeling is makes it easier to manage.",
    },
    {
        "name": "\U0001F9ED Group Compass Decision",
        "objective": "Practice making a group decision where everyone's voice counts.",
        "materials": ["None (or paper for voting)"],
        "steps": [
            "Present the group with a simple choice, like which game to play next.",
            "Each person shares their pick and one reason why.",
            "Vote or find a compromise that includes as many preferences as possible.",
            "Reflect together on whether everyone felt heard, even if they didn't 'win.'",
        ],
        "tip": "A good group decision makes everyone feel considered, not just outvoted.",
    },
    {
        "name": "\U0001F6D1 Cool-Off Corner Practice",
        "objective": "Practice recognizing when to take a break during a conflict and how to return calmly.",
        "materials": ["None"],
        "steps": [
            "Act out getting frustrated in a small disagreement.",
            "Practice saying 'I need a cool-off minute' and stepping to a calm spot.",
            "Use a calming strategy, like breathing or counting, for one minute.",
            "Return and finish the conversation calmly.",
        ],
        "tip": "Taking a break isn't avoiding the problem -- it's preparing to solve it well.",
    },
    {
        "name": "\U0001F575\uFE0F Feelings Clue Hunt",
        "objective": "Practice picking up on subtle clues about how someone feels.",
        "materials": ["None"],
        "steps": [
            "One player thinks of a feeling but doesn't say it out loud.",
            "They give three subtle clues using tone of voice, posture, and gestures, no naming the feeling.",
            "The group tries to guess the feeling from the clues.",
            "Talk about which clue was the easiest or hardest to read.",
        ],
        "tip": "Tone and body language often say more than the words themselves.",
    },
    {
        "name": "\U0001F3A4 No Interrupting Challenge",
        "objective": "Practice letting a speaker finish completely before responding.",
        "materials": ["A timer (phone or watch, optional)"],
        "steps": [
            "Take turns sharing a short story or opinion for up to one minute.",
            "Everyone else practices waiting silently until the speaker is fully done.",
            "After each turn, the next speaker can respond or ask a question.",
            "Talk about how it felt to not be interrupted.",
        ],
        "tip": "Waiting for a full stop before jumping in shows real respect for what someone's saying.",
    },
    {
        "name": "\U0001F9D7 Trust Walk Obstacle Trail",
        "objective": "Practice trusting a partner's guidance while navigating with limited sight.",
        "materials": ["A blindfold or closed eyes", "A few soft obstacles (cushions, cones)"],
        "steps": [
            "Set up several soft obstacles in a safe area.",
            "One partner closes their eyes while the other gives calm spoken directions to navigate around them.",
            "Switch roles after reaching the end.",
            "Talk about what made you trust, or not trust, your partner's directions.",
        ],
        "tip": "Trust grows when directions are clear, calm, and honest.",
    },
    {
        "name": "\U0001F3B2 Scenario Spinner Showdown",
        "objective": "Practice responding kindly and fairly to different tricky social scenarios.",
        "materials": ["A few written scenario cards (or spoken prompts)"],
        "steps": [
            "Take turns picking a scenario, like 'A friend accidentally breaks your favorite pencil.'",
            "Act out a kind, fair response with a partner.",
            "The group discusses whether the response felt fair and kind.",
            "Try a different scenario and switch roles.",
        ],
        "tip": "Practicing tricky moments ahead of time makes them easier to handle for real.",
    },
    {
        "name": "\U0001F31F Strength Spotlight Circle",
        "objective": "Practice noticing and naming a specific strength in a classmate.",
        "materials": ["None"],
        "steps": [
            "Sit in a circle; each player picks the person to their right.",
            "Say one specific strength you notice in them, like 'You explain things really clearly.'",
            "The person receiving it says thank you.",
            "Continue until everyone has given and received a spotlight.",
        ],
        "tip": "Specific compliments mean more than general ones like 'you're nice.'",
    },
]


GAMES[4] = [
    {
        "name": "\U0001F3AD Emotion Layers Charades",
        "objective": "Practice recognizing that people can feel more than one emotion at once.",
        "materials": ["Index cards with two-feeling combos, like 'excited but nervous'"],
        "steps": [
            "Pick a card with two feelings combined, like 'happy but embarrassed.'",
            "Act out both feelings blending together using face and body.",
            "The group guesses both feelings.",
            "Discuss a real situation where you might feel two things at once.",
        ],
        "tip": "It's normal to feel more than one thing at the same time.",
    },
    {
        "name": "\U0001F300 Reset Routine Design",
        "objective": "Practice designing a personal calm-down routine that actually works for you.",
        "materials": ["Paper and pencil"],
        "steps": [
            "List 3 things that usually help you calm down, like breathing, movement, or quiet time.",
            "Put them in order to create your own reset routine.",
            "Test your routine by imagining a frustrating moment and walking through the steps.",
            "Share your routine with a partner and compare ideas.",
        ],
        "tip": "A calm-down plan works best when you build it before you need it.",
    },
    {
        "name": "\U0001F3DD\uFE0F Deserted Island Debate",
        "objective": "Practice negotiating and compromising when a group has limited resources to share.",
        "materials": ["5-6 small item cards, like rope, blanket, flashlight"],
        "steps": [
            "As a stranded group, you can only keep 3 of the 5-6 items.",
            "Each person argues for which items matter most and why.",
            "Negotiate together until the group agrees on the final 3.",
            "Reflect on how the group reached agreement -- voting, trading, or compromise.",
        ],
        "tip": "Good negotiation means really listening to reasons, not just repeating your own.",
    },
    {
        "name": "\U0001F3A7 Interview Swap",
        "objective": "Practice deep listening by interviewing a partner and then introducing them accurately.",
        "materials": ["None (paper optional for notes)"],
        "steps": [
            "Interview a partner for 2 minutes about something they care about.",
            "Listen closely and remember a few key details.",
            "Introduce your partner to the group using only what you remember.",
            "Partner corrects or confirms anything you got right or missed.",
        ],
        "tip": "The best interviewers remember details because they're truly listening, not just waiting to talk.",
    },
    {
        "name": "\u2696\uFE0F Mediator for a Minute",
        "objective": "Practice acting as a neutral mediator to help two people solve a disagreement.",
        "materials": ["None"],
        "steps": [
            "Two players act out a realistic disagreement, like disagreeing on project roles.",
            "A third player acts as mediator, asking each side to explain their view calmly.",
            "The mediator helps both sides find common ground.",
            "Rotate roles so everyone practices being the mediator.",
        ],
        "tip": "A good mediator doesn't take sides -- they help both sides be heard.",
    },
    {
        "name": "\U0001F526 Spotlight on Empathy",
        "objective": "Practice imagining a situation from someone else's point of view.",
        "materials": ["A few scenario prompts"],
        "steps": [
            "Read a scenario, like 'A new student doesn't know anyone at lunch.'",
            "Each person shares what they think that person might be feeling and needing.",
            "Brainstorm together one specific way to help.",
            "Talk about a time someone made you feel welcomed like that.",
        ],
        "tip": "Imagining someone else's perspective is the first step toward real empathy.",
    },
    {
        "name": "\U0001F9E9 Silent Sculpture Build",
        "objective": "Practice nonverbal teamwork and reading group cues without talking.",
        "materials": ["Building blocks, craft sticks, or similar materials"],
        "steps": [
            "As a group, agree to build something together without talking at all.",
            "Use gestures and pointing only to communicate ideas.",
            "Build for 5 minutes, then reveal and discuss what you made.",
            "Talk about how it felt to work as a team without words.",
        ],
        "tip": "Teamwork often relies on more than just talking -- watching each other matters too.",
    },
    {
        "name": "\U0001F3AF Feeling Roots Investigation",
        "objective": "Practice tracing a strong feeling back to its real cause.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Think of a recent strong feeling, like frustration or excitement.",
            "Ask yourself 'why' three times in a row to dig past the surface reason.",
            "Write down what you discover about the real root of the feeling.",
            "Share your discovery with a partner if you'd like.",
        ],
        "tip": "The first reason for a feeling isn't always the real one -- digging deeper helps.",
    },
    {
        "name": "\U0001F5F3\uFE0F Fair Vote Council",
        "objective": "Practice running a fair group decision process that respects the minority opinion.",
        "materials": ["Paper for voting (optional)"],
        "steps": [
            "Present a group choice with at least 3 options.",
            "Discuss pros and cons of each option together.",
            "Vote, and if it's not unanimous, discuss how to make the outcome still feel fair to everyone.",
            "Reflect on what made the process feel fair (or not).",
        ],
        "tip": "A fair process matters just as much as a fair outcome.",
    },
    {
        "name": "\U0001F570\uFE0F Perspective Time Machine",
        "objective": "Practice retelling a conflict from the other person's point of view.",
        "materials": ["None"],
        "steps": [
            "Think of a recent small disagreement you had with someone.",
            "Retell the story out loud, but from the other person's perspective.",
            "A partner listens and asks a clarifying question.",
            "Talk about what you noticed seeing it from their side.",
        ],
        "tip": "Telling a story from someone else's view often changes how you feel about it.",
    },
    {
        "name": "\U0001F399\uFE0F Talking Stick Debate",
        "objective": "Practice listening fully to an opposing opinion before responding.",
        "materials": ["An object to use as a talking stick"],
        "steps": [
            "Pick a light debate topic, like 'Is recess or lunch more important?'",
            "Only the person holding the talking stick may speak.",
            "Before responding, you must first summarize what the last speaker said.",
            "Pass the stick and continue the respectful debate.",
        ],
        "tip": "Understanding an opinion doesn't mean you have to agree with it.",
    },
    {
        "name": "\U0001F9D8 Body Scan Reset",
        "objective": "Practice noticing tension in the body and releasing it on purpose.",
        "materials": ["None"],
        "steps": [
            "Stand or sit still and slowly notice each body part from head to toe.",
            "Tense each muscle group for 3 seconds, then release it completely.",
            "Move through shoulders, hands, legs, and feet.",
            "Notice how your whole body feels different at the end.",
        ],
        "tip": "Your body often holds onto stress before your mind even notices it.",
    },
    {
        "name": "\U0001F3AD Conflict Rewrite",
        "objective": "Practice rewriting how a disagreement plays out to reach a better ending.",
        "materials": ["None"],
        "steps": [
            "Act out a common conflict scenario the way it usually goes wrong, like yelling or walking away angry.",
            "Pause and discuss what could have gone better.",
            "Act out the same scenario again, using better choices this time.",
            "Compare how the two versions felt different.",
        ],
        "tip": "You can always choose to 'rewrite' how a hard moment goes.",
    },
    {
        "name": "\U0001F309 Bridge the Difference",
        "objective": "Practice finding common ground between people with different opinions or interests.",
        "materials": ["None"],
        "steps": [
            "Split into pairs with different favorite hobbies or interests.",
            "Each partner shares what they love about their interest.",
            "Together, find one surprising thing your two interests have in common.",
            "Share your bridge discovery with the group.",
        ],
        "tip": "Even very different interests usually share something in common if you look closely.",
    },
]


GAMES[5] = [
    {
        "name": "\U0001F3AD Micro-Expression Match",
        "objective": "Practice reading quick, subtle facial expressions to identify feelings.",
        "materials": ["None"],
        "steps": [
            "One player flashes a quick facial expression for just 2 seconds, then returns to neutral.",
            "Others try to name the feeling they caught.",
            "Discuss what specific facial clues gave it away, like eyebrows, mouth, or eyes.",
            "Take turns flashing different expressions.",
        ],
        "tip": "Feelings often flash across a face quickly -- paying close attention helps you catch them.",
    },
    {
        "name": "\U0001F50B Feelings Battery Check",
        "objective": "Practice checking in on your own emotional energy level throughout the day.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Draw a battery icon and rate your current emotional energy from empty to full.",
            "Write one reason for your current level.",
            "List one small action that could help recharge if you're running low.",
            "Check your battery again later and notice if it changed.",
        ],
        "tip": "Just like a phone, it's okay to notice when your emotional battery needs a recharge.",
    },
    {
        "name": "\U0001F3DB\uFE0F Classroom Constitution",
        "objective": "Practice negotiating group rules that everyone agrees to follow.",
        "materials": ["Paper and pencil"],
        "steps": [
            "As a group, brainstorm 3-5 rules for how you'll work together on a project.",
            "Discuss and adjust any rule someone disagrees with until the group finds wording everyone accepts.",
            "Write the final agreed rules down.",
            "Sign or initial the list to show your commitment.",
        ],
        "tip": "Rules everyone helped write are rules everyone is more likely to follow.",
    },
    {
        "name": "\U0001F3A7 Three-Question Interview",
        "objective": "Practice asking thoughtful follow-up questions instead of just waiting for your turn to talk.",
        "materials": ["None (paper optional for notes)"],
        "steps": [
            "Partner A shares something about their week for one minute.",
            "Partner B asks three follow-up questions based on what they actually heard.",
            "Switch roles and repeat.",
            "Talk about which follow-up question felt the most thoughtful.",
        ],
        "tip": "Great follow-up questions prove you were really listening, not just waiting.",
    },
    {
        "name": "\u2694\uFE0F Debate and Bridge",
        "objective": "Practice arguing a position respectfully, then finding common ground with the opposing side.",
        "materials": ["A simple debate topic"],
        "steps": [
            "Split into two small groups, each defending a different side of a light topic.",
            "Each side presents their strongest point calmly.",
            "After both sides speak, work together to find one point you actually agree on.",
            "Reflect on how it felt to disagree respectfully.",
        ],
        "tip": "You can disagree strongly with an idea and still respect the person holding it.",
    },
    {
        "name": "\U0001FA9E Empathy Mirror Interview",
        "objective": "Practice imagining and voicing another person's likely feelings in a real situation.",
        "materials": ["A scenario prompt"],
        "steps": [
            "Read a scenario about someone facing a challenge, like missing a big goal or being new.",
            "Take turns 'becoming' that person and answering questions in first person as if you were them.",
            "Your partner asks questions, like 'How did that make you feel?'",
            "Switch and reflect on what was easy or hard to imagine.",
        ],
        "tip": "Speaking as if you were someone else helps you understand feelings you haven't had yourself.",
    },
    {
        "name": "\U0001F9E0 Team Strategy Puzzle",
        "objective": "Practice dividing tasks and combining strengths to solve a puzzle faster as a team.",
        "materials": ["A jigsaw puzzle, riddle set, or logic puzzle"],
        "steps": [
            "Look over the challenge together and decide how to split up the work.",
            "Assign roles based on what each person feels good at.",
            "Work your section, then combine results as a team.",
            "Discuss what strategy worked well and what you'd change next time.",
        ],
        "tip": "Good teams don't just work hard -- they work smart by using everyone's strengths.",
    },
    {
        "name": "\U0001F321\uFE0F Escalation Ladder",
        "objective": "Practice recognizing the early warning signs before a feeling becomes too big to manage.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Draw a ladder with 5 rungs from 'totally calm' to 'completely overwhelmed.'",
            "Write what your body and mind feel like at each rung, like clenched fists at rung 4.",
            "Circle which rung you usually notice and step in to use a calming strategy.",
            "Share your ladder with a partner and compare warning signs.",
        ],
        "tip": "Catching a feeling on a low rung makes it much easier to manage.",
    },
    {
        "name": "\U0001F54A\uFE0F Peace Treaty Draft",
        "objective": "Practice writing out a fair agreement to resolve a repeated disagreement.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Think of a disagreement that keeps happening, like whose turn it is or sharing space.",
            "Each person writes down what they need to feel it's fair.",
            "Together, draft a simple written agreement both people can accept.",
            "Both sign the treaty and agree to try it for a week.",
        ],
        "tip": "Putting an agreement in writing helps everyone remember and stick to it.",
    },
    {
        "name": "\U0001F50D Assumption Check",
        "objective": "Practice noticing when you've assumed a reason for someone's behavior, and checking if it's true.",
        "materials": ["A few short scenario prompts"],
        "steps": [
            "Read a scenario, like 'A classmate didn't say hi to you this morning.'",
            "Write down your first assumption about why.",
            "Brainstorm at least two other possible reasons that have nothing to do with you.",
            "Discuss how checking assumptions changes how you might react.",
        ],
        "tip": "Our first guess about someone's behavior isn't always the true story.",
    },
    {
        "name": "\U0001F3A4 Panel Discussion Practice",
        "objective": "Practice listening to multiple viewpoints in a group discussion without dominating.",
        "materials": ["A discussion topic"],
        "steps": [
            "Sit as a panel with one topic to discuss.",
            "Each person gets an equal turn to share their view uninterrupted.",
            "After everyone has spoken once, open it up for respectful back-and-forth.",
            "Reflect on whether everyone got roughly equal airtime.",
        ],
        "tip": "A great discussion leaves room for every voice, not just the loudest one.",
    },
    {
        "name": "\U0001F9D8 Reset and Refocus Routine",
        "objective": "Practice a quick physical routine to refocus attention after a frustrating moment.",
        "materials": ["None"],
        "steps": [
            "Stand and shake out your hands and arms for 10 seconds.",
            "Take 3 slow, deep breaths while rolling your shoulders back.",
            "Name one thing you can see, hear, and feel right now.",
            "Set one small, doable next step to refocus on.",
        ],
        "tip": "A short physical reset can clear space for clearer thinking.",
    },
    {
        "name": "\U0001F3AD Scenario Swap Court",
        "objective": "Practice arguing both sides of a disagreement to better understand each perspective.",
        "materials": ["A scenario prompt"],
        "steps": [
            "Pick a common disagreement scenario as a group.",
            "Assign each pair to argue for the side they don't actually agree with.",
            "Present your assigned side's best argument to the group.",
            "Discuss how arguing the other side changed your understanding.",
        ],
        "tip": "Understanding the other side's argument doesn't mean you have to agree with it.",
    },
    {
        "name": "\U0001F331 Growth Mindset Circle",
        "objective": "Practice supporting a teammate through a setback with encouraging, specific feedback.",
        "materials": ["None"],
        "steps": [
            "Each person shares a recent challenge or setback, big or small.",
            "The group responds with specific encouragement, not just 'good job' or 'don't worry.'",
            "The person shares one thing they'll try differently next time.",
            "Close by each person naming one strength they see in the sharer.",
        ],
        "tip": "Real support sounds specific, not just reassuring.",
    },
]


GAMES[6] = [
    {
        "name": "\U0001F3AD Emotional Layers Debrief",
        "objective": "Practice unpacking a complex situation involving mixed or conflicting feelings.",
        "materials": ["A written scenario, like 'excited to move but sad to leave friends'"],
        "steps": [
            "Read a scenario with mixed feelings out loud.",
            "Discuss all the different feelings someone in that situation might have.",
            "Debate which feeling might be strongest and why, without needing to fully agree.",
            "Reflect together: has anyone felt something similarly mixed before?",
        ],
        "tip": "Complicated situations often come with complicated, mixed feelings -- and that's normal.",
    },
    {
        "name": "\U0001F527 Personal Toolkit Build",
        "objective": "Practice building and evaluating a personalized set of strategies for handling stress.",
        "materials": ["Paper and pencil"],
        "steps": [
            "List every calming or refocusing strategy you can think of, even ones you haven't tried.",
            "Sort them into categories: physical, mental, and social strategies.",
            "Circle your top 3 go-to tools and explain why each works for you.",
            "Share your toolkit with a partner and trade one new idea.",
        ],
        "tip": "Having more than one tool matters, because different situations call for different strategies.",
    },
    {
        "name": "\U0001F3D9\uFE0F City Council Simulation",
        "objective": "Practice negotiating a group decision where different roles have different priorities.",
        "materials": ["Simple role cards, like 'wants more parks' or 'wants a new library'"],
        "steps": [
            "Each person plays a role with a specific priority for a made-up town decision.",
            "Present your role's case to the group, then listen to the others.",
            "Negotiate a compromise plan that addresses as many priorities as possible.",
            "Debrief: what made the negotiation easier or harder?",
        ],
        "tip": "Real negotiation means understanding what actually matters to each side, not just their opening position.",
    },
    {
        "name": "\U0001F3A7 Active Listening Audit",
        "objective": "Practice noticing and correcting your own listening habits during a real conversation.",
        "materials": ["None"],
        "steps": [
            "Have a 3-minute conversation with a partner about a topic you both care about.",
            "Partner rates you afterward on eye contact, follow-up questions, and not interrupting.",
            "Switch roles and repeat.",
            "Discuss one specific listening habit each of you wants to improve.",
        ],
        "tip": "Even good listeners can always find one habit worth sharpening.",
    },
    {
        "name": "\u2696\uFE0F Both Sides Now",
        "objective": "Practice fully understanding an opposing viewpoint before forming your own conclusion.",
        "materials": ["A debatable, age-appropriate topic"],
        "steps": [
            "Split into two groups defending opposite sides of a topic.",
            "Each side brainstorms their strongest 2-3 points.",
            "After presenting, each side must summarize the other side's argument accurately.",
            "Discuss as a whole group whether anyone's opinion shifted, even slightly.",
        ],
        "tip": "You haven't really heard an argument until you can explain it back accurately.",
    },
    {
        "name": "\U0001FA9F Window and Mirror",
        "objective": "Practice recognizing when a story is a window into someone else's experience versus a mirror of your own.",
        "materials": ["A few short scenario cards or stories"],
        "steps": [
            "Read a short story or scenario about someone different from you.",
            "Decide if it feels like a window, learning about a new experience, or a mirror, reflecting your own experience.",
            "Discuss what you can learn from a window story even if it's not your own experience.",
            "Share a personal example of a time a story helped you understand someone else.",
        ],
        "tip": "Learning from someone else's story is a powerful form of empathy.",
    },
    {
        "name": "\U0001F9E0 Divide and Conquer Challenge",
        "objective": "Practice organizing a team by strengths under real time pressure.",
        "materials": ["A multi-step group challenge or puzzle with a timer"],
        "steps": [
            "Look at the full challenge together and identify the different types of tasks involved.",
            "Quickly assign roles based on each person's strengths and interests.",
            "Work in parallel, checking in briefly at set intervals.",
            "Debrief on what organizing strategy worked best under time pressure.",
        ],
        "tip": "Fast teamwork depends on clear roles agreed on up front, not figuring it out as you go.",
    },
    {
        "name": "\U0001F4CA Feeling Trends Journal",
        "objective": "Practice noticing patterns in what triggers strong feelings over time.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Think back over the last week and jot down 2-3 moments with strong feelings.",
            "Look for a pattern: same time of day, same type of situation, same people?",
            "Write one insight about a trigger you noticed.",
            "Write one strategy to try the next time that trigger comes up.",
        ],
        "tip": "Noticing your own patterns is one of the most useful emotional skills you can build.",
    },
    {
        "name": "\U0001F91D Repair the Friendship",
        "objective": "Practice the steps of a genuine apology and repair after a real conflict.",
        "materials": ["None"],
        "steps": [
            "Act out a realistic falling-out between friends, like feeling excluded or a broken promise.",
            "The player who caused hurt practices a genuine apology: naming what happened, how it affected the other person, and what they'll do differently.",
            "The other player practices accepting the apology honestly, including saying if they need more time.",
            "Discuss what makes an apology feel real versus empty.",
        ],
        "tip": "A real apology names the specific hurt -- a vague 'sorry' often doesn't land the same way.",
    },
    {
        "name": "\U0001F526 Perspective Panel",
        "objective": "Practice considering a situation from three or more different people's perspectives at once.",
        "materials": ["A scenario involving multiple people, like a group project conflict"],
        "steps": [
            "Read a scenario involving at least 3 people with different roles.",
            "Assign each person in your group a character to represent.",
            "Each character explains the situation from their own point of view.",
            "Discuss together what a fair resolution would look like, considering everyone's perspective.",
        ],
        "tip": "The fairest solutions usually come from considering more than two points of view.",
    },
    {
        "name": "\U0001F399\uFE0F Steelman Challenge",
        "objective": "Practice restating an opposing opinion in its strongest, most fair form before responding.",
        "materials": ["A light debate topic"],
        "steps": [
            "Pick a topic where people in the group have different opinions.",
            "Before disagreeing, each person must restate the other's opinion in its strongest possible form.",
            "The original speaker confirms if the restatement was fair and accurate.",
            "Only then does the listener share their own view.",
        ],
        "tip": "Arguing against the strongest version of an idea, not a weak one, leads to better conversations.",
    },
    {
        "name": "\U0001F9D8 Focus Reset Protocol",
        "objective": "Practice a multi-step routine to reset focus and emotional state after a disruption.",
        "materials": ["None"],
        "steps": [
            "Pause and name the feeling you're currently experiencing, out loud or in your head.",
            "Take 4 slow breaths, counting each one.",
            "Physically change your position or location slightly, like standing up or turning around.",
            "Set one clear, small intention for what you'll focus on next.",
        ],
        "tip": "A reset routine works best when it's the same steps every time, so your body learns to recognize it.",
    },
    {
        "name": "\U0001F3DB\uFE0F Mock Mediation Session",
        "objective": "Practice running a structured mediation between two people in conflict.",
        "materials": ["None"],
        "steps": [
            "Two players act out a realistic conflict, like broken trust or an unfair group work split.",
            "A third player mediates: each side speaks uninterrupted, the mediator summarizes both views, then the group brainstorms solutions together.",
            "The two sides pick a solution they can both accept.",
            "Debrief on what made the mediation process fair.",
        ],
        "tip": "A structured process helps take the heat out of a hard conversation.",
    },
    {
        "name": "\U0001F30D Global Empathy Exchange",
        "objective": "Practice imagining life circumstances very different from your own with curiosity instead of judgment.",
        "materials": ["A few short scenario descriptions of different life circumstances"],
        "steps": [
            "Read a short description of someone living in very different circumstances than you.",
            "Discuss what might be the same about their feelings and needs, despite different circumstances.",
            "Discuss what questions you'd want to ask them if you could.",
            "Reflect on one assumption you had to set aside to really imagine their perspective.",
        ],
        "tip": "Curiosity about someone different from you is the doorway to real empathy.",
    },
]


GAMES[7] = [
    {
        "name": "\U0001F3AD Emotional Contradiction Circle",
        "objective": "Practice sitting with and discussing feelings that seem to contradict each other.",
        "materials": ["None"],
        "steps": [
            "Each person shares a time they felt two contradictory things at once, like relieved but guilty, or proud but embarrassed.",
            "The group discusses why both feelings can be true at the same time.",
            "Talk about whether one feeling needs to 'win,' or if they can both just exist.",
            "Close by sharing one insight from the discussion.",
        ],
        "tip": "Contradictory feelings aren't a sign something's wrong -- they're a sign a situation is complex.",
    },
    {
        "name": "\U0001F9ED Values Compass Mapping",
        "objective": "Practice connecting emotional reactions to underlying personal values.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Think of a recent moment you felt strongly about something, like frustrated, proud, or hurt.",
            "Ask yourself what value was involved, like fairness, honesty, or loyalty.",
            "Write down the connection between the feeling and the value.",
            "Discuss with a partner how knowing your values helps you understand your reactions.",
        ],
        "tip": "Strong feelings are often values speaking up -- figuring out which one helps you respond wisely.",
    },
    {
        "name": "\U0001F3DB\uFE0F Stakeholder Roundtable",
        "objective": "Practice negotiating a decision where multiple stakeholders have competing legitimate interests.",
        "materials": ["Role cards describing different stakeholder priorities"],
        "steps": [
            "Assign each person a stakeholder role with a legitimate but different priority, like planning a class event with budget, fun, and inclusivity concerns.",
            "Each stakeholder presents their priority and why it matters.",
            "Negotiate together toward a plan that reasonably addresses multiple priorities.",
            "Debrief on which priorities were hardest to balance and why.",
        ],
        "tip": "Most real decisions involve balancing several valid interests, not picking one right answer.",
    },
    {
        "name": "\U0001F3A7 Listening for What's Not Said",
        "objective": "Practice noticing unspoken feelings or needs behind what someone says out loud.",
        "materials": ["A few scenario prompts with subtext"],
        "steps": [
            "Read a short scripted line that hints at an unspoken feeling, like 'It's fine, I guess I just won't go.'",
            "Discuss what feeling or need might be behind the words.",
            "Practice responding to the unspoken feeling, not just the literal words.",
            "Switch roles and try a new line.",
        ],
        "tip": "Sometimes the most important thing in a conversation is what wasn't directly said.",
    },
    {
        "name": "\u2696\uFE0F Ethics Roundtable",
        "objective": "Practice discussing a values-based disagreement respectfully without needing full agreement.",
        "materials": ["An age-appropriate ethical dilemma prompt"],
        "steps": [
            "Present a values-based dilemma, like 'Should you tell an adult that a friend is struggling and hiding it?'",
            "Each person shares their view and reasoning.",
            "Practice responding to a differing view with 'I see it differently because...' instead of dismissing it.",
            "Reflect on whether the group needs to agree, or can respectfully hold different views.",
        ],
        "tip": "Respecting a different opinion doesn't mean you have to adopt it -- it means hearing it fully.",
    },
    {
        "name": "\U0001FA9E Reverse Interview",
        "objective": "Practice deeply understanding someone's perspective by interviewing them as if writing their life story.",
        "materials": ["None"],
        "steps": [
            "Interview a partner about a challenge they've faced and how they felt through it.",
            "Ask open, curious follow-up questions rather than jumping to advice.",
            "Summarize their story back to them in your own words.",
            "Partner confirms if you captured their experience accurately.",
        ],
        "tip": "Deep empathy starts with curiosity, not with trying to fix or relate everything back to yourself.",
    },
    {
        "name": "\U0001F9E0 Cross-Functional Team Challenge",
        "objective": "Practice coordinating a team where members have different skills and must combine them under a deadline.",
        "materials": ["A multi-part team challenge, like building, puzzle, or planning, with a timer"],
        "steps": [
            "Review the challenge and identify what types of thinking or skills it requires.",
            "Assign roles that play to strengths, and agree on check-in points.",
            "Complete the challenge, adjusting roles if something isn't working.",
            "Debrief on what communication strategies kept the team coordinated.",
        ],
        "tip": "The strongest teams adjust their plan when something isn't working, instead of sticking to it out of habit.",
    },
    {
        "name": "\U0001F4C8 Trigger Pattern Analysis",
        "objective": "Practice analyzing personal emotional patterns to identify proactive strategies.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Reflect on the last month and identify a recurring emotional trigger.",
            "Analyze what typically happens right before, during, and after that trigger.",
            "Identify one point in that pattern where a different choice could change the outcome.",
            "Write a specific, realistic plan to try that different choice next time.",
        ],
        "tip": "You can't change a pattern you haven't noticed yet -- awareness is the first real step.",
    },
    {
        "name": "\U0001F91D Full-Circle Apology Practice",
        "objective": "Practice giving and receiving a complete apology that addresses impact, not just intent.",
        "materials": ["None"],
        "steps": [
            "Act out a realistic conflict where intent and impact were different, like a joke that unintentionally hurt someone.",
            "Practice apologizing for the impact even when the intent wasn't to hurt.",
            "The other person practices explaining the impact honestly, without exaggerating or minimizing.",
            "Discuss the difference between 'I'm sorry you felt that way' and 'I'm sorry I did that.'",
        ],
        "tip": "A strong apology owns the impact of an action, not just the good intentions behind it.",
    },
    {
        "name": "\U0001F526 Systems of Perspective",
        "objective": "Practice recognizing how someone's circumstances shape their perspective on a shared situation.",
        "materials": ["A scenario involving people from different circumstances"],
        "steps": [
            "Read a scenario involving people affected differently by the same event.",
            "Discuss how each person's different circumstances might shape how they experience it.",
            "Identify one assumption that might be unfair to make about any of them.",
            "Discuss what a genuinely fair response would look like for everyone involved.",
        ],
        "tip": "The same event can land very differently on different people -- fairness means noticing that.",
    },
    {
        "name": "\U0001F399\uFE0F Devil's Advocate Rotation",
        "objective": "Practice genuinely considering a viewpoint you disagree with by being assigned to argue it.",
        "materials": ["A debatable, age-appropriate topic"],
        "steps": [
            "Pick a topic and have each person state their honest opinion first.",
            "Rotate: everyone must now argue the opposite of their own stated opinion for two minutes.",
            "The group discusses which 'opposite' arguments were more convincing than expected.",
            "Reflect on whether anyone's original opinion shifted even slightly.",
        ],
        "tip": "Arguing a view you disagree with is one of the fastest ways to actually understand it.",
    },
    {
        "name": "\U0001F9D8 Self-Directed Reset Design",
        "objective": "Practice designing and committing to a personal, repeatable strategy for handling a specific stressful pattern.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Identify one recurring stressful situation, like a hard subject or competition nerves.",
            "Design a specific, step-by-step personal plan for handling it better next time.",
            "Share your plan with a partner and get one piece of honest feedback.",
            "Commit to trying your plan the next time that situation comes up.",
        ],
        "tip": "A plan you designed yourself is more likely to work than one someone else handed you.",
    },
    {
        "name": "\U0001F3DB\uFE0F Community Impact Council",
        "objective": "Practice weighing competing community interests to reach a decision that considers the common good.",
        "materials": ["Role cards representing different community perspectives"],
        "steps": [
            "Assign roles representing different community members affected by a shared decision, like a new school policy.",
            "Each role presents their concerns and what they need from the outcome.",
            "As a council, negotiate a decision, explicitly naming any trade-offs made.",
            "Debrief on what 'fair to everyone' actually looked like in practice.",
        ],
        "tip": "Real fairness often means naming trade-offs honestly, not pretending everyone gets everything they want.",
    },
    {
        "name": "\U0001F30D Empathy Beyond Agreement",
        "objective": "Practice extending genuine empathy to someone whose choices or opinions you don't agree with.",
        "materials": ["A scenario involving a character making an understandable but debatable choice"],
        "steps": [
            "Read a scenario where a character makes a choice the group might not agree with, but can understand.",
            "Discuss what pressures or feelings might have led to that choice.",
            "Separate 'I understand why' from 'I agree with what they did.'",
            "Reflect on why it's possible, and useful, to empathize with someone without approving of their choice.",
        ],
        "tip": "You can understand someone's feelings without agreeing with their actions -- both can be true.",
    },
]


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    # Plain ASCII " | " separator -- a non-ASCII middle-dot separator here
    # previously got double-UTF8-encoded somewhere in the sqlcmd/ODBC file-
    # reading pipeline (confirmed live: " \u00b7 " landed in the DB as the
    # literal 4-character sequence " \u00c2\u00b7 "), and a plain comma is
    # ambiguous since several material descriptions already contain commas
    # inside their own parenthetical text (e.g. "(leaf, rock, flower...)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 72_sel_games_content.sql")
    out.append("-- Adds a 'SEL Skill-Building Games' category to the existing always-on")
    out.append("-- 'sel' subject_area for every grade (TK-6th) -- no schema or proc changes")
    out.append("-- needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly")
    out.append("-- as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's sel category")
    out.append("-- is selected, satisfying \"7 games, different set each week\" without any")
    out.append("-- manual per-week authoring. Structurally follows")
    out.append("-- gen_68_outdoor_games_content.py, the proven template for this content type.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print).")
    out.append("-- See gen_72_sel_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'sel' AND category_name = N'SEL Skill-Building Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_sel_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'sel', N'SEL Skill-Building Games', 'space_heavy', 7, N'Play a game that helps you understand feelings and get along with others!', 0);"
        )
        out.append(f"    SET {var} = SCOPE_IDENTITY();")
        for qi, game in enumerate(games, start=1):
            prompt = build_prompt(game)
            diagram_data = {"steps": game["steps"]}
            cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order", "diagram_type", "diagram_data"]
            vals = [var, esc("short_response"), esc(prompt), "NULL", esc(game["tip"]), str(qi),
                    esc("sequence_steps"), esc(json.dumps(diagram_data, ensure_ascii=False))]
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
    for grade_id in GRADE_IDS:
        n = len(GAMES[grade_id])
        if n != 14:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected 14")
            ok = False
        names = [g["name"] for g in GAMES[grade_id]]
        if len(names) != len(set(names)):
            dupes = [n for n in names if names.count(n) > 1]
            print(f"DUPLICATE within grade {GRADE_LABELS[grade_id]}: {set(dupes)}")
            ok = False
        for game in GAMES[grade_id]:
            for key in ("name", "objective", "materials", "steps", "tip"):
                if key not in game or not game[key]:
                    print(f"MISSING '{key}' in grade {GRADE_LABELS[grade_id]} game {game.get('name')}")
                    ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_games = sum(len(v) for v in GAMES.values())
    print(f"Grades: {len(GAMES)}, Total games: {total_games}", file=sys.stderr)
    # newline="" prevents Python's default Windows text-mode translation of
    # "\n" to "\r\n" -- without it, every embedded "\n\n" inside a prompt
    # string (used to separate Name/Objective/Materials) gets written as a
    # literal "\r\n" into the SQL file, which then lands as-is inside the
    # quoted N'...' string literal and gets stored verbatim in the database.
    # This bit the team for real on gen_68 (outdoor games): shipped 112 rows
    # with \r\n before catching it.
    with open(r"D:\Project\www\littlescholarhub\lsh.database\72_sel_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 72_sel_games_content.sql", file=sys.stderr)
