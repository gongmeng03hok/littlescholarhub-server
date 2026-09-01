# -*- coding: utf-8 -*-
"""
Generates lsh.database/83_outdoor_games_retro70s_batch1.sql -- extends the
existing 'Outdoor Games' category (see 68/69/70/71/82) with 7 MORE games
per grade (42 -> 49 per grade, 56 new games), introducing a 1970s-retro
theme built around toys and activities that defined that decade's outdoor
play: pogo sticks, kite flying, water balloon fights, banana-bike rodeos,
"Spud" (the classic ball-calling game), early skateboarding, and Big Wheel
trikes. No branded/copyrighted characters -- traditional public-domain
activities and toy TYPES only, scaled by grade, with safety-conscious
framing on the wheeled/thrown ones (helmets, supervision, gentle contact).
Checked against all 336 existing Outdoor Games names for collisions
(none found) before writing content.

Same structural fields and prompt format as prior retro batches (name,
inspiration, objective, materials, steps, safety_line, image_prompt),
appended to the same per-grade Outdoor Games category row, sort_order
continuing from 43.

Also emits outdoor_games_retro70s_image_prompts.md (reference doc only,
not stored in the DB).

Run with: python gen_83_outdoor_games_retro70s_batch1.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🦘 Pretend Pogo Hop",
        "objective": "Practice two-footed bouncing in place, like a pretend pogo stick, to build balance and rhythm.",
        "inspiration": "A safe, stick-free warm-up for the pogo stick craze that bounced across 1970s backyards.",
        "materials": ["None -- just open space!"],
        "steps": [
            "Stand with feet together and hands out to the sides for balance.",
            "Bounce gently in place on both feet, like you're on a pretend pogo stick.",
            "Count how many bounces in a row you can do without stopping.",
            "Try bouncing forward a little bit at a time!",
        ],
        "safety_line": "Bounce on soft ground like grass, and keep bounces small and controlled.",
        "image_prompt": "A joyful illustration of a young child mid-bounce on grass with both feet together and arms out for balance, pretending to ride an invisible pogo stick, bright sunny yard. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 My First Kite Walk",
        "objective": "Practice walking steadily while holding a kite string, to get a feel for how kites catch the wind.",
        "inspiration": "A gentle introduction to kite flying, a favorite breezy-day activity of the 1970s.",
        "materials": ["1 simple kite (or a kite-shaped paper cutout on a string)"],
        "steps": [
            "Hold the kite string with both hands and stand somewhere open and breezy.",
            "Walk forward slowly while a grown-up helps hold the kite up behind you.",
            "Feel the tug of the wind on the string as you walk.",
            "Wave to your kite as it starts to lift a little into the air!",
        ],
        "safety_line": "Fly kites away from roads, trees, and power lines, with a grown-up nearby.",
        "image_prompt": "A cheerful illustration of a young child walking across a grassy park holding a colorful diamond kite string, a grown-up helping launch the kite behind them, blue sky with fluffy clouds. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Gentle Pass",
        "objective": "Practice careful, gentle hand-offs while passing a water balloon between friends.",
        "inspiration": "A slowed-down, no-throwing version of the classic summer water balloon toss.",
        "materials": ["A few small water balloons", "Towels for drying off"],
        "steps": [
            "Stand close together in a small circle with a grown-up.",
            "Gently pass a water balloon from one pair of hands to the next.",
            "Try to pass it all the way around the circle without it popping.",
            "If it pops, laugh it off and grab a towel -- then try again with a new one!",
        ],
        "safety_line": "Pass gently with both hands cupped underneath -- never squeeze or toss.",
        "image_prompt": "A cheerful illustration of a small circle of children carefully passing a colorful water balloon hand to hand, big smiles, sunny backyard with grass. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Tricycle Path Ride",
        "objective": "Practice steady steering and pedaling along a simple marked path.",
        "inspiration": "A gentle warm-up for the banana-bike and trike rodeos that filled 1970s driveways.",
        "materials": ["A tricycle or ride-on toy", "Chalk or cones to mark a simple path"],
        "steps": [
            "Draw or mark a simple curved path with chalk or cones on a flat, safe surface.",
            "Sit on the tricycle and pedal slowly along the path.",
            "Try to keep your wheels inside the marked path the whole way.",
            "Ride it again a little faster once you feel steady!",
        ],
        "safety_line": "Ride only on a flat surface away from cars, with a grown-up watching nearby.",
        "image_prompt": "A sweet illustration of a young child pedaling a colorful tricycle along a chalk-drawn curvy path in a driveway, big happy smile, sunny day. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Gentle Toss",
        "objective": "Practice listening for your name and freezing quickly in a gentle group ball game.",
        "inspiration": "A slowed-down, no-throwing version of the classic 1970s playground game Spud.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Everyone stands in a loose circle while one player gently tosses the ball straight up and calls a friend's name.",
            "Everyone else scatters a few steps away and then freezes in place.",
            "The named friend catches or picks up the ball and calls out 'Spud!'",
            "That friend walks over and gently taps a frozen player with the ball -- then it's that player's turn to toss!",
        ],
        "safety_line": "Always tap gently with the ball in hand -- never throw it at a friend.",
        "image_prompt": "A playful illustration of a small circle of children scattering after a ball toss, one child freezing mid-step with a big grin, sunny grassy yard. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Wheeled Wobble Walk",
        "objective": "Practice balance and slow, steady steps while holding onto a scooter or riding a trike.",
        "inspiration": "A gentle first step toward the skateboarding craze that took off in the 1970s.",
        "materials": ["A scooter, balance bike, or tricycle", "A flat, open surface"],
        "steps": [
            "Stand next to your scooter or trike, holding on with both hands.",
            "Take small, careful steps forward while keeping the wheels rolling slowly beside you.",
            "Practice stopping gently by holding still.",
            "Once you feel steady, try a few steps a little faster!",
        ],
        "safety_line": "Always practice on a flat, open surface away from stairs, slopes, and traffic.",
        "image_prompt": "A charming illustration of a young child walking alongside a colorful scooter, holding the handlebars carefully with both hands, sunny driveway setting. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Ride-Along",
        "objective": "Practice pedaling and steering a low ride-on trike along a short, simple course.",
        "inspiration": "The iconic low-riding Big Wheel trike that was everywhere on 1970s driveways.",
        "materials": ["A Big Wheel or similar low ride-on trike", "Cones or chalk to mark a short path"],
        "steps": [
            "Sit low in the seat and place both feet on the pedals.",
            "Pedal slowly forward along a short, simple marked path.",
            "Practice turning the wide front wheel gently to follow the path.",
            "Ride it again, trying to keep a nice steady pace!",
        ],
        "safety_line": "Ride only on a flat driveway or sidewalk away from cars, with a grown-up nearby.",
        "image_prompt": "A fun illustration of a young child riding a low, colorful Big Wheel trike along a chalk path in a driveway, big front wheel visible, sunny afternoon. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[1] = [
    {
        "name": "🦘 Pogo Stick First Bounces",
        "objective": "Practice a few real pogo stick bounces with a grown-up holding on for support.",
        "inspiration": "The pogo stick craze that bounced across countless 1970s backyards.",
        "materials": ["A pogo stick (child-sized)", "A grown-up spotter"],
        "steps": [
            "Stand next to the pogo stick with a grown-up holding it steady.",
            "Step onto the footrests and hold the handles firmly.",
            "With the grown-up supporting you, try a few small bounces in place.",
            "Count how many bounces you can do before needing a break!",
        ],
        "safety_line": "Always practice pogo sticking with a grown-up spotting you on a soft, flat surface.",
        "image_prompt": "A joyful illustration of a young child on a pogo stick mid-bounce with a grown-up gently steadying them from behind, grassy backyard. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Flying Basics",
        "objective": "Practice launching a kite into the wind and keeping it flying steady.",
        "inspiration": "The classic breezy-day activity that filled 1970s parks and open fields.",
        "materials": ["1 kite with string"],
        "steps": [
            "Stand with your back to the wind and hold the kite up with a friend's help.",
            "Let out a little string while walking backward slowly as the wind catches the kite.",
            "Once it lifts, let out a bit more string to help it climb.",
            "Keep gentle tension on the string to keep it flying steady!",
        ],
        "safety_line": "Fly kites in open fields, away from roads, trees, and power lines.",
        "image_prompt": "A cheerful illustration of a child in a park letting out kite string as a colorful diamond kite climbs into a blue sky with a few clouds. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Basics",
        "objective": "Practice underhand tossing and catching a water balloon with a partner.",
        "inspiration": "The classic summer water balloon toss, a 1970s backyard party staple.",
        "materials": ["Small water balloons", "Towels for drying off"],
        "steps": [
            "Stand facing a partner just a few steps apart.",
            "Gently underhand toss the water balloon back and forth.",
            "After each successful catch, take one step farther apart.",
            "See how far apart you can get before it pops!",
        ],
        "safety_line": "Toss gently and underhand only -- never throw hard or aim at faces.",
        "image_prompt": "A fun illustration of two children tossing a colorful water balloon back and forth on a sunny lawn, both smiling with arms out ready to catch. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Rodeo Basics",
        "objective": "Practice steady pedaling and simple steering skills on a bike with training wheels.",
        "inspiration": "The banana-seat bike rodeos that were a rite of passage on 1970s driveways.",
        "materials": ["A bike with training wheels", "Cones or chalk to mark a simple course"],
        "steps": [
            "Set up a simple straight or gently curving path with cones or chalk.",
            "Pedal along the path, keeping your eyes up and looking ahead.",
            "Practice a smooth, controlled stop at the end.",
            "Ride it again, trying to stay right on the path!",
        ],
        "safety_line": "Always wear a helmet and ride on a flat surface away from traffic.",
        "image_prompt": "A cheerful illustration of a young child riding a bike with training wheels and a colorful helmet along a cone-marked path in a driveway. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Basics",
        "objective": "Practice quick listening, scattering, and freezing in the classic ball-calling game.",
        "inspiration": "The classic 1970s playground game where a called name means it's your turn.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Everyone stands in a loose group while one player tosses the ball up and calls a friend's name.",
            "Everyone scatters and freezes once the named player catches (or picks up) the ball.",
            "The player with the ball calls 'Spud!' and takes up to 3 giant steps toward the nearest frozen player.",
            "They gently tap that player with the ball -- then that player tosses next!",
        ],
        "safety_line": "Always tap gently with the ball in hand -- this game never involves throwing at people.",
        "image_prompt": "A lively illustration of children scattering away from a central player holding a ball after a name is called, playful energy, sunny playground. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard First Balance",
        "objective": "Practice standing steady on a skateboard while it stays still, with a grown-up holding a hand.",
        "inspiration": "The very first steps toward the skateboarding craze that exploded in the mid-1970s.",
        "materials": ["A skateboard", "A helmet", "A grown-up spotter"],
        "steps": [
            "Place the skateboard on grass or carpet first so it won't roll.",
            "Step on with both feet, holding a grown-up's hand for balance.",
            "Practice bending your knees slightly and standing tall.",
            "Once you feel steady, try it on a flat, smooth surface with the grown-up holding on!",
        ],
        "safety_line": "Always wear a helmet, and never practice without a grown-up spotting you.",
        "image_prompt": "A sweet illustration of a young child standing on a skateboard on grass, holding a grown-up's hand for balance, wearing a colorful helmet. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Race Basics",
        "objective": "Practice pedaling a Big Wheel at a steady pace over a short measured distance.",
        "inspiration": "The iconic Big Wheel trike races that filled 1970s neighborhood driveways.",
        "materials": ["A Big Wheel or similar low ride-on trike", "Cones to mark a start and finish"],
        "steps": [
            "Set up a start line and a finish line a short distance apart.",
            "Sit low in the seat and get your feet ready on the pedals.",
            "On 'go,' pedal steadily from start to finish.",
            "Try it again and see if you can pedal even smoother!",
        ],
        "safety_line": "Race only on a flat, open surface away from cars and steep slopes.",
        "image_prompt": "An energetic illustration of a young child pedaling a colorful Big Wheel trike toward an orange cone finish line, determined smile, driveway setting. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[2] = [
    {
        "name": "🦘 Pogo Stick Warm-Up",
        "objective": "Practice a short series of steady pogo stick bounces with light support.",
        "inspiration": "The classic pogo stick, one of the defining backyard toys of the 1970s.",
        "materials": ["A pogo stick (child-sized)", "A grown-up nearby"],
        "steps": [
            "Step onto the pogo stick and hold the handles firmly.",
            "Start with a grown-up lightly supporting your shoulder for the first few bounces.",
            "Try bouncing on your own for 3-5 bounces in a row.",
            "Rest, then try again and see if you can add one more bounce!",
        ],
        "safety_line": "Practice on a soft, flat surface, and always have a grown-up nearby.",
        "image_prompt": "A joyful illustration of a child bouncing independently on a pogo stick in a grassy yard, a grown-up watching a step away, bright sunny day. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Launch Warm-Up",
        "objective": "Practice launching a kite solo and adjusting string tension to keep it flying.",
        "inspiration": "The classic backyard and park kite-flying that peaked in popularity in the 1970s.",
        "materials": ["1 kite with string"],
        "steps": [
            "Hold the kite up with the wind at your back and let it catch a gust.",
            "Run a few light steps if needed to help it lift, then stop and let out string.",
            "Adjust how much string is out to keep the kite steady in the wind.",
            "See how long you can keep it flying without it dipping to the ground!",
        ],
        "safety_line": "Fly kites in wide open spaces, away from roads, trees, and power lines.",
        "image_prompt": "A cheerful illustration of a child solo-launching a colorful kite in an open field, kite lifting into a clear blue sky. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Warm-Up",
        "objective": "Practice tossing and catching a water balloon at increasing distances with a partner.",
        "inspiration": "The classic backyard water balloon toss, a summertime staple of the 1970s.",
        "materials": ["Small water balloons", "Towels for drying off"],
        "steps": [
            "Start close to your partner and toss the balloon gently underhand.",
            "After each successful catch, both partners take one step backward.",
            "Keep going until the balloon pops, then start over with a new one.",
            "Try to beat your best distance from last time!",
        ],
        "safety_line": "Toss underhand and gently -- distance is about catching skill, not throwing hard.",
        "image_prompt": "A fun illustration of two children standing farther apart tossing a water balloon, one mid-catch with focused determination, sunny lawn. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Obstacle Warm-Up",
        "objective": "Practice steering carefully around a few simple obstacles on a bike.",
        "inspiration": "The bike-handling skills every kid needed for a proper 1970s neighborhood bike rodeo.",
        "materials": ["A bike", "3-4 cones to mark obstacles"],
        "steps": [
            "Set up 3-4 cones spaced out in a simple line.",
            "Ride slowly, steering around each cone one at a time.",
            "Focus on smooth, controlled turns rather than speed.",
            "Ride the course again and try to knock over zero cones!",
        ],
        "safety_line": "Always wear a helmet and ride slowly enough to stay in full control.",
        "image_prompt": "A lively illustration of a child on a bike with a helmet weaving carefully between orange cones set up on a driveway. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Warm-Up",
        "objective": "Practice quicker reactions and short sprints in the classic ball-calling game.",
        "inspiration": "The classic 1970s playground name-calling ball game, played at a slightly faster pace.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Everyone stands in a loose group; one player tosses the ball up and calls a name.",
            "Everyone scatters quickly and freezes as soon as the named player has the ball.",
            "The player with the ball calls 'Spud!' and takes up to 3 steps toward the nearest frozen player.",
            "A gentle tap with the ball ends that round -- the tapped player tosses next!",
        ],
        "safety_line": "Scatter safely, watching where you're running, and always tap gently.",
        "image_prompt": "An energetic illustration of a group of children scattering quickly in different directions after a ball toss, one child mid-freeze with arms out, sunny field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard Push Warm-Up",
        "objective": "Practice a gentle push-and-glide with one foot while staying balanced.",
        "inspiration": "The classic first real skateboarding skill from the 1970s skateboarding boom.",
        "materials": ["A skateboard", "A helmet", "A flat, smooth surface"],
        "steps": [
            "Stand with one foot on the skateboard and one foot on the ground.",
            "Push off gently with your ground foot and place it back on the board once moving.",
            "Glide slowly in a straight line, keeping your knees slightly bent.",
            "Practice stepping off calmly to stop whenever you feel wobbly.",
        ],
        "safety_line": "Always wear a helmet and practice on a flat surface away from slopes and traffic.",
        "image_prompt": "A fun illustration of a child gliding gently on a skateboard along a smooth sidewalk, wearing a helmet, one foot pushing off behind. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Relay Warm-Up",
        "objective": "Practice a short relay hand-off between two Big Wheel riders.",
        "inspiration": "The friendly Big Wheel races that turned into full relays on 1970s driveways.",
        "materials": ["1-2 Big Wheels or similar ride-on trikes", "Cones to mark a short lane"],
        "steps": [
            "Set up a short lane with a cone marking the turnaround point.",
            "The first rider pedals to the cone, turns around, and rides back.",
            "Hop off and tag the next rider to take a turn.",
            "See how smoothly your pair can complete two full turns!",
        ],
        "safety_line": "Ride on a flat, open surface away from cars, and hop off carefully at the hand-off.",
        "image_prompt": "A fun illustration of one child riding a Big Wheel back toward a cone while a second child waits eagerly for their turn, sunny driveway. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[3] = [
    {
        "name": "🦘 Pogo Stick Challenge",
        "objective": "Practice sustained pogo stick bouncing without support, aiming for a personal best.",
        "inspiration": "The pogo stick bouncing contests that popped up on 1970s playgrounds and backyards.",
        "materials": ["A pogo stick (child-sized)"],
        "steps": [
            "Step onto the pogo stick and find your balance before starting.",
            "Bounce steadily, counting each bounce out loud.",
            "Try to beat your own best bounce count from last time.",
            "Take a short rest between attempts to stay steady.",
        ],
        "safety_line": "Bounce on a soft, flat surface, and stop right away if you feel off-balance.",
        "image_prompt": "An energetic illustration of a child confidently bouncing on a pogo stick across a grassy yard, counting on their fingers between bounces, sunny day. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Flying Challenge",
        "objective": "Practice keeping a kite airborne for as long as possible while managing string and wind changes.",
        "inspiration": "The classic kite-flying pastime, popular at parks and beaches throughout the 1970s.",
        "materials": ["1 kite with string"],
        "steps": [
            "Launch your kite and get it flying steadily in the wind.",
            "Practice letting out and reeling in string to react to gusts.",
            "Time how many minutes you can keep it airborne without it touching the ground.",
            "Try again and see if you can beat your own time!",
        ],
        "safety_line": "Keep flying in a wide open space, away from roads, trees, and power lines.",
        "image_prompt": "A cheerful illustration of a child confidently managing kite string while their colorful kite dips and rises with the wind, wide open park setting. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Challenge",
        "objective": "Practice precise underhand tossing and soft-handed catching over increasing distances.",
        "inspiration": "The classic water balloon toss, a favorite 1970s summer party game.",
        "materials": ["Small water balloons", "Towels for drying off"],
        "steps": [
            "Start a few steps from your partner and toss gently underhand.",
            "After each catch, both partners step back one more step.",
            "Focus on 'soft hands' -- catching by giving with the balloon, not grabbing hard.",
            "See how far apart your pair can get before the balloon finally pops!",
        ],
        "safety_line": "Underhand tosses only, and always catch with soft, cupped hands.",
        "image_prompt": "A lively illustration of two children spaced far apart tossing a water balloon high between them, both leaning in to catch softly, sunny backyard. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Rodeo Challenge",
        "objective": "Practice a full obstacle course combining steering, stopping, and balance skills.",
        "inspiration": "The full bike rodeo events that were a highlight of many 1970s neighborhood summers.",
        "materials": ["A bike", "5-6 cones to mark a full course"],
        "steps": [
            "Set up a course with a slalom section, a straight sprint, and a controlled-stop zone.",
            "Ride the full course, focusing on control through each section.",
            "Time your run, or just focus on completing it without touching a cone.",
            "Try the course again and see where you can improve!",
        ],
        "safety_line": "Always wear a helmet, and prioritize control over speed through every section.",
        "image_prompt": "A dynamic illustration of a child on a bike with a helmet navigating a full cone course with a slalom section and a stop zone, driveway setting. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Challenge",
        "objective": "Practice quicker decision-making about how far to scatter based on who's holding the ball.",
        "inspiration": "The classic 1970s playground ball-calling game, played with a bigger group for more challenge.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Play with a bigger group standing in a loose scatter to start.",
            "One player tosses the ball up and calls a name; everyone else runs and freezes once the ball is caught.",
            "The ball holder calls 'Spud!' and takes up to 3 steps toward the nearest frozen player.",
            "A gentle tap ends the round, and that player becomes the next tosser!",
        ],
        "safety_line": "With more players scattering, keep your head up and watch where you're running.",
        "image_prompt": "A busy, joyful illustration of a large group of children scattering in every direction across a field after a ball toss, playful chaos, sunny sky. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard Slalom Challenge",
        "objective": "Practice weaving smoothly through a row of cones while gliding on a skateboard.",
        "inspiration": "The slalom skateboarding style that became a 1970s skateboarding favorite.",
        "materials": ["A skateboard", "A helmet", "4-5 cones", "A flat, smooth surface"],
        "steps": [
            "Set up 4-5 cones spaced evenly in a line.",
            "Push off gently and glide, steering side to side around each cone.",
            "Keep your knees bent and weight centered as you weave.",
            "Try the course again, aiming for smoother turns each time!",
        ],
        "safety_line": "Always wear a helmet, and slow down rather than rush through the weave.",
        "image_prompt": "A dynamic illustration of a child on a skateboard weaving smoothly between a row of orange cones on a smooth path, helmet on, focused expression. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Relay Challenge",
        "objective": "Practice a full team relay with multiple Big Wheel riders taking turns.",
        "inspiration": "The full-team Big Wheel relay races that filled 1970s cul-de-sacs.",
        "materials": ["1-2 Big Wheels or similar ride-on trikes", "Cones to mark a lane"],
        "steps": [
            "Split into small teams lined up behind the start line.",
            "The first rider pedals to a cone, turns around, and rides back.",
            "Hop off and tag the next teammate to take their turn.",
            "First team to get every rider through the relay wins!",
        ],
        "safety_line": "Ride on a flat, open surface, and hop off carefully so the next rider has a clear start.",
        "image_prompt": "An energetic illustration of a small team of children cheering as one rides a Big Wheel back toward a cone, next rider ready to go, sunny driveway. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[4] = [
    {
        "name": "🦘 Pogo Stick Count Challenge",
        "objective": "Practice sustained balance and rhythm to reach a target number of consecutive bounces.",
        "inspiration": "The pogo stick bounce-counting contests popular on 1970s playgrounds.",
        "materials": ["A pogo stick (child-sized)"],
        "steps": [
            "Set a target number of bounces to aim for (start with 10).",
            "Bounce steadily, keeping your core tight and eyes forward.",
            "If you reach your target, set a new, slightly higher goal.",
            "Take breaks between attempts so your legs stay fresh.",
        ],
        "safety_line": "Stop and rest if your legs feel tired -- fatigue is when falls happen.",
        "image_prompt": "A determined illustration of a child bouncing steadily on a pogo stick across a grassy field, a chalk number written nearby showing a bounce count goal. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Height Contest",
        "objective": "Practice letting out string efficiently to get a kite as high as possible.",
        "inspiration": "The friendly 'whose kite flies highest' contests common at 1970s park gatherings.",
        "materials": ["1 kite with string per player"],
        "steps": [
            "Launch your kite and get it flying steadily.",
            "Let out string gradually, watching how the kite responds to the wind.",
            "See how high you can get your kite while keeping it under control.",
            "Compare with a friend's kite -- whose got the highest today?",
        ],
        "safety_line": "Never let out so much string that you lose sight of or control over your kite.",
        "image_prompt": "A cheerful illustration of two children in a park each flying their own colorful kite high in the sky, comparing heights and laughing. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Distance Challenge",
        "objective": "Practice controlled, gentle tossing technique to maximize catching distance with a partner.",
        "inspiration": "The classic water balloon toss, taken to its farthest-distance extreme.",
        "materials": ["Small water balloons", "Towels for drying off", "Something to mark distance (chalk or a tape measure)"],
        "steps": [
            "Start close together and toss gently, stepping back after every successful catch.",
            "Mark your distance with chalk each time you both step back.",
            "Focus on a smooth, arcing underhand toss rather than a flat throw.",
            "See how far your pair's mark gets before the balloon pops!",
        ],
        "safety_line": "A gentle, arcing toss is safer and more accurate than throwing hard -- distance comes from technique, not force.",
        "image_prompt": "A fun illustration of two children standing very far apart, one mid-toss sending a water balloon in a high gentle arc, chalk distance marks on the grass between them. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Slalom Course",
        "objective": "Practice tight, controlled turns weaving through a closely spaced cone course.",
        "inspiration": "The bike slalom events that tested steering skill at 1970s neighborhood bike rodeos.",
        "materials": ["A bike", "6-8 closely spaced cones"],
        "steps": [
            "Set up 6-8 cones spaced closer together than a normal obstacle course.",
            "Ride slowly through the course, weaving tightly around each cone.",
            "Focus on smooth handlebar turns rather than leaning your whole body.",
            "Time yourself, then try again for a smoother, faster run!",
        ],
        "safety_line": "Always wear a helmet, and go slowly enough to stay in control through tight turns.",
        "image_prompt": "A dynamic illustration of a child on a bike with a helmet weaving tightly through closely spaced cones, focused expression, driveway course. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Strategy",
        "objective": "Practice reading the group to decide the smartest direction to scatter and freeze.",
        "inspiration": "The classic 1970s ball-calling game, played with an eye toward smart positioning.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "As the ball is tossed, think fast about which direction has the most open space.",
            "Scatter toward that space and freeze the instant the ball is caught.",
            "If you're the ball holder, think about which frozen player is closest before calling 'Spud!'",
            "Play several rounds, tracking who avoids being tapped the longest!",
        ],
        "safety_line": "Even with strategy in mind, always watch where you're running before you freeze.",
        "image_prompt": "A thoughtful yet playful illustration of children scattering strategically toward open space in a field after a ball toss, one glancing back to judge distance. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard Cone Course",
        "objective": "Practice combining pushing, gliding, and steering through a longer mixed course.",
        "inspiration": "The backyard skateboard courses kids built with whatever cones and chalk they had in the 1970s.",
        "materials": ["A skateboard", "A helmet", "6-8 cones", "A flat, smooth surface"],
        "steps": [
            "Set up a course mixing a straight glide section and a weaving section.",
            "Push off and glide the straight section, then carefully weave through the cones.",
            "Step off calmly at the end rather than jumping.",
            "Run the course again, aiming for one continuous smooth ride!",
        ],
        "safety_line": "Always wear a helmet, and choose control over speed on every section.",
        "image_prompt": "A dynamic illustration of a child on a skateboard gliding through a straight section then weaving between cones, helmet on, smooth sidewalk course. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Speed Course",
        "objective": "Practice pedaling at maximum steady speed through a straight timed course.",
        "inspiration": "The friendly Big Wheel speed trials that were a summer tradition on 1970s driveways.",
        "materials": ["A Big Wheel or similar low ride-on trike", "Cones marking start and finish", "A stopwatch or phone timer"],
        "steps": [
            "Set up a straight course with a clear start and finish line.",
            "Get in position with feet ready on the pedals.",
            "On 'go,' pedal as steadily and quickly as you can to the finish.",
            "Check your time, then try again to beat it!",
        ],
        "safety_line": "Race only on a flat, open surface away from cars, and keep both hands on the handlebars.",
        "image_prompt": "An energetic illustration of a child pedaling hard on a colorful Big Wheel toward a finish line, motion lines suggesting speed, driveway setting with a stopwatch nearby. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[5] = [
    {
        "name": "🦘 Pogo Stick Trick Practice",
        "objective": "Practice adding a simple trick, like a quarter-turn, to steady pogo stick bouncing.",
        "inspiration": "The trick-bouncing that advanced pogo enthusiasts showed off in the 1970s.",
        "materials": ["A pogo stick (child-sized)"],
        "steps": [
            "Warm up with 10-15 steady bounces in place first.",
            "Once steady, try a very small quarter-turn while bouncing.",
            "Land facing slightly to the side, then bounce back to facing forward.",
            "Practice slowly -- accuracy matters more than height!",
        ],
        "safety_line": "Only attempt turns once your straight bouncing is steady, and always on soft ground.",
        "image_prompt": "A dynamic illustration of a child mid-bounce on a pogo stick, body turned slightly to demonstrate a small trick, grassy backyard. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Trick Flying",
        "objective": "Practice steering a kite through simple loops and figure-eight patterns.",
        "inspiration": "The playful trick-flying that advanced kite fans experimented with in the 1970s.",
        "materials": ["1 kite with string"],
        "steps": [
            "Get your kite flying steady and high in open wind first.",
            "Gently pull and release the string to make the kite dip and climb.",
            "Try guiding it through a slow, wide figure-eight pattern in the sky.",
            "Practice a few times -- smooth, gentle movements work best!",
        ],
        "safety_line": "Trick flying still means staying in a wide open space, away from people, trees, and wires.",
        "image_prompt": "A dynamic illustration of a colorful kite swooping through a wide figure-eight pattern in the sky, a child on the ground carefully guiding the string. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Rodeo Skills Test",
        "objective": "Practice a full skills circuit combining slow riding, sharp turns, and precise stopping.",
        "inspiration": "The full skills-test bike rodeos that many 1970s schools and neighborhoods ran each summer.",
        "materials": ["A bike", "Cones for multiple stations", "Chalk for a stopping line"],
        "steps": [
            "Set up stations: a slow-ride zone, a figure-eight turn, and a precision-stop chalk line.",
            "Complete the slow-ride zone without putting a foot down.",
            "Ride the figure-eight smoothly around two cones.",
            "Finish by stopping with your front wheel exactly on the chalk line!",
        ],
        "safety_line": "Always wear a helmet, and prioritize precision over speed at every station.",
        "image_prompt": "A detailed illustration of a bike rodeo course with a slow-ride zone, a figure-eight cone pattern, and a chalk stopping line, a child riding through wearing a helmet. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Championship",
        "objective": "Practice competitive strategy and quick freezing across a full multi-round tournament.",
        "inspiration": "A championship-format version of the classic 1970s playground game Spud.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Play multiple rounds, keeping a running tally of how many times each player is tapped.",
            "Whoever has the fewest taps after 10 rounds is doing the best at scattering smart.",
            "Rotate who starts with the ball each round to keep it fair.",
            "Celebrate the player with the fewest taps as the round's champion!",
        ],
        "safety_line": "Competitive rounds still mean gentle taps only -- speed of scattering, not contact force.",
        "image_prompt": "An exciting illustration of a group of children playing an intense round of Spud, a simple tally chart nearby tracking taps, sunny field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard Slalom Championship",
        "objective": "Practice consistent slalom weaving across a full timed head-to-head tournament.",
        "inspiration": "A championship-format version of the classic 1970s skateboard slalom.",
        "materials": ["A skateboard", "A helmet", "Cones", "A flat, smooth surface", "A stopwatch or phone timer"],
        "steps": [
            "Set up a standard slalom cone course and time each rider's run.",
            "Run several heats, keeping track of everyone's best time.",
            "The rider with the fastest clean run (no missed cones) wins the round.",
            "Try again to see if you can beat your own best time!",
        ],
        "safety_line": "Always wear a helmet, and a slower clean run beats a fast one that clips a cone.",
        "image_prompt": "An exciting illustration of a child racing through a slalom cone course on a skateboard with a helmet, a stopwatch and small crowd of friends watching nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Relay Strategy",
        "objective": "Practice smart hand-off timing and pacing across a multi-lap team relay.",
        "inspiration": "The strategic team Big Wheel relays that got competitive on longer 1970s summer days.",
        "materials": ["1-2 Big Wheels or similar ride-on trikes", "Cones to mark a lane"],
        "steps": [
            "Split into teams and decide the riding order strategically (fastest rider last, for example).",
            "Each rider completes one lap to the cone and back before tagging the next.",
            "Encourage the current rider loudly to help them pace well.",
            "First team through all laps in their planned order wins!",
        ],
        "safety_line": "Ride on a flat, open surface, and always wait for a full stop before the next rider starts.",
        "image_prompt": "A spirited illustration of a team of children strategizing riding order before a Big Wheel relay, one rider already pedaling toward a cone. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Championship",
        "objective": "Practice peak tossing precision across a full multi-pair elimination tournament.",
        "inspiration": "A championship-format version of the classic 1970s water balloon toss.",
        "materials": ["Small water balloons", "Towels for drying off"],
        "steps": [
            "Set up several pairs tossing at once, each starting close together.",
            "Every successful catch means both partners step back one step.",
            "A pair is eliminated when their balloon pops -- last pair still tossing wins!",
            "Celebrate every pair's best distance, win or not.",
        ],
        "safety_line": "Championship excitement still means gentle, underhand tosses only.",
        "image_prompt": "A festive illustration of several pairs of children tossing water balloons at increasing distances across a sunny lawn, a small crowd cheering. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[6] = [
    {
        "name": "🦘 Pogo Stick Championship",
        "objective": "Practice peak bounce-count endurance across a full head-to-head contest.",
        "inspiration": "A championship-format version of the classic 1970s pogo stick bouncing contest.",
        "materials": ["Pogo sticks (child-sized), one per competitor"],
        "steps": [
            "Line up competitors and have each attempt their longest bounce streak, one at a time.",
            "Count bounces out loud together for whoever is competing.",
            "Track everyone's best streak on a simple scoreboard.",
            "The longest streak at the end wins the championship!",
        ],
        "safety_line": "Always compete on a soft, flat surface, and stop immediately if legs feel shaky.",
        "image_prompt": "An exciting illustration of a child bouncing on a pogo stick while friends count aloud and watch, a small chalk scoreboard tracking bounce streaks. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Flying Championship",
        "objective": "Practice sustained flying skill and height management across a timed group competition.",
        "inspiration": "A championship-format version of the classic 1970s park kite-flying contest.",
        "materials": ["1 kite with string per player"],
        "steps": [
            "Everyone launches their kite at the same time in a wide open field.",
            "Time how long each kite stays airborne without touching the ground.",
            "Track everyone's longest continuous flight time.",
            "Whoever keeps their kite up the longest is the Kite Flying Champion!",
        ],
        "safety_line": "Give each flier plenty of space, and stay well clear of roads, trees, and power lines.",
        "image_prompt": "A festive illustration of several colorful kites flying at once above a wide open field, children below managing their strings, sunny sky. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Grand Finals",
        "objective": "Practice peak precision tossing in a single deciding final round.",
        "inspiration": "The grand finals of the classic 1970s water balloon toss tournament.",
        "materials": ["Small water balloons", "Towels for drying off"],
        "steps": [
            "Bring the two most successful pairs from earlier rounds to face off.",
            "Both pairs start at the same distance and step back together after each catch.",
            "The pair that reaches the farthest distance without popping wins the finals.",
            "Give both finalist pairs a big round of applause either way!",
        ],
        "safety_line": "Even in the finals, a gentle underhand toss beats a hard, risky throw.",
        "image_prompt": "A dramatic finals illustration of two pairs of children tossing water balloons at a large distance apart, a cheering crowd watching from the sidelines. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Rodeo Championship",
        "objective": "Practice peak precision across a full multi-station bike rodeo competition.",
        "inspiration": "A championship-format version of the full 1970s neighborhood bike rodeo.",
        "materials": ["Bikes", "Cones for multiple stations", "A stopwatch or phone timer"],
        "steps": [
            "Set up all the classic stations: slalom, figure-eight, and precision stop.",
            "Each rider completes the full circuit while being timed.",
            "Deduct points for any missed cone or stop-line miss, added to the total time.",
            "The rider with the best combined time and accuracy wins the championship!",
        ],
        "safety_line": "Always wear a helmet, and remember precision beats raw speed in every rodeo event.",
        "image_prompt": "An exciting championship illustration of a bike rodeo course with multiple stations, a rider with a helmet completing a precise stop on a chalk line, small scoreboard nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Grand Tournament",
        "objective": "Practice advanced strategy and consistency across a full bracket-style Spud tournament.",
        "inspiration": "A grand-tournament version of the classic 1970s playground game Spud.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Play a full tournament of many rounds, with a running tally kept for everyone.",
            "Rotate who starts each round so every player gets equal chances.",
            "After a set number of rounds, total up who was tapped the fewest times.",
            "That player is crowned the Spud Grand Tournament winner!",
        ],
        "safety_line": "A big tournament is still a gentle-tap-only game -- keep contact soft the whole way through.",
        "image_prompt": "A festive illustration of a large group of children scattered across a field mid-round of a Spud tournament, a scoreboard with several names and tally marks nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard Slalom Masters",
        "objective": "Practice mastery-level slalom control across the toughest, most tightly spaced cone course.",
        "inspiration": "The most advanced slalom format of the classic 1970s skateboarding boom.",
        "materials": ["A skateboard", "A helmet", "8-10 closely spaced cones", "A stopwatch or phone timer"],
        "steps": [
            "Set up 8-10 cones spaced tighter than any earlier course.",
            "Ride the course focusing on tight, controlled weaving.",
            "Time your run and note if you cleanly avoided every cone.",
            "The fastest CLEAN run (no missed cones) is the Slalom Master!",
        ],
        "safety_line": "Always wear a helmet, and a slower clean run always beats a fast, sloppy one.",
        "image_prompt": "A dynamic illustration of a skilled young skateboarder weaving tightly through a dense row of cones, helmet on, small crowd watching and cheering. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Grand Prix",
        "objective": "Practice peak steady-speed pedaling across a full multi-lap Grand-Prix-style race.",
        "inspiration": "The friendly 'Grand Prix' Big Wheel races that capped off many 1970s summer block parties.",
        "materials": ["Big Wheels or similar ride-on trikes, one per racer", "Cones marking a full lap course"],
        "steps": [
            "Set up a full lap course with a clear start/finish line.",
            "Line up all racers together at the start.",
            "On 'go,' everyone pedals a set number of laps around the course.",
            "First to complete all laps and cross the finish line wins the Grand Prix!",
        ],
        "safety_line": "Race only on a flat, open surface away from cars, and keep a safe distance between racers.",
        "image_prompt": "An exciting illustration of several children racing colorful Big Wheels together around a marked lap course, cheering crowd, checkered-flag-style finish line drawn in chalk. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[7] = [
    {
        "name": "🦘 Pogo Stick Masters",
        "objective": "Practice mastery-level bouncing endurance and control at the highest difficulty.",
        "inspiration": "The most advanced pogo stick bouncing contest format from the 1970s craze.",
        "materials": ["Pogo sticks (child-sized), one per competitor"],
        "steps": [
            "Each competitor attempts their longest streak while also adding a small quarter-turn trick partway through.",
            "Judges (friends or grown-ups) note both streak length and trick success.",
            "Combine streak length and trick success for a final score.",
            "The highest combined score is the Pogo Stick Master!",
        ],
        "safety_line": "Only attempt tricks once your straight bouncing is fully steady, always on soft ground.",
        "image_prompt": "A dynamic masters-level illustration of a child mid-trick on a pogo stick, small turn visible, friends watching and judging nearby, grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪁 Kite Flying Masters",
        "objective": "Practice mastery-level kite control, combining height, duration, and simple tricks.",
        "inspiration": "The most advanced kite-flying format enjoyed by dedicated 1970s kite hobbyists.",
        "materials": ["1 kite with string per player"],
        "steps": [
            "Launch your kite and get it flying high and steady.",
            "Attempt a slow figure-eight trick while maintaining height.",
            "Time how long you can keep the kite up while also completing the trick.",
            "The flier with the best combined height, time, and trick success is the Kite Master!",
        ],
        "safety_line": "Master-level flying still means staying in wide open space, well clear of hazards.",
        "image_prompt": "A skillful illustration of a kite tracing a graceful figure-eight high in the sky, a confident child on the ground managing the string with practiced ease. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Water Balloon Toss Masters",
        "objective": "Practice the most advanced tossing precision across the longest distances yet.",
        "inspiration": "The ultimate mastery-level version of the classic 1970s water balloon toss.",
        "materials": ["Small water balloons", "Towels for drying off"],
        "steps": [
            "Pair up with a partner known for great catching hands.",
            "Start farther apart than any earlier round and toss gently.",
            "Step back after every catch, aiming for a new personal-best distance.",
            "Whichever pair reaches the greatest distance overall are the Toss Masters!",
        ],
        "safety_line": "Mastery is about technique, not force -- a soft, high arc is still the safest and most accurate toss.",
        "image_prompt": "An impressive illustration of two children very far apart tossing a water balloon in a beautiful high arc between them, sunny expansive lawn. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚲 Bike Rodeo Masters",
        "objective": "Practice the highest level of bike control across the most demanding rodeo course.",
        "inspiration": "The master-class bike rodeo format that capped off the best 1970s neighborhood bike skills events.",
        "materials": ["Bikes", "Cones for a demanding multi-station course", "A stopwatch or phone timer"],
        "steps": [
            "Set up a demanding course: a tight slalom, a slow-ride balance zone, and a precise figure-eight.",
            "Complete the full course with as few mistakes as possible, timed from start to finish.",
            "Deduct time bonuses are earned for a perfectly clean run.",
            "The best time with a clean run earns the Bike Rodeo Master title!",
        ],
        "safety_line": "Always wear a helmet -- mastery means control at every speed, not just going fast.",
        "image_prompt": "An impressive illustration of a skilled child rider navigating a demanding multi-station bike course with precision, helmet on, small crowd of admiring friends. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Spud Masters League",
        "objective": "Practice the most advanced group strategy and awareness across an ongoing league format.",
        "inspiration": "A league-format version of the classic 1970s playground game Spud, for a big group.",
        "materials": ["1 soft, lightweight ball"],
        "steps": [
            "Play Spud across several 'seasons' (sets of 10 rounds), tracking each player's tap count per season.",
            "Compare results across seasons to see who consistently avoids taps.",
            "Rotate ball-tossers fairly across every season.",
            "Crown the player with the best overall record the Spud League Champion!",
        ],
        "safety_line": "League play is still about smart scattering, not rough contact -- gentle taps always.",
        "image_prompt": "A festive league-day illustration of a large group of children mid-round of Spud, with a simple multi-season scoreboard nearby tracking results. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛹 Skateboard Trick Masters",
        "objective": "Practice combining slalom control with a simple, safe trick for the ultimate skateboarding showcase.",
        "inspiration": "The trick-combo showcases that top 1970s skateboarders were known for.",
        "materials": ["A skateboard", "A helmet", "Cones", "A flat, smooth surface"],
        "steps": [
            "Ride a slalom cone course smoothly from start to finish.",
            "At the end, attempt one simple trick you've mastered, like a controlled kick-turn.",
            "Combine your slalom time and trick success for an overall score.",
            "The best combined score earns the Skateboard Trick Master title!",
        ],
        "safety_line": "Always wear a helmet, and only attempt a trick you've already practiced safely many times.",
        "image_prompt": "An impressive illustration of a young skateboarder completing a smooth kick-turn at the end of a cone course, helmet on, small cheering audience. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚗 Big Wheel Grand Prix Masters",
        "objective": "Practice the ultimate combination of speed, cornering, and endurance across the longest Big Wheel race yet.",
        "inspiration": "The legendary multi-lap Big Wheel Grand Prix races that ended many epic 1970s summers.",
        "materials": ["Big Wheels or similar ride-on trikes, one per racer", "Cones marking a full multi-turn lap course"],
        "steps": [
            "Set up the longest lap course yet, with at least two turns per lap.",
            "Line up all racers and agree on the number of laps (start with 3).",
            "Race steadily, focusing on smooth cornering to avoid losing speed.",
            "First racer to complete all laps and cross the finish line is the Grand Prix Masters Champion!",
        ],
        "safety_line": "Longer races mean more focus, not more speed -- steady and controlled wins multi-lap races.",
        "image_prompt": "A grand, celebratory illustration of several children racing Big Wheels around a multi-turn course, a checkered finish line, cheering crowd, sunny summer day. Flat colorful children's-book illustration style, no text.",
    },
]


GRADE_TARGET_COUNT = 7


def esc(s):
    if s is None:
        return "NULL"
    return "N'" + str(s).replace("'", "''") + "'"


def build_prompt(game):
    materials = " | ".join(game["materials"])
    return (f"{game['name']}\n\n"
            f"70s Inspiration: {game['inspiration']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 83_outdoor_games_retro70s_batch1.sql")
    out.append("-- Extends the existing 'Outdoor Games' category (see 68/69/70/71/82) with")
    out.append("-- 7 more games per grade (42 -> 49), introducing a 1970s-retro theme:")
    out.append("-- pogo sticks, kite flying, water balloon tosses, banana-bike rodeos,")
    out.append("-- 'Spud' (classic ball-calling game), early skateboarding, and Big Wheel")
    out.append("-- trike races. No branded/copyrighted characters -- traditional")
    out.append("-- public-domain activities and toy TYPES only, scaled by grade.")
    out.append("--")
    out.append("-- Appends to the SAME per-grade PacketCategories row with sort_order")
    out.append("-- continuing from 43. See gen_83_outdoor_games_retro70s_batch1.py.")
    out.append("")
    out.append("IF NOT EXISTS (")
    out.append("    SELECT 1 FROM dbo.PacketQuestions q")
    out.append("    JOIN dbo.PacketCategories c ON c.category_id = q.category_id")
    out.append("    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 43")
    out.append(")")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == GRADE_TARGET_COUNT, f"grade {grade_id} has {len(games)} games, expected {GRADE_TARGET_COUNT}"
        var = f"@cat_70s_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    SELECT {var} = category_id FROM dbo.PacketCategories "
            f"WHERE grade_id = {grade_id} AND category_name = 'Outdoor Games';"
        )
        for i, game in enumerate(games):
            sort_order = 43 + i
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


def emit_image_prompts_doc():
    out = []
    out.append("# Outdoor Games -- 1970s Retro Batch -- Illustrator / AI Image Prompts")
    out.append("")
    out.append("Reference doc only -- not stored in the app database. One detailed prompt")
    out.append("per game, organized by grade, for a future illustration pass.")
    out.append("")
    for grade_id in GRADE_IDS:
        out.append(f"## {GRADE_LABELS[grade_id]}")
        out.append("")
        for game in GAMES[grade_id]:
            out.append(f"### {game['name']}")
            out.append("")
            out.append(f"*70s Inspiration: {game['inspiration']}*")
            out.append("")
            out.append(game["image_prompt"])
            out.append("")
    return "\n".join(out)


def check_completeness():
    ok = True
    all_names = []
    for grade_id in GRADE_IDS:
        n = len(GAMES[grade_id])
        if n != GRADE_TARGET_COUNT:
            print(f"INCOMPLETE: grade {GRADE_LABELS[grade_id]} has {n} games, expected {GRADE_TARGET_COUNT}")
            ok = False
        names = [g["name"] for g in GAMES[grade_id]]
        if len(names) != len(set(names)):
            print(f"DUPLICATE within grade {GRADE_LABELS[grade_id]}: {[n for n in names if names.count(n) > 1]}")
            ok = False
        all_names.extend(names)
        for game in GAMES[grade_id]:
            for key in ("name", "inspiration", "objective", "materials", "steps", "safety_line", "image_prompt"):
                if key not in game or not game[key]:
                    print(f"MISSING '{key}' in grade {GRADE_LABELS[grade_id]} game {game.get('name')}")
                    ok = False
    if len(all_names) != len(set(all_names)):
        dupes = [n for n in all_names if all_names.count(n) > 1]
        print(f"DUPLICATE across grades: {set(dupes)}")
        ok = False
    return ok


if __name__ == "__main__":
    import sys
    if not check_completeness():
        sys.exit(1)
    total_games = sum(len(v) for v in GAMES.values())
    print(f"Grades: {len(GAMES)}, Total new games: {total_games}", file=sys.stderr)
    with open(r"D:\Project\www\littlescholarhub\lsh.database\83_outdoor_games_retro70s_batch1.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    with open(r"D:\Project\www\littlescholarhub\scratch_tmp\outdoor_games_retro70s_image_prompts.md", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_image_prompts_doc())
    print("Wrote 83_outdoor_games_retro70s_batch1.sql and image-prompts doc", file=sys.stderr)
