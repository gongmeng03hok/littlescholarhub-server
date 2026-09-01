# -*- coding: utf-8 -*-
"""
Generates lsh.database/70_outdoor_games_no_materials_content.sql — extends
the existing 'Outdoor Games' category with 7 more games per grade (21 -> 28
per grade, 56 new games), every one playable with ZERO materials — just
kids, voices, and open space. Same append-to-existing-category pattern as
69_outdoor_games_household_content.sql (sort_order continuing from 22).

Run with: python gen_migration_70.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🙈 Hide and Seek",
        "objective": "Practice counting and finding hidden friends using only your eyes and ears.",
        "materials": ["None — just kids and a safe space to hide in!"],
        "steps": [
            "One player is the 'Seeker' and closes their eyes, counting to 10.",
            "Everyone else finds a hiding spot.",
            "The Seeker calls 'Ready or not, here I come!' and looks for everyone.",
            "The first person found becomes the next Seeker!",
        ],
        "safety_line": "Only hide in spots a grown-up says are safe and allowed.",
        "image_prompt": "A cheerful illustration showing a child covering their eyes and counting near a tree, while two other children are shown mid-tiptoe sneaking to hide behind a bush and a low fence nearby. Bright sunny yard background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪞 Copy Cat",
        "objective": "Practice careful watching by copying a leader's movements exactly.",
        "materials": ["None — just kids standing face to face!"],
        "steps": [
            "Pair up, facing a partner.",
            "One partner is the 'Leader' and makes slow movements (raising an arm, making a face).",
            "The other partner copies exactly, like a mirror.",
            "Switch roles after a minute!",
        ],
        "safety_line": "Move slowly and gently so your partner can copy safely.",
        "image_prompt": "A playful illustration of two children facing each other, one with an arm raised and a silly face (the leader), the other in the exact same pose like a mirror reflection (the copier). Bright, simple sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦁 Animal Sound Guess",
        "objective": "Practice listening and guessing which animal sound a friend is making.",
        "materials": ["None — just voices!"],
        "steps": [
            "One player thinks of an animal and makes its sound (roar, moo, quack).",
            "Everyone else guesses which animal it is.",
            "Whoever guesses right gets to make the next animal sound.",
            "Keep going through as many animals as you can think of!",
        ],
        "safety_line": "Take turns and listen quietly while someone else is making their sound.",
        "image_prompt": "A fun illustration showing a child cupping their hands like a lion's mane and roaring playfully, while two other children listen with hands cupped to their ears, guessing expressions on their faces. Bright, simple sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚶 Silly Walk Parade",
        "objective": "Practice inventing and following different silly ways of walking.",
        "materials": ["None — just kids and open space to walk in!"],
        "steps": [
            "One player leads the parade with a silly walk (like a robot, a crab, or tiptoes).",
            "Everyone follows behind, copying the silly walk.",
            "After a bit, the leader moves to the back and a new leader starts a new silly walk.",
            "Keep parading with new silly walks!",
        ],
        "safety_line": "Walk in an open space with nothing to trip over.",
        "image_prompt": "A joyful illustration of a line of 4 children walking in a silly parade — the leader doing a robot-arm walk, followed by others copying — winding across a sunny grassy yard. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🦊 What Time Is It, Mr. Fox?",
        "objective": "Practice counting and quick reactions in a classic chasing game.",
        "materials": ["None — just kids and open space!"],
        "steps": [
            "One player is 'Mr. Fox' and stands at one end of the space, back turned.",
            "Everyone else calls out, 'What time is it, Mr. Fox?'",
            "Mr. Fox calls back a number (like '3 o'clock') and everyone takes that many steps toward him.",
            "If Mr. Fox ever calls 'Dinner time!' he turns and chases everyone back to the start line!",
        ],
        "safety_line": "Only take the number of steps called, and stop chasing once someone reaches home base.",
        "image_prompt": "A fun outdoor illustration showing a child standing with their back turned at one end of a grassy field (Mr. Fox), while a group of children take careful steps forward from the far end, counting under their breath. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👍 Thumbs Up, Thumbs Down",
        "objective": "Practice sharing opinions quickly using a simple thumbs signal.",
        "materials": ["None — just thumbs!"],
        "steps": [
            "One player calls out a simple statement ('Ice cream is yummy!').",
            "Everyone shows thumbs up if they agree, thumbs down if they don't, or sideways if they're not sure.",
            "Talk about why people felt differently.",
            "Take turns calling out new statements!",
        ],
        "safety_line": "It's okay for friends to disagree — everyone's thumb answer is welcome.",
        "image_prompt": "A cheerful illustration showing 4 children in a small circle, each holding up a thumb — some pointing up, one pointing down, one sideways — all smiling and looking at each other's answers. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤫 Freeze and Listen",
        "objective": "Practice staying still and noticing quiet sounds around you.",
        "materials": ["None — just quiet ears!"],
        "steps": [
            "Everyone freezes completely still and closes their eyes.",
            "Listen quietly for 30 seconds, noticing every sound you can hear.",
            "Open your eyes and take turns sharing one sound you heard.",
            "Try again in a different spot — did you hear something new?",
        ],
        "safety_line": "Stand somewhere safe and steady before closing your eyes.",
        "image_prompt": "A peaceful illustration of 3 children standing very still with their eyes closed on a grassy lawn, hands slightly cupped near their ears, calm listening expressions. Small sound-wave icons drift from a nearby bird and rustling leaves. Warm, quiet, flat children's-book illustration style, no text.",
    },
]


GAMES[1] = [
    {
        "name": "🙈 Hide and Seek: Team Edition",
        "objective": "Practice teamwork by hiding together in small groups and staying quiet.",
        "materials": ["None — just kids and a safe space!"],
        "steps": [
            "One player is the Seeker and counts to 15 with eyes closed.",
            "Everyone else hides together in pairs or small groups.",
            "Groups must stay together and stay quiet the whole time.",
            "The first group found becomes the new Seekers!",
        ],
        "safety_line": "Only hide in spots a grown-up says are safe and allowed.",
        "image_prompt": "A playful illustration showing a child counting with eyes closed near a fence, while two pairs of children are shown crouched together hiding behind a bush and behind a low wall, holding back giggles. Bright sunny yard background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "✂️ Rock Paper Scissors Tournament",
        "objective": "Practice quick decision-making in a bracket-style rock-paper-scissors competition.",
        "materials": ["None — just hands!"],
        "steps": [
            "Pair up and play rock-paper-scissors — best 2 out of 3 wins the match.",
            "Winners move on to play another winner.",
            "Keep playing until only one champion remains!",
            "Cheer for every match along the way.",
        ],
        "safety_line": "Show your hand signal gently — no fast or forceful arm movements.",
        "image_prompt": "A fun illustration of two children facing each other, both fists out mid-'rock paper scissors' reveal — one showing 'paper' (flat hand), the other 'rock' (closed fist) — with other kids watching and cheering nearby. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪞 Mirror Me",
        "objective": "Practice focus and body control by mirroring a partner's slow movements.",
        "materials": ["None — just kids facing each other!"],
        "steps": [
            "Pair up, standing face to face.",
            "One partner slowly moves their arms, head, or body.",
            "The other partner mirrors every movement exactly, like a reflection.",
            "Switch roles after a minute — no talking allowed while mirroring!",
        ],
        "safety_line": "Move slowly and smoothly so your partner can follow safely.",
        "image_prompt": "A calm illustration of two children facing each other, one slowly raising one arm and tilting their head, the other in the exact mirrored pose, both focused and quiet. Bright simple background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "📞 Whisper Down the Lane",
        "objective": "Practice careful listening and speaking clearly in a message-passing chain.",
        "materials": ["None — just a line of friends!"],
        "steps": [
            "Stand in a line or circle.",
            "The first player whispers a short phrase into the next person's ear.",
            "Each person whispers what they heard to the next, all the way down the line.",
            "The last player says the phrase out loud — compare it to the original!",
        ],
        "safety_line": "Whisper gently and keep a comfortable distance from each other's ears.",
        "image_prompt": "A fun illustration showing a line of 5 children, each whispering into the next person's ear, with small speech-bubble squiggles showing the message passing down the line, and the last child looking surprised at what came out. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🎭 Animal Charades",
        "objective": "Practice acting out and guessing animals without using words.",
        "materials": ["None — just bodies and imagination!"],
        "steps": [
            "One player silently acts out an animal using only movements and sounds are not allowed.",
            "Everyone else guesses which animal it is.",
            "Whoever guesses correctly acts out the next animal.",
            "Keep going through as many animals as you can act out!",
        ],
        "safety_line": "Act out animals safely — no rough movements or bumping into others.",
        "image_prompt": "A playful illustration of a child crouched low, arms bent like an elephant's trunk swinging, acting out an animal silently, while other children watch with thinking, guessing expressions. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏃 Classic Tag",
        "objective": "Practice running, dodging, and quick tagging in the simplest chasing game.",
        "materials": ["None — just kids and open space!"],
        "steps": [
            "One player is 'It.'",
            "'It' chases the others, trying to tag someone.",
            "Whoever gets tagged becomes the new 'It.'",
            "Keep playing and switching who's 'It'!",
        ],
        "safety_line": "Tag gently with an open hand, and play in a wide open space.",
        "image_prompt": "A dynamic illustration of a child reaching out to tag another child who is running away, both mid-motion with speed lines, on a wide open grassy field. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🐍 Follow the Snake",
        "objective": "Practice moving together as a connected group, following a winding leader.",
        "materials": ["None — just a line of friends holding shoulders!"],
        "steps": [
            "Line up, each player placing hands on the shoulders of the person in front.",
            "The front player (the snake's head) leads the line in a winding path.",
            "The whole line must move together without breaking apart.",
            "Switch who leads the snake after a lap!",
        ],
        "safety_line": "Move slowly enough that the whole line can stay connected safely.",
        "image_prompt": "A fun illustration of 5 children in a line, each with hands on the shoulders of the person in front, winding in an S-shaped path across a grassy yard like a snake, all smiling. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[2] = [
    {
        "name": "🥫 Sardines",
        "objective": "Practice sneaking and squeezing together in a reverse hide-and-seek game.",
        "materials": ["None — just kids and a safe space to hide in!"],
        "steps": [
            "One player hides while everyone else counts to 20 with eyes closed.",
            "Everyone splits up to search for the hider.",
            "When you find the hider, quietly squeeze into the hiding spot with them (no telling others!).",
            "The last person still searching alone becomes the next hider!",
        ],
        "safety_line": "Only hide in spots a grown-up allows, and squeeze in gently, not roughly.",
        "image_prompt": "A funny illustration showing a cramped hiding spot (behind a large bush) where 4 children are squeezed together giggling, while one more child approaches searching, not yet realizing everyone is already there. Bright sunny yard background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👍 Thumb War Tournament",
        "objective": "Compete in a friendly thumb-wrestling tournament using only hands.",
        "materials": ["None — just hands!"],
        "steps": [
            "Pair up and lock hands, thumbs up.",
            "Say the countdown together, then try to pin your partner's thumb down.",
            "Best 2 out of 3 wins the match and moves on to face another winner.",
            "Keep playing until a tournament champion is crowned!",
        ],
        "safety_line": "Keep it gentle and fun — no squeezing hands too hard.",
        "image_prompt": "A close-up playful illustration of two children's hands locked together in a thumb-war grip, one thumb pinning the other down, both children smiling with focused, competitive expressions. Bright simple background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "📋 Categories Game",
        "objective": "Practice quick thinking by naming items in a category before time runs out.",
        "materials": ["None — just voices and quick thinking!"],
        "steps": [
            "Pick a category, like 'animals' or 'foods.'",
            "Take turns naming one item in that category without repeating.",
            "If you can't think of one in 5 seconds, you're out for that round!",
            "Pick a new category and play again.",
        ],
        "safety_line": "Be patient and encouraging if a friend needs a little extra time to think.",
        "image_prompt": "A fun illustration of 4 children sitting in a circle on grass, one child mid-speech with a thought bubble showing an animal icon, others waiting their turn with thinking expressions. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🗿 Grandma's Footsteps",
        "objective": "Practice sneaking quietly toward a goal without being caught moving.",
        "materials": ["None — just kids and open space!"],
        "steps": [
            "One player ('Grandma') stands at one end, facing away from the group.",
            "Everyone else starts at the other end, trying to sneak closer.",
            "Grandma can turn around any time — anyone caught moving must go back to start!",
            "First player to tag Grandma without being caught wins and becomes the new Grandma!",
        ],
        "safety_line": "Move carefully and stop instantly when Grandma turns around.",
        "image_prompt": "A suspenseful illustration showing a child standing with back turned at one end of a yard (Grandma), while several children are frozen mid-step in funny off-balance poses partway across the yard, caught in the act of sneaking forward. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🕵️ I Spy",
        "objective": "Practice describing and guessing objects using colors and clues.",
        "materials": ["None — just eyes and voices!"],
        "steps": [
            "One player picks an object they can see and says, 'I spy with my little eye, something that is [color]!'",
            "Everyone else guesses what the object is.",
            "Whoever guesses correctly picks the next object.",
            "Keep playing with new objects and clues!",
        ],
        "safety_line": "Pick objects that are safely visible from where everyone is standing.",
        "image_prompt": "A playful illustration of a child pointing subtly toward a red flower in a garden while saying something, with two other children looking around thoughtfully, scanning the yard for red objects. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦶 Hop and Count",
        "objective": "Practice counting and balance by hopping a set number of times on one foot.",
        "materials": ["None — just kids and open space!"],
        "steps": [
            "Call out a number, like '5.'",
            "Everyone hops on one foot that many times, counting out loud together.",
            "Switch to the other foot and try a new number.",
            "See who can hop the highest number without losing balance!",
        ],
        "safety_line": "Hop on grass or a soft surface in case you lose your balance.",
        "image_prompt": "A cheerful illustration of 3 children hopping on one foot on grass, mouths open mid-count, arms out for balance, with small floating number icons (1, 2, 3) above them showing their count. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎭 Charades Relay",
        "objective": "Work in teams to act out and guess words as fast as possible.",
        "materials": ["None — just bodies and imagination!"],
        "steps": [
            "Split into 2 teams; one player from each team acts out a word (an animal, an action) silently.",
            "Their team tries to guess the word as fast as possible.",
            "Once guessed correctly, the next player on that team acts out a new word.",
            "First team to get through 5 words wins!",
        ],
        "safety_line": "Act safely — no bumping into teammates while acting things out.",
        "image_prompt": "An energetic illustration showing two teams of children on opposite sides, one child mid-action flapping arms like a bird while teammates shout guesses, hands raised excitedly. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[3] = [
    {
        "name": "🌋 The Floor Is Lava",
        "objective": "Practice balance and quick thinking by staying off the 'lava' floor.",
        "materials": ["None — just kids and any safe furniture/steps already around!"],
        "steps": [
            "Someone calls out, 'The floor is lava!'",
            "Everyone must get off the ground onto a safe spot (a step, a low wall, a curb) within 5 seconds.",
            "Stay off the 'lava' until someone calls, 'All clear!'",
            "Call 'Lava!' again at a random moment and see who reacts fastest!",
        ],
        "safety_line": "Only climb onto sturdy, safe surfaces — never anything wobbly or high.",
        "image_prompt": "A fun illustration showing 3 children scrambling to balance on a low garden wall and a wide step, feet lifted off the grass below, playful panicked expressions, as if the ground were lava. Bright sunny yard background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "❓ 20 Questions",
        "objective": "Practice asking smart yes-or-no questions to guess a secret item.",
        "materials": ["None — just voices and clever thinking!"],
        "steps": [
            "One player thinks of an object and keeps it secret.",
            "Everyone else takes turns asking yes-or-no questions to narrow it down.",
            "After 20 questions (or fewer), guess what the object is!",
            "Whoever guesses correctly (or asks the most helpful questions) picks the next object.",
        ],
        "safety_line": "Be patient with each other's questions and guesses.",
        "image_prompt": "A thoughtful illustration of 3 children sitting in a circle, one with a secret thought-bubble showing a simple object (like an apple), the others raising hands with question marks above their heads, thinking hard. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "👀 Staring Contest Tournament",
        "objective": "Practice self-control and focus in a silly staring-contest competition.",
        "materials": ["None — just eyes!"],
        "steps": [
            "Pair up and face each other.",
            "Stare into each other's eyes without blinking or laughing.",
            "Whoever blinks or laughs first loses that round.",
            "Winners face other winners until a champion is crowned!",
        ],
        "safety_line": "Keep a comfortable distance apart while staring.",
        "image_prompt": "A silly illustration of two children facing each other very close, eyes wide open in an intense staring contest, one starting to crack a smile while the other stays serious, both trying not to laugh. Bright simple background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤔 Would You Rather",
        "objective": "Practice sharing opinions and explaining reasoning with fun hypothetical choices.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "One player asks a 'Would you rather...' question with two silly options.",
            "Everyone picks a side and explains why.",
            "Talk about who picked what and why.",
            "Take turns asking new 'Would you rather' questions!",
        ],
        "safety_line": "Keep questions kind and silly, not something that could hurt feelings.",
        "image_prompt": "A fun illustration of 4 children sitting in a circle, two pointing left and two pointing right in response to a question, with small thought-bubble icons above showing two silly options (like a slide vs. a swing). Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎬 Silent Charades Battle",
        "objective": "Compete in teams to guess acted-out words the fastest, using only movement.",
        "materials": ["None — just bodies and imagination!"],
        "steps": [
            "Split into 2 teams. One player from each team gets a secret word (an activity, an animal).",
            "Act it out silently — no talking or sound effects allowed!",
            "Your team shouts guesses until they get it right.",
            "Fastest team to guess 5 words in a row wins!",
        ],
        "safety_line": "Act safely with enough space so you don't bump into anyone.",
        "image_prompt": "A lively illustration showing a child silently acting out swimming motions with arms while their team watches intently, hands raised shouting guesses, the opposing team waiting for their turn nearby. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🗣️ Story Starters",
        "objective": "Build a silly group story together, one sentence at a time.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "The first player starts a story with one sentence ('Once there was a dragon who loved pizza...').",
            "Each player adds one more sentence, building on what came before.",
            "Keep going around the circle, making the story sillier each time!",
            "End the story together when it feels complete.",
        ],
        "safety_line": "Keep the story kind and fun — everyone's sentence gets a turn.",
        "image_prompt": "A whimsical illustration of 4 children sitting in a circle outside, one mid-sentence with an animated expression, small imaginative thought-bubble doodles (a dragon, a pizza) floating above the group. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "😉 Wink Detective",
        "objective": "Practice careful observation to spot a secret 'winker' before getting caught.",
        "materials": ["None — just eyes and a group of friends!"],
        "steps": [
            "One player is secretly chosen as the 'Detective' (others don't know who).",
            "One other player is secretly the 'Winker,' chosen without others seeing.",
            "The Winker secretly winks at people, who then playfully pretend to be 'out.'",
            "The Detective watches closely and tries to guess who the Winker is before too many people are 'out'!",
        ],
        "safety_line": "Keep it gentle and fun — no one actually leaves the game, just plays along.",
        "image_prompt": "A playful mystery-themed illustration showing one child winking subtly at another, who reacts with an exaggerated dramatic 'caught' pose, while a third child (the Detective) watches everyone closely with a magnifying-glass-style curious expression. Bright sunny group setting. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[4] = [
    {
        "name": "🕵️ 20 Questions Detective",
        "objective": "Use strategic yes-or-no questions to narrow down and guess a secret item efficiently.",
        "materials": ["None — just voices and strategy!"],
        "steps": [
            "One player secretly picks a category (person, place, or thing) and an item within it.",
            "Everyone else asks yes-or-no questions, starting broad ('Is it alive?') and narrowing down.",
            "Try to guess the item using as few questions as possible.",
            "Whoever guesses correctly (or asks the smartest question) picks the next item!",
        ],
        "safety_line": "Take turns fairly so everyone gets a chance to ask questions.",
        "image_prompt": "A thoughtful illustration of a small group of students sitting outside, one with a secret thought-bubble showing a simple object, others taking notes on a mental checklist of yes/no answers, strategic focused expressions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "📖 Story Chain",
        "objective": "Build a creative story together, adding one sentence at a time in order.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "The first player starts a story with one sentence.",
            "Going around the circle, each player adds exactly one sentence, keeping the story making sense.",
            "Try to build toward an interesting ending as a group.",
            "After a set number of rounds, the last player wraps up the story!",
        ],
        "safety_line": "Keep the story kind — everyone's contribution should build up the fun, not tear it down.",
        "image_prompt": "A creative illustration of a group of students sitting in a circle outside, each with a small speech bubble containing a piece of a growing story, building toward an imaginative scene (like a castle or a spaceship) shown faintly in the background as the collective story. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤥 Two Truths and a Lie",
        "objective": "Practice sharing facts about yourself and spotting a friend's fib.",
        "materials": ["None — just voices and honesty (mostly)!"],
        "steps": [
            "Each player thinks of 2 true things about themselves and 1 made-up thing.",
            "Say all 3 out loud, in any order, without hinting which is the lie.",
            "Everyone else guesses which one is the lie.",
            "Reveal the answer, then let the next player share their 3 statements!",
        ],
        "safety_line": "Keep statements kind and appropriate — this is about fun facts, not embarrassing secrets.",
        "image_prompt": "A friendly illustration showing a student speaking to a small group, with 3 small thought-bubble icons above representing their 3 statements (two with checkmarks for true, one faded/question-marked for the guessed lie), listeners with curious thinking expressions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🌋 The Floor Is Lava: Team Edition",
        "objective": "Work together as a team to help everyone reach safety before the lava spreads.",
        "materials": ["None — just kids and any safe furniture/steps already around!"],
        "steps": [
            "Someone calls, 'The floor is lava!' and everyone scrambles to safe spots.",
            "This time, the whole TEAM must be off the ground within 10 seconds — help each other!",
            "If anyone is still on the 'lava' when time's up, the whole team must start over.",
            "Try again and see if your team can beat your own best time!",
        ],
        "safety_line": "Only climb onto sturdy, safe surfaces, and help each other carefully — no pushing.",
        "image_prompt": "A dynamic team illustration showing a group of children helping each other climb onto low garden walls and wide steps, one child extending a hand to pull a teammate up, all with urgent but joyful expressions. Bright sunny yard background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎭 Emotion Charades",
        "objective": "Practice recognizing and expressing different emotions through acting.",
        "materials": ["None — just faces, bodies, and imagination!"],
        "steps": [
            "One player picks a secret emotion (excited, nervous, surprised, proud) and acts it out silently.",
            "Everyone else guesses which emotion is being shown.",
            "Talk about what body language or facial expressions gave it away.",
            "Take turns acting out new emotions!",
        ],
        "safety_line": "Act out emotions safely, without exaggerated movements that could bump others.",
        "image_prompt": "An expressive illustration of a student making a wide-eyed, hands-on-cheeks surprised expression, acting out an emotion, while classmates watch closely trying to guess, some raising hands with guesses. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤝 Human Knot",
        "objective": "Work together as a team to untangle a human knot using only communication and careful movement.",
        "materials": ["None — just a group of friends standing in a circle!"],
        "steps": [
            "Stand in a circle and reach across to hold two different people's hands (not the people next to you).",
            "Without letting go, work together to untangle into one big circle (or a few connected circles).",
            "Talk through it as a team — who needs to step over or under whom?",
            "Celebrate once you're untangled!",
        ],
        "safety_line": "Move slowly and gently — never pull or twist arms to force the untangling.",
        "image_prompt": "A collaborative illustration showing a group of 6 students with arms crossed and tangled together in a human knot, some stepping carefully over connected arms while others duck under, focused teamwork expressions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🗣️ Categories Speed Round",
        "objective": "Practice quick recall by naming items in a category before a countdown ends.",
        "materials": ["None — just voices and quick thinking!"],
        "steps": [
            "Pick a category (countries, sports, foods) and a letter of the alphabet.",
            "Take turns naming something in that category starting with that letter within 5 seconds.",
            "If you can't think of one in time, you're out for that round.",
            "Change the category or letter and keep playing!",
        ],
        "safety_line": "Be encouraging if a friend needs a little extra time to think.",
        "image_prompt": "A fast-paced illustration of a group of students in a circle, one mid-speech with an excited expression and a small letter icon ('S') floating above, others counting down on their fingers. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[5] = [
    {
        "name": "🗣️ Impromptu Debate Circle",
        "objective": "Practice forming and sharing an opinion on the spot, with reasons to support it.",
        "materials": ["None — just voices and quick thinking!"],
        "steps": [
            "One player calls out a light debate topic ('Cats or dogs?', 'Summer or winter?').",
            "Everyone picks a side and has 30 seconds to think of one good reason.",
            "Take turns sharing your reason — listen respectfully to other sides too.",
            "Vote at the end on which side made the most convincing case!",
        ],
        "safety_line": "Keep it friendly — disagreeing about the topic doesn't mean disagreeing as friends.",
        "image_prompt": "A lively illustration of a small group of students split into two sides of a circle, one side gesturing enthusiastically while presenting a reason, the other side listening thoughtfully. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "😉 Wink Detective Championship",
        "objective": "Sharpen observation skills in a faster-paced round of the classic wink-detective game.",
        "materials": ["None — just eyes and a group of friends!"],
        "steps": [
            "Secretly choose a Detective and a Winker without others knowing who's who.",
            "The Winker discreetly winks at players, who playfully act 'out' when winked at.",
            "The Detective has 3 guesses to identify the Winker before too many players are 'out.'",
            "Play multiple rounds, rotating who gets picked as Detective and Winker!",
        ],
        "safety_line": "Keep it lighthearted — being 'out' just means playing along, not actually leaving.",
        "image_prompt": "A playful mystery-themed illustration showing a subtle wink exchanged between two students in a group circle, with a third student (the Detective) narrowing their eyes suspiciously, scanning the group for clues. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎬 Silent Movie Charades",
        "objective": "Act out an entire short scene silently, like a character in an old silent film.",
        "materials": ["None — just bodies, faces, and imagination!"],
        "steps": [
            "One player picks a simple scene idea (getting caught in the rain, winning a race).",
            "Act out the whole scene silently and dramatically, like a silent movie character, with big expressions.",
            "Everyone else guesses what's happening.",
            "Take turns acting out new silent scenes!",
        ],
        "safety_line": "Act dramatically but safely — big expressions, not rough movements.",
        "image_prompt": "A dramatic, exaggerated illustration of a student mid-scene acting out getting caught in the rain — arms up, mouth open in mock surprise, hand shielding their face — in a theatrical silent-film style pose, classmates watching and guessing. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🌟 Human Bingo Mixer",
        "objective": "Practice social skills by finding classmates who match different fun facts.",
        "materials": ["None — just voices and curiosity!"],
        "steps": [
            "Think of 5 fun 'traits' to look for (has a pet, likes pizza, can whistle, has a sibling, plays a sport).",
            "Walk around asking classmates questions to find someone who matches each trait.",
            "When you find a match, remember their name for that trait.",
            "First to find a match for all 5 traits calls 'Bingo!'",
        ],
        "safety_line": "Ask questions kindly, and it's okay if someone doesn't match — just ask someone else.",
        "image_prompt": "A social, friendly illustration of a group of students mingling and chatting in pairs across a sunny yard, with small icon thought-bubbles above some of them showing traits like a pet paw print, a pizza slice, and a soccer ball. Bright, warm flat children's-book illustration style, no text.",
    },
    {
        "name": "🤝 Human Knot Challenge",
        "objective": "Work as a larger team to untangle a bigger, trickier human knot using only teamwork.",
        "materials": ["None — just a group of friends standing in a circle!"],
        "steps": [
            "Form a larger circle of 8-10 players, each grabbing two different people's hands across the circle.",
            "Without letting go, work together to untangle into one connected shape.",
            "Communicate clearly — who needs to duck, step over, or turn?",
            "Time yourselves and see if a second team can untangle faster!",
        ],
        "safety_line": "Move slowly and gently — never yank or twist to force the untangling.",
        "image_prompt": "A large collaborative illustration showing 8 students with crossed, tangled arms in a big human knot, several mid-motion carefully stepping over and ducking under connected arms, determined teamwork expressions throughout. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎲 Fortunately, Unfortunately",
        "objective": "Build a silly story together by alternating good news and bad news twists.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "The first player starts a story sentence with 'Fortunately...' (something good happens).",
            "The next player continues with 'Unfortunately...' (something goes wrong).",
            "Keep alternating fortunately/unfortunately, building a wild, silly story.",
            "End the story together when it feels complete!",
        ],
        "safety_line": "Keep twists silly and fun, not scary or upsetting.",
        "image_prompt": "A whimsical illustration of a group of students in a circle, alternating expressions of exaggerated joy and mock dismay as the story twists back and forth, small floating icons above showing contrasting story moments (like sunshine then a rain cloud). Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🗿 Freeze Statue Showdown",
        "objective": "Compete to hold the most creative, stable freeze-pose the longest.",
        "materials": ["None — just bodies and balance!"],
        "steps": [
            "On 'go,' everyone strikes a creative statue pose and freezes.",
            "Hold your pose without wobbling or moving.",
            "Anyone who moves or falls out of their pose is out.",
            "Last statue standing wins the showdown!",
        ],
        "safety_line": "Choose poses you can actually balance safely — nothing too risky.",
        "image_prompt": "A fun illustration of 4 students frozen in creative, dynamic statue poses on grass — one balanced on one leg with arms out like a superhero, another mid-jump frozen in the air pose — all holding very still with focused expressions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[6] = [
    {
        "name": "🧩 Silent Line-Up Challenge",
        "objective": "Practice nonverbal communication by organizing the group in order without talking.",
        "materials": ["None — just a group of friends and no talking!"],
        "steps": [
            "Pick a category to line up by (birthday month, height, alphabetical first name).",
            "Without speaking at all, figure out how to arrange yourselves in the correct order.",
            "Use gestures, hand signals, or writing in the air to communicate.",
            "Once everyone thinks you're in order, check out loud together!",
        ],
        "safety_line": "Move calmly while rearranging — no pushing to get into position.",
        "image_prompt": "A focused illustration showing a line of students silently gesturing to each other, using hand signals and mouthing numbers, working out their birthday-month order without speaking, concentrated expressions throughout. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "📖 One-Word Story",
        "objective": "Build a story together where each person can only add a single word at a time.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "Sit in a circle. The first player says one word to start a story ('Once').",
            "Each player adds exactly one more word, going around the circle.",
            "Keep the story making sense as a group, one word at a time.",
            "See how long and silly you can make the story before it stops making sense!",
        ],
        "safety_line": "Keep words kind and appropriate for the group.",
        "image_prompt": "A creative illustration of students sitting in a circle, each with a single word in a small speech bubble, the words strung together above the circle forming a sentence, playful concentrated expressions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🗣️ Debate Circle: Advanced",
        "objective": "Practice building a structured argument with reasons and evidence on the spot.",
        "materials": ["None — just voices and quick thinking!"],
        "steps": [
            "Pick a debate topic and split into two sides.",
            "Each side gets 1 minute to prepare 2 reasons supporting their position.",
            "Present your reasons, then let the other side respond with a counter-point.",
            "Vote as a group on which side argued most convincingly!",
        ],
        "safety_line": "Debate the ideas, not each other — keep it respectful and friendly.",
        "image_prompt": "An engaging illustration of two small groups of students facing each other, one side presenting with confident gestures while holding up fingers to count their reasons, the other side listening and preparing a response. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎭 Freeze Frame Tableau",
        "objective": "Work as a group to instantly create a frozen scene representing a given theme.",
        "materials": ["None — just bodies and imagination!"],
        "steps": [
            "Call out a theme ('a busy city street,' 'a soccer game,' 'a birthday party').",
            "On 'freeze,' everyone instantly poses to create a frozen scene representing that theme.",
            "Hold your pose while others guess what's happening in the scene.",
            "Call a new theme and freeze into a different tableau!",
        ],
        "safety_line": "Choose poses that are safe to hold and won't bump into others.",
        "image_prompt": "A dynamic illustration showing a group of 5 students frozen mid-action, each in a different pose that together represents a busy street scene — one pretending to walk a dog, one frozen mid-jog, one pointing as if crossing a street — all holding perfectly still. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤝 Trust Walk",
        "objective": "Build trust and communication by guiding a partner safely using only your voice.",
        "materials": ["None — just a partner and open space!"],
        "steps": [
            "Pair up; one partner closes their eyes (or wears a blindfold), the other guides with words only.",
            "The guide walks a few steps behind, giving clear directions ('two steps forward, turn slightly left').",
            "Navigate a simple safe path together.",
            "Switch roles and try again — discuss what directions worked best!",
        ],
        "safety_line": "Guides must speak clearly and stay close in case their partner needs help.",
        "image_prompt": "A warm, trust-building illustration showing a student with eyes closed walking carefully with hands slightly out, guided by a partner walking a few steps behind giving verbal directions shown as a small speech bubble with simple arrow icons. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🧠 Memory Chain",
        "objective": "Practice memory and listening by repeating and adding to a growing list.",
        "materials": ["None — just memory and voices!"],
        "steps": [
            "The first player says, 'I packed my bag and in it I put a [item].'",
            "The next player repeats that item and adds a new one.",
            "Keep going around, with each player repeating the WHOLE growing list before adding their own item.",
            "See how long the list can get before someone forgets an item!",
        ],
        "safety_line": "Be encouraging if someone forgets — it's just part of the fun challenge.",
        "image_prompt": "A playful illustration of students sitting in a circle, one mid-recitation with a thought bubble showing a growing chain of small item icons (a hat, a ball, a book), others listening intently, waiting their turn. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤔 Would You Rather Tournament",
        "objective": "Debate and vote through a bracket of silly 'would you rather' dilemmas.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "One player presents a 'Would you rather...' question with two options.",
            "Everyone votes and briefly explains their reasoning.",
            "The majority option 'wins' and moves to the next round against a new dilemma.",
            "Keep going through several rounds — track which type of choice wins most often!",
        ],
        "safety_line": "Keep dilemmas silly and fun, respecting that people vote differently.",
        "image_prompt": "A fun tournament-style illustration showing a small bracket board with two 'would you rather' options facing off, students in the foreground raising hands to vote for their preferred side, animated discussion expressions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[7] = [
    {
        "name": "🗣️ Formal Debate Showdown",
        "objective": "Practice structured, respectful argument with opening statements, rebuttals, and closing remarks.",
        "materials": ["None — just voices, quick thinking, and 2 teams!"],
        "steps": [
            "Split into 2 teams and pick a debate topic.",
            "Each team gives a 1-minute opening statement with their main points.",
            "Teams take turns giving 30-second rebuttals responding to the other side.",
            "Each team gives a short closing statement, then the group votes on the most convincing argument!",
        ],
        "safety_line": "Debate the ideas respectfully — no interrupting or personal comments.",
        "image_prompt": "A formal-style illustration of two teams of students facing each other, one team member standing to give an opening statement with a confident gesture, the opposing team taking notes to prepare a rebuttal. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🧠 Memory Palace Challenge",
        "objective": "Practice memory techniques by linking a growing list of items to a mental journey.",
        "materials": ["None — just memory and imagination!"],
        "steps": [
            "Pick a familiar path (like walking from your front door to your room).",
            "The first player names an item and 'places' it at the first spot along the path.",
            "Each player repeats all previous items in order, then adds one more at the next spot.",
            "See how far along the path (and how many items) your group can remember together!",
        ],
        "safety_line": "Be patient and encouraging — this memory technique takes practice.",
        "image_prompt": "An imaginative illustration showing a dotted path from a doorway to a bedroom, with small item icons (a hat, a book, a ball) placed at points along the path representing memory anchors, a student tracing the path with a finger while reciting the list aloud. Bright, thoughtful flat illustration style, no text.",
    },
    {
        "name": "🎭 Improv Scene Building",
        "objective": "Practice quick creative thinking by building an unscripted scene together with a partner.",
        "materials": ["None — just imagination, voices, and a partner!"],
        "steps": [
            "Pair up. One player starts a scene with one line ('Welcome to my spaceship!').",
            "The partner responds, building on the idea — always saying 'yes, and...' to add to what's been said.",
            "Keep the scene going for a minute, building something increasingly silly and creative.",
            "Switch partners and start a brand new improvised scene!",
        ],
        "safety_line": "Keep scenes kind and appropriate — 'yes, and' means building up, not tearing down.",
        "image_prompt": "A dynamic illustration of two students acting out an improvised scene, one gesturing as if piloting a spaceship, the other reacting with an animated surprised expression, both fully in character. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🤝 Blind Trust Formation",
        "objective": "Work as a full group, using only verbal guidance, to form a specific shape together.",
        "materials": ["None — just a group of friends and no peeking!"],
        "steps": [
            "Everyone closes their eyes except for one designated 'Guide.'",
            "The Guide calls out instructions to help the group form a shape (like a circle or a line) using only words.",
            "The group listens carefully and moves based only on the Guide's voice.",
            "Open your eyes at the end to see how close you got to the shape!",
        ],
        "safety_line": "Move slowly with hands slightly out to avoid bumping into each other.",
        "image_prompt": "A collaborative illustration showing a group of students with eyes closed, moving carefully with hands slightly extended, forming a rough circle shape based on the directions of one student (the Guide) standing to the side, eyes open, calling out instructions. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "📖 Collaborative Mystery Story",
        "objective": "Build a mystery story together, each adding a clue or twist in turn.",
        "materials": ["None — just imagination and voices!"],
        "steps": [
            "The first player sets up a mystery ('The trophy went missing from the school office...').",
            "Each player adds a new clue, suspect, or twist, building the mystery together.",
            "After several rounds, work together to solve the mystery you've created!",
            "See if the ending actually matches all the clues that were given.",
        ],
        "safety_line": "Keep the mystery fun and age-appropriate — nothing too scary.",
        "image_prompt": "An intriguing illustration of a group of students sitting in a circle, small icon thought-bubbles above them showing mystery clues (a magnifying glass, a footprint, a question mark), one student mid-sentence adding a new twist to the story. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🧩 Silent Sorting Challenge",
        "objective": "Communicate and organize as a group using only gestures, no talking or writing.",
        "materials": ["None — just a group of friends and no talking!"],
        "steps": [
            "Secretly, everyone is given a number in their head 1 through however many players there are (agree on this before starting silently, e.g. by a quick whisper from a leader).",
            "Without speaking or showing fingers with numbers, arrange yourselves in the correct numeric order using only gestures.",
            "Once everyone believes they're in order, check together out loud.",
            "Try again with a trickier category to sort by, like the number of letters in your first name!",
        ],
        "safety_line": "Move calmly while rearranging — this is about communication, not speed.",
        "image_prompt": "A focused illustration of a line of students gesturing to each other with hand signals and pointing, silently working out their order, concentrated expressions, no speech bubbles to emphasize the silence. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "😉 Wink Assassin Tournament",
        "objective": "Sharpen observation and deduction skills in an advanced elimination-style wink-detective game.",
        "materials": ["None — just eyes and a group of friends!"],
        "steps": [
            "Secretly assign one player as the 'Assassin' without anyone else knowing.",
            "The Assassin discreetly winks at players, who dramatically act 'eliminated' when winked at.",
            "One player is the 'Investigator' and gets 3 total guesses (used at any point) to name the Assassin.",
            "See if the Investigator solves it before too many players are 'eliminated' — then pick new roles and play again!",
        ],
        "safety_line": "Keep it lighthearted — being 'eliminated' just means playfully sitting out that round, not leaving the game.",
        "image_prompt": "A suspenseful, playful illustration showing a subtle wink exchanged between two students, with a third student (the Investigator) narrowing their eyes and scanning the group thoughtfully, a couple of 'eliminated' students dramatically clutching their chests nearby in mock defeat. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 70_outdoor_games_no_materials_content.sql")
    out.append("-- Extends the existing 'Outdoor Games' category (see 68/69) with 7 more")
    out.append("-- games per grade (21 -> 28), every one playable with ZERO materials — just")
    out.append("-- kids, voices, and open space, no equipment or setup of any kind.")
    out.append("--")
    out.append("-- Appends to the SAME per-grade PacketCategories row (looked up, not")
    out.append("-- re-created) with sort_order continuing from 22. target_count stays at 7.")
    out.append("-- See gen_70_outdoor_games_no_materials_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (")
    out.append("    SELECT 1 FROM dbo.PacketQuestions q")
    out.append("    JOIN dbo.PacketCategories c ON c.category_id = q.category_id")
    out.append("    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 22")
    out.append(")")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 7, f"grade {grade_id} has {len(games)} games, expected 7"
        var = f"@cat_nm_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    SELECT {var} = category_id FROM dbo.PacketCategories "
            f"WHERE grade_id = {grade_id} AND category_name = 'Outdoor Games';"
        )
        for i, game in enumerate(games):
            sort_order = 22 + i
            prompt = build_prompt(game)
            diagram_data = {"steps": game["steps"]}
            cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order", "diagram_type", "diagram_data"]
            vals = [var, esc("short_response"), esc(prompt), "NULL", esc(game["safety_line"]), str(sort_order),
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
        if n != 7:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected 7")
            ok = False
        names = [g["name"] for g in GAMES[grade_id]]
        if len(names) != len(set(names)):
            print(f"DUPLICATE within grade {GRADE_LABELS[grade_id]}: {[n for n in names if names.count(n) > 1]}")
            ok = False
        for game in GAMES[grade_id]:
            for key in ("name", "objective", "materials", "steps", "safety_line", "image_prompt"):
                if key not in game or not game[key]:
                    print(f"MISSING '{key}' in grade {GRADE_LABELS[grade_id]} game {game.get('name')}")
                    ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_games = sum(len(v) for v in GAMES.values())
    print(f"Grades: {len(GAMES)}, Total new games: {total_games}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\70_outdoor_games_no_materials_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 70_outdoor_games_no_materials_content.sql", file=sys.stderr)
