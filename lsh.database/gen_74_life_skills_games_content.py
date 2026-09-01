# -*- coding: utf-8 -*-
"""
Generates lsh.database/74_life_skills_games_content.sql — adds a "Real-Life
Skills Games" category to the existing always-on 'life_skills' subject_area
(no schema/proc changes needed) for every grade TK-6. Each grade gets a pool
of 14 hand-crafted games; target_count=7 (fixed, not the usual ~65%
auto-rebalance ratio) means the existing NEWID()-sampling rotation serves a
different 7-of-14 combination most weeks a grade's life_skills category is
picked, so consecutive weeks show a different set without any manual
"week 1 / week 2" authoring.

The games span the subject area's existing themes (Digital Literacy & Online
Safety, Financial Literacy, Organization, Time Management) inside ONE new
"Games" category, hand-crafted per grade (not templated word-swaps). These
are printed weekly-packet games played at home, so every "digital literacy"
game is screen-FREE: role-play scenarios, discussion games, and hand-drawn
scenario cards — never actual device use.

Modeled directly on gen_68_outdoor_games_content.py (same esc()/build_prompt()/
emit_sql()/check_completeness() shapes); see that file for the reasoning
behind the " | " materials separator and the newline="" file-write guard.

Run with: python gen_74_life_skills_games_content.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), tip
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "💰 Penny Sorting Circle",
        "objective": "Practice sorting pretend coins by size while taking turns.",
        "materials": ["Pretend coins or buttons in 2-3 sizes", "A bowl or basket"],
        "steps": [
            "Dump the pretend coins in the middle.",
            "Take turns picking one up.",
            "Say if it's big or small and put it in the matching pile.",
            "Keep going until every coin is sorted.",
        ],
        "tip": "Sorting money by size is the very first step toward counting it later!",
    },
    {
        "name": "🧺 Toy Basket Race",
        "objective": "Practice putting toys away in the right basket to build simple organizing habits.",
        "materials": ["2 baskets or bins", "A small pile of toys, blocks, or stuffed animals"],
        "steps": [
            "Label one basket 'soft toys' and one 'hard toys' (a grown-up can help).",
            "Set a timer for one minute.",
            "Race to put every toy in the correct basket before time is up.",
            "Count together how many you got right!",
        ],
        "tip": "A place for everything makes clean-up time so much faster.",
    },
    {
        "name": "🚦 Ask a Grown-Up Game",
        "objective": "Practice knowing which everyday choices need a grown-up's okay first.",
        "materials": ["None — just talk it through together"],
        "steps": [
            "A grown-up names a simple situation, like 'a video I've never seen pops up.'",
            "The child decides: 'ask a grown-up' or 'it's fine by myself.'",
            "Talk together about why.",
            "Try a few more examples.",
        ],
        "tip": "Learning to pause and ask is a safe habit worth starting small, today.",
    },
    {
        "name": "⏰ Morning Picture Parade",
        "objective": "Practice putting a morning routine in the right order using picture cards.",
        "materials": ["4-5 hand-drawn picture cards showing wake up, brush teeth, get dressed, eat breakfast"],
        "steps": [
            "Draw or find simple pictures for each morning step.",
            "Mix up the cards.",
            "Work together to line them up in the order they really happen.",
            "Act out the routine as you go!",
        ],
        "tip": "Seeing the steps in order helps mornings feel calm instead of rushed.",
    },
    {
        "name": "🪙 Piggy Bank Drop",
        "objective": "Practice counting pretend coins one at a time into a bank.",
        "materials": ["Pretend coins or buttons", "A jar or piggy bank"],
        "steps": [
            "Give the child a small pile of pretend coins.",
            "Drop them in one at a time, counting out loud together.",
            "See how many you counted when the pile is empty.",
            "Try again and see if the count matches!",
        ],
        "tip": "Counting slowly and out loud is how real counting skills grow.",
    },
    {
        "name": "🎒 Backpack Bin Match",
        "objective": "Practice matching everyday items to where they belong.",
        "materials": ["A backpack or bag", "A few household items like a cup, a book, a shoe"],
        "steps": [
            "Spread the items out on the floor.",
            "Show a 'home' spot for each one (shelf, bag, basket).",
            "Take turns carrying an item to its home.",
            "Cheer when every item finds its spot!",
        ],
        "tip": "Naming a 'home' for each item makes putting things away simple.",
    },
    {
        "name": "🕐 Beat the Timer Cleanup",
        "objective": "Practice tidying quickly and happily before a timer runs out.",
        "materials": ["A timer or clock", "A few toys to tidy"],
        "steps": [
            "Set a timer for 2 minutes.",
            "Pick up as many toys as you can before it beeps.",
            "Cheer together when the timer goes off.",
            "Reset and try to beat your own time!",
        ],
        "tip": "Turning cleanup into a game makes it something to look forward to.",
    },
    {
        "name": "🛍️ Pretend Store Visit",
        "objective": "Practice a simple 'buy' and 'pay' routine with pretend money.",
        "materials": ["Pretend coins or paper money", "2-3 toy items to 'sell'"],
        "steps": [
            "A grown-up sets out a few toys with a coin next to each.",
            "The child picks an item and hands over the matching coin.",
            "The grown-up says 'thank you!' and hands over the toy.",
            "Take turns being the shopper and the shopkeeper.",
        ],
        "tip": "Trading coins for items is a gentle first taste of how buying works.",
    },
    {
        "name": "🧦 Sock Match Sprint",
        "objective": "Practice matching pairs quickly, an early sorting and organizing skill.",
        "materials": ["Several pairs of socks"],
        "steps": [
            "Mix up a pile of socks.",
            "Take turns pulling out two socks.",
            "Check if they match — if yes, set the pair aside.",
            "Keep going until every sock has its partner!",
        ],
        "tip": "Matching pairs is a fun warm-up for real laundry-folding later.",
    },
    {
        "name": "🗓️ What Comes Next?",
        "objective": "Practice predicting the next step in a simple daily routine.",
        "materials": ["None — just talk it through together"],
        "steps": [
            "A grown-up starts a routine out loud, like 'First we wake up, then we...'",
            "The child guesses what comes next.",
            "Keep building the routine one step at a time.",
            "Try a bedtime routine too!",
        ],
        "tip": "Predicting 'what's next' helps little ones feel ready for the day.",
    },
    {
        "name": "🙋 Safe or Wait Game",
        "objective": "Practice telling the difference between things okay to do alone and things that need a helper.",
        "materials": ["None — just talk it through together"],
        "steps": [
            "A grown-up names a simple action, like 'pouring my own water.'",
            "The child gives thumbs up for 'I can do it' or thumbs sideways for 'ask first.'",
            "Talk about the answer together.",
            "Try five more examples.",
        ],
        "tip": "Small decisions like these build the confidence to make bigger safe choices later.",
    },
    {
        "name": "📦 Big Box, Little Box",
        "objective": "Practice sorting toys by size into two containers.",
        "materials": ["2 boxes or bins (one bigger, one smaller)", "A mix of toys"],
        "steps": [
            "Set out the two boxes side by side.",
            "Pick up a toy and decide if it's big or little.",
            "Place it in the matching box.",
            "Keep sorting until every toy has a home!",
        ],
        "tip": "Sorting by size is an early building block for organizing anything.",
    },
    {
        "name": "🍎 Snack Time Sharing",
        "objective": "Practice fair sharing and simple counting with a pretend snack.",
        "materials": ["Play food pieces or crackers", "2-3 plates"],
        "steps": [
            "Count out a small pile of pretend snack pieces.",
            "Share them evenly between the plates, one at a time.",
            "Count how many ended up on each plate.",
            "Talk about whether the sharing was fair.",
        ],
        "tip": "Fair sharing is one of the very first 'money sense' lessons kids learn.",
    },
    {
        "name": "🧸 Toy Library Checkout",
        "objective": "Practice a simple borrow-and-return routine, an early responsibility habit.",
        "materials": ["A few toys", "A small shelf or basket as the 'library'"],
        "steps": [
            "Line up the toys on the 'library' shelf.",
            "Take turns 'checking out' one toy to play with.",
            "When done playing, return it to its exact spot.",
            "Check that every toy made it back home!",
        ],
        "tip": "Returning things to their place is a habit that helps for life.",
    },
]


GAMES[1] = [
    {
        "name": "💰 Coin Value Count",
        "objective": "Practice counting pretend pennies and nickels to reach a small total.",
        "materials": ["Pretend pennies and nickels (or paper cutouts)", "A small cup"],
        "steps": [
            "Show the child a penny (worth 1) and a nickel (worth 5).",
            "Ask them to collect coins until they reach a target number, like 10.",
            "Count out loud together as coins go in the cup.",
            "Check the total together when done.",
        ],
        "tip": "Small counting goals like this build real number sense for money later.",
    },
    {
        "name": "🛒 Three Item Shop",
        "objective": "Practice choosing items within a small pretend budget.",
        "materials": ["Pretend coins", "3 toy items each with a price tag (1-5)"],
        "steps": [
            "Give the shopper 5 pretend coins to spend.",
            "Look at the price tags on each item.",
            "Decide which item(s) to buy without going over 5 coins.",
            "Pay and trade roles with a partner.",
        ],
        "tip": "Choosing what fits your coins is the very start of budgeting.",
    },
    {
        "name": "🗂️ Sort By Type Relay",
        "objective": "Practice organizing household items into matching categories quickly.",
        "materials": ["A mixed pile of toys, clothes, and books", "3 labeled bins"],
        "steps": [
            "Label three bins: toys, clothes, books.",
            "Set a timer for 90 seconds.",
            "Race to sort the mixed pile into the right bins.",
            "Check together and re-sort any mistakes.",
        ],
        "tip": "Categories make it much faster to find things later — and to clean up too!",
    },
    {
        "name": "🕵️ Real or Pretend Online Pop-Up",
        "objective": "Practice spotting the difference between a trusted grown-up message and a surprise pop-up, using drawn cards.",
        "materials": ["3-4 hand-drawn cards showing simple scenes (a video, a game, a pop-up ad)"],
        "steps": [
            "Lay out the drawn cards face up.",
            "Talk about which ones a grown-up should see first.",
            "Sort the cards into 'show a grown-up' and 'just for fun.'",
            "Discuss why some things need a grown-up's eyes first.",
        ],
        "tip": "Pausing before clicking anything new is a habit worth starting early.",
    },
    {
        "name": "🗓️ Build My Day Cards",
        "objective": "Practice arranging picture cards into a simple daily schedule.",
        "materials": ["5-6 picture cards for daily activities (breakfast, school, play, dinner, bed)"],
        "steps": [
            "Spread the picture cards out, mixed up.",
            "Put them in order from morning to night.",
            "Talk through the day using the cards.",
            "Try swapping two cards and see if the day still makes sense!",
        ],
        "tip": "Seeing a whole day laid out helps make even busy days feel manageable.",
    },
    {
        "name": "⏳ Race the Sand Timer",
        "objective": "Practice estimating how long simple tasks take.",
        "materials": ["A sand timer or 1-minute phone timer", "Blocks to stack"],
        "steps": [
            "Guess how many blocks you can stack before time runs out.",
            "Start the timer and stack as fast (and carefully) as you can.",
            "Count your blocks when time is up.",
            "Compare your guess to your real result!",
        ],
        "tip": "Guessing and checking time is how kids learn what 'one minute' really feels like.",
    },
    {
        "name": "🧦 Laundry Color Sort",
        "objective": "Practice sorting clothes by color, an early organizing skill.",
        "materials": ["A pile of clean clothes (or clothing pictures)", "2 baskets"],
        "steps": [
            "Label one basket 'light colors' and one 'dark colors.'",
            "Take turns picking up a clothing item.",
            "Decide which basket it belongs in.",
            "Sort the whole pile together!",
        ],
        "tip": "Color-sorting laundry is a real chore your grown-ups will thank you for.",
    },
    {
        "name": "🪙 Save or Spend Jar",
        "objective": "Practice deciding whether to save a coin or spend it on a small treat.",
        "materials": ["Pretend coins", "2 jars labeled 'save' and 'spend'"],
        "steps": [
            "Give the child several pretend coins one at a time.",
            "For each coin, decide: save it or spend it on a pretend treat.",
            "Drop the coin in the matching jar.",
            "Count how many ended up in each jar at the end.",
        ],
        "tip": "There's no wrong answer — just practice noticing you always have a choice.",
    },
    {
        "name": "🧹 Chore Chart Sticker Hunt",
        "objective": "Practice completing a simple set of chores and tracking them.",
        "materials": ["A paper chore chart with 3-4 simple pictures", "Stickers"],
        "steps": [
            "Look at the chore chart together (make bed, feed pet, tidy shoes).",
            "Complete one chore at a time.",
            "Add a sticker next to each finished chore.",
            "Celebrate when the whole chart is full of stickers!",
        ],
        "tip": "Checking off finished tasks feels great — that's why grown-ups do it too!",
    },
    {
        "name": "🚦 Stranger at the Door Practice",
        "objective": "Practice the safe response when someone unexpected knocks or calls.",
        "materials": ["None — just talk it through together"],
        "steps": [
            "A grown-up pretends to be a delivery person or unknown caller.",
            "The child practices saying 'I need to get a grown-up' instead of answering alone.",
            "Switch roles and try it again.",
            "Talk about who the safe grown-ups to get are.",
        ],
        "tip": "Practicing the words ahead of time makes them easy to remember for real.",
    },
    {
        "name": "📚 Bookshelf Order-Up",
        "objective": "Practice organizing books by a simple rule like size or color.",
        "materials": ["5-8 books"],
        "steps": [
            "Pick a rule together: biggest to smallest, or by color.",
            "Line the books up on a shelf or the floor following the rule.",
            "Check the order together.",
            "Try a new rule and reorganize!",
        ],
        "tip": "Organizing by a rule is a skill that works for books, toys, and someday desks.",
    },
    {
        "name": "⏰ Bedtime Countdown",
        "objective": "Practice following a short step-by-step countdown to bedtime.",
        "materials": ["None — just talk it through together", "A clock if available"],
        "steps": [
            "Name the 3 steps left before bed: pajamas, teeth, story.",
            "Do each step one at a time, checking it off out loud.",
            "Notice how much closer to bedtime you get after each step.",
            "Celebrate finishing all 3!",
        ],
        "tip": "Breaking bedtime into small steps makes the routine feel easy, not rushed.",
    },
    {
        "name": "🛍️ Grocery Picture List",
        "objective": "Practice following a simple picture list while 'shopping' at home.",
        "materials": ["A picture list of 4-5 pretend grocery items", "Play food or household stand-ins"],
        "steps": [
            "Look at the picture list together.",
            "Find or point to each item around the room.",
            "Check it off the list as you find it.",
            "See if you found everything on the list!",
        ],
        "tip": "Following a list is a real skill you'll use at the grocery store for years.",
    },
    {
        "name": "🤝 Take Turns Trade",
        "objective": "Practice fair trading and turn-taking with toys.",
        "materials": ["A few small toys or trinkets"],
        "steps": [
            "Each player picks one toy to start with.",
            "Take turns offering a trade to a partner.",
            "Both players must agree before trading.",
            "Play a few rounds and talk about what made a trade feel fair.",
        ],
        "tip": "Fair trades are an early lesson in value that money math builds on later.",
    },
]


GAMES[2] = [
    {
        "name": "💰 Coin Combo Challenge",
        "objective": "Practice combining different coin values to reach a target amount.",
        "materials": ["Pretend pennies, nickels, dimes (or paper cutouts)", "A small tray"],
        "steps": [
            "Pick a target number, like 15 cents.",
            "Find different coin combinations that add up to the target.",
            "Try to find more than one way to make it.",
            "Check your combos with a partner.",
        ],
        "tip": "There's often more than one right way to make the same amount — just like in real life.",
    },
    {
        "name": "🛒 Set a Budget Shop",
        "objective": "Practice staying within a set spending limit while choosing items.",
        "materials": ["Pretend coins totaling 20", "5 toy items with price tags 3-10"],
        "steps": [
            "Give the shopper exactly 20 pretend coins.",
            "Browse the price tags and pick which items to buy.",
            "Add up the prices before paying to make sure you're under 20.",
            "Pay and see how many coins you have left over.",
        ],
        "tip": "Checking the total before you pay is a habit that saves real money later.",
    },
    {
        "name": "🗂️ Desk Organizer Dash",
        "objective": "Practice sorting school supplies into labeled groups quickly.",
        "materials": ["A mixed pile of pencils, crayons, erasers, and paper clips", "3-4 small containers"],
        "steps": [
            "Label each container (pencils, crayons, small stuff).",
            "Set a 2-minute timer.",
            "Race to sort the whole pile into the right containers.",
            "Check your work and fix any mix-ups.",
        ],
        "tip": "A tidy desk means less time hunting and more time for the fun stuff.",
    },
    {
        "name": "🕵️ Pop-Up Trap Spotter",
        "objective": "Practice recognizing tricky online pop-ups and ads through drawn scenario cards, without using an actual device.",
        "materials": ["4-5 drawn cards showing pretend pop-up scenes with flashy prizes or 'click now' messages"],
        "steps": [
            "Lay out the drawn pop-up cards.",
            "Talk about which details seem like a trick (too-good prizes, urgent countdowns).",
            "Sort the cards into 'ignore/close' and 'tell a grown-up.'",
            "Discuss what makes something feel trustworthy versus tricky.",
        ],
        "tip": "If something online feels too exciting or too urgent, that's often a clue to slow down.",
    },
    {
        "name": "🗓️ To-Do List Planner",
        "objective": "Practice writing and checking off a short to-do list in a logical order.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Write down 4-5 things you need to do today.",
            "Number them in the order that makes the most sense.",
            "Cross off each task as you finish it.",
            "Look back at your list at the end of the day.",
        ],
        "tip": "A written list means your brain doesn't have to remember everything at once.",
    },
    {
        "name": "⏳ Time Estimate Showdown",
        "objective": "Practice estimating how long several tasks take and comparing to the real time.",
        "materials": ["A timer or clock", "3 simple tasks (build a small tower, draw a picture, tidy a shelf)"],
        "steps": [
            "Guess how long each of the 3 tasks will take.",
            "Time yourself doing each one.",
            "Compare your guesses to the real times.",
            "See which task you guessed most accurately!",
        ],
        "tip": "Getting better at estimating time helps you plan your whole day more realistically.",
    },
    {
        "name": "🧦 Drawer Organization Race",
        "objective": "Practice organizing a drawer or shelf by category against the clock.",
        "materials": ["A messy drawer or box of mixed items", "Small dividers or containers"],
        "steps": [
            "Dump the drawer's contents out and group into categories.",
            "Set a timer for a few minutes.",
            "Put each category back into the drawer in its own section.",
            "Check that everything has a clear spot.",
        ],
        "tip": "A little organizing now saves a lot of searching time later.",
    },
    {
        "name": "🪙 Saving Goal Tracker",
        "objective": "Practice tracking progress toward a small savings goal over several pretend weeks.",
        "materials": ["Pretend coins", "Paper for a simple savings chart"],
        "steps": [
            "Pick a fun small goal, like 30 coins for a pretend toy.",
            "Each 'week,' add a few coins and mark the chart.",
            "Watch the chart fill up toward the goal.",
            "Celebrate when you reach it!",
        ],
        "tip": "Watching your savings grow bit by bit makes reaching a goal feel exciting, not slow.",
    },
    {
        "name": "🧹 Family Chore Auction",
        "objective": "Practice choosing and committing to chores fairly among a group.",
        "materials": ["Paper strips listing 5-6 simple chores", "Pretend coins as 'bids' (optional)"],
        "steps": [
            "Lay out the chore strips where everyone can see them.",
            "Take turns picking (or 'bidding' pretend coins for) the chore you want.",
            "Make sure every chore gets picked by someone.",
            "Complete your chosen chore and check it off together.",
        ],
        "tip": "Choosing your own chore makes it feel less like a chore and more like a choice.",
    },
    {
        "name": "🚦 Stranger Message Sort",
        "objective": "Practice sorting pretend messages into 'from someone I know' and 'from someone unknown,' a core online-safety skill.",
        "materials": ["6-8 index cards each describing a short pretend message scenario"],
        "steps": [
            "Write or draw 6-8 short message scenarios on cards.",
            "Read each one and decide: known sender or unknown sender.",
            "Sort into two piles.",
            "Talk about what to do with unknown-sender messages (tell a grown-up, don't reply).",
        ],
        "tip": "Not answering messages from people you don't know is always a safe first move.",
    },
    {
        "name": "📚 Category Bookshelf Challenge",
        "objective": "Practice sorting a mixed shelf into logical categories of your own choosing.",
        "materials": ["8-10 books or labeled item cards"],
        "steps": [
            "Look at all the items and think of 2-3 categories that fit them.",
            "Sort every item into a category.",
            "Explain your categories to a partner.",
            "Try re-sorting using different categories!",
        ],
        "tip": "There's often more than one 'right' way to organize — the goal is that YOU can find things fast.",
    },
    {
        "name": "⏰ Weekend Schedule Draft",
        "objective": "Practice planning a balanced weekend with both chores and fun activities.",
        "materials": ["Paper and pencil, or a simple 2-day calendar grid"],
        "steps": [
            "Draw two columns: Saturday and Sunday.",
            "Write in must-do items first (chores, homework).",
            "Fill in fun activities around them.",
            "Check that your weekend has a good balance of both.",
        ],
        "tip": "Planning fun and responsibilities together helps neither one get forgotten.",
    },
    {
        "name": "🛍️ Unit Price Comparison",
        "objective": "Practice comparing which of two similar items gives more for the money.",
        "materials": ["2-3 pairs of pretend items with different sizes and prices written on cards"],
        "steps": [
            "Look at two similar items — same thing, different size and price.",
            "Figure out which one seems like the better value.",
            "Explain your reasoning out loud.",
            "Try a few more pairs to practice.",
        ],
        "tip": "A bigger price doesn't always mean a worse deal — comparing carefully matters.",
    },
    {
        "name": "🤝 Chore Swap Negotiation",
        "objective": "Practice respectfully negotiating a trade of responsibilities with another person.",
        "materials": ["Paper strips listing a few chores for two players"],
        "steps": [
            "Each player lists 2-3 chores they're responsible for.",
            "Talk about whether either player would like to swap a chore.",
            "Agree together on a fair swap (or agree not to swap).",
            "Complete your (possibly new) chore list.",
        ],
        "tip": "Good negotiating means both people feel like the deal was fair.",
    },
]


GAMES[3] = [
    {
        "name": "💰 Allowance Add-Up",
        "objective": "Practice adding coins and small bills to total a weekly allowance.",
        "materials": ["Pretend coins and small bills", "Paper and pencil"],
        "steps": [
            "Give the child a mixed pile of pretend money.",
            "Add it all up and write the total.",
            "Check the math together.",
            "Try a different mixed pile and total it again.",
        ],
        "tip": "Adding up your own money is the first step toward tracking it.",
    },
    {
        "name": "🛒 Shopping List Budget",
        "objective": "Practice planning purchases from a list while staying under a spending limit.",
        "materials": ["A written price list of 6-8 items", "Pretend money totaling a set budget"],
        "steps": [
            "Look at the price list and decide what you want to buy.",
            "Add up your choices as you go.",
            "Stop adding items once you're close to your budget.",
            "Check that your total doesn't go over the limit.",
        ],
        "tip": "Planning your purchases before you shop helps your money go further.",
    },
    {
        "name": "🗂️ Backpack Overhaul",
        "objective": "Practice organizing a backpack or desk by category under a time limit.",
        "materials": ["A messy backpack or desk full of papers and supplies", "A few folders or bins"],
        "steps": [
            "Dump everything out and sort into categories (papers, supplies, books).",
            "Set a timer for 3 minutes.",
            "Put each category back in an organized spot.",
            "Check if everything has a clear place.",
        ],
        "tip": "An organized backpack means less searching and more time for what matters.",
    },
    {
        "name": "🕵️ Pop-Up Trap Spotter",
        "objective": "Practice recognizing tricky online pop-ups and ads through drawn scenario cards, without using an actual device.",
        "materials": ["4-5 drawn cards showing pretend pop-up scenes with flashy prizes or 'click now' messages"],
        "steps": [
            "Lay out the drawn pop-up cards.",
            "Talk about which details seem like a trick (too-good prizes, urgent countdowns).",
            "Sort the cards into 'ignore/close' and 'tell a grown-up.'",
            "Discuss what makes something feel trustworthy versus tricky.",
        ],
        "tip": "If something online feels too exciting or too urgent, that's often a clue to slow down.",
    },
    {
        "name": "🗓️ To-Do List Planner",
        "objective": "Practice writing and checking off a short to-do list in a logical order.",
        "materials": ["Paper and pencil"],
        "steps": [
            "Write down 4-5 things you need to do today.",
            "Number them in the order that makes the most sense.",
            "Cross off each task as you finish it.",
            "Look back at your list at the end of the day.",
        ],
        "tip": "A written list means your brain doesn't have to remember everything at once.",
    },
    {
        "name": "⏳ Time Estimate Showdown",
        "objective": "Practice estimating how long several tasks take and comparing to the real time.",
        "materials": ["A timer or clock", "3 simple tasks (build a small tower, draw a picture, tidy a shelf)"],
        "steps": [
            "Guess how long each of the 3 tasks will take.",
            "Time yourself doing each one.",
            "Compare your guesses to the real times.",
            "See which task you guessed most accurately!",
        ],
        "tip": "Getting better at estimating time helps you plan your whole day more realistically.",
    },
    {
        "name": "🧦 Drawer Organization Race",
        "objective": "Practice organizing a drawer or shelf by category against the clock.",
        "materials": ["A messy drawer or box of mixed items", "Small dividers or containers"],
        "steps": [
            "Dump the drawer's contents out and group into categories.",
            "Set a timer for a few minutes.",
            "Put each category back into the drawer in its own section.",
            "Check that everything has a clear spot.",
        ],
        "tip": "A little organizing now saves a lot of searching time later.",
    },
    {
        "name": "🪙 Saving Goal Tracker",
        "objective": "Practice tracking progress toward a small savings goal over several pretend weeks.",
        "materials": ["Pretend coins", "Paper for a simple savings chart"],
        "steps": [
            "Pick a fun small goal, like 30 coins for a pretend toy.",
            "Each 'week,' add a few coins and mark the chart.",
            "Watch the chart fill up toward the goal.",
            "Celebrate when you reach it!",
        ],
        "tip": "Watching your savings grow bit by bit makes reaching a goal feel exciting, not slow.",
    },
    {
        "name": "🧹 Family Chore Auction",
        "objective": "Practice choosing and committing to chores fairly among a group.",
        "materials": ["Paper strips listing 5-6 simple chores", "Pretend coins as 'bids' (optional)"],
        "steps": [
            "Lay out the chore strips where everyone can see them.",
            "Take turns picking (or 'bidding' pretend coins for) the chore you want.",
            "Make sure every chore gets picked by someone.",
            "Complete your chosen chore and check it off together.",
        ],
        "tip": "Choosing your own chore makes it feel less like a chore and more like a choice.",
    },
    {
        "name": "🚦 Stranger Message Sort",
        "objective": "Practice sorting pretend messages into 'from someone I know' and 'from someone unknown,' a core online-safety skill.",
        "materials": ["6-8 index cards each describing a short pretend message scenario"],
        "steps": [
            "Write or draw 6-8 short message scenarios on cards.",
            "Read each one and decide: known sender or unknown sender.",
            "Sort into two piles.",
            "Talk about what to do with unknown-sender messages (tell a grown-up, don't reply).",
        ],
        "tip": "Not answering messages from people you don't know is always a safe first move.",
    },
    {
        "name": "📚 Category Bookshelf Challenge",
        "objective": "Practice sorting a mixed shelf into logical categories of your own choosing.",
        "materials": ["8-10 books or labeled item cards"],
        "steps": [
            "Look at all the items and think of 2-3 categories that fit them.",
            "Sort every item into a category.",
            "Explain your categories to a partner.",
            "Try re-sorting using different categories!",
        ],
        "tip": "There's often more than one 'right' way to organize — the goal is that YOU can find things fast.",
    },
    {
        "name": "⏰ Weekend Schedule Draft",
        "objective": "Practice planning a balanced weekend with both chores and fun activities.",
        "materials": ["Paper and pencil, or a simple 2-day calendar grid"],
        "steps": [
            "Draw two columns: Saturday and Sunday.",
            "Write in must-do items first (chores, homework).",
            "Fill in fun activities around them.",
            "Check that your weekend has a good balance of both.",
        ],
        "tip": "Planning fun and responsibilities together helps neither one get forgotten.",
    },
    {
        "name": "🛍️ Unit Price Comparison",
        "objective": "Practice comparing which of two similar items gives more for the money.",
        "materials": ["2-3 pairs of pretend items with different sizes and prices written on cards"],
        "steps": [
            "Look at two similar items — same thing, different size and price.",
            "Figure out which one seems like the better value.",
            "Explain your reasoning out loud.",
            "Try a few more pairs to practice.",
        ],
        "tip": "A bigger price doesn't always mean a worse deal — comparing carefully matters.",
    },
    {
        "name": "🤝 Chore Swap Negotiation",
        "objective": "Practice respectfully negotiating a trade of responsibilities with another person.",
        "materials": ["Paper strips listing a few chores for two players"],
        "steps": [
            "Each player lists 2-3 chores they're responsible for.",
            "Talk about whether either player would like to swap a chore.",
            "Agree together on a fair swap (or agree not to swap).",
            "Complete your (possibly new) chore list.",
        ],
        "tip": "Good negotiating means both people feel like the deal was fair.",
    },
]


GAMES[4] = [
    {
        "name": "💰 Budget the Ten Dollars",
        "objective": "Practice dividing a small budget across needs, wants, and savings.",
        "materials": ["Pretend $10 in bills", "Paper divided into 'needs,' 'wants,' 'savings'"],
        "steps": [
            "Look at your $10 and the three categories.",
            "Decide how much to put toward each category.",
            "Write your amounts down and make sure they add up to $10.",
            "Explain why you split it that way.",
        ],
        "tip": "Deciding how to split money before you spend it is real budgeting in action.",
    },
    {
        "name": "🛒 Grocery Budget Challenge",
        "objective": "Practice planning a grocery list that stays within a set budget while covering different needs.",
        "materials": ["A price list of 10-12 pretend grocery items", "A set budget amount"],
        "steps": [
            "Look at the price list and think about what a family might need.",
            "Pick items that add up to your budget or less.",
            "Make sure your list covers a few different food groups.",
            "Compare your list with a partner's — did you both stay in budget?",
        ],
        "tip": "Real grocery budgeting means balancing what you want with what you actually need.",
    },
    {
        "name": "🗂️ Junk Drawer Sprint",
        "objective": "Practice organizing a chaotic mixed drawer into clear categories under time pressure.",
        "materials": ["A pile of mixed small household items", "4-5 small containers"],
        "steps": [
            "Dump the mixed pile out and look it over.",
            "Decide on 4-5 categories that make sense.",
            "Set a 3-minute timer and sort everything into its category.",
            "Check your work — does everything have an obvious home?",
        ],
        "tip": "Even the messiest drawer becomes manageable once you group things by type.",
    },
    {
        "name": "🕵️ Personal Info Detective",
        "objective": "Practice identifying which details are safe to share online and which are private, through scenario cards.",
        "materials": ["6-8 scenario cards listing different pieces of information (favorite color, home address, pet's name, school name)"],
        "steps": [
            "Read each scenario card out loud.",
            "Decide: safe to share publicly, or private/ask a grown-up first.",
            "Sort into two piles.",
            "Discuss why some details (address, school, full name) are more sensitive than others.",
        ],
        "tip": "A good rule of thumb: if it could help a stranger find you in real life, keep it private.",
    },
    {
        "name": "🗓️ Weekend Time-Block Planner",
        "objective": "Practice planning a weekend using time blocks instead of just a list.",
        "materials": ["Paper with a simple hourly grid for Saturday", "Pencil"],
        "steps": [
            "Draw a grid with rough time blocks (morning, midday, afternoon, evening).",
            "Fill in an activity or chore for each block.",
            "Leave at least one block open for free time.",
            "Review your plan — does it feel realistic?",
        ],
        "tip": "Blocking out time (not just listing tasks) is how many grown-ups plan their busiest days.",
    },
    {
        "name": "⏳ Password Strength Sort",
        "objective": "Practice recognizing what makes a password strong versus easy to guess, through card sorting (no device needed).",
        "materials": ["8-10 cards each with a made-up example password written on it"],
        "steps": [
            "Write several example passwords on cards, some weak (like '1234') and some stronger.",
            "Sort the cards from weakest to strongest.",
            "Talk about what makes the stronger ones harder to guess.",
            "Try writing a new strong example together.",
        ],
        "tip": "A strong password mixes letters, numbers, and symbols — and is never something easy to guess.",
    },
    {
        "name": "🧦 Closet Category Challenge",
        "objective": "Practice organizing clothing by multiple categories (type and season) under time pressure.",
        "materials": ["A mixed pile of clothing (or clothing picture cards)", "Labeled sections or bins"],
        "steps": [
            "Decide on 2 sorting rules together, like type and season.",
            "Set a timer and sort the pile using both rules.",
            "Check that everything landed in a sensible spot.",
            "Talk about which rule was trickier to apply.",
        ],
        "tip": "Sorting by more than one rule at once is a great brain workout — and a real organizing skill.",
    },
    {
        "name": "🪙 Save For a Goal Simulation",
        "objective": "Practice planning several weeks of saving toward a specific price goal.",
        "materials": ["Pretend money", "Paper for a multi-week savings tracker"],
        "steps": [
            "Pick a goal item and its price (like a $25 toy).",
            "Decide a realistic amount to save each pretend week.",
            "Fill in the tracker week by week until you reach the goal.",
            "Talk about what you'd do if you got extra money one week — save more or the same?",
        ],
        "tip": "Big goals become easy to reach once you break them into small weekly steps.",
    },
    {
        "name": "🧹 Chore Rotation Wheel",
        "objective": "Practice planning a fair rotating chore schedule for a group.",
        "materials": ["Paper and pencil, or a simple hand-drawn spinner"],
        "steps": [
            "List everyone in your household or group.",
            "List the chores that need doing each week.",
            "Assign chores so each person gets a fair, rotating turn.",
            "Write out next week's rotation so everyone knows what's coming.",
        ],
        "tip": "A rotation means nobody gets stuck with the same chore forever.",
    },
    {
        "name": "🚦 Online Kindness or Not",
        "objective": "Practice recognizing kind versus unkind online comments through scenario cards, and choosing a safe, kind response.",
        "materials": ["6-8 cards with short example comments written on them"],
        "steps": [
            "Write a mix of kind and unkind example comments on cards.",
            "Read each one and decide: kind, unkind, or unsure.",
            "For unkind ones, talk about a safe response (don't reply, tell a grown-up).",
            "Discuss why kindness matters just as much online as in person.",
        ],
        "tip": "The same kindness rules from real life apply online too — always.",
    },
    {
        "name": "📚 File Folder System",
        "objective": "Practice creating a simple filing system for papers by subject or type.",
        "materials": ["A stack of mixed papers (or paper stand-ins)", "3-4 folders"],
        "steps": [
            "Label each folder with a category (school, art, important, other).",
            "Sort the stack of papers into the correct folders.",
            "Stack the folders neatly in order of importance.",
            "Explain your system to someone else.",
        ],
        "tip": "A simple filing system means important papers are never lost in a pile again.",
    },
    {
        "name": "⏰ Homework Time Estimate",
        "objective": "Practice estimating and tracking time spent on different types of homework tasks.",
        "materials": ["A timer or clock", "Paper for tracking", "Actual or pretend homework tasks"],
        "steps": [
            "List 2-3 homework-style tasks and guess how long each will take.",
            "Time yourself completing each one.",
            "Compare your guesses to the real times.",
            "Talk about which subject tends to take longer than expected.",
        ],
        "tip": "Knowing which tasks take longer helps you plan your homework time better.",
    },
    {
        "name": "🛍️ Comparison Shopping Trip",
        "objective": "Practice comparing prices and features across similar products to find the smartest buy.",
        "materials": ["3-4 pretend product cards with different prices and features"],
        "steps": [
            "Look over 3-4 similar pretend products with different prices.",
            "List one pro and one con for each option.",
            "Decide which one is the smartest buy and explain why.",
            "Try a new set of products and compare again.",
        ],
        "tip": "The cheapest option isn't always the smartest — think about what you're really getting.",
    },
    {
        "name": "🗺️ Plan the Class Trip Budget",
        "objective": "Practice budgeting for a group activity with several cost categories.",
        "materials": ["Paper and pencil", "A pretend total budget", "A list of cost categories (transport, food, activity)"],
        "steps": [
            "Look at your total pretend budget and the cost categories.",
            "Decide how much to spend in each category.",
            "Add everything up and check it matches your total budget.",
            "Adjust one category if you go over!",
        ],
        "tip": "Planning a group budget means balancing everyone's needs against a fixed amount.",
    },
]


GAMES[5] = [
    {
        "name": "💰 Needs vs Wants Sort",
        "objective": "Practice distinguishing needs from wants while planning a budget.",
        "materials": ["10-12 item cards (some needs like shoes, some wants like a video game)", "Paper"],
        "steps": [
            "Read each item card and decide: need or want.",
            "Sort the cards into two piles.",
            "Talk about items that felt tricky to decide.",
            "Rank the want-pile items by how much you'd want to save for them.",
        ],
        "tip": "Knowing the difference between needs and wants is the foundation of every good budget.",
    },
    {
        "name": "🛒 Savings Goal Trade-Off",
        "objective": "Practice choosing between saving for a big goal versus spending on smaller things now.",
        "materials": ["Pretend money", "Cards listing one big goal item and several small treat items"],
        "steps": [
            "Look at the big goal's price and the small treats' prices.",
            "Decide: buy small treats now, or skip them to save for the big goal faster?",
            "Simulate a few pretend weeks of choices.",
            "Reflect on how your choices affected your progress toward the goal.",
        ],
        "tip": "Every spending choice is really a choice about what you're saying no to.",
    },
    {
        "name": "🗂️ Study Space Setup Challenge",
        "objective": "Practice designing and organizing a study space system that would actually help you focus.",
        "materials": ["A table or desk area", "Various supplies to arrange", "Paper for a 'system' sketch"],
        "steps": [
            "Look at your available supplies and space.",
            "Decide where each type of item should live for easy access.",
            "Set it up and sketch a simple map of your system.",
            "Test it: can you find everything within 10 seconds?",
        ],
        "tip": "A study space that's organized before you sit down helps you actually get started faster.",
    },
    {
        "name": "🕵️ Cyberbullying Bystander Role-Play",
        "objective": "Practice deciding how to respond kindly and safely when witnessing unkind online behavior, through role-play.",
        "materials": ["None — just talk it through together, or simple scenario cards"],
        "steps": [
            "One person describes a scenario: someone is being teased in a group chat.",
            "Talk through the options: join in, ignore, or support the person being teased.",
            "Role-play saying something kind and supportive, or the choice to tell a grown-up.",
            "Discuss why being a supportive bystander matters.",
        ],
        "tip": "Standing up for someone online takes courage — and it makes a real difference.",
    },
    {
        "name": "🗓️ Multi-Day Project Planner",
        "objective": "Practice breaking a project into steps spread across several days before a deadline.",
        "materials": ["Paper and pencil", "A pretend project with a due date 5 days away"],
        "steps": [
            "Write down the project's final deadline.",
            "List all the smaller steps needed to finish it.",
            "Spread the steps across the days leading up to the deadline.",
            "Check your plan leaves room for the unexpected.",
        ],
        "tip": "Big projects feel much less overwhelming once they're broken into daily steps.",
    },
    {
        "name": "⏳ Priority Trade-Off Game",
        "objective": "Practice choosing which of several tasks to do first when time is limited.",
        "materials": ["Cards listing 5-6 tasks with different time lengths", "A fixed total time budget"],
        "steps": [
            "Look at your total available time and the list of tasks.",
            "Decide which tasks fit and in what order.",
            "Explain why you prioritized the way you did.",
            "Try a new time budget and see if your choices change.",
        ],
        "tip": "When time is short, deciding what matters most is a skill just like budgeting money.",
    },
    {
        "name": "🧦 Family Closet Reorganize",
        "objective": "Practice designing and executing an organization system for a shared space.",
        "materials": ["A mixed pile of clothing (or picture cards)", "Several bins or sections"],
        "steps": [
            "Discuss what organizing rule would work best for a shared space (by person, by type, by season).",
            "Sort the whole pile using your chosen rule.",
            "Label each section clearly.",
            "Explain your system so someone else could keep it up.",
        ],
        "tip": "A system that's easy to explain to someone else is usually a system that will actually last.",
    },
    {
        "name": "🪙 Comparison Savings Rate",
        "objective": "Practice comparing how choices about spending now change how fast a savings goal is reached.",
        "materials": ["Pretend money", "Paper for two savings trackers"],
        "steps": [
            "Pick a savings goal and its price.",
            "Try Plan A: save a small amount weekly and see how many weeks it takes.",
            "Try Plan B: save a bigger amount and compare how much faster it goes.",
            "Talk about the trade-off between spending now and saving faster.",
        ],
        "tip": "Saving a little more now can mean reaching your goal a lot sooner.",
    },
    {
        "name": "🧹 Chore Negotiation Meeting",
        "objective": "Practice a respectful family-meeting-style negotiation over chore responsibilities.",
        "materials": ["Paper listing current chores and who does them"],
        "steps": [
            "List all household chores and who currently does each one.",
            "Take turns sharing if any chore feels unfair or too much.",
            "Discuss and agree on any changes as a group.",
            "Write the new agreement down so everyone remembers it.",
        ],
        "tip": "Talking things through calmly usually gets a fairer result than just complaining.",
    },
    {
        "name": "🚦 Screen Time Balance Dilemma",
        "objective": "Practice weighing the trade-offs of screen time against other priorities through discussion scenarios.",
        "materials": ["None — just talk it through together, or a few written dilemma cards"],
        "steps": [
            "Read a dilemma out loud, like 'You have homework and a favorite show is on.'",
            "Talk through what each choice would mean for tomorrow.",
            "Decide together what a balanced choice looks like.",
            "Try a few more dilemmas with different priorities.",
        ],
        "tip": "Balance isn't about never having fun — it's about making sure everything important gets its turn.",
    },
    {
        "name": "📚 Digital Footprint Discussion",
        "objective": "Practice understanding that things posted online can last and be seen by others, through a screen-free discussion game.",
        "materials": ["None — just talk it through together, or index cards with example posts written out"],
        "steps": [
            "Read an example pretend post out loud (drawn on a card, not a real device).",
            "Discuss: who might see this now, and who might see it years from now?",
            "Decide if it's something you'd want out there long-term.",
            "Talk about the 'would I be okay with grandma seeing this?' test.",
        ],
        "tip": "Thinking ahead about who might see something later is a smart digital habit for life.",
    },
    {
        "name": "⏰ Weekly Time Audit",
        "objective": "Practice tracking how time is actually spent across a week and reflecting on the balance.",
        "materials": ["Paper with a simple 7-day grid", "Pencil"],
        "steps": [
            "Estimate how many hours go to school, homework, chores, fun, and sleep each day.",
            "Fill in your best guesses across the week.",
            "Add up each category's weekly total.",
            "Reflect: does the balance match what you'd want it to be?",
        ],
        "tip": "Seeing where your time actually goes is the first step to using it more the way you want.",
    },
    {
        "name": "🛍️ Sales and Discount Math",
        "objective": "Practice calculating a discounted price to compare real savings.",
        "materials": ["3-4 pretend price tags with a percent-off sale written on them", "Paper for math"],
        "steps": [
            "Look at an item's original price and its discount percentage.",
            "Calculate the sale price (estimates are fine).",
            "Compare a few different discounted items to find the best real savings.",
            "Check your math with a partner.",
        ],
        "tip": "A big discount percentage doesn't always mean the biggest real savings — the math matters.",
    },
    {
        "name": "🤝 Family Budget Meeting Role-Play",
        "objective": "Practice participating respectfully in a simple family discussion about spending priorities.",
        "materials": ["Paper listing a pretend family budget and a few spending requests"],
        "steps": [
            "Look at the pretend family's total budget together.",
            "Take turns presenting a spending request and why it matters.",
            "Discuss as a group which requests fit the budget this 'month.'",
            "Agree together on a final plan.",
        ],
        "tip": "Being part of a budget conversation helps you understand choices grown-ups make every day.",
    },
]


GAMES[6] = [
    {
        "name": "💰 Monthly Budget Simulation",
        "objective": "Practice allocating a pretend monthly income across several expense categories.",
        "materials": ["Pretend money representing a monthly income", "Paper divided into categories (housing, food, fun, savings)"],
        "steps": [
            "Start with a set pretend monthly income.",
            "Decide how much goes into each category, making sure it all adds up.",
            "Write your budget plan down.",
            "Reflect: which category was hardest to decide on, and why?",
        ],
        "tip": "Every real budget is a series of trade-offs — practicing them now makes the real thing easier later.",
    },
    {
        "name": "🛒 Unexpected Expense Curveball",
        "objective": "Practice adjusting a budget when an unplanned cost comes up.",
        "materials": ["A completed pretend monthly budget (or a new simple one)", "A card describing a surprise expense"],
        "steps": [
            "Start with your planned budget.",
            "Draw a surprise expense card (like 'bike tire needs replacing').",
            "Decide which category to pull money from to cover it.",
            "Reflect on how it felt to adjust your plan.",
        ],
        "tip": "Real budgets need flexibility — leaving a little room for surprises is smart planning.",
    },
    {
        "name": "🗂️ Filing System Overhaul",
        "objective": "Practice designing a multi-level organization system for a large mixed collection.",
        "materials": ["A large mixed pile of papers or items", "Several folders or bins", "Labels"],
        "steps": [
            "Sort the pile into a few broad categories first.",
            "Within each category, sort into smaller subcategories.",
            "Label everything clearly at both levels.",
            "Test your system by asking someone to find one specific item fast.",
        ],
        "tip": "Big organizing jobs go faster when you sort broad-to-narrow instead of all at once.",
    },
    {
        "name": "🕵️ Digital Citizenship Dilemma Cards",
        "objective": "Practice discussing and deciding responses to realistic digital citizenship dilemmas.",
        "materials": ["6-8 written dilemma cards (e.g., 'a friend shares a mean post about someone else')"],
        "steps": [
            "Draw a dilemma card and read it aloud.",
            "Discuss a few possible responses and their consequences.",
            "Choose the response that feels most responsible and kind.",
            "Talk about what you'd say to a friend who wasn't sure what to do.",
        ],
        "tip": "Thinking through dilemmas ahead of time makes it easier to choose well in the real moment.",
    },
    {
        "name": "🗓️ Deadline Juggling Simulation",
        "objective": "Practice planning around multiple deadlines that overlap in the same week.",
        "materials": ["Paper and pencil", "Cards listing 3-4 pretend assignments with different due dates"],
        "steps": [
            "Lay out all your pretend deadlines for the week.",
            "Estimate how much time each task will realistically take.",
            "Build a day-by-day plan that finishes everything on time.",
            "Reflect: what would you do differently if a new task got added?",
        ],
        "tip": "Planning backward from a deadline is one of the most useful time-management tricks there is.",
    },
    {
        "name": "⏳ Time vs Priority Reflection",
        "objective": "Practice reflecting on whether time spent actually matched personal priorities.",
        "materials": ["Paper and pencil", "A completed weekly time log, if available"],
        "steps": [
            "List your top 3 personal priorities right now (school, sports, family, etc.).",
            "Estimate how much time last week actually went to each one.",
            "Compare the numbers honestly.",
            "Reflect and discuss: what's one small change that would better match your time to your priorities?",
        ],
        "tip": "Noticing a gap between priorities and actual time is the first step to closing it.",
    },
    {
        "name": "🧦 Move-In Organization Challenge",
        "objective": "Practice organizing a large set of belongings into a new space efficiently.",
        "materials": ["A mixed pile of belongings (or picture cards)", "Several bins or shelves representing 'rooms'"],
        "steps": [
            "Sort belongings by which 'room' they'd go in.",
            "Within each room group, decide a logical placement order.",
            "Set everything up and check that similar items are grouped together.",
            "Reflect: what would you organize differently next time?",
        ],
        "tip": "Thinking through an organization plan before you start saves a lot of re-sorting later.",
    },
    {
        "name": "🪙 Compound Savings Story",
        "objective": "Practice understanding how consistent small savings add up significantly over pretend time.",
        "materials": ["Pretend money", "Paper for a multi-month savings tracker"],
        "steps": [
            "Pick a small consistent weekly savings amount.",
            "Track it growing week by week across several pretend months.",
            "Notice how the total grows faster the longer you keep going.",
            "Reflect: what's a real goal this kind of saving could help you reach?",
        ],
        "tip": "Small consistent savings really do add up — that's one of the most powerful ideas in personal finance.",
    },
    {
        "name": "🧹 Household Systems Design",
        "objective": "Practice designing a full chore and organization system for a household as a small project.",
        "materials": ["Paper and pencil", "A list of household members and typical chores"],
        "steps": [
            "List all regular household chores and how often each needs doing.",
            "Design a fair rotation or assignment system for the group.",
            "Write clear, simple instructions for each chore.",
            "Present your system and get feedback from the group.",
        ],
        "tip": "A well-designed system means chores get done without anyone having to nag.",
    },
    {
        "name": "🚦 Online Reputation Discussion",
        "objective": "Practice discussing how online behavior can shape how others see you over time.",
        "materials": ["None — just talk it through together, or written example-post cards"],
        "steps": [
            "Read a few example pretend posts or comments.",
            "Discuss what impression each one might give someone reading it later.",
            "Talk about the difference between a private feeling and a public post.",
            "Reflect: what's one habit that keeps an online reputation positive?",
        ],
        "tip": "What you put online becomes part of your story — it's worth choosing it thoughtfully.",
    },
    {
        "name": "📚 Categorize and Cross-Reference",
        "objective": "Practice organizing information so it can be found more than one way.",
        "materials": ["10-12 item or topic cards", "Paper for a simple index"],
        "steps": [
            "Sort the cards into main categories.",
            "Notice items that could fit more than one category.",
            "Create a simple index or key showing where each item is filed.",
            "Test it: can a partner find an item using your index?",
        ],
        "tip": "The best organization systems make sense to someone besides just you.",
    },
    {
        "name": "⏰ Extracurricular Balance Scenario",
        "objective": "Practice weighing time commitments across multiple activities and reflecting on balance.",
        "materials": ["Paper and pencil", "Cards listing 4-5 pretend activities with weekly time commitments"],
        "steps": [
            "Look at your pretend activities and their weekly time costs.",
            "Add up the total time and compare it to a realistic weekly limit.",
            "Decide which activities to keep, adjust, or set aside.",
            "Reflect: how did you decide what to prioritize?",
        ],
        "tip": "Saying no to one good thing sometimes makes room for another good thing to actually get your full attention.",
    },
    {
        "name": "🛍️ Subscription Trap Spotter",
        "objective": "Practice recognizing how small recurring costs add up over time, using pretend subscription cards.",
        "materials": ["4-5 cards listing pretend small monthly costs"],
        "steps": [
            "Look at each pretend monthly cost card.",
            "Calculate what each one adds up to over a full year.",
            "Add all the yearly totals together.",
            "Reflect: were you surprised by the total? What would you do with that money instead?",
        ],
        "tip": "Small recurring costs can quietly add up to a big number over a year — worth checking in on regularly.",
    },
    {
        "name": "🤝 Big Purchase Planning Meeting",
        "objective": "Practice planning and presenting a savings plan for a bigger personal goal.",
        "materials": ["Paper and pencil", "A pretend big-goal item with a price"],
        "steps": [
            "Pick a bigger pretend goal item and find its price.",
            "Plan out a realistic weekly or monthly savings amount to reach it.",
            "Write out a full timeline to the goal.",
            "Present your plan to a partner and explain your reasoning.",
        ],
        "tip": "A goal with a real plan behind it is far more likely to actually happen.",
    },
]


GAMES[7] = [
    {
        "name": "💰 Paycheck to Budget Simulation",
        "objective": "Practice building a full monthly budget from a pretend paycheck, covering fixed and variable expenses.",
        "materials": ["Pretend money representing a monthly paycheck", "Paper listing fixed costs (rent, bills) and variable costs (food, fun)"],
        "steps": [
            "Start with your pretend monthly paycheck total.",
            "Subtract fixed costs first, since those don't change.",
            "Divide what's left between variable costs and savings.",
            "Reflect: what would you cut first if the paycheck were smaller?",
        ],
        "tip": "Paying fixed costs first, then deciding on the rest, is how many real budgets are built.",
    },
    {
        "name": "🛒 Emergency Fund Scenario",
        "objective": "Practice understanding why setting aside savings for emergencies matters, through a decision simulation.",
        "materials": ["Pretend money", "A card describing an unexpected emergency cost"],
        "steps": [
            "Start with a pretend budget that includes a small emergency fund.",
            "Draw an emergency card (like 'a bike needs a big repair').",
            "Decide: cover it from the emergency fund, or scramble to find money elsewhere?",
            "Reflect on which felt less stressful and why.",
        ],
        "tip": "An emergency fund exists so a surprise cost doesn't have to become a crisis.",
    },
    {
        "name": "🗂️ Moving Day Packing Challenge",
        "objective": "Practice labeling and organizing belongings efficiently under a time limit, simulating a move.",
        "materials": ["A pile of mixed items (or picture cards)", "Boxes or bins", "Labels or markers"],
        "steps": [
            "Sort items into logical box groups (kitchen, books, clothes).",
            "Label each box clearly with its contents and destination room.",
            "Set a timer and pack as efficiently as possible.",
            "Reflect: what would you label differently to make unpacking easier?",
        ],
        "tip": "Clear labeling now always saves confusion (and time) later.",
    },
    {
        "name": "🕵️ Digital Footprint Deep Dive",
        "objective": "Practice reflecting on how an online presence builds up over years and what that might mean later in life.",
        "materials": ["None — just talk it through together, or written example scenario cards"],
        "steps": [
            "Discuss a scenario: a college or employer looks someone up online someday.",
            "Talk through what kinds of posts would leave a good impression versus a concerning one.",
            "Come up with 3 personal 'digital habits' worth keeping.",
            "Reflect: which habit do you think matters most, and why?",
        ],
        "tip": "The habits you build online now are the same ones that will follow you for years.",
    },
    {
        "name": "🗓️ Group Project Dependency Planner",
        "objective": "Practice scheduling a group project where some tasks depend on others being finished first.",
        "materials": ["Paper and pencil", "Cards listing 5-6 pretend project tasks, some dependent on others"],
        "steps": [
            "Lay out all the tasks and note which ones must happen before others can start.",
            "Build a schedule that respects those dependencies.",
            "Assign rough time estimates and a final deadline.",
            "Reflect: what happens to the whole plan if one early task runs late?",
        ],
        "tip": "In group projects, one delayed task can delay everything after it — planning for that in advance really helps.",
    },
    {
        "name": "⏳ Extracurricular Juggling Reflection",
        "objective": "Practice mapping and honestly evaluating a full schedule of commitments for sustainability.",
        "materials": ["Paper and pencil", "A list of current or pretend weekly commitments with time estimates"],
        "steps": [
            "List every regular commitment and its weekly time cost.",
            "Add up the total and compare it to available free hours in a week.",
            "Identify anything that feels like too much, or room for more.",
            "Reflect: is your current balance actually working for you?",
        ],
        "tip": "A schedule that looks fine on paper can still feel overwhelming — checking in with yourself matters too.",
    },
    {
        "name": "🧦 Full Closet System Redesign",
        "objective": "Practice designing and justifying a complete, sustainable organization system for a personal space.",
        "materials": ["A mixed pile of belongings (or picture cards)", "Bins or sections", "Labels"],
        "steps": [
            "Assess what's currently disorganized and why.",
            "Design a system with clear categories and an easy-to-maintain routine.",
            "Set it up and write a short 'how to keep this working' note.",
            "Reflect: what's the biggest reason organization systems usually fail, and how does yours avoid it?",
        ],
        "tip": "The best system isn't the fanciest one — it's the one you'll actually keep using.",
    },
    {
        "name": "🪙 Cost Comparison Over Time",
        "objective": "Practice comparing the true long-term cost of different spending choices.",
        "materials": ["2-3 cards describing pretend purchase options with different upfront and ongoing costs"],
        "steps": [
            "Compare a cheaper option with ongoing costs versus a pricier one-time option.",
            "Calculate the total cost of each over a full year (or more).",
            "Decide which is actually the better long-term value.",
            "Reflect: does the 'cheaper' choice always win?",
        ],
        "tip": "Looking at total cost over time, not just the price tag today, leads to smarter decisions.",
    },
    {
        "name": "🧹 Household CEO Challenge",
        "objective": "Practice designing and delegating a full household organization and chore system as a leadership exercise.",
        "materials": ["Paper and pencil", "A list of all household chores and members"],
        "steps": [
            "Take on the role of 'household CEO' for this game.",
            "Design a full chore schedule, considering everyone's fairness and strengths.",
            "Write clear instructions and a simple way to track completion.",
            "Present your plan and explain your reasoning for each decision.",
        ],
        "tip": "Good leadership means designing systems that make life easier for everyone, not just yourself.",
    },
    {
        "name": "🚦 Online Dilemma Debate",
        "objective": "Practice defending a reasoned position on a digital citizenship dilemma through respectful discussion.",
        "materials": ["4-5 written dilemma cards with no clear single right answer"],
        "steps": [
            "Draw a dilemma card with a genuinely tricky digital scenario.",
            "Take a position and explain your reasoning.",
            "Have a partner argue a different view, respectfully.",
            "Reflect together on what a thoughtful person might actually do.",
        ],
        "tip": "The most complex digital dilemmas rarely have one perfect answer — reasoning through them is the real skill.",
    },
    {
        "name": "📚 Master Index System",
        "objective": "Practice building a comprehensive, multi-level organization and reference system for a large set of information.",
        "materials": ["15+ item or topic cards", "Paper for a detailed index"],
        "steps": [
            "Sort all items into main categories and subcategories.",
            "Build a written index showing exactly where to find each item.",
            "Test the system with a partner using only the index.",
            "Reflect: what made the system fast (or slow) to use?",
        ],
        "tip": "A well-built index turns a big pile of information into something anyone could navigate.",
    },
    {
        "name": "⏰ Time-Money Trade-Off Debate",
        "objective": "Practice reasoning through scenarios where time and money decisions are linked.",
        "materials": ["3-4 scenario cards describing a choice between spending more time or more money for the same result"],
        "steps": [
            "Read a scenario, like 'pay for a faster option or spend extra time doing it yourself.'",
            "Discuss the trade-offs of each choice.",
            "Decide which you'd choose and explain your reasoning.",
            "Try a few more scenarios and see if your reasoning changes.",
        ],
        "tip": "Time and money are both limited resources — recognizing when you're trading one for the other is a grown-up skill.",
    },
    {
        "name": "🛍️ Subscription Audit Project",
        "objective": "Practice auditing a set of recurring pretend costs and deciding what's actually worth keeping.",
        "materials": ["6-8 cards listing pretend recurring subscriptions with monthly costs and how often they're 'used'"],
        "steps": [
            "Review each subscription's cost and how much value it seems to provide.",
            "Decide which to keep, cancel, or downgrade.",
            "Calculate the total yearly savings from your decisions.",
            "Reflect: how would you decide if something is really worth the recurring cost?",
        ],
        "tip": "Regularly auditing recurring costs is one of the simplest ways to find extra money in a budget.",
    },
    {
        "name": "🤝 Big Goal Investment Plan",
        "objective": "Practice building and presenting a full multi-month plan to reach an ambitious savings goal.",
        "materials": ["Paper and pencil", "A pretend big-goal item with a price", "Calculator (optional)"],
        "steps": [
            "Pick an ambitious pretend goal and its total price.",
            "Plan a realistic monthly savings amount and calculate the full timeline.",
            "Identify one way you could reach the goal faster (extra saving, or a smaller starting goal).",
            "Present your full plan, including your reasoning, to a partner.",
        ],
        "tip": "A clear plan turns 'I want that someday' into 'here's exactly how I'll get it.'",
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
    # inside their own parenthetical text (e.g. "(kitchen, books, clothes)").
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 74_life_skills_games_content.sql")
    out.append("-- Adds a 'Real-Life Skills Games' category to the existing always-on")
    out.append("-- 'life_skills' subject_area for every grade (TK-6th) — no schema or proc")
    out.append("-- changes needed, reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket")
    out.append("-- exactly as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games spanning the subject area's existing")
    out.append("-- themes (Digital Literacy & Online Safety, Financial Literacy,")
    out.append("-- Organization, Time Management); target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's life_skills")
    out.append("-- category is selected, satisfying \"7 games, different set each week\"")
    out.append("-- without any manual per-week authoring.")
    out.append("--")
    out.append("-- Every game is a screen-free, printed activity played at home — including")
    out.append("-- the digital-literacy games, which use role-play and hand-drawn scenario")
    out.append("-- cards rather than any actual device use.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print — see 63_whole_child_rotation.sql).")
    out.append("-- See gen_74_life_skills_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'life_skills' AND category_name = N'Real-Life Skills Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_life_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'life_skills', N'Real-Life Skills Games', 'space_heavy', 7, N'Practice a real-world skill through a fun hands-on game!', 0);"
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
    # This bit the outdoor-games batch for real: shipped 112 rows with \r\n
    # before catching it — see gen_68_outdoor_games_content.py.
    with open(r"D:\Project\www\littlescholarhub\lsh.database\74_life_skills_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    print("Wrote 74_life_skills_games_content.sql", file=sys.stderr)
