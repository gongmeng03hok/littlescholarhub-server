# -*- coding: utf-8 -*-
"""
Generates lsh.database/76_arts_games_content.sql -- adds a "Creative Arts
Games" category to the existing always-on 'arts' subject_area for every
grade TK-6th. Each grade gets a pool of 14 hand-crafted games spanning the
three already-shipped 'arts' themes (Creative Writing & Storytelling,
Music & Performing Arts, Visual Art Appreciation & Drawing); target_count=7
(fixed, not the usual ~65% auto-rebalance ratio) means the existing
NEWID()-sampling rotation serves a different 7-of-14 combination most weeks
a grade's arts category is selected, so consecutive weeks show a
different set without any manual "week 1 / week 2" authoring.

Follows the exact pattern of gen_68_outdoor_games_content.py.

Run with: python gen_76_arts_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "\U0001F4D6 Silly Story Circle",
        "objective": "Practice listening and adding an idea to a group story.",
        "materials": ["None -- just your imagination and a few friends or family"],
        "steps": [
            "Sit in a circle with a grown-up or friends.",
            "The grown-up starts a silly story with one sentence, like 'Once there was a purple dog.'",
            "Each person adds one silly sentence to keep the story going.",
            "Keep going around the circle until everyone has had a few turns.",
        ],
        "tip": "Every silly idea makes the story more fun -- there's no wrong answer!",
    },
    {
        "name": "\U0001F58D\uFE0F Pass-the-Paper Picture",
        "objective": "Practice taking turns and building a picture together as a group.",
        "materials": ["1 big sheet of paper", "Crayons or markers"],
        "steps": [
            "Everyone sits around one big piece of paper.",
            "Take turns adding one shape, animal, or squiggle to the picture.",
            "Pass the paper to the next person after your turn.",
            "When the paper is full, look at your silly group picture together!",
        ],
        "tip": "There's no 'wrong' shape to add -- every squiggle makes it more fun.",
    },
    {
        "name": "\U0001F50D Guess What I'm Drawing",
        "objective": "Practice recognizing simple shapes and objects as they're drawn.",
        "materials": ["Paper", "Crayon or marker"],
        "steps": [
            "A grown-up slowly draws a simple, familiar thing (like a sun, a cat, or a ball).",
            "Call out your guess as soon as you think you know what it is!",
            "Keep drawing until someone guesses right.",
            "Take turns -- draw something simple for a grown-up or friend to guess.",
        ],
        "tip": "Guessing early and being wrong is part of the fun -- keep guessing!",
    },
    {
        "name": "\U0001F648 Eyes-Closed Scribble",
        "objective": "Practice making marks on paper using touch instead of sight.",
        "materials": ["Paper", "Crayon"],
        "steps": [
            "Close your eyes (or wear a soft blindfold like a scarf).",
            "Draw a simple picture -- like a face or a house -- without peeking.",
            "Open your eyes and see your silly eyes-closed drawing!",
            "Try again with a new picture.",
        ],
        "tip": "Silly, wobbly lines are exactly what's supposed to happen -- that's the fun part!",
    },
    {
        "name": "\U0001F483 Freeze Dance Party",
        "objective": "Practice moving to music and freezing completely still when it stops.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "Turn on a favorite upbeat song and dance around.",
            "A grown-up pauses the music without warning.",
            "Freeze in your silliest pose the second the music stops!",
            "Turn the music back on and keep dancing.",
        ],
        "tip": "The sillier your freeze pose, the more fun -- there's no wrong way to dance!",
    },
    {
        "name": "\U0001F44F Copy My Clap",
        "objective": "Practice listening carefully and copying a simple clapping pattern.",
        "materials": ["None -- just your hands"],
        "steps": [
            "A grown-up claps a simple pattern, like clap-clap-pause-clap.",
            "Listen carefully, then clap the same pattern back.",
            "Take turns being the clapper who makes the pattern.",
            "Try a new pattern each round!",
        ],
        "tip": "It's okay to get it a little wrong -- try again and listen extra close.",
    },
    {
        "name": "\U0001F442 What's That Sound?",
        "objective": "Practice listening closely and identifying everyday sounds.",
        "materials": ["A few household objects (keys, a bell, a bag of rice, a spoon and cup)"],
        "steps": [
            "Close your eyes or turn away.",
            "A grown-up makes a sound with an object, like jingling keys or tapping a spoon on a cup.",
            "Guess what made the sound!",
            "Take turns being the sound-maker.",
        ],
        "tip": "Every good guess counts, even if it's not quite right -- keep listening closely.",
    },
    {
        "name": "\U0001FA9E Mirror Me",
        "objective": "Practice watching closely and copying a partner's slow movements.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Stand facing a partner.",
            "One person slowly moves an arm, makes a face, or sways side to side.",
            "The other person copies the movement like a mirror, at the same time.",
            "Switch who leads after a minute.",
        ],
        "tip": "Moving slowly and watching closely makes you a great mirror partner.",
    },
    {
        "name": "\U0001F418 Act Like an Animal",
        "objective": "Practice using body movements to show an idea without talking.",
        "materials": ["None -- just your imagination"],
        "steps": [
            "A grown-up whispers an animal name to one player (like elephant or bunny).",
            "That player acts and moves like the animal for everyone to guess.",
            "Everyone else calls out their guesses.",
            "Take turns picking a new animal to act out.",
        ],
        "tip": "Big, silly movements make it even more fun to guess!",
    },
    {
        "name": "\U0001F60A Feeling Faces",
        "objective": "Practice showing different feelings with your face and body.",
        "materials": ["None -- just your imagination"],
        "steps": [
            "A grown-up calls out a feeling, like happy, surprised, or sleepy.",
            "Make your biggest face and body pose to show that feeling.",
            "Look around at your friends' funny faces too!",
            "Try a new feeling each round.",
        ],
        "tip": "There's no wrong way to show a feeling -- make it as big as you like.",
    },
    {
        "name": "\U0001F5FF Freeze-Frame Statues",
        "objective": "Practice holding a still pose to show a simple idea.",
        "materials": ["None -- just open space"],
        "steps": [
            "A grown-up calls out an idea, like 'a sleepy cat' or 'a tall tree.'",
            "Everyone freezes in a pose that shows that idea.",
            "Hold your statue pose until the grown-up says 'unfreeze!'",
            "Try a new idea and freeze again.",
        ],
        "tip": "Any pose you choose is the perfect pose -- just freeze and have fun.",
    },
    {
        "name": "\U0001F3B2 Picture Story Starter",
        "objective": "Practice using a picture to imagine and tell a simple story.",
        "materials": ["A few simple picture cards or drawings (a sun, a dog, a boat)"],
        "steps": [
            "Pick one picture card without looking.",
            "Look at the picture and think of one silly sentence about it.",
            "Say your sentence out loud to the group.",
            "Take turns picking new pictures and telling more of the story.",
        ],
        "tip": "Any silly idea about the picture is a great story idea.",
    },
    {
        "name": "\U0001F514 Sound Effects Story",
        "objective": "Practice making sound effects to go along with a simple story.",
        "materials": ["A few noisy household objects (bells, pots, crinkly paper)"],
        "steps": [
            "A grown-up tells a very short, simple story out loud.",
            "Whenever you hear a fun word (like 'splash' or 'boom'), make a sound with your object.",
            "Listen carefully so you know when it's your turn to make a sound.",
            "Try the story again and switch which sound each person makes.",
        ],
        "tip": "Loud, silly sounds make the story even more exciting.",
    },
    {
        "name": "\U0001F941 Kitchen Band Parade",
        "objective": "Practice making music and moving together using household objects as instruments.",
        "materials": ["Pots, spoons, or plastic containers to use as drums", "Open space to march"],
        "steps": [
            "Give each child a pot or container and a spoon to tap.",
            "March around the room or yard, tapping your 'drum' along to a beat.",
            "Follow a grown-up as the parade leader, changing speed (slow, fast, slow).",
            "Take turns being the parade leader who picks the beat.",
        ],
        "tip": "Any beat you tap is the right beat -- enjoy making your own music!",
    },
]


GAMES[1] = [
    {
        "name": "\U0001F4DA Add-One-Line Story",
        "objective": "Practice building a group story by adding one sentence at a time.",
        "materials": ["None -- just your imagination and a few friends or family"],
        "steps": [
            "Sit together and pick a simple story starter, like 'One day, a little robot woke up.'",
            "Go around the group -- each person adds one new sentence to the story.",
            "Try to make your sentence connect to what the last person said.",
            "Keep going until the story reaches a fun, silly ending.",
        ],
        "tip": "There's no wrong direction for the story to go -- surprise each other!",
    },
    {
        "name": "\U0001F5BC\uFE0F Fold-and-Draw Creature",
        "objective": "Practice building a silly creature drawing together, one part at a time.",
        "materials": ["1 sheet of paper", "Crayons or markers"],
        "steps": [
            "Fold the paper into 3 sections.",
            "The first person draws a head in the top section, then folds it back so it's hidden.",
            "The next person draws a body in the middle section without peeking at the head.",
            "The last person draws legs or feet in the bottom section, then unfold to reveal your silly creature!",
        ],
        "tip": "The sillier the mismatched creature looks, the better -- that's the whole point!",
    },
    {
        "name": "\U0001F3A8 Draw & Guess Starters",
        "objective": "Practice drawing simple clues so others can guess the word.",
        "materials": ["Paper", "Crayons or markers", "A few simple word cards (dog, sun, house, tree)"],
        "steps": [
            "Pick a word card without showing anyone.",
            "Draw clues for that word -- no letters or numbers allowed!",
            "Everyone else calls out guesses while you draw.",
            "Whoever guesses correctly draws the next word.",
        ],
        "tip": "Simple shapes are often the best clues -- you don't have to be a great artist.",
    },
    {
        "name": "\U0001F91A Wrong-Hand Drawing",
        "objective": "Practice drawing with your non-writing hand to explore a new challenge.",
        "materials": ["Paper", "Crayon or marker"],
        "steps": [
            "Hold your crayon in the hand you don't usually draw with.",
            "Draw a simple picture, like a house or a flower.",
            "Compare it with a picture drawn with your regular hand.",
            "Try a second wrong-hand drawing and see if it gets easier!",
        ],
        "tip": "Wobbly lines are expected -- this game is about trying something new, not being perfect.",
    },
    {
        "name": "\U0001F57A Freeze Dance Shapes",
        "objective": "Practice dancing to music and freezing into a specific shape when it stops.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "Turn on a favorite upbeat song and dance.",
            "Before pausing the music, call out a shape to freeze into, like 'freeze like a letter T!'",
            "Freeze in that shape the instant the music stops.",
            "Pick a new shape each time you restart the music.",
        ],
        "tip": "Making a clear, big shape with your body is what makes this game fun to watch.",
    },
    {
        "name": "\U0001F44F Clap-and-Echo Patterns",
        "objective": "Practice listening to and repeating longer clapping rhythms.",
        "materials": ["None -- just your hands"],
        "steps": [
            "One player claps a short rhythm pattern, like clap-clap-pause-clap-clap.",
            "Everyone else echoes the same pattern back together.",
            "Make the pattern one clap longer each round.",
            "See how long a pattern the group can remember and copy!",
        ],
        "tip": "Listening quietly before you clap back helps you remember the pattern.",
    },
    {
        "name": "\U0001F3A7 Guess the Household Sound",
        "objective": "Practice identifying sounds made by everyday objects by listening carefully.",
        "materials": ["5-6 household objects that make different sounds (keys, paper, a bell, a cup and spoon, a zipper)"],
        "steps": [
            "Turn away or close your eyes.",
            "A partner picks one object and makes a sound with it.",
            "Guess which object made the sound.",
            "Take turns being the sound-maker and try to stump each other!",
        ],
        "tip": "It's okay to guess a few times -- listening again for clues is part of the fun.",
    },
    {
        "name": "\U0001FA9E Mirror Partners",
        "objective": "Practice copying a partner's movements at the exact same time.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Stand facing your partner, like looking in a mirror.",
            "One partner slowly moves -- arms, face, or body -- while the other copies exactly.",
            "Try to move so smoothly that it's hard to tell who's leading.",
            "Switch leaders after about a minute.",
        ],
        "tip": "Slow, smooth movements are much easier to mirror than fast ones.",
    },
    {
        "name": "\U0001F3AD Silent Action Charades",
        "objective": "Practice acting out simple actions using only body movements, no talking or sounds.",
        "materials": ["A few simple action cards (brushing teeth, riding a bike, flying a kite)"],
        "steps": [
            "Pick an action card without showing anyone.",
            "Act out the action using only your body -- no talking or sound effects.",
            "Everyone else calls out their guesses.",
            "Take turns picking a new action to act out.",
        ],
        "tip": "Slowing down your movements often makes them easier for others to guess.",
    },
    {
        "name": "\U0001F632 Feelings Freeze",
        "objective": "Practice showing different feelings clearly through facial expressions and posture.",
        "materials": ["None -- just your imagination"],
        "steps": [
            "One player calls out a feeling, like excited, grumpy, or nervous.",
            "Everyone freezes into a pose and face that shows that feeling.",
            "Look around and notice how everyone showed the same feeling differently.",
            "Call out a new feeling and freeze again.",
        ],
        "tip": "Everyone can show the same feeling in their own way -- that's what makes it interesting.",
    },
    {
        "name": "\U0001F5FF Group Statue Scene",
        "objective": "Practice working together to build one frozen scene using several people's poses.",
        "materials": ["None -- just a group and open space"],
        "steps": [
            "Pick a simple scene idea together, like 'a busy playground' or 'a zoo.'",
            "Each person picks a part of the scene and freezes into a pose to show it.",
            "Hold still together like a group statue.",
            "Take a peek at your whole 'statue scene' before trying a new idea.",
        ],
        "tip": "Different poses for the same scene make the group statue more interesting to look at.",
    },
    {
        "name": "\U0001F3B2 Story Card Draw",
        "objective": "Practice using a picture prompt to build a short story with a partner.",
        "materials": ["A few simple picture cards (a dragon, a rocket, a birthday cake)"],
        "steps": [
            "Draw one picture card without looking.",
            "Make up 2-3 sentences that could start a story about that picture.",
            "Pass the story to a partner, who adds 2-3 more sentences.",
            "Keep trading until your story has a fun ending!",
        ],
        "tip": "Any picture can lead to a great story -- let your imagination run with it.",
    },
    {
        "name": "\U0001F514 Story with Sound Effects",
        "objective": "Practice adding sound effects at the right moments in a group story.",
        "materials": ["A few noisy objects (bells, a drum, crinkly paper, a whistle)"],
        "steps": [
            "Each player picks one sound-making object.",
            "A grown-up or reader tells a short story out loud.",
            "Whenever your key word is said (like 'splash' or 'crash'), make your sound at just the right moment.",
            "Try the story again, switching which sound each person is in charge of.",
        ],
        "tip": "Listening closely for your cue is what makes the sound effects land perfectly.",
    },
    {
        "name": "\U0001F941 Beat Keeper Band",
        "objective": "Practice keeping a steady beat together using household instruments.",
        "materials": ["Pots, containers, or boxes to use as drums", "Wooden spoons or sticks"],
        "steps": [
            "Give each player something to tap as a drum.",
            "One player is the 'Beat Keeper' and taps a simple steady beat.",
            "Everyone else joins in, tapping along to match the same beat.",
            "Take turns being the Beat Keeper and try a faster or slower beat.",
        ],
        "tip": "Staying together as a group matters more than being perfectly fast.",
    },
]


GAMES[2] = [
    {
        "name": "\U0001F4DD Three-Sentence Story Swap",
        "objective": "Practice writing a short story cooperatively by swapping papers.",
        "materials": ["Paper", "Pencil or crayon"],
        "steps": [
            "Write the first sentence of a story on your paper.",
            "Swap papers with a partner.",
            "Read what's there and add the next sentence.",
            "Swap two more times until each story has a beginning, middle, and end.",
        ],
        "tip": "Reading your partner's sentence carefully helps your next sentence fit perfectly.",
    },
    {
        "name": "\U0001F409 Exquisite Corpse Creature",
        "objective": "Practice creating a mismatched creature drawing without seeing the whole picture.",
        "materials": ["Paper", "Crayons or markers"],
        "steps": [
            "Fold a paper into 3 equal sections (head, body, legs).",
            "Draw a head in the top section, then fold it out of sight before passing it on.",
            "The next artist draws a body without peeking, folds it away, and passes it on.",
            "The last artist draws legs, then everyone unfolds the paper together to reveal the creature.",
        ],
        "tip": "The more mismatched the creature looks, the funnier the reveal -- enjoy the surprise!",
    },
    {
        "name": "\U0001F58D\uFE0F Draw & Guess Word Battle",
        "objective": "Practice drawing quick visual clues so a partner can guess a word within a time limit.",
        "materials": ["Paper", "Crayons or markers", "Word cards or a short word list", "A timer (optional)"],
        "steps": [
            "Pick a word from the list without showing your partner.",
            "Draw clues (no letters or numbers) for 60 seconds while your partner guesses out loud.",
            "Switch roles after each round.",
            "Keep score of how many words each of you guessed correctly.",
        ],
        "tip": "Starting with the biggest, most recognizable shape usually gets the fastest guess.",
    },
    {
        "name": "\u270B One Continuous Line",
        "objective": "Practice drawing an object without lifting your pencil off the paper.",
        "materials": ["Paper", "Pencil or crayon"],
        "steps": [
            "Pick something simple to draw, like an animal or your house.",
            "Draw it without ever lifting your pencil off the paper.",
            "See how your drawing looks when you finish the single line.",
            "Try a new object with a fresh continuous line.",
        ],
        "tip": "It's supposed to look a little wobbly -- that's what makes one-line drawings fun to look at.",
    },
    {
        "name": "\U0001F483 Freeze Dance Categories",
        "objective": "Practice dancing to music and freezing in a pose that matches a called-out category.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "Play a favorite upbeat song and dance freely.",
            "When the music pauses, a caller shouts a category, like 'freeze like an animal!'",
            "Freeze in a pose that matches that category.",
            "Resume the music and try a new category next time it stops.",
        ],
        "tip": "The most creative pose for the category is always a winner -- there's no single right answer.",
    },
    {
        "name": "\U0001F44F Clap-Back Rounds",
        "objective": "Practice remembering and repeating an increasingly longer rhythm pattern.",
        "materials": ["None -- just your hands"],
        "steps": [
            "Player one claps a short rhythm.",
            "Player two repeats it, then adds one more clap of their own.",
            "Player one repeats the whole longer pattern, then adds another clap.",
            "Keep taking turns adding claps until someone forgets the pattern -- then start a new one!",
        ],
        "tip": "Whispering the rhythm to yourself under your breath can help you remember it.",
    },
    {
        "name": "\U0001F3A7 Sound Detective",
        "objective": "Practice identifying sounds and describing what makes them by listening carefully.",
        "materials": ["6-8 household objects that make distinct sounds"],
        "steps": [
            "Close your eyes while a partner makes a sound with one object.",
            "Guess what object made the sound, and describe why you think so.",
            "Open your eyes to check if you're right.",
            "Switch roles and try to pick trickier sounds to stump each other.",
        ],
        "tip": "Describing the sound out loud (crinkly, jingly, thumpy) can help you narrow down your guess.",
    },
    {
        "name": "\U0001FA9E Mirror Match Duet",
        "objective": "Practice mirroring a partner's movements smoothly and in sync.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Face your partner and decide who leads first.",
            "The leader moves slowly and smoothly -- arms, face, whole body.",
            "The follower copies each movement like a reflection, at the same time.",
            "Switch leaders every minute, and try to keep the movements slow enough to follow easily.",
        ],
        "tip": "The best mirror duets look so smooth it's hard to tell who's really leading.",
    },
    {
        "name": "\U0001F3AD Object Charades",
        "objective": "Practice using body movements to show how an object is used, without talking.",
        "materials": ["A few object cards (umbrella, guitar, telephone, paintbrush)"],
        "steps": [
            "Pick an object card without showing anyone.",
            "Act out using that object -- no talking, no sound effects.",
            "Everyone else guesses what the object is.",
            "Take turns picking a new object to act out.",
        ],
        "tip": "Acting out exactly how the object feels in your hands gives the best clues.",
    },
    {
        "name": "\U0001F62F Emotion Switch-Up",
        "objective": "Practice quickly switching between different facial expressions and body language on cue.",
        "materials": ["A few emotion word cards (surprised, proud, worried, silly)"],
        "steps": [
            "One player calls out an emotion word.",
            "Everyone else instantly makes a face and pose to match it.",
            "After a few seconds, call out a brand-new emotion to switch to.",
            "Take turns being the caller.",
        ],
        "tip": "Switching quickly and fully into each new emotion is what makes this game a fun challenge.",
    },
    {
        "name": "\U0001F5FF Freeze-Frame Story Scene",
        "objective": "Practice working with a group to freeze into a scene from a familiar story.",
        "materials": ["None -- just a group and open space"],
        "steps": [
            "Pick a simple, familiar story or event together, like 'a birthday party.'",
            "Each person chooses one moment or character from that scene and freezes into a pose.",
            "Hold your group freeze-frame for a few seconds.",
            "Try a different moment from the same story and freeze again.",
        ],
        "tip": "Picking a clear, specific moment to freeze makes your pose easier for others to recognize.",
    },
    {
        "name": "\U0001F3B2 Story Dice Adventure",
        "objective": "Practice building a short story using randomly chosen picture prompts.",
        "materials": ["6-8 small picture cards (or drawings) placed face-down", "Paper and pencil (optional)"],
        "steps": [
            "Flip over 3 picture cards without looking.",
            "Think of a way to connect all 3 pictures into one short story.",
            "Tell your story out loud to a partner or write it down.",
            "Flip 3 new cards and try a totally different story.",
        ],
        "tip": "The trickiest picture combinations often make the most surprising, fun stories.",
    },
    {
        "name": "\U0001F514 Foley Story Theater",
        "objective": "Practice creating sound effects that match the action in a story as it's read aloud.",
        "materials": ["A short story or a few sentences to read aloud", "A few noisy objects (paper, bells, a drum, keys)"],
        "steps": [
            "Assign each player one or two sound-effect objects.",
            "As the story is read aloud, listen for moments that need a sound (footsteps, a door, rain).",
            "Make your sound effect at exactly the right moment in the story.",
            "Read the story again and see if the sound effects match even better the second time.",
        ],
        "tip": "Timing your sound to the exact word makes the whole story come alive.",
    },
    {
        "name": "\U0001F941 Rhythm Relay Band",
        "objective": "Practice passing a steady rhythm around a group without breaking the beat.",
        "materials": ["Household items to tap as instruments (pots, boxes, spoons)"],
        "steps": [
            "Sit or stand in a circle, each with something to tap.",
            "The first player taps a 4-beat rhythm.",
            "The next player continues the same steady beat without stopping, then the next, all the way around.",
            "See how many times the beat can go around the circle without anyone missing it!",
        ],
        "tip": "Listening to the beat before it reaches you helps you jump in smoothly.",
    },
]


GAMES[3] = [
    {
        "name": "\U0001F4D6 Genre Swap Story",
        "objective": "Practice writing a short group story that shifts into a silly new genre halfway through.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Start writing a normal story, like 'A girl walked her dog to the park.'",
            "After 3 sentences, a partner picks a silly genre card (spooky, superhero, fairy tale) to switch to.",
            "Keep writing the same story, but now in that new silly style.",
            "Read your genre-swapped story out loud and see how it changed!",
        ],
        "tip": "The funniest stories often come from the most unexpected genre switch.",
    },
    {
        "name": "\U0001F419 Three-Artist Creature",
        "objective": "Practice building one creature drawing across three artists who can't see the whole thing.",
        "materials": ["Paper folded into 3 sections", "Crayons or markers"],
        "steps": [
            "Artist one draws a head/face in the top section, then folds it away.",
            "Artist two draws a body and arms in the middle section without peeking, then folds it away.",
            "Artist three draws legs or a tail in the bottom section.",
            "Unfold together and name your brand-new mismatched creature!",
        ],
        "tip": "Naming your creature together is the perfect way to celebrate its silliness.",
    },
    {
        "name": "\U0001F3A8 Speed Sketch Draw & Guess",
        "objective": "Practice drawing fast, clear clues under time pressure so a team can guess.",
        "materials": ["Paper", "Crayons or markers", "Word cards", "A timer"],
        "steps": [
            "Split into two small teams.",
            "One artist per team draws a secret word for their team to guess in 45 seconds -- no letters or numbers.",
            "Teams shout guesses until time runs out or someone guesses right.",
            "Switch artists each round and add up correct guesses to see who scores more.",
        ],
        "tip": "Drawing the most important part of the word first gives your team the best head start.",
    },
    {
        "name": "\U0001F300 Shape-Only Drawing Challenge",
        "objective": "Practice drawing a recognizable picture using only three basic shapes.",
        "materials": ["Paper", "Crayons or markers"],
        "steps": [
            "Pick something to draw, like a robot or a house.",
            "Build your entire drawing using only circles, squares, and triangles.",
            "Add small details (like eyes or windows) using the same three shapes only.",
            "Show a partner and see if they can guess what shapes you used the most.",
        ],
        "tip": "Working within a limit like 'only 3 shapes' often sparks the most creative solutions.",
    },
    {
        "name": "\U0001F57A Freeze Dance Story",
        "objective": "Practice dancing and using freeze poses to help tell a short made-up story.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "Dance to music while a narrator tells a very short story out loud.",
            "Every time the music pauses, freeze into a pose that shows what's happening in the story right then.",
            "Resume dancing when the music restarts and the story continues.",
            "Try the same story again with completely different freeze poses.",
        ],
        "tip": "Your freeze pose doesn't need to be perfect -- it just needs to show what the story character is doing.",
    },
    {
        "name": "\U0001F44F Call-and-Response Rhythm",
        "objective": "Practice performing a call-and-response rhythm pattern with a partner or group.",
        "materials": ["None -- just your hands and voice"],
        "steps": [
            "One player claps and says a short rhythmic phrase, like 'clap-clap, stomp!'",
            "The whole group echoes it back exactly.",
            "The leader changes the pattern each round, mixing claps, stomps, and snaps.",
            "Take turns being the leader who creates new patterns.",
        ],
        "tip": "Mixing different sounds (claps, stomps, snaps) makes your patterns more fun to copy.",
    },
    {
        "name": "\U0001F3A7 Sound Story Guess",
        "objective": "Practice identifying a short sequence of sounds and guessing what story they tell.",
        "materials": ["4-5 household objects for sound effects"],
        "steps": [
            "One player makes 3 sounds in a row using different objects (like a door creak, footsteps, then a bell).",
            "Everyone else closes their eyes and listens to the full sequence.",
            "Guess what mini 'story' the sounds might be telling.",
            "Take turns creating a new 3-sound sequence for others to guess.",
        ],
        "tip": "There's no single right story -- the most creative guess is just as good as the 'expected' one.",
    },
    {
        "name": "\U0001FA9E Shadow Mirror",
        "objective": "Practice mirroring a partner's movements while adding your own creative details.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Face your partner and choose a leader.",
            "The leader creates a slow movement sequence -- like reaching, bending, and turning.",
            "The follower mirrors it exactly, then adds one small new movement of their own at the end.",
            "Switch leaders and build a longer movement sequence together each round.",
        ],
        "tip": "Adding just one new movement each time keeps the sequence growing in a fun, surprising way.",
    },
    {
        "name": "\U0001F3AD Scene Starter Charades",
        "objective": "Practice acting out a short scene idea using only movement and expression.",
        "materials": ["A few scene cards (cooking a meal, exploring a cave, fixing a bike)"],
        "steps": [
            "Pick a scene card without showing anyone.",
            "Act out the scene silently for about 30 seconds.",
            "Everyone else guesses what scene you're acting out.",
            "Take turns picking a new scene to act out.",
        ],
        "tip": "Adding small realistic details, like wiping your hands after 'cooking,' gives the best clues.",
    },
    {
        "name": "\U0001F3A2 Emotion Roller Coaster",
        "objective": "Practice smoothly transitioning your face and body through a sequence of different emotions.",
        "materials": ["A list of 4-5 emotions in order (calm, excited, scared, relieved, happy)"],
        "steps": [
            "Read the emotion list out loud together.",
            "Act out each emotion in order, holding each one for a few seconds before moving to the next.",
            "Try to make the transitions between emotions feel smooth and believable.",
            "Create a new order of emotions and try the 'roller coaster' again.",
        ],
        "tip": "Thinking about why you'd feel each emotion helps make your expression more believable.",
    },
    {
        "name": "\U0001F5FF Storybook Tableau Trio",
        "objective": "Practice working in small groups to create three connected frozen scenes that tell a story.",
        "materials": ["None -- just a group and open space"],
        "steps": [
            "In groups of 3, pick a simple story with a beginning, middle, and end.",
            "Freeze into a group pose showing the beginning of the story.",
            "On a signal, unfreeze and move into a new pose showing the middle, then the end.",
            "Show your three-part 'living storybook' to another group.",
        ],
        "tip": "Clear, different poses for each part make your story easy for an audience to follow.",
    },
    {
        "name": "\U0001F3B2 Three-Card Story Chain",
        "objective": "Practice building a short story that connects three randomly drawn picture prompts in order.",
        "materials": ["8-10 small picture cards", "Paper and pencil (optional)"],
        "steps": [
            "Draw 3 picture cards and lay them in a row.",
            "Write or tell a short story that uses all three pictures in that exact order.",
            "Read your story aloud to a partner.",
            "Shuffle and draw 3 new cards for a brand-new story.",
        ],
        "tip": "The order of the pictures can guide your story's beginning, middle, and end.",
    },
    {
        "name": "\U0001F514 Radio Play Sound Effects",
        "objective": "Practice performing live sound effects to bring an old-style radio story to life.",
        "materials": ["A short written story or script", "A few sound-effect objects (paper, bells, a drum, a cup of water)"],
        "steps": [
            "Assign each player a sound-effect job based on the story's action.",
            "One player reads the story aloud slowly, like an old radio show.",
            "Sound-effect players add their sounds at just the right moments -- no visuals allowed, just sound!",
            "Perform it a second time and see if the sound effects land even better.",
        ],
        "tip": "Closing your eyes while listening to the finished 'radio play' makes the sound effects feel extra real.",
    },
    {
        "name": "\U0001F941 Layered Rhythm Band",
        "objective": "Practice layering two different rhythm patterns together as a group.",
        "materials": ["Household items to tap as instruments"],
        "steps": [
            "Split into two small groups.",
            "Group A starts a simple steady beat and keeps repeating it.",
            "Group B joins in on top with a different, second rhythm pattern.",
            "Listen to how the two layered rhythms sound together, then switch patterns between groups.",
        ],
        "tip": "Keeping your own steady beat while hearing a different one is a great listening challenge.",
    },
]


GAMES[4] = [
    {
        "name": "\U0001F4DA Constraint Story Chain",
        "objective": "Practice building a longer collaborative story while following a specific creative constraint.",
        "materials": ["Paper", "Pencil", "A constraint card (e.g., 'no character can speak,' 'must include a talking object')"],
        "steps": [
            "Draw one constraint card and read it aloud to the group.",
            "Take turns adding 2-3 sentences each to a group story that must follow the constraint the whole time.",
            "Keep going until the story reaches a full ending (at least 5 rounds).",
            "Read the whole story aloud and see how the constraint shaped the plot.",
        ],
        "tip": "A tricky constraint often forces the most creative and surprising story ideas.",
    },
    {
        "name": "\U0001F5BC\uFE0F Blind Relay Mural",
        "objective": "Practice contributing to a group drawing where each artist can only see a small clue of what came before.",
        "materials": ["1 long roll or taped-together sheets of paper", "Crayons or markers"],
        "steps": [
            "Artist one draws a scene on the far-left section, then covers all but the very edge of it.",
            "Artist two can only see that tiny edge and must continue the scene from there.",
            "Keep going down the paper, each artist only seeing the last small edge.",
            "Unveil the whole mural together and see how the scene changed and grew.",
        ],
        "tip": "Small clues lead to big surprises -- the mismatched sections are the best part to talk about.",
    },
    {
        "name": "\U0001F3A8 60-Second Draw-Off",
        "objective": "Practice drawing clear, recognizable clues under strict time pressure for a team.",
        "materials": ["Paper", "Crayons or markers", "Word/phrase cards (harder than single words)", "A timer"],
        "steps": [
            "Split into two teams and pick a card with a short phrase (not just one word).",
            "The artist draws clues for the whole phrase in 60 seconds while their team guesses.",
            "Score a point only if the team guesses the exact full phrase.",
            "Switch artists and alternate teams each round.",
        ],
        "tip": "Breaking a phrase into its separate words and drawing each part helps your team guess faster.",
    },
    {
        "name": "\u270B Non-Dominant Portrait Challenge",
        "objective": "Practice drawing a detailed portrait using your non-dominant hand, focused on careful observation.",
        "materials": ["Paper", "Pencil or crayon", "A partner to model, or a photo"],
        "steps": [
            "Look closely at your partner's face (or a photo) for 30 seconds without drawing.",
            "Using only your non-dominant hand, draw their portrait while looking at them, not the paper.",
            "Finish the drawing and compare it with your partner's actual face.",
            "Trade roles and try again.",
        ],
        "tip": "Looking at your subject more than your paper is what makes this challenge (and the funny results) worthwhile.",
    },
    {
        "name": "\U0001F483 Choreographed Freeze Sequence",
        "objective": "Practice creating and remembering a sequence of three freeze poses set to music.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "As a group, agree on three freeze poses in order (like reaching, crouching, spinning).",
            "Dance freely to music between poses, hitting pose 1 at the first pause, pose 2 at the second, pose 3 at the third.",
            "Practice the sequence a few times until everyone lands the poses together.",
            "Perform your finished sequence for another group.",
        ],
        "tip": "Counting the beats between poses in your head helps the whole group land them together.",
    },
    {
        "name": "\U0001F44F Rhythm Canon Rounds",
        "objective": "Practice performing a rhythm as a canon, where groups start the same pattern at staggered times.",
        "materials": ["None -- just your hands and voice"],
        "steps": [
            "Split into 2-3 small groups and agree on one 4-beat rhythm pattern together.",
            "Group 1 starts clapping the pattern on repeat.",
            "Two beats later, Group 2 joins in with the same pattern, then Group 3 two beats after that.",
            "Listen to how the layered, staggered pattern sounds, then try starting the groups in a different order.",
        ],
        "tip": "Staying steady on your own beat -- even while hearing others start differently -- is the real challenge here.",
    },
    {
        "name": "\U0001F3A7 Foley Mystery Sequence",
        "objective": "Practice sequencing and identifying a chain of sound effects that tell a mini mystery.",
        "materials": ["6-8 household objects for varied sounds"],
        "steps": [
            "One player creates a sequence of 4-5 sounds that could tell a mini mystery story (a knock, footsteps, a gasp, a thud).",
            "Everyone else listens with eyes closed and tries to guess what happened, in order.",
            "Compare guesses and reveal what the sound-maker actually imagined.",
            "Take turns building a new mystery sound sequence.",
        ],
        "tip": "Really specific sound choices (a soft creak vs. a loud slam) give the clearest story clues.",
    },
    {
        "name": "\U0001FA9E Sequence Mirror Build",
        "objective": "Practice mirroring and extending a growing sequence of movements with a partner.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Partner A performs one movement; Partner B mirrors it exactly.",
            "Partner B adds a second movement; Partner A mirrors the first movement, then the new one.",
            "Keep adding one movement each round, always mirroring the whole sequence from the start.",
            "See how long a sequence your pair can build and remember together!",
        ],
        "tip": "Practicing the sequence out loud in your head as you mirror it helps you remember more steps.",
    },
    {
        "name": "\U0001F3AD Category Charades Challenge",
        "objective": "Practice acting out prompts from a specific creative category without speaking.",
        "materials": ["Prompt cards sorted into categories (jobs, weather, hobbies, historical figures)"],
        "steps": [
            "Pick a category, then draw a prompt card from within it.",
            "Act out the prompt silently for up to a minute.",
            "Teammates guess both the specific prompt AND which category it came from.",
            "Rotate through all the categories over several rounds.",
        ],
        "tip": "Committing fully to small, specific details makes your acting much easier to read.",
    },
    {
        "name": "\U0001F3A2 Emotion Story Improv",
        "objective": "Practice improvising a short wordless scene that moves through a specific emotional arc.",
        "materials": ["An emotion-arc card (e.g., 'nervous to determined to proud')"],
        "steps": [
            "Draw an emotion-arc card showing 3 feelings in order.",
            "Improvise a silent scene (no talking) that moves through all three feelings believably.",
            "Ask watchers to guess the emotional arc you performed.",
            "Try a new arc card and repeat.",
        ],
        "tip": "Slowing your transitions between feelings helps the audience follow your emotional journey.",
    },
    {
        "name": "\U0001F5FF Five-Scene Living Story",
        "objective": "Practice working as a group to build five connected freeze-frame scenes that tell a full story.",
        "materials": ["None -- just a group and open space"],
        "steps": [
            "As a group, outline a simple story with 5 key moments (beginning, rising action, climax, falling action, ending).",
            "Assign each group member a role, then freeze into a pose for scene 1.",
            "On a signal, transition smoothly into scene 2, then scene 3, all the way to scene 5.",
            "Perform your full five-scene living story for an audience, then ask what moment stood out most.",
        ],
        "tip": "A clearly different pose for every single scene keeps your audience able to follow along.",
    },
    {
        "name": "\U0001F3B2 Plot Twist Dice",
        "objective": "Practice inserting a mid-story plot twist into an already-started story.",
        "materials": ["10-12 story-starter cards", "5-6 plot-twist cards", "Paper and pencil"],
        "steps": [
            "Draw a story-starter card and write the first half of a story from it.",
            "Draw a plot-twist card and rewrite or continue your story to work the twist in naturally.",
            "Finish the story after the twist.",
            "Read it aloud and discuss how the twist changed the direction.",
        ],
        "tip": "The best twists connect to something small you already mentioned earlier in the story.",
    },
    {
        "name": "\U0001F514 Foley Director's Cut",
        "objective": "Practice directing a small team to perform sound effects for a story, then revising the choices.",
        "materials": ["A short written story or script", "6-8 sound-effect objects"],
        "steps": [
            "One player is the 'director' who assigns sound jobs and decides which sounds fit best.",
            "Perform the story once through with the director's first choices.",
            "As a group, discuss which sounds worked and which didn't, then swap objects or timing.",
            "Perform the 'director's cut' -- the improved second version.",
        ],
        "tip": "Being willing to change your first sound choice is exactly how real sound designers improve their work.",
    },
    {
        "name": "\U0001F941 Original Rhythm Composition",
        "objective": "Practice composing, notating (with simple symbols), and performing an original layered rhythm piece.",
        "materials": ["Household items to tap as instruments", "Paper and pencil for simple rhythm notation"],
        "steps": [
            "In small groups, invent a rhythm piece with at least 3 layered parts.",
            "Write your rhythm down using simple symbols you invent together (like X for a tap, O for a pause).",
            "Practice reading your own notation while performing the piece.",
            "Perform for another group and share your notation so they can try to read it too.",
        ],
        "tip": "Inventing your own simple symbols is exactly how real composers first sketch out new music.",
    },
]


GAMES[5] = [
    {
        "name": "\U0001F4DA Round-Robin Chapter Story",
        "objective": "Practice co-authoring a multi-chapter story where each writer controls one character's chapter.",
        "materials": ["Paper", "Pencil", "A shared character list (3-4 characters)"],
        "steps": [
            "As a group, invent 3-4 characters and one shared setting.",
            "Each writer takes one character and writes a short chapter from that character's point of view.",
            "Pass chapters around so everyone reads what happened before writing the next chapter.",
            "Combine all chapters into one full story and read it aloud together.",
        ],
        "tip": "Staying true to your character's personality, even when the plot gets surprising, keeps the story consistent.",
    },
    {
        "name": "\U0001F5BC\uFE0F Constraint Mural Relay",
        "objective": "Practice contributing to a group mural while following one shared visual rule the whole time.",
        "materials": ["1 long roll or taped-together sheets of paper", "Crayons or markers", "A visual constraint (e.g., 'everything must be drawn using only straight lines')"],
        "steps": [
            "Agree on one visual constraint for the entire mural before starting.",
            "Each artist adds a new section to the growing scene, following the constraint.",
            "Pass the mural along until everyone has added at least one section.",
            "Step back and look at the finished mural -- discuss how the constraint shaped the whole piece.",
        ],
        "tip": "A shared rule like 'only straight lines' can turn a very different-looking mural into one that feels connected.",
    },
    {
        "name": "\U0001F3A8 Reverse Draw & Guess",
        "objective": "Practice guessing a hidden word by asking only yes/no questions about a partner's drawing.",
        "materials": ["Paper", "Crayons or markers", "Word cards"],
        "steps": [
            "One artist draws a secret word's clues in complete silence.",
            "Guessers can only ask yes/no questions about the drawing -- no shouting random guesses.",
            "The artist answers only by nodding, shaking their head, or adding to the drawing.",
            "See how few questions it takes to guess correctly, then switch artists.",
        ],
        "tip": "Asking about big details first (Is it an animal? Is it alive?) narrows things down fastest.",
    },
    {
        "name": "\u270B Gesture Drawing Sprint",
        "objective": "Practice quickly capturing the overall motion and shape of a pose rather than fine details.",
        "materials": ["Paper", "Pencil or crayon", "A timer", "A partner to pose"],
        "steps": [
            "One partner strikes an active pose (like mid-jump or reaching) for 30 seconds.",
            "The other quickly sketches only the overall motion and shape -- no details, no erasing.",
            "Switch roles and try a new pose each round.",
            "Compare a few sketches at the end and notice how the quick lines still capture movement.",
        ],
        "tip": "Working fast on purpose stops you from getting stuck on small details -- big shapes first.",
    },
    {
        "name": "\U0001F483 Story-Told-Through-Dance",
        "objective": "Practice choreographing a short movement sequence that tells a specific story without words.",
        "materials": ["Music player or phone with speaker", "A simple story outline (3 events)"],
        "steps": [
            "Agree on a 3-event story to tell (e.g., a seed grows into a tree in a storm).",
            "As a group, choreograph movements for each event, set to music.",
            "Practice the full sequence a few times until the events are clear.",
            "Perform for an audience and ask if they could follow the story.",
        ],
        "tip": "Bigger, clearer movements read better to an audience than small, subtle ones.",
    },
    {
        "name": "\U0001F44F Polyrhythm Partners",
        "objective": "Practice performing two different but complementary rhythm patterns at the same time.",
        "materials": ["None -- just your hands and voice"],
        "steps": [
            "Pair up and each choose a different simple rhythm pattern.",
            "Practice your own pattern alone until it's steady.",
            "Perform both patterns together at the same time, listening for how they fit together.",
            "Switch patterns with your partner and try the new combination.",
        ],
        "tip": "Focusing on your own steady beat, without matching your partner's, is the key skill here.",
    },
    {
        "name": "\U0001F3A7 Layered Soundscape Composition",
        "objective": "Practice designing and performing a multi-layered soundscape with intentional structure (build, climax, fade).",
        "materials": ["6-8 varied sound objects"],
        "steps": [
            "As a group, choose a scene with a clear emotional arc (a calm morning that turns into a thunderstorm).",
            "Plan which sounds represent the beginning (calm), middle (building), and end (fading) of the arc.",
            "Perform the full soundscape live, following your planned structure.",
            "Reflect: did the structure come through clearly to a listener with their eyes closed?",
        ],
        "tip": "Planning where your soundscape builds and where it fades is what turns random noises into a composition.",
    },
    {
        "name": "\U0001FA9E Delayed Mirror Challenge",
        "objective": "Practice mirroring a partner's movement sequence from memory, with a delay, rather than in real time.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Partner A performs a short movement sequence (5-6 moves) once, fully.",
            "Partner B watches without moving, then performs the entire sequence back from memory.",
            "Partner A checks how accurately the sequence was mirrored.",
            "Switch roles with a new, slightly longer sequence, then reflect on what helped you remember the moves.",
        ],
        "tip": "Breaking the sequence into smaller chunks in your mind makes it much easier to recall.",
    },
    {
        "name": "\U0001F3AD Genre-Constrained Charades",
        "objective": "Practice acting out a prompt while committing to a specific performance genre or style.",
        "materials": ["Prompt cards", "Genre cards (silent-film era, slow-motion, exaggerated musical)"],
        "steps": [
            "Draw one prompt card and one genre card.",
            "Act out the prompt fully committed to the genre style the whole time (e.g., acting 'making a sandwich' in slow motion).",
            "Teammates guess both the prompt and the genre being used.",
            "Reflect: how did the genre constraint change the way you performed the same prompt?",
        ],
        "tip": "Full commitment to the genre -- even when it feels silly -- is what sells the performance.",
    },
    {
        "name": "\U0001F3A2 Extended Emotional Arc Improv",
        "objective": "Practice improvising a longer wordless scene that develops through several connected emotional stages.",
        "materials": ["An emotion-arc card with 4-5 stages"],
        "steps": [
            "Draw a 4-5 stage emotion-arc card (e.g., 'curious to confused to frustrated to determined to relieved').",
            "Improvise a single continuous silent scene that moves believably through every stage in order.",
            "Ask an audience to identify each stage as it happened.",
            "Reflect together: which transition between emotions was hardest to make believable, and why?",
        ],
        "tip": "Giving each emotional stage a clear physical change -- posture, breathing, pace -- helps the audience follow the arc.",
    },
    {
        "name": "\U0001F5FF Abstract Concept Tableau",
        "objective": "Practice using group tableau to represent an abstract idea rather than a literal scene.",
        "materials": ["Abstract concept cards (change, conflict, community, hope)"],
        "steps": [
            "Draw an abstract concept card as a group.",
            "Without discussing out loud, each person finds a pose that represents part of the concept.",
            "Freeze together into one combined tableau.",
            "Reveal the concept to an audience and reflect on which poses read clearly and which needed explaining.",
        ],
        "tip": "Abstract ideas often come through best when poses show relationships between people, not just individual actions.",
    },
    {
        "name": "\U0001F3B2 Unreliable Narrator Dice",
        "objective": "Practice writing a short story from the point of view of a narrator who isn't telling the full truth.",
        "materials": ["Story-prompt cards", "Paper and pencil"],
        "steps": [
            "Draw a story prompt and decide on a narrator who has a reason to hide or twist part of the truth.",
            "Write the story fully in that narrator's voice, including subtle hints that something's being left out.",
            "Read your story aloud without revealing the twist first.",
            "Ask listeners what clues tipped them off, then reflect on which hints worked best.",
        ],
        "tip": "Small, specific details that don't quite add up are more convincing than an obvious lie.",
    },
    {
        "name": "\U0001F514 Foley Composition Critique",
        "objective": "Practice designing a soundtrack for a story, then giving and receiving constructive feedback on the choices.",
        "materials": ["A short written story or script", "6-8 sound-effect objects"],
        "steps": [
            "In small groups, design and perform a full sound-effect track for the same short story.",
            "Each group performs their version for the others.",
            "Give specific, kind feedback: one sound choice that worked well, and one idea for how it could be even better.",
            "Revise your track based on the feedback and perform it once more.",
        ],
        "tip": "Specific feedback (like 'the rain sound came in too early') helps far more than a general 'good job.'",
    },
    {
        "name": "\U0001F941 Multi-Part Rhythm Score",
        "objective": "Practice composing and notating a multi-part rhythm piece for a small ensemble, then reflecting on the process.",
        "materials": ["Household items to tap as instruments", "Paper and pencil for notation"],
        "steps": [
            "In small groups, compose a rhythm piece with at least 4 distinct parts that fit together.",
            "Write out a simple notation system so anyone could learn to play each part.",
            "Teach your notation to another group and have them perform your piece.",
            "Reflect together: what was hardest about explaining your rhythm to someone who didn't compose it?",
        ],
        "tip": "If someone else can play your piece just from your notation, you've written it clearly.",
    },
]


GAMES[6] = [
    {
        "name": "\U0001F4DA Frame Story Collaboration",
        "objective": "Practice constructing a story-within-a-story where an outer narrator introduces an inner tale.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "As a group, invent an outer narrator character and a reason they're telling a story (e.g., around a campfire).",
            "Write the outer narrator's short introduction together.",
            "Each writer then contributes a section of the 'inner story' the narrator is telling.",
            "Close with the outer narrator's reaction, then reflect on how the frame changed how you experienced the inner story.",
        ],
        "tip": "A frame story lets you comment on the story itself -- notice how the narrator's reactions shape the meaning.",
    },
    {
        "name": "\U0001F5BC\uFE0F Constraint-Swap Mural",
        "objective": "Practice adapting to a changing artistic constraint mid-project and maintaining visual coherence.",
        "materials": ["1 long roll or taped-together sheets of paper", "Crayons, markers, or paint", "Two different constraint cards"],
        "steps": [
            "Start the mural under constraint 1 (e.g., 'monochrome color scheme') for the first half.",
            "Partway through, reveal constraint 2 (e.g., 'add one wildly different color') and adapt the rest of the mural to include it.",
            "Finish the mural working to blend both halves so it still feels like one connected piece.",
            "Reflect: what choices did you make to keep the mural feeling unified despite the constraint change?",
        ],
        "tip": "A visual bridge -- a shape or color repeated on both sides -- can tie two very different halves together.",
    },
    {
        "name": "\U0001F3A8 Metaphor Draw & Guess",
        "objective": "Practice drawing a metaphor or idiom literally so a partner has to decode the intended meaning.",
        "materials": ["Paper", "Crayons or markers", "Idiom/metaphor cards (e.g., 'break the ice,' 'time flies')"],
        "steps": [
            "Draw an idiom card and sketch it completely literally -- exactly what the words say, not what they mean.",
            "Show the drawing to a partner, who has to guess the real idiom and its actual meaning.",
            "Discuss how the literal drawing was funny or confusing compared to the real meaning.",
            "Switch roles and pick a new idiom.",
        ],
        "tip": "The gap between the literal drawing and the real meaning is exactly what makes idioms fun to illustrate.",
    },
    {
        "name": "\u270B Continuous-Line Self-Portrait",
        "objective": "Practice sustained self-observation while drawing under a strict technical constraint.",
        "materials": ["Paper", "Pencil", "A mirror"],
        "steps": [
            "Set up a mirror so you can see your own face clearly.",
            "Draw a self-portrait without ever lifting your pencil off the paper, for the entire drawing.",
            "Keep looking back and forth between the mirror and your paper as you go.",
            "Reflect: what did you notice about your own face that you don't usually pay attention to?",
        ],
        "tip": "This drawing isn't meant to look 'accurate' -- the noticing is the real point of the exercise.",
    },
    {
        "name": "\U0001F483 Structured Improvisation Piece",
        "objective": "Practice improvising within a set structure (a fixed beginning and ending, open middle) as a group.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "As a group, plan and practice one fixed opening pose and one fixed closing pose.",
            "Everything in between is fully improvised live, with no rehearsal, as the music plays.",
            "Perform the piece once, hitting your planned start and end exactly.",
            "Reflect: how did having a planned start and end change how free the improvised middle felt?",
        ],
        "tip": "A little bit of planned structure can actually make the improvised parts feel more confident, not less.",
    },
    {
        "name": "\U0001F44F Odd-Meter Rhythm Challenge",
        "objective": "Practice composing and performing a rhythm piece in an unusual, non-standard beat grouping.",
        "materials": ["None -- just your hands and voice"],
        "steps": [
            "As a group, choose an odd beat grouping to work in (like groups of 5 or 7 instead of the usual 4).",
            "Compose a short rhythm pattern that fits your chosen grouping exactly.",
            "Practice until the whole group can perform it together without losing the count.",
            "Perform for another group, then reflect on what made counting an unusual grouping harder or easier than expected.",
        ],
        "tip": "Counting out loud together at first, then gradually going silent, helps the group internalize an odd rhythm.",
    },
    {
        "name": "\U0001F3A7 Story Without Narration Soundscape",
        "objective": "Practice telling a complete story using only layered sound effects, with no spoken narration at all.",
        "materials": ["6-10 varied sound objects"],
        "steps": [
            "As a group, plan a story with a clear beginning, middle, and end -- but agree not to use any spoken words.",
            "Decide which sounds represent each story beat and rehearse the order and timing.",
            "Perform the full soundscape for listeners with their eyes closed, no narration.",
            "Ask listeners to describe the story they imagined, then reflect on what came through clearly versus what confused them.",
        ],
        "tip": "Without narration, timing and silence do as much storytelling work as the sounds themselves.",
    },
    {
        "name": "\U0001FA9E Ensemble Mirror Wave",
        "objective": "Practice mirroring in a larger group where a movement ripples outward from one leader.",
        "materials": ["None -- just a group and open space"],
        "steps": [
            "Stand in a loose circle or line, with one leader visible to everyone.",
            "The leader begins a slow movement sequence; the person next to them mirrors it a half-second behind, then the next person, rippling outward.",
            "Continue the wave all the way around or down the line.",
            "Reflect: what did it feel like to be in the middle of the wave versus starting or ending it?",
        ],
        "tip": "Watching the person right next to you, not the original leader, keeps the ripple effect smooth.",
    },
    {
        "name": "\U0001F3AD Status Swap Scene",
        "objective": "Practice performing a wordless scene where two characters' social status visibly shifts partway through.",
        "materials": ["Two character cards describing a relationship (e.g., 'boss and new employee')"],
        "steps": [
            "Pick two characters with a clear status difference (one has more power or confidence than the other).",
            "Improvise a silent scene where that status is obvious at first through posture and movement.",
            "Partway through, find a believable moment where the status flips -- the lower-status character gains the upper hand.",
            "Reflect with the audience on what physical choices (posture, pace, eye contact) signaled the status and the shift.",
        ],
        "tip": "Status is shown more through posture and movement than through facial expression alone -- stand differently to feel it.",
    },
    {
        "name": "\U0001F3A2 Contradiction Emotion Improv",
        "objective": "Practice performing a scene where your face shows one emotion while your body language shows a conflicting one.",
        "materials": ["Two emotion cards per performer"],
        "steps": [
            "Draw two emotion cards that contradict each other (e.g., face: 'calm,' body: 'panicked').",
            "Improvise a short silent scene maintaining both contradictory signals at once.",
            "Ask an audience to describe what they noticed and what feeling they believed most.",
            "Reflect: why might a person's face and body show two different feelings at the same time in real life?",
        ],
        "tip": "Real people often hide feelings this way -- this exercise makes that contradiction visible on purpose.",
    },
    {
        "name": "\U0001F5FF Symbolic Ensemble Sculpture",
        "objective": "Practice building a group tableau where the physical arrangement itself communicates the concept's meaning.",
        "materials": ["Abstract concept cards (isolation, collaboration, growth, balance)"],
        "steps": [
            "Draw an abstract concept card as a group.",
            "Discuss briefly how physical distance, height, and connection between bodies could represent the concept, then freeze into it.",
            "Present the tableau to an audience without explaining it first.",
            "Reflect together on which physical choices (who was close, who was high or low, who was facing away) carried the most meaning.",
        ],
        "tip": "Distance and level (standing versus crouching) often communicate a concept more powerfully than facial expression can.",
    },
    {
        "name": "\U0001F3B2 Multi-Genre Story Remix",
        "objective": "Practice retelling the exact same plot events in two completely different genres, then comparing the effect.",
        "materials": ["A shared short plot outline", "Two genre cards", "Paper and pencil"],
        "steps": [
            "As a group, agree on one simple plot outline (a character loses something important and searches for it).",
            "Draw two very different genre cards (e.g., 'horror' and 'comedy') and write the SAME plot once in each genre.",
            "Read both versions aloud back to back.",
            "Reflect: which specific word choices or details changed the most between the two genre versions?",
        ],
        "tip": "The events can stay identical -- genre lives mostly in word choice, pacing, and tone, not plot.",
    },
    {
        "name": "\U0001F514 Full Soundtrack Design Review",
        "objective": "Practice designing a complete layered soundtrack for a scene, then presenting and defending creative choices.",
        "materials": ["A short written scene or script", "8-10 sound-effect objects"],
        "steps": [
            "In small groups, design a full soundtrack (multiple layered sounds, not just one at a time) for the same scene.",
            "Perform your soundtrack for the other groups.",
            "After each performance, the group explains WHY they chose each key sound, not just what it was.",
            "As an audience, ask one respectful question about a choice you're curious about, then reflect on how explaining your reasoning changed your own understanding of your choices.",
        ],
        "tip": "Being able to explain 'why' a sound choice works is often harder -- and more valuable -- than making the choice itself.",
    },
    {
        "name": "\U0001F941 Original Score for a Silent Scene",
        "objective": "Practice composing an original rhythm piece specifically timed to accompany a silent performed scene.",
        "materials": ["Household items to tap as instruments", "A short planned silent scene (performed by other group members)"],
        "steps": [
            "One small group plans and rehearses a short silent scene.",
            "Another small group composes a rhythm piece, watching the scene and timing specific hits to key moments in the action.",
            "Perform the scene and the live rhythm score together for the first time.",
            "Reflect together: which moments in the scene were hardest to time the music to, and why?",
        ],
        "tip": "Watching the performers' bodies for a clear physical cue -- not just guessing the timing -- is the composer's best tool.",
    },
]


GAMES[7] = GAMES[6]
GAMES[6] = [
    {
        "name": "\U0001F4DA Same Scene, Two Voices",
        "objective": "Practice retelling one shared scene from two different characters' points of view.",
        "materials": ["Paper", "Pencil", "A shared scene idea (e.g., a surprise birthday party)"],
        "steps": [
            "As a pair, agree on one short scene and what actually happens in it.",
            "Each writer writes that SAME scene once, but entirely from a different character's point of view.",
            "Read both versions aloud back to back.",
            "Discuss what details each narrator noticed, left out, or felt differently about.",
        ],
        "tip": "The same five minutes can feel completely different depending on whose eyes you're seeing it through.",
    },
    {
        "name": "\U0001F5BC️ Two-Rule Mural",
        "objective": "Practice keeping a mural visually unified while following two constraints at once.",
        "materials": ["1 long roll or taped-together sheets of paper", "Crayons or markers", "Two visual constraint cards (e.g., 'only circles' and 'only cool colors')"],
        "steps": [
            "Draw two constraint cards before starting and agree both apply to the whole mural.",
            "Each artist adds a new section, following both rules at the same time.",
            "Pass the mural along until everyone has added at least one section.",
            "Step back and discuss which constraint was harder to follow and why.",
        ],
        "tip": "When two rules pull in different directions, the interesting choices happen in how you compromise.",
    },
    {
        "name": "\U0001F3A8 Gesture-Only Draw & Guess",
        "objective": "Practice communicating a drawing's subject using only silent gestures, no words or nodding.",
        "materials": ["Paper", "Crayons or markers", "Word cards"],
        "steps": [
            "One artist draws a secret word's clues in complete silence.",
            "Guessers may only respond with gestures too -- no talking, no yes/no words from either side.",
            "Keep going until the word is guessed, using only drawing and gesture the whole time.",
            "Switch artists and reflect on which gestures ended up doing the most work.",
        ],
        "tip": "Pointing, shaking your head, and exaggerated shrugs can carry a surprising amount of meaning.",
    },
    {
        "name": "✋ One-Minute Motion Study",
        "objective": "Practice sketching a moving subject's changing shape across several short timed poses.",
        "materials": ["Paper", "Pencil or crayon", "A timer", "A partner to pose"],
        "steps": [
            "One partner performs a slow one-minute movement (like a stretch or a slow spin).",
            "The other sketches 3-4 quick snapshots of the shape at different moments during that minute.",
            "Compare the snapshots side by side to see the movement's path.",
            "Switch roles and try a movement with a different kind of shape change.",
        ],
        "tip": "You're not drawing one pose -- you're drawing how one shape turns into the next.",
    },
    {
        "name": "\U0001F483 Story-Through-Dance Duet",
        "objective": "Practice choreographing a short duet that shows a relationship changing between two characters.",
        "materials": ["Music player or phone with speaker", "A simple relationship idea (e.g., strangers becoming friends)"],
        "steps": [
            "As a pair, agree on how a relationship between two characters changes over a short dance.",
            "Choreograph movements that show the characters starting apart and ending connected (or vice versa).",
            "Practice the sequence a few times, then perform it for an audience.",
            "Ask the audience what they thought the relationship was, and how they could tell it changed.",
        ],
        "tip": "Distance and eye contact between dancers often tell the relationship story more than the steps themselves.",
    },
    {
        "name": "\U0001F44F Call-and-Response Rhythm Chain",
        "objective": "Practice inventing and extending a rhythm pattern as a group, one new addition at a time.",
        "materials": ["None -- just your hands and voice"],
        "steps": [
            "First player claps a short 2-beat pattern.",
            "Next player repeats it exactly, then adds one new beat of their own.",
            "Keep going around the group, each person repeating the whole growing chain before adding to it.",
            "See how long the chain gets before someone needs a group replay to remember it all.",
        ],
        "tip": "Saying the pattern in your head as a little rhythm word (like 'ta-ta-TUM') makes it much easier to hold onto.",
    },
    {
        "name": "\U0001F3A7 Two-Scene Soundscape Switch",
        "objective": "Practice smoothly transitioning a soundscape from one setting to a completely different one.",
        "materials": ["6-8 varied sound objects"],
        "steps": [
            "As a group, pick two very different settings (like a quiet library and a busy street).",
            "Plan sounds for each setting, plus a short transition moment that bridges them.",
            "Perform the full soundscape live, moving from setting one to setting two through your transition.",
            "Ask a listener with eyes closed if they could tell exactly when the setting changed.",
        ],
        "tip": "A transition sound that could belong to either setting (like a door, or footsteps) makes the switch feel natural.",
    },
    {
        "name": "\U0001FA9E Mirror With a Twist",
        "objective": "Practice mirroring a partner's movement sequence while one small rule changes it on purpose.",
        "materials": ["None -- just a partner and open space"],
        "steps": [
            "Partner A performs a short movement sequence (4-5 moves).",
            "Partner B mirrors it back, but with one agreed twist -- like mirroring everything in slow motion, or backwards.",
            "Partner A checks whether the twist rule was followed consistently, not just the moves.",
            "Switch roles with a new twist rule and reflect on which twist was hardest to keep track of.",
        ],
        "tip": "Committing fully to the twist -- even if it makes you slower -- reads more clearly than doing it halfway.",
    },
    {
        "name": "\U0001F3AD Style-Shift Scene",
        "objective": "Practice performing the same short scene twice, shifting performance style partway through on a cue.",
        "materials": ["Prompt cards", "Two contrasting style cards (e.g., 'overly dramatic' and 'totally bored')"],
        "steps": [
            "Draw a scene prompt and two contrasting style cards.",
            "Perform the scene in the first style, then on a partner's clap, snap instantly into the second style mid-scene.",
            "Keep the same words and actions -- only the style changes.",
            "Reflect on how much the style shift changed how the scene felt, even though nothing else did.",
        ],
        "tip": "Voice, pace, and posture carry style even more than facial expression does -- change those first.",
    },
    {
        "name": "\U0001F3A2 Shared Emotion, Two Reactions",
        "objective": "Practice improvising a scene where two characters feel the same emotion but express it in opposite ways.",
        "materials": ["An emotion card"],
        "steps": [
            "Draw one emotion card that both characters will secretly be feeling (like nervousness).",
            "Improvise a silent scene where one character shows the emotion loudly and the other hides it completely.",
            "Ask an audience to guess the shared emotion and which character was hiding it.",
            "Reflect on how the same feeling can look completely different from person to person.",
        ],
        "tip": "A character 'hiding' a feeling usually leaks it out in one small detail -- a tapping foot, a tight jaw.",
    },
    {
        "name": "\U0001F5FF Before-and-After Tableau",
        "objective": "Practice building two connected group tableaus that show a clear before-and-after moment.",
        "materials": ["Abstract concept or event cards (a storm passing, a team winning)"],
        "steps": [
            "Draw a concept or event card as a group.",
            "Build a frozen tableau for the 'before' moment, then a second one for the 'after' moment.",
            "Perform both, holding a brief pause in between, for an audience.",
            "Ask the audience to describe what changed between the two tableaus and how they could tell.",
        ],
        "tip": "Changing just a few people's positions between the two tableaus can tell the whole story of the change.",
    },
    {
        "name": "\U0001F3B2 Twist Ending Dice",
        "objective": "Practice writing a short story that sets up one expected ending, then delivers a different, fair twist.",
        "materials": ["Story-prompt cards", "Paper and pencil"],
        "steps": [
            "Draw a story prompt and plan an ending readers would naturally expect.",
            "Write the story so it seems to be heading toward that ending, but plant 2-3 small honest clues toward a different twist.",
            "Read the story aloud, stopping right before the ending to let listeners guess.",
            "Reveal the twist and ask which clues they noticed -- or missed.",
        ],
        "tip": "A fair twist uses clues the reader could have caught -- it shouldn't come from nowhere.",
    },
    {
        "name": "\U0001F514 Two-Group Sound Match",
        "objective": "Practice designing a soundtrack for a scene, then comparing choices with a group who did the same scene differently.",
        "materials": ["A short written story or script", "6-8 sound-effect objects per group"],
        "steps": [
            "Split into two groups and each design a full sound-effect track for the exact same short story.",
            "Perform both versions back to back for everyone.",
            "As a full group, list every sound choice that was different between the two versions.",
            "Discuss which different choices worked equally well, and why more than one right answer can exist.",
        ],
        "tip": "Two very different sound choices can both be 'correct' if they both make the scene feel real.",
    },
    {
        "name": "\U0001F941 Layered Rhythm Build",
        "objective": "Practice composing a rhythm piece that adds one new layer at a time until the full group is playing together.",
        "materials": ["Household items to tap as instruments"],
        "steps": [
            "In a small group, each person invents their own simple, steady rhythm pattern.",
            "Starting with just one player, add one new player's pattern every 4 counts until everyone is layered in.",
            "Hold the full layered pattern for a while, then reverse the order, removing players one at a time.",
            "Reflect on which combination of layers sounded the fullest, and which felt the most cluttered.",
        ],
        "tip": "Keeping your own pattern rock-steady, even as new layers join around you, is the real challenge here.",
    },
]  # 5th grade — calibrated between GAMES[5] (4th) and GAMES[7] (6th, originally authored as GAMES[6])


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    # Plain ASCII " | " separator -- a non-ASCII middle-dot separator here
    # previously got double-UTF8-encoded somewhere in the sqlcmd/ODBC file-
    # reading pipeline (confirmed live: " . " landed in the DB as the
    # literal 4-character sequence " A. "), and a plain comma is
    # ambiguous since several material descriptions already contain commas
    # inside their own parenthetical text (e.g. "(leaf, rock, flower...)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 76_arts_games_content.sql")
    out.append("-- Adds a 'Creative Arts Games' category to the existing always-on 'arts'")
    out.append("-- subject_area for every grade (TK-6th) -- no schema or proc changes needed,")
    out.append("-- reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games spanning the three already-shipped")
    out.append("-- 'arts' themes (Creative Writing & Storytelling, Music & Performing Arts,")
    out.append("-- Visual Art Appreciation & Drawing); target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's arts category")
    out.append("-- is selected, satisfying \"7 games, different set each week\" without any")
    out.append("-- manual per-week authoring.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print -- see 63_whole_child_rotation.sql). answer_text")
    out.append("-- carries a short encouraging tip about creativity/self-expression.")
    out.append("-- See gen_76_arts_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'arts' AND category_name = N'Creative Arts Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_arts_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'arts', N'Creative Arts Games', 'space_heavy', 7, N'Get creative with a fun art, music, or storytelling game!', 0);"
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
            if not (3 <= len(game.get("steps", [])) <= 5):
                print(f"STEP COUNT out of 3-5 range in grade {GRADE_LABELS[grade_id]} game {game.get('name')} ({len(game.get('steps', []))} steps)")
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
    # This bit the team for real on the outdoor-games batch before catching it.
    with open(r"D:\Project\www\littlescholarhub\lsh.database\76_arts_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 76_arts_games_content.sql", file=sys.stderr)
