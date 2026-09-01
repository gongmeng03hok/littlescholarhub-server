# -*- coding: utf-8 -*-
"""
Generates lsh.database/84_outdoor_games_retro90s_batch1.sql -- extends the
existing 'Outdoor Games' category (see 68/69/70/71/82/83) with 7 MORE
games per grade (49 -> 56 per grade, 56 new games), introducing a
1990s-retro theme built around toys and activities that defined that
decade's outdoor/recess play: inline skating (rollerblades), Super Soaker
water gun duels, Grounders (the playground-equipment tag game), Manhunt /
Flashlight Tag, kick scooters, homemade chalk "Twister," and yo-yo tricks.
No branded/copyrighted characters -- traditional public-domain activities
and toy TYPES only, scaled by grade, with safety-conscious framing on the
wheeled/water/dusk ones (helmets, supervision, boundaries, gentle contact).
Checked against all 392 existing Outdoor Games names for collisions
(none found) before writing content.

Same structural fields and prompt format as prior retro batches (name,
inspiration, objective, materials, steps, safety_line, image_prompt),
appended to the same per-grade Outdoor Games category row, sort_order
continuing from 50.

Also emits outdoor_games_retro90s_image_prompts.md (reference doc only,
not stored in the DB).

Run with: python gen_84_outdoor_games_retro90s_batch1.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🛼 Rollerblade Wobble Walk",
        "objective": "Practice standing and taking small careful steps while wearing inline skates.",
        "inspiration": "A gentle first step toward the inline-skating craze that rolled through the 1990s.",
        "materials": ["Inline skates (rollerblades)", "Knee and elbow pads if you have them", "A grown-up spotter"],
        "steps": [
            "Put on the skates and stand still first, getting used to the feel.",
            "Hold a grown-up's hand or a railing for the first few steps.",
            "Take small, careful rolling steps forward, one foot at a time.",
            "Once you feel steady, try letting go for just a few seconds!",
        ],
        "safety_line": "Always skate with a grown-up nearby, and wear a helmet and pads if you have them.",
        "image_prompt": "A sweet illustration of a young child wearing colorful inline skates, holding an adult's hand for balance while taking a careful step on a smooth sidewalk, big concentrated smile. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Gentle Squirt",
        "objective": "Practice aiming a small water gun at a target with control.",
        "inspiration": "A calm introduction to the water-gun water fights that soaked 1990s summer backyards.",
        "materials": ["1 small water gun per child", "A bucket or target (a chalk circle on a fence works too)"],
        "steps": [
            "Fill the water gun with a grown-up's help.",
            "Stand a few steps back from the target.",
            "Squeeze gently and aim for the target, not at friends.",
            "Refill and try again -- see if you can hit the target three times in a row!",
        ],
        "safety_line": "Only aim at targets, never at faces, and always squirt gently.",
        "image_prompt": "A cheerful illustration of a young child aiming a small colorful water gun at a chalk target drawn on a fence, sunny backyard, water droplets sparkling. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Gentle Version",
        "objective": "Practice climbing onto and staying on playground equipment quickly and safely.",
        "inspiration": "A slowed-down version of the classic 1990s recess game Grounders.",
        "materials": ["A low platform, step, or playground structure", "A grown-up to call out"],
        "steps": [
            "Everyone starts standing on the ground near a low platform or step.",
            "A grown-up calls 'Grounders!' as a signal.",
            "Everyone walks (not runs) to climb onto the platform so their feet are off the ground.",
            "Once everyone is safely up, celebrate together and try again from a different spot!",
        ],
        "safety_line": "Walk, don't run, to the platform, and only climb equipment made for climbing.",
        "image_prompt": "A cheerful illustration of a few young children calmly climbing onto a low wooden platform in a backyard, smiling, grassy setting. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Flashlight Freeze",
        "objective": "Practice freezing in place the instant a flashlight beam touches you.",
        "inspiration": "A gentle, early-evening version of the flashlight tag games that lit up 1990s neighborhoods.",
        "materials": ["1 flashlight", "A small, safe yard at dusk"],
        "steps": [
            "One player holds the flashlight and stands in the middle.",
            "Everyone else walks slowly around a small safe area.",
            "When the flashlight beam touches you, freeze in place like a statue.",
            "Once everyone is frozen, pick a new flashlight holder and start again!",
        ],
        "safety_line": "Play only in a small, safe, well-known yard with a grown-up watching nearby.",
        "image_prompt": "A gentle dusk illustration of a small child holding a flashlight beam onto a friend who freezes mid-step with a big smile, warm twilight colors in a backyard. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Wobble Walk",
        "objective": "Practice standing on a kick scooter and taking small pushes while holding the handlebars.",
        "inspiration": "A gentle first step toward the kick-scooter craze that took off in the late 1990s.",
        "materials": ["A kick scooter (2-wheeled push scooter)", "A helmet", "A flat, open surface"],
        "steps": [
            "Stand with one foot on the scooter deck and hold the handlebars.",
            "Push off gently with your other foot, just a little bit.",
            "Practice standing steady as the scooter rolls a short distance.",
            "Try it again, pushing off a little more each time!",
        ],
        "safety_line": "Always wear a helmet, and practice on a flat surface away from traffic.",
        "image_prompt": "A charming illustration of a young child standing on a colorful kick scooter, one foot pushing gently, wearing a helmet, sunny driveway. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Dot Hop",
        "objective": "Practice hopping carefully from one colored chalk dot to another.",
        "inspiration": "A simple warm-up for the homemade chalk 'Twister' games inspired by the classic board game's 1990s popularity.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw 4-5 big colored dots spread out on the pavement.",
            "Stand on one dot to start.",
            "Hop carefully to a different colored dot when a grown-up calls a color.",
            "Keep hopping to new dots each time a color is called!",
        ],
        "safety_line": "Hop carefully and land with both feet steady before hopping again.",
        "image_prompt": "A playful bird's-eye illustration of a young child hopping between several large colorful chalk dots drawn on gray pavement, arms out for balance. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Gentle Swing",
        "objective": "Practice a simple up-and-down yo-yo motion to build hand coordination.",
        "inspiration": "A gentle introduction to the yo-yo tricks that were a huge 1990s playground obsession.",
        "materials": ["1 yo-yo (a beginner, non-string-lock style works best)"],
        "steps": [
            "Loop the yo-yo string securely around one finger with a grown-up's help.",
            "Let the yo-yo drop gently downward.",
            "Give a small upward tug to bring it back to your hand.",
            "Practice a few times, catching it gently each time!",
        ],
        "safety_line": "Swing gently and keep the yo-yo away from your face and from other people.",
        "image_prompt": "A sweet illustration of a young child holding a colorful yo-yo mid-swing, focused and happy expression, sunny backyard. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[1] = [
    {
        "name": "🛼 Rollerblade First Glide",
        "objective": "Practice a short, steady glide on inline skates with light support.",
        "inspiration": "The inline-skating boom that rolled onto nearly every 1990s sidewalk.",
        "materials": ["Inline skates (rollerblades)", "A helmet and pads", "A grown-up spotter"],
        "steps": [
            "Put on skates, helmet, and pads, then stand on a flat, smooth surface.",
            "Hold a grown-up's hand for the first push forward.",
            "Glide a short distance, keeping your knees slightly bent.",
            "Practice stopping by dragging the heel brake or holding a grown-up's hand.",
        ],
        "safety_line": "Always wear a helmet and pads, and skate only with a grown-up nearby.",
        "image_prompt": "A cheerful illustration of a young child gliding a short distance on inline skates while holding a grown-up's hand, helmet and pads visible, smooth sidewalk. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Target Practice",
        "objective": "Practice aiming accurately at multiple targets from a set distance.",
        "inspiration": "The Super Soaker water-gun craze that defined 1990s summer play.",
        "materials": ["1 water gun per child", "2-3 targets (chalk circles or plastic cups on a fence)"],
        "steps": [
            "Set up 2-3 targets at different heights on a fence or wall.",
            "Stand at a marked line a few steps back.",
            "Take turns aiming and squirting at each target.",
            "See how many targets you can hit in a row!",
        ],
        "safety_line": "Only aim at targets, never at people's faces, and stay behind the marked line.",
        "image_prompt": "A cheerful illustration of a child aiming a colorful water gun at several plastic cups lined up on a fence, sunny backyard, water spray visible. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Basics",
        "objective": "Practice quick reactions to climb onto safe equipment when a signal is called.",
        "inspiration": "The classic 1990s recess game where touching the ground means you're caught.",
        "materials": ["Playground equipment (platforms, steps, a low wall)", "A grown-up to be 'It'"],
        "steps": [
            "One player is 'It' and closes their eyes, counting to 10.",
            "Everyone else spreads out near different pieces of safe equipment.",
            "When 'It' calls 'Grounders!', everyone must get off the ground onto equipment.",
            "'It' opens their eyes and looks for anyone still touching the ground -- that player helps count next time!",
        ],
        "safety_line": "Only climb on equipment made for climbing, and move carefully, not recklessly.",
        "image_prompt": "A lively illustration of several children scrambling to climb onto a low playground platform after hearing a signal, playful energy, sunny playground. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Flashlight Tag Basics",
        "objective": "Practice quiet movement and quick tagging using a flashlight beam as the 'tag.'",
        "inspiration": "The classic evening flashlight tag that lit up 1990s cul-de-sacs after dinner.",
        "materials": ["1-2 flashlights", "A safe, agreed-upon yard at dusk", "A grown-up to supervise"],
        "steps": [
            "One player holds a flashlight and is 'It.'",
            "Everyone else moves around the yard, staying within the agreed boundary.",
            "If the flashlight beam touches you, you're tagged and become the next 'It.'",
            "Play until everyone has had a turn holding the flashlight!",
        ],
        "safety_line": "Stay within a clear, well-lit boundary and always play with a grown-up nearby.",
        "image_prompt": "A warm dusk illustration of children moving around a backyard while one shines a flashlight beam toward a friend, cozy twilight colors, porch light glowing. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter First Glide",
        "objective": "Practice a longer, steady glide on a kick scooter while staying balanced.",
        "inspiration": "The kick-scooter craze that rolled through neighborhoods in the late 1990s.",
        "materials": ["A kick scooter", "A helmet", "A flat, smooth surface"],
        "steps": [
            "Stand on the scooter with both hands on the handlebars.",
            "Push off with one foot a few times to build a steady glide.",
            "Keep your eyes up and knees slightly bent while gliding.",
            "Practice stopping smoothly by stepping your foot down gently.",
        ],
        "safety_line": "Always wear a helmet, and scoot only on flat ground away from traffic.",
        "image_prompt": "A fun illustration of a young child gliding confidently on a kick scooter with a helmet on, along a smooth sidewalk, sunny day. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Basics",
        "objective": "Practice placing hands and feet on different colored chalk dots without falling over.",
        "inspiration": "A homemade, chalk-drawn version of the classic Twister board game, popular at 1990s block parties.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw a grid of colored dots (red, blue, yellow, green) on the pavement.",
            "A caller shouts out a body part and color, like 'left hand, blue!'",
            "Move that hand or foot to a dot of that color without moving your other limbs.",
            "Keep going until someone gently loses their balance -- then start a new round!",
        ],
        "safety_line": "Play on a soft or grassy area if possible, and it's okay to laugh and fall down safely.",
        "image_prompt": "A playful illustration of a young child stretching to place a hand on a colorful chalk dot while balancing on the others, sunny pavement grid. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Basics",
        "objective": "Practice the basic 'sleeper' motion where the yo-yo spins at the bottom of the string before returning.",
        "inspiration": "The classic first real yo-yo skill that every 1990s yo-yo fan learned.",
        "materials": ["1 yo-yo"],
        "steps": [
            "Throw the yo-yo down gently with a slight snap of the wrist.",
            "Let it spin ('sleep') at the bottom of the string for a second.",
            "Give a small upward tug to make it climb back to your hand.",
            "Practice a few times to get the timing just right!",
        ],
        "safety_line": "Practice with space around you so the yo-yo doesn't bump into anyone.",
        "image_prompt": "A focused illustration of a young child watching their yo-yo spin at the bottom of its string, string taut, backyard setting. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[2] = [
    {
        "name": "🛼 Rollerblade Warm-Up",
        "objective": "Practice gliding, turning gently, and stopping with more confidence on inline skates.",
        "inspiration": "The inline-skating craze that had 1990s kids gliding down every smooth sidewalk.",
        "materials": ["Inline skates", "A helmet and pads"],
        "steps": [
            "Skate in a straight line for a short distance, building speed slowly.",
            "Practice a gentle wide turn by leaning slightly to one side.",
            "Use your heel brake or a controlled glide-to-stop to slow down.",
            "Repeat, trying to make your stops smoother each time!",
        ],
        "safety_line": "Always wear a helmet and pads, and skate on smooth ground away from traffic.",
        "image_prompt": "An energetic illustration of a child confidently gliding and turning on inline skates along a smooth path, helmet and pads on, sunny park setting. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Duel Warm-Up",
        "objective": "Practice a friendly one-on-one water gun duel with clear, fair rules.",
        "inspiration": "The classic backyard Super Soaker duels that were a rite of summer in the 1990s.",
        "materials": ["2 water guns", "A dry-off towel for each player"],
        "steps": [
            "Two players stand a set distance apart, water guns ready.",
            "On 'go,' both try to squirt the other player's shirt first.",
            "First to get squirted on the shirt loses that round.",
            "Refill and switch who calls 'go' for the next round!",
        ],
        "safety_line": "Aim only at shirts and shoulders, never at faces, and agree on rules before starting.",
        "image_prompt": "A joyful illustration of two children in a friendly water gun duel on a sunny lawn, both mid-squirt with big grins, water arcs visible. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Challenge",
        "objective": "Practice quick decision-making about which equipment is safest and fastest to reach.",
        "inspiration": "The classic 1990s recess game, played with a slightly bigger play area for more challenge.",
        "materials": ["Multiple playground equipment pieces spread out", "A player to be 'It'"],
        "steps": [
            "Spread out across a bigger area with several pieces of safe equipment to choose from.",
            "'It' counts down loudly while everyone picks their target equipment.",
            "When 'It' calls 'Grounders!', race safely to get off the ground.",
            "Anyone still on the ground when 'It' opens their eyes helps call next round!",
        ],
        "safety_line": "Choose a nearby, safe piece of equipment rather than a far, risky sprint.",
        "image_prompt": "A dynamic illustration of children scattering across a playground toward different climbing structures after hearing a signal, energetic poses. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Flashlight Tag Challenge",
        "objective": "Practice strategic movement to avoid the flashlight beam across a slightly bigger play area.",
        "inspiration": "The classic evening flashlight tag game, played across a bigger, more exciting boundary.",
        "materials": ["1-2 flashlights", "A larger safe, agreed-upon yard at dusk", "A grown-up to supervise"],
        "steps": [
            "Mark out clear boundaries for the play area before starting.",
            "One player holds the flashlight and calls out when the game begins.",
            "Everyone else moves carefully, trying to avoid being lit up by the beam.",
            "Whoever is tagged by the beam becomes the next flashlight holder!",
        ],
        "safety_line": "Stick to the marked boundary, move at a walking pace in the dark, and always have a grown-up supervising.",
        "image_prompt": "A cozy dusk illustration of several children moving carefully around a larger yard while a flashlight beam sweeps nearby, warm twilight sky, porch lights glowing. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Slalom Challenge",
        "objective": "Practice steering a kick scooter smoothly around a simple row of cones.",
        "inspiration": "The kick-scooter tricks and courses that neighborhood kids invented in the late 1990s.",
        "materials": ["A kick scooter", "A helmet", "4-5 cones"],
        "steps": [
            "Set up 4-5 cones spaced evenly in a line.",
            "Scoot and steer gently around each cone one at a time.",
            "Keep your speed slow and controlled through the weave.",
            "Try the course again, aiming for smoother turns!",
        ],
        "safety_line": "Always wear a helmet, and slow down through turns rather than rushing.",
        "image_prompt": "A dynamic illustration of a child on a kick scooter weaving carefully between orange cones, helmet on, sunny driveway course. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Challenge",
        "objective": "Practice balancing across more limb positions as the calls get trickier.",
        "inspiration": "A leveled-up version of the homemade chalk Twister game, popular at 1990s summer parties.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw a bigger grid of colored dots than the basic version.",
            "A caller shouts out combinations like 'right foot green, left hand yellow.'",
            "Try to keep all four limbs on different dots without falling.",
            "Keep going until someone gently loses balance -- then reset for a new round!",
        ],
        "safety_line": "Play on soft or grassy ground, and always fall safely rather than fight to stay up.",
        "image_prompt": "A playful illustration of a child stretched across several colorful chalk dots in a twisted but balanced pose, friends laughing and watching nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Trick Challenge",
        "objective": "Practice a simple named trick, like 'Walk the Dog,' building on the basic sleeper motion.",
        "inspiration": "The trick-yo-yo skills that turned 1990s recess into a playground competition.",
        "materials": ["1 yo-yo"],
        "steps": [
            "Throw a strong sleeper so the yo-yo spins steadily at the bottom.",
            "Gently lower the spinning yo-yo to the ground so it 'walks' along.",
            "Give it a small tug to bring it back up into your hand.",
            "Practice a few times until you can do it smoothly!",
        ],
        "safety_line": "Practice this trick low to the ground and with space around your feet.",
        "image_prompt": "A fun illustration of a young child performing the 'walk the dog' yo-yo trick, yo-yo rolling along the pavement on its string, focused smile. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[3] = [
    {
        "name": "🛼 Rollerblade Challenge",
        "objective": "Practice combining speed, turning, and stopping in a short skating course.",
        "inspiration": "The inline-skating obstacle courses that neighborhood kids set up throughout the 1990s.",
        "materials": ["Inline skates", "A helmet and pads", "2-3 cones"],
        "steps": [
            "Set up 2-3 cones spaced out along a smooth path.",
            "Skate the path, weaving gently around each cone.",
            "Finish with a smooth, controlled stop.",
            "Try the course again, aiming for better control!",
        ],
        "safety_line": "Always wear a helmet and pads, and keep speed low enough to stay in control.",
        "image_prompt": "A dynamic illustration of a child on inline skates weaving around cones on a smooth path, helmet and pads on, confident expression. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Duel Challenge",
        "objective": "Practice quick reflexes and evasive movement in a best-of-3 water gun duel.",
        "inspiration": "The escalating Super Soaker duels that were a summer highlight for 1990s kids.",
        "materials": ["2 water guns", "Towels for drying off"],
        "steps": [
            "Two players face off a short distance apart, guns ready.",
            "On 'go,' both try to squirt the other's shirt while dodging.",
            "Whoever gets squirted first loses that round -- play best of 3!",
            "Refill water guns between rounds and switch starting positions.",
        ],
        "safety_line": "Aim only at shirts and shoulders, never faces, and agree on the play area boundaries first.",
        "image_prompt": "An energetic illustration of two children dodging and squirting water guns at each other in a backyard duel, water spraying, big smiles. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Teams",
        "objective": "Practice teamwork by helping teammates find safe equipment quickly.",
        "inspiration": "A team-based twist on the classic 1990s recess game Grounders.",
        "materials": ["Multiple playground equipment pieces", "A player or two to be 'It'"],
        "steps": [
            "Split into small teams, each responsible for reaching a different piece of equipment.",
            "One or two players are 'It' and count down loudly.",
            "When 'Grounders!' is called, teams help each other get safely off the ground.",
            "Any team with all members safely up scores a point for that round!",
        ],
        "safety_line": "Helping a teammate means guiding them safely, not pulling or pushing.",
        "image_prompt": "A team-spirited illustration of small groups of children helping each other climb onto playground equipment, cheerful cooperation, sunny playground. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Manhunt Teams",
        "objective": "Practice team-based hiding and searching strategy in a larger evening game.",
        "inspiration": "Manhunt, the large-scale hide-and-seek/tag game that took over 1990s neighborhood evenings.",
        "materials": ["1-2 flashlights", "A larger safe, agreed-upon area at dusk", "A grown-up to supervise"],
        "steps": [
            "Split into a 'hunter' team with flashlights and a 'hider' team.",
            "Hiders spread out and hide within the agreed boundary while hunters count.",
            "Hunters search together, using flashlights to spot hiders.",
            "A hider is caught when the flashlight beam finds them and calls their name -- switch team roles next round!",
        ],
        "safety_line": "Stay within the clearly marked boundary, walk (don't run) in the dark, and always have a grown-up nearby.",
        "image_prompt": "An exciting dusk illustration of a group of children searching together with flashlights while others hide behind trees and bushes, warm twilight colors. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Cone Course",
        "objective": "Practice a full scooter course combining straight pushes and careful weaving.",
        "inspiration": "The backyard scooter courses that late-1990s kids built with whatever cones they had.",
        "materials": ["A kick scooter", "A helmet", "5-6 cones"],
        "steps": [
            "Set up a course with a straight stretch and a weaving section.",
            "Push and glide the straight section, then carefully weave through the cones.",
            "Finish with a smooth, controlled stop.",
            "Run the course again, aiming for one continuous smooth ride!",
        ],
        "safety_line": "Always wear a helmet, and choose control over speed through the weave.",
        "image_prompt": "A dynamic illustration of a child on a kick scooter completing a straight glide then weaving through cones, helmet on, sunny course. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Teams",
        "objective": "Practice teamwork by taking turns calling moves for a partner's chalk Twister round.",
        "inspiration": "A team-based twist on the homemade chalk Twister game popular at 1990s summer parties.",
        "materials": ["Playground chalk"],
        "steps": [
            "Pair up, with one partner playing and one partner calling out moves.",
            "The caller announces a hand or foot and a color for their partner to reach.",
            "Switch roles after each round so everyone gets a turn playing.",
            "See which pair can keep their player balanced the longest!",
        ],
        "safety_line": "Play on soft or grassy ground, and it's okay to fall safely and laugh it off.",
        "image_prompt": "A fun illustration of one child calling out a move while their partner stretches carefully across colorful chalk dots, teamwork and laughter, sunny pavement. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Around the World",
        "objective": "Practice the classic 'Around the World' trick, swinging the yo-yo in a full circle.",
        "inspiration": "One of the most iconic yo-yo tricks that every serious 1990s yo-yo kid learned to show off.",
        "materials": ["1 yo-yo"],
        "steps": [
            "Throw a strong sleeper so the yo-yo spins steadily.",
            "Swing your arm out to the side, letting the spinning yo-yo circle around.",
            "Guide it in a full circle back to where it started.",
            "Catch it by giving a small tug to bring it back to your hand!",
        ],
        "safety_line": "Practice this trick with LOTS of open space around you, away from other people.",
        "image_prompt": "An exciting illustration of a child mid-swing performing the 'Around the World' yo-yo trick, the yo-yo tracing a wide circular arc, open backyard space. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[4] = [
    {
        "name": "🛼 Rollerblade Slalom Course",
        "objective": "Practice weaving smoothly through a tighter row of cones while inline skating.",
        "inspiration": "The slalom skating that advanced 1990s inline skaters showed off on smooth pavement.",
        "materials": ["Inline skates", "A helmet and pads", "5-6 closely spaced cones"],
        "steps": [
            "Set up 5-6 cones spaced closer together than a basic course.",
            "Skate through the course, weaving side to side with small, controlled turns.",
            "Keep your knees bent and weight centered as you weave.",
            "Try the course again, aiming for smoother, quicker turns!",
        ],
        "safety_line": "Always wear a helmet and pads, and slow down rather than rush through tight turns.",
        "image_prompt": "A dynamic illustration of a child on inline skates weaving tightly through a row of cones, helmet and pads on, focused expression. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Team Duel",
        "objective": "Practice team coordination and strategy in a small-group water gun battle.",
        "inspiration": "The team water fights that turned 1990s backyard parties into all-out Super Soaker battles.",
        "materials": ["Water guns, one per player", "A marked play area", "Towels for drying off"],
        "steps": [
            "Split into two small teams within a marked play area.",
            "On 'go,' teams try to squirt every member of the other team's shirt.",
            "Once squirted, a player sits out until the round ends.",
            "The last team with a dry player standing wins the round!",
        ],
        "safety_line": "Aim only at shirts and shoulders, never faces, and stay within the marked area.",
        "image_prompt": "An action-packed illustration of two small teams of children battling with water guns across a marked backyard area, water spraying everywhere, joyful chaos. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Strategy",
        "objective": "Practice scanning the whole play area quickly to pick the smartest safe spot.",
        "inspiration": "A strategy-focused twist on the classic 1990s recess game Grounders.",
        "materials": ["Multiple playground equipment pieces spread widely", "A player to be 'It'"],
        "steps": [
            "Before the round starts, take a moment to plan which equipment is closest to you.",
            "'It' counts down while everyone gets into position nearby (but not touching) their target.",
            "When 'Grounders!' is called, move quickly and safely to your planned spot.",
            "Compare strategies afterward -- who picked the smartest spot?",
        ],
        "safety_line": "A smart, nearby choice beats a risky sprint to a far piece of equipment.",
        "image_prompt": "A thoughtful yet playful illustration of children eyeing different pieces of playground equipment, planning their move, sunny playground scene. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Manhunt Strategy",
        "objective": "Practice advanced hiding strategy and quiet communication as a hider team.",
        "inspiration": "The strategic side of Manhunt that made 1990s evening games last for hours.",
        "materials": ["1-2 flashlights", "A larger safe, agreed-upon area at dusk", "A grown-up to supervise"],
        "steps": [
            "As a hider team, plan hiding spots that are close together for quiet communication.",
            "Hide quietly while hunters search with flashlights.",
            "Use quiet signals (like a soft whistle) to warn teammates if hunters are close.",
            "See how long your hider team can avoid being fully caught!",
        ],
        "safety_line": "Stay within the clearly marked, well-known boundary, and always have a grown-up supervising.",
        "image_prompt": "An atmospheric dusk illustration of a group of children hiding quietly together behind a bush while a flashlight beam sweeps nearby, warm twilight colors. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Trick Practice",
        "objective": "Practice a simple, safe scooter trick, like a controlled hop over a low line.",
        "inspiration": "The scooter tricks that adventurous kids started experimenting with as the craze grew in the late 1990s.",
        "materials": ["A kick scooter", "A helmet", "A piece of chalk or a low, soft obstacle"],
        "steps": [
            "Draw a chalk line or place a very low, soft obstacle on flat ground.",
            "Build a little speed in a straight line toward it.",
            "Give a small hop with both feet as you cross the line.",
            "Land steady and keep rolling -- practice a few times to smooth it out!",
        ],
        "safety_line": "Always wear a helmet, and only attempt tricks on flat, obstacle-free ground.",
        "image_prompt": "A fun illustration of a child mid-hop on a kick scooter over a chalk line, helmet on, confident expression, sunny driveway. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Speed Round",
        "objective": "Practice quick, accurate moves as the calls come faster in a timed round.",
        "inspiration": "A faster-paced version of the homemade chalk Twister game popular at 1990s summer parties.",
        "materials": ["Playground chalk", "A stopwatch or phone timer"],
        "steps": [
            "Draw the color-dot grid and set a timer for 60 seconds.",
            "The caller shouts moves as quickly as they can think of them.",
            "The player tries to follow every call without losing balance before time runs out.",
            "See how many calls you can complete in the time limit!",
        ],
        "safety_line": "Speed is fun, but balance comes first -- it's okay to slow down if needed.",
        "image_prompt": "An energetic illustration of a child quickly reaching for a chalk dot mid-call, a stopwatch visible nearby, playful urgency, sunny pavement. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Walk the Dog Challenge",
        "objective": "Practice combining the 'Walk the Dog' trick with a longer walking distance for extra challenge.",
        "inspiration": "The showcase yo-yo tricks that turned 1990s playgrounds into friendly competitions.",
        "materials": ["1 yo-yo"],
        "steps": [
            "Throw a strong, steady sleeper.",
            "Lower the spinning yo-yo to the ground so it rolls along like a little dog.",
            "Walk forward slowly, guiding the yo-yo along the ground beside you.",
            "See how far you can 'walk the dog' before bringing it back up!",
        ],
        "safety_line": "Practice on smooth, flat ground with plenty of space and no tripping hazards.",
        "image_prompt": "A cheerful illustration of a child walking slowly while their yo-yo rolls along the pavement beside them like a little dog on a leash. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[5] = [
    {
        "name": "🛼 Rollerblade Trick Practice",
        "objective": "Practice a simple, safe skating trick, like a one-foot glide, building on solid slalom skills.",
        "inspiration": "The trick skating that advanced 1990s inline skaters practiced at the skate park or driveway.",
        "materials": ["Inline skates", "A helmet and pads", "A flat, smooth surface"],
        "steps": [
            "Build up a steady, comfortable speed in a straight line.",
            "Lift one skate slightly off the ground, balancing on the other.",
            "Glide on one foot for a few seconds before setting the lifted foot back down.",
            "Practice on both feet to build balance evenly!",
        ],
        "safety_line": "Always wear a helmet and pads, and only try one-foot glides once your two-foot skating is solid.",
        "image_prompt": "A skillful illustration of a child gliding on one inline skate with the other leg lifted slightly, arms out for balance, helmet and pads on. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Strategy Battle",
        "objective": "Practice using cover and timing strategically in a bigger team water gun battle.",
        "inspiration": "The elaborate backyard water-gun battles with hiding spots and strategy that defined 1990s summers.",
        "materials": ["Water guns, one per player", "A marked play area with some hiding spots (bushes, chairs)", "Towels for drying off"],
        "steps": [
            "Split into two teams within a marked area that includes a few safe hiding spots.",
            "Teams plan a quick strategy: who advances, who guards a spot.",
            "On 'go,' battle to squirt every player on the other team.",
            "The last team with a dry player wins -- then swap strategies and play again!",
        ],
        "safety_line": "Aim only at shirts and shoulders, never faces, and keep hiding spots safe (no climbing).",
        "image_prompt": "A dynamic illustration of two teams of children using bushes and chairs as cover during a strategic water gun battle, water spraying, exciting energy. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Championship",
        "objective": "Practice consistent quick reactions across a full multi-round Grounders tournament.",
        "inspiration": "A championship-format version of the classic 1990s recess game Grounders.",
        "materials": ["Multiple playground equipment pieces", "Players rotating as 'It'"],
        "steps": [
            "Play several rounds, rotating who is 'It' each time.",
            "Keep a simple tally of how many times each player is caught on the ground.",
            "After all rounds, add up who was caught the fewest times.",
            "That player is the Grounders Champion!",
        ],
        "safety_line": "Championship excitement is still no excuse for reckless climbing -- safety first, every round.",
        "image_prompt": "An exciting illustration of a group of children scrambling onto playground equipment during a championship round, a simple tally chart nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Manhunt Championship",
        "objective": "Practice peak strategic hiding and searching skill across a multi-round Manhunt tournament.",
        "inspiration": "A championship-format version of Manhunt, the epic evening game of 1990s neighborhoods.",
        "materials": ["1-2 flashlights", "A larger safe, agreed-upon area at dusk", "A grown-up to supervise"],
        "steps": [
            "Play several rounds, swapping hunter and hider teams each time.",
            "Time how long each hider team can avoid being fully caught.",
            "Track the longest survival time across all rounds.",
            "The team with the longest survival time is the Manhunt Champion!",
        ],
        "safety_line": "Stay within the clearly marked boundary at all times, and always play with a grown-up supervising.",
        "image_prompt": "An exciting dusk illustration of children celebrating a long round of Manhunt, flashlights and warm porch lights glowing, twilight sky. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Slalom Championship",
        "objective": "Practice consistent slalom weaving across a full timed head-to-head tournament.",
        "inspiration": "A championship-format version of the kick-scooter slalom courses popular in the late 1990s.",
        "materials": ["A kick scooter", "A helmet", "Cones", "A stopwatch or phone timer"],
        "steps": [
            "Set up a standard slalom cone course and time each rider's run.",
            "Run several heats, keeping track of everyone's best time.",
            "The rider with the fastest clean run (no missed cones) wins the round.",
            "Try again to see if you can beat your own best time!",
        ],
        "safety_line": "Always wear a helmet, and a slower clean run beats a fast one that clips a cone.",
        "image_prompt": "An exciting illustration of a child racing through a slalom cone course on a kick scooter with a helmet, a stopwatch and small crowd of friends watching. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Championship",
        "objective": "Practice peak balance and flexibility across a multi-round elimination Twister tournament.",
        "inspiration": "A championship-format version of the homemade chalk Twister game.",
        "materials": ["Playground chalk"],
        "steps": [
            "Draw a color-dot grid big enough for 2-3 players at once.",
            "Play rounds where whoever falls or loses balance first is out.",
            "Continue until one player remains standing after a full round of calls.",
            "That player is the Chalk Twister Champion!",
        ],
        "safety_line": "Play on soft or grassy ground, and always fall safely rather than fight to stay up.",
        "image_prompt": "A lively illustration of two or three children stretched across a shared grid of colorful chalk dots, one gently losing balance while others hold steady, playful competition. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Championship",
        "objective": "Practice performing a sequence of tricks smoothly for a friendly judged competition.",
        "inspiration": "The playground yo-yo competitions that were the ultimate showcase of 1990s trick skills.",
        "materials": ["1 yo-yo per competitor"],
        "steps": [
            "Each competitor performs 3 tricks in a row: sleeper, walk the dog, and around the world.",
            "Friends or a grown-up judge smoothness and control, not just difficulty.",
            "Give each competitor a score out of 10 for their sequence.",
            "The highest combined score wins the Yo-Yo Championship!",
        ],
        "safety_line": "Always leave plenty of space around each performer, especially during Around the World.",
        "image_prompt": "A festive illustration of a child performing a yo-yo trick sequence in front of friends acting as judges, cheerful competitive energy, sunny backyard. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[6] = [
    {
        "name": "🛼 Rollerblade Championship",
        "objective": "Practice peak slalom speed and control across a full timed skating competition.",
        "inspiration": "A championship-format version of the inline-skating slalom courses from the 1990s.",
        "materials": ["Inline skates", "A helmet and pads", "Cones", "A stopwatch or phone timer"],
        "steps": [
            "Set up a full slalom course and time each skater's run.",
            "Run several heats, tracking everyone's best clean time.",
            "A missed cone adds a time penalty to that run.",
            "The fastest clean time overall is crowned the Rollerblade Champion!",
        ],
        "safety_line": "Always wear a helmet and pads -- championship speed still needs championship control.",
        "image_prompt": "An exciting illustration of a skilled skater weaving through a slalom cone course on inline skates, helmet and pads on, small crowd cheering. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun Grand Battle",
        "objective": "Practice large-group strategy and teamwork in a full multi-team water gun tournament.",
        "inspiration": "The all-out neighborhood water wars that were the ultimate 1990s summer showdown.",
        "materials": ["Water guns, one per player", "A large marked play area", "Towels for drying off"],
        "steps": [
            "Split into 2-3 teams across a large marked play area with a few safe hiding spots.",
            "Each team plans a strategy before the battle begins.",
            "On 'go,' battle to squirt every player on the opposing teams.",
            "The last team with a dry player standing wins the Grand Battle!",
        ],
        "safety_line": "Aim only at shirts and shoulders, never faces, and keep the whole battle within the marked area.",
        "image_prompt": "A grand, joyful illustration of multiple teams of children in an all-out water gun battle across a large backyard, water spraying everywhere, energetic chaos. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Masters",
        "objective": "Practice mastery-level quick reactions across the most demanding Grounders format.",
        "inspiration": "The most advanced format of the classic 1990s recess game Grounders.",
        "materials": ["Multiple playground equipment pieces spread widely", "Players rotating as 'It'"],
        "steps": [
            "Play with a wider spread of equipment and a shorter countdown from 'It.'",
            "Rotate who is 'It' every round to keep it fair.",
            "Track who is never caught across an entire extended session.",
            "Whoever survives every round without being caught is the Grounders Master!",
        ],
        "safety_line": "A shorter countdown means moving quickly but always safely -- no risky jumps.",
        "image_prompt": "An intense but joyful illustration of children racing to climb onto scattered playground equipment during a fast-paced round, sunny playground. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Manhunt Masters",
        "objective": "Practice the most advanced hiding, searching, and communication strategy across a full Manhunt season.",
        "inspiration": "The master-level Manhunt games that became legendary in some 1990s neighborhoods.",
        "materials": ["1-2 flashlights", "A large, safe, agreed-upon area at dusk", "A grown-up to supervise"],
        "steps": [
            "Play a full 'season' of several Manhunt rounds across one evening, swapping teams each round.",
            "Track each team's survival time for every round.",
            "Add up total survival time across the whole season.",
            "The team with the best total survival time are the Manhunt Masters!",
        ],
        "safety_line": "A full evening of play means extra care with boundaries, lighting, and grown-up supervision throughout.",
        "image_prompt": "A magical dusk illustration of a large group of children playing an epic evening game of Manhunt, flashlights sweeping, warm twilight colors, porch lights glowing. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Slalom Masters",
        "objective": "Practice mastery-level scooter control across the toughest, most tightly spaced cone course.",
        "inspiration": "The most advanced scooter slalom format from the height of the late-1990s scooter craze.",
        "materials": ["A kick scooter", "A helmet", "8-10 closely spaced cones", "A stopwatch or phone timer"],
        "steps": [
            "Set up 8-10 cones spaced tighter than any earlier course.",
            "Ride the course focusing on tight, controlled weaving.",
            "Time your run and note if you cleanly avoided every cone.",
            "The fastest CLEAN run (no missed cones) is the Scooter Slalom Master!",
        ],
        "safety_line": "Always wear a helmet, and a slower clean run always beats a fast, sloppy one.",
        "image_prompt": "A dynamic illustration of a skilled young scooter rider weaving tightly through a dense row of cones, helmet on, small crowd watching. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Masters",
        "objective": "Practice the most demanding balance combinations in a mastery-level chalk Twister showdown.",
        "inspiration": "The ultimate mastery-level format of the homemade chalk Twister craze.",
        "materials": ["Playground chalk", "A stopwatch or phone timer"],
        "steps": [
            "Draw a large, dense grid of colored dots for maximum challenge.",
            "The caller gives rapid-fire combinations for a full 90 seconds.",
            "The player tries to follow every call without losing balance.",
            "Whoever lasts the longest without falling is the Chalk Twister Master!",
        ],
        "safety_line": "Play on soft or grassy ground, and always prioritize a safe fall over holding a pose too long.",
        "image_prompt": "An impressive illustration of a child in an extremely stretched but balanced pose across a dense grid of chalk dots, friends cheering nearby. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Masters",
        "objective": "Practice combining multiple tricks into one smooth, judged routine at the highest skill level.",
        "inspiration": "The showcase yo-yo routines that crowned the true yo-yo masters of the 1990s playground scene.",
        "materials": ["1 yo-yo per competitor"],
        "steps": [
            "Each competitor designs a routine combining at least 4 tricks in a row.",
            "Practice the transitions between tricks so the routine flows smoothly.",
            "Perform the routine for friends or a grown-up judge.",
            "The smoothest, most confident routine is crowned the Yo-Yo Master!",
        ],
        "safety_line": "Always leave plenty of open space, especially for tricks that swing the yo-yo out wide.",
        "image_prompt": "An impressive illustration of a child performing a confident, flowing yo-yo trick routine in front of an admiring small audience, sunny backyard stage feel. Flat colorful children's-book illustration style, no text.",
    },
]

GAMES[7] = [
    {
        "name": "🛼 Rollerblade Slalom Masters",
        "objective": "Practice the highest level of skating control combining slalom, one-foot glides, and stopping.",
        "inspiration": "The most advanced inline-skating showcase from the peak of the 1990s craze.",
        "materials": ["Inline skates", "A helmet and pads", "Cones", "A stopwatch or phone timer"],
        "steps": [
            "Ride a slalom course, then add a one-foot glide section, then finish with a precision stop.",
            "Time the full combined course.",
            "Deduct points for any missed cone or wobble during the one-foot section.",
            "The best combined time and control score wins the Slalom Masters title!",
        ],
        "safety_line": "Always wear a helmet and pads -- mastery means control at every speed, not just going fast.",
        "image_prompt": "An impressive illustration of a skilled skater combining a slalom weave with a one-foot glide, helmet and pads on, small cheering crowd. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Gun World Championship",
        "objective": "Practice the ultimate combination of strategy, teamwork, and accuracy in a grand water gun finale.",
        "inspiration": "The legendary all-day water gun tournaments that capped off epic 1990s summers.",
        "materials": ["Water guns, one per player", "A large marked play area with hiding spots", "Towels for drying off"],
        "steps": [
            "Run a full bracket tournament: several teams compete in elimination rounds.",
            "Each round follows standard team-battle rules until one team remains dry.",
            "Winning teams advance to the next round; losing teams cheer on the rest.",
            "The final remaining team is crowned the Water Gun World Champions!",
        ],
        "safety_line": "Bigger tournament, same rules: aim only at shirts and shoulders, never faces.",
        "image_prompt": "A grand, festive illustration of a large water gun tournament with a bracket chart, multiple teams battling across a big backyard, joyful splashing chaos. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛝 Grounders Grand Champion",
        "objective": "Practice the ultimate combination of speed, awareness, and safe climbing across an extended tournament.",
        "inspiration": "The grand-champion format of the classic 1990s recess game Grounders.",
        "materials": ["Multiple playground equipment pieces spread widely", "Players rotating as 'It'"],
        "steps": [
            "Play an extended tournament of many rounds, tracking every player's catch count.",
            "Rotate 'It' fairly so everyone gets equal turns.",
            "After the full tournament, total up who was caught the fewest times overall.",
            "That player earns the title of Grounders Grand Champion!",
        ],
        "safety_line": "An extended tournament means pacing yourself -- safety and stamina both matter.",
        "image_prompt": "A festive illustration of a large group of children finishing an epic Grounders tournament, a simple final scoreboard nearby, sunny playground. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔦 Manhunt Grand Finale",
        "objective": "Practice the ultimate combination of stealth, strategy, and teamwork in a climactic final round.",
        "inspiration": "The legendary season-ending Manhunt finales that neighborhood kids talked about for years.",
        "materials": ["1-2 flashlights", "The largest safe, agreed-upon area available at dusk", "Multiple grown-ups to supervise"],
        "steps": [
            "Bring together the two best-performing teams from earlier rounds for one final showdown.",
            "Play one long, decisive round with the biggest boundary used all season.",
            "Hunters and hiders both use everything they've learned all season.",
            "Whichever team wins this final round is crowned the Manhunt Grand Champions!",
        ],
        "safety_line": "The biggest game of the season needs the most supervision -- make sure grown-ups can see the whole boundary.",
        "image_prompt": "A dramatic, magical dusk illustration of a large final Manhunt showdown, flashlights sweeping across a big yard, warm twilight sky, excited children celebrating. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🛴 Scooter Grand Prix",
        "objective": "Practice combining slalom skill, speed, and a simple trick in one ultimate scooter showcase.",
        "inspiration": "The legendary end-of-summer scooter showcases that capped off the late-1990s scooter craze.",
        "materials": ["A kick scooter", "A helmet", "Cones", "A stopwatch or phone timer"],
        "steps": [
            "Ride a full slalom course, then a straight speed section, then finish with one simple safe trick.",
            "Time the whole combined course.",
            "Judge the trick separately for style and control.",
            "Combine time and trick score for the final Scooter Grand Prix ranking!",
        ],
        "safety_line": "Always wear a helmet, and only attempt the trick if it's one you've already mastered safely.",
        "image_prompt": "An exciting illustration of a scooter rider completing a slalom course before landing a simple trick, helmet on, cheering friends watching. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Chalk Twister Grand Champion",
        "objective": "Practice the ultimate balance and flexibility test across a multi-round elimination showdown.",
        "inspiration": "The grand-champion format of the homemade chalk Twister craze at its most competitive.",
        "materials": ["Playground chalk", "A stopwatch or phone timer"],
        "steps": [
            "Run a full elimination bracket: whoever falls first in each head-to-head match is out.",
            "Continue through the bracket until two finalists remain.",
            "Play one final head-to-head round between the finalists.",
            "The finalist who lasts longest is the Chalk Twister Grand Champion!",
        ],
        "safety_line": "Play on soft or grassy ground, and always choose a safe fall over pushing through discomfort.",
        "image_prompt": "A dramatic illustration of two finalists stretched across a shared grid of chalk dots in an intense final match, friends cheering all around. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪀 Yo-Yo Grand Masters",
        "objective": "Practice the ultimate trick routine, combining every skill learned into one polished final performance.",
        "inspiration": "The grand finale yo-yo showcases that crowned the true legends of the 1990s playground yo-yo scene.",
        "materials": ["1 yo-yo per competitor"],
        "steps": [
            "Each finalist designs a routine using every trick they've learned: sleeper, walk the dog, around the world, and one original move.",
            "Practice the full routine several times for smoothness.",
            "Perform for a small audience of friends and family.",
            "The routine that gets the biggest cheer is crowned the Yo-Yo Grand Masters champion!",
        ],
        "safety_line": "A bigger routine still needs plenty of open space, especially for wide swinging tricks.",
        "image_prompt": "A grand, celebratory illustration of a child performing a polished final yo-yo routine for an admiring audience, confetti-like joy, sunny backyard stage. Flat colorful children's-book illustration style, no text.",
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
            f"90s Inspiration: {game['inspiration']}\n\n"
            f"Objective: {game['objective']}\n\n"
            f"Materials: {materials}\n\n"
            f"Follow the steps below to play!")


def emit_sql():
    out = []
    out.append("-- 84_outdoor_games_retro90s_batch1.sql")
    out.append("-- Extends the existing 'Outdoor Games' category (see 68/69/70/71/82/83)")
    out.append("-- with 7 more games per grade (49 -> 56), introducing a 1990s-retro theme:")
    out.append("-- inline skating (rollerblades), Super Soaker water gun duels, Grounders,")
    out.append("-- Manhunt/Flashlight Tag, kick scooters, homemade chalk 'Twister,' and")
    out.append("-- yo-yo tricks. No branded/copyrighted characters -- traditional")
    out.append("-- public-domain activities and toy TYPES only, scaled by grade.")
    out.append("--")
    out.append("-- Appends to the SAME per-grade PacketCategories row with sort_order")
    out.append("-- continuing from 50. See gen_84_outdoor_games_retro90s_batch1.py.")
    out.append("")
    out.append("IF NOT EXISTS (")
    out.append("    SELECT 1 FROM dbo.PacketQuestions q")
    out.append("    JOIN dbo.PacketCategories c ON c.category_id = q.category_id")
    out.append("    WHERE c.category_name = 'Outdoor Games' AND c.grade_id = 0 AND q.sort_order = 50")
    out.append(")")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == GRADE_TARGET_COUNT, f"grade {grade_id} has {len(games)} games, expected {GRADE_TARGET_COUNT}"
        var = f"@cat_90s_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    SELECT {var} = category_id FROM dbo.PacketCategories "
            f"WHERE grade_id = {grade_id} AND category_name = 'Outdoor Games';"
        )
        for i, game in enumerate(games):
            sort_order = 50 + i
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
    out.append("# Outdoor Games -- 1990s Retro Batch -- Illustrator / AI Image Prompts")
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
            out.append(f"*90s Inspiration: {game['inspiration']}*")
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
    with open(r"D:\Project\www\littlescholarhub\lsh.database\84_outdoor_games_retro90s_batch1.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    with open(r"D:\Project\www\littlescholarhub\scratch_tmp\outdoor_games_retro90s_image_prompts.md", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_image_prompts_doc())
    print("Wrote 84_outdoor_games_retro90s_batch1.sql and image-prompts doc", file=sys.stderr)
