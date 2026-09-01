# -*- coding: utf-8 -*-
"""
Generates lsh.database/68_outdoor_games_content.sql — adds an "Outdoor
Games" category to the existing 'health' subject_area (always-on, no
schema/proc changes needed) for every grade TK-6. Each grade gets a pool
of 14 hand-crafted games; the existing rotation samples 7 of them (via
target_count=7, ORDER BY NEWID()) fresh each week a grade's health
category is picked, so consecutive weeks show a different set without
any manual "week 1 / week 2" authoring.

Also emits games_image_prompts.md — a companion reference doc (NOT stored
in the database, nothing in the app renders images today) with the
detailed illustrator/AI-image prompt for every game, organized by grade.

Run with: python gen_migration_68.py
"""
import json

GRADE_IDS = [0, 1, 2, 3, 4, 5, 6, 7]
GRADE_LABELS = ["TK", "K", "1st", "2nd", "3rd", "4th", "5th", "6th"]

# GAMES[grade_id] = list of 14 game dicts:
#   name, objective, materials (list[str]), steps (list[str]), safety_line, image_prompt
GAMES = {g: [] for g in GRADE_IDS}


GAMES[0] = [
    {
        "name": "🐸 Animal Walk Relay",
        "objective": "Practice moving like different animals while taking turns with friends.",
        "materials": ["2 cones or chairs (start/finish markers)", "Open grass area"],
        "steps": [
            "Grown-up sets 2 markers about 10 big steps apart.",
            "First player hops like a frog to the far marker.",
            "Next player waddles like a duck back to start.",
            "Take turns picking a new animal each round (bear crawl, bunny hop, crab walk).",
        ],
        "safety_line": "Walk (don't run) on grass, and take breaks whenever you feel tired.",
        "image_prompt": "A bright, friendly cartoon-style illustration of a grassy backyard with two orange cones about 10 steps apart marking 'start' and 'finish'. Three diverse young children (ages 4-5) are shown mid-action along the path between the cones: one hopping like a frog with hands on the ground, one waddling with arms tucked like duck wings, one crawling on hands and feet like a bear. Add small dotted-line footprint trails showing the path from start to finish. Sunny sky, simple background, big bold labels 'START' and 'FINISH' near each cone. Style: flat colorful children's-book illustration, no text other than the two labels.",
    },
    {
        "name": "🫧 Bubble Pop Dash",
        "objective": "Chase and pop bubbles to practice running, reaching, and having fun outside.",
        "materials": ["Bubble solution and wand (or bubble machine)"],
        "steps": [
            "A grown-up blows a big batch of bubbles into the air.",
            "Children run and pop as many bubbles as they can before they land.",
            "Count out loud together how many bubbles got popped.",
            "Repeat with a new batch of bubbles!",
        ],
        "safety_line": "Watch where you're running so you don't bump into a friend.",
        "image_prompt": "A cheerful outdoor scene with a grown-up blowing many soap bubbles from a bubble wand into the air above a grassy yard. Three young children (ages 4-5) are shown mid-jump reaching up with both hands to pop the floating bubbles, big smiles, joyful poses. Bubbles of varying sizes drawn as light blue translucent circles with a small highlight. Sunny background with a few clouds. Style: flat colorful children's-book illustration, no text.",
    },
    {
        "name": "🌈 Color Hunt Hop",
        "objective": "Find and hop to matching colors while exploring outside.",
        "materials": ["5-6 sheets of colored paper or chalk-drawn color circles", "Sidewalk chalk (optional)"],
        "steps": [
            "Grown-up places colored papers (or draws chalk circles) around the yard.",
            "Call out a color, like 'yellow!'",
            "Everyone hops to the matching colored spot.",
            "Take turns calling out the next color.",
        ],
        "safety_line": "Look before you hop so you land safely.",
        "image_prompt": "A top-down/bird's-eye view illustration of a driveway or yard with 6 large colored circles drawn in sidewalk chalk (red, blue, yellow, green, orange, purple), spaced apart in a loose scatter pattern. Three small cartoon children are shown mid-hop, each landing inside a different colored circle with one foot up in a hopping pose, arms out for balance. Bright cheerful colors, simple sunny background. Style: flat colorful children's-book illustration, no text.",
    },
    {
        "name": "🐾 Follow the Leader Trail",
        "objective": "Copy a leader's fun movements while walking along an outdoor path.",
        "materials": ["None — just open outdoor space"],
        "steps": [
            "One child (or grown-up) is picked as the Leader.",
            "The Leader walks a path and does a silly movement (tiptoe, big steps, spin, wave arms).",
            "Everyone else follows behind, copying exactly what the Leader does.",
            "After a few minutes, pick a new Leader.",
        ],
        "safety_line": "Leaders should pick movements that are safe to copy, like walking, not running fast.",
        "image_prompt": "A winding grassy path illustration shown from a slightly elevated angle. A cartoon child leads a line of 3 other children in a conga-line style, each copying a silly pose: leader mid-tiptoe with arms out, followed by kids also on tiptoe with arms out, all in a line following the curved path. Trees and bushes line the path. Bright, sunny, playful children's-book style illustration, no text.",
    },
    {
        "name": "👥 Shadow Tag",
        "objective": "Practice moving quickly and carefully while playing a gentle version of tag.",
        "materials": ["Sunny outdoor space (needs visible shadows)"],
        "steps": [
            "One player is 'It.'",
            "'It' tries to step on another player's shadow.",
            "If your shadow is stepped on, you become the new 'It.'",
            "Keep playing and taking turns being 'It.'",
        ],
        "safety_line": "Play in an open, flat area with no obstacles to trip on.",
        "image_prompt": "A sunny outdoor scene showing a child ('It', wearing a red shirt) reaching down with one foot to step onto the long cartoon shadow of another child who is running away. The shadows are drawn as soft gray silhouettes stretched across the pavement/grass, clearly connected to each child's feet. Bright midday sun icon in the corner. Simple flat children's-book illustration style, no text.",
    },
    {
        "name": "💃 Freeze Dance Outside",
        "objective": "Dance freely to music, then freeze completely still when the music stops.",
        "materials": ["Music player or phone with speaker"],
        "steps": [
            "Turn on fun music and dance around the yard.",
            "A grown-up pauses the music without warning.",
            "Everyone freezes in their silliest pose the moment the music stops.",
            "Turn the music back on and keep dancing!",
        ],
        "safety_line": "Dance in a space with room to move without bumping into anyone.",
        "image_prompt": "A joyful outdoor scene of 4 diverse young children frozen mid-dance-move in silly poses (one with arms up like a robot, one balanced on one foot, one mid-spin, one with a funny arm wave), all outside on grass with a portable speaker playing music nearby (shown with small music-note symbols floating above it). Bright, sunny, colorful flat children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Parachute Popcorn",
        "objective": "Work together to bounce a ball high using a shared parachute or blanket.",
        "materials": ["Play parachute or large lightweight blanket", "Soft foam ball or beanbag"],
        "steps": [
            "Everyone holds the edge of the parachute (or blanket) in a circle.",
            "Place a soft ball in the middle.",
            "Everyone shakes the parachute up and down together to bounce the 'popcorn' ball high.",
            "See how high you can bounce it without it falling off!",
        ],
        "safety_line": "Use a soft ball only, and keep a good grip on the parachute.",
        "image_prompt": "A circle of 5-6 diverse young children standing on grass, each holding the colorful edge of a round rainbow-striped play parachute stretched taut between them. A soft yellow foam ball is shown mid-bounce above the center of the parachute, with small motion lines indicating upward movement. All children have joyful expressions, arms raised mid-shake. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦆 Duck Duck Goose",
        "objective": "Practice quick reactions and taking turns in a classic circle game.",
        "materials": ["None — just a group and open grass"],
        "steps": [
            "Everyone sits in a circle facing inward.",
            "One player walks around the outside, tapping heads and saying 'duck' each time.",
            "On one head, they say 'goose!' instead.",
            "The 'goose' jumps up and chases the tapper around the circle back to the empty spot.",
        ],
        "safety_line": "Run around the OUTSIDE of the circle only, watching for friends sitting down.",
        "image_prompt": "A bird's-eye view illustration of 6 children sitting cross-legged in a circle on grass, facing inward. One child is shown standing and walking around the outside of the circle with a hand extended, tapping the head of a seated child who has an excited 'surprised' expression (this is the 'goose'). Motion lines show the goose about to jump up. Bright, cheerful, simple flat children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Rainbow Ring Toss",
        "objective": "Practice aiming and throwing rings onto colorful targets.",
        "materials": ["3-4 plastic rings or hula hoops", "1-2 traffic cones or bottles as targets"],
        "steps": [
            "Stand a cone or bottle upright as the target.",
            "Stand a few steps back (grown-up marks a line).",
            "Take turns tossing rings, trying to land them around the target.",
            "Count how many rings each person lands!",
        ],
        "safety_line": "Only toss rings — never throw them at people.",
        "image_prompt": "A simple outdoor illustration showing an orange traffic cone standing upright on grass as a target, with two colorful plastic rings (one red, one blue) mid-air flying toward it, and one ring already successfully landed around its base. A small child stands a few steps away in a throwing pose, one arm extended after releasing a ring. A chalk line on the ground marks the throwing spot. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🦁 Sleeping Lions",
        "objective": "Practice lying still and calm, like a resting lion, for as long as possible.",
        "materials": ["Soft grass or blanket to lie on"],
        "steps": [
            "Everyone lies down on the grass and pretends to be a sleeping lion.",
            "Stay as still and quiet as possible.",
            "A grown-up gently checks around — if you giggle or move too much, you're 'awake!'",
            "Whoever stays 'asleep' the longest wins a cheer from the group.",
        ],
        "safety_line": "Choose a soft, shaded, clean spot to lie down.",
        "image_prompt": "A peaceful outdoor illustration of 4 children lying down flat on a grassy lawn with their eyes closed, pretending to sleep like lions, some with hands tucked under their heads. One grown-up crouches nearby smiling gently, tiptoeing between them. Soft shade from a nearby tree. Calm, warm color palette, flat children's-book illustration style, no text.",
    },
    {
        "name": "🎈 Balloon Bounce Walk",
        "objective": "Practice balance and gentle movement while keeping a balloon in the air.",
        "materials": ["1 balloon per child"],
        "steps": [
            "Give each child a balloon.",
            "Walk around the yard while gently bouncing the balloon in the air.",
            "Try not to let your balloon touch the ground!",
            "See how far you can walk without dropping it.",
        ],
        "safety_line": "Walk carefully and watch for friends around you.",
        "image_prompt": "A cheerful outdoor scene showing 3 young children walking across grass, each gently patting a colorful balloon (red, yellow, blue) upward into the air above their heads with an open palm, mid-stride. Motion lines show the balloons bouncing. Bright sunny sky background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔍 Nature Scavenger Stroll",
        "objective": "Explore outside and find simple items from nature.",
        "materials": ["Simple picture list (leaf, rock, flower, stick, feather)"],
        "steps": [
            "Look at the picture list together with a grown-up.",
            "Walk around the yard or park looking for each item.",
            "Point to (or gently pick up) each item you find.",
            "Celebrate together when you find them all!",
        ],
        "safety_line": "Only touch plants and items a grown-up says are safe.",
        "image_prompt": "A friendly outdoor illustration of a young child crouching down in a garden path, pointing excitedly at a small pile of nature items on the ground (a leaf, a smooth rock, a small flower, a twig, a feather), each item clearly separated and visible. A grown-up stands nearby holding a simple picture checklist card showing icons of the same 5 items. Bright natural background with grass, small bushes, and a tree. Flat colorful children's-book illustration style, no text except small icon shapes on the checklist card.",
    },
    {
        "name": "👂 Simon Says Outside",
        "objective": "Practice listening carefully and following movement directions.",
        "materials": ["None — just open outdoor space"],
        "steps": [
            "One person is 'Simon' and gives movement directions.",
            "If Simon says 'Simon says jump!' — everyone jumps.",
            "If Simon just says 'jump!' (no 'Simon says') — don't move!",
            "Take turns being Simon.",
        ],
        "safety_line": "Choose safe movements like jumping, spinning slowly, or waving arms.",
        "image_prompt": "An outdoor illustration showing one child standing confidently in front, arms raised as if giving a command (this is 'Simon'), facing 3 other children who are all mid-jump with arms up and big smiles, following the direction. Sunny grassy background. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "⚽ Roll the Big Ball",
        "objective": "Practice rolling and catching a large, soft ball with a partner.",
        "materials": ["1 large soft ball (beach ball or exercise ball)"],
        "steps": [
            "Two players sit or stand facing each other, a few steps apart.",
            "One player rolls the ball to the other.",
            "Catch or stop the ball, then roll it back.",
            "Take a step back after every few rolls to make it a bit harder!",
        ],
        "safety_line": "Roll gently — don't throw the ball hard.",
        "image_prompt": "A simple outdoor illustration of two young children sitting on grass facing each other with legs spread in a V-shape, a large colorful striped beach ball rolling on the ground between them, motion lines showing it moving from one child toward the other. Both children have hands out ready to catch or push it. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[1] = [
    {
        "name": "🚦 Red Light, Green Light",
        "objective": "Practice starting, stopping, and listening carefully to directions.",
        "materials": ["None — just open grass space"],
        "steps": [
            "One player is the 'Stoplight' and stands at the finish line.",
            "Everyone else lines up at the starting line.",
            "When the Stoplight says 'Green light!' everyone walks forward.",
            "When the Stoplight says 'Red light!' everyone freezes instantly.",
            "First player to reach the Stoplight becomes the new Stoplight.",
        ],
        "safety_line": "Walk, don't run, so you can freeze safely on 'red light.'",
        "image_prompt": "An outdoor illustration showing a grassy field with a clear starting line (chalk line) on one side and a child standing at the far end holding up a hand like a traffic signal (the 'Stoplight'). Between them, 3 children are shown frozen mid-step in funny off-balance poses, arms out for balance, clearly stopped mid-motion. A red circle icon glows near the Stoplight child to represent 'red light.' Bright sunny flat children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Beanbag Toss Target",
        "objective": "Practice aiming and tossing beanbags into target zones.",
        "materials": ["3-4 beanbags", "Hula hoop or chalk-drawn target circles", "Sidewalk chalk (optional)"],
        "steps": [
            "Lay a hula hoop on the ground (or draw circles with chalk) a few steps away.",
            "Take turns tossing beanbags, trying to land them inside the circle.",
            "Count how many beanbags land inside.",
            "Try stepping back farther for a harder challenge!",
        ],
        "safety_line": "Only toss beanbags at the target — never at people.",
        "image_prompt": "A top-down outdoor illustration showing a bright hula hoop lying flat on grass as a target, with 2 beanbags already inside it and one beanbag shown mid-air flying toward it with a dotted arc line showing its path. A child stands a few steps away in a throwing pose. Bright, cheerful flat children's-book illustration style, no text.",
    },
    {
        "name": "🦒 Animal Charades Tag",
        "objective": "Act out animals while playing a gentle chasing game.",
        "materials": ["Index cards with animal pictures (optional)"],
        "steps": [
            "One player is 'It' and picks an animal to act like while chasing (e.g., a bear).",
            "Everyone else runs away, also moving like a different animal.",
            "When tagged, that player becomes 'It' and picks a new animal.",
            "Keep switching animals each round!",
        ],
        "safety_line": "Play in a wide open space with no obstacles to trip over.",
        "image_prompt": "A playful outdoor scene of a child moving in a 'bear crawl' pose (on hands and feet) chasing after two other children who are running while flapping their arms like birds and hopping like kangaroos. Bright grassy field background with a few trees. Fun, dynamic flat children's-book illustration style, no text.",
    },
    {
        "name": "🎡 Hula Hoop Hop",
        "objective": "Practice jumping and balance by hopping through a row of hoops.",
        "materials": ["5-6 hula hoops"],
        "steps": [
            "Lay hula hoops in a row on the ground, slightly apart.",
            "Hop from hoop to hoop, landing with both feet inside each one.",
            "Try to reach the end without stepping outside a hoop.",
            "Take turns and cheer each other on!",
        ],
        "safety_line": "Take your time — it's not a race, balance matters more than speed.",
        "image_prompt": "A top-down illustration of 5 colorful hula hoops laid out in a slightly curving row on green grass. A child is shown mid-hop with both feet together, landing inside the third hoop, arms out for balance, with small motion lines showing the hopping path from hoop to hoop. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🛍️ Sack Hop Race",
        "objective": "Practice jumping with both feet together in a fun hopping race.",
        "materials": ["1 pillowcase or sack per player", "2 cones (start/finish)"],
        "steps": [
            "Each player steps into a sack, holding the top edges with both hands.",
            "Line up at the start marker.",
            "On 'go,' hop forward toward the finish line inside your sack.",
            "First one to the finish wins — then race again!",
        ],
        "safety_line": "Hop on grass or soft ground, and go at a pace you can control.",
        "image_prompt": "A fun outdoor race illustration showing 3 children standing inside large cloth sacks that come up to their waists, holding the top edges with both hands, all mid-hop toward a finish line marked by an orange cone. Small motion lines under their feet show hopping movement. Bright sunny grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🫧 Bubble Wand Chase",
        "objective": "Chase, catch, and pop bubbles while running and jumping outside.",
        "materials": ["Bubble wand and solution"],
        "steps": [
            "A grown-up blows a big stream of bubbles.",
            "Children chase after the bubbles and try to catch or pop them.",
            "Try catching one gently on your finger without popping it!",
            "Blow a new batch and keep playing.",
        ],
        "safety_line": "Watch where you run so you don't bump into friends or furniture.",
        "image_prompt": "A joyful outdoor scene with a stream of soap bubbles floating across a sunny yard from a bubble wand held by an adult. Two children are shown mid-run reaching up to catch bubbles, one balancing a bubble gently on an extended fingertip with a delighted expression. Bright cheerful colors, flat children's-book illustration style, no text.",
    },
    {
        "name": "🎵 Musical Hoops",
        "objective": "Practice quick movement and listening for when music stops.",
        "materials": ["Hula hoops (one fewer than the number of players)", "Music player"],
        "steps": [
            "Lay hula hoops in a circle on the ground.",
            "Play music while everyone walks around the hoops.",
            "When the music stops, jump into the nearest hoop!",
            "Remove one hoop each round — whoever can't find a hoop cheers on the rest.",
        ],
        "safety_line": "Step (don't dive) into hoops to avoid bumping heads with a friend.",
        "image_prompt": "A bird's-eye view illustration of 5 hula hoops arranged in a circle on grass, with 4 children walking around them in a circular path. A small speaker icon with music notes shows nearby. One child is shown mid-jump landing inside a hoop, arms out. Bright, playful flat children's-book illustration style, no text.",
    },
    {
        "name": "🍂 Nature Color Match",
        "objective": "Find outdoor items that match a set of color cards.",
        "materials": ["5-6 colored paper swatches or cards"],
        "steps": [
            "Grown-up hands each child a colored card.",
            "Search the yard or park for something outside that matches that color.",
            "Bring back your item (or point to it) to show the group.",
            "Trade cards and search for a new color!",
        ],
        "safety_line": "Only touch plants or items a grown-up says are okay to touch.",
        "image_prompt": "An outdoor illustration of a child holding up a small green paper card next to a green leaf on a bush, comparing the colors with a delighted expression. Nearby, another child holds a yellow card next to a dandelion flower. Bright natural garden background with grass and small plants. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🕳️ Obstacle Crawl Course",
        "objective": "Move through a simple obstacle course using different movements.",
        "materials": ["Hula hoops, cones, a jump rope or pool noodle (for crawling under)"],
        "steps": [
            "Set up 3-4 simple stations: hop through hoops, crawl under a rope, walk around cones, jump over a line.",
            "Line up and go through the course one at a time.",
            "Cheer for whoever is going through the course!",
            "Take turns going again and try to go faster (but still carefully).",
        ],
        "safety_line": "Go one at a time so no one bumps into each other.",
        "image_prompt": "A side-view illustration of a simple backyard obstacle course laid out left to right: 3 hula hoops on the ground for hopping through, a jump rope tied between two chairs at knee-height for crawling under, and 2 orange cones to walk around in a zigzag. A child is shown mid-crawl under the rope, with dotted arrow lines showing the full path through all stations. Bright sunny grassy background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "⭕ Ring Around Relay",
        "objective": "Practice running in a loop and tagging a teammate to keep the relay going.",
        "materials": ["2 cones to mark a loop"],
        "steps": [
            "Set up two cones a short distance apart to mark a loop.",
            "Split into 2 small teams, lined up at one cone.",
            "First player runs around the loop and tags the next teammate's hand.",
            "Keep going until every player has had a turn!",
        ],
        "safety_line": "Run at a pace you can control, and tag hands gently.",
        "image_prompt": "A top-down illustration of an oval running loop marked by two orange cones on grass, with a dotted line showing the loop path. Two small teams of children are lined up at one cone, and one child is shown mid-run around the far cone with motion lines, heading back to tag the next teammate's outstretched hand. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "☁️ Cloud Watching Circle",
        "objective": "Practice lying still, looking up, and imagining shapes in the clouds together.",
        "materials": ["A blanket to lie on (optional)"],
        "steps": [
            "Everyone lies down on a blanket or the grass, looking up at the sky.",
            "Take turns pointing out a cloud and saying what shape it looks like.",
            "Listen to what shapes your friends see too.",
            "Relax and enjoy the sky for a few quiet minutes.",
        ],
        "safety_line": "Choose a shaded or sunscreen-protected spot to lie comfortably.",
        "image_prompt": "A peaceful illustration from a low angle showing 3 children lying on their backs on a blanket spread across grass, all looking up at a bright blue sky filled with fluffy white clouds shaped like recognizable things (one cloud shaped like a bunny, one like a heart, one like a boat). One child points up excitedly. Warm, calm color palette, flat children's-book illustration style, no text.",
    },
    {
        "name": "🗺️ Follow the Path Maze",
        "objective": "Follow a chalk-drawn path from start to finish without stepping off.",
        "materials": ["Sidewalk chalk"],
        "steps": [
            "Draw a winding path on the driveway or sidewalk with chalk.",
            "Walk along the path, staying on the chalk lines.",
            "Try walking backward or hopping along the path for a challenge!",
            "Draw a new, trickier path and try again.",
        ],
        "safety_line": "Walk slowly on the chalk path to avoid slipping.",
        "image_prompt": "A bird's-eye view illustration of a winding chalk-drawn path on gray pavement, curving left and right with a clear 'START' label at one end and 'FINISH' at the other. A child is shown mid-step balancing carefully along the chalk line with arms out for balance. Bright colorful chalk line (drawn in rainbow colors), sunny pavement background. Flat children's-book illustration style.",
    },
    {
        "name": "🥅 Kick and Catch",
        "objective": "Practice kicking a ball to a partner and catching it back.",
        "materials": ["1 soft playground ball"],
        "steps": [
            "Two players stand a few steps apart, facing each other.",
            "One player gently kicks the ball to the other.",
            "The other player stops the ball with their foot or catches it with their hands.",
            "Take turns kicking back and forth.",
        ],
        "safety_line": "Kick gently along the ground — no high kicks.",
        "image_prompt": "A simple outdoor illustration of two children standing on grass facing each other a few steps apart. One child is mid-kick, leg extended toward a colorful playground ball rolling along the ground with motion lines, while the other child has one foot forward ready to stop it. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦘 Giant Steps",
        "objective": "Practice asking politely and taking different-sized steps toward a goal.",
        "materials": ["None — just open space"],
        "steps": [
            "One player is the 'Leader' and stands at the finish line.",
            "Everyone else lines up at the start and asks, 'Mother, may I take [2 giant steps]?'",
            "The Leader says 'Yes, you may!' (or suggests a different step type).",
            "First to reach the Leader wins and becomes the new Leader.",
        ],
        "safety_line": "Take steps carefully so you don't lose your balance and fall.",
        "image_prompt": "An outdoor illustration showing a child standing confidently at one end of a grassy lawn (the 'Leader'), facing 3 other children lined up at the far end. One child is shown mid-stride taking an exaggerated giant step forward, arms swinging for balance, with a dotted line showing the step distance. Bright sunny flat children's-book illustration style, no text.",
    },
]


GAMES[2] = [
    {
        "name": "🏁 Simple Relay Race",
        "objective": "Work as a team to run and pass a baton as fast as possible.",
        "materials": ["1 baton (or stick/ball)", "2 cones"],
        "steps": [
            "Split into 2 teams, lined up behind a starting cone.",
            "First runner races to the far cone, around it, and back.",
            "Hand the baton to the next teammate.",
            "First team to have everyone finish wins!",
        ],
        "safety_line": "Hand off the baton carefully — don't throw it.",
        "image_prompt": "A top-down illustration of two lanes on a grass field, each marked by a starting cone and a far turn-around cone. Two teams of 4 children each are lined up at the start, and in each lane a runner is shown mid-run holding a baton with a dotted arrow showing the loop path around the far cone and back. Bright, energetic sports-day style flat illustration, no text.",
    },
    {
        "name": "🧭 Four Corners",
        "objective": "Practice quick decision-making and quiet movement between four spots.",
        "materials": ["4 cones or markers to label corners of a square area"],
        "steps": [
            "Mark 4 corners of a square play area with cones.",
            "One player is 'It' and closes their eyes and counts to 10 in the middle.",
            "Everyone else quietly picks a corner to stand in.",
            "'It' points to a corner with eyes still closed — everyone there is out!",
        ],
        "safety_line": "Walk quietly to your corner — no running or pushing.",
        "image_prompt": "A bird's-eye view illustration of a large square play area with an orange cone marking each of the 4 corners. Children stand grouped near different corners (2-3 kids per corner), while one child stands blindfolded or eyes-closed in the very center, one arm pointing outward toward a corner. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🦈 Gentle Sharks and Minnows",
        "objective": "Practice running and dodging while trying to cross safely to the other side.",
        "materials": ["2 lines marked with chalk or cones (opposite ends of the play area)"],
        "steps": [
            "One or two players are 'Sharks' and stand in the middle.",
            "Everyone else ('Minnows') lines up on one side.",
            "On 'go,' Minnows try to run to the other side without being gently tagged.",
            "Tagged Minnows become Sharks for the next round!",
        ],
        "safety_line": "Tag gently with an open hand — no grabbing or shoving.",
        "image_prompt": "A top-down illustration of a wide rectangular play field with a chalk line at each end. In the middle, 2 children stand as 'Sharks' with arms out ready to tag. On one end line, a group of 5 'Minnow' children are shown mid-sprint running toward the opposite line, with motion lines behind them. Bright energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🏐 Balloon Volleyball",
        "objective": "Work with a partner to keep a balloon from touching the ground using a 'net.'",
        "materials": ["1 balloon", "A jump rope or string tied between two chairs as a net"],
        "steps": [
            "Tie a rope between two chairs at chest height to make a net.",
            "Two players stand on opposite sides.",
            "Hit the balloon back and forth over the 'net' using your hands.",
            "Count how many times you can hit it back and forth without it touching the ground!",
        ],
        "safety_line": "Use gentle taps, not hard hits, since it's a balloon.",
        "image_prompt": "An outdoor illustration showing a jump rope tied at chest-height between two lawn chairs, acting as a volleyball net, with a red balloon floating just above the rope mid-flight. Two children stand on opposite sides, one with a hand raised having just tapped the balloon over, the other reaching up to hit it back. Bright sunny grassy background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎯 Beanbag Bullseye",
        "objective": "Practice aiming beanbags at a target to score points.",
        "materials": ["4-5 beanbags", "Chalk-drawn target circles or a hula hoop with a bucket in the middle"],
        "steps": [
            "Draw 3 rings on the ground with chalk (or set a bucket inside a hoop) — outer ring worth 1 point, middle worth 2, center worth 3.",
            "Stand behind a throwing line a few steps back.",
            "Take turns tossing beanbags, adding up your points.",
            "Play 3 rounds and see who scores the most!",
        ],
        "safety_line": "Only toss toward the target, never at another player.",
        "image_prompt": "A top-down illustration of 3 concentric chalk-drawn circles on pavement, labeled with small point values '1', '2', '3' from outer to inner ring. A beanbag is shown mid-air flying toward the center ring with a dotted arc trajectory line from a throwing line a few steps away where a child stands in mid-throw pose. Bright, clear scoring diagram feel, flat children's-book illustration style.",
    },
    {
        "name": "🏗️ Obstacle Course Challenge",
        "objective": "Complete a multi-station obstacle course as quickly and safely as possible.",
        "materials": ["Cones, hula hoops, a jump rope, a small ramp or step (optional)"],
        "steps": [
            "Set up 4-5 stations: zigzag around cones, hop through hoops, crawl under a rope, balance-walk a line, jump over a small object.",
            "Time each player (or team) going through the whole course.",
            "Cheer each other on as you go through the stations.",
            "Try again and see if you can beat your own time!",
        ],
        "safety_line": "Go one at a time through the course, and walk (don't sprint) between stations.",
        "image_prompt": "A side-view layout illustration of a 5-station backyard obstacle course arranged left to right: cones to zigzag between, hula hoops on the ground to hop through, a rope tied low between two chairs to crawl under, a chalk line to balance-walk along, and a small box to jump over at the end. A dotted arrow path connects all 5 stations in order, with a child shown mid-action at the hula-hoop station. Bright, clear, colorful flat children's-book illustration style, no text.",
    },
    {
        "name": "🧊 Freeze Tag",
        "objective": "Practice running, dodging, and helping teammates get unfrozen.",
        "materials": ["Open play space"],
        "steps": [
            "One or two players are 'It.'",
            "When tagged, a player freezes in place with arms out.",
            "Frozen players can be unfrozen if a teammate crawls under their arms.",
            "See if 'It' can freeze everyone, or if the team can stay unfrozen!",
        ],
        "safety_line": "Tag gently with an open hand, and crawl carefully under arms.",
        "image_prompt": "An outdoor illustration showing one child frozen mid-run with arms stretched out to the sides like a statue, while a teammate crouches and crawls underneath their arms to 'unfreeze' them. In the background, another child (the tagger, wearing a bright colored shirt to show they're 'It') is running toward another player. Bright sunny grassy field background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎡 Hula Hoop Toss",
        "objective": "Practice tossing hula hoops onto a target for points.",
        "materials": ["3-4 hula hoops", "1 cone or bottle as a target post"],
        "steps": [
            "Stand a cone or bottle upright as the target.",
            "Stand a few steps back behind a line.",
            "Take turns tossing hula hoops like rings, trying to land them around the target.",
            "Count how many hoops each player lands!",
        ],
        "safety_line": "Toss hoops low and gently — never toward another person.",
        "image_prompt": "A simple outdoor illustration of an orange traffic cone standing on grass with one hula hoop already landed around its base, and a second brightly colored hula hoop shown mid-air flying toward it in a spinning motion with a dotted trajectory arc. A child stands a few steps back in a throwing pose. Bright sunny flat children's-book illustration style, no text.",
    },
    {
        "name": "🔍 Nature Scavenger Hunt",
        "objective": "Find a list of outdoor items by searching and observing carefully.",
        "materials": ["A written or picture scavenger hunt list (leaf, pinecone, feather, rock, flower, bug)"],
        "steps": [
            "Look over the scavenger hunt list together.",
            "Search the yard or park for each item on the list.",
            "Check off (or collect) each item as you find it.",
            "See who can find every item first, or work together as a team!",
        ],
        "safety_line": "Only pick up items a grown-up says are safe to touch.",
        "image_prompt": "An outdoor illustration of a child holding a clipboard with a checklist of 6 small nature icons (leaf, pinecone, feather, rock, flower, bug), with 3 items already checked off. The child crouches examining a pinecone on the ground in a park setting with trees and bushes in the background. Bright, natural, flat colorful children's-book illustration style, no text except small checkmark icons.",
    },
    {
        "name": "🏃 Simon Says Sprint",
        "objective": "Practice listening carefully and reacting quickly with movement commands.",
        "materials": ["Open outdoor space"],
        "steps": [
            "One player is 'Simon' and calls out movement commands.",
            "If Simon says 'Simon says run in place!' — everyone does it.",
            "If Simon just says 'run in place!' (no 'Simon says') — don't move!",
            "Anyone who moves at the wrong time sits out one round, then rejoins.",
        ],
        "safety_line": "Pick safe movements — no fast running near obstacles.",
        "image_prompt": "An outdoor illustration of one child standing confidently with a raised hand giving commands (Simon), facing 4 other children who are shown mid-action jogging in place with knees lifted high, big focused expressions. Bright sunny grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🚧 Line Tag",
        "objective": "Practice quick footwork by only being allowed to run along drawn lines.",
        "materials": ["Sidewalk chalk to draw a grid of lines"],
        "steps": [
            "Draw a large chalk grid (like a tic-tac-toe pattern, but bigger) on pavement.",
            "One player is 'It' and can only move along the chalk lines.",
            "Everyone else also must stay on the lines while avoiding being tagged.",
            "Tagged players become 'It' for the next round.",
        ],
        "safety_line": "Watch your footing on the lines so you don't trip.",
        "image_prompt": "A bird's-eye view illustration of a large chalk-drawn grid pattern (like an oversized tic-tac-toe board) on gray pavement, with several children standing at different intersection points along the lines. One child (marked with a colored wristband as 'It') is shown moving along a line toward another player, who is shown mid-step moving away along a perpendicular line. Bright chalk colors, flat children's-book illustration style, no text.",
    },
    {
        "name": "🪣 Bucket Ball Toss",
        "objective": "Practice underhand throwing accuracy by tossing balls into buckets.",
        "materials": ["3 buckets of different sizes", "Several small soft balls"],
        "steps": [
            "Line up 3 buckets at different distances (close, medium, far).",
            "Stand behind a throwing line.",
            "Take turns tossing balls, trying to land them in a bucket.",
            "Farther buckets are worth more points — add up your score!",
        ],
        "safety_line": "Use an underhand toss, and only aim at the buckets.",
        "image_prompt": "A top-down illustration showing three buckets of the same size placed at increasing distances from a throwing line (close, medium, far), each labeled with a small point value ('1 pt', '2 pt', '3 pt'). A soft ball is shown mid-air arcing toward the farthest bucket with a dotted trajectory line, and a child stands at the throwing line in an underhand-toss pose. Bright, clear, flat children's-book illustration style.",
    },
    {
        "name": "🧭 Follow the Compass",
        "objective": "Practice following simple directions (left, right, forward, back) to reach a spot.",
        "materials": ["Sidewalk chalk or cones to mark a start and hidden 'treasure' spot"],
        "steps": [
            "A grown-up hides a small prize or marker somewhere in the yard.",
            "Give simple directions: '5 steps forward, turn right, 3 steps forward.'",
            "Follow the directions exactly to find the hidden spot.",
            "Take turns giving directions to a friend!",
        ],
        "safety_line": "Walk carefully while counting steps so you don't bump into anything.",
        "image_prompt": "A bird's-eye view illustration of a yard showing a dotted directional path made of arrows: 5 steps forward, then a right-turn arrow, then 3 more steps forward, ending at a small treasure-chest icon or flag marker. A child is shown mid-walk following the arrows with a focused, determined expression. Bright sunny grassy background. Flat colorful children's-book illustration style, no text besides small directional arrow icons.",
    },
    {
        "name": "🗿 Statue Game",
        "objective": "Practice balance and self-control by freezing in place after being spun or tossed gently.",
        "materials": ["Open grass space"],
        "steps": [
            "One player gently spins or swings each player's hand once, then lets go.",
            "That player must freeze immediately in whatever position they land in, like a statue.",
            "Everyone tries to hold their statue pose without wobbling.",
            "After a few seconds, take turns being the 'spinner.'",
        ],
        "safety_line": "Spin gently and slowly — this is about balance, not speed.",
        "image_prompt": "A playful outdoor illustration of 3 children frozen in funny off-balance 'statue' poses on grass — one with one leg up, one with arms twisted, one mid-tip-toe — all holding very still with focused, slightly wobbly expressions. A fourth child stands nearby watching and smiling, having just released their hand from a gentle spin. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[3] = [
    {
        "name": "🚩 Capture the Flag Lite",
        "objective": "Work with a team to sneak across enemy territory and grab the other team's flag.",
        "materials": ["2 flags (or bandanas)", "Cones to mark a center dividing line"],
        "steps": [
            "Split into 2 teams, each with its own half of the field and a flag hidden near the back.",
            "On 'go,' try to sneak into the other team's territory to grab their flag.",
            "If tagged in enemy territory, walk back to your own side and try again.",
            "First team to bring the flag back to their side wins!",
        ],
        "safety_line": "Tag gently with an open hand — no grabbing clothes or pulling.",
        "image_prompt": "A top-down aerial-view illustration of a rectangular field divided by a dotted center line into a blue team side and a red team side, each with a small flag icon planted near the back edge. Several children in blue shirts are shown on the red side sneaking toward the red flag, while red-shirted children patrol nearby. Motion lines show one blue player being tagged and pointing back toward their own side. Bright, clear strategy-map style flat illustration, no text besides simple flag icons.",
    },
    {
        "name": "⚽ Kickball Basics",
        "objective": "Practice kicking, running bases, and basic teamwork rules of kickball.",
        "materials": ["1 kickball", "4 bases (or cones)"],
        "steps": [
            "Set up 4 bases in a diamond shape, like baseball.",
            "One team kicks, the other fields the ball.",
            "The pitcher rolls the ball to the kicker, who kicks it and runs the bases.",
            "The fielding team tries to get the kicker 'out' by catching the ball or tagging a base.",
        ],
        "safety_line": "Run bases carefully and watch for the ball and other players.",
        "image_prompt": "A top-down diagram-style illustration of a kickball diamond with 4 bases (home, first, second, third) marked by orange cones, connected by a dotted running path. A child is shown mid-kick at home plate sending a red rubber ball flying, while another child runs toward first base. Fielders are positioned around the diamond. Bright, clear sports-diagram flat illustration style, no text besides simple base labels '1st, 2nd, 3rd, Home'.",
    },
    {
        "name": "🎯 Frisbee Toss Target",
        "objective": "Practice throwing a frisbee accurately toward a target.",
        "materials": ["1 flying disc (frisbee)", "A hula hoop or bucket as a target"],
        "steps": [
            "Set a hula hoop or bucket on the ground as the target.",
            "Stand a few steps back behind a throwing line.",
            "Take turns throwing the frisbee, aiming for the target.",
            "Move the line back for a bigger challenge as you improve!",
        ],
        "safety_line": "Only throw toward the target and check that no one is in the flight path.",
        "image_prompt": "An outdoor illustration showing a hula hoop lying flat on grass as a target, with a colorful flying disc shown mid-flight arcing toward it, a dotted curved trajectory line tracing its path from a child standing at a throwing line several steps away, arm extended after the throw. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏃 Obstacle Relay Teams",
        "objective": "Work as a team to complete an obstacle course relay as fast as possible.",
        "materials": ["Cones, hula hoops, a jump rope, a baton"],
        "steps": [
            "Set up an obstacle course (zigzag cones, hop through hoops, crawl under a rope).",
            "Split into 2 teams, lined up at the start.",
            "First player runs the course and hands the baton to the next teammate.",
            "First team to have everyone finish the course wins!",
        ],
        "safety_line": "Only one runner goes through the course at a time per team.",
        "image_prompt": "A side-view illustration of two parallel obstacle courses laid out identically side by side (zigzag cones, hula hoops, a low rope to crawl under), each ending at a teammate waiting to receive a baton. Two teams of children are shown, one runner mid-obstacle-course in each lane holding a baton, with the rest of each team lined up waiting their turn. Bright, energetic sports-day style flat illustration, no text.",
    },
    {
        "name": "🌀 Blob Tag",
        "objective": "Work together as a growing group to tag remaining players.",
        "materials": ["Open play space"],
        "steps": [
            "One player is 'It' and tags another player.",
            "The two tagged players hold hands and become 'the Blob,' chasing together.",
            "Every new player tagged joins the Blob, holding hands in a line.",
            "Last player not tagged wins the round!",
        ],
        "safety_line": "The Blob must stay holding hands — no letting go to grab someone.",
        "image_prompt": "A dynamic outdoor illustration showing a growing chain of 4 children holding hands in a line (the 'Blob'), running together across a grassy field chasing after 2 remaining players who are sprinting away in different directions. Motion lines show the chase. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "⚖️ Ball Balance Race",
        "objective": "Practice balance and steady movement while carrying a ball on a spoon or racket.",
        "materials": ["1 spoon or small racket per player", "1 small ball per player", "2 cones"],
        "steps": [
            "Each player balances a small ball on a spoon or racket.",
            "Line up at the start cone.",
            "Walk to the far cone and back without dropping the ball.",
            "If you drop it, pick it back up and keep going from where you dropped it!",
        ],
        "safety_line": "Walk carefully — this is about balance, not speed.",
        "image_prompt": "An outdoor illustration of 3 children walking in a line toward a distant cone, each carefully balancing a small ball on a large spoon held out in front of them, eyes focused downward in concentration, one child's ball shown mid-wobble about to fall. Bright sunny grassy field background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🔎 Scavenger Hunt Clues",
        "objective": "Follow written clues to find hidden items around the outdoor area.",
        "materials": ["4-5 written clue cards", "Small hidden prizes or markers"],
        "steps": [
            "Grown-up hides clue cards and a final prize around the yard beforehand.",
            "Read the first clue together and figure out where it points.",
            "Find that spot to get the next clue.",
            "Follow all the clues until you find the final prize!",
        ],
        "safety_line": "Only search in areas a grown-up has approved ahead of time.",
        "image_prompt": "An outdoor illustration showing a child reading a small folded paper clue card near a tree, with a dotted path leading to a bush where the next clue card is tucked, and finally to a small treasure box under a garden chair. Three sequential 'clue stops' are shown connected by a dashed path with numbered circles (1, 2, 3). Bright natural garden background. Flat colorful children's-book illustration style.",
    },
    {
        "name": "🔲 Four Square",
        "objective": "Practice bouncing and hitting a ball within a 4-square court using simple rules.",
        "materials": ["1 bouncy ball", "Chalk to draw a 4-square court"],
        "steps": [
            "Draw a large square divided into 4 smaller squares, numbered 1-4.",
            "One player stands in each square.",
            "The player in square 4 serves by bouncing the ball into another square.",
            "Keep hitting the ball into different squares — miss or hit out of bounds, and you're out (new player rotates in)!",
        ],
        "safety_line": "Hit the ball gently with an open hand, not a hard punch.",
        "image_prompt": "A bird's-eye view illustration of a chalk-drawn court divided into 4 equal squares numbered 1, 2, 3, 4, each with a child standing inside. A bouncy ball is shown mid-bounce inside square 3, with a dotted arc showing it traveling from square 4 where a player just hit it. Bright pavement background. Flat colorful children's-book illustration style, clear diagram feel.",
    },
    {
        "name": "🎒 Bean Bag Relay",
        "objective": "Practice balance and teamwork by racing while carrying a beanbag on your head.",
        "materials": ["1 beanbag per team", "2 cones"],
        "steps": [
            "Split into teams, lined up at the start cone.",
            "First player balances a beanbag on their head and walks to the far cone and back.",
            "Hand the beanbag to the next teammate (no throwing!).",
            "First team to finish wins!",
        ],
        "safety_line": "If your beanbag falls, stop, pick it up, and continue from where you are.",
        "image_prompt": "An outdoor illustration of a child walking carefully with a small beanbag balanced on top of their head, arms slightly out for balance, walking toward a distant cone. Behind them, teammates wait in line at the starting cone. Bright sunny grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪢 Jump Rope Challenge",
        "objective": "Practice jump-roping and count how many consecutive jumps you can do.",
        "materials": ["1 jump rope per player"],
        "steps": [
            "Each player gets their own jump rope.",
            "Practice swinging the rope and jumping over it.",
            "Count out loud how many jumps in a row you can do without stopping.",
            "Try to beat your own best score!",
        ],
        "safety_line": "Give yourself space so your rope doesn't hit a friend.",
        "image_prompt": "An outdoor illustration of a child mid-jump over a jump rope, rope shown as a curved motion-blur arc beneath their feet, arms bent holding the rope handles, focused determined expression. A small speech-bubble-style number counter nearby shows '7' to represent a jump count. Bright sunny grassy background. Flat colorful children's-book illustration style.",
    },
    {
        "name": "💪 Team Tug of War (Light)",
        "objective": "Work together as a team to pull a rope across a middle line.",
        "materials": ["1 sturdy rope", "Chalk or a marker for the center line"],
        "steps": [
            "Draw a line on the ground for the middle.",
            "Split into 2 even teams, each holding one end of the rope.",
            "On 'go,' pull together to try to bring the middle of the rope past your side of the line.",
            "First team to pull the rope's middle marker across their line wins!",
        ],
        "safety_line": "Wear closed-toe shoes and let go of the rope right away if you fall or slip.",
        "image_prompt": "A top-down illustration of a thick rope stretched across a grassy field with a chalk line marking the middle, and a ribbon tied at the rope's center point. Two teams of 3-4 children each pull on opposite ends, leaning back with feet braced, determined expressions. The ribbon marker is shown slightly closer to one team's side. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🦶 Hopscotch Trail",
        "objective": "Practice hopping on one and two feet along a numbered hopscotch grid.",
        "materials": ["Sidewalk chalk", "A small stone or beanbag marker"],
        "steps": [
            "Draw a hopscotch grid (numbered 1-8) with chalk.",
            "Toss your marker onto square 1.",
            "Hop through the grid on one foot for single squares, two feet for side-by-side squares, skipping the square with your marker.",
            "Pick up your marker on the way back, then toss it to the next number!",
        ],
        "safety_line": "Hop carefully to keep your balance on each square.",
        "image_prompt": "A bird's-eye view illustration of a classic hopscotch grid drawn in colorful chalk on pavement, numbered 1 through 8, with squares 4-5 and 6-7 drawn side by side for two-footed landings. A small beanbag marker sits in square 3. A child is shown mid-hop on one foot in square 2, arms out for balance. Bright, clear diagram-style flat illustration, no text besides the numbers.",
    },
    {
        "name": "🦆 Duck Duck Goose Sprint",
        "objective": "Practice quick reactions and full-speed running in a faster version of a classic circle game.",
        "materials": ["Open grass space"],
        "steps": [
            "Everyone sits in a circle facing inward.",
            "One player walks (or jogs) around the circle tapping heads, saying 'duck' each time.",
            "On one head, they say 'goose!' — that player jumps up and sprints to chase them.",
            "The tapper must run all the way around the circle back to the empty spot before being tagged.",
        ],
        "safety_line": "Only run around the outside of the circle, watching for seated players.",
        "image_prompt": "A bird's-eye view illustration of 7 children sitting in a circle on grass, one child standing and sprinting around the outside with motion lines showing speed, chased closely by another child who just jumped up (the 'goose'), both heading toward an empty spot in the circle. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "💦 Water Balloon Toss",
        "objective": "Work with a partner to toss and catch a water balloon without popping it.",
        "materials": ["Water balloons (filled)"],
        "steps": [
            "Pair up and stand a few steps apart, facing your partner.",
            "Gently toss the water balloon back and forth.",
            "After each successful catch, both partners take one step back.",
            "See how far apart you can get before the balloon pops!",
        ],
        "safety_line": "Toss gently and catch with both hands — expect a splash if it pops!",
        "image_prompt": "A fun outdoor illustration of two children standing several steps apart on grass, one mid-throw releasing a colorful water balloon, the other with both hands cupped ready to catch it, a dotted arc trajectory line connecting them. Both children have excited, laughing expressions, slightly damp from earlier splashes. Bright sunny summer background. Flat colorful children's-book illustration style, no text.",
    },
]


GAMES[4] = [
    {
        "name": "🚩 Capture the Flag",
        "objective": "Use teamwork and strategy to capture the opposing team's flag and bring it home.",
        "materials": ["2 flags", "Cones to mark boundaries and a jail zone for each team"],
        "steps": [
            "Split the field in half between 2 teams, each with a flag and a jail zone.",
            "Sneak into enemy territory to grab their flag without being tagged.",
            "If tagged on enemy territory, go to their jail until a teammate frees you.",
            "First team to bring the flag back to their own side wins!",
        ],
        "safety_line": "Tag gently with an open hand, and know your team's boundary lines.",
        "image_prompt": "An aerial strategy-map illustration of a large field split by a dotted center line into two territories (blue and red), each with a flag icon and a small 'jail' zone marked with a square outline near the back corner. Blue players are shown sneaking through red territory, with one blue player standing inside the red jail zone with arms crossed (captured), while a teammate approaches to free them. Clear, colorful tactical-map style flat illustration, no text besides simple flag and jail icons.",
    },
    {
        "name": "⚽ Kickball Tournament",
        "objective": "Apply kickball rules and teamwork across a full mini-tournament of innings.",
        "materials": ["1 kickball", "4 bases", "Scorecard (optional)"],
        "steps": [
            "Set up bases in a diamond; split into 2 teams.",
            "Play 3 innings, switching between kicking and fielding each inning.",
            "Track runs scored by each team on a simple scorecard.",
            "Team with the most runs after 3 innings wins the tournament!",
        ],
        "safety_line": "Slide-free base running — just run through the base safely.",
        "image_prompt": "A diagram-style illustration of a kickball diamond with 4 bases, showing a runner mid-sprint between first and second base while a fielder catches a rolling ball nearby. A small scoreboard icon in the corner shows 'Inning 2, Blue 3 - Red 2'. Bright, clear sports-diagram flat illustration style.",
    },
    {
        "name": "🥏 Ultimate Frisbee Intro",
        "objective": "Practice throwing, catching, and moving a frisbee downfield as a team without running while holding it.",
        "materials": ["1 flying disc", "4 cones to mark end zones"],
        "steps": [
            "Mark two end zones with cones at opposite ends of the field.",
            "Split into 2 teams; the goal is to catch the disc inside the other team's end zone.",
            "You can't run while holding the disc — only pivot and pass to a teammate.",
            "If the disc touches the ground or is caught by the other team, they take possession.",
        ],
        "safety_line": "No grabbing the disc out of someone's hands — only intercept passes in the air.",
        "image_prompt": "A top-down field diagram illustration showing two end zones marked by cones at each end of a rectangular field. A player is shown mid-throw releasing a flying disc toward a teammate standing inside the far end zone with arms raised ready to catch, while opposing players position themselves to intercept. Dotted arc line traces the disc's flight path. Clear sports-diagram flat illustration style, no text besides 'END ZONE' labels.",
    },
    {
        "name": "🏃 Team Relay Obstacle",
        "objective": "Coordinate as a team to complete a multi-station relay obstacle course fastest.",
        "materials": ["Cones, hula hoops, a jump rope, a balance beam or line, a baton"],
        "steps": [
            "Set up 5 stations: cone zigzag, hoop hop, rope crawl, balance line, jump rope 5 times.",
            "Split into 2 teams lined up at the start.",
            "Each runner completes all 5 stations, then tags the next teammate.",
            "First team with everyone finished wins!",
        ],
        "safety_line": "Complete each station fully and safely before moving to the next.",
        "image_prompt": "A side-view illustration of a 5-station obstacle course laid out in sequence: zigzag cones, a row of hula hoops, a low rope for crawling, a chalk balance line, and a jump rope. Numbered station markers (1-5) with a dotted path connecting them. A runner is shown at station 3 crawling under the rope, teammates waiting in a relay line at the start. Bright, clear, energetic flat illustration style.",
    },
    {
        "name": "🔲 Four Square Challenge",
        "objective": "Apply advanced four-square rules including special serves and challenges.",
        "materials": ["1 bouncy ball", "Chalk to draw the 4-square court"],
        "steps": [
            "Draw a 4-square court with squares numbered 1 (lowest) to 4 (king/queen square).",
            "The player in square 4 serves the ball into another square.",
            "Players hit the ball back and forth; missing or hitting out sends you to square 1, others move up.",
            "Try to reach and stay in square 4 the longest!",
        ],
        "safety_line": "Hit with an open hand only — no punching or kicking the ball.",
        "image_prompt": "A bird's-eye diagram illustration of a chalk four-square court with squares clearly labeled 1, 2, 3, and 4 (with a small crown icon on square 4 to show it's the 'king/queen' square), each occupied by a child. A ball is shown bouncing from square 4 toward square 2 with a dotted arc. Bright, clear diagram-style flat illustration.",
    },
    {
        "name": "🗺️ Scavenger Hunt Teams",
        "objective": "Work in small teams to solve clues and find hidden items across a wider area.",
        "materials": ["5-6 written clue cards per team", "Small prizes at the final spot"],
        "steps": [
            "Split into small teams of 2-3.",
            "Give each team their first clue card.",
            "Follow the clue trail, solving each clue to find the next location.",
            "First team to reach the final hidden prize wins!",
        ],
        "safety_line": "Stay within the boundaries a grown-up sets for the hunt area.",
        "image_prompt": "An illustrated overhead map-style scene of a yard or park showing a dotted path connecting 5 numbered clue locations (a tree, a bench, a mailbox, a fence post, a garden bed) leading to a treasure box at the final spot. Two small teams of children are shown at different points along the path, one team reading a clue card near the tree. Bright, colorful treasure-map style flat illustration.",
    },
    {
        "name": "💪 Tug of War",
        "objective": "Use coordinated team strength and strategy to pull the rope across the line.",
        "materials": ["1 thick sturdy rope", "Chalk or marker for the center line"],
        "steps": [
            "Mark a center line and tie a ribbon at the rope's middle.",
            "Split into 2 even teams, gripping the rope on opposite sides.",
            "On 'go,' pull together, leaning back and digging in your heels.",
            "First team to pull the ribbon marker past their line wins!",
        ],
        "safety_line": "Wear closed-toe shoes, and let go immediately if you slip or fall.",
        "image_prompt": "A dynamic top-down illustration of a thick rope with a ribbon tied at its center, stretched across a chalk line on grass. Two teams of 4-5 children each lean back at an angle, feet braced, gripping the rope with determined expressions, working together to pull. The ribbon marker is shown just past one team's line, showing them winning. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🦈 Sharks and Minnows",
        "objective": "Practice sprinting and dodging strategy while trying to safely cross the field.",
        "materials": ["2 boundary lines marked with chalk or cones"],
        "steps": [
            "Mark two lines at opposite ends of the field.",
            "2-3 players are 'Sharks' and stand in the middle; everyone else ('Minnows') lines up on one side.",
            "On 'go,' Minnows sprint to the other line without being tagged.",
            "Tagged Minnows become Sharks — play continues until only a few Minnows remain!",
        ],
        "safety_line": "Tag with an open hand only, and watch for other runners nearby.",
        "image_prompt": "A top-down field illustration with chalk lines at both ends, 3 children positioned in the middle as 'Sharks' with arms out ready to tag, and a large group of 'Minnow' children sprinting from one line toward the other with motion lines showing speed and dodging paths. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🥏 Kan Jam Basics",
        "objective": "Practice throwing a disc toward a partner's goal to score points as a team.",
        "materials": ["2 goal targets (buckets or a Kan Jam set)", "1 flying disc"],
        "steps": [
            "Set up 2 goal targets facing each other, about 15 steps apart.",
            "Pair up — one thrower per team stands at each goal, one deflector partner stands near their own goal.",
            "Throwers alternate tossing the disc toward their partner's goal.",
            "The deflector can tap the disc to redirect it into the goal for bonus points!",
        ],
        "safety_line": "Only throw when it's your turn, and stand clear of the goal area otherwise.",
        "image_prompt": "A top-down field diagram showing two goal target stands (drum-shaped) facing each other about 15 steps apart. A thrower stands beside one goal releasing a flying disc with a dotted arc trajectory toward the far goal, where a deflector player stands ready with a hand raised to tap it in. Clear sports-diagram flat illustration style.",
    },
    {
        "name": "🏷️ Team Tag Strategy",
        "objective": "Use team communication and strategy to tag opposing players while protecting your own.",
        "materials": ["Pinnies or colored bands to mark 2 teams", "Boundary cones"],
        "steps": [
            "Split into 2 teams marked by different colors.",
            "Each team tries to tag members of the other team while avoiding being tagged themselves.",
            "Tagged players do 5 jumping jacks before rejoining the game.",
            "Play for a set time — team with the fewest tags wins!",
        ],
        "safety_line": "Tag gently on the shoulder or back — no shoving.",
        "image_prompt": "A dynamic outdoor field illustration showing two teams wearing different colored pinnies (blue and yellow) mixed together across a marked play area, with one blue player tagging a yellow player's shoulder. Nearby, a tagged player is shown doing a jumping jack before rejoining. Boundary cones mark the play area edges. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🪣 Bucket Brigade Relay",
        "objective": "Work as a team to transport water from one bucket to another as efficiently as possible.",
        "materials": ["2 large buckets per team (one filled with water)", "1 cup per player"],
        "steps": [
            "Line up team members between a full bucket and an empty bucket.",
            "Each player scoops water with their cup and passes it down the line.",
            "Pour into the next person's cup without spilling too much!",
            "The team that moves the most water to the empty bucket in 2 minutes wins.",
        ],
        "safety_line": "Watch for slippery wet ground and walk carefully near buckets.",
        "image_prompt": "An outdoor illustration of a line of 4 children standing between two large buckets, each holding a cup, passing water down the line — one child pouring from their cup into the next child's cup, with small water droplet motion lines showing the transfer. Bright sunny summer background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🎡 Hula Hoop Pass",
        "objective": "Work as a team in a circle to pass a hula hoop around without letting go of hands.",
        "materials": ["1 hula hoop"],
        "steps": [
            "Everyone forms a circle, holding hands.",
            "Loop a hula hoop over one player's arm before they join hands.",
            "Without letting go of hands, everyone works together to pass the hoop all the way around the circle.",
            "Time yourselves and try to beat your own record!",
        ],
        "safety_line": "Move slowly and carefully so no one's hands get pulled too hard.",
        "image_prompt": "A circle of 6 children holding hands on grass, with a colorful hula hoop looped over one player's shoulder and arm, shown mid-transfer as that player ducks through the hoop to pass it toward the next person in the circle without releasing hands. Bright sunny outdoor background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🪢 Jump Rope Relay",
        "objective": "Combine running and jump-roping skills in a team relay format.",
        "materials": ["1 jump rope per team", "2 cones"],
        "steps": [
            "Split into teams lined up at the start cone.",
            "First player runs to the far cone, does 10 jump-rope jumps, then runs back.",
            "Hand the rope to the next teammate.",
            "First team to have everyone finish wins!",
        ],
        "safety_line": "Make sure you have space to swing the rope without hitting anyone.",
        "image_prompt": "An outdoor illustration showing a child mid-jump over a jump rope near a distant cone, motion-blur arc showing the rope's swing, with teammates lined up waiting at the starting cone in the foreground. Bright sunny grassy field. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🌳 Nature Trail Race",
        "objective": "Navigate a marked outdoor trail while identifying nature checkpoints along the way.",
        "materials": ["Trail markers (flags or chalk arrows)", "A checklist of things to spot along the trail"],
        "steps": [
            "Set up a looping trail marked with flags or chalk arrows.",
            "Give each player or team a checklist of things to spot (a certain tree, a rock, a bench).",
            "Follow the trail, checking off items as you go.",
            "First to complete the full loop with all items checked wins!",
        ],
        "safety_line": "Stay on the marked trail and walk carefully over uneven ground.",
        "image_prompt": "An overhead map-style illustration of a looping trail through a park marked with small flag icons at intervals, passing by a large tree, a rock, and a bench (each marked with a small checklist icon). A child is shown jogging along the trail path with a checklist in hand, checking off an item near the tree. Bright, natural, colorful flat illustration style.",
    },
]


GAMES[5] = [
    {
        "name": "🚩 Capture the Flag: Strategy Edition",
        "objective": "Plan and execute a team strategy involving offense, defense, and guards to capture the flag.",
        "materials": ["2 flags", "Cones for boundaries and jail zones"],
        "steps": [
            "Split into 2 teams; before starting, each team huddles to assign roles (attackers, guards, jail-breakers).",
            "Attackers try to sneak in and grab the flag; guards defend it; jail-breakers free tagged teammates.",
            "Tagged players wait in jail until freed by a teammate's touch.",
            "First team to bring the flag home safely wins!",
        ],
        "safety_line": "Tag with an open hand only, and respect boundary lines at all times.",
        "image_prompt": "A detailed aerial tactical-map illustration of a field split into two territories, each with a flag and jail zone. Small labeled icons show different player roles: a shield icon near 2 guards standing near their flag, a running-shoe icon near 2 attackers sneaking into enemy territory, and a key icon near a jail-breaker approaching the jail zone where a teammate is held. Clear, colorful strategy-diagram flat illustration style.",
    },
    {
        "name": "🥏 Ultimate Frisbee Match",
        "objective": "Apply full ultimate frisbee rules including stall counts and turnovers in a real match.",
        "materials": ["1 flying disc", "Cones for end zones and sidelines"],
        "steps": [
            "Mark the field with sidelines and end zones on each end.",
            "Teams move the disc by passing only — no running with it, and the thrower has 10 seconds ('stall count') to release each pass.",
            "A dropped, intercepted, or out-of-bounds disc turns possession over to the other team.",
            "Score by catching the disc inside the opposing end zone!",
        ],
        "safety_line": "No physical contact when guarding — stay an arm's length away from the thrower.",
        "image_prompt": "A detailed top-down field diagram showing a full ultimate frisbee field with sidelines and end zones marked at both ends. A thrower is shown counting down a stall count (small '5...4...3' bubble above their head) while being guarded at a distance by an opposing player, and a teammate cuts toward the end zone to receive a pass, shown with a dotted arc trajectory. Clear sports-diagram flat illustration style.",
    },
    {
        "name": "⚽ Kickball League",
        "objective": "Play a structured multi-inning kickball game applying fielding positions and scoring strategy.",
        "materials": ["1 kickball", "4 bases", "Scorecard"],
        "steps": [
            "Assign fielding positions (pitcher, baseman, outfield) for the fielding team.",
            "Play 4 innings, switching kicking and fielding each inning.",
            "Track outs (3 outs ends a team's turn kicking) and runs scored.",
            "Team with the most runs after 4 innings wins the league match!",
        ],
        "safety_line": "Run through bases without sliding to avoid injury.",
        "image_prompt": "A detailed kickball field diagram showing 4 bases and labeled fielding positions (pitcher near the middle, basemen at 1st/2nd/3rd, outfielders spread in the back). A runner sprints from home toward first base while a fielder catches a rolling ball in the outfield. A scoreboard corner shows 'Inning 3, Home 4 - Away 3'. Clear, colorful sports-diagram flat illustration style.",
    },
    {
        "name": "🏗️ Team Obstacle Design",
        "objective": "Design and then complete a custom obstacle course as a team, combining creativity with athletics.",
        "materials": ["Cones, hula hoops, jump ropes, chalk, and other yard items"],
        "steps": [
            "Split into small teams and give each team 10 minutes to design an obstacle course using available materials.",
            "Each team explains their course's stations to the group.",
            "Teams rotate through and complete each other's courses.",
            "Vote together on the most creative and fun course design!",
        ],
        "safety_line": "Check each team's course for safety before anyone runs it.",
        "image_prompt": "A wide illustration showing a small team of 3 children arranging cones, hula hoops, and a jump rope into a creative obstacle layout on grass, with one child sketching the course plan on paper. In the background, another completed course is being run by a different team. Bright, collaborative, colorful flat illustration style, no text.",
    },
    {
        "name": "🧭 Scavenger Hunt Navigator",
        "objective": "Use simple map-reading and coordinate skills to locate hidden checkpoints.",
        "materials": ["A hand-drawn simple map of the play area", "5-6 checkpoint markers"],
        "steps": [
            "Give each team a simple hand-drawn map marking checkpoint locations.",
            "Navigate using the map to find each checkpoint in order.",
            "Collect a puzzle piece or letter at each checkpoint.",
            "First team to find all checkpoints and solve the final puzzle/word wins!",
        ],
        "safety_line": "Stay within the mapped play area boundaries at all times.",
        "image_prompt": "An illustrated treasure-map-style overhead view of a yard/park showing a hand-drawn map with an X marking 5 numbered checkpoint locations connected by a dotted path, each checkpoint marked with a small letter tile icon. A child is shown holding a paper map, comparing it to the real landmarks around them (a tree, a fence, a bench) to navigate. Bright, adventurous, colorful flat illustration style.",
    },
    {
        "name": "🏈 Flag Football Basics",
        "objective": "Learn basic flag football rules: passing, receiving, and pulling flags instead of tackling.",
        "materials": ["1 football", "Flag belts (or bandanas tucked into waistbands)", "Cones for end zones"],
        "steps": [
            "Split into 2 teams; each player wears a flag belt.",
            "The offense tries to move the ball toward the end zone by running or passing.",
            "The defense stops the play by pulling a flag off the ball carrier (no tackling!).",
            "Score a touchdown by reaching the end zone with the ball!",
        ],
        "safety_line": "Only pull flags — never grab, push, or tackle another player.",
        "image_prompt": "A top-down football field diagram illustration showing an end zone marked with cones at one end. An offensive player runs with a football toward the end zone, a colorful flag visibly tucked at their waist, while a defender reaches for the flag with an outstretched hand. Dotted motion lines show the runner's path. Clear sports-diagram flat illustration style.",
    },
    {
        "name": "🔲 Four Square Tournament",
        "objective": "Compete in a bracket-style four-square tournament applying advanced rules.",
        "materials": ["1 bouncy ball", "Chalk for the court", "Simple bracket sheet"],
        "steps": [
            "Draw a 4-square court and set up a rotation line for waiting players.",
            "Play standard four-square rules — miss or hit out, you're out and go to the back of the line.",
            "Track how many rounds each player survives as 'king/queen' of square 4.",
            "Crown the player with the most total rounds won as tournament champion!",
        ],
        "safety_line": "Hit the ball with an open hand only, keeping hits low and controlled.",
        "image_prompt": "A bird's-eye diagram of a 4-square court with a line of waiting children off to the side, and a simple tournament bracket sheet shown nearby with small crown icons next to leading players' names. The ball is shown mid-bounce in the court. Clear, colorful diagram-style flat illustration.",
    },
    {
        "name": "🏃 Relay Baton Pass",
        "objective": "Practice smooth, fast baton exchanges in a competitive team relay.",
        "materials": ["1 baton per team", "4 cones marking a relay loop"],
        "steps": [
            "Split into teams of 4, each player positioned at a different point around the loop.",
            "First runner sprints to the next teammate and passes the baton without stopping.",
            "Continue until all 4 legs of the relay are complete.",
            "Fastest team to complete the full loop wins!",
        ],
        "safety_line": "Practice the baton handoff slowly first before going full speed.",
        "image_prompt": "A top-down illustration of an oval relay track with 4 cones marking exchange zones, and 4 runners positioned at each zone. One runner is shown mid-handoff, passing a baton to the next runner who has started running alongside them, both hands connected on the baton. Dotted motion lines trace the full loop. Clear, energetic sports-diagram flat illustration style.",
    },
    {
        "name": "💪 Team Tug of War",
        "objective": "Coordinate team strategy and timing to win a full tug-of-war match.",
        "materials": ["1 thick rope", "Chalk or marker for center line"],
        "steps": [
            "Tie a ribbon at the rope's center and mark a line on the ground.",
            "Teams line up in order of strength/height for balance, gripping the rope.",
            "On 'go,' pull together in a coordinated rhythm — try calling out 'pull!' together.",
            "First team to pull the ribbon past their line wins the match!",
        ],
        "safety_line": "Wear closed-toe shoes and let go immediately if you lose your footing.",
        "image_prompt": "A dynamic top-down illustration of two teams of 5 children gripping a thick rope on opposite sides of a chalk line, leaning back in a coordinated pulling stance, one player at the front of each team calling out a cue. The ribbon marker at the rope's center is shown moving toward one team's side. Bright, energetic flat children's-book illustration style, no text.",
    },
    {
        "name": "🥏 Disc Golf Intro",
        "objective": "Practice throwing a disc toward a target in as few throws as possible, like mini golf.",
        "materials": ["1 flying disc", "5-6 target markers (buckets, trees, or cones)"],
        "steps": [
            "Set up 5-6 'holes' around the yard, each a target like a bucket or tree.",
            "Throw the disc from a starting spot toward the first target.",
            "Pick up the disc where it lands and throw again toward the same target until you hit it.",
            "Count your throws for each hole — lowest total throws across all holes wins!",
        ],
        "safety_line": "Make sure the throwing path is clear of people before each throw.",
        "image_prompt": "An overhead course-map illustration showing 5 disc-golf 'holes' scattered around a park, each marked with a numbered bucket target and a dotted throwing path with a small number showing throw count needed. A child is shown mid-throw with a flying disc arcing toward the nearest bucket target. Bright, clear course-map style flat illustration.",
    },
    {
        "name": "💧 Water Relay Challenge",
        "objective": "Work as a team to transport water using sponges in a fast-paced relay.",
        "materials": ["2 buckets per team (one full, one empty)", "1 sponge per team"],
        "steps": [
            "Line up teams between a full bucket and an empty bucket, a short distance apart.",
            "Each player soaks the sponge in the full bucket, then runs to squeeze it into the empty bucket.",
            "Run back and pass the sponge to the next teammate.",
            "Team with the most water transferred in the time limit wins!",
        ],
        "safety_line": "Watch for wet, slippery ground while running.",
        "image_prompt": "An outdoor illustration of a child running between two buckets holding a dripping wet sponge above the empty bucket, squeezing water out with visible droplets falling. Teammates are lined up cheering nearby. Bright sunny summer background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🏷️ Team Strategy Tag",
        "objective": "Use planned team roles (chasers and blockers) to tag opponents strategically.",
        "materials": ["Colored pinnies for 2 teams", "Boundary cones"],
        "steps": [
            "Split into 2 teams; each team assigns some players as 'chasers' and some as 'blockers.'",
            "Chasers try to tag the other team; blockers protect their own teammates by standing between them and chasers.",
            "Tagged players sit out for 30 seconds before rejoining.",
            "Team with fewer tags after the time limit wins!",
        ],
        "safety_line": "Blocking means standing in the way, not pushing or grabbing.",
        "image_prompt": "A tactical outdoor illustration showing a blue-team chaser reaching to tag a yellow-team player, while another blue player acts as a blocker standing between them, arms out to intercept. Boundary cones mark the play area. Bright, dynamic, colorful flat illustration style, no text.",
    },
    {
        "name": "🪵 Balance Beam Relay",
        "objective": "Practice balance and coordination by walking a low balance beam as part of a relay.",
        "materials": ["A low balance beam (or a wide board/line of chalk)", "2 cones"],
        "steps": [
            "Set up a low balance beam (or chalk line) between two cones.",
            "Split into teams; first player walks across the beam without stepping off.",
            "If you step off, go back to where you started on the beam and continue.",
            "Tag the next teammate after crossing — fastest team to finish wins!",
        ],
        "safety_line": "Walk slowly with arms out for balance — this isn't a running race.",
        "image_prompt": "A side-view illustration of a low wooden balance beam (or thick chalk line) laid across grass between two cones. A child is shown mid-step walking carefully along it with arms outstretched for balance, teammates waiting in line at the start. Bright sunny background. Flat colorful children's-book illustration style, no text.",
    },
    {
        "name": "🧭 Orienteering Basics",
        "objective": "Use a simple compass and clues to navigate to specific points in order.",
        "materials": ["A simple compass (or compass app)", "5 numbered checkpoint cards with directions"],
        "steps": [
            "Give each team a compass and a set of directions (e.g., 'walk north 10 steps to checkpoint 1').",
            "Follow the compass directions to find each checkpoint in order.",
            "Collect a letter or stamp at each checkpoint.",
            "First team to visit all checkpoints in order and spell the secret word wins!",
        ],
        "safety_line": "Stay within the marked area, and walk (don't run) while checking the compass.",
        "image_prompt": "An overhead illustration of a park area with a large compass rose (N/S/E/W) overlaid, showing a dotted path with directional arrows leading to 5 numbered checkpoint flags. A child is shown holding a compass, checking its needle direction against a checkpoint card. Bright, clear, adventurous flat illustration style with visible compass icon.",
    },
]


GAMES[6] = [
    {
        "name": "🚩 Capture the Flag: Advanced",
        "objective": "Design and execute a multi-role team strategy involving scouts, guards, and runners.",
        "materials": ["2 flags", "Cones for boundaries and jail zones", "Colored pinnies for teams"],
        "steps": [
            "Split into 2 teams; each team plans roles (scouts to find the flag, guards to defend, runners to grab and sprint it home).",
            "Play a full round, allowing teams to adjust strategy between rounds.",
            "Track jail rescues and successful flag captures.",
            "Best 2 out of 3 rounds wins the match!",
        ],
        "safety_line": "Tag with an open hand only, and call out 'tag!' clearly so there's no confusion.",
        "image_prompt": "A detailed aerial tactical-map illustration showing a large field divided into two territories with flags and jail zones, and small role-icons above different players: a magnifying glass icon over 'scouts', a shield icon over 'guards', and a lightning bolt over 'runners'. Dotted arrows show planned movement paths for each role. Clear, sophisticated strategy-diagram flat illustration style.",
    },
    {
        "name": "🥏 Ultimate Frisbee League",
        "objective": "Play a full-length ultimate frisbee game applying complete rules and defensive strategy.",
        "materials": ["1 flying disc", "Cones for field boundaries and end zones", "Pinnies for 2 teams"],
        "steps": [
            "Set up a full field with end zones; split into 2 teams of equal size.",
            "Play to a set score (e.g., first to 7 points) or a time limit.",
            "Apply full rules: stall counts, turnovers on drops/interceptions/out-of-bounds.",
            "Rotate positions between offense and defense strategically as a team.",
        ],
        "safety_line": "No physical contact — maintain a safe guarding distance at all times.",
        "image_prompt": "A detailed full-field ultimate frisbee diagram with end zones at both ends, showing a 7-on-7 formation with players spread across the field in offensive and defensive positions, one thrower mid-release with a dotted trajectory toward a cutting receiver near the end zone. Clear, professional-style sports-diagram flat illustration.",
    },
    {
        "name": "🏈 Flag Football Scrimmage",
        "objective": "Run a structured flag football scrimmage applying downs, positions, and play strategy.",
        "materials": ["1 football", "Flag belts", "Cones for field markers and end zones"],
        "steps": [
            "Set up a field with yard markers and end zones; split into 2 teams.",
            "Offense gets 4 downs to advance the ball and score; huddle to call a play each down.",
            "Defense tries to pull flags to stop the play before the end zone.",
            "Switch offense/defense after a touchdown or turnover on downs.",
        ],
        "safety_line": "Only pull flags to stop a play — no tackling, blocking with force, or grabbing jerseys.",
        "image_prompt": "A detailed football field diagram with yard-marker cones and an end zone, showing an offensive formation huddled before a play, then a wide receiver running a route with a dotted path toward the end zone as a defender pursues, reaching for their flag belt. Clear, professional sports-diagram flat illustration style.",
    },
    {
        "name": "🏗️ Team Obstacle Course Design",
        "objective": "Design, build, and test a challenging obstacle course while considering safety and fairness.",
        "materials": ["Cones, hula hoops, jump ropes, chalk, and other available yard equipment"],
        "steps": [
            "In small teams, brainstorm and sketch an obstacle course with at least 6 stations.",
            "Build the course using available materials, checking for safety hazards.",
            "Have another team test-run your course and give feedback.",
            "Revise your course based on feedback, then host a final course-run event!",
        ],
        "safety_line": "Test every station yourself before letting others use it.",
        "image_prompt": "A wide detailed illustration showing a team of 4 students collaboratively planning an obstacle course on paper with a hand-drawn diagram, while in the background their partially-built course (cones, hoops, ropes) takes shape across the yard, with another team member testing a station. Bright, collaborative, colorful flat illustration style.",
    },
    {
        "name": "🔐 Scavenger Hunt Cipher",
        "objective": "Decode simple ciphers and clues to locate a sequence of hidden checkpoints.",
        "materials": ["Cipher clue cards (simple letter-shift codes)", "Hidden checkpoint markers"],
        "steps": [
            "Give each team a starting cipher clue that decodes into a location hint.",
            "Solve the cipher, go to that location, and find the next coded clue.",
            "Continue decoding and following clues through the whole trail.",
            "First team to decode the final clue and find the hidden prize wins!",
        ],
        "safety_line": "Stay within the boundaries a grown-up sets for the hunt.",
        "image_prompt": "An illustration of a clue card showing a simple letter-shift cipher (e.g., 'WUHH' with a decode arrow to 'TREE'), held by a child who is looking toward a large tree in the background where the next clue is hidden. A dotted path connects several such clue-cipher stops across a park setting. Bright, mysterious, adventurous flat illustration style with visible cipher text on the card.",
    },
    {
        "name": "⚽ Kickball Strategy League",
        "objective": "Apply advanced kickball strategy including defensive positioning and kicking placement.",
        "materials": ["1 kickball", "4 bases", "Scorecard"],
        "steps": [
            "Assign strategic fielding positions based on where kickers tend to send the ball.",
            "Kicking team discusses strategy for placing kicks to open field areas.",
            "Play a full multi-inning game, tracking outs, runs, and strategy adjustments between innings.",
            "Team with the most runs after all innings wins the league match!",
        ],
        "safety_line": "Run bases under control and avoid colliding with fielders.",
        "image_prompt": "A detailed kickball field diagram showing strategically positioned fielders covering gaps in the outfield, with a dotted arrow showing a kicker's planned kick placement toward an open area. A scoreboard corner tracks 'Inning 4, strategy notes: kick left field.' Clear, tactical sports-diagram flat illustration style.",
    },
    {
        "name": "🥏 Disc Golf Challenge",
        "objective": "Complete a full disc golf course using strategic throws to minimize total throw count.",
        "materials": ["1-2 flying discs", "8-9 target markers around the play area"],
        "steps": [
            "Set up an 8-9 hole disc golf course using buckets, trees, or cones as targets.",
            "Throw from the tee toward each target, then throw again from where the disc lands.",
            "Track your throw count for each hole on a scorecard.",
            "Lowest total throws across the whole course wins!",
        ],
        "safety_line": "Always check that your throwing lane is clear of people before throwing.",
        "image_prompt": "A detailed overhead disc-golf course map showing 9 numbered holes scattered across a park, each with a target bucket and a dotted throwing path with a small scorecard box showing throw counts. A player is shown at hole 5, mid-throw with a flying disc arcing toward the bucket target. Clear, professional course-map style flat illustration.",
    },
    {
        "name": "🏃 Team Relay Championship",
        "objective": "Coordinate a multi-leg relay combining running, jumping, and balance stations across a full team.",
        "materials": ["Cones, a jump rope, a balance beam or line, a baton"],
        "steps": [
            "Set up a relay with 4 different legs: sprint, jump-rope station, balance beam, and zigzag cones.",
            "Split into teams of 4, each assigned to one leg.",
            "Each runner completes their leg and hands off the baton to the next.",
            "Fastest team through all 4 legs wins the championship!",
        ],
        "safety_line": "Complete your leg's task fully before handing off — no skipping steps.",
        "image_prompt": "A detailed top-down relay-course diagram showing 4 distinct legs laid end-to-end: a sprint lane, a jump-rope station, a balance beam, and a zigzag cone course, each with a runner assigned and a baton exchange point marked between legs. Clear, energetic, professional sports-diagram flat illustration style.",
    },
    {
        "name": "🧭 Orienteering Challenge",
        "objective": "Use a compass and paced distances to navigate a multi-point course as accurately and quickly as possible.",
        "materials": ["Compass (or compass app)", "Course map with 6-8 numbered checkpoints and bearings"],
        "steps": [
            "Study the course map showing compass bearings and distances between checkpoints.",
            "Navigate from checkpoint to checkpoint using your compass and paced steps.",
            "Punch or mark your card at each checkpoint to prove you found it.",
            "Fastest accurate completion of the full course wins!",
        ],
        "safety_line": "Stay within the marked course boundaries and check in with a grown-up at each checkpoint.",
        "image_prompt": "A detailed orienteering course map illustration showing a compass rose and 7 numbered checkpoint flags connected by dotted bearing lines with distance labels (e.g., '50m NE'). A student is shown holding a compass up, sighting toward a checkpoint flag in the distance, map in the other hand. Clear, professional course-map style flat illustration.",
    },
    {
        "name": "💪 Tug of War Tournament",
        "objective": "Compete in a bracket-style tug of war tournament, adjusting team strategy between matches.",
        "materials": ["1 thick rope", "Chalk for center lines", "Tournament bracket sheet"],
        "steps": [
            "Split into several small teams for a bracket tournament.",
            "Each match, teams pull against each other; winner advances in the bracket.",
            "Between matches, teams can discuss strategy (foot placement, timing, grip).",
            "The team that wins all their matches becomes tournament champion!",
        ],
        "safety_line": "Wear closed-toe shoes, and let go immediately if you feel unsteady.",
        "image_prompt": "A detailed illustration showing a tug-of-war tournament bracket board on an easel beside the play area, with two teams currently pulling against a rope marked with a center ribbon. Previous match results are shown checked off on the bracket. Bright, competitive, colorful flat illustration style.",
    },
    {
        "name": "🔲 Four Square Masters",
        "objective": "Apply advanced four-square techniques and special rules in competitive play.",
        "materials": ["1 bouncy ball", "Chalk for the court", "List of 'special rule' cards (optional advanced moves)"],
        "steps": [
            "Draw a 4-square court with squares numbered 1 to 4.",
            "Play standard rules, but allow special moves like 'around the world' (ball must bounce in every square before returning).",
            "Track how many rounds each player holds square 4 ('king/queen').",
            "Player with the longest total reign as king/queen is the Four Square Master!",
        ],
        "safety_line": "Hit with an open hand only, and call out clearly if the ball is out.",
        "image_prompt": "A bird's-eye diagram of a 4-square court with squares numbered 1-4, showing a dotted 'around the world' ball path bouncing through all 4 squares in sequence with small numbered arrows (1→2→3→4). Players stand ready in each square. Clear, detailed diagram-style flat illustration.",
    },
    {
        "name": "🤝 Team Building Trust Walk",
        "objective": "Build communication and trust by guiding a blindfolded partner safely through a simple course.",
        "materials": ["Blindfolds (bandanas)", "Cones or soft obstacles to navigate around"],
        "steps": [
            "Pair up; one partner wears a blindfold, the other gives verbal directions only.",
            "Set up a simple path with a few soft obstacles (cones) to walk around.",
            "The guiding partner uses clear words (not touch) to direct their partner safely through.",
            "Switch roles and try again — discuss what communication worked best!",
        ],
        "safety_line": "Guides must speak clearly and walk close by in case their partner needs help.",
        "image_prompt": "An outdoor illustration showing a blindfolded student walking carefully with hands slightly out, while their partner walks a few steps behind giving directions (shown with a speech bubble containing simple arrow icons for 'left' and 'forward'). Soft cone obstacles are placed along the path. Bright, warm, trust-building flat illustration style.",
    },
    {
        "name": "🏐 Speedball Basics",
        "objective": "Combine soccer, basketball, and football movements in a fast-paced hybrid game.",
        "materials": ["1 soccer-style ball", "Cones for boundaries and goals"],
        "steps": [
            "Set up a field with a goal at each end.",
            "Players can kick the ball on the ground OR pick it up and pass it by hand once it's in the air (popped up).",
            "Score by kicking the ball into the goal, or by a caught pass inside the goal area.",
            "Play with 2 teams, switching between ground and air play as the ball moves.",
        ],
        "safety_line": "No pushing or grabbing — steal the ball with your feet or hands only, never a player.",
        "image_prompt": "A dynamic field diagram illustration showing a player dribbling a ball with their foot near midfield, then another player mid-catch after the ball popped into the air, both goals marked with cones at either end. Dotted lines show the transition from ground play to air play. Clear, energetic sports-diagram flat illustration style.",
    },
    {
        "name": "💧 Water Relay Olympics",
        "objective": "Compete in a multi-station water-themed relay combining speed, balance, and teamwork.",
        "materials": ["Buckets, sponges, cups, water balloons", "Cones marking 3-4 stations"],
        "steps": [
            "Set up 3-4 water-themed stations: sponge squeeze relay, cup-carry balance walk, water balloon toss.",
            "Split into teams; each runner completes all stations before tagging the next teammate.",
            "Track team times or points across each station.",
            "Team with the best overall performance wins the Water Relay Olympics!",
        ],
        "safety_line": "Watch for slippery wet ground and walk carefully between stations.",
        "image_prompt": "A wide illustration showing a 3-station water relay course: a sponge-squeeze station with two buckets, a cup-carry balance walk with a child concentrating on not spilling, and a water balloon toss between two players. Bright splashy water droplets throughout, sunny summer background. Colorful, energetic flat illustration style, no text.",
    },
]


GAMES[7] = [
    {
        "name": "🚩 Capture the Flag: Championship",
        "objective": "Lead a full team through a multi-round championship applying complex strategy and sportsmanship.",
        "materials": ["2 flags", "Cones for boundaries and jail zones", "Pinnies for teams"],
        "steps": [
            "Split into 2 teams; elect a team captain to help coordinate strategy.",
            "Play 3 timed rounds, allowing teams to adjust roles and strategy between rounds based on what worked.",
            "Track captures, tags, and jailbreaks across all 3 rounds.",
            "Team with the most successful captures across all rounds is champion!",
        ],
        "safety_line": "Tag with an open hand only, and settle any disputes calmly using good sportsmanship.",
        "image_prompt": "A championship-style aerial tactical map illustration showing a large field with two territories, flags, and jail zones, with a team captain icon (small star badge) shown near a huddle of players planning strategy with hand gestures pointing across the map. A scoreboard corner tracks 'Round 2: Blue 1 - Red 0'. Clear, sophisticated, professional strategy-diagram flat illustration style.",
    },
    {
        "name": "🥏 Ultimate Frisbee Tournament",
        "objective": "Compete in a bracket-style ultimate frisbee tournament applying full rules and sportsmanship (the 'Spirit of the Game').",
        "materials": ["1 flying disc per field", "Cones for boundaries and end zones", "Bracket sheet"],
        "steps": [
            "Split into several teams for a round-robin or bracket tournament.",
            "Play each match to a set point total or time limit, self-officiating calls fairly (Spirit of the Game).",
            "Track wins/losses or points across all matches.",
            "Team with the best overall record becomes tournament champion!",
        ],
        "safety_line": "Ultimate is self-officiated — call your own fouls honestly and resolve disagreements respectfully.",
        "image_prompt": "A detailed tournament illustration showing two ultimate frisbee fields side by side with games in progress, and a bracket board nearby tracking match results with small trophy icons next to advancing teams. Players are shown mid-game making a fair-play handshake gesture after a contested call. Clear, professional, sportsmanship-themed flat illustration style.",
    },
    {
        "name": "🏈 Flag Football League",
        "objective": "Play a full flag football league match applying offensive plays, defensive coverage, and scoring strategy.",
        "materials": ["1 football", "Flag belts", "Cones for yard markers and end zones", "Scorecard"],
        "steps": [
            "Set up a full field with yard markers; split into 2 teams with assigned positions.",
            "Offense huddles to call plays each down; defense calls coverage assignments.",
            "Play a full game to a point total or time limit, tracking downs and score.",
            "Team with the most points at the end wins the league match!",
        ],
        "safety_line": "Only pull flags to end a play — no tackling or excessive contact.",
        "image_prompt": "A detailed full football field diagram showing an offensive formation lined up against a defensive formation, with a play-call huddle icon shown before the snap and a dotted route line showing a receiver's path after the snap. A scoreboard shows 'Q3: Home 14 - Away 10'. Clear, professional sports-diagram flat illustration style.",
    },
    {
        "name": "🧗 Leadership Obstacle Course",
        "objective": "Take turns leading a team through an obstacle course using only verbal instructions.",
        "materials": ["Cones, hula hoops, jump ropes for an obstacle course", "Blindfolds (optional challenge mode)"],
        "steps": [
            "Set up a multi-station obstacle course as a team.",
            "One student is the 'Leader' and must verbally guide a teammate (who can't see the course layout) through it.",
            "The teammate follows only the Leader's spoken directions to complete each station.",
            "Rotate Leaders so everyone gets a turn practicing clear communication!",
        ],
        "safety_line": "Leaders must give clear, safe directions and watch closely in case help is needed.",
        "image_prompt": "A detailed illustration showing a student standing to the side with a megaphone-style speech bubble giving directions ('Left! Now crawl under!'), while a blindfolded teammate carefully navigates a multi-station obstacle course (cones, hoops, a low rope) based on those instructions. Bright, focused, collaborative flat illustration style.",
    },
    {
        "name": "🧭 Orienteering Expedition",
        "objective": "Navigate an extended multi-checkpoint course using compass bearings, pacing, and map reading as a team.",
        "materials": ["Compass (or compass app)", "Detailed course map with 8-10 checkpoints and bearings/distances"],
        "steps": [
            "Study the full course map showing all checkpoints, bearings, and distances.",
            "As a team, plan the most efficient order to visit checkpoints.",
            "Navigate the full expedition, recording your time and route at each checkpoint.",
            "Team with the fastest accurate completion of the full expedition wins!",
        ],
        "safety_line": "Stay together as a team and within marked boundaries throughout the expedition.",
        "image_prompt": "A detailed expedition-style course map illustration showing a compass rose and 10 numbered checkpoint flags scattered across a large park area, connected by dotted bearing lines with distance labels, and a small planning table showing a team's chosen route order. A group of students is shown consulting a map and compass together at a checkpoint. Clear, professional, adventurous course-map style flat illustration.",
    },
    {
        "name": "🥏 Disc Golf Tournament",
        "objective": "Compete across a full disc golf course, applying strategic throw selection to achieve the lowest score.",
        "materials": ["1-2 flying discs per player", "9-hole course with target markers", "Scorecards"],
        "steps": [
            "Play a full 9-hole disc golf course, recording throw counts per hole on a scorecard.",
            "Discuss throw strategy with your group between holes (distance vs. accuracy).",
            "Total your scores after all 9 holes.",
            "Lowest total score across the whole course wins the tournament!",
        ],
        "safety_line": "Always confirm the throwing lane is clear before every throw.",
        "image_prompt": "A detailed 9-hole disc-golf tournament scorecard illustration alongside an overhead course map showing all 9 holes with target buckets, and a player mid-throw at hole 6 with a dotted trajectory arc. The scorecard shows running totals for multiple players. Clear, professional, tournament-style flat illustration.",
    },
    {
        "name": "🗝️ Team Strategy Scavenger Hunt",
        "objective": "Plan and execute a team strategy to efficiently solve multi-step clues and puzzles across a wide area.",
        "materials": ["6-8 multi-step clue cards (riddles, simple ciphers, math clues)", "Hidden final prize"],
        "steps": [
            "As a team, review all starting clues together and divide tasks if clues can be solved in parallel.",
            "Solve each clue to reveal the next checkpoint location.",
            "Regroup to combine information if some clues depend on others.",
            "First team to solve the full trail and find the final prize wins!",
        ],
        "safety_line": "Stay within the boundaries a grown-up sets and check in regularly.",
        "image_prompt": "An illustrated overhead treasure-hunt map showing 7 numbered clue locations scattered across a park, connected by dotted paths, with small icons showing different clue types (a riddle scroll, a cipher lock, a math symbol) at different stops. A team of 3 students is shown huddled together comparing notes at a central meeting point. Bright, strategic, adventurous flat illustration style.",
    },
    {
        "name": "🏐 Speedball Match",
        "objective": "Apply combined soccer/basketball/football rules in a full competitive speedball match.",
        "materials": ["1 soccer-style ball", "Cones for boundaries and goals", "Pinnies for 2 teams"],
        "steps": [
            "Set up a field with a goal at each end; split into 2 teams.",
            "Play with combined rules: ground play uses feet only, air play (ball popped up) can be caught and passed by hand.",
            "Score by kicking into the goal or completing a caught pass inside the goal area.",
            "Play a full timed match, tracking the score for each team!",
        ],
        "safety_line": "No pushing, grabbing, or aggressive contact — steal the ball fairly.",
        "image_prompt": "A detailed full-field speedball diagram showing a 2-team match in progress: one side shows ground dribbling with feet near midfield, the other shows an aerial catch-and-pass sequence near the goal, both goals marked clearly at each end. Dynamic motion lines throughout. Clear, professional sports-diagram flat illustration style.",
    },
    {
        "name": "💪 Tug of War Finals",
        "objective": "Compete in a high-stakes tug of war final applying refined team strategy and timing.",
        "materials": ["1 thick rope", "Chalk for center line", "Tournament bracket sheet showing finalists"],
        "steps": [
            "The two remaining tournament teams face off for the championship.",
            "Before pulling, each team huddles to finalize foot placement, grip order, and pulling rhythm.",
            "On 'go,' pull together with coordinated timing and calls.",
            "The team that pulls the rope's center marker past their line wins the championship!",
        ],
        "safety_line": "Wear closed-toe shoes, and let go immediately if you feel unsteady or start to fall.",
        "image_prompt": "A dramatic championship-style illustration of two evenly matched teams straining against a thick rope with a ribbon center marker, chalk line beneath them, a small trophy icon and 'FINALS' banner shown above the scene. Both teams show intense, determined expressions leaning back in coordinated form. Bright, high-energy flat illustration style.",
    },
    {
        "name": "🔁 Relay Olympics",
        "objective": "Compete across a full multi-event relay Olympics combining speed, skill, and teamwork events.",
        "materials": ["Cones, jump ropes, batons, balance beams, and other relay equipment"],
        "steps": [
            "Set up 4-5 different relay events (sprint relay, jump-rope relay, balance-beam relay, obstacle relay).",
            "Split into teams; each team competes in every event, earning points based on placement.",
            "Track total points across all events on a scoreboard.",
            "Team with the most total points after all events wins the Relay Olympics!",
        ],
        "safety_line": "Complete every event fully and fairly before moving to the next.",
        "image_prompt": "A wide 'Olympics'-themed illustration showing 4 different relay event stations happening simultaneously across a field (a sprint lane, a jump-rope station, a balance beam, an obstacle zigzag), with a large scoreboard in the background tracking points per team, plus small medal icons. Bright, festive, high-energy flat illustration style.",
    },
    {
        "name": "🤝 Team Building Challenge Course",
        "objective": "Solve a series of cooperative physical challenges that require full-team communication and trust.",
        "materials": ["Jump ropes, hula hoops, a tarp or blanket, cones"],
        "steps": [
            "Set up 3-4 cooperative challenges (e.g., whole team must cross a 'lava zone' using only 2 hula hoops as stepping stones).",
            "As a team, discuss and plan your strategy before attempting each challenge.",
            "Complete each challenge together — if a rule is broken, the team restarts that challenge.",
            "Reflect as a group afterward: what teamwork strategies worked best?",
        ],
        "safety_line": "Move carefully during challenges — the goal is cooperation, not speed.",
        "image_prompt": "An illustration showing a full team of 6 students working together to cross a marked 'lava zone' (a chalked-off area) using only 2 hula hoops as stepping stones, passed carefully from person to person while others wait their turn balanced on a hoop. Bright, collaborative, focused flat illustration style, no text besides a 'LAVA ZONE' chalk-style label.",
    },
    {
        "name": "⚽ Kickball Championship",
        "objective": "Apply full strategic kickball play across a championship-level multi-inning match.",
        "materials": ["1 kickball", "4 bases", "Scorecard"],
        "steps": [
            "Set defensive positions strategically based on scouting the other team's kicking tendencies.",
            "Play a full championship match (5+ innings), tracking outs, runs, and strategy adjustments.",
            "Discuss strategy adjustments as a team between innings.",
            "Team with the most runs at the end of the match is champion!",
        ],
        "safety_line": "Run bases under control, and communicate clearly to avoid collisions with fielders.",
        "image_prompt": "A championship-style kickball field diagram showing a strategically positioned defense (shifted toward one side based on a scouting note), a runner sliding safely into a base, and a scoreboard showing 'Championship: Inning 5, Blue 6 - Red 5'. Clear, competitive, professional sports-diagram flat illustration style.",
    },
    {
        "name": "🔲 Four Square Pro League",
        "objective": "Compete in an ongoing four-square league applying advanced strategy and special move rules.",
        "materials": ["1 bouncy ball", "Chalk for the court", "League standings sheet"],
        "steps": [
            "Draw a 4-square court; establish a rotation line for waiting challengers.",
            "Play using advanced rules (allow special moves like spins or lobs, agreed on beforehand).",
            "Track each player's total time spent as 'king/queen' of square 4 across multiple sessions.",
            "Keep a running league standings sheet — top scorer at the end of the week is Pro League Champion!",
        ],
        "safety_line": "Hit with an open hand only, and keep special moves controlled and safe.",
        "image_prompt": "A detailed bird's-eye four-square court diagram showing advanced play in action — a ball mid-lob arcing high over square 2 toward square 4 — with a league standings clipboard nearby showing player names and total 'king/queen' time. Clear, competitive, professional diagram-style flat illustration.",
    },
    {
        "name": "🏃 Fitness Circuit Relay",
        "objective": "Complete a fast-paced circuit combining strength, cardio, and agility stations as a team.",
        "materials": ["Cones for 6 stations", "A jump rope", "A stopwatch (or phone timer)"],
        "steps": [
            "Set up 6 stations in a loop: jumping jacks, jump rope, high knees, lunges, sprint, plank hold.",
            "Split into teams; each runner does a set amount at each station (e.g., 10 jumping jacks) before moving to the next.",
            "Time each team's total circuit completion.",
            "Team with the fastest full circuit (done correctly at every station) wins!",
        ],
        "safety_line": "Use good form at each station — speed matters less than doing each exercise correctly and safely.",
        "image_prompt": "A top-down circuit-training diagram illustration showing 6 stations arranged in a loop, each marked with a small icon showing the exercise (jumping jacks, jump rope, high knees, lunges, a sprint arrow, a plank pose), connected by a dotted path with numbered station markers 1-6. A student is shown mid-exercise at the jump-rope station. Clear, energetic, professional fitness-diagram flat illustration style.",
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
    out.append("-- 68_outdoor_games_content.sql")
    out.append("-- Adds an 'Outdoor Games' category to the existing always-on 'health'")
    out.append("-- subject_area for every grade (TK-6th) — no schema or proc changes needed,")
    out.append("-- reuses dbo.PacketSubjectAreas/usp_GetOrCreateWeeklyPacket exactly as-is.")
    out.append("--")
    out.append("-- Each grade gets a pool of 14 games; target_count=7 (fixed, not the usual")
    out.append("-- ~65% auto-rebalance ratio) means the existing NEWID()-sampling rotation")
    out.append("-- serves a different 7-of-14 combination most weeks a grade's health")
    out.append("-- category is selected, satisfying \"7 outdoor games, different set each")
    out.append("-- week\" without any manual per-week authoring.")
    out.append("--")
    out.append("-- Each game is ONE PacketQuestions row: prompt carries the Name/Objective/")
    out.append("-- Materials, diagram_type='sequence_steps' carries the Step-by-Step")
    out.append("-- Instructions (already-shipped diagram type, renders as a numbered list in")
    out.append("-- both the app and print — see 63_whole_child_rotation.sql). The requested")
    out.append("-- 'Image Instruction' (a prompt for an illustrator/AI image generator) has")
    out.append("-- no home in the schema — nothing in Weekly Packets renders raster images")
    out.append("-- today, only code-drawn diagrams — so those prompts are NOT stored here;")
    out.append("-- see games_image_prompts.md (generated alongside this file) instead.")
    out.append("-- See gen_68_outdoor_games_content.py.")
    out.append("")
    out.append("IF NOT EXISTS (SELECT 1 FROM dbo.PacketCategories WHERE subject_area = 'health' AND category_name = 'Outdoor Games')")
    out.append("BEGIN")

    for grade_id in GRADE_IDS:
        games = GAMES[grade_id]
        assert len(games) == 14, f"grade {grade_id} has {len(games)} games, expected 14"
        var = f"@cat_outdoor_{grade_id}"
        out.append(f"    DECLARE {var} INT;")
        out.append(
            f"    INSERT INTO dbo.PacketCategories (grade_id, subject_area, category_name, layout_type, target_count, intro_text, is_core)\n"
            f"        VALUES ({grade_id}, 'health', N'Outdoor Games', 'space_heavy', 7, N'Pick a game below and play it outside with friends or family this week!', 0);"
        )
        out.append(f"    SET {var} = SCOPE_IDENTITY();")
        for qi, game in enumerate(games, start=1):
            prompt = build_prompt(game)
            diagram_data = {"steps": game["steps"]}
            cols = ["category_id", "question_type", "prompt", "choices_json", "answer_text", "sort_order", "diagram_type", "diagram_data"]
            vals = [var, esc("short_response"), esc(prompt), "NULL", esc(game["safety_line"]), str(qi),
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
    out.append("# Outdoor Games — Illustrator / AI Image-Generation Prompts")
    out.append("")
    out.append("Reference doc only — not stored in the app database (nothing in Weekly")
    out.append("Packets renders raster images today). One detailed prompt per game, organized")
    out.append("by grade, for a future illustration pass.")
    out.append("")
    for grade_id in GRADE_IDS:
        out.append(f"## {GRADE_LABELS[grade_id]}")
        out.append("")
        for game in GAMES[grade_id]:
            out.append(f"### {game['name']}")
            out.append("")
            out.append(game["image_prompt"])
            out.append("")
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
    print(f"Grades: {len(GAMES)}, Total games: {total_games}", file=sys.stderr)
    # newline="" prevents Python's default Windows text-mode translation of
    # "\n" to "\r\n" — without it, every embedded "\n\n" inside a prompt
    # string (used to separate Name/Objective/Materials) gets written as a
    # literal "\r\n" into the SQL file, which then lands as-is inside the
    # quoted N'...' string literal and gets stored verbatim in the database.
    # Hit this for real: shipped 112 rows with \r\n before catching it.
    #
    # encoding="utf-8-sig" (adds a UTF-8 BOM) is likewise required: sqlcmd.exe
    # fed a BOM-less UTF-8 file misdetects the codepage and double-encodes
    # EVERY non-ASCII character on the way in (emoji, em-dashes, middle-dots,
    # curly quotes -- not just one specific character). Hit this for real
    # too: ~400 rows across every Games category shipped corrupted before the
    # BOM fix was found and applied via a one-off pyodbc repair pass.
    with open(r"D:\Project\www\littlescholarhub\lsh.database\68_outdoor_games_content.sql", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_sql())
    with open(r"D:\Project\www\littlescholarhub\scratch_tmp\games_image_prompts.md", "w", encoding="utf-8-sig", newline="") as f:
        f.write(emit_image_prompts_doc())
    print("Wrote 68_outdoor_games_content.sql and games_image_prompts.md", file=sys.stderr)
