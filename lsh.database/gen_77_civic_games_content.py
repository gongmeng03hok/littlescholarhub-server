# -*- coding: utf-8 -*-
"""
Generates lsh.database/77_civic_games_content.sql — adds a "Community &
Civics Games" category to the existing 'civic' subject_area (already
shipped via 67_civic_humor_character_culture_content.sql — no schema/proc
changes needed) for every grade TK-6th. Each grade gets a pool of 14
hand-crafted games spanning the civic subject area's existing themes
(Civics & Government, Community & Global Citizenship, Public Speaking &
Debate); the existing rotation samples 7 of them (via target_count=7,
ORDER BY NEWID()) fresh each week a grade's civic category is picked, so
consecutive weeks show a different set without any manual "week 1 / week
2" authoring. See gen_68_outdoor_games_content.py, this file's proven
template.

Content rule: strictly nonpartisan and non-controversial. No real
political parties, no real politicians of any era, no real-world
divisive social/political issues. Voting/election mechanics are always
generic-process (how does voting work), and debate topics are always
lighthearted (best pizza topping, cats vs dogs, best season, etc.).

Run with: python gen_77_civic_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🗳️ Raise Your Hand Vote",
        "objective": "Practice voting by raising a hand to help the group choose something together.",
        "materials": ["None — just a group and raised hands"],
        "steps": [
            "Grown-up asks a fun question, like 'Story time or song time first?'",
            "Everyone raises a hand for their favorite choice.",
            "Count the hands together out loud.",
            "Whichever choice has more hands wins — do that one first!",
        ],
        "tip": "Every raised hand helps the whole group decide together!",
    },
    {
        "name": "👩‍⚕️ Community Helper Dress-Up",
        "objective": "Practice recognizing community helpers by dressing up and acting out their jobs.",
        "materials": ["Dress-up clothes or simple props (hat, toy stethoscope, etc.)", "A few stuffed animals as 'patients' or 'customers'"],
        "steps": [
            "Pick a community helper to be, like a doctor, firefighter, or mail carrier.",
            "Put on a simple costume piece or grab a matching prop.",
            "Act out one thing that helper does to help people.",
            "Take turns being a different helper!",
        ],
        "tip": "Community helpers take care of us every single day!",
    },
    {
        "name": "🤝 Kindness Helper Hunt",
        "objective": "Practice noticing simple ways to help family members around the house.",
        "materials": ["None — just your home and a grown-up"],
        "steps": [
            "Grown-up names someone in the house who might need a small hand.",
            "Think of one gentle way to help them, like carrying a napkin or picking up a toy.",
            "Go do that one kind thing together.",
            "Give each other a high five when it's done!",
        ],
        "tip": "Small kind acts make a big difference to the people we love!",
    },
    {
        "name": "🍕 Pizza vs Ice Cream Cheer",
        "objective": "Practice sharing a simple opinion out loud in a fun, friendly way.",
        "materials": ["None — just a group of friends or family"],
        "steps": [
            "Grown-up asks: pizza or ice cream — which do you like best?",
            "Walk to one side of the room for pizza, the other side for ice cream.",
            "Everyone says one word about why they picked their side, like 'cheesy!' or 'yummy!'",
            "Cheer for both sides — everyone's favorite is okay!",
        ],
        "tip": "It's fun to share what you like, even when friends pick something different!",
    },
    {
        "name": "🌍 Spin the Globe Friends",
        "objective": "Practice noticing that children all over the world live in different kinds of communities.",
        "materials": ["A globe, world map, or picture book about the world"],
        "steps": [
            "Grown-up spins the globe or opens the map.",
            "Stop it gently with a finger on a spot.",
            "Imagine a kid living there — what might their house or school look like?",
            "Try again and imagine a different faraway friend!",
        ],
        "tip": "There are friendly kids just like you living all around the world!",
    },
    {
        "name": "📫 Mail Carrier Delivery Game",
        "objective": "Practice the mail carrier's job by delivering pretend letters around the house.",
        "materials": ["A few pieces of paper folded like letters", "A small bag or basket"],
        "steps": [
            "Put a few paper 'letters' in your delivery bag.",
            "Walk to each family member's favorite spot in the house.",
            "Hand them their letter with a smile, just like a mail carrier.",
            "Say 'Special delivery!' each time you deliver one.",
        ],
        "tip": "Mail carriers help people stay connected to each other!",
    },
    {
        "name": "🚒 Helper Sounds Match",
        "objective": "Practice matching sounds to the community helpers who make them.",
        "materials": ["None — just your voice and imagination"],
        "steps": [
            "Grown-up makes a sound, like a siren 'wee-oo' or a whistle.",
            "Guess which helper makes that sound — firefighter, police officer, crossing guard?",
            "Act out that helper for a few seconds.",
            "Take turns making the next sound!",
        ],
        "tip": "Helpers use sounds and signals to keep everyone safe!",
    },
    {
        "name": "🧺 Neighbor Basket Pass",
        "objective": "Practice naming helpful items and how they can be used to help a neighbor.",
        "materials": ["A small basket", "3-4 simple household items (a spoon, a bandage, a toy, a blanket)"],
        "steps": [
            "Sit in a circle and put the basket in the middle.",
            "Take turns picking one item from the basket.",
            "Say one way that item could help a neighbor.",
            "Pass the basket to the next friend.",
        ],
        "tip": "Even everyday items can help us take care of each other!",
    },
    {
        "name": "✋ Thumbs Up Town Meeting",
        "objective": "Practice a simple group decision using thumbs up or thumbs down.",
        "materials": ["None — just a group and thumbs"],
        "steps": [
            "Grown-up brings up a silly choice, like 'Should we have snack time before or after story time?'",
            "Everyone shows thumbs up for one choice, thumbs down for the other.",
            "Count the thumbs together.",
            "Go with whichever choice got more thumbs up!",
        ],
        "tip": "Meetings help a whole group make a choice together!",
    },
    {
        "name": "🎨 Community Helper Coloring Match",
        "objective": "Practice matching community helpers to the tools they use.",
        "materials": ["Simple pictures or cutouts of helpers (firefighter, doctor, teacher)", "Matching pictures of their tools (hose, stethoscope, book)", "Crayons (optional)"],
        "steps": [
            "Spread out the helper pictures and the tool pictures.",
            "Look at each helper and think about what tool they use.",
            "Match each tool picture next to the correct helper.",
            "Color your favorite helper when you're done!",
        ],
        "tip": "Every helper has special tools that help them do their job!",
    },
    {
        "name": "🐶 Take Turns Circle",
        "objective": "Practice waiting patiently and listening while each friend gets a turn to talk.",
        "materials": ["A soft toy or small object to pass around"],
        "steps": [
            "Sit together in a circle.",
            "Whoever is holding the toy gets to talk — everyone else listens quietly.",
            "Share something simple, like your favorite color.",
            "Pass the toy gently to the next friend.",
        ],
        "tip": "Listening to a friend is just as important as talking!",
    },
    {
        "name": "🏘️ Build-a-Block Town",
        "objective": "Practice imagining how a community fits together by building a pretend town.",
        "materials": ["Building blocks or empty boxes", "Small toy people (optional)"],
        "steps": [
            "Build a few simple buildings out of blocks, like a house, a school, and a store.",
            "Name each building and who might work there.",
            "Move a toy person around the town, 'visiting' each building.",
            "Add a new building together!",
        ],
        "tip": "A town works best when every building has a helpful job!",
    },
    {
        "name": "🎈 Balloon Ballot Box",
        "objective": "Practice an early version of voting by dropping a choice into a box.",
        "materials": ["An empty box or bowl", "Small paper balls or pom-poms in 2 colors"],
        "steps": [
            "Grown-up names two color choices, like red or blue.",
            "Pick your favorite color's paper ball.",
            "Drop it into the ballot box.",
            "Count together how many of each color are inside!",
        ],
        "tip": "Dropping in your choice is a fun way to be part of a group decision!",
    },
    {
        "name": "🚦 Helper Freeze Dance",
        "objective": "Practice recognizing community helpers by freezing into their pose during a dance game.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "Turn on music and dance around freely.",
            "When the music stops, freeze like a community helper — a firefighter holding a hose, a doctor listening with a stethoscope.",
            "Grown-up guesses which helper you're being.",
            "Turn the music back on and pick a new helper next time!",
        ],
        "tip": "Community helpers come in all shapes, sizes, and jobs!",
    },
]


GAMES[1] = [
    {
        "name": "🗳️ Class Snack Vote",
        "objective": "Practice voting between two choices and counting the results together.",
        "materials": ["Paper and pencil (for tally marks)"],
        "steps": [
            "Pick two snack choices, like crackers or fruit.",
            "Each person raises a hand for their favorite.",
            "Make a tally mark for each vote on paper.",
            "Count the tally marks — the snack with more marks wins!",
        ],
        "tip": "Counting every vote makes sure everyone's choice is heard!",
    },
    {
        "name": "👷 Helper Charades",
        "objective": "Practice acting out and recognizing different community helper jobs.",
        "materials": ["Index cards with helper names or pictures (firefighter, teacher, doctor, mail carrier)"],
        "steps": [
            "Pick a card without showing anyone.",
            "Act out that helper's job using only actions, no talking.",
            "Everyone else guesses which helper you're acting out.",
            "Take turns picking a new card!",
        ],
        "tip": "You can recognize a helper's job just by watching what they do!",
    },
    {
        "name": "🤗 Helping Hands Chain",
        "objective": "Practice thinking of kind ways to help others and sharing ideas out loud.",
        "materials": ["Paper strips", "Tape or glue", "Markers"],
        "steps": [
            "Think of one kind thing you could do for someone this week.",
            "Draw or write it on a paper strip.",
            "Loop the strip and tape it into a chain link.",
            "Connect your link to a friend's to build a kindness chain!",
        ],
        "tip": "Kindness grows bigger every time it's shared, just like this chain!",
    },
    {
        "name": "🐱 Cats vs Dogs Cheer-Off",
        "objective": "Practice sharing a simple opinion and one reason for it in front of a group.",
        "materials": ["None — just a group of friends"],
        "steps": [
            "Split into two groups: Team Cats and Team Dogs.",
            "Each team huddles for a moment to think of one reason their pick is great.",
            "Each team shouts their reason together, like 'Dogs play fetch!'",
            "Clap for both teams — both answers are great!",
        ],
        "tip": "Sharing why you like something helps others understand you better!",
    },
    {
        "name": "🗺️ Around-the-World Match Game",
        "objective": "Practice matching homes, foods, or clothing to different communities around the world.",
        "materials": ["Picture cards of homes/foods/clothing from a few different countries"],
        "steps": [
            "Spread out the picture cards.",
            "Look closely at each picture and notice what's different or similar to your own home.",
            "Sort the cards into small groups by country or region.",
            "Share one thing you noticed with a friend!",
        ],
        "tip": "Communities around the world can look different but share the same kindness!",
    },
    {
        "name": "📬 Neighborhood Delivery Relay",
        "objective": "Practice teamwork by delivering pretend mail to labeled stations.",
        "materials": ["A few labeled 'house' stations (paper signs)", "Pretend letters (folded paper)", "A small basket per team"],
        "steps": [
            "Set up 3-4 labeled house stations around the room or yard.",
            "Split into small teams, each with a basket of letters.",
            "Take turns running one letter at a time to the matching house.",
            "First team to deliver all their mail wins!",
        ],
        "tip": "Mail carriers help every house in the neighborhood, one at a time!",
    },
    {
        "name": "🚑 Helper Tool Sort",
        "objective": "Practice sorting tools by which community helper uses them.",
        "materials": ["Pictures or toy versions of tools (stethoscope, hose, badge, book)", "Labeled sorting spots for each helper"],
        "steps": [
            "Lay out the labeled helper spots.",
            "Look at each tool and decide which helper would use it.",
            "Place the tool in the matching helper's spot.",
            "Check your work together when all tools are sorted!",
        ],
        "tip": "Every tool has a helper who knows exactly how to use it!",
    },
    {
        "name": "🙋 Ballot Box Basics",
        "objective": "Practice an early voting process by writing a choice on paper and placing it in a box.",
        "materials": ["Small paper slips", "Pencils", "A box or container"],
        "steps": [
            "Grown-up asks a fun question, like your favorite color.",
            "Write or draw your answer on a paper slip.",
            "Fold it and place it in the ballot box.",
            "Open all the slips together and count each answer!",
        ],
        "tip": "A ballot box lets everyone share their choice, one at a time!",
    },
    {
        "name": "🏫 Classroom Rules Vote",
        "objective": "Practice making a group decision about a simple rule for game time.",
        "materials": ["Paper and marker (to write the winning rule)"],
        "steps": [
            "Think of two friendly options for a game-time rule, like 'quiet music' or 'no music.'",
            "Everyone votes with a raised hand for their choice.",
            "Count the votes and announce the winner.",
            "Write the new rule down and follow it during your next game!",
        ],
        "tip": "Rules feel fairer when everyone gets to help choose them!",
    },
    {
        "name": "🌎 Global Friends Circle",
        "objective": "Practice learning and sharing a simple fact about kids in another country.",
        "materials": ["A book or picture about children in another country"],
        "steps": [
            "Grown-up shares one fun fact about kids somewhere else in the world.",
            "Sit in a circle and talk about how it's similar or different from your day.",
            "Take turns sharing what surprised you most.",
            "Thank each other for listening!",
        ],
        "tip": "Learning about other communities helps us understand our big, wide world!",
    },
    {
        "name": "🎤 Best Season Cheer",
        "objective": "Practice giving one clear reason to support an opinion in front of others.",
        "materials": ["None — just a group and open floor space"],
        "steps": [
            "Pick your favorite season: spring, summer, fall, or winter.",
            "Think of one reason you like it, like 'summer has swimming!'",
            "Take turns standing up and sharing your season and reason.",
            "Clap for every speaker!",
        ],
        "tip": "Everyone can have a different favorite — and that's what makes sharing fun!",
    },
    {
        "name": "🧹 Helping Neighbor Chore Relay",
        "objective": "Practice teamwork by pretending to help a neighbor tidy up quickly.",
        "materials": ["A few soft toys scattered on the floor", "A basket"],
        "steps": [
            "Imagine a neighbor needs help tidying their yard before a friend visits.",
            "Set a timer and race to pick up the scattered toys into the basket.",
            "Work together, not against each other.",
            "Celebrate together when the 'yard' is tidy!",
        ],
        "tip": "Helping a neighbor feels great, especially when you work together!",
    },
    {
        "name": "🚸 Community Helper Freeze Tag",
        "objective": "Practice recognizing helper roles while playing an active tag game.",
        "materials": ["Open play space"],
        "steps": [
            "One player is 'It' and gently tags others.",
            "Tagged players freeze in place with arms out.",
            "To unfreeze a friend, name a community helper out loud.",
            "Keep playing until everyone has been unfrozen at least once!",
        ],
        "tip": "Just like helpers work together, friends can help unfreeze each other!",
    },
    {
        "name": "🖐️ Talking Stick Turns",
        "objective": "Practice listening quietly and waiting for a turn to speak.",
        "materials": ["A stick, spoon, or small object to use as the 'talking stick'"],
        "steps": [
            "Sit in a circle together.",
            "Only the person holding the talking stick may speak.",
            "Share a short thought, then pass the stick to the next friend.",
            "Everyone else listens quietly until it's their turn!",
        ],
        "tip": "Good listening is one of the kindest things you can do for a friend!",
    },
]


GAMES[2] = [
    {
        "name": "🗳️ Two-Choice Class Vote",
        "objective": "Practice voting on two options and recording the results with tally marks.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick two simple choices, like 'read outside' or 'read inside.'",
            "Each person votes by raising a hand for their pick.",
            "Make a tally mark for every vote as it's counted.",
            "Announce which choice won and do that activity!",
        ],
        "tip": "Tally marks help us count votes clearly and fairly!",
    },
    {
        "name": "🏆 Best Recess Game Debate",
        "objective": "Practice giving one reason to support an opinion about a favorite game.",
        "materials": ["None — just two players and a friendly audience"],
        "steps": [
            "Two players each pick a different favorite recess game.",
            "Each player says one reason their game is the most fun.",
            "The audience listens carefully to both reasons.",
            "Everyone claps for both games — no wrong answers here!",
        ],
        "tip": "A good reason helps others understand why you like something!",
    },
    {
        "name": "👩‍🚒 Helper Job Interview",
        "objective": "Practice asking and answering simple questions about a community helper's job.",
        "materials": ["A simple prop (hat, badge, or toy tool)"],
        "steps": [
            "One player pretends to be a community helper.",
            "Another player asks, 'What do you do to help people?'",
            "The helper answers with one or two simple sentences.",
            "Switch roles and pick a new helper job!",
        ],
        "tip": "Asking questions is a great way to learn how someone helps their community!",
    },
    {
        "name": "🤝 Kindness Coupon Swap",
        "objective": "Practice writing and trading small acts of kindness with a partner.",
        "materials": ["Index cards", "Markers"],
        "steps": [
            "Write one simple kind act on a card, like 'I'll share my crayons.'",
            "Decorate your kindness coupon.",
            "Trade coupons with a partner.",
            "Try to complete your partner's kind act sometime this week!",
        ],
        "tip": "A small kindness coupon can make someone's whole day brighter!",
    },
    {
        "name": "🍦 Ice Cream Flavor Poll",
        "objective": "Practice collecting opinions from a group and organizing them into a simple graph.",
        "materials": ["Paper", "Pencil or crayons"],
        "steps": [
            "Ask friends or family to name their favorite ice cream flavor.",
            "Draw a simple bar for each flavor, adding one box per vote.",
            "Compare the bars to see which flavor got the most votes.",
            "Share your graph with the group!",
        ],
        "tip": "A poll is a friendly way to find out what a whole group thinks!",
    },
    {
        "name": "🗺️ Passport Stamp Game",
        "objective": "Practice learning one fact about a different community at each pretend-travel station.",
        "materials": ["A few 'country' stations with one fun fact each", "A homemade paper 'passport'", "A stamp or sticker per station"],
        "steps": [
            "Visit each station and read (or listen to) one fact about that place.",
            "Add a sticker 'stamp' to your passport at each stop.",
            "Visit all the stations to fill your passport.",
            "Share your favorite fact you learned!",
        ],
        "tip": "Every stamp in your passport is a new community you learned about!",
    },
    {
        "name": "📮 Mail Carrier Route Planning",
        "objective": "Practice planning a simple, efficient path to deliver mail to several houses.",
        "materials": ["Paper with a simple drawn map of houses", "Pencil"],
        "steps": [
            "Look at the map with 4-5 houses drawn on it.",
            "Draw a path connecting all the houses without crossing your own line.",
            "Trace your route with a finger to check it makes sense.",
            "Compare your route with a friend's — is there a shorter way?",
        ],
        "tip": "Planning ahead helps helpers like mail carriers do their job efficiently!",
    },
    {
        "name": "🐾 Community Helper Match-Up",
        "objective": "Practice matching community helper job titles to descriptions of what they do.",
        "materials": ["Cards with helper names", "Cards with matching job descriptions"],
        "steps": [
            "Mix up both sets of cards and spread them out.",
            "Read a job description card carefully.",
            "Find the helper name card that matches it.",
            "Keep going until every helper is matched!",
        ],
        "tip": "Knowing what each helper does helps you appreciate your whole community!",
    },
    {
        "name": "🎙️ One-Minute Pitch: Best Pet",
        "objective": "Practice giving a short, one-reason pitch to persuade an audience.",
        "materials": ["A timer or phone stopwatch"],
        "steps": [
            "Pick your favorite type of pet.",
            "Think of one good reason it makes the best pet.",
            "Give your pitch to a friend or family member in under a minute.",
            "Ask your listener what they liked about your pitch!",
        ],
        "tip": "A short, clear reason can be very convincing!",
    },
    {
        "name": "🧭 Map Your Neighborhood",
        "objective": "Practice drawing a simple map and marking where community helpers work.",
        "materials": ["Paper", "Crayons or markers"],
        "steps": [
            "Draw a simple map of your neighborhood or town.",
            "Mark where helpers work, like the school, fire station, or store.",
            "Add a small symbol for each helper location.",
            "Show your map to someone and explain what each symbol means!",
        ],
        "tip": "Maps help us understand how our whole community fits together!",
    },
    {
        "name": "🙌 Group Decision Circle",
        "objective": "Practice making a group decision by talking it through and voting.",
        "materials": ["None — just a group ready to play"],
        "steps": [
            "Suggest 2-3 different games the group could play next.",
            "Talk about each choice for a moment, sharing why it might be fun.",
            "Vote by raised hands for the favorite.",
            "Play the winning game together!",
        ],
        "tip": "Talking it through before voting helps everyone feel heard!",
    },
    {
        "name": "🌟 Everyday Hero Spotlight",
        "objective": "Practice recognizing and sharing about real people who help others.",
        "materials": ["None — just your own stories"],
        "steps": [
            "Think of someone you know who helped somebody else recently.",
            "Share what they did and how it helped.",
            "Listen to a friend's story about their everyday hero too.",
            "Thank a real helper in your life this week!",
        ],
        "tip": "Everyday heroes are all around us, not just in stories!",
    },
    {
        "name": "⚖️ For and Against: Recess Length",
        "objective": "Practice hearing and respectfully considering two different sides of a friendly topic.",
        "materials": ["None — just two players and a listening audience"],
        "steps": [
            "One player argues for a longer recess, the other for keeping it the same.",
            "Each player shares one reason for their side.",
            "The audience listens to both sides without interrupting.",
            "Talk together about which reason made the most sense to you!",
        ],
        "tip": "Listening to both sides helps you understand a topic better!",
    },
    {
        "name": "🏘️ Build a Fair Rule",
        "objective": "Practice working together to agree on a fair rule for a game.",
        "materials": ["Paper", "Marker"],
        "steps": [
            "Pick a game the group wants to play.",
            "Suggest one new rule that could make it more fun or fair.",
            "Talk about the suggestion and vote on whether to use it.",
            "Write down the agreed rule and play by it!",
        ],
        "tip": "Fair rules work best when everyone has a say in making them!",
    },
]


GAMES[3] = [
    {
        "name": "🗳️ Team Captain Vote",
        "objective": "Practice a simple election process by nominating and voting for a team captain.",
        "materials": ["Paper slips", "A small box"],
        "steps": [
            "Ask for 2 volunteers who would like to be team captain.",
            "Each volunteer says one sentence about how they'd help the team.",
            "Everyone writes their choice on a paper slip and drops it in the box.",
            "Count the votes together and announce the new captain!",
        ],
        "tip": "A good captain listens to the whole team, just like a good leader listens to their community!",
    },
    {
        "name": "🏅 Best Superhero Power Debate",
        "objective": "Practice building a short argument with two reasons to support an opinion.",
        "materials": ["None — just two debaters and an audience"],
        "steps": [
            "Each debater picks a different superhero power (like flying or invisibility).",
            "Each one shares two reasons their power is the most useful.",
            "The audience listens to both arguments.",
            "Vote by cheering for the argument that convinced you most!",
        ],
        "tip": "Two good reasons make an argument even stronger than one!",
    },
    {
        "name": "🚓 Community Helper Riddle Game",
        "objective": "Practice recognizing community helper jobs by solving riddles.",
        "materials": ["A few written riddles about helper jobs"],
        "steps": [
            "Read a riddle out loud, like 'I put out fires and rescue cats from trees. Who am I?'",
            "Guess which community helper the riddle describes.",
            "Check the answer together.",
            "Take turns making up your own helper riddle!",
        ],
        "tip": "Riddles are a fun way to think carefully about how helpers serve their community!",
    },
    {
        "name": "🤲 Random Acts of Kindness Bingo",
        "objective": "Practice completing and tracking simple kind acts for family and neighbors.",
        "materials": ["A bingo-style grid with kind acts written in each square", "A pencil or stickers to mark squares"],
        "steps": [
            "Look over the bingo grid of kind acts, like 'hold the door' or 'say thank you.'",
            "Complete one kind act from the grid.",
            "Mark that square off when it's done.",
            "See how many rows you can complete this week!",
        ],
        "tip": "Every square you fill in makes your community a little kinder!",
    },
    {
        "name": "🍕 Pizza Topping Persuasion Speech",
        "objective": "Practice giving a short persuasive speech in favor of an opinion.",
        "materials": ["A timer or phone stopwatch"],
        "steps": [
            "Pick your favorite pizza topping.",
            "Prepare a 30-second speech explaining why it's the best.",
            "Deliver your speech to a partner or small group.",
            "Ask your audience which point convinced them most!",
        ],
        "tip": "Speaking with confidence helps others really hear your point!",
    },
    {
        "name": "🌏 Where in the World Game",
        "objective": "Practice matching landmarks or symbols to simple facts about communities around the world.",
        "materials": ["Picture cards of landmarks or flags", "Matching fact cards"],
        "steps": [
            "Spread out the landmark/flag cards and the fact cards.",
            "Read a fact card and figure out which landmark or flag it matches.",
            "Pair up all the matching cards.",
            "Share which community you'd most like to learn more about!",
        ],
        "tip": "Every community has its own special landmarks and stories!",
    },
    {
        "name": "📦 Delivery Route Challenge",
        "objective": "Practice planning an efficient delivery route across a simple map.",
        "materials": ["A drawn map with several delivery stops", "Pencil"],
        "steps": [
            "Look at the map showing several delivery stops.",
            "Plan a route that visits every stop without backtracking too much.",
            "Trace your planned route with a pencil.",
            "Compare routes with a friend and discuss which one is shorter!",
        ],
        "tip": "Good planning helps community helpers do their jobs faster and better!",
    },
    {
        "name": "🏫 Classroom Ballot Box",
        "objective": "Practice a majority-rules voting process using written ballots.",
        "materials": ["Small paper ballots", "A box", "Pencils"],
        "steps": [
            "Present two or three choices for the group to decide on.",
            "Everyone writes their choice on a ballot and places it in the box.",
            "Count the ballots out loud together.",
            "Announce the choice with the majority of votes!",
        ],
        "tip": "Majority rules means the choice most people agree on wins!",
    },
    {
        "name": "🐕 Cats vs Dogs Formal Debate Lite",
        "objective": "Practice a simple two-sided debate structure with reasons and an audience vote.",
        "materials": ["None — just two small teams and an audience"],
        "steps": [
            "Split into Team Cats and Team Dogs.",
            "Each team shares two reasons their pet is the best.",
            "The other team listens without interrupting.",
            "The audience votes by clapping for the most convincing team!",
        ],
        "tip": "A calm, clear argument is more convincing than a loud one!",
    },
    {
        "name": "🧑‍🤝‍🧑 Helping Hands Relay Race",
        "objective": "Practice teamwork by racing to deliver helpful items to a pretend neighbor in need.",
        "materials": ["A few 'helpful items' (blanket, water bottle, toy)", "2 cones to mark start and finish"],
        "steps": [
            "Set up a start line and a 'neighbor's house' finish line.",
            "Split into teams, each with a set of helpful items.",
            "Take turns running one item at a time to the neighbor's house.",
            "First team to deliver all their items wins!",
        ],
        "tip": "Working together makes helping a neighbor faster and more fun!",
    },
    {
        "name": "🗣️ Turn-Taking Talk Show",
        "objective": "Practice interviewing and listening skills through a pretend talk show about community helpers.",
        "materials": ["A pretend microphone (or any object)"],
        "steps": [
            "One player is the host, another plays a community helper guest.",
            "The host asks the guest 2-3 questions about their job.",
            "The guest answers while the host listens without interrupting.",
            "Switch roles and pick a new helper to interview!",
        ],
        "tip": "A good host listens as much as they talk!",
    },
    {
        "name": "🌈 Best Season Debate Match",
        "objective": "Practice a for/against debate structure with an audience vote at the end.",
        "materials": ["None — just two debaters and an audience"],
        "steps": [
            "Two players each pick a different favorite season.",
            "Each shares two reasons why their season is the best.",
            "The audience listens to both sides.",
            "Audience votes by clapping for the argument they found most convincing!",
        ],
        "tip": "Even a friendly disagreement can be fun when everyone listens respectfully!",
    },
    {
        "name": "🚦 Community Rule Makers",
        "objective": "Practice proposing, discussing, and voting on a fair rule as a group.",
        "materials": ["Paper", "Marker"],
        "steps": [
            "Think of a rule that could make a group game more fun or fair.",
            "Share your idea with the group and explain why.",
            "Vote on whether to adopt the new rule.",
            "Write down the rule and use it in your next game!",
        ],
        "tip": "Rules made together are rules everyone is happy to follow!",
    },
    {
        "name": "🗳️ Silent Ballot Practice",
        "objective": "Practice the idea of a private vote by folding and submitting a silent ballot.",
        "materials": ["Small paper slips", "Pencils", "A box"],
        "steps": [
            "Present a fun choice, like a favorite game to play next.",
            "Write your choice privately on a folded slip of paper.",
            "Place your folded ballot in the box without showing anyone.",
            "Unfold and count all the ballots together to find the winner!",
        ],
        "tip": "A private vote lets everyone choose freely, without feeling pressured!",
    },
]


GAMES[4] = [
    {
        "name": "🗳️ Secret Ballot Election",
        "objective": "Practice the process of a secret ballot election from voting to counting results.",
        "materials": ["Small paper ballots", "Pencils", "A closed box or envelope"],
        "steps": [
            "Present two choices for the group to decide, like a class game or snack.",
            "Each person writes their choice privately, folds it, and drops it in the box.",
            "Once everyone has voted, open the box and read each ballot aloud.",
            "Tally the results and announce the winner!",
        ],
        "tip": "A secret ballot lets everyone vote honestly, based on their own opinion!",
    },
    {
        "name": "⚖️ Debate Club: Cats vs Dogs",
        "objective": "Practice a formal debate structure with an opening statement, a rebuttal, and a closing statement.",
        "materials": ["A timer or phone stopwatch"],
        "steps": [
            "Two debaters each pick a side: Team Cats or Team Dogs.",
            "Each gives a short opening statement explaining their side.",
            "Each debater responds to the other's point with a respectful rebuttal.",
            "Both give a short closing statement, then the audience votes!",
        ],
        "tip": "A strong rebuttal responds calmly and directly to the other side's point!",
    },
    {
        "name": "🏛️ Mock Town Council Meeting",
        "objective": "Practice proposing and voting on a rule in a simple simulated town council meeting.",
        "materials": ["Simple name tags for roles (mayor, council members)", "Paper", "Pencil"],
        "steps": [
            "Assign roles: one mayor and a few council members.",
            "One council member proposes a silly new town rule, like 'Fridays are pajama day.'",
            "Council members discuss and ask questions about the proposal.",
            "The council votes, and the mayor announces the result!",
        ],
        "tip": "Good decisions come from asking questions before voting!",
    },
    {
        "name": "🤝 Kindness Challenge Card Game",
        "objective": "Practice planning and reporting back on a small act of kindness.",
        "materials": ["Cards with kindness challenges written on them", "A container to draw from"],
        "steps": [
            "Draw a kindness challenge card, like 'compliment three people today.'",
            "Complete the challenge sometime before the next meeting.",
            "Come back and share how it went with the group.",
            "Draw a new challenge card and try again!",
        ],
        "tip": "A completed kindness challenge is a little gift to your whole community!",
    },
    {
        "name": "🍕 Best Pizza Topping Debate",
        "objective": "Practice building a structured for/against argument with supporting reasons and a rebuttal.",
        "materials": ["A timer or phone stopwatch"],
        "steps": [
            "Two debaters each pick a favorite pizza topping.",
            "Each shares two reasons supporting their topping.",
            "Each debater offers one respectful rebuttal to the other's reasons.",
            "The audience votes for the most convincing argument!",
        ],
        "tip": "Backing up your opinion with reasons makes it much more convincing!",
    },
    {
        "name": "🌍 Global Communities Passport Project",
        "objective": "Practice researching and comparing how communities differ around the world.",
        "materials": ["A few 'country' research stations with facts and pictures", "A simple passport booklet (folded paper)"],
        "steps": [
            "Visit each station and read facts about that community's homes, food, or celebrations.",
            "Write or draw one thing you learned in your passport.",
            "Compare that community to your own — what's similar, what's different?",
            "Share your favorite discovery with the group!",
        ],
        "tip": "Every community solves everyday needs in its own unique way!",
    },
    {
        "name": "📬 City Planner Delivery Challenge",
        "objective": "Practice planning the most efficient mail delivery route across a mock city map.",
        "materials": ["A drawn map of a mock city with many delivery stops", "Pencil", "Ruler (optional)"],
        "steps": [
            "Study the map and count how many stops need a delivery.",
            "Plan a route that reaches every stop using the shortest path you can find.",
            "Trace your final route and measure roughly how far it travels.",
            "Compare your route's length with a partner's — whose is shorter?",
        ],
        "tip": "Careful planning helps a whole city run more smoothly!",
    },
    {
        "name": "🧑‍⚖️ Fair or Not Fair Game",
        "objective": "Practice discussing and voting on whether everyday scenarios are fair.",
        "materials": ["Scenario cards describing simple situations (like sharing a swing fairly)"],
        "steps": [
            "Read a scenario card out loud to the group.",
            "Discuss whether the situation seems fair or not, and why.",
            "Vote as a group: fair or not fair?",
            "Talk about what would make it more fair, if needed!",
        ],
        "tip": "Thinking about fairness helps us treat everyone in our community kindly!",
    },
    {
        "name": "🗣️ Two-Minute Persuasive Speech: Best Season",
        "objective": "Practice preparing and delivering a short, structured persuasive speech.",
        "materials": ["A timer or phone stopwatch", "Notecards (optional)"],
        "steps": [
            "Pick your favorite season and think of 2-3 reasons it's the best.",
            "Prepare a short speech with a beginning, middle, and end.",
            "Deliver your two-minute speech to a partner or small group.",
            "Ask your listeners which reason stood out most!",
        ],
        "tip": "A clear beginning, middle, and end makes any speech easier to follow!",
    },
    {
        "name": "🏘️ Design-a-Community Project Game",
        "objective": "Practice designing and presenting a small community with clear helper roles.",
        "materials": ["Paper", "Markers or crayons"],
        "steps": [
            "In small teams, draw a small community with a school, park, and a few helper buildings.",
            "Decide what job each building and helper serves.",
            "Present your community design to the other teams.",
            "Ask each other questions about how your communities work!",
        ],
        "tip": "A well-designed community has helpers for every important need!",
    },
    {
        "name": "🤗 Neighbor Helper Simulation",
        "objective": "Practice brainstorming solutions to a scenario where a neighbor needs help.",
        "materials": ["Scenario cards describing a neighbor in need (like an elderly neighbor's mail piling up)"],
        "steps": [
            "Read a neighbor-in-need scenario card out loud.",
            "Brainstorm 2-3 ways the group could help in that situation.",
            "Vote on the best idea as a group.",
            "Talk about how it would feel to actually help that neighbor!",
        ],
        "tip": "Noticing when someone needs help is the first step to being a great neighbor!",
    },
    {
        "name": "🗳️ Majority Rules Game Show",
        "objective": "Practice quick voting and understanding the concept of a majority.",
        "materials": ["Paper", "Pencil (for tallying)"],
        "steps": [
            "Ask a quick, silly question, like 'cereal or toast for breakfast?'",
            "Everyone votes with a raised hand.",
            "Tally the votes and discuss which choice has the majority.",
            "Play several quick rounds with new silly questions!",
        ],
        "tip": "A majority means more than half the group agrees on the same choice!",
    },
    {
        "name": "🌐 Compare Two Communities Game",
        "objective": "Practice comparing and contrasting features of two different communities.",
        "materials": ["Pictures or facts about two different communities (a city and a small town, for example)", "Paper divided into two columns"],
        "steps": [
            "Look closely at facts or pictures from both communities.",
            "List similarities in one column and differences in the other.",
            "Talk about why each community might have grown that way.",
            "Share your favorite similarity and difference with the group!",
        ],
        "tip": "Comparing communities helps us see how people everywhere solve similar needs!",
    },
    {
        "name": "🎤 Rebuttal Ready: Best School Subject Debate",
        "objective": "Practice listening carefully to an opposing argument and responding respectfully.",
        "materials": ["A timer or phone stopwatch"],
        "steps": [
            "Two debaters each pick a different favorite school subject.",
            "Each shares one reason their subject is the most fun.",
            "Each debater listens carefully, then responds respectfully to the other's point.",
            "The audience votes for the response that listened best!",
        ],
        "tip": "The best rebuttals show you were really listening to the other side!",
    },
]


GAMES[5] = [
    {
        "name": "🗳️ Class Election Simulation",
        "objective": "Practice a full simple election process: nomination, speech, secret ballot, and counting results.",
        "materials": ["Paper ballots", "A ballot box", "Pencils"],
        "steps": [
            "Two or three classmates volunteer to be candidates for a fun class role, like 'Game Time Captain.'",
            "Each candidate gives a short speech about how they'd do the job well.",
            "Everyone votes privately on a paper ballot and places it in the box.",
            "Count the ballots together and announce the winner!",
        ],
        "tip": "A fair election gives every candidate a chance to be heard before the vote!",
    },
    {
        "name": "⚖️ Formal Debate: Summer vs Winter",
        "objective": "Practice a structured debate with judged scoring based on strength of arguments.",
        "materials": ["A timer or phone stopwatch", "Paper and pencil for judges to score"],
        "steps": [
            "Two debaters each pick a season, summer or winter, to defend.",
            "Each gives an opening statement with two supporting reasons.",
            "Each responds to the other's argument with a rebuttal.",
            "Judges (the rest of the group) score based on clarity and reasoning, then announce a winner!",
        ],
        "tip": "Clear reasoning is even more convincing than a loud voice!",
    },
    {
        "name": "🏛️ Community Council Role-Play",
        "objective": "Practice debating and voting on a mock community project as council members.",
        "materials": ["Role name tags (council members)", "Paper describing the proposed project (like a new park bench)"],
        "steps": [
            "Assign each player a council member role.",
            "One player proposes a small community project and explains its benefits.",
            "Council members ask questions and share opinions, for and against.",
            "The council votes, and the result is announced to the 'community'!",
        ],
        "tip": "Good community decisions come from hearing many different points of view!",
    },
    {
        "name": "🤲 Helping Hands Service Project Plan",
        "objective": "Practice planning a simple neighborhood helping project from idea to action steps.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Brainstorm a small way to help your neighborhood, like a trash pickup or card-making for neighbors.",
            "Write down 3 clear steps needed to make the project happen.",
            "Decide who could help with each step.",
            "Share your plan with the group and get feedback!",
        ],
        "tip": "Even the biggest helping projects start with one clear, simple plan!",
    },
    {
        "name": "🍦 Persuasive Pitch: Best Dessert",
        "objective": "Practice a full persuasive speech structure with a hook, reasons, and a closing call to action.",
        "materials": ["A timer or phone stopwatch", "Notecards (optional)"],
        "steps": [
            "Pick your favorite dessert and think of an attention-grabbing opening line.",
            "Add 2-3 clear reasons why it's the best.",
            "End with a strong closing line that sums up your point.",
            "Deliver your pitch to a partner and ask what part convinced them most!",
        ],
        "tip": "A strong opening hook makes people want to listen to the rest of your argument!",
    },
    {
        "name": "🌍 World Communities Research Relay",
        "objective": "Practice quickly recalling facts about different communities worldwide through a relay quiz.",
        "materials": ["Fact cards about communities in different countries", "2 team areas"],
        "steps": [
            "Split into two teams, each near a stack of shuffled fact-question cards.",
            "One player runs up, reads a question, and answers it as a team.",
            "If correct, keep the card; if not, place it back and try the next one.",
            "The team with the most correct cards after the relay wins!",
        ],
        "tip": "Learning quick facts about communities helps us appreciate how connected our world is!",
    },
    {
        "name": "📮 Logistics Challenge: City Delivery Planner",
        "objective": "Practice optimizing a delivery route around distance and obstacles on a map.",
        "materials": ["A drawn map with delivery stops and a few 'obstacles' (like a closed road)", "Pencil"],
        "steps": [
            "Study the map, noting all delivery stops and any blocked roads.",
            "Plan the shortest route that still avoids every obstacle.",
            "Trace your final route and estimate its total distance.",
            "Compare with a partner and discuss which route works best and why!",
        ],
        "tip": "Great logistics planning means solving problems before they slow you down!",
    },
    {
        "name": "🧑‍⚖️ Debate the Rule: Recess Length",
        "objective": "Practice a structured for/against debate with an audience vote after hearing both sides.",
        "materials": ["A timer or phone stopwatch"],
        "steps": [
            "One debater argues for a longer recess, the other for keeping it the same.",
            "Each gives an opening statement with supporting reasons.",
            "Each responds to the other's argument with a brief rebuttal.",
            "The audience votes after hearing both full sides!",
        ],
        "tip": "Fair debates always let both sides finish before anyone votes!",
    },
    {
        "name": "🗳️ Ranked Choice Snack Vote",
        "objective": "Practice the concept of ranked-choice voting by ranking multiple snack options.",
        "materials": ["Paper ballots listing 3-4 snack choices", "Pencils"],
        "steps": [
            "List 3-4 snack choices on each ballot.",
            "Each voter ranks the snacks from favorite (1) to least favorite.",
            "Collect the ballots and count first-choice votes first.",
            "If no snack has a majority, remove the lowest and recount using next choices!",
        ],
        "tip": "Ranked-choice voting lets people show more than just their single favorite!",
    },
    {
        "name": "🏘️ Build-a-Better-Community Design Challenge",
        "objective": "Practice designing a community solution to a specific need and presenting it clearly.",
        "materials": ["Paper", "Markers"],
        "steps": [
            "In teams, pick one community need, like more places to play or more green space.",
            "Design a simple community feature that solves that need.",
            "Prepare a short presentation explaining your design and its benefits.",
            "Present to the group and answer any questions!",
        ],
        "tip": "The best community designs start by really listening to what people need!",
    },
    {
        "name": "🤝 Kindness Ripple Effect Game",
        "objective": "Practice tracing how one kind act can help multiple people, one after another.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Start with one small kind act, like helping a friend carry books.",
            "Think about who that act might inspire to be kind too.",
            "Draw an arrow chain showing the kindness spreading to 3-4 more people.",
            "Share your kindness chain with the group!",
        ],
        "tip": "One kind act can ripple out and touch more people than you'd ever guess!",
    },
    {
        "name": "🌐 Similarities & Differences Community Map",
        "objective": "Practice comparing community features across two countries using a map.",
        "materials": ["Two country maps or fact sheets", "Paper divided into a Venn diagram"],
        "steps": [
            "Research or read facts about two different countries' communities.",
            "Fill in the Venn diagram with unique features on each side and shared features in the middle.",
            "Discuss why some features might be shared and others different.",
            "Share your most interesting finding with the group!",
        ],
        "tip": "Even far-apart communities often share more in common than we expect!",
    },
    {
        "name": "🎤 Two-Sided Speech: Best Class Pet",
        "objective": "Practice preparing arguments for both sides of a topic, then arguing an assigned side.",
        "materials": ["A timer or phone stopwatch", "Notecards"],
        "steps": [
            "Pick two possible class pets and prepare 2 reasons supporting each one.",
            "Get randomly assigned one side to argue, even if it's not your personal favorite.",
            "Deliver a short speech defending your assigned side.",
            "Talk afterward about how it felt to argue a side you didn't originally pick!",
        ],
        "tip": "Understanding both sides of an argument makes you a stronger, fairer thinker!",
    },
    {
        "name": "🧭 Civic Puzzle: Match the Rule to the Reason",
        "objective": "Practice matching everyday community rules to the reasons they help everyone.",
        "materials": ["Cards with simple community rules", "Cards with matching reasons"],
        "steps": [
            "Spread out the rule cards and the reason cards.",
            "Read a rule, like 'wait your turn in line.'",
            "Find the reason card that best explains why that rule helps everyone.",
            "Match all the pairs and discuss any surprising ones!",
        ],
        "tip": "Most community rules exist for a good reason — even the ones that seem small!",
    },
]


GAMES[6] = [
    {
        "name": "🗳️ Full Class Election Day",
        "objective": "Practice a complete simulated election, including nominations, speeches, secret ballots, and results.",
        "materials": ["Paper ballots", "A ballot box", "Pencils", "A timer for speeches"],
        "steps": [
            "Nominate 2-3 candidates for a fun classroom role.",
            "Each candidate prepares and delivers a one-minute speech about their ideas.",
            "Everyone votes by secret ballot and places it in the box.",
            "Count the ballots together, announce results, and reflect on what made a speech convincing!",
        ],
        "tip": "A trustworthy election depends on every vote being counted honestly and fairly!",
    },
    {
        "name": "⚖️ Structured Debate Tournament: Best Season",
        "objective": "Practice a timed, judged debate tournament format with a reflection on persuasive techniques.",
        "materials": ["A timer or phone stopwatch", "Judging notes (paper and pencil)"],
        "steps": [
            "Form small teams, each defending a different season.",
            "Each team gets a timed round for opening statements, rebuttals, and closing arguments.",
            "Judges score each round on clarity, evidence, and respectfulness.",
            "After scoring, discuss as a group what made the winning team's argument convincing!",
        ],
        "tip": "Reflecting on what worked helps you become an even stronger speaker next time!",
    },
    {
        "name": "🏛️ Mock City Council Budget Game",
        "objective": "Practice debating and voting on how to allocate a pretend community budget.",
        "materials": ["Paper 'budget bills' (fake money or tokens)", "Cards listing project options (park, library books, sports court)"],
        "steps": [
            "Give the group a fixed pretend budget and 3-4 project options to fund.",
            "Each project 'sponsor' pitches why their project deserves funding.",
            "The council discusses trade-offs, since the budget can't fund everything.",
            "Vote on the final budget split and reflect on the toughest trade-off you made!",
        ],
        "tip": "Community budgets always involve tough choices about what matters most!",
    },
    {
        "name": "🤝 Community Service Project Pitch",
        "objective": "Practice pitching a service project idea and reflecting on what made a pitch convincing.",
        "materials": ["Paper", "Pencil", "A timer"],
        "steps": [
            "Each person or team prepares a short pitch for a community service project idea.",
            "Deliver your pitch to the group, including the problem it solves and how it helps.",
            "The group votes on which pitch they'd most want to support.",
            "Discuss together what specifically made the winning pitch so convincing!",
        ],
        "tip": "The most convincing pitches clearly connect the idea to a real community need!",
    },
    {
        "name": "🍕 Persuasive Speech Showdown: Pizza Toppings",
        "objective": "Practice a full persuasive speech structure with peer reflection on technique.",
        "materials": ["A timer or phone stopwatch", "Notecards"],
        "steps": [
            "Prepare a persuasive speech about your favorite pizza topping with a hook, evidence, and a call to action.",
            "Deliver your speech to the group within the time limit.",
            "Listeners give one piece of specific feedback about what was convincing.",
            "Reflect on which feedback you'd use to improve your speech next time!",
        ],
        "tip": "Even a silly topic is a great way to practice serious persuasive speaking skills!",
    },
    {
        "name": "🌍 Global Citizenship Simulation",
        "objective": "Practice representing a community's needs and customs in a collaborative world-summit discussion.",
        "materials": ["Role cards describing different (fictional or general) communities and their needs"],
        "steps": [
            "Each player or team represents a community with its own needs and customs.",
            "Take turns sharing what your community values and needs most.",
            "Discuss as a group how different communities could support one another.",
            "Reflect on what you learned about communities different from your own!",
        ],
        "tip": "Understanding another community's perspective is the first step toward global cooperation!",
    },
    {
        "name": "📦 Supply Chain Delivery Strategy Game",
        "objective": "Practice planning an optimized delivery network and discussing trade-offs as a team.",
        "materials": ["A map with multiple delivery hubs and destinations", "Pencil", "Paper for notes"],
        "steps": [
            "Study the map showing hubs, destinations, and distances.",
            "As a team, plan the most efficient way to deliver to every destination.",
            "Discuss trade-offs, like speed versus cost, as you finalize your plan.",
            "Compare your team's strategy with another team's and discuss the differences!",
        ],
        "tip": "Good planning balances many trade-offs, not just speed or cost alone!",
    },
    {
        "name": "🧑‍⚖️ Formal Debate: Should Homework Be Optional",
        "objective": "Practice a fully structured debate with a reflection component on persuasive strategies used.",
        "materials": ["A timer or phone stopwatch", "Notecards"],
        "steps": [
            "Two teams prepare arguments for and against optional homework.",
            "Each side delivers opening statements, then a rebuttal round.",
            "Each side gives a closing statement summarizing their strongest point.",
            "As a group, reflect on which specific arguments and techniques were most convincing!",
        ],
        "tip": "Great debaters can explain the other side's view even while disagreeing with it!",
    },
    {
        "name": "🗳️ Ranked Choice Voting Challenge",
        "objective": "Practice ranked-choice voting with multiple rounds of elimination and recounting.",
        "materials": ["Ballots listing 4-5 favorite game choices", "Pencils", "Paper for tallying rounds"],
        "steps": [
            "Rank all the choices on your ballot from favorite to least favorite.",
            "Count first-choice votes; if no choice has a majority, eliminate the lowest.",
            "Redistribute those ballots to voters' next choice and recount.",
            "Repeat until one choice has a majority, then reflect on how the result changed each round!",
        ],
        "tip": "Ranked-choice voting can reveal a group's true favorite, even without an easy majority!",
    },
    {
        "name": "🏘️ Ideal Community Design Pitch",
        "objective": "Practice designing, pitching, and voting on ideal community features as a team.",
        "materials": ["Paper", "Markers", "A timer for pitches"],
        "steps": [
            "In teams, design an ideal small community addressing a real need (green space, safety, fun).",
            "Prepare a short pitch explaining your design's biggest benefit.",
            "Present to the group and take questions.",
            "Vote for a favorite design and reflect on what made it stand out!",
        ],
        "tip": "The strongest community designs solve a real problem in a clear, simple way!",
    },
    {
        "name": "🤲 Kindness Campaign Planning Game",
        "objective": "Practice planning and pitching a mini kindness campaign with a persuasive case.",
        "materials": ["Paper", "Markers"],
        "steps": [
            "Brainstorm a small kindness campaign idea, like a compliment wall or a thank-you note drive.",
            "Plan how it would work and who it would help.",
            "Pitch your campaign idea persuasively to the group.",
            "Reflect on what part of your pitch felt most convincing and why!",
        ],
        "tip": "A well-planned kindness campaign can spread good feelings through an entire community!",
    },
    {
        "name": "🌐 Compare Global Communities Debate",
        "objective": "Practice debating which of two general community approaches solves a shared problem better.",
        "materials": ["Fact cards describing two different (generic) community approaches to a challenge, like recycling", "A timer"],
        "steps": [
            "Read about two different ways communities might handle the same challenge.",
            "Each debater or team defends one approach with supporting reasons.",
            "Listen and respond respectfully to the other side's argument.",
            "Reflect as a group on the strengths of both approaches!",
        ],
        "tip": "Comparing different solutions helps us find the best ideas from everywhere!",
    },
    {
        "name": "🎤 Convincing Argument Reflection Circle",
        "objective": "Practice reflecting on what specifically makes a persuasive argument convincing.",
        "materials": ["None — just a group after a debate or speech activity"],
        "steps": [
            "After a mini debate or speech, sit in a circle together.",
            "Each person shares one specific thing a teammate said that was convincing.",
            "Discuss patterns — was it evidence, tone, structure, or something else?",
            "Write down one takeaway to use in your own next speech!",
        ],
        "tip": "Noticing exactly what makes an argument work helps you build stronger arguments yourself!",
    },
    {
        "name": "🧭 Civic Values Sorting Debate",
        "objective": "Practice sorting and debating which community values matter most in a given scenario.",
        "materials": ["Cards listing community values (fairness, safety, kindness, honesty)", "A scenario card"],
        "steps": [
            "Read a scenario where a community must make a decision.",
            "Sort the value cards in order of what matters most for that scenario.",
            "Debate your ranking with a partner who sorted differently.",
            "Reflect on how different values can lead to different, still-reasonable choices!",
        ],
        "tip": "Thoughtful communities weigh many values, not just one, before deciding!",
    },
]


GAMES[7] = [
    {
        "name": "🗳️ Student Government Mock Election",
        "objective": "Practice a full mock election process with platform statements, speeches, and secret ballots.",
        "materials": ["Paper ballots", "A ballot box", "Pencils", "A timer for speeches"],
        "steps": [
            "Candidates prepare a short, non-partisan platform statement, like 'more art supplies' or 'a weekly game day.'",
            "Each candidate delivers a one-to-two-minute speech to the group.",
            "Everyone votes by secret ballot and places it in the box.",
            "Count the results together and discuss what made each platform appealing!",
        ],
        "tip": "The best platforms clearly explain how they'll help the whole group, not just one person!",
    },
    {
        "name": "⚖️ Championship Debate: Cats vs Dogs Finals",
        "objective": "Practice an advanced debate structure including a cross-examination round.",
        "materials": ["A timer or phone stopwatch", "Notecards"],
        "steps": [
            "Two teams prepare arguments for Team Cats or Team Dogs.",
            "Each side gives an opening statement, then a cross-examination round of direct questions.",
            "Each side gives a rebuttal responding to the questions raised.",
            "Judges score the debate and explain what won them over in the closing discussion!",
        ],
        "tip": "A great cross-examination question makes the other side think harder about their argument!",
    },
    {
        "name": "🏛️ Community Budget Council Simulation",
        "objective": "Practice negotiating and voting to allocate a mock community budget across competing projects.",
        "materials": ["Pretend budget tokens", "Project proposal cards (park upgrade, library, recycling program)"],
        "steps": [
            "Distribute a limited set of budget tokens to the council.",
            "Each project proposal gets pitched with its cost and benefits.",
            "Council members negotiate and can combine or scale back projects to fit the budget.",
            "Vote on the final budget allocation and reflect on the compromises made!",
        ],
        "tip": "Real community budgeting almost always requires compromise between good ideas!",
    },
    {
        "name": "🤝 Neighbor-in-Need Case Study Game",
        "objective": "Practice analyzing a scenario, proposing solutions, debating them, and voting on the best plan.",
        "materials": ["A detailed neighbor-in-need scenario card", "Paper for notes"],
        "steps": [
            "Read a detailed scenario about a neighbor facing a challenge.",
            "In small groups, brainstorm and write down 2-3 possible ways to help.",
            "Each group presents its plan and answers questions from others.",
            "Vote on the strongest plan and discuss what made it effective!",
        ],
        "tip": "The best help matches exactly what a neighbor actually needs!",
    },
    {
        "name": "🍕 Ultimate Persuasion Challenge: Best Topping",
        "objective": "Practice advanced persuasive speaking including a rebuttal round and audience Q&A.",
        "materials": ["A timer or phone stopwatch", "Notecards"],
        "steps": [
            "Prepare a persuasive speech defending your favorite pizza topping with strong evidence.",
            "Deliver your speech, then face a rebuttal from an opposing speaker.",
            "Take 1-2 questions from the audience and respond on the spot.",
            "Reflect afterward on which question was hardest to answer and why!",
        ],
        "tip": "Handling tough questions calmly is one of the most powerful persuasive skills!",
    },
    {
        "name": "🌍 Global Citizen Summit Role-Play",
        "objective": "Practice representing different community perspectives and negotiating a shared solution.",
        "materials": ["Role cards describing different community perspectives on a shared, generic issue (like sharing a park space)"],
        "steps": [
            "Each player represents a different community perspective on the shared issue.",
            "Take turns explaining your community's needs and concerns.",
            "Work together to negotiate a solution that respects multiple perspectives.",
            "Reflect on which part of the negotiation was hardest to agree on!",
        ],
        "tip": "Great negotiators look for solutions where everyone gains something important!",
    },
    {
        "name": "📦 City Logistics Strategy Game",
        "objective": "Practice advanced route and resource optimization with team strategy discussion.",
        "materials": ["A complex map with multiple hubs, destinations, and limited resources (like a set number of delivery trucks)", "Paper for planning"],
        "steps": [
            "Study the map and the limited resources available for deliveries.",
            "As a team, strategize the most efficient way to serve every destination.",
            "Present your strategy and reasoning to another team.",
            "Discuss the trade-offs each team made and what you'd change next time!",
        ],
        "tip": "Smart resource strategy means making the most of what you have, not wishing for more!",
    },
    {
        "name": "🧑‍⚖️ Formal Debate: School Uniforms vs Free Dress",
        "objective": "Practice a fully judged, structured debate on a lighthearted school policy topic.",
        "materials": ["A timer or phone stopwatch", "Judging score sheets"],
        "steps": [
            "Two teams prepare arguments for uniforms or free dress at school.",
            "Each side presents opening statements, a rebuttal round, and closing statements.",
            "Judges score based on evidence, clarity, and respectfulness.",
            "Announce the winner and discuss what argument was the turning point!",
        ],
        "tip": "Even a lighthearted topic deserves careful evidence and respectful listening!",
    },
    {
        "name": "🗳️ Election Reform Lab",
        "objective": "Practice comparing different generic voting methods through mini-elections and discussing their pros and cons.",
        "materials": ["Paper ballots set up for three formats: show of hands, secret ballot, ranked choice", "Pencils"],
        "steps": [
            "Run the same fun mini-election three times using a different voting method each time.",
            "Record the results of each method.",
            "Compare whether the winner changed depending on the method used.",
            "Discuss as a group the pros and cons of each voting method!",
        ],
        "tip": "The way we vote can shape the outcome just as much as what we vote for!",
    },
    {
        "name": "🏘️ Future Community Design Lab",
        "objective": "Practice designing a future community that solves a specific challenge and defending the design.",
        "materials": ["Paper", "Markers", "A timer for presentations"],
        "steps": [
            "Pick a specific challenge a future community might face, like limited space or clean energy needs.",
            "Design a community solution addressing that challenge.",
            "Present your design and defend it against questions from the group.",
            "Reflect on which question challenged your design the most, and how you'd improve it!",
        ],
        "tip": "Great designs get even better after facing tough, thoughtful questions!",
    },
    {
        "name": "🤲 Kindness Initiative Pitch Competition",
        "objective": "Practice pitching a kindness initiative competitively and reflecting on persuasive strengths.",
        "materials": ["Paper", "Markers", "A timer for pitches"],
        "steps": [
            "Design a kindness initiative for your school or neighborhood.",
            "Prepare a short, energetic pitch explaining its impact.",
            "Present your pitch competition-style to a panel of 'judges' (the group).",
            "Judges vote and explain what made the winning pitch so convincing!",
        ],
        "tip": "The most convincing pitches make the impact of an idea feel real and personal!",
    },
    {
        "name": "🌐 Cross-Culture Community Debate",
        "objective": "Practice debating a shared generic community challenge from two different cultural perspectives.",
        "materials": ["Fact cards describing two general cultural approaches to a shared challenge (like sharing food during a festival)", "A timer"],
        "steps": [
            "Learn about two different cultural approaches to the same kind of community challenge.",
            "Each debater or team defends the strengths of one approach.",
            "Respond respectfully to questions and challenges from the other side.",
            "Reflect on what each approach can teach the other!",
        ],
        "tip": "Every culture has wisdom to share about building strong communities!",
    },
    {
        "name": "🎤 Convincing Case Reflection Lab",
        "objective": "Practice a deep group reflection on the specific persuasive techniques used across recent debates.",
        "materials": ["Notes or memories from a recent debate activity", "Paper for group notes"],
        "steps": [
            "As a group, recall a few of the strongest arguments made in recent debates.",
            "Discuss what techniques made each one effective — evidence, structure, tone, or timing.",
            "Sort the techniques from most to least persuasive as a group.",
            "Each person writes one technique they want to try in their next speech!",
        ],
        "tip": "The best speakers are always studying what makes other arguments work!",
    },
    {
        "name": "🧭 Civic Roles Simulation Game",
        "objective": "Practice taking on different civic roles in one scenario and reflecting on each role's importance.",
        "materials": ["Role cards (voter, council member, volunteer, community reporter)", "A shared scenario card"],
        "steps": [
            "Assign each player a different civic role within the same community scenario.",
            "Each role takes an action appropriate to their part — voting, proposing, volunteering, or reporting.",
            "Act out how the scenario unfolds as each role contributes.",
            "Reflect together on why every one of these roles matters to a healthy community!",
        ],
        "tip": "A strong community needs every kind of civic role working together!",
    },
]


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    # Plain ASCII " | " separator — a non-ASCII middle-dot separator here
    # previously got double-UTF8-encoded somewhere in the sqlcmd/ODBC file-
    # reading pipeline (confirmed live: " · " landed in the DB as the
    # literal 4-character sequence " Â· "), and a plain comma is
    # ambiguous since several material descriptions already contain commas
    # inside their own parenthetical text (e.g. "(park upgrade, library,
    # recycling program)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 77_civic_games_content.sql")
    out.append("-- Adds a 'Community & Civics Games' category to the existing always-on")
    out.append("-- 'civic' subject_area for every grade (TK-6th) — no schema or proc changes")
    out.append("-- needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly")
    out.append("-- as-is. The 'civic' subject_area already ships three categories (Civics &")
    out.append("-- Government, Community & Global Citizenship, Public Speaking & Debate —")
    out.append("-- see 67_civic_humor_character_culture_content.sql); this Games category")
    out.append("-- spans all three of those themes through hands-on play instead of Q&A.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's civic")
    out.append("-- category is selected, satisfying \"7 civic games, different set each")
    out.append("-- week\" without any manual per-week authoring.")
    out.append("--")
    out.append("-- Content rule: strictly nonpartisan and non-controversial. No real")
    out.append("-- political parties, no real politicians of any era, no real-world")
    out.append("-- divisive social/political issues. Voting/election mechanics are always")
    out.append("-- generic-process; debate topics are always lighthearted (pizza toppings,")
    out.append("-- cats vs dogs, best season, etc.).")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print). answer_text carries a short encouraging")
    out.append("-- civic-mindset tip.")
    out.append("-- See gen_77_civic_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'civic' AND category_name = N'Community & Civics Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_civic_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'civic', N'Community & Civics Games', 'space_heavy', 7, N'Learn how communities work together through a fun civics game!', 0);"
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
    # "\n" to "\r\n" — without it, every embedded "\n\n" inside a prompt
    # string (used to separate Name/Objective/Materials) gets written as a
    # literal "\r\n" into the SQL file, which then lands as-is inside the
    # quoted N'...' string literal and gets stored verbatim in the database.
    # This bit the team for real on the sibling outdoor-games content type
    # (68_outdoor_games_content.sql) before the fix was applied here.
    with open(r"D:\Project\www\littlescholarhub\lsh.database\77_civic_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 77_civic_games_content.sql", file=sys.stderr)
