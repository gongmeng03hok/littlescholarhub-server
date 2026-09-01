# -*- coding: utf-8 -*-
"""
Generates lsh.database/79_character_games_content.sql — adds a "Character
Building Games" category to the existing 'character' subject_area
(always-on, no schema/proc changes needed) for every grade TK-6. Each
grade gets a pool of 14 hand-crafted games spanning the subject_area's
existing themes (growth mindset / "yet" thinking, manners & respect,
moral lessons like honesty and standing up for others, kindness, and
gratitude); the existing rotation samples 7 of them (via target_count=7,
ORDER BY NEWID()) fresh each week a grade's character category is picked,
so consecutive weeks show a different set without any manual "week 1 /
week 2" authoring. Mirrors the proven structure of
gen_68_outdoor_games_content.py exactly.

Run with: python gen_79_character_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🌟 Kindness Bingo",
        "objective": "Practice noticing and doing simple kind acts with the help of a grown-up.",
        "materials": ["Paper with 4 simple kindness pictures drawn or printed", "Crayon or sticker to mark squares"],
        "steps": [
            "Grown-up draws (or shows) 4 simple kindness pictures on paper, like sharing, hugging, saying thank you, and helping clean up.",
            "Do one kind thing from the paper with a grown-up's help.",
            "Mark that square with a crayon or sticker.",
            "Try to mark all 4 squares by the end of the day!",
        ],
        "tip": "Every kind act — big or small — makes someone's day a little brighter.",
    },
    {
        "name": "🧸 Share the Toy",
        "objective": "Practice sharing a favorite toy and taking turns with a friend or grown-up.",
        "materials": ["1 favorite toy"],
        "steps": [
            "Sit together with a grown-up or friend and one toy.",
            "Play with the toy for a little while, then say 'your turn' and hand it over.",
            "Wait patiently while your friend plays.",
            "Trade back and forth a few times, cheering for each other.",
        ],
        "tip": "Sharing turns a fun toy into an even more fun game together.",
    },
    {
        "name": "🙏 Thank You Circle",
        "objective": "Practice saying thank you and naming one thing you're happy about.",
        "materials": ["None — just a small circle of family or friends"],
        "steps": [
            "Sit together in a circle with a grown-up.",
            "Take turns saying one thing you're happy or thankful for, like 'my blanket' or 'my dog.'",
            "A grown-up can help younger friends think of an idea.",
            "Clap gently for each person after they share.",
        ],
        "tip": "Noticing happy little things helps your heart feel warm and full.",
    },
    {
        "name": "🖐️ Thankful Hand Trace",
        "objective": "Practice naming things you're grateful for using your own hand as a guide.",
        "materials": ["Paper", "Crayon"],
        "steps": [
            "Trace your hand on paper with a grown-up's help.",
            "Name one thing you're thankful for on each finger.",
            "A grown-up can write or draw a small picture for each one.",
            "Show your thankful hand to someone and tell them about it!",
        ],
        "tip": "You have five thankful things right at your fingertips.",
    },
    {
        "name": "🐰 Honest Bunny Says",
        "objective": "Practice telling the truth about who did something, with a grown-up's gentle guidance.",
        "materials": ["A stuffed animal or puppet (any toy works)"],
        "steps": [
            "Grown-up holds up a stuffed animal and makes up a silly little mix-up, like 'who moved the blocks?'",
            "Practice saying 'I did it!' in a brave, honest voice.",
            "The grown-up gives a big smile and says thank you for being honest.",
            "Try a new silly mix-up and practice again.",
        ],
        "tip": "Telling the truth, even about small things, makes you a trusted friend.",
    },
    {
        "name": "🧩 Puzzle Piece Confession",
        "objective": "Practice admitting a small mistake honestly with a grown-up's support.",
        "materials": ["A simple puzzle (a few large pieces)"],
        "steps": [
            "Grown-up hides one puzzle piece before starting.",
            "Try to finish the puzzle and notice a piece is missing.",
            "Practice saying 'I think a piece is missing, can you help me find it?' honestly.",
            "Find the piece together and finish the puzzle!",
        ],
        "tip": "Speaking up honestly, even about a mix-up, helps solve problems together.",
    },
    {
        "name": "🌈 Not Yet Game",
        "objective": "Practice turning 'I can't' into 'I can't YET' with a cheerful grown-up-led game.",
        "materials": ["None — just a grown-up and a willing helper"],
        "steps": [
            "Grown-up says a simple thing, like 'I can't tie my shoe.'",
            "Together, add the magic word: 'I can't tie my shoe... YET!'",
            "Cheer loudly every time you add 'yet!'",
            "Try it with a few more simple 'I can't' ideas.",
        ],
        "tip": "The word 'yet' means you're still learning — and that's exciting!",
    },
    {
        "name": "🌱 Little Seed, Big Try",
        "objective": "Practice connecting trying hard things with the idea of slowly growing and improving.",
        "materials": ["Paper", "Crayon (to draw a seed and a plant)"],
        "steps": [
            "Draw a tiny seed on paper.",
            "Try something a little bit tricky, like stacking blocks or hopping on one foot.",
            "Each time you try, draw the seed growing a little taller.",
            "Celebrate when your drawing grows into a full little plant!",
        ],
        "tip": "Just like a seed, trying hard things helps you grow a little every day.",
    },
    {
        "name": "🙋 Please & Thank You Puppet Show",
        "objective": "Practice using polite words like please and thank you in a playful puppet show.",
        "materials": ["2 puppets or stuffed animals (or your own hands)"],
        "steps": [
            "Grown-up and child each hold a puppet.",
            "Act out a simple scene, like asking to borrow a crayon.",
            "Practice having the puppets say 'please' when asking and 'thank you' after.",
            "Switch puppets and try a new polite scene.",
        ],
        "tip": "Please and thank you are like little gifts you can give with your words.",
    },
    {
        "name": "🎁 Please Pass It Game",
        "objective": "Practice using polite words while passing an object around a small group.",
        "materials": ["1 soft object to pass, like a stuffed animal or ball"],
        "steps": [
            "Sit in a small circle with family or friends.",
            "Ask, 'Please may I have it?' before it's passed to you.",
            "Say 'thank you' when you receive it.",
            "Pass it to the next person and keep going around the circle.",
        ],
        "tip": "Polite words make sharing feel warm and friendly.",
    },
    {
        "name": "🐢 Slow and Steady Stack",
        "objective": "Practice patience and trying again when a block tower falls down.",
        "materials": ["Soft blocks or stackable cups"],
        "steps": [
            "Stack blocks one at a time, going slow and steady.",
            "If the tower falls, take a deep breath together.",
            "Say 'let's try again!' and start restacking.",
            "Celebrate however tall your tower gets.",
        ],
        "tip": "Going slow and trying again is its own kind of winning.",
    },
    {
        "name": "🧱 Block Tower Restart",
        "objective": "Practice a cheerful attitude about starting over after a small setback.",
        "materials": ["Soft blocks"],
        "steps": [
            "Build a tower together as tall as you can.",
            "When it tumbles down (it will!), clap and say 'oops, let's rebuild!'",
            "Build it again, maybe a little differently this time.",
            "Keep rebuilding together as many times as you'd like.",
        ],
        "tip": "Every tumble is just a chance to build again.",
    },
    {
        "name": "🤗 Comfort a Friend Game",
        "objective": "Practice noticing when someone is sad and offering comfort.",
        "materials": ["A stuffed animal to pretend is sad"],
        "steps": [
            "Grown-up holds a stuffed animal and says it feels sad.",
            "Think of one kind thing to say or do, like a gentle hug or 'I'm here for you.'",
            "Give the stuffed animal your kind words or a hug.",
            "Talk about how the stuffed animal (and you!) might feel better now.",
        ],
        "tip": "A caring word or a gentle hug can help a sad friend feel better.",
    },
    {
        "name": "🐻 Comfort Bear Circle",
        "objective": "Practice giving kind, comforting words to others in a group.",
        "materials": ["1 stuffed bear (or any stuffed animal)"],
        "steps": [
            "Sit in a small circle and pass around the stuffed bear.",
            "Pretend the bear is feeling a little sad today.",
            "Each person says one kind, comforting thing to the bear when it's their turn.",
            "Give the bear a group hug at the end!",
        ],
        "tip": "Kind words are a wonderful gift to share with anyone who needs them.",
    },
]


GAMES[1] = [
    {
        "name": "💛 Kindness Bingo Walk",
        "objective": "Practice noticing and doing simple kind acts around the house or classroom.",
        "materials": ["Paper bingo card with 4-6 pictures of kind acts", "Crayon or stickers"],
        "steps": [
            "Look at the pictures on your kindness bingo card (share, say thank you, help clean up, give a compliment).",
            "Walk around with a grown-up looking for chances to do each kind act.",
            "Mark off a square every time you complete one.",
            "See if you can fill the whole card by bedtime!",
        ],
        "tip": "Kindness is even more fun when you go looking for chances to share it.",
    },
    {
        "name": "🍪 Kind Cookie Pass",
        "objective": "Practice offering to share and thinking of others first.",
        "materials": ["A pretend plate of treats (drawn, or use blocks/toys as pretend cookies)"],
        "steps": [
            "Set out a pretend plate of treats with a grown-up.",
            "Before taking one for yourself, offer the plate to someone else first.",
            "Practice saying 'would you like one?' in a friendly voice.",
            "Take turns being the one who offers the plate.",
        ],
        "tip": "Offering first is a simple way to show someone you're thinking of them.",
    },
    {
        "name": "🌻 Gratitude Petal Game",
        "objective": "Practice naming several things you're grateful for using a growing paper flower.",
        "materials": ["Paper", "Crayon or scissors (grown-up can help cut petals)"],
        "steps": [
            "Draw or cut out a flower center on paper.",
            "Name one thing you're grateful for and add a petal for it.",
            "Keep naming grateful things and adding petals.",
            "Count your petals together when your flower is full!",
        ],
        "tip": "The more you notice to be grateful for, the fuller your flower grows.",
    },
    {
        "name": "🎈 Gratitude Balloon Pop",
        "objective": "Practice sharing something you're grateful for after a fun little surprise.",
        "materials": ["2-3 balloons with small paper prompts inside (or paper slips in a bag if no balloons)"],
        "steps": [
            "Grown-up puts a small gratitude prompt inside each balloon before blowing it up (or use paper slips in a bag).",
            "Pop a balloon (or pick a slip) gently.",
            "Read the prompt and answer it, like 'name someone who helps you.'",
            "Pop or pick another and keep sharing!",
        ],
        "tip": "A little surprise makes sharing gratitude even more fun.",
    },
    {
        "name": "🐷 Piggy Bank Honesty Game",
        "objective": "Practice deciding to tell the truth about a found item.",
        "materials": ["1 play coin or small toy"],
        "steps": [
            "Grown-up 'hides' a play coin somewhere in the room before you start.",
            "Find the coin during play.",
            "Practice saying 'I found this, whose is it?' instead of keeping it quietly.",
            "Talk about how good it feels to be honest about what you find.",
        ],
        "tip": "Speaking up honestly about a find is one of the kindest things you can do.",
    },
    {
        "name": "🎲 Honest Dice Game",
        "objective": "Practice choosing the honest response in simple everyday scenarios.",
        "materials": ["1 die (or a coin to flip)", "3-6 simple scenario cards read aloud by a grown-up"],
        "steps": [
            "Grown-up reads a simple scenario, like 'you broke a crayon by accident.'",
            "Roll the die (or flip the coin) to pick between two choices: tell what happened, or stay quiet.",
            "Talk about why telling what happened is the honest choice.",
            "Try a new scenario and roll again.",
        ],
        "tip": "Even a small accident is easier to fix when you're honest about it.",
    },
    {
        "name": "🐣 Hatching the Yet Egg",
        "objective": "Practice using the word 'yet' to turn a hard task into an exciting challenge.",
        "materials": ["Paper egg shape (drawn or cut out)", "Crayon"],
        "steps": [
            "Draw a big egg shape on paper.",
            "Try something a little tricky, like hopping five times in a row.",
            "Each time you try, color in a crack on the egg.",
            "When the egg 'hatches,' celebrate — you didn't do it before, but now you're getting closer!",
        ],
        "tip": "Every try cracks the egg a little more open toward 'I can!'",
    },
    {
        "name": "🧩 One More Try Puzzle",
        "objective": "Practice saying an encouraging 'yet' phrase when a task feels tricky.",
        "materials": ["A simple puzzle (chunky pieces)"],
        "steps": [
            "Start working on the puzzle together.",
            "If a piece is tricky, say out loud: 'I can't find this piece... yet!'",
            "Keep trying a little longer before asking for help.",
            "Cheer loudly when the puzzle is finished!",
        ],
        "tip": "Saying 'yet' out loud reminds your brain that trying pays off.",
    },
    {
        "name": "🎭 Manners Charades",
        "objective": "Practice recognizing polite behaviors by acting them out.",
        "materials": ["Index cards with simple manners drawn or written (grown-up can read them aloud)"],
        "steps": [
            "Grown-up picks a manners card, like 'saying please' or 'holding the door.'",
            "Act out the polite behavior without talking.",
            "Others guess which good manner is being shown.",
            "Take turns picking a new card and acting it out.",
        ],
        "tip": "Good manners are easy to spot once you know what to look for.",
    },
    {
        "name": "👋 Greeting Game",
        "objective": "Practice greeting others politely in different pretend situations.",
        "materials": ["None — just a willing partner"],
        "steps": [
            "Pretend to meet someone new, like a new neighbor or a friend's grown-up.",
            "Practice saying 'hello, nice to meet you' with a smile.",
            "Practice saying a polite 'goodbye, see you later!' too.",
            "Try a few different pretend meetings and greetings.",
        ],
        "tip": "A warm hello or goodbye can make someone's whole day better.",
    },
    {
        "name": "🎯 Bullseye of Effort",
        "objective": "Practice trying multiple times at a toss game, no matter where the toss lands.",
        "materials": ["A soft ball or beanbag", "A hoop or bucket target"],
        "steps": [
            "Stand a few steps from the target.",
            "Toss the ball toward the target.",
            "Whether you hit it or miss it, say 'good try!' and toss again.",
            "Keep tossing several times, celebrating each attempt.",
        ],
        "tip": "Every toss — hit or miss — is a chance to get a little better.",
    },
    {
        "name": "🐌 Snail Race Patience Game",
        "objective": "Practice patience by racing as slowly as possible instead of as fast as possible.",
        "materials": ["Open floor or yard space", "2 markers for start/finish"],
        "steps": [
            "Line up at the start marker.",
            "On 'go,' move as slowly as a snail toward the finish — no rushing!",
            "The last one to reach the finish line wins.",
            "Try again and see who can go even slower and steadier.",
        ],
        "tip": "Going slow and steady takes just as much focus as going fast.",
    },
    {
        "name": "🦸 Be a Buddy Game",
        "objective": "Practice including a friend who might be feeling left out.",
        "materials": ["2-3 simple scenario pictures or descriptions (read aloud by a grown-up)"],
        "steps": [
            "Grown-up describes a simple scene, like 'a friend is sitting alone at recess.'",
            "Think of one kind way to include them, like inviting them to play.",
            "Act out walking over and saying your kind invitation.",
            "Talk about how the left-out friend might feel afterward.",
        ],
        "tip": "One small invitation can turn someone's lonely moment into a happy one.",
    },
    {
        "name": "🧩 Everyone Gets a Turn Game",
        "objective": "Practice making sure everyone in a group gets included and gets a turn.",
        "materials": ["1 simple toy or game with turns (like rolling a ball back and forth)"],
        "steps": [
            "Play a simple turn-taking game in a small group.",
            "Before starting, name everyone who should get a turn.",
            "Check off (or count) each person's turn as you go.",
            "Celebrate together once everyone has had a turn!",
        ],
        "tip": "A game is more fun for everyone when nobody gets left out.",
    },
]


GAMES[2] = [
    {
        "name": "🎁 Kindness Coupon Game",
        "objective": "Practice planning and giving a kind act to someone in your family.",
        "materials": ["Paper cut into small coupon shapes", "Pencil or crayon"],
        "steps": [
            "Draw or write 3-4 simple kindness coupons, like 'I'll help set the table' or 'free hug.'",
            "Decorate each coupon.",
            "Give one coupon to a family member.",
            "Follow through and complete the kind act on the coupon!",
        ],
        "tip": "A kindness coupon is a promise — and keeping it feels great.",
    },
    {
        "name": "🎨 Kindness Rainbow",
        "objective": "Practice completing a full week of kind acts to build a colorful rainbow.",
        "materials": ["Paper with a rainbow outline", "Crayons"],
        "steps": [
            "Draw a big rainbow outline with several colored stripes.",
            "Do one kind act, then color in one stripe of the rainbow.",
            "Keep doing kind acts and coloring stripes over the next few days.",
            "Celebrate when your whole rainbow is colored in!",
        ],
        "tip": "Each kind act adds a little more color to your day.",
    },
    {
        "name": "📝 Gratitude Jar",
        "objective": "Practice writing down and sharing things you're grateful for.",
        "materials": ["A jar or box", "Small paper slips", "Pencil"],
        "steps": [
            "Write (or draw) one thing you're grateful for on a small slip of paper.",
            "Fold it and drop it in the jar.",
            "Add a new slip every day for a week.",
            "At the end of the week, read them all out loud together.",
        ],
        "tip": "A jar full of grateful notes is a jar full of happy reminders.",
    },
    {
        "name": "🌟 Gratitude Star Chart",
        "objective": "Practice noticing and recording things you're thankful for throughout a day.",
        "materials": ["Paper chart with empty stars", "Sticker or crayon"],
        "steps": [
            "Draw or print a chart with 5 empty stars.",
            "Each time you notice something you're grateful for, color or sticker a star.",
            "Say the grateful thing out loud when you fill each star.",
            "See if you can fill all 5 stars by the end of the day!",
        ],
        "tip": "Gratitude gets easier to spot the more you practice looking for it.",
    },
    {
        "name": "🎭 Truth or Tale",
        "objective": "Practice telling the difference between an honest choice and a dishonest one in short scenarios.",
        "materials": ["4-6 short scenario cards (a grown-up can write or read these aloud)"],
        "steps": [
            "Listen to a short scenario, like 'you spilled juice and no one saw.'",
            "Decide what the honest choice would be.",
            "Act out or say out loud what you would do and say.",
            "Talk about why the honest choice matters, even when no one is watching.",
        ],
        "tip": "Doing the honest thing when no one's watching shows real character.",
    },
    {
        "name": "🧵 Tell the Truth Trail",
        "objective": "Practice choosing honesty by moving forward along a simple path game.",
        "materials": ["Chalk or tape to mark a path with 6-8 steps", "Scenario cards"],
        "steps": [
            "Draw or mark a path with several steps toward a finish line.",
            "Read a scenario card at each step and choose the honest response.",
            "If you pick the honest choice, move forward one step.",
            "Reach the finish line by choosing honesty the whole way!",
        ],
        "tip": "Every honest choice moves you one step closer to being trusted.",
    },
    {
        "name": "💪 Turn It Into Yet",
        "objective": "Practice flipping 'I can't' statements into 'yet' statements with a next step.",
        "materials": ["4-5 cards with simple 'I can't...' statements written or drawn"],
        "steps": [
            "Pick a card and read the 'I can't...' statement out loud.",
            "Add the word 'yet' to the end of the sentence.",
            "Think of one small step you could try to get closer to 'I can.'",
            "Pick another card and try again.",
        ],
        "tip": "Adding 'yet' turns a stuck feeling into a starting point.",
    },
    {
        "name": "🎈 Yet Balloon Bounce",
        "objective": "Practice pairing a physical game with positive 'can't yet' self-talk.",
        "materials": ["1 balloon"],
        "steps": [
            "Bounce the balloon gently in the air with your hand.",
            "Each time you bounce it, say a 'can't yet' statement, like 'I can't do a cartwheel... yet!'",
            "Keep bouncing and adding new 'yet' statements.",
            "See how many bounces (and 'yets') you can do in a row!",
        ],
        "tip": "Turning 'can't' into 'yet' keeps your thinking bouncing in a good direction.",
    },
    {
        "name": "📞 Phone Manners Role Play",
        "objective": "Practice polite greetings, listening, and goodbyes during a pretend phone call.",
        "materials": ["A toy phone (or just your hand)"],
        "steps": [
            "Pretend to call a friend or family member.",
            "Practice a polite greeting, like 'Hello, this is [your name].'",
            "Listen without interrupting while your partner talks.",
            "End the call with a polite goodbye, like 'Thanks for talking, bye!'",
        ],
        "tip": "Polite listening is just as important as polite talking.",
    },
    {
        "name": "🙊 Interrupting Bell Game",
        "objective": "Practice waiting for your turn to speak instead of interrupting.",
        "materials": ["A small bell or a hand signal (like a raised hand)"],
        "steps": [
            "Have a short conversation with a partner about your day.",
            "If you feel the urge to interrupt, use the bell or raised hand signal instead of speaking.",
            "Wait until your partner finishes their sentence before you talk.",
            "Switch — let your partner practice waiting too.",
        ],
        "tip": "Waiting your turn to speak shows a friend that their words matter too.",
    },
    {
        "name": "🧵 String Untangle Challenge",
        "objective": "Practice staying patient and persistent while untangling a simple knot.",
        "materials": ["A length of soft string or yarn, lightly knotted"],
        "steps": [
            "Start with a gently tangled piece of string or yarn.",
            "Work slowly to untangle it, one loop at a time.",
            "If you feel frustrated, take a breath and keep trying.",
            "Celebrate when the string is completely untangled!",
        ],
        "tip": "Patience untangles more knots than frustration ever will.",
    },
    {
        "name": "🎯 Three Tries Challenge",
        "objective": "Practice noticing improvement across several attempts at the same task.",
        "materials": ["A simple task, like tossing a beanbag into a bucket"],
        "steps": [
            "Try the task once and notice how it goes.",
            "Try it a second time, thinking about one small thing to do differently.",
            "Try it a third time and compare to your first try.",
            "Talk about what got better between try one and try three.",
        ],
        "tip": "Trying again with a small change is how skills grow.",
    },
    {
        "name": "🌈 New Friend Welcome Game",
        "objective": "Practice role-playing a warm welcome for someone new to a group.",
        "materials": ["None — just a partner or small group"],
        "steps": [
            "One person pretends to be new to the group, standing a little apart.",
            "The others practice walking over and saying a friendly welcome.",
            "Invite the 'new friend' to join your game or activity.",
            "Switch roles so everyone gets to practice welcoming.",
        ],
        "tip": "A warm welcome can turn a nervous new friend into a happy one.",
    },
    {
        "name": "🫱 Helping Hand Relay",
        "objective": "Practice stopping to help a teammate before continuing a game.",
        "materials": ["2 cones or markers", "A small obstacle (like a hula hoop to step through)"],
        "steps": [
            "Set up a simple obstacle path between two markers.",
            "One player pretends to get 'stuck' partway through.",
            "The next player must stop and help them before either continues.",
            "Take turns being the one who gets stuck and the one who helps.",
        ],
        "tip": "A good teammate always makes time to help, even mid-race.",
    },
]


GAMES[3] = [
    {
        "name": "🐾 Compliment Circle",
        "objective": "Practice giving and receiving genuine compliments in a group.",
        "materials": ["None — just a small group"],
        "steps": [
            "Sit or stand in a circle.",
            "Take turns giving the person next to you a genuine compliment.",
            "Say thank you when you receive a compliment.",
            "Keep going around the circle until everyone has given and received one.",
        ],
        "tip": "A genuine compliment costs nothing but can mean everything to someone.",
    },
    {
        "name": "🎡 Kindness Wheel Spin",
        "objective": "Practice completing a randomly chosen act of kindness.",
        "materials": ["A paper spinner (or die) labeled with 4-6 kind acts"],
        "steps": [
            "Make a simple paper spinner with kind acts written around the edge, like 'give a compliment' or 'help without being asked.'",
            "Spin it to land on a kind act.",
            "Go complete that act sometime today.",
            "Spin again tomorrow for a new kind act to try!",
        ],
        "tip": "Letting the spinner choose can lead you to kind acts you might not have picked yourself.",
    },
    {
        "name": "💌 Thank-You Note Relay",
        "objective": "Practice expressing gratitude in writing to someone who has helped you.",
        "materials": ["Paper", "Pencil or crayons"],
        "steps": [
            "Think of someone who has helped or done something kind for you recently.",
            "Write (or draw) them a short thank-you note.",
            "Deliver the note to them yourself.",
            "Notice how it feels to make someone smile with your words.",
        ],
        "tip": "A written thank-you can be kept and reread long after the moment has passed.",
    },
    {
        "name": "🎤 Thankful Interview Duo",
        "objective": "Practice asking and answering questions about gratitude with a partner.",
        "materials": ["None — just a partner"],
        "steps": [
            "Pair up with a partner.",
            "Take turns asking, 'What is one thing you're thankful for today, and why?'",
            "Listen carefully to your partner's answer.",
            "Share what you learned about each other's answers with the group.",
        ],
        "tip": "Asking someone what they're grateful for is a great way to get to know them better.",
    },
    {
        "name": "🕵️‍♀️ Honesty Detective",
        "objective": "Practice identifying the honest choice in short everyday scenario cards.",
        "materials": ["5-6 scenario cards describing small honesty dilemmas"],
        "steps": [
            "Read a scenario card, like 'you got extra change back at the store by mistake.'",
            "Decide what the honest choice would be and why.",
            "Act out how you would handle it honestly.",
            "Move to the next scenario card and repeat.",
        ],
        "tip": "Being an honesty detective means noticing the honest path even when it's not obvious.",
    },
    {
        "name": "🔍 Spot the Fib Game",
        "objective": "Practice noticing when a short story doesn't add up and imagining the honest version.",
        "materials": ["3-4 short made-up stories with an inconsistency (read aloud by a grown-up or partner)"],
        "steps": [
            "Listen to a short story that has a small inconsistency, like someone's excuse not quite matching the facts.",
            "Try to spot what doesn't add up.",
            "Talk about what the honest version of the story might sound like.",
            "Try another story and spot the fib again.",
        ],
        "tip": "Noticing when something doesn't add up is the first step to choosing honesty yourself.",
    },
    {
        "name": "🧗 Challenge Ladder Game",
        "objective": "Practice attempting increasingly difficult challenges while celebrating effort at every level.",
        "materials": ["A simple list of 4-5 challenges in order of difficulty (like hop on one foot, then hop and clap, then hop and spin)"],
        "steps": [
            "Try the easiest challenge on your 'ladder' first.",
            "Whether you succeed or not, celebrate the attempt and move to the next rung.",
            "Keep climbing the ladder of harder challenges.",
            "Talk about which rung felt hardest and why you kept climbing anyway.",
        ],
        "tip": "Every rung you attempt — even a wobbly one — is real progress.",
    },
    {
        "name": "🖍️ Mistake Art Game",
        "objective": "Practice turning a mistake into something new instead of feeling upset about it.",
        "materials": ["Paper", "Crayons or markers"],
        "steps": [
            "Start drawing a picture.",
            "On purpose (or by accident), make a mistake mark on the paper.",
            "Turn that mistake into a new part of the drawing, like turning a smudge into a cloud.",
            "Talk about how mistakes can lead somewhere unexpected and good.",
        ],
        "tip": "A mistake is often just the start of a different — sometimes better — idea.",
    },
    {
        "name": "🍽️ Table Manners Challenge",
        "objective": "Practice recognizing and demonstrating good table manners.",
        "materials": ["A pretend table setting (plates, napkin, utensils — real or drawn)"],
        "steps": [
            "Set up a pretend meal at the table.",
            "Act out good table manners: napkin in lap, asking to pass food, chewing with your mouth closed.",
            "Have a partner act out one manners 'mistake' for you to spot and gently correct.",
            "Switch roles and try spotting a different mistake.",
        ],
        "tip": "Good table manners help everyone enjoy the meal together.",
    },
    {
        "name": "🧑‍🤝‍🧑 Personal Space Game",
        "objective": "Practice recognizing and respecting others' personal space during movement.",
        "materials": ["Open space", "Hula hoops (optional, one per player)"],
        "steps": [
            "If using hoops, each player stands inside their own hoop as their 'personal space bubble.'",
            "Move around the space, being careful not to bump into anyone else's bubble.",
            "Practice asking, 'Is it okay if I stand here?' before getting close to a friend.",
            "Talk about why respecting space helps everyone feel comfortable.",
        ],
        "tip": "Respecting someone's space is a quiet but powerful way to show respect.",
    },
    {
        "name": "🧩 Puzzle Persistence Challenge",
        "objective": "Practice using strategies to keep trying during a timed puzzle challenge.",
        "materials": ["A puzzle with a moderate number of pieces", "A timer (optional)"],
        "steps": [
            "Set a friendly time goal (or no timer at all) and start the puzzle.",
            "If you get stuck, try a new strategy, like sorting edge pieces first.",
            "Take a short breather if frustrated, then come back to it.",
            "Celebrate finishing, no matter how long it took.",
        ],
        "tip": "Persistence isn't about never getting stuck — it's about trying a new way when you do.",
    },
    {
        "name": "🏆 Effort Over Outcome Game",
        "objective": "Practice measuring success by effort and improvement rather than winning alone.",
        "materials": ["3-4 simple mini-challenges (like tossing, balancing, or hopping tasks)"],
        "steps": [
            "Try each mini-challenge and notice how many attempts it takes.",
            "Score yourself on effort (did you keep trying?) rather than just success.",
            "Compare your second attempt at each challenge to your first.",
            "Celebrate the challenge where you showed the most improvement.",
        ],
        "tip": "The score that matters most is how much effort you gave, not just the result.",
    },
    {
        "name": "🤝 Standing Up Kindly",
        "objective": "Practice standing up for a friend kindly, without being unkind back.",
        "materials": ["2-3 short scenario cards about a friend being teased"],
        "steps": [
            "Read a scenario where a friend is being teased or left out.",
            "Think of a kind, firm way to stand up for them, like 'that's not okay, let's go.'",
            "Act out saying your kind, firm response.",
            "Talk about why standing up kindly is more powerful than fighting back unkindly.",
        ],
        "tip": "Standing up for a friend works best when it's done with kindness, not anger.",
    },
    {
        "name": "🛡️ Kind Words Shield",
        "objective": "Practice responding to teasing with calm, kind, and confident words.",
        "materials": ["None — just a partner"],
        "steps": [
            "Partner gently pretends to tease about something silly and harmless.",
            "Practice responding calmly with a kind, confident phrase, like 'that's just how I am, and that's okay.'",
            "Switch roles so both partners get to practice.",
            "Talk about how staying calm can take away the sting of teasing.",
        ],
        "tip": "A calm, kind response is a strong shield against unkind words.",
    },
]


GAMES[4] = [
    {
        "name": "🕵️ Secret Kindness Mission",
        "objective": "Practice performing an anonymous kind act and reflecting on how it felt.",
        "materials": ["A jar or bag with 4-5 kindness mission slips"],
        "steps": [
            "Write 4-5 kindness mission ideas on slips of paper, like 'compliment someone you don't usually talk to.'",
            "Draw one mission from the jar without others seeing.",
            "Complete the mission secretly, without getting credit.",
            "Reflect afterward: how did it feel to do something kind without anyone knowing it was you?",
        ],
        "tip": "Kindness done in secret is just as meaningful — sometimes even more so.",
    },
    {
        "name": "🎁 Anonymous Kindness Notes",
        "objective": "Practice writing kind, encouraging notes for others without expecting credit.",
        "materials": ["Small paper slips", "Pencil"],
        "steps": [
            "Think of 2-3 people who could use a kind or encouraging note.",
            "Write a short, genuine note for each person.",
            "Deliver the notes anonymously, like slipping them somewhere the person will find them.",
            "Talk about why kindness doesn't need to be noticed to matter.",
        ],
        "tip": "The best kindness sometimes asks for nothing in return, not even a thank-you.",
    },
    {
        "name": "🔍 Gratitude Scavenger Hunt",
        "objective": "Practice noticing and appreciating things around you that you're grateful for.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Make a quick list of 5 categories, like 'something that makes you comfortable' or 'someone who helps you.'",
            "Search your home or room for an item or person that fits each category.",
            "Write down or sketch what you found for each one.",
            "Share your list with someone and explain why each item matters to you.",
        ],
        "tip": "Gratitude is easier to find when you go looking for it on purpose.",
    },
    {
        "name": "🔗 Gratitude Chain Reaction",
        "objective": "Practice connecting the things you're grateful for to the people who provide them.",
        "materials": ["Paper strips", "Tape or a stapler"],
        "steps": [
            "On each paper strip, write something you're grateful for and the person connected to it.",
            "Loop and tape (or staple) the strips together into a growing paper chain.",
            "Add a new link every day for several days.",
            "Hang up your finished chain as a reminder of everyone who helps you.",
        ],
        "tip": "Every link in your chain is a reminder that gratitude connects us to others.",
    },
    {
        "name": "🎬 The Broken Vase Scenario",
        "objective": "Practice choosing to admit a mistake honestly instead of hiding it.",
        "materials": ["None — just imagination and a partner"],
        "steps": [
            "Act out a scenario: you accidentally broke something and no one saw it happen.",
            "Practice one version where you hide the mistake, and talk about how that might feel later.",
            "Practice a second version where you honestly admit it right away.",
            "Discuss which choice leads to more trust in the long run, even if it's harder in the moment.",
        ],
        "tip": "Owning a mistake right away is almost always easier than carrying the secret.",
    },
    {
        "name": "🎭 Confess & Repair Role Play",
        "objective": "Practice not just admitting a mistake honestly, but also making it right.",
        "materials": ["2-3 scenario cards describing a mistake that affected someone else"],
        "steps": [
            "Read a scenario, like accidentally losing a friend's borrowed item.",
            "Practice honestly telling the person what happened.",
            "Go a step further — think of one way to repair or make up for the mistake.",
            "Act out both the honest confession and the repair plan.",
        ],
        "tip": "Real honesty includes both telling the truth and trying to make things right.",
    },
    {
        "name": "🔄 Flip the Thought",
        "objective": "Practice recognizing fixed-mindset thoughts and flipping them into growth-mindset ones.",
        "materials": ["5-6 cards with fixed-mindset statements written on them"],
        "steps": [
            "Read a fixed-mindset statement, like 'I'm just bad at this.'",
            "Flip it into a growth-mindset version, like 'I'm still learning this.'",
            "Say both versions out loud and notice how they feel different.",
            "Try flipping a few more statements with a partner.",
        ],
        "tip": "The thought you choose to believe shapes how hard you're willing to try.",
    },
    {
        "name": "🧠 Brain Grows Stronger Game",
        "objective": "Practice a new physical skill and connect the effort to how the brain grows through practice.",
        "materials": ["2-3 soft scarves or small balls for a simple juggling-style challenge"],
        "steps": [
            "Try a brand-new small challenge, like juggling two soft scarves.",
            "Notice that it feels awkward and hard at first — that's expected!",
            "Keep practicing for a few minutes, tracking small improvements.",
            "Talk about how your brain builds new pathways every time you practice something hard.",
        ],
        "tip": "Feeling awkward at something new is a sign your brain is busy growing.",
    },
    {
        "name": "👂 Listening Ears Challenge",
        "objective": "Practice active listening and respectful eye contact during a partner conversation.",
        "materials": ["None — just a partner"],
        "steps": [
            "Partner up and take turns being the speaker and the listener.",
            "The speaker shares something about their day for one minute.",
            "The listener practices eye contact, nodding, and not interrupting.",
            "Switch roles, then talk about what good listening felt like from both sides.",
        ],
        "tip": "Really listening tells someone their words matter to you.",
    },
    {
        "name": "📖 Manners Story Fix-It",
        "objective": "Practice identifying rude behavior in a story and rewriting it politely.",
        "materials": ["A short story with a rude behavior moment (written or read aloud)"],
        "steps": [
            "Read or listen to a short story where a character behaves rudely.",
            "Identify exactly what was impolite about their behavior.",
            "Rewrite or act out the scene with a polite version instead.",
            "Compare how the polite version might change how others in the story feel.",
        ],
        "tip": "Noticing rude behavior in a story helps you recognize — and choose against — it in real life.",
    },
    {
        "name": "🏆 Effort Medal Challenge",
        "objective": "Practice completing a series of small challenges and being rewarded for effort and improvement.",
        "materials": ["3-4 mini physical or mental challenges", "Paper medals (drawn or cut out)"],
        "steps": [
            "Attempt each mini-challenge, like a balance test or a quick math puzzle.",
            "After each one, award yourself a paper medal based on effort and improvement, not just success.",
            "Reflect on which challenge took the most perseverance.",
            "Display your medals as a reminder of your effort.",
        ],
        "tip": "A medal for effort matters just as much as a medal for winning.",
    },
    {
        "name": "📈 Practice Makes Progress Chart",
        "objective": "Practice tracking improvement at a skill over multiple attempts.",
        "materials": ["Paper", "Pencil", "A simple skill to practice, like tossing a ball into a bucket"],
        "steps": [
            "Try the skill and record your result, like how many tosses out of five went in.",
            "Practice the skill a few more times, recording each result on your chart.",
            "Look at your chart to see how your numbers changed.",
            "Talk about what practice did for your results, even without practicing for long.",
        ],
        "tip": "A chart of your tries shows proof that practice really does help.",
    },
    {
        "name": "🧭 Include Everyone Challenge",
        "objective": "Practice noticing who's left out in a group setting and finding a way to include them.",
        "materials": ["3-4 scenario cards about group activities where someone is unintentionally excluded"],
        "steps": [
            "Read a scenario, like a group project where one person wasn't asked to join.",
            "Brainstorm a specific way to include that person going forward.",
            "Act out approaching them and offering a genuine invitation.",
            "Discuss how noticing exclusion — even unintentional — is the first step to fixing it.",
        ],
        "tip": "Inclusion often starts with simply noticing who isn't in the circle yet.",
    },
    {
        "name": "💝 Plan a Kind Act Challenge",
        "objective": "Practice planning a deliberate, thoughtful kind act for someone who might need it and reflecting on its impact.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Think of someone who might be having a hard week and could use some support.",
            "Plan a specific, thoughtful kind act just for them.",
            "Carry out your planned act of kindness.",
            "Reflect afterward: how did planning ahead change the impact of your kindness?",
        ],
        "tip": "A little planning can turn kindness from an accident into something truly meaningful.",
    },
]


GAMES[5] = [
    {
        "name": "📣 Kindness Ripple Challenge",
        "objective": "Practice thinking through how one kind act might inspire a chain reaction of kindness in others.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Do one genuine kind act for someone today.",
            "Imagine (or ask, if possible) whether your kind act inspired them to do something kind for someone else.",
            "Sketch or write out the possible 'ripple' — who might your kindness reach beyond the first person?",
            "Discuss with a group: how far do you think a single kind act can really travel?",
        ],
        "tip": "Kindness rarely stops with just one person — it tends to ripple outward.",
    },
    {
        "name": "🎯 Kindness Impact Challenge",
        "objective": "Practice planning a deliberate act of kindness aimed at real impact, then reflecting on the outcome.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Identify someone whose day could genuinely be improved by a kind act.",
            "Plan a specific act that fits what that person actually needs (not just what's easiest for you).",
            "Carry out your planned kind act.",
            "Reflect and discuss: did the impact match what you expected? What did you learn?",
        ],
        "tip": "The most meaningful kindness is often shaped around what someone actually needs.",
    },
    {
        "name": "🎙️ Gratitude Interview",
        "objective": "Practice interviewing someone about what they're grateful for and reflecting on their answer.",
        "materials": ["Paper", "Pencil", "A few interview questions"],
        "steps": [
            "Prepare 2-3 questions about gratitude, like 'what's something you're grateful for that most people wouldn't guess?'",
            "Interview a family member or friend, writing down their answers.",
            "Share what surprised you most about their answers.",
            "Discuss as a group how gratitude can look different from person to person.",
        ],
        "tip": "Asking someone about their gratitude often reveals what really matters to them.",
    },
    {
        "name": "🗓️ Gratitude Countdown Reflection",
        "objective": "Practice a week-long gratitude habit and reflecting on patterns in what you noticed.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Each day for a week, write one thing you're grateful for and one sentence about why.",
            "At the end of the week, review your full list.",
            "Look for patterns — do certain people, places, or moments show up often?",
            "Discuss what your patterns reveal about what truly matters to you.",
        ],
        "tip": "A week of tracked gratitude often shows you what you value most, even if you hadn't noticed before.",
    },
    {
        "name": "🧩 The Group Project Dilemma",
        "objective": "Practice role-playing an honesty dilemma about fairly representing group work contributions.",
        "materials": ["1 scenario card describing a group project where contributions were uneven"],
        "steps": [
            "Read the scenario: a group project is being graded, but one member did much less work than the others.",
            "Role-play a conversation about how to honestly represent everyone's contribution.",
            "Discuss different honest approaches — talking to the teacher, talking to the group member directly, or something else.",
            "As a group, discuss which approach balances honesty with fairness and kindness best.",
        ],
        "tip": "Honesty about group work protects fairness for everyone, including the person who did less.",
    },
    {
        "name": "🎲 Honesty Choices Card Game",
        "objective": "Practice ranking honesty dilemmas by difficulty and discussing strategies for tackling hard ones.",
        "materials": ["6-8 more advanced honesty scenario cards"],
        "steps": [
            "Read through advanced scenarios, like 'a friend asks you to cover for them.'",
            "Rank the scenarios from easiest to hardest to handle honestly.",
            "For the hardest scenario, brainstorm as a group what an honest, respectful response could sound like.",
            "Discuss why some honest choices feel riskier to your friendships than others.",
        ],
        "tip": "The hardest honest choices are often the ones that matter most.",
    },
    {
        "name": "📈 Yet Journey Map",
        "objective": "Practice mapping out the practice steps needed to move from 'can't' to 'can' for a real skill.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick a real skill you can't do yet, but would like to learn.",
            "Map out 4-5 small steps that could help you get closer to 'can.'",
            "Try the first step on your map today.",
            "Discuss with a partner: which step do you think will be hardest, and why?",
        ],
        "tip": "A map from 'can't' to 'can' makes a big goal feel like a series of doable steps.",
    },
    {
        "name": "🎤 Growth Mindset Debate",
        "objective": "Practice defending a growth-mindset viewpoint in a friendly debate about ability and effort.",
        "materials": ["A list of debate statements about talent vs. effort"],
        "steps": [
            "Read a statement, like 'some people are just naturally good at things and others aren't.'",
            "Take the growth-mindset side of the debate and argue that effort and practice matter most.",
            "Listen to a partner's counterpoints and respond respectfully.",
            "Reflect afterward: did arguing for growth mindset change how you think about your own challenges?",
        ],
        "tip": "Arguing for a growth mindset out loud can help you believe it a little more yourself.",
    },
    {
        "name": "💬 Respectful Disagreement Game",
        "objective": "Practice disagreeing with someone's opinion while remaining fully respectful of them.",
        "materials": ["A list of mild opinion topics", "Respectful phrase starter cards"],
        "steps": [
            "Pick a mild opinion topic to discuss with a partner.",
            "When you disagree, use a respectful phrase starter, like 'I understand why you think that, and here's my view...'",
            "Practice fully hearing your partner's point before responding.",
            "Discuss how the conversation might have gone differently without respectful language.",
        ],
        "tip": "Respectful disagreement lets you keep the relationship even when you don't keep the same opinion.",
    },
    {
        "name": "🌐 Digital Manners Challenge",
        "objective": "Practice deciding on and role-playing respectful responses in online/digital scenario cards.",
        "materials": ["4-5 scenario cards about texting or online comments"],
        "steps": [
            "Read a digital scenario, like receiving a rude comment on a group chat.",
            "Decide on a respectful, level-headed way to respond (or choose not to respond).",
            "Role-play typing out (or saying aloud) your respectful response.",
            "Discuss as a group why digital manners matter just as much as in-person manners.",
        ],
        "tip": "The words you type carry just as much weight as the words you say out loud.",
    },
    {
        "name": "🔄 Setback Comeback Game",
        "objective": "Practice brainstorming and acting out thoughtful responses to real-feeling setback scenarios.",
        "materials": ["4-5 setback scenario cards, like not making a team or getting a low grade despite effort"],
        "steps": [
            "Read a setback scenario card aloud.",
            "Brainstorm 2-3 different ways someone could respond, from unhelpful to helpful.",
            "Act out the most helpful, perseverance-focused response.",
            "Discuss as a group what makes a comeback response actually helpful rather than just positive-sounding.",
        ],
        "tip": "A good comeback response takes the setback seriously and still finds a way forward.",
    },
    {
        "name": "🎯 Long-Term Goal Challenge",
        "objective": "Practice setting a personal goal, planning practice steps, and discussing what perseverance looks like over time.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Set a small personal goal you'd like to improve at over the next couple of weeks.",
            "Plan out a few practice steps and roughly when you'll do them.",
            "Check in on your progress after a few days.",
            "Discuss with a partner or group: what does perseverance look like when progress is slow?",
        ],
        "tip": "Perseverance over weeks looks different than perseverance in a single moment — both matter.",
    },
    {
        "name": "🎭 Ally Role Play",
        "objective": "Practice role-playing being an upstander who supports a peer during a conflict, rather than staying a bystander.",
        "materials": ["2-3 scenario cards describing a peer conflict or unkind moment"],
        "steps": [
            "Read a scenario where someone is being treated unkindly by a peer.",
            "Discuss the difference between a bystander (who watches) and an upstander (who helps).",
            "Role-play an upstander response, like calmly saying 'that's not okay' or checking in with the person afterward.",
            "Discuss as a group why being an upstander can feel hard, and what makes it easier to do.",
        ],
        "tip": "Being an upstander doesn't require being loud — it just requires being willing to act.",
    },
    {
        "name": "🧩 Team Trust Challenge",
        "objective": "Practice a cooperative trust-building challenge and reflecting on how to support teammates.",
        "materials": ["A blindfold (or closed eyes)", "A simple safe obstacle path (cones or soft objects)"],
        "steps": [
            "Set up a simple, safe obstacle path.",
            "One partner closes their eyes (or wears a blindfold) while the other gives verbal directions through the path.",
            "Switch roles so both partners experience guiding and trusting.",
            "Discuss afterward: what helped you trust your partner, and how can you be that kind of trustworthy teammate for others?",
        ],
        "tip": "Trust is built through small moments of clear communication and follow-through.",
    },
]


GAMES[6] = [
    {
        "name": "🌟 Random Acts Planning Game",
        "objective": "Practice brainstorming and planning kind acts for people outside your usual circle of friends.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Brainstorm a list of 5-6 random acts of kindness aimed at people you don't usually interact with.",
            "Choose one that feels genuinely doable and meaningful.",
            "Carry out your chosen act of kindness this week.",
            "Discuss afterward: why can kindness toward strangers or new people feel different than kindness toward close friends?",
        ],
        "tip": "Stepping outside your usual circle is where kindness can have the most unexpected impact.",
    },
    {
        "name": "🧭 Kindness Priorities Discussion",
        "objective": "Practice discussing and ranking different kind acts by their potential impact, and choosing where to focus your effort.",
        "materials": ["6-8 kind-act scenario cards of varying scale (small daily kindness vs. bigger organized efforts)"],
        "steps": [
            "Read through the kind-act scenario cards as a group.",
            "Discuss and rank them by how much of an impact each might have, and how much effort each takes.",
            "Debate: is a small daily kindness more valuable than a big occasional one?",
            "Choose one from the list to actually put into action this week.",
        ],
        "tip": "Both small daily kindness and big planned kindness matter — the key is actually doing one.",
    },
    {
        "name": "🌍 Gratitude Perspective Challenge",
        "objective": "Practice finding something to be grateful for within a genuinely frustrating or difficult situation.",
        "materials": ["3-4 scenario cards describing a mildly frustrating or difficult situation"],
        "steps": [
            "Read a frustrating scenario card, like a canceled plan or a tough loss in a game.",
            "Brainstorm something — even something small — to be grateful for within that situation.",
            "Share your reframed perspective with the group.",
            "Discuss: does finding gratitude in a hard moment change how it feels, or just how you think about it?",
        ],
        "tip": "Gratitude doesn't erase a hard moment, but it can change how much power that moment has over you.",
    },
    {
        "name": "🔁 Gratitude vs. Complaint Tally",
        "objective": "Practice noticing the balance between gratitude and complaint in your own everyday thinking.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "For one day, keep a simple tally of moments you complain about something versus moments you feel grateful for something.",
            "At the end of the day, compare your two tallies.",
            "Discuss what surprised you about the balance.",
            "Set a small goal for shifting the balance a little more toward gratitude tomorrow.",
        ],
        "tip": "Noticing your own gratitude-to-complaint ratio is the first step to shifting it.",
    },
    {
        "name": "🗣️ Integrity Under Pressure",
        "objective": "Practice discussing and role-playing a complex honesty dilemma involving peer pressure.",
        "materials": ["1-2 layered scenario cards, like a friend cheating and asking you not to tell"],
        "steps": [
            "Read a layered scenario where staying honest could put a friendship at risk.",
            "Discuss as a group the different possible responses and their consequences.",
            "Role-play the response that best balances honesty with care for the friendship.",
            "Reflect: what makes integrity harder to hold onto when there's real social pressure involved?",
        ],
        "tip": "Integrity under pressure is harder than integrity when it's easy — and that's exactly when it counts most.",
    },
    {
        "name": "🧭 Honesty Compass Discussion",
        "objective": "Practice mapping out different honest responses to a layered ethical dilemma and discussing trade-offs.",
        "materials": ["1-2 layered ethical dilemma cards (e.g., a small 'white lie' vs. a harmful lie)"],
        "steps": [
            "Read a layered dilemma involving different shades of honesty.",
            "As a group, map out at least 2-3 different honest responses and what each might lead to.",
            "Discuss whether all lies are equally serious, and why or why not.",
            "Reflect individually: what's your own 'honesty compass' — the values that guide your choice?",
        ],
        "tip": "Not every honesty dilemma has one perfect answer — but thinking it through carefully always helps.",
    },
    {
        "name": "🧠 Fixed vs Growth Sorting Challenge",
        "objective": "Practice sorting statements into fixed vs. growth mindset categories and discussing how to shift fixed thinking.",
        "materials": ["8-10 mindset statement cards"],
        "steps": [
            "Sort each statement card into a 'fixed mindset' or 'growth mindset' pile.",
            "For each fixed-mindset statement, discuss as a group how you could reframe it.",
            "Pick the fixed-mindset statement that feels most familiar to your own thinking.",
            "Discuss and write your own reframed version of it.",
        ],
        "tip": "Recognizing a fixed-mindset thought is the first step to being able to change it.",
    },
    {
        "name": "📊 Growth Mindset Self-Audit",
        "objective": "Practice honestly reflecting on your own mindset patterns across different areas of life.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "List 3-4 areas of your life, like sports, school subjects, or a hobby.",
            "For each area, honestly rate whether your self-talk leans more fixed or growth mindset.",
            "Pick the area with the most fixed-mindset thinking and write one growth-mindset phrase to try using there.",
            "Discuss with a partner: which area was hardest to be honest about, and why?",
        ],
        "tip": "A growth mindset isn't all-or-nothing — most people have it in some areas and not others.",
    },
    {
        "name": "🌐 Netiquette Scenario Challenge",
        "objective": "Practice discussing and deciding respectful responses to realistic online communication scenarios.",
        "materials": ["4-5 realistic scenario cards about texting or online comments"],
        "steps": [
            "Read a scenario, like seeing a harsh comment posted about a classmate online.",
            "Discuss as a group what a respectful, responsible response could look like.",
            "Role-play typing out (or saying aloud) that respectful response.",
            "Reflect: why can it feel easier to be unkind online than in person, and what can you do about that?",
        ],
        "tip": "Respect online takes more intention because you can't see the other person's face — so give it extra care.",
    },
    {
        "name": "🗳️ Respectful Disagreement Panel",
        "objective": "Practice holding a structured, respectful discussion on a topic with differing opinions.",
        "materials": ["A mild discussion topic with multiple valid viewpoints", "Discussion ground rules (written or discussed beforehand)"],
        "steps": [
            "As a group, agree on respectful discussion ground rules, like no interrupting and using 'I' statements.",
            "Discuss a topic where people are likely to have different opinions.",
            "Practice acknowledging a good point from someone you disagree with before responding.",
            "Reflect afterward: how did the ground rules change the tone of the discussion?",
        ],
        "tip": "A respectful discussion isn't about avoiding disagreement — it's about disagreeing well.",
    },
    {
        "name": "🎯 Long-Term Goal Challenge: Team Edition",
        "objective": "Practice supporting a teammate's long-term goal and discussing what perseverance looks like as a group effort.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pair up and each share a personal goal you're working toward.",
            "Brainstorm one specific way you could support your partner's perseverance over the next couple of weeks.",
            "Check in with each other partway through to see how it's going.",
            "Discuss as a group: how does having someone else's support change your own perseverance?",
        ],
        "tip": "Perseverance is often easier when someone else is cheering you on and checking in.",
    },
    {
        "name": "🔁 Setback Reframe Discussion",
        "objective": "Practice reframing a real or realistic setback as a source of useful information rather than just a failure.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Think of a real setback you've experienced (or use a realistic example scenario).",
            "Write down what the setback might have taught you, even if it didn't feel that way at the time.",
            "Share your reframed setback with a partner or group.",
            "Discuss: does reframing a setback change how likely you are to try again?",
        ],
        "tip": "A setback reframed as a lesson is far less likely to stop you the next time.",
    },
    {
        "name": "⚖️ Upstander Dilemma Discussion Game",
        "objective": "Practice discussing complex scenarios about witnessing unkindness and weighing different upstander responses.",
        "materials": ["3-4 layered scenario cards about witnessing unkind behavior"],
        "steps": [
            "Read a layered scenario where stepping in could be risky or awkward.",
            "Discuss as a group at least 2-3 different ways someone could respond as an upstander.",
            "Weigh the pros and cons of each response — which balances courage and safety best?",
            "Reflect individually: which response would actually feel realistic for you to try?",
        ],
        "tip": "There's more than one way to be an upstander — the best one is the one you can actually follow through on.",
    },
    {
        "name": "🧩 Team Trust Challenge: Reflection Edition",
        "objective": "Practice a cooperative trust exercise followed by a deeper group discussion on supporting teammates.",
        "materials": ["A blindfold (or closed eyes)", "A simple safe obstacle path"],
        "steps": [
            "Set up a safe obstacle path and pair up, with one partner guiding the other (eyes closed) through it using only words.",
            "Switch roles so both partners experience trusting and guiding.",
            "As a full group, discuss what specific communication helped build trust fastest.",
            "Reflect: how can these same trust-building habits show up in a real team or friend group?",
        ],
        "tip": "Trust between teammates is built the same way every time — through clear words and follow-through.",
    },
]


GAMES[7] = [
    {
        "name": "🌟 Random Acts Planning Game II",
        "objective": "Practice brainstorming, choosing, and following through on a bigger act of kindness with a clear plan.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Brainstorm a list of kind acts that would require some planning to pull off, like organizing a small collection for a cause.",
            "Choose one and outline the steps needed to make it happen.",
            "Carry out at least the first step this week.",
            "Discuss as a group: what makes a planned act of kindness feel different from a spontaneous one?",
        ],
        "tip": "The kind acts that take the most planning often create the biggest impact.",
    },
    {
        "name": "🧭 Kindness Priorities Debate",
        "objective": "Practice debating and defending different views on how kindness effort should be prioritized.",
        "materials": ["6-8 kind-act scenario cards of varying scale"],
        "steps": [
            "Split into two small groups, each defending a different view: 'small daily kindness matters most' vs. 'big planned kindness matters most.'",
            "Each group makes its best case using the scenario cards as evidence.",
            "Come back together and discuss where the two views actually overlap.",
            "Agree as a group on one kind act — small or big — to actually carry out this week.",
        ],
        "tip": "Debating kindness helps you see there's more than one right way to show it.",
    },
    {
        "name": "🌍 Gratitude Under Pressure",
        "objective": "Practice finding genuine gratitude within a more serious or emotionally complex situation.",
        "materials": ["3-4 scenario cards describing a more significant setback or disappointment"],
        "steps": [
            "Read a scenario describing a real disappointment, like not getting picked for something you worked hard for.",
            "Discuss as a group why forced positivity ('just be grateful!') can sometimes feel dismissive.",
            "Brainstorm genuine, honest gratitude that can coexist with disappointment, not replace it.",
            "Reflect: how is 'gratitude alongside disappointment' different from 'gratitude instead of it'?",
        ],
        "tip": "Real gratitude doesn't require pretending hard things don't hurt — it can sit right beside them.",
    },
    {
        "name": "🔁 Gratitude Ripple Mapping",
        "objective": "Practice tracing how one act of gratitude or appreciation can influence a wider circle of people.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pick one person you're grateful for and map out how their help reached you (who helped them along the way?).",
            "Sketch a simple diagram showing the chain of people connected to that one moment of gratitude.",
            "Share your map with the group and discuss what surprised you.",
            "Consider: who might be at the start of a ripple that eventually reaches you without you even realizing it?",
        ],
        "tip": "Gratitude often traces back further than the one person right in front of you.",
    },
    {
        "name": "🗣️ Integrity Under Pressure: Peer Panel",
        "objective": "Practice discussing multiple realistic honesty-under-pressure dilemmas as a panel and comparing responses.",
        "materials": ["2-3 layered scenario cards involving peer pressure and honesty"],
        "steps": [
            "Split into small groups, each assigned a different layered honesty dilemma.",
            "Each group discusses and prepares their best honest, respectful response.",
            "Present your group's scenario and response to the full group as a short 'panel.'",
            "Compare responses across groups: what approaches came up again and again?",
        ],
        "tip": "Hearing how others handle the same hard choice can give you more tools for your own.",
    },
    {
        "name": "🧭 Honesty Compass: Real-World Edition",
        "objective": "Practice applying an honesty framework to a dilemma drawn from real or realistic everyday situations.",
        "materials": ["1-2 realistic dilemma cards drawn from school, friendship, or online situations"],
        "steps": [
            "Read a realistic dilemma involving honesty and competing loyalties.",
            "As a group, identify who could be affected by each possible honest response.",
            "Choose the response that best balances honesty, fairness, and care for others.",
            "Reflect individually: has something like this ever actually happened to you, and what did you do?",
        ],
        "tip": "The best honesty compass considers not just what's true, but who it affects.",
    },
    {
        "name": "🧠 Fixed vs Growth: Real Talk Edition",
        "objective": "Practice identifying fixed-mindset language in real conversations and practicing a growth-mindset reply.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Recall a recent moment when you or someone around you said something fixed-mindset, like 'I'm just not a math person.'",
            "Write down what a growth-mindset reply could have sounded like instead.",
            "Practice saying that growth-mindset reply out loud with a partner.",
            "Discuss: how might that small change in language have changed the rest of the conversation?",
        ],
        "tip": "Catching fixed-mindset language in real conversations — not just on cards — is where the real practice happens.",
    },
    {
        "name": "📊 Growth Mindset Self-Audit: Deep Dive",
        "objective": "Practice a more detailed reflection connecting mindset patterns to specific past challenges and future plans.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Think of a specific challenge you faced this year and how you talked to yourself about it.",
            "Rate how fixed or growth-mindset your self-talk was during that challenge.",
            "Write one sentence describing how you'd like to talk to yourself the next time something similar happens.",
            "Share with a partner and discuss what makes it hard to remember to use growth-mindset self-talk in the moment.",
        ],
        "tip": "Planning your growth-mindset self-talk ahead of time makes it easier to use when you actually need it.",
    },
    {
        "name": "🌐 Netiquette Case Studies",
        "objective": "Practice analyzing realistic digital-communication case studies and proposing thoughtful, respectful responses.",
        "materials": ["4-5 detailed realistic case-study scenarios about group chats, comments, or messaging"],
        "steps": [
            "Read a detailed case study involving a digital communication conflict or gray area.",
            "Discuss in small groups what a respectful, responsible response could look like, and why.",
            "Consider more than one option and weigh their pros and cons.",
            "Present your group's recommended response and reasoning to the full group.",
        ],
        "tip": "Thinking through digital dilemmas ahead of time makes it easier to respond well in the actual moment.",
    },
    {
        "name": "🗳️ Respectful Disagreement Panel: Cross Views",
        "objective": "Practice representing and respectfully defending a viewpoint you don't personally hold, to build empathy for other perspectives.",
        "materials": ["A mild discussion topic with multiple valid viewpoints", "Assigned viewpoint cards"],
        "steps": [
            "Each participant is assigned a viewpoint to argue, which may not be their own personal opinion.",
            "Prepare your best respectful case for your assigned viewpoint.",
            "Hold a structured discussion where each side is heard fully before responding.",
            "Reflect afterward: did arguing a different viewpoint change how you understand people who hold it?",
        ],
        "tip": "Respectfully arguing a view you don't hold is one of the fastest ways to build empathy for people who do.",
    },
    {
        "name": "🎯 Long-Term Goal Challenge: Mentor Edition",
        "objective": "Practice mentoring a younger student or peer through a small perseverance challenge and reflecting on what good mentoring looks like.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Pair up with a younger student or peer working on a goal of their own.",
            "Offer specific, encouraging support and check in on their progress over a set period.",
            "Reflect on what kind of support actually helped them keep going.",
            "Discuss as a group: how is mentoring someone else's perseverance different from managing your own?",
        ],
        "tip": "Helping someone else persevere often teaches you just as much about your own perseverance.",
    },
    {
        "name": "🔁 Setback Reframe Discussion: Long View",
        "objective": "Practice reframing a setback with a longer-term perspective, considering how it might look a year from now.",
        "materials": ["Paper", "Pencil"],
        "steps": [
            "Think of a real or realistic setback and write down how it feels right now.",
            "Imagine looking back on this setback a year from now — write what you think you might say about it then.",
            "Compare the two perspectives and discuss what changed.",
            "Share with a partner: does imagining the long view make the setback feel any different today?",
        ],
        "tip": "Most setbacks look smaller from a year away than they do in the moment.",
    },
    {
        "name": "⚖️ Upstander Dilemma: Escalation Edition",
        "objective": "Practice discussing a multi-step scenario where the right upstander response may need to change as a situation escalates.",
        "materials": ["2-3 multi-part scenario cards where an unkind situation escalates over several steps"],
        "steps": [
            "Read a scenario that unfolds in stages, starting mild and becoming more serious.",
            "At each stage, discuss as a group what an upstander response could look like — and whether it needs to change.",
            "Identify the point where getting a trusted adult involved becomes the right call.",
            "Reflect: how do you decide when to handle something yourself versus when to ask for help?",
        ],
        "tip": "Knowing when to ask a trusted adult for help is itself a form of courage, not a failure to handle it alone.",
    },
    {
        "name": "🧩 Team Trust Challenge: Leadership Edition",
        "objective": "Practice leading a small team through a cooperative trust challenge and reflecting on what made your leadership effective.",
        "materials": ["A blindfold (or closed eyes)", "A simple safe obstacle path", "3-4 teammates"],
        "steps": [
            "As the designated leader, guide a small blindfolded team one at a time through a safe obstacle path using only clear verbal directions.",
            "Rotate the leader role so everyone gets a turn leading and being guided.",
            "As a group, discuss which leader's directions were easiest to follow, and why.",
            "Reflect: what does this exercise teach about the kind of communication that earns a team's trust?",
        ],
        "tip": "Clear, calm communication is one of the fastest ways to earn a team's trust.",
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
    # inside their own parenthetical text (e.g. "(leaf, rock, flower...)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 79_character_games_content.sql")
    out.append("-- Adds a 'Character Building Games' category to the existing always-on")
    out.append("-- 'character' subject_area for every grade (TK-6th) — no schema or proc")
    out.append("-- changes needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket")
    out.append("-- exactly as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games spanning the subject_area's existing")
    out.append("-- themes (growth mindset / 'yet' thinking, manners & respect, honesty and")
    out.append("-- other moral lessons, kindness, and gratitude); target_count=7 (fixed, not")
    out.append("-- the usual ~65% auto-rebalance ratio) means the existing NEWID()-sampling")
    out.append("-- rotation serves a different 7-of-14 combination most weeks a grade's")
    out.append("-- character category is selected, satisfying '7 character games, different")
    out.append("-- set each week' without any manual per-week authoring.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print — see 63_whole_child_rotation.sql). answer_text")
    out.append("-- carries a short values-focused closing tip for the game.")
    out.append("-- See gen_79_character_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'character' AND category_name = N'Character Building Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_char_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'character', N'Character Building Games', 'space_heavy', 7, N'Practice being your best self with a fun character-building game!', 0);"
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
    # Hit this for real on this exact content type: shipped 112 rows with
    # \r\n before catching it (see gen_68_outdoor_games_content.py).
    with open(r"D:\Project\www\littlescholarhub\lsh.database\79_character_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 79_character_games_content.sql", file=sys.stderr)
