-- 86_outdoor_games_player_counts.sql
-- Adds a "Players: <value>" line to every Outdoor Games game's prompt text
-- (448 games across all 8 grades), inserted right after "Objective:" and
-- before "Materials:" — matching the existing structured-prompt convention
-- ("Objective:"/"Materials:"/"80s Inspiration:") that
-- GET /content/outdoor-games (content.py) and the admin Outdoor Games
-- Library screen already parse by line prefix. Values are judgment calls
-- based on each game's actual mechanic (relay/team games get "Teams of
-- 2+", chase/tag games get a minimum group size, solo skill challenges
-- get "1+ (solo or group)", etc.) — not a formula, read per game.
-- All other text (emoji, wording, punctuation, any 80s-Inspiration line)
-- is preserved byte-for-byte; only the new Players line was added.

UPDATE dbo.PacketQuestions SET prompt = N'🐸 Animal Walk Relay

Objective: Practice moving like different animals while taking turns with friends.

Players: Teams of 2+ (2 or more teams)

Materials: 2 cones or chairs (start/finish markers) | Open grass area

Follow the steps below to play!' WHERE question_id = 4018;

UPDATE dbo.PacketQuestions SET prompt = N'🫧 Bubble Pop Dash

Objective: Chase and pop bubbles to practice running, reaching, and having fun outside.

Players: 1+ (solo or group)

Materials: Bubble solution and wand (or bubble machine)

Follow the steps below to play!' WHERE question_id = 4019;

UPDATE dbo.PacketQuestions SET prompt = N'🌈 Color Hunt Hop

Objective: Find and hop to matching colors while exploring outside.

Players: 1+ (solo or group)

Materials: 5-6 sheets of colored paper or chalk-drawn color circles | Sidewalk chalk (optional)

Follow the steps below to play!' WHERE question_id = 4020;

UPDATE dbo.PacketQuestions SET prompt = N'🐾 Follow the Leader Trail

Objective: Copy a leader''s fun movements while walking along an outdoor path.

Players: 2-4 players

Materials: None — just open outdoor space

Follow the steps below to play!' WHERE question_id = 4021;

UPDATE dbo.PacketQuestions SET prompt = N'👥 Shadow Tag

Objective: Practice moving quickly and carefully while playing a gentle version of tag.

Players: 3+ players

Materials: Sunny outdoor space (needs visible shadows)

Follow the steps below to play!' WHERE question_id = 4022;

UPDATE dbo.PacketQuestions SET prompt = N'💃 Freeze Dance Outside

Objective: Dance freely to music, then freeze completely still when the music stops.

Players: 1+ (solo or group)

Materials: Music player or phone with speaker

Follow the steps below to play!' WHERE question_id = 4023;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Parachute Popcorn

Objective: Work together to bounce a ball high using a shared parachute or blanket.

Players: Whole group (6+)

Materials: Play parachute or large lightweight blanket | Soft foam ball or beanbag

Follow the steps below to play!' WHERE question_id = 4024;

UPDATE dbo.PacketQuestions SET prompt = N'🦆 Duck Duck Goose

Objective: Practice quick reactions and taking turns in a classic circle game.

Players: Whole group (6+)

Materials: None — just a group and open grass

Follow the steps below to play!' WHERE question_id = 4025;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Rainbow Ring Toss

Objective: Practice aiming and throwing rings onto colorful targets.

Players: 1+ (solo or group)

Materials: 3-4 plastic rings or hula hoops | 1-2 traffic cones or bottles as targets

Follow the steps below to play!' WHERE question_id = 4026;

UPDATE dbo.PacketQuestions SET prompt = N'🦁 Sleeping Lions

Objective: Practice lying still and calm, like a resting lion, for as long as possible.

Players: 1+ (solo or group)

Materials: Soft grass or blanket to lie on

Follow the steps below to play!' WHERE question_id = 4027;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Balloon Bounce Walk

Objective: Practice balance and gentle movement while keeping a balloon in the air.

Players: 1+ (solo or group)

Materials: 1 balloon per child

Follow the steps below to play!' WHERE question_id = 4028;

UPDATE dbo.PacketQuestions SET prompt = N'🔍 Nature Scavenger Stroll

Objective: Explore outside and find simple items from nature.

Players: 1+ (solo or group)

Materials: Simple picture list (leaf, rock, flower, stick, feather)

Follow the steps below to play!' WHERE question_id = 4029;

UPDATE dbo.PacketQuestions SET prompt = N'👂 Simon Says Outside

Objective: Practice listening carefully and following movement directions.

Players: 2-4 players

Materials: None — just open outdoor space

Follow the steps below to play!' WHERE question_id = 4030;

UPDATE dbo.PacketQuestions SET prompt = N'⚽ Roll the Big Ball

Objective: Practice rolling and catching a large, soft ball with a partner.

Players: 2 players

Materials: 1 large soft ball (beach ball or exercise ball)

Follow the steps below to play!' WHERE question_id = 4031;

UPDATE dbo.PacketQuestions SET prompt = N'🍽️ Paper Plate Toss

Objective: Practice tossing and aiming using paper plates as flying discs. Works indoors or outdoors.

Players: 1+ (solo or group)

Materials: 2-3 paper plates | A laundry basket or box as a target

Follow the steps below to play!' WHERE question_id = 4130;

UPDATE dbo.PacketQuestions SET prompt = N'🧦 Sock Ball Basket

Objective: Practice tossing a soft rolled-up sock into a basket target.

Players: 1+ (solo or group)

Materials: 2-3 pairs of socks rolled into balls | A laundry basket or bucket

Follow the steps below to play!' WHERE question_id = 4131;

UPDATE dbo.PacketQuestions SET prompt = N'🍂 Leaf & Stick Sorting

Objective: Collect and sort natural items by size, color, or shape.

Players: 1+ (solo or group)

Materials: Leaves and sticks found outside | 2-3 sorting bins or hoops (optional)

Follow the steps below to play!' WHERE question_id = 4132;

UPDATE dbo.PacketQuestions SET prompt = N'🛏️ Pillow Path Walk

Objective: Practice balance and big steps by walking across a path of pillows.

Players: 1+ (solo or group)

Materials: 4-5 pillows or couch cushions

Follow the steps below to play!' WHERE question_id = 4133;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Spoon and Cotton Ball Walk

Objective: Practice balance and steady hands by carrying a cotton ball on a spoon.

Players: 1+ (solo or group)

Materials: 1 spoon per player | 1 cotton ball (or pom-pom) per player

Follow the steps below to play!' WHERE question_id = 4134;

UPDATE dbo.PacketQuestions SET prompt = N'✈️ Paper Airplane Fly-Off

Objective: Make a simple paper airplane and practice throwing it.

Players: 1+ (solo or group)

Materials: 1 sheet of paper per player

Follow the steps below to play!' WHERE question_id = 4135;

UPDATE dbo.PacketQuestions SET prompt = N'🔍 Nature Texture Hunt

Objective: Explore outside and find things that feel different — smooth, rough, soft, bumpy.

Players: 1+ (solo or group)

Materials: None — just curious hands and open outdoor space

Follow the steps below to play!' WHERE question_id = 4136;

UPDATE dbo.PacketQuestions SET prompt = N'🙈 Hide and Seek

Objective: Practice counting and finding hidden friends using only your eyes and ears.

Players: 3+ players

Materials: None — just kids and a safe space to hide in!

Follow the steps below to play!' WHERE question_id = 4186;

UPDATE dbo.PacketQuestions SET prompt = N'🪞 Copy Cat

Objective: Practice careful watching by copying a leader''s movements exactly.

Players: 2 players

Materials: None — just kids standing face to face!

Follow the steps below to play!' WHERE question_id = 4187;

UPDATE dbo.PacketQuestions SET prompt = N'🦁 Animal Sound Guess

Objective: Practice listening and guessing which animal sound a friend is making.

Players: 2-4 players

Materials: None — just voices!

Follow the steps below to play!' WHERE question_id = 4188;

UPDATE dbo.PacketQuestions SET prompt = N'🚶 Silly Walk Parade

Objective: Practice inventing and following different silly ways of walking.

Players: 1+ (solo or group)

Materials: None — just kids and open space to walk in!

Follow the steps below to play!' WHERE question_id = 4189;

UPDATE dbo.PacketQuestions SET prompt = N'🦊 What Time Is It, Mr. Fox?

Objective: Practice counting and quick reactions in a classic chasing game.

Players: 3+ players

Materials: None — just kids and open space!

Follow the steps below to play!' WHERE question_id = 4190;

UPDATE dbo.PacketQuestions SET prompt = N'👍 Thumbs Up, Thumbs Down

Objective: Practice sharing opinions quickly using a simple thumbs signal.

Players: 2-4 players

Materials: None — just thumbs!

Follow the steps below to play!' WHERE question_id = 4191;

UPDATE dbo.PacketQuestions SET prompt = N'🤫 Freeze and Listen

Objective: Practice staying still and noticing quiet sounds around you.

Players: 1+ (solo or group)

Materials: None — just quiet ears!

Follow the steps below to play!' WHERE question_id = 4192;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Toe-Tap Hopscotch

80s Inspiration: A simplified version of the classic hopscotch grid kids have chalked onto sidewalks for generations.

Objective: Practice hopping and balance on a simple 4-square chalk hopscotch course.

Players: 1+ (solo or group)

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 4242;

UPDATE dbo.PacketQuestions SET prompt = N'🥊 Freeze Tag Throwback

80s Inspiration: A classic schoolyard tag variant that''s been played on playgrounds for decades.

Objective: Practice quick running and freezing completely still when tagged, just like retro playground tag.

Players: 3+ players

Materials: None — just open space!

Follow the steps below to play!' WHERE question_id = 4243;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Big Rope Jump-In

80s Inspiration: A gentle version of the long jump-rope games where two turners swing a rope for others to jump in.

Objective: Practice timing and jumping by hopping into a gently-swinging long rope.

Players: 3+ players

Materials: 1 long jump rope

Follow the steps below to play!' WHERE question_id = 4244;

UPDATE dbo.PacketQuestions SET prompt = N'🧮 Bean Bag Toss Classic

80s Inspiration: A simple version of the beanbag toss games common on 1980s playgrounds and school fairs.

Objective: Practice tossing and aiming beanbags at a chalk-drawn target.

Players: 1+ (solo or group)

Materials: 3-4 beanbags | Playground chalk

Follow the steps below to play!' WHERE question_id = 4245;

UPDATE dbo.PacketQuestions SET prompt = N'🖍️ Chalk Path Walk

80s Inspiration: Inspired by the winding chalk paths and hopscotch trails kids used to draw across playgrounds.

Objective: Practice balance and following a path by walking along a winding chalk line.

Players: 1+ (solo or group)

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 4246;

UPDATE dbo.PacketQuestions SET prompt = N'🪑 Musical Chairs Throwback

80s Inspiration: The classic musical chairs game that''s been a party and playground favorite since long before the 1980s.

Objective: Practice quick reactions by finding a chair before the music stops.

Players: 3+ players

Materials: Chairs (one fewer than the number of players) | Music (clapping or humming works too!)

Follow the steps below to play!' WHERE question_id = 4247;

UPDATE dbo.PacketQuestions SET prompt = N'🤫 Statue Freeze Retro

80s Inspiration: A simple version of retro ''statues'' games where kids freeze in silly poses and try not to move.

Objective: Practice freezing in a funny pose and holding perfectly still.

Players: 1+ (solo or group)

Materials: None — just kids and open space!

Follow the steps below to play!' WHERE question_id = 4248;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Wave Hello

80s Inspiration: A gentle, safety-first take on the classic Red Rover call-and-cross game.

Objective: Practice walking confidently across an open space while friends cheer you on.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5306;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Baby Steps

80s Inspiration: A simplified version of the classic permission-asking playground game.

Objective: Practice listening carefully and following simple step directions.

Players: 2-4 players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5307;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Gentle Start

80s Inspiration: A slowed-down, walk-only version of the classic team retrieval game.

Objective: Practice quick walking and grabbing a soft object placed in the middle.

Players: Teams of 2+ (2 or more teams)

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!' WHERE question_id = 5308;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Hop Starter

80s Inspiration: A short, simple version of the classic field-day potato sack race.

Objective: Practice hopping while holding onto a soft sack or pillowcase.

Players: 1+ (solo or group)

Materials: 1 soft pillowcase or cloth sack per child

Follow the steps below to play!' WHERE question_id = 5309;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Wobble Walk

80s Inspiration: A gentle version of the classic field-day egg-and-spoon race, using a soft ball instead of a real egg.

Objective: Practice balancing a soft ball on a spoon while walking carefully.

Players: 1+ (solo or group)

Materials: 1 large spoon per child | 1 small soft ball or pom-pom per child

Follow the steps below to play!' WHERE question_id = 5310;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Buddy Steps Partner Walk

80s Inspiration: A safe warm-up version of the classic three-legged race, using linked arms instead of tied legs.

Objective: Practice walking in sync with a partner, side by side.

Players: 2 players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5311;

UPDATE dbo.PacketQuestions SET prompt = N'🌉 London Bridge Sing-Along

80s Inspiration: A classic traditional singing-and-movement circle game passed down for generations.

Objective: Practice moving through a bridge shape made by two friends'' raised arms, in time with a song.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5312;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pretend Pogo Hop

70s Inspiration: A safe, stick-free warm-up for the pogo stick craze that bounced across 1970s backyards.

Objective: Practice two-footed bouncing in place, like a pretend pogo stick, to build balance and rhythm.

Players: 1+ (solo or group)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5362;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 My First Kite Walk

70s Inspiration: A gentle introduction to kite flying, a favorite breezy-day activity of the 1970s.

Objective: Practice walking steadily while holding a kite string, to get a feel for how kites catch the wind.

Players: 1+ (solo or group)

Materials: 1 simple kite (or a kite-shaped paper cutout on a string)

Follow the steps below to play!' WHERE question_id = 5363;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Gentle Pass

70s Inspiration: A slowed-down, no-throwing version of the classic summer water balloon toss.

Objective: Practice careful, gentle hand-offs while passing a water balloon between friends.

Players: 2-4 players

Materials: A few small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5364;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Tricycle Path Ride

70s Inspiration: A gentle warm-up for the banana-bike and trike rodeos that filled 1970s driveways.

Objective: Practice steady steering and pedaling along a simple marked path.

Players: 1+ (solo or group)

Materials: A tricycle or ride-on toy | Chalk or cones to mark a simple path

Follow the steps below to play!' WHERE question_id = 5365;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Gentle Toss

70s Inspiration: A slowed-down, no-throwing version of the classic 1970s playground game Spud.

Objective: Practice listening for your name and freezing quickly in a gentle group ball game.

Players: 3+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5366;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Wheeled Wobble Walk

70s Inspiration: A gentle first step toward the skateboarding craze that took off in the 1970s.

Objective: Practice balance and slow, steady steps while holding onto a scooter or riding a trike.

Players: 1+ (solo or group)

Materials: A scooter, balance bike, or tricycle | A flat, open surface

Follow the steps below to play!' WHERE question_id = 5367;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Ride-Along

70s Inspiration: The iconic low-riding Big Wheel trike that was everywhere on 1970s driveways.

Objective: Practice pedaling and steering a low ride-on trike along a short, simple course.

Players: 1+ (solo or group)

Materials: A Big Wheel or similar low ride-on trike | Cones or chalk to mark a short path

Follow the steps below to play!' WHERE question_id = 5368;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Wobble Walk

90s Inspiration: A gentle first step toward the inline-skating craze that rolled through the 1990s.

Objective: Practice standing and taking small careful steps while wearing inline skates.

Players: 1+ (solo or group)

Materials: Inline skates (rollerblades) | Knee and elbow pads if you have them | A grown-up spotter

Follow the steps below to play!' WHERE question_id = 5418;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Gentle Squirt

90s Inspiration: A calm introduction to the water-gun water fights that soaked 1990s summer backyards.

Objective: Practice aiming a small water gun at a target with control.

Players: 1+ (solo or group)

Materials: 1 small water gun per child | A bucket or target (a chalk circle on a fence works too)

Follow the steps below to play!' WHERE question_id = 5419;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Gentle Version

90s Inspiration: A slowed-down version of the classic 1990s recess game Grounders.

Objective: Practice climbing onto and staying on playground equipment quickly and safely.

Players: 1+ (solo or group)

Materials: A low platform, step, or playground structure | A grown-up to call out

Follow the steps below to play!' WHERE question_id = 5420;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Flashlight Freeze

90s Inspiration: A gentle, early-evening version of the flashlight tag games that lit up 1990s neighborhoods.

Objective: Practice freezing in place the instant a flashlight beam touches you.

Players: 2-4 players

Materials: 1 flashlight | A small, safe yard at dusk

Follow the steps below to play!' WHERE question_id = 5421;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Wobble Walk

90s Inspiration: A gentle first step toward the kick-scooter craze that took off in the late 1990s.

Objective: Practice standing on a kick scooter and taking small pushes while holding the handlebars.

Players: 1+ (solo or group)

Materials: A kick scooter (2-wheeled push scooter) | A helmet | A flat, open surface

Follow the steps below to play!' WHERE question_id = 5422;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Dot Hop

90s Inspiration: A simple warm-up for the homemade chalk ''Twister'' games inspired by the classic board game''s 1990s popularity.

Objective: Practice hopping carefully from one colored chalk dot to another.

Players: 1+ (solo or group)

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 5423;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Gentle Swing

90s Inspiration: A gentle introduction to the yo-yo tricks that were a huge 1990s playground obsession.

Objective: Practice a simple up-and-down yo-yo motion to build hand coordination.

Players: 1+ (solo or group)

Materials: 1 yo-yo (a beginner, non-string-lock style works best)

Follow the steps below to play!' WHERE question_id = 5424;

UPDATE dbo.PacketQuestions SET prompt = N'🚦 Red Light, Green Light

Objective: Practice starting, stopping, and listening carefully to directions.

Players: 3+ players

Materials: None — just open grass space

Follow the steps below to play!' WHERE question_id = 4032;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Beanbag Toss Target

Objective: Practice aiming and tossing beanbags into target zones.

Players: 1+ (solo or group)

Materials: 3-4 beanbags | Hula hoop or chalk-drawn target circles | Sidewalk chalk (optional)

Follow the steps below to play!' WHERE question_id = 4033;

UPDATE dbo.PacketQuestions SET prompt = N'🦒 Animal Charades Tag

Objective: Act out animals while playing a gentle chasing game.

Players: 3+ players

Materials: Index cards with animal pictures (optional)

Follow the steps below to play!' WHERE question_id = 4034;

UPDATE dbo.PacketQuestions SET prompt = N'🎡 Hula Hoop Hop

Objective: Practice jumping and balance by hopping through a row of hoops.

Players: 1+ (solo or group)

Materials: 5-6 hula hoops

Follow the steps below to play!' WHERE question_id = 4035;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Hop Race

Objective: Practice jumping with both feet together in a fun hopping race.

Players: 2-4 players

Materials: 1 pillowcase or sack per player | 2 cones (start/finish)

Follow the steps below to play!' WHERE question_id = 4036;

UPDATE dbo.PacketQuestions SET prompt = N'🫧 Bubble Wand Chase

Objective: Chase, catch, and pop bubbles while running and jumping outside.

Players: 1+ (solo or group)

Materials: Bubble wand and solution

Follow the steps below to play!' WHERE question_id = 4037;

UPDATE dbo.PacketQuestions SET prompt = N'🎵 Musical Hoops

Objective: Practice quick movement and listening for when music stops.

Players: 3+ players

Materials: Hula hoops (one fewer than the number of players) | Music player

Follow the steps below to play!' WHERE question_id = 4038;

UPDATE dbo.PacketQuestions SET prompt = N'🍂 Nature Color Match

Objective: Find outdoor items that match a set of color cards.

Players: 1+ (solo or group)

Materials: 5-6 colored paper swatches or cards

Follow the steps below to play!' WHERE question_id = 4039;

UPDATE dbo.PacketQuestions SET prompt = N'🕳️ Obstacle Crawl Course

Objective: Move through a simple obstacle course using different movements.

Players: 1+ (solo or group)

Materials: Hula hoops, cones, a jump rope or pool noodle (for crawling under)

Follow the steps below to play!' WHERE question_id = 4040;

UPDATE dbo.PacketQuestions SET prompt = N'⭕ Ring Around Relay

Objective: Practice running in a loop and tagging a teammate to keep the relay going.

Players: Teams of 2+ (2 or more teams)

Materials: 2 cones to mark a loop

Follow the steps below to play!' WHERE question_id = 4041;

UPDATE dbo.PacketQuestions SET prompt = N'☁️ Cloud Watching Circle

Objective: Practice lying still, looking up, and imagining shapes in the clouds together.

Players: 1+ (solo or group)

Materials: A blanket to lie on (optional)

Follow the steps below to play!' WHERE question_id = 4042;

UPDATE dbo.PacketQuestions SET prompt = N'🗺️ Follow the Path Maze

Objective: Follow a chalk-drawn path from start to finish without stepping off.

Players: 1+ (solo or group)

Materials: Sidewalk chalk

Follow the steps below to play!' WHERE question_id = 4043;

UPDATE dbo.PacketQuestions SET prompt = N'🥅 Kick and Catch

Objective: Practice kicking a ball to a partner and catching it back.

Players: 2 players

Materials: 1 soft playground ball

Follow the steps below to play!' WHERE question_id = 4044;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Giant Steps

Objective: Practice asking politely and taking different-sized steps toward a goal.

Players: 2-4 players

Materials: None — just open space

Follow the steps below to play!' WHERE question_id = 4045;

UPDATE dbo.PacketQuestions SET prompt = N'📰 Newspaper Stomp Ball

Objective: Make a ball out of scrap paper and practice kicking it into a goal.

Players: 1+ (solo or group)

Materials: Old newspaper or scrap paper | Tape | 2 chairs or shoes as goal markers

Follow the steps below to play!' WHERE question_id = 4137;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Cup Stack Race

Objective: Practice fine motor skills and speed by stacking and unstacking cups.

Players: 2-4 players

Materials: 6-10 plastic cups per player

Follow the steps below to play!' WHERE question_id = 4138;

UPDATE dbo.PacketQuestions SET prompt = N'🎨 Rock Painting Match

Objective: Paint or color rocks with matching patterns, then find their pairs.

Players: 1+ (solo or group)

Materials: 6-8 smooth rocks (collected outside) | Washable paint or markers

Follow the steps below to play!' WHERE question_id = 4139;

UPDATE dbo.PacketQuestions SET prompt = N'⛺ Blanket Fort Builder

Objective: Work together to design and build a cozy fort using blankets and furniture.

Players: 2-4 players

Materials: 2-3 blankets or sheets | Chairs, couch cushions, or a table

Follow the steps below to play!' WHERE question_id = 4140;

UPDATE dbo.PacketQuestions SET prompt = N'🧷 Clothespin Drop

Objective: Practice hand-eye coordination by dropping clothespins into a target container.

Players: 1+ (solo or group)

Materials: 5-6 clothespins | 1 jar or narrow container

Follow the steps below to play!' WHERE question_id = 4141;

UPDATE dbo.PacketQuestions SET prompt = N'⛵ Paper Boat Race

Objective: Fold a simple paper boat and race it in water.

Players: 2-4 players

Materials: 1 sheet of paper per player | A tub, sink, or shallow puddle of water

Follow the steps below to play!' WHERE question_id = 4142;

UPDATE dbo.PacketQuestions SET prompt = N'🌿 Stick Balance Walk

Objective: Practice balance and focus by walking along a stick or rope laid on the ground.

Players: 1+ (solo or group)

Materials: A long stick, rope, or string laid straight on the ground

Follow the steps below to play!' WHERE question_id = 4143;

UPDATE dbo.PacketQuestions SET prompt = N'🙈 Hide and Seek: Team Edition

Objective: Practice teamwork by hiding together in small groups and staying quiet.

Players: 4+ players

Materials: None — just kids and a safe space!

Follow the steps below to play!' WHERE question_id = 4193;

UPDATE dbo.PacketQuestions SET prompt = N'✂️ Rock Paper Scissors Tournament

Objective: Practice quick decision-making in a bracket-style rock-paper-scissors competition.

Players: 4+ players

Materials: None — just hands!

Follow the steps below to play!' WHERE question_id = 4194;

UPDATE dbo.PacketQuestions SET prompt = N'🪞 Mirror Me

Objective: Practice focus and body control by mirroring a partner''s slow movements.

Players: 2 players

Materials: None — just kids facing each other!

Follow the steps below to play!' WHERE question_id = 4195;

UPDATE dbo.PacketQuestions SET prompt = N'📞 Whisper Down the Lane

Objective: Practice careful listening and speaking clearly in a message-passing chain.

Players: 4+ players

Materials: None — just a line of friends!

Follow the steps below to play!' WHERE question_id = 4196;

UPDATE dbo.PacketQuestions SET prompt = N'🎭 Animal Charades

Objective: Practice acting out and guessing animals without using words.

Players: 2-4 players

Materials: None — just bodies and imagination!

Follow the steps below to play!' WHERE question_id = 4197;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Classic Tag

Objective: Practice running, dodging, and quick tagging in the simplest chasing game.

Players: 3+ players

Materials: None — just kids and open space!

Follow the steps below to play!' WHERE question_id = 4198;

UPDATE dbo.PacketQuestions SET prompt = N'🐍 Follow the Snake

Objective: Practice moving together as a connected group, following a winding leader.

Players: 3+ players

Materials: None — just a line of friends holding shoulders!

Follow the steps below to play!' WHERE question_id = 4199;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Classic Hopscotch Ladder

80s Inspiration: The full classic hopscotch grid — single squares hopped on one foot, side-by-side squares landed on with both feet.

Objective: Practice hopping in a pattern of single and double squares along a chalk hopscotch ladder.

Players: 1+ (solo or group)

Materials: Playground chalk | A small stone or beanbag marker

Follow the steps below to play!' WHERE question_id = 4249;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Lite

80s Inspiration: A simplified version of Kick the Can, a beloved dusk-till-dark neighborhood game for generations of kids.

Objective: Practice hiding, sneaking, and quick running in a gentle version of the classic can-kicking game.

Players: 3+ players

Materials: 1 empty plastic bottle or bucket (standing in for the ''can'')

Follow the steps below to play!' WHERE question_id = 4250;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Long Rope Jump-In

80s Inspiration: The classic long jump-rope game where two turners swing a rope for others to run in and jump.

Objective: Practice timing your jump into a swinging long rope and jumping a few times before hopping out.

Players: 3+ players

Materials: 1 long jump rope

Follow the steps below to play!' WHERE question_id = 4251;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Beanbag Board Toss

80s Inspiration: A pavement version of the classic beanbag toss boards found at school carnivals and playgrounds.

Objective: Practice aiming beanbags at numbered chalk zones to score points.

Players: 1+ (solo or group)

Materials: 3-4 beanbags | Playground chalk

Follow the steps below to play!' WHERE question_id = 4252;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 TV Tag Retro

80s Inspiration: A playground twist on tag where calling out a word (like a TV show name) makes you safe for a few seconds.

Objective: Practice quick thinking and running by naming something to become briefly safe from tag.

Players: 3+ players

Materials: None — just open space!

Follow the steps below to play!' WHERE question_id = 4253;

UPDATE dbo.PacketQuestions SET prompt = N'🖍️ Four-Square Warm-Up

80s Inspiration: An easier version of Four Square, the classic ball-bouncing playground game played in a chalk-divided court.

Objective: Practice the basic bounce-and-hit rules of four square in a simplified starter version.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!' WHERE question_id = 4254;

UPDATE dbo.PacketQuestions SET prompt = N'🪑 Musical Spots Throwback

80s Inspiration: A no-chairs playground version of musical chairs, using chalk circles instead.

Objective: Practice quick reactions by finding an empty chalk spot before the music stops.

Players: 3+ players

Materials: Playground chalk | Music (clapping or humming works too!)

Follow the steps below to play!' WHERE question_id = 4255;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Gentle Version

80s Inspiration: A safety-first take on the classic Red Rover call-and-cross game.

Objective: Practice jogging lightly across an open space and gently letting go of hands.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5313;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Basics

80s Inspiration: The classic permission-asking playground game, with a few different step types.

Objective: Practice asking politely and following different types of movement steps.

Players: 2-4 players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5314;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Basics

80s Inspiration: The classic team game where a called player races to grab an object first.

Objective: Practice quick reactions, running, and gentle tagging in a team retrieval game.

Players: Teams of 2+ (2 or more teams)

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!' WHERE question_id = 5315;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Basics

80s Inspiration: The classic field-day potato sack race.

Objective: Practice hopping steadily in a sack over a short race distance.

Players: 2-4 players

Materials: 1 soft pillowcase or cloth sack per child

Follow the steps below to play!' WHERE question_id = 5316;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Basics

80s Inspiration: The classic field-day egg-and-spoon race, using a soft ball for safety.

Objective: Practice balancing a soft ball on a spoon while walking briskly.

Players: 1+ (solo or group)

Materials: 1 large spoon per child | 1 small soft ball or pom-pom per child

Follow the steps below to play!' WHERE question_id = 5317;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Three-Legged Race Basics

80s Inspiration: The classic field-day three-legged race.

Objective: Practice walking in sync with a partner whose ankle is gently tied to yours.

Players: 2 players

Materials: 1 soft scarf or strip of cloth per pair

Follow the steps below to play!' WHERE question_id = 5318;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Roller Skate Wobble Walk

80s Inspiration: A gentle introduction to the roller-skating relays that were everywhere on 1980s playgrounds.

Objective: Practice basic balance and small steps while wearing roller skates.

Players: 1+ (solo or group)

Materials: Roller skates (with a grown-up spotting) | A smooth, flat surface

Follow the steps below to play!' WHERE question_id = 5319;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick First Bounces

70s Inspiration: The pogo stick craze that bounced across countless 1970s backyards.

Objective: Practice a few real pogo stick bounces with a grown-up holding on for support.

Players: 1+ (solo or group)

Materials: A pogo stick (child-sized) | A grown-up spotter

Follow the steps below to play!' WHERE question_id = 5369;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Flying Basics

70s Inspiration: The classic breezy-day activity that filled 1970s parks and open fields.

Objective: Practice launching a kite into the wind and keeping it flying steady.

Players: 1+ (solo or group)

Materials: 1 kite with string

Follow the steps below to play!' WHERE question_id = 5370;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Basics

70s Inspiration: The classic summer water balloon toss, a 1970s backyard party staple.

Objective: Practice underhand tossing and catching a water balloon with a partner.

Players: 2 players

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5371;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Rodeo Basics

70s Inspiration: The banana-seat bike rodeos that were a rite of passage on 1970s driveways.

Objective: Practice steady pedaling and simple steering skills on a bike with training wheels.

Players: 1+ (solo or group)

Materials: A bike with training wheels | Cones or chalk to mark a simple course

Follow the steps below to play!' WHERE question_id = 5372;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Basics

70s Inspiration: The classic 1970s playground game where a called name means it''s your turn.

Objective: Practice quick listening, scattering, and freezing in the classic ball-calling game.

Players: 3+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5373;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard First Balance

70s Inspiration: The very first steps toward the skateboarding craze that exploded in the mid-1970s.

Objective: Practice standing steady on a skateboard while it stays still, with a grown-up holding a hand.

Players: 1+ (solo or group)

Materials: A skateboard | A helmet | A grown-up spotter

Follow the steps below to play!' WHERE question_id = 5374;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Race Basics

70s Inspiration: The iconic Big Wheel trike races that filled 1970s neighborhood driveways.

Objective: Practice pedaling a Big Wheel at a steady pace over a short measured distance.

Players: 1+ (solo or group)

Materials: A Big Wheel or similar low ride-on trike | Cones to mark a start and finish

Follow the steps below to play!' WHERE question_id = 5375;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade First Glide

90s Inspiration: The inline-skating boom that rolled onto nearly every 1990s sidewalk.

Objective: Practice a short, steady glide on inline skates with light support.

Players: 1+ (solo or group)

Materials: Inline skates (rollerblades) | A helmet and pads | A grown-up spotter

Follow the steps below to play!' WHERE question_id = 5425;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Target Practice

90s Inspiration: The Super Soaker water-gun craze that defined 1990s summer play.

Objective: Practice aiming accurately at multiple targets from a set distance.

Players: 1+ (solo or group)

Materials: 1 water gun per child | 2-3 targets (chalk circles or plastic cups on a fence)

Follow the steps below to play!' WHERE question_id = 5426;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Basics

90s Inspiration: The classic 1990s recess game where touching the ground means you''re caught.

Objective: Practice quick reactions to climb onto safe equipment when a signal is called.

Players: 1+ (solo or group)

Materials: Playground equipment (platforms, steps, a low wall) | A grown-up to be ''It''

Follow the steps below to play!' WHERE question_id = 5427;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Flashlight Tag Basics

90s Inspiration: The classic evening flashlight tag that lit up 1990s cul-de-sacs after dinner.

Objective: Practice quiet movement and quick tagging using a flashlight beam as the ''tag.''

Players: 3+ players

Materials: 1-2 flashlights | A safe, agreed-upon yard at dusk | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5428;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter First Glide

90s Inspiration: The kick-scooter craze that rolled through neighborhoods in the late 1990s.

Objective: Practice a longer, steady glide on a kick scooter while staying balanced.

Players: 1+ (solo or group)

Materials: A kick scooter | A helmet | A flat, smooth surface

Follow the steps below to play!' WHERE question_id = 5429;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Basics

90s Inspiration: A homemade, chalk-drawn version of the classic Twister board game, popular at 1990s block parties.

Objective: Practice placing hands and feet on different colored chalk dots without falling over.

Players: 1+ (solo or group)

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 5430;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Basics

90s Inspiration: The classic first real yo-yo skill that every 1990s yo-yo fan learned.

Objective: Practice the basic ''sleeper'' motion where the yo-yo spins at the bottom of the string before returning.

Players: 1+ (solo or group)

Materials: 1 yo-yo

Follow the steps below to play!' WHERE question_id = 5431;
UPDATE dbo.PacketQuestions SET prompt = N'🏁 Simple Relay Race

Objective: Work as a team to run and pass a baton as fast as possible.

Players: Teams of 2+ (2 or more teams)

Materials: 1 baton (or stick/ball) | 2 cones

Follow the steps below to play!' WHERE question_id = 4046;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Four Corners

Objective: Practice quick decision-making and quiet movement between four spots.

Players: 4+ players

Materials: 4 cones or markers to label corners of a square area

Follow the steps below to play!' WHERE question_id = 4047;

UPDATE dbo.PacketQuestions SET prompt = N'🦈 Gentle Sharks and Minnows

Objective: Practice running and dodging while trying to cross safely to the other side.

Players: 3+ players

Materials: 2 lines marked with chalk or cones (opposite ends of the play area)

Follow the steps below to play!' WHERE question_id = 4048;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Balloon Volleyball

Objective: Work with a partner to keep a balloon from touching the ground using a ''net.''

Players: 2 players

Materials: 1 balloon | A jump rope or string tied between two chairs as a net

Follow the steps below to play!' WHERE question_id = 4049;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Beanbag Bullseye

Objective: Practice aiming beanbags at a target to score points.

Players: 1+ (solo or group)

Materials: 4-5 beanbags | Chalk-drawn target circles or a hula hoop with a bucket in the middle

Follow the steps below to play!' WHERE question_id = 4050;

UPDATE dbo.PacketQuestions SET prompt = N'🏗️ Obstacle Course Challenge

Objective: Complete a multi-station obstacle course as quickly and safely as possible.

Players: 1+ (solo or group)

Materials: Cones, hula hoops, a jump rope, a small ramp or step (optional)

Follow the steps below to play!' WHERE question_id = 4051;

UPDATE dbo.PacketQuestions SET prompt = N'🧊 Freeze Tag

Objective: Practice running, dodging, and helping teammates get unfrozen.

Players: 3+ players

Materials: Open play space

Follow the steps below to play!' WHERE question_id = 4052;

UPDATE dbo.PacketQuestions SET prompt = N'🎡 Hula Hoop Toss

Objective: Practice tossing hula hoops onto a target for points.

Players: 1+ (solo or group)

Materials: 3-4 hula hoops | 1 cone or bottle as a target post

Follow the steps below to play!' WHERE question_id = 4053;

UPDATE dbo.PacketQuestions SET prompt = N'🔍 Nature Scavenger Hunt

Objective: Find a list of outdoor items by searching and observing carefully.

Players: 1+ (solo or group)

Materials: A written or picture scavenger hunt list (leaf, pinecone, feather, rock, flower, bug)

Follow the steps below to play!' WHERE question_id = 4054;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Simon Says Sprint

Objective: Practice listening carefully and reacting quickly with movement commands.

Players: 1+ (solo or group)

Materials: Open outdoor space

Follow the steps below to play!' WHERE question_id = 4055;

UPDATE dbo.PacketQuestions SET prompt = N'🚧 Line Tag

Objective: Practice quick footwork by only being allowed to run along drawn lines.

Players: 3+ players

Materials: Sidewalk chalk to draw a grid of lines

Follow the steps below to play!' WHERE question_id = 4056;

UPDATE dbo.PacketQuestions SET prompt = N'🪣 Bucket Ball Toss

Objective: Practice underhand throwing accuracy by tossing balls into buckets.

Players: 1+ (solo or group)

Materials: 3 buckets of different sizes | Several small soft balls

Follow the steps below to play!' WHERE question_id = 4057;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Follow the Compass

Objective: Practice following simple directions (left, right, forward, back) to reach a spot.

Players: 1+ (solo or group)

Materials: Sidewalk chalk or cones to mark a start and hidden ''treasure'' spot

Follow the steps below to play!' WHERE question_id = 4058;

UPDATE dbo.PacketQuestions SET prompt = N'🗿 Statue Game

Objective: Practice balance and self-control by freezing in place after being spun or tossed gently.

Players: 1+ (solo or group)

Materials: Open grass space

Follow the steps below to play!' WHERE question_id = 4059;

UPDATE dbo.PacketQuestions SET prompt = N'✈️ Paper Airplane Distance Challenge

Objective: Fold, test, and improve a paper airplane design to fly as far as possible.

Players: 1+ (solo or group)

Materials: 2-3 sheets of paper per player | A measuring tape or long string

Follow the steps below to play!' WHERE question_id = 4144;

UPDATE dbo.PacketQuestions SET prompt = N'🧦 Sock Ball Target Toss

Objective: Practice aiming by tossing rolled socks at numbered targets for points.

Players: 1+ (solo or group)

Materials: 4-5 rolled-up sock balls | Chalk or tape to mark 3 target zones with point values

Follow the steps below to play!' WHERE question_id = 4145;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Spoon and Ball Relay

Objective: Balance a small ball on a spoon while racing to a finish line and back.

Players: Teams of 2+ (2 or more teams)

Materials: 1 spoon per team | 1 small ball (or bouncy ball) per team | 2 markers

Follow the steps below to play!' WHERE question_id = 4146;

UPDATE dbo.PacketQuestions SET prompt = N'📦 Cardboard Box Maze

Objective: Build and navigate a simple maze using cardboard boxes.

Players: 1+ (solo or group)

Materials: 4-6 cardboard boxes (open on both ends, or just used as walls)

Follow the steps below to play!' WHERE question_id = 4147;

UPDATE dbo.PacketQuestions SET prompt = N'🌲 Pinecone Toss Game

Objective: Practice tossing pinecones (or rocks) into targets for points.

Players: 1+ (solo or group)

Materials: 4-5 pinecones (or small rocks) | A bucket or hula hoop target

Follow the steps below to play!' WHERE question_id = 4148;

UPDATE dbo.PacketQuestions SET prompt = N'🕸️ String Web Walk

Objective: Navigate through a string ''spider web'' without touching the strings.

Players: 1+ (solo or group)

Materials: A ball of string or yarn | Two chairs or door frames to tie it between

Follow the steps below to play!' WHERE question_id = 4149;

UPDATE dbo.PacketQuestions SET prompt = N'🎳 Rolled-Sock Bowling

Objective: Set up homemade bowling pins and practice rolling a ball to knock them down.

Players: 1+ (solo or group)

Materials: 6 empty plastic bottles or rolled-sock ''pins'' | 1 ball (soft ball or rolled sock)

Follow the steps below to play!' WHERE question_id = 4150;

UPDATE dbo.PacketQuestions SET prompt = N'🥫 Sardines

Objective: Practice sneaking and squeezing together in a reverse hide-and-seek game.

Players: 3+ players

Materials: None — just kids and a safe space to hide in!

Follow the steps below to play!' WHERE question_id = 4200;

UPDATE dbo.PacketQuestions SET prompt = N'👍 Thumb War Tournament

Objective: Compete in a friendly thumb-wrestling tournament using only hands.

Players: 4+ players

Materials: None — just hands!

Follow the steps below to play!' WHERE question_id = 4201;

UPDATE dbo.PacketQuestions SET prompt = N'📋 Categories Game

Objective: Practice quick thinking by naming items in a category before time runs out.

Players: 2-4 players

Materials: None — just voices and quick thinking!

Follow the steps below to play!' WHERE question_id = 4202;

UPDATE dbo.PacketQuestions SET prompt = N'🗿 Grandma''s Footsteps

Objective: Practice sneaking quietly toward a goal without being caught moving.

Players: 3+ players

Materials: None — just kids and open space!

Follow the steps below to play!' WHERE question_id = 4203;

UPDATE dbo.PacketQuestions SET prompt = N'🕵️ I Spy

Objective: Practice describing and guessing objects using colors and clues.

Players: 2-4 players

Materials: None — just eyes and voices!

Follow the steps below to play!' WHERE question_id = 4204;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hop and Count

Objective: Practice counting and balance by hopping a set number of times on one foot.

Players: 1+ (solo or group)

Materials: None — just kids and open space!

Follow the steps below to play!' WHERE question_id = 4205;

UPDATE dbo.PacketQuestions SET prompt = N'🎭 Charades Relay

Objective: Work in teams to act out and guess words as fast as possible.

Players: Teams of 2+ (2 or more teams)

Materials: None — just bodies and imagination!

Follow the steps below to play!' WHERE question_id = 4206;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Challenge

80s Inspiration: The classic full-length hopscotch course, a sidewalk-chalk staple for generations.

Objective: Practice hopping through a full 1-10 hopscotch course with speed and balance.

Players: 1+ (solo or group)

Materials: Playground chalk | A small stone or beanbag marker

Follow the steps below to play!' WHERE question_id = 4256;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Classic

80s Inspiration: Kick the Can, a beloved neighborhood evening game that mixes hide-and-seek with a race to free everyone caught.

Objective: Combine hiding, sneaking, and running strategy in the classic can-guarding game.

Players: 3+ players

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!' WHERE question_id = 4257;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Basics

80s Inspiration: Four Square, one of the most iconic 1980s blacktop games, played in a chalk-divided court with a bouncy ball.

Objective: Learn and apply the basic rules of Four Square: serving, bouncing, and elimination.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!' WHERE question_id = 4258;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Jump Rope Rhyme Time

80s Inspiration: Classic jump-rope games where turners chant a rhyme while a jumper keeps time with their feet.

Objective: Practice steady jump-rope rhythm while chanting an original counting rhyme.

Players: 3+ players

Materials: 1 jump rope

Follow the steps below to play!' WHERE question_id = 4259;

UPDATE dbo.PacketQuestions SET prompt = N'⚾ Wall Ball Retro

80s Inspiration: Wall Ball, a simple throw-and-catch game that''s been a recess favorite against any handy wall for decades.

Objective: Practice throwing and catching a ball off a wall using simple rules.

Players: 1+ (solo or group)

Materials: 1 rubber ball | A flat outdoor wall

Follow the steps below to play!' WHERE question_id = 4260;

UPDATE dbo.PacketQuestions SET prompt = N'🐌 Sidewalk Snail Spiral

80s Inspiration: A spiral variation of hopscotch, sometimes called a ''snail,'' popular on playgrounds as an alternative to the standard ladder shape.

Objective: Practice hopping through a spiral-shaped hopscotch course from the outside in.

Players: 1+ (solo or group)

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 4261;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Freeze Tag Tournament Retro

80s Inspiration: A tournament twist on the classic playground freeze tag game.

Objective: Compete to be the last player still moving in a bracket-style freeze tag showdown.

Players: 4+ players

Materials: None — just open space!

Follow the steps below to play!' WHERE question_id = 4262;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Warm-Up

80s Inspiration: The classic call-and-cross team game, played with a safety-first mindset.

Objective: Practice jogging with control and breaking through joined hands safely.

Players: Whole group (6+)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5320;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Challenge

80s Inspiration: The classic permission-asking game, with a wider variety of step types.

Objective: Practice strategic step choices while following clear directions.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5321;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Relay

80s Inspiration: The classic team game, adapted so every player gets a turn in order.

Objective: Practice quick decision-making and teamwork in a relay-style retrieval game.

Players: Teams of 2+ (2 or more teams)

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!' WHERE question_id = 5322;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Challenge

80s Inspiration: The classic field-day potato sack race, with an added turn for more challenge.

Objective: Practice steady hopping over a longer race distance with a turnaround.

Players: 1+ (solo or group)

Materials: 1 soft pillowcase or cloth sack per child | 1 cone or marker

Follow the steps below to play!' WHERE question_id = 5323;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Challenge

80s Inspiration: The classic field-day egg-and-spoon race, with an added turn for more challenge.

Objective: Practice balancing while walking around an obstacle.

Players: 1+ (solo or group)

Materials: 1 large spoon per child | 1 small soft ball or pom-pom per child | 1 cone or marker

Follow the steps below to play!' WHERE question_id = 5324;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Three-Legged Race Challenge

80s Inspiration: The classic field-day three-legged race, stepped up with a full race course.

Objective: Practice coordinated walking with a partner over a longer race distance.

Players: 2 players

Materials: 1 soft scarf or strip of cloth per pair

Follow the steps below to play!' WHERE question_id = 5325;

UPDATE dbo.PacketQuestions SET prompt = N'🏓 Tetherball Intro

80s Inspiration: The classic playground tetherball game, found on nearly every 1980s schoolyard.

Objective: Practice hitting a ball on a rope around a pole with a partner.

Players: 2 players

Materials: A tetherball pole and ball (or improvised rope-and-ball setup)

Follow the steps below to play!' WHERE question_id = 5326;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick Warm-Up

70s Inspiration: The classic pogo stick, one of the defining backyard toys of the 1970s.

Objective: Practice a short series of steady pogo stick bounces with light support.

Players: 1+ (solo or group)

Materials: A pogo stick (child-sized) | A grown-up nearby

Follow the steps below to play!' WHERE question_id = 5376;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Launch Warm-Up

70s Inspiration: The classic backyard and park kite-flying that peaked in popularity in the 1970s.

Objective: Practice launching a kite solo and adjusting string tension to keep it flying.

Players: 1+ (solo or group)

Materials: 1 kite with string

Follow the steps below to play!' WHERE question_id = 5377;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Warm-Up

70s Inspiration: The classic backyard water balloon toss, a summertime staple of the 1970s.

Objective: Practice tossing and catching a water balloon at increasing distances with a partner.

Players: 2 players

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5378;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Obstacle Warm-Up

70s Inspiration: The bike-handling skills every kid needed for a proper 1970s neighborhood bike rodeo.

Objective: Practice steering carefully around a few simple obstacles on a bike.

Players: 1+ (solo or group)

Materials: A bike | 3-4 cones to mark obstacles

Follow the steps below to play!' WHERE question_id = 5379;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Warm-Up

70s Inspiration: The classic 1970s playground name-calling ball game, played at a slightly faster pace.

Objective: Practice quicker reactions and short sprints in the classic ball-calling game.

Players: 3+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5380;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard Push Warm-Up

70s Inspiration: The classic first real skateboarding skill from the 1970s skateboarding boom.

Objective: Practice a gentle push-and-glide with one foot while staying balanced.

Players: 1+ (solo or group)

Materials: A skateboard | A helmet | A flat, smooth surface

Follow the steps below to play!' WHERE question_id = 5381;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Relay Warm-Up

70s Inspiration: The friendly Big Wheel races that turned into full relays on 1970s driveways.

Objective: Practice a short relay hand-off between two Big Wheel riders.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 Big Wheels or similar ride-on trikes | Cones to mark a short lane

Follow the steps below to play!' WHERE question_id = 5382;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Warm-Up

90s Inspiration: The inline-skating craze that had 1990s kids gliding down every smooth sidewalk.

Objective: Practice gliding, turning gently, and stopping with more confidence on inline skates.

Players: 1+ (solo or group)

Materials: Inline skates | A helmet and pads

Follow the steps below to play!' WHERE question_id = 5432;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Duel Warm-Up

90s Inspiration: The classic backyard Super Soaker duels that were a rite of summer in the 1990s.

Objective: Practice a friendly one-on-one water gun duel with clear, fair rules.

Players: 2 players

Materials: 2 water guns | A dry-off towel for each player

Follow the steps below to play!' WHERE question_id = 5433;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Challenge

90s Inspiration: The classic 1990s recess game, played with a slightly bigger play area for more challenge.

Objective: Practice quick decision-making about which equipment is safest and fastest to reach.

Players: 3+ players

Materials: Multiple playground equipment pieces spread out | A player to be ''It''

Follow the steps below to play!' WHERE question_id = 5434;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Flashlight Tag Challenge

90s Inspiration: The classic evening flashlight tag game, played across a bigger, more exciting boundary.

Objective: Practice strategic movement to avoid the flashlight beam across a slightly bigger play area.

Players: 3+ players

Materials: 1-2 flashlights | A larger safe, agreed-upon yard at dusk | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5435;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Slalom Challenge

90s Inspiration: The kick-scooter tricks and courses that neighborhood kids invented in the late 1990s.

Objective: Practice steering a kick scooter smoothly around a simple row of cones.

Players: 1+ (solo or group)

Materials: A kick scooter | A helmet | 4-5 cones

Follow the steps below to play!' WHERE question_id = 5436;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Challenge

90s Inspiration: A leveled-up version of the homemade chalk Twister game, popular at 1990s summer parties.

Objective: Practice balancing across more limb positions as the calls get trickier.

Players: 2 players

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 5437;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Trick Challenge

90s Inspiration: The trick-yo-yo skills that turned 1990s recess into a playground competition.

Objective: Practice a simple named trick, like ''Walk the Dog,'' building on the basic sleeper motion.

Players: 1+ (solo or group)

Materials: 1 yo-yo

Follow the steps below to play!' WHERE question_id = 5438;

UPDATE dbo.PacketQuestions SET prompt = N'🚩 Capture the Flag Lite

Objective: Work with a team to sneak across enemy territory and grab the other team''s flag.

Players: Teams of 2+ (2 or more teams)

Materials: 2 flags (or bandanas) | Cones to mark a center dividing line

Follow the steps below to play!' WHERE question_id = 4060;

UPDATE dbo.PacketQuestions SET prompt = N'⚽ Kickball Basics

Objective: Practice kicking, running bases, and basic teamwork rules of kickball.

Players: Teams of 2+ (2 or more teams)

Materials: 1 kickball | 4 bases (or cones)

Follow the steps below to play!' WHERE question_id = 4061;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Frisbee Toss Target

Objective: Practice throwing a frisbee accurately toward a target.

Players: 1+ (solo or group)

Materials: 1 flying disc (frisbee) | A hula hoop or bucket as a target

Follow the steps below to play!' WHERE question_id = 4062;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Obstacle Relay Teams

Objective: Work as a team to complete an obstacle course relay as fast as possible.

Players: Teams of 2+ (2 or more teams)

Materials: Cones, hula hoops, a jump rope, a baton

Follow the steps below to play!' WHERE question_id = 4063;

UPDATE dbo.PacketQuestions SET prompt = N'🌀 Blob Tag

Objective: Work together as a growing group to tag remaining players.

Players: 4+ players

Materials: Open play space

Follow the steps below to play!' WHERE question_id = 4064;

UPDATE dbo.PacketQuestions SET prompt = N'⚖️ Ball Balance Race

Objective: Practice balance and steady movement while carrying a ball on a spoon or racket.

Players: 1+ (solo or group)

Materials: 1 spoon or small racket per player | 1 small ball per player | 2 cones

Follow the steps below to play!' WHERE question_id = 4065;

UPDATE dbo.PacketQuestions SET prompt = N'🔎 Scavenger Hunt Clues

Objective: Follow written clues to find hidden items around the outdoor area.

Players: 1+ (solo or group)

Materials: 4-5 written clue cards | Small hidden prizes or markers

Follow the steps below to play!' WHERE question_id = 4066;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square

Objective: Practice bouncing and hitting a ball within a 4-square court using simple rules.

Players: 4+ players

Materials: 1 bouncy ball | Chalk to draw a 4-square court

Follow the steps below to play!' WHERE question_id = 4067;

UPDATE dbo.PacketQuestions SET prompt = N'🎒 Bean Bag Relay

Objective: Practice balance and teamwork by racing while carrying a beanbag on your head.

Players: Teams of 2+ (2 or more teams)

Materials: 1 beanbag per team | 2 cones

Follow the steps below to play!' WHERE question_id = 4068;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Jump Rope Challenge

Objective: Practice jump-roping and count how many consecutive jumps you can do.

Players: 1+ (solo or group)

Materials: 1 jump rope per player

Follow the steps below to play!' WHERE question_id = 4069;

UPDATE dbo.PacketQuestions SET prompt = N'💪 Team Tug of War (Light)

Objective: Work together as a team to pull a rope across a middle line.

Players: Teams of 2+ (2 or more teams)

Materials: 1 sturdy rope | Chalk or a marker for the center line

Follow the steps below to play!' WHERE question_id = 4070;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Trail

Objective: Practice hopping on one and two feet along a numbered hopscotch grid.

Players: 1+ (solo or group)

Materials: Sidewalk chalk | A small stone or beanbag marker

Follow the steps below to play!' WHERE question_id = 4071;

UPDATE dbo.PacketQuestions SET prompt = N'🦆 Duck Duck Goose Sprint

Objective: Practice quick reactions and full-speed running in a faster version of a classic circle game.

Players: 4+ players

Materials: Open grass space

Follow the steps below to play!' WHERE question_id = 4072;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Balloon Toss

Objective: Work with a partner to toss and catch a water balloon without popping it.

Players: 2 players

Materials: Water balloons (filled)

Follow the steps below to play!' WHERE question_id = 4073;

UPDATE dbo.PacketQuestions SET prompt = N'📰 Newspaper Ball Toss Battle

Objective: Work in teams to toss paper balls across a line, keeping your own side clear.

Players: Teams of 2+ (2 or more teams)

Materials: 10-15 balls of crumpled scrap paper | A rope or tape line to divide the area

Follow the steps below to play!' WHERE question_id = 4151;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Cup Tower Relay

Objective: Race in teams to build the tallest cup tower before time runs out.

Players: Teams of 2+ (2 or more teams)

Materials: 15-20 plastic cups per team

Follow the steps below to play!' WHERE question_id = 4152;

UPDATE dbo.PacketQuestions SET prompt = N'🌳 Nature Scavenger Bingo

Objective: Find and check off a bingo card of natural outdoor items.

Players: 1+ (solo or group)

Materials: A simple 3x3 bingo card with nature items drawn or listed (leaf, rock, flower, bird, cloud, etc.)

Follow the steps below to play!' WHERE question_id = 4153;

UPDATE dbo.PacketQuestions SET prompt = N'🦸 Blanket Cape Obstacle Dash

Objective: Wear a blanket cape and complete a simple obstacle course as a superhero.

Players: 1+ (solo or group)

Materials: 1 small blanket or towel per player (as a cape) | Household items for obstacles (pillows, chairs, boxes)

Follow the steps below to play!' WHERE question_id = 4154;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Paper Plate Frisbee Golf

Objective: Toss a paper plate ''disc'' toward a series of household targets in as few throws as possible.

Players: 1+ (solo or group)

Materials: 1-2 paper plates | 3-4 household ''holes'' (a laundry basket, a chair, a doorway, a box)

Follow the steps below to play!' WHERE question_id = 4155;

UPDATE dbo.PacketQuestions SET prompt = N'🧷 Clothespin Clip Relay

Objective: Race to clip clothespins onto your clothing, then race to remove them.

Players: Teams of 2+ (2 or more teams)

Materials: 10-15 clothespins per team | 2 cones or markers

Follow the steps below to play!' WHERE question_id = 4156;

UPDATE dbo.PacketQuestions SET prompt = N'🎣 Stick and String Fishing Game

Objective: Make a simple fishing pole and practice ''catching'' paper fish with a magnet or hook.

Players: 1+ (solo or group)

Materials: 1 stick | String | A magnet or paperclip | Paper fish cutouts with paperclips attached

Follow the steps below to play!' WHERE question_id = 4157;

UPDATE dbo.PacketQuestions SET prompt = N'🌋 The Floor Is Lava

Objective: Practice balance and quick thinking by staying off the ''lava'' floor.

Players: 1+ (solo or group)

Materials: None — just kids and any safe furniture/steps already around!

Follow the steps below to play!' WHERE question_id = 4207;

UPDATE dbo.PacketQuestions SET prompt = N'❓ 20 Questions

Objective: Practice asking smart yes-or-no questions to guess a secret item.

Players: 2-4 players

Materials: None — just voices and clever thinking!

Follow the steps below to play!' WHERE question_id = 4208;

UPDATE dbo.PacketQuestions SET prompt = N'👀 Staring Contest Tournament

Objective: Practice self-control and focus in a silly staring-contest competition.

Players: 4+ players

Materials: None — just eyes!

Follow the steps below to play!' WHERE question_id = 4209;

UPDATE dbo.PacketQuestions SET prompt = N'🤔 Would You Rather

Objective: Practice sharing opinions and explaining reasoning with fun hypothetical choices.

Players: 2-4 players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4210;

UPDATE dbo.PacketQuestions SET prompt = N'🎬 Silent Charades Battle

Objective: Compete in teams to guess acted-out words the fastest, using only movement.

Players: Teams of 2+ (2 or more teams)

Materials: None — just bodies and imagination!

Follow the steps below to play!' WHERE question_id = 4211;

UPDATE dbo.PacketQuestions SET prompt = N'🗣️ Story Starters

Objective: Build a silly group story together, one sentence at a time.

Players: 2-4 players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4212;

UPDATE dbo.PacketQuestions SET prompt = N'😉 Wink Detective

Objective: Practice careful observation to spot a secret ''winker'' before getting caught.

Players: 4+ players

Materials: None — just eyes and a group of friends!

Follow the steps below to play!' WHERE question_id = 4213;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Relay Retro

80s Inspiration: Turns the traditional solo hopscotch course into a team relay race.

Objective: Combine team relay racing with the classic hopscotch hopping pattern.

Players: Teams of 2+ (2 or more teams)

Materials: Playground chalk | 2 beanbag markers

Follow the steps below to play!' WHERE question_id = 4263;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Teams

80s Inspiration: A team-based version of the classic Kick the Can game, adding cooperative strategy.

Objective: Apply team strategy to guarding the can and freeing teammates from jail.

Players: Teams of 2+ (2 or more teams)

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!' WHERE question_id = 4264;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Rally

80s Inspiration: A rally-focused twist on the classic 1980s blacktop favorite, Four Square.

Objective: Practice sustained rallies in four square, keeping the ball in play as long as possible.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!' WHERE question_id = 4265;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Double Dutch Intro

80s Inspiration: Double Dutch, the iconic two-rope jump style that became hugely popular on playgrounds through the 1980s.

Objective: Learn the basics of jumping between two ropes turning in opposite directions.

Players: 3+ players

Materials: 2 jump ropes

Follow the steps below to play!' WHERE question_id = 4266;

UPDATE dbo.PacketQuestions SET prompt = N'⚾ Wall Ball Challenge

80s Inspiration: A leveled-up version of the classic recess wall-ball game, adding challenge moves.

Objective: Practice more advanced wall-ball throws and catches with added challenge rules.

Players: 1+ (solo or group)

Materials: 1 rubber ball | A flat outdoor wall | Playground chalk (optional, for a throwing line)

Follow the steps below to play!' WHERE question_id = 4267;

UPDATE dbo.PacketQuestions SET prompt = N'🖍️ Chalk Spot Shuffle

80s Inspiration: A pavement chalk game inspired by classic hand-and-foot placement party games from the 80s.

Objective: Practice following called-out directions to move hands and feet onto different colored chalk spots.

Players: 2 players

Materials: Playground chalk (multiple colors)

Follow the steps below to play!' WHERE question_id = 4268;

UPDATE dbo.PacketQuestions SET prompt = N'❌ Sidewalk Tic-Tac-Toe Toss

80s Inspiration: Merges a chalk-drawn tic-tac-toe grid with the classic beanbag-toss accuracy games of the era.

Objective: Combine beanbag-tossing accuracy with the classic 3-in-a-row strategy game.

Players: 2 players

Materials: Playground chalk | 2 sets of different-colored beanbags (or rocks)

Follow the steps below to play!' WHERE question_id = 4269;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Championship

80s Inspiration: The classic call-and-cross team game, played with strategic team calling.

Objective: Practice teamwork strategy in choosing which player to call across.

Players: Whole group (6+)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5327;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Teams

80s Inspiration: A team relay twist on the classic Mother May I game.

Objective: Practice teamwork by taking turns asking permission as a relay team.

Players: Teams of 2+ (2 or more teams)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5328;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Teams

80s Inspiration: A team-based expansion of the classic Steal the Bacon game.

Objective: Practice quick teamwork calls and multi-player retrieval strategy.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!' WHERE question_id = 5329;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Relay

80s Inspiration: A relay-team version of the classic potato sack race.

Objective: Practice teamwork by passing the sack to the next teammate in a relay.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 soft pillowcases or cloth sacks | 1 cone or marker per lane

Follow the steps below to play!' WHERE question_id = 5330;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Relay

80s Inspiration: A relay-team version of the classic egg-and-spoon race.

Objective: Practice teamwork by handing off a balanced spoon to the next teammate.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 large spoons | 1-2 small soft balls or pom-poms | 1 cone or marker per lane

Follow the steps below to play!' WHERE question_id = 5331;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Three-Legged Race Relay

80s Inspiration: A relay-team version of the classic three-legged race.

Objective: Practice coordinated team racing with multiple tied pairs taking turns.

Players: Teams of 2+ (2 or more teams)

Materials: Soft scarves or strips of cloth, one per pair | 1 cone or marker per lane

Follow the steps below to play!' WHERE question_id = 5332;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Roller Skating Relay

80s Inspiration: The classic roller-skating relays that were a staple of 1980s neighborhood playgrounds.

Objective: Practice balanced skating over a short distance as part of a team relay.

Players: Teams of 2+ (2 or more teams)

Materials: Roller skates | A smooth, flat surface | 1 cone or marker per lane

Follow the steps below to play!' WHERE question_id = 5333;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick Challenge

70s Inspiration: The pogo stick bouncing contests that popped up on 1970s playgrounds and backyards.

Objective: Practice sustained pogo stick bouncing without support, aiming for a personal best.

Players: 1+ (solo or group)

Materials: A pogo stick (child-sized)

Follow the steps below to play!' WHERE question_id = 5383;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Flying Challenge

70s Inspiration: The classic kite-flying pastime, popular at parks and beaches throughout the 1970s.

Objective: Practice keeping a kite airborne for as long as possible while managing string and wind changes.

Players: 1+ (solo or group)

Materials: 1 kite with string

Follow the steps below to play!' WHERE question_id = 5384;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Challenge

70s Inspiration: The classic water balloon toss, a favorite 1970s summer party game.

Objective: Practice precise underhand tossing and soft-handed catching over increasing distances.

Players: 2 players

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5385;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Rodeo Challenge

70s Inspiration: The full bike rodeo events that were a highlight of many 1970s neighborhood summers.

Objective: Practice a full obstacle course combining steering, stopping, and balance skills.

Players: 1+ (solo or group)

Materials: A bike | 5-6 cones to mark a full course

Follow the steps below to play!' WHERE question_id = 5386;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Challenge

70s Inspiration: The classic 1970s playground ball-calling game, played with a bigger group for more challenge.

Objective: Practice quicker decision-making about how far to scatter based on who''s holding the ball.

Players: 4+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5387;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard Slalom Challenge

70s Inspiration: The slalom skateboarding style that became a 1970s skateboarding favorite.

Objective: Practice weaving smoothly through a row of cones while gliding on a skateboard.

Players: 1+ (solo or group)

Materials: A skateboard | A helmet | 4-5 cones | A flat, smooth surface

Follow the steps below to play!' WHERE question_id = 5388;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Relay Challenge

70s Inspiration: The full-team Big Wheel relay races that filled 1970s cul-de-sacs.

Objective: Practice a full team relay with multiple Big Wheel riders taking turns.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 Big Wheels or similar ride-on trikes | Cones to mark a lane

Follow the steps below to play!' WHERE question_id = 5389;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Challenge

90s Inspiration: The inline-skating obstacle courses that neighborhood kids set up throughout the 1990s.

Objective: Practice combining speed, turning, and stopping in a short skating course.

Players: 1+ (solo or group)

Materials: Inline skates | A helmet and pads | 2-3 cones

Follow the steps below to play!' WHERE question_id = 5439;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Duel Challenge

90s Inspiration: The escalating Super Soaker duels that were a summer highlight for 1990s kids.

Objective: Practice quick reflexes and evasive movement in a best-of-3 water gun duel.

Players: 2 players

Materials: 2 water guns | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5440;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Teams

90s Inspiration: A team-based twist on the classic 1990s recess game Grounders.

Objective: Practice teamwork by helping teammates find safe equipment quickly.

Players: Teams of 2+ (2 or more teams)

Materials: Multiple playground equipment pieces | A player or two to be ''It''

Follow the steps below to play!' WHERE question_id = 5441;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Manhunt Teams

90s Inspiration: Manhunt, the large-scale hide-and-seek/tag game that took over 1990s neighborhood evenings.

Objective: Practice team-based hiding and searching strategy in a larger evening game.

Players: Whole group (6+)

Materials: 1-2 flashlights | A larger safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5442;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Cone Course

90s Inspiration: The backyard scooter courses that late-1990s kids built with whatever cones they had.

Objective: Practice a full scooter course combining straight pushes and careful weaving.

Players: 1+ (solo or group)

Materials: A kick scooter | A helmet | 5-6 cones

Follow the steps below to play!' WHERE question_id = 5443;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Teams

90s Inspiration: A team-based twist on the homemade chalk Twister game popular at 1990s summer parties.

Objective: Practice teamwork by taking turns calling moves for a partner''s chalk Twister round.

Players: Teams of 2+ (2 or more teams)

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 5444;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Around the World

90s Inspiration: One of the most iconic yo-yo tricks that every serious 1990s yo-yo kid learned to show off.

Objective: Practice the classic ''Around the World'' trick, swinging the yo-yo in a full circle.

Players: 1+ (solo or group)

Materials: 1 yo-yo

Follow the steps below to play!' WHERE question_id = 5445;
UPDATE dbo.PacketQuestions SET prompt = N'🚩 Capture the Flag

Objective: Use teamwork and strategy to capture the opposing team''s flag and bring it home.

Players: Teams of 2+ (2 or more teams)

Materials: 2 flags | Cones to mark boundaries and a jail zone for each team

Follow the steps below to play!' WHERE question_id = 4074;

UPDATE dbo.PacketQuestions SET prompt = N'⚽ Kickball Tournament

Objective: Apply kickball rules and teamwork across a full mini-tournament of innings.

Players: Teams of 2+ (2 or more teams)

Materials: 1 kickball | 4 bases | Scorecard (optional)

Follow the steps below to play!' WHERE question_id = 4075;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Ultimate Frisbee Intro

Objective: Practice throwing, catching, and moving a frisbee downfield as a team without running while holding it.

Players: Teams of 2+ (2 or more teams)

Materials: 1 flying disc | 4 cones to mark end zones

Follow the steps below to play!' WHERE question_id = 4076;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Team Relay Obstacle

Objective: Coordinate as a team to complete a multi-station relay obstacle course fastest.

Players: Teams of 2+ (2 or more teams)

Materials: Cones, hula hoops, a jump rope, a balance beam or line, a baton

Follow the steps below to play!' WHERE question_id = 4077;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Challenge

Objective: Apply advanced four-square rules including special serves and challenges.

Players: 4+ players

Materials: 1 bouncy ball | Chalk to draw the 4-square court

Follow the steps below to play!' WHERE question_id = 4078;

UPDATE dbo.PacketQuestions SET prompt = N'🗺️ Scavenger Hunt Teams

Objective: Work in small teams to solve clues and find hidden items across a wider area.

Players: Teams of 2+ (2 or more teams)

Materials: 5-6 written clue cards per team | Small prizes at the final spot

Follow the steps below to play!' WHERE question_id = 4079;

UPDATE dbo.PacketQuestions SET prompt = N'💪 Tug of War

Objective: Use coordinated team strength and strategy to pull the rope across the line.

Players: Teams of 2+ (2 or more teams)

Materials: 1 thick sturdy rope | Chalk or marker for the center line

Follow the steps below to play!' WHERE question_id = 4080;

UPDATE dbo.PacketQuestions SET prompt = N'🦈 Sharks and Minnows

Objective: Practice sprinting and dodging strategy while trying to safely cross the field.

Players: 4+ players

Materials: 2 boundary lines marked with chalk or cones

Follow the steps below to play!' WHERE question_id = 4081;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Kan Jam Basics

Objective: Practice throwing a disc toward a partner''s goal to score points as a team.

Players: Teams of 2+ (2 or more teams)

Materials: 2 goal targets (buckets or a Kan Jam set) | 1 flying disc

Follow the steps below to play!' WHERE question_id = 4082;

UPDATE dbo.PacketQuestions SET prompt = N'🏷️ Team Tag Strategy

Objective: Use team communication and strategy to tag opposing players while protecting your own.

Players: Teams of 2+ (2 or more teams)

Materials: Pinnies or colored bands to mark 2 teams | Boundary cones

Follow the steps below to play!' WHERE question_id = 4083;

UPDATE dbo.PacketQuestions SET prompt = N'🪣 Bucket Brigade Relay

Objective: Work as a team to transport water from one bucket to another as efficiently as possible.

Players: Teams of 2+ (2 or more teams)

Materials: 2 large buckets per team (one filled with water) | 1 cup per player

Follow the steps below to play!' WHERE question_id = 4084;

UPDATE dbo.PacketQuestions SET prompt = N'🎡 Hula Hoop Pass

Objective: Work as a team in a circle to pass a hula hoop around without letting go of hands.

Players: 3+ players

Materials: 1 hula hoop

Follow the steps below to play!' WHERE question_id = 4085;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Jump Rope Relay

Objective: Combine running and jump-roping skills in a team relay format.

Players: Teams of 2+ (2 or more teams)

Materials: 1 jump rope per team | 2 cones

Follow the steps below to play!' WHERE question_id = 4086;

UPDATE dbo.PacketQuestions SET prompt = N'🌳 Nature Trail Race

Objective: Navigate a marked outdoor trail while identifying nature checkpoints along the way.

Players: 1+ (solo or group)

Materials: Trail markers (flags or chalk arrows) | A checklist of things to spot along the trail

Follow the steps below to play!' WHERE question_id = 4087;

UPDATE dbo.PacketQuestions SET prompt = N'✈️ Paper Airplane Target Challenge

Objective: Design a paper airplane and practice landing it accurately inside target zones.

Players: 1+ (solo or group)

Materials: 2-3 sheets of paper per player | Chalk or tape to mark 3 target zones on the ground

Follow the steps below to play!' WHERE question_id = 4158;

UPDATE dbo.PacketQuestions SET prompt = N'🎳 Household Item Bowling

Objective: Set up a bowling lane using household items and practice rolling for accuracy.

Players: 1+ (solo or group)

Materials: 6-10 plastic bottles or cups as pins | A ball (soft ball or rolled-up socks taped together)

Follow the steps below to play!' WHERE question_id = 4159;

UPDATE dbo.PacketQuestions SET prompt = N'🧺 Nature Weaving Craft Race

Objective: Collect natural materials and weave them into a simple pattern as fast as possible.

Players: 1+ (solo or group)

Materials: Long grass, thin sticks, or vines collected outside | A simple frame (a paper plate with slits cut in, or a stick frame)

Follow the steps below to play!' WHERE question_id = 4160;

UPDATE dbo.PacketQuestions SET prompt = N'📦 Cardboard Slide and Ramp Challenge

Objective: Build a ramp from cardboard and test which household objects roll or slide the farthest.

Players: 1+ (solo or group)

Materials: A large piece of cardboard | Books or a chair to prop it up | Small household objects to test (a ball, a toy car, a bottle cap)

Follow the steps below to play!' WHERE question_id = 4161;

UPDATE dbo.PacketQuestions SET prompt = N'🧦 Sock Ball Dodge

Objective: Practice dodging and throwing accuracy in a gentle sock-ball dodgeball game.

Players: 4+ players

Materials: 6-8 rolled-up sock balls | A center line (rope or tape)

Follow the steps below to play!' WHERE question_id = 4162;

UPDATE dbo.PacketQuestions SET prompt = N'🪨 Rock Stacking Challenge

Objective: Practice patience and balance by stacking rocks into the tallest stable tower.

Players: 1+ (solo or group)

Materials: 5-8 rocks of different sizes (collected outside)

Follow the steps below to play!' WHERE question_id = 4163;

UPDATE dbo.PacketQuestions SET prompt = N'📰 Newspaper Tower Build

Objective: Work in teams to build the tallest free-standing tower using only newspaper and tape.

Players: Teams of 2+ (2 or more teams)

Materials: A stack of newspaper or scrap paper per team | 1 roll of tape per team

Follow the steps below to play!' WHERE question_id = 4164;

UPDATE dbo.PacketQuestions SET prompt = N'🕵️ 20 Questions Detective

Objective: Use strategic yes-or-no questions to narrow down and guess a secret item efficiently.

Players: 2-4 players

Materials: None — just voices and strategy!

Follow the steps below to play!' WHERE question_id = 4214;

UPDATE dbo.PacketQuestions SET prompt = N'📖 Story Chain

Objective: Build a creative story together, adding one sentence at a time in order.

Players: 2-4 players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4215;

UPDATE dbo.PacketQuestions SET prompt = N'🤥 Two Truths and a Lie

Objective: Practice sharing facts about yourself and spotting a friend''s fib.

Players: 2-4 players

Materials: None — just voices and honesty (mostly)!

Follow the steps below to play!' WHERE question_id = 4216;

UPDATE dbo.PacketQuestions SET prompt = N'🌋 The Floor Is Lava: Team Edition

Objective: Work together as a team to help everyone reach safety before the lava spreads.

Players: 3+ players

Materials: None — just kids and any safe furniture/steps already around!

Follow the steps below to play!' WHERE question_id = 4217;

UPDATE dbo.PacketQuestions SET prompt = N'🎭 Emotion Charades

Objective: Practice recognizing and expressing different emotions through acting.

Players: 2-4 players

Materials: None — just faces, bodies, and imagination!

Follow the steps below to play!' WHERE question_id = 4218;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Human Knot

Objective: Work together as a team to untangle a human knot using only communication and careful movement.

Players: Whole group (6+)

Materials: None — just a group of friends standing in a circle!

Follow the steps below to play!' WHERE question_id = 4219;

UPDATE dbo.PacketQuestions SET prompt = N'🗣️ Categories Speed Round

Objective: Practice quick recall by naming items in a category before a countdown ends.

Players: 2-4 players

Materials: None — just voices and quick thinking!

Follow the steps below to play!' WHERE question_id = 4220;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Speed Round

80s Inspiration: Adds a speed-challenge twist to the traditional hopscotch course.

Objective: Race against the clock to complete a hopscotch course as fast as possible without mistakes.

Players: 1+ (solo or group)

Materials: Playground chalk | A beanbag marker | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 4270;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Strategy

80s Inspiration: A more strategic version of the classic Kick the Can game, emphasizing planning over just running.

Objective: Apply advanced hiding and timing strategy to outsmart the can''s guard.

Players: 4+ players

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!' WHERE question_id = 4271;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Tournament Retro

80s Inspiration: A full-fledged tournament format built around the classic 1980s blacktop favorite, Four Square.

Objective: Compete in a bracket-style four square tournament applying full classic rules.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk | A simple bracket sheet

Follow the steps below to play!' WHERE question_id = 4272;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Double Dutch Jump Challenge

80s Inspiration: Builds on the classic Double Dutch two-rope jumping tradition with an endurance challenge.

Objective: Practice sustained double dutch jumping and counting consecutive jumps.

Players: 3+ players

Materials: 2 jump ropes

Follow the steps below to play!' WHERE question_id = 4273;

UPDATE dbo.PacketQuestions SET prompt = N'⚾ Wall Ball Ace

80s Inspiration: A precision-focused version of the classic recess wall-ball game.

Objective: Practice precision throwing to hit specific chalk-marked zones on a wall.

Players: 1+ (solo or group)

Materials: 1 rubber ball | A flat outdoor wall | Playground chalk

Follow the steps below to play!' WHERE question_id = 4274;

UPDATE dbo.PacketQuestions SET prompt = N'⚪ Marbles Ring Toss

80s Inspiration: A gentle version of the classic marbles ring game, one of the most popular pocket games of the era.

Objective: Practice aiming and flicking marbles to knock others out of a chalk-drawn ring.

Players: 1+ (solo or group)

Materials: A handful of marbles (large, supervised — or use small rocks/bottle caps) | Playground chalk

Follow the steps below to play!' WHERE question_id = 4275;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Elastics Jump Challenge

80s Inspiration: Elastics (also called Chinese jump rope), where a big loop of elastic is stretched between two players'' legs while a third jumps a set pattern of footwork.

Objective: Practice jumping footwork patterns using a big loop of elastic held between two players'' ankles.

Players: 3+ players

Materials: 1 long loop of elastic (or a few rubber bands tied together, or a soft rope loop)

Follow the steps below to play!' WHERE question_id = 4276;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Advanced Strategy

80s Inspiration: The classic call-and-cross team game, with real strategic thinking.

Objective: Practice reading the other team''s line to choose the weakest link to call.

Players: Whole group (6+)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5334;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Strategy

80s Inspiration: A strategy-focused twist on the classic Mother May I game.

Objective: Practice choosing the most efficient step type to reach the finish fastest.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5335;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Strategy

80s Inspiration: A strategy-focused twist on the classic Steal the Bacon game.

Objective: Practice reading an opponent''s movement to decide when to grab and when to fake.

Players: Teams of 2+ (2 or more teams)

Materials: 1 soft object (a rolled sock or beanbag)

Follow the steps below to play!' WHERE question_id = 5336;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Obstacle Course

80s Inspiration: A leveled-up version of the classic potato sack race with an obstacle course twist.

Objective: Practice hopping steadily through a short course with multiple obstacles.

Players: 1+ (solo or group)

Materials: Soft pillowcases or cloth sacks | 3-4 cones or markers

Follow the steps below to play!' WHERE question_id = 5337;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Obstacle Dash

80s Inspiration: A leveled-up version of the classic egg-and-spoon race with obstacles added.

Objective: Practice balancing through a short obstacle course without dropping the ball.

Players: 1+ (solo or group)

Materials: Large spoons | Small soft balls or pom-poms | 3-4 cones or markers

Follow the steps below to play!' WHERE question_id = 5338;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Wheelbarrow Race Basics

80s Inspiration: The classic field-day wheelbarrow race, a favorite of 1980s school field days.

Objective: Practice teamwork balance with one partner walking on hands while the other holds their legs.

Players: 2 players

Materials: A soft grassy or padded surface

Follow the steps below to play!' WHERE question_id = 5339;

UPDATE dbo.PacketQuestions SET prompt = N'👻 Ghost in the Graveyard

80s Inspiration: A beloved neighborhood evening game from countless 1980s summer nights.

Objective: Practice quiet movement and quick reactions in a classic dusk hide-and-seek game.

Players: 4+ players

Materials: None -- just open space with hiding spots | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5340;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick Count Challenge

70s Inspiration: The pogo stick bounce-counting contests popular on 1970s playgrounds.

Objective: Practice sustained balance and rhythm to reach a target number of consecutive bounces.

Players: 1+ (solo or group)

Materials: A pogo stick (child-sized)

Follow the steps below to play!' WHERE question_id = 5390;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Height Contest

70s Inspiration: The friendly ''whose kite flies highest'' contests common at 1970s park gatherings.

Objective: Practice letting out string efficiently to get a kite as high as possible.

Players: 1+ (solo or group)

Materials: 1 kite with string per player

Follow the steps below to play!' WHERE question_id = 5391;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Distance Challenge

70s Inspiration: The classic water balloon toss, taken to its farthest-distance extreme.

Objective: Practice controlled, gentle tossing technique to maximize catching distance with a partner.

Players: 2 players

Materials: Small water balloons | Towels for drying off | Something to mark distance (chalk or a tape measure)

Follow the steps below to play!' WHERE question_id = 5392;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Slalom Course

70s Inspiration: The bike slalom events that tested steering skill at 1970s neighborhood bike rodeos.

Objective: Practice tight, controlled turns weaving through a closely spaced cone course.

Players: 1+ (solo or group)

Materials: A bike | 6-8 closely spaced cones

Follow the steps below to play!' WHERE question_id = 5393;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Strategy

70s Inspiration: The classic 1970s ball-calling game, played with an eye toward smart positioning.

Objective: Practice reading the group to decide the smartest direction to scatter and freeze.

Players: 4+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5394;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard Cone Course

70s Inspiration: The backyard skateboard courses kids built with whatever cones and chalk they had in the 1970s.

Objective: Practice combining pushing, gliding, and steering through a longer mixed course.

Players: 1+ (solo or group)

Materials: A skateboard | A helmet | 6-8 cones | A flat, smooth surface

Follow the steps below to play!' WHERE question_id = 5395;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Speed Course

70s Inspiration: The friendly Big Wheel speed trials that were a summer tradition on 1970s driveways.

Objective: Practice pedaling at maximum steady speed through a straight timed course.

Players: 1+ (solo or group)

Materials: A Big Wheel or similar low ride-on trike | Cones marking start and finish | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5396;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Slalom Course

90s Inspiration: The slalom skating that advanced 1990s inline skaters showed off on smooth pavement.

Objective: Practice weaving smoothly through a tighter row of cones while inline skating.

Players: 1+ (solo or group)

Materials: Inline skates | A helmet and pads | 5-6 closely spaced cones

Follow the steps below to play!' WHERE question_id = 5446;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Team Duel

90s Inspiration: The team water fights that turned 1990s backyard parties into all-out Super Soaker battles.

Objective: Practice team coordination and strategy in a small-group water gun battle.

Players: Teams of 2+ (2 or more teams)

Materials: Water guns, one per player | A marked play area | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5447;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Strategy

90s Inspiration: A strategy-focused twist on the classic 1990s recess game Grounders.

Objective: Practice scanning the whole play area quickly to pick the smartest safe spot.

Players: 4+ players

Materials: Multiple playground equipment pieces spread widely | A player to be ''It''

Follow the steps below to play!' WHERE question_id = 5448;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Manhunt Strategy

90s Inspiration: The strategic side of Manhunt that made 1990s evening games last for hours.

Objective: Practice advanced hiding strategy and quiet communication as a hider team.

Players: Whole group (6+)

Materials: 1-2 flashlights | A larger safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5449;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Trick Practice

90s Inspiration: The scooter tricks that adventurous kids started experimenting with as the craze grew in the late 1990s.

Objective: Practice a simple, safe scooter trick, like a controlled hop over a low line.

Players: 1+ (solo or group)

Materials: A kick scooter | A helmet | A piece of chalk or a low, soft obstacle

Follow the steps below to play!' WHERE question_id = 5450;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Speed Round

90s Inspiration: A faster-paced version of the homemade chalk Twister game popular at 1990s summer parties.

Objective: Practice quick, accurate moves as the calls come faster in a timed round.

Players: 3+ players

Materials: Playground chalk | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5451;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Walk the Dog Challenge

90s Inspiration: The showcase yo-yo tricks that turned 1990s playgrounds into friendly competitions.

Objective: Practice combining the ''Walk the Dog'' trick with a longer walking distance for extra challenge.

Players: 1+ (solo or group)

Materials: 1 yo-yo

Follow the steps below to play!' WHERE question_id = 5452;

UPDATE dbo.PacketQuestions SET prompt = N'🚩 Capture the Flag: Strategy Edition

Objective: Plan and execute a team strategy involving offense, defense, and guards to capture the flag.

Players: Teams of 2+ (2 or more teams)

Materials: 2 flags | Cones for boundaries and jail zones

Follow the steps below to play!' WHERE question_id = 4088;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Ultimate Frisbee Match

Objective: Apply full ultimate frisbee rules including stall counts and turnovers in a real match.

Players: Teams of 2+ (2 or more teams)

Materials: 1 flying disc | Cones for end zones and sidelines

Follow the steps below to play!' WHERE question_id = 4089;

UPDATE dbo.PacketQuestions SET prompt = N'⚽ Kickball League

Objective: Play a structured multi-inning kickball game applying fielding positions and scoring strategy.

Players: Teams of 2+ (2 or more teams)

Materials: 1 kickball | 4 bases | Scorecard

Follow the steps below to play!' WHERE question_id = 4090;

UPDATE dbo.PacketQuestions SET prompt = N'🏗️ Team Obstacle Design

Objective: Design and then complete a custom obstacle course as a team, combining creativity with athletics.

Players: Teams of 2+ (2 or more teams)

Materials: Cones, hula hoops, jump ropes, chalk, and other yard items

Follow the steps below to play!' WHERE question_id = 4091;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Scavenger Hunt Navigator

Objective: Use simple map-reading and coordinate skills to locate hidden checkpoints.

Players: 1+ (solo or group)

Materials: A hand-drawn simple map of the play area | 5-6 checkpoint markers

Follow the steps below to play!' WHERE question_id = 4092;

UPDATE dbo.PacketQuestions SET prompt = N'🏈 Flag Football Basics

Objective: Learn basic flag football rules: passing, receiving, and pulling flags instead of tackling.

Players: Teams of 2+ (2 or more teams)

Materials: 1 football | Flag belts (or bandanas tucked into waistbands) | Cones for end zones

Follow the steps below to play!' WHERE question_id = 4093;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Tournament

Objective: Compete in a bracket-style four-square tournament applying advanced rules.

Players: 4+ players

Materials: 1 bouncy ball | Chalk for the court | Simple bracket sheet

Follow the steps below to play!' WHERE question_id = 4094;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Relay Baton Pass

Objective: Practice smooth, fast baton exchanges in a competitive team relay.

Players: Teams of 2+ (2 or more teams)

Materials: 1 baton per team | 4 cones marking a relay loop

Follow the steps below to play!' WHERE question_id = 4095;

UPDATE dbo.PacketQuestions SET prompt = N'💪 Team Tug of War

Objective: Coordinate team strategy and timing to win a full tug-of-war match.

Players: Teams of 2+ (2 or more teams)

Materials: 1 thick rope | Chalk or marker for center line

Follow the steps below to play!' WHERE question_id = 4096;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Disc Golf Intro

Objective: Practice throwing a disc toward a target in as few throws as possible, like mini golf.

Players: 1+ (solo or group)

Materials: 1 flying disc | 5-6 target markers (buckets, trees, or cones)

Follow the steps below to play!' WHERE question_id = 4097;

UPDATE dbo.PacketQuestions SET prompt = N'💧 Water Relay Challenge

Objective: Work as a team to transport water using sponges in a fast-paced relay.

Players: Teams of 2+ (2 or more teams)

Materials: 2 buckets per team (one full, one empty) | 1 sponge per team

Follow the steps below to play!' WHERE question_id = 4098;

UPDATE dbo.PacketQuestions SET prompt = N'🏷️ Team Strategy Tag

Objective: Use planned team roles (chasers and blockers) to tag opponents strategically.

Players: Teams of 2+ (2 or more teams)

Materials: Colored pinnies for 2 teams | Boundary cones

Follow the steps below to play!' WHERE question_id = 4099;

UPDATE dbo.PacketQuestions SET prompt = N'🪵 Balance Beam Relay

Objective: Practice balance and coordination by walking a low balance beam as part of a relay.

Players: Teams of 2+ (2 or more teams)

Materials: A low balance beam (or a wide board/line of chalk) | 2 cones

Follow the steps below to play!' WHERE question_id = 4100;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Orienteering Basics

Objective: Use a simple compass and clues to navigate to specific points in order.

Players: 1+ (solo or group)

Materials: A simple compass (or compass app) | 5 numbered checkpoint cards with directions

Follow the steps below to play!' WHERE question_id = 4101;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Paper Catapult Challenge

Objective: Build a simple catapult from household items and test its launch distance.

Players: 1+ (solo or group)

Materials: 1 spoon | A rubber band | A small stack of books or a block for a pivot | Small paper balls or pom-poms to launch

Follow the steps below to play!' WHERE question_id = 4165;

UPDATE dbo.PacketQuestions SET prompt = N'♻️ Recycling Relay Sort

Objective: Race in teams to correctly sort recyclable household items into the right bins.

Players: Teams of 2+ (2 or more teams)

Materials: A mixed pile of clean recyclables (paper, plastic, cardboard) | 3 labeled boxes or bins

Follow the steps below to play!' WHERE question_id = 4166;

UPDATE dbo.PacketQuestions SET prompt = N'🍁 Nature Land Art Challenge

Objective: Use only natural materials found outside to create a piece of art on the ground.

Players: 1+ (solo or group)

Materials: Leaves, sticks, rocks, flowers, and other natural items found outside

Follow the steps below to play!' WHERE question_id = 4167;

UPDATE dbo.PacketQuestions SET prompt = N'🛏️ Blanket Tug and Balance

Objective: Combine balance and gentle team pulling using a folded blanket.

Players: 2-4 players

Materials: 1 sturdy blanket or towel

Follow the steps below to play!' WHERE question_id = 4168;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Cup Stack Speed Challenge

Objective: Practice speed and precision using the competitive cup-stacking technique.

Players: 1+ (solo or group)

Materials: 12 plastic cups per player

Follow the steps below to play!' WHERE question_id = 4169;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 String and Stick Compass Walk

Objective: Use a simple sun-shadow method with a stick to estimate direction, then walk a course.

Players: 1+ (solo or group)

Materials: 1 stick | String | A sunny outdoor spot

Follow the steps below to play!' WHERE question_id = 4170;

UPDATE dbo.PacketQuestions SET prompt = N'🏠 Household Obstacle Ninja Course

Objective: Design and complete an obstacle course using only furniture and household items.

Players: 1+ (solo or group)

Materials: Pillows, chairs, tape, boxes, and other safe household items

Follow the steps below to play!' WHERE question_id = 4171;

UPDATE dbo.PacketQuestions SET prompt = N'🗣️ Impromptu Debate Circle

Objective: Practice forming and sharing an opinion on the spot, with reasons to support it.

Players: 3+ players

Materials: None — just voices and quick thinking!

Follow the steps below to play!' WHERE question_id = 4221;

UPDATE dbo.PacketQuestions SET prompt = N'😉 Wink Detective Championship

Objective: Sharpen observation skills in a faster-paced round of the classic wink-detective game.

Players: 4+ players

Materials: None — just eyes and a group of friends!

Follow the steps below to play!' WHERE question_id = 4222;

UPDATE dbo.PacketQuestions SET prompt = N'🎬 Silent Movie Charades

Objective: Act out an entire short scene silently, like a character in an old silent film.

Players: 2-4 players

Materials: None — just bodies, faces, and imagination!

Follow the steps below to play!' WHERE question_id = 4223;

UPDATE dbo.PacketQuestions SET prompt = N'🌟 Human Bingo Mixer

Objective: Practice social skills by finding classmates who match different fun facts.

Players: Whole group (6+)

Materials: None — just voices and curiosity!

Follow the steps below to play!' WHERE question_id = 4224;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Human Knot Challenge

Objective: Work as a larger team to untangle a bigger, trickier human knot using only teamwork.

Players: Whole group (6+)

Materials: None — just a group of friends standing in a circle!

Follow the steps below to play!' WHERE question_id = 4225;

UPDATE dbo.PacketQuestions SET prompt = N'🎲 Fortunately, Unfortunately

Objective: Build a silly story together by alternating good news and bad news twists.

Players: 2-4 players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4226;

UPDATE dbo.PacketQuestions SET prompt = N'🗿 Freeze Statue Showdown

Objective: Compete to hold the most creative, stable freeze-pose the longest.

Players: 2-4 players

Materials: None — just bodies and balance!

Follow the steps below to play!' WHERE question_id = 4227;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Master Challenge

80s Inspiration: Takes the classic hopscotch ladder and lets players design their own advanced layout.

Objective: Design and complete a custom advanced hopscotch course with mixed hopping patterns.

Players: 1+ (solo or group)

Materials: Playground chalk | A beanbag marker

Follow the steps below to play!' WHERE question_id = 4277;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Championship

80s Inspiration: A championship format built around the enduring neighborhood classic, Kick the Can.

Objective: Apply full team strategy across multiple rounds of the classic can-guarding game.

Players: 4+ players

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!' WHERE question_id = 4278;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square King/Queen League

80s Inspiration: Builds a league format around the blacktop classic Four Square, tracking long-term standings.

Objective: Compete in an ongoing four square league, tracking who holds the top square the longest.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk | A league standings sheet

Follow the steps below to play!' WHERE question_id = 4279;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Double Dutch Relay

80s Inspiration: Turns the classic Double Dutch jump style into a team relay event.

Objective: Combine team relay racing with double dutch jump-rope skills.

Players: Teams of 2+ (2 or more teams)

Materials: 2 jump ropes per team

Follow the steps below to play!' WHERE question_id = 4280;

UPDATE dbo.PacketQuestions SET prompt = N'⚾ Wall Ball World Cup

80s Inspiration: A tournament format built around the classic recess wall-ball game.

Objective: Compete in a bracket-style wall ball tournament applying skill challenges.

Players: 2-4 players

Materials: 1 rubber ball | A flat outdoor wall | A bracket sheet

Follow the steps below to play!' WHERE question_id = 4281;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Jacks Retro Challenge

80s Inspiration: Jacks, a tiny-but-mighty pavement game played with a small ball and metal or plastic pieces, hugely popular through the 1980s.

Objective: Practice hand-eye coordination and quick reflexes with the classic game of jacks.

Players: 1+ (solo or group)

Materials: A set of jacks (or small stones/bottle caps) | 1 small bouncy ball

Follow the steps below to play!' WHERE question_id = 4282;

UPDATE dbo.PacketQuestions SET prompt = N'👏 Hand-Clap Rhythm Challenge

80s Inspiration: Inspired by the hand-clapping games that were a playground staple, where partners clap out a rhythm together.

Objective: Practice memory and rhythm by learning and repeating an original hand-clapping pattern with a partner.

Players: 2 players

Materials: None — just hands and a partner!

Follow the steps below to play!' WHERE question_id = 4283;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Team Tactics

80s Inspiration: The classic call-and-cross team game, played with real tactical planning.

Objective: Practice full-team strategy across multiple rounds of calling and defending.

Players: Whole group (6+)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5341;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Championship

80s Inspiration: A championship-format version of the classic Steal the Bacon game.

Objective: Practice competitive, multi-round retrieval strategy tracked for an overall winner.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!' WHERE question_id = 5342;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Championship

80s Inspiration: A championship-format version of the classic potato sack race.

Objective: Practice consistent, fast hopping across a full multi-round tournament.

Players: 1+ (solo or group)

Materials: Soft pillowcases or cloth sacks | Cones for a marked lane

Follow the steps below to play!' WHERE question_id = 5343;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Championship

80s Inspiration: A championship-format version of the classic egg-and-spoon race.

Objective: Practice consistent balance skill across a full multi-round tournament.

Players: 1+ (solo or group)

Materials: Large spoons | Small soft balls or pom-poms | Cones for a marked lane

Follow the steps below to play!' WHERE question_id = 5344;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Wheelbarrow Race Championship

80s Inspiration: A championship-format version of the classic field-day wheelbarrow race.

Objective: Practice sustained partner-balance strength across a full competitive race.

Players: Teams of 2+ (2 or more teams)

Materials: A soft grassy or padded surface | Cones for a marked lane

Follow the steps below to play!' WHERE question_id = 5345;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Championship

80s Inspiration: A championship-format version of the classic Mother May I game.

Objective: Practice competitive strategic step choices across a multi-round tournament.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5346;

UPDATE dbo.PacketQuestions SET prompt = N'🏓 Tetherball Championship

80s Inspiration: A championship-format version of the classic playground tetherball game.

Objective: Practice sustained tetherball skill across a full head-to-head tournament.

Players: 2 players

Materials: A tetherball pole and ball (or improvised rope-and-ball setup)

Follow the steps below to play!' WHERE question_id = 5347;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick Trick Practice

70s Inspiration: The trick-bouncing that advanced pogo enthusiasts showed off in the 1970s.

Objective: Practice adding a simple trick, like a quarter-turn, to steady pogo stick bouncing.

Players: 1+ (solo or group)

Materials: A pogo stick (child-sized)

Follow the steps below to play!' WHERE question_id = 5397;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Trick Flying

70s Inspiration: The playful trick-flying that advanced kite fans experimented with in the 1970s.

Objective: Practice steering a kite through simple loops and figure-eight patterns.

Players: 1+ (solo or group)

Materials: 1 kite with string

Follow the steps below to play!' WHERE question_id = 5398;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Rodeo Skills Test

70s Inspiration: The full skills-test bike rodeos that many 1970s schools and neighborhoods ran each summer.

Objective: Practice a full skills circuit combining slow riding, sharp turns, and precise stopping.

Players: 1+ (solo or group)

Materials: A bike | Cones for multiple stations | Chalk for a stopping line

Follow the steps below to play!' WHERE question_id = 5399;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Championship

70s Inspiration: A championship-format version of the classic 1970s playground game Spud.

Objective: Practice competitive strategy and quick freezing across a full multi-round tournament.

Players: 4+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5400;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard Slalom Championship

70s Inspiration: A championship-format version of the classic 1970s skateboard slalom.

Objective: Practice consistent slalom weaving across a full timed head-to-head tournament.

Players: 2-4 players

Materials: A skateboard | A helmet | Cones | A flat, smooth surface | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5401;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Relay Strategy

70s Inspiration: The strategic team Big Wheel relays that got competitive on longer 1970s summer days.

Objective: Practice smart hand-off timing and pacing across a multi-lap team relay.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 Big Wheels or similar ride-on trikes | Cones to mark a lane

Follow the steps below to play!' WHERE question_id = 5402;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Championship

70s Inspiration: A championship-format version of the classic 1970s water balloon toss.

Objective: Practice peak tossing precision across a full multi-pair elimination tournament.

Players: Teams of 2+ (2 or more teams)

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5403;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Trick Practice

90s Inspiration: The trick skating that advanced 1990s inline skaters practiced at the skate park or driveway.

Objective: Practice a simple, safe skating trick, like a one-foot glide, building on solid slalom skills.

Players: 1+ (solo or group)

Materials: Inline skates | A helmet and pads | A flat, smooth surface

Follow the steps below to play!' WHERE question_id = 5453;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Strategy Battle

90s Inspiration: The elaborate backyard water-gun battles with hiding spots and strategy that defined 1990s summers.

Objective: Practice using cover and timing strategically in a bigger team water gun battle.

Players: Teams of 2+ (2 or more teams)

Materials: Water guns, one per player | A marked play area with some hiding spots (bushes, chairs) | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5454;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Championship

90s Inspiration: A championship-format version of the classic 1990s recess game Grounders.

Objective: Practice consistent quick reactions across a full multi-round Grounders tournament.

Players: 4+ players

Materials: Multiple playground equipment pieces | Players rotating as ''It''

Follow the steps below to play!' WHERE question_id = 5455;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Manhunt Championship

90s Inspiration: A championship-format version of Manhunt, the epic evening game of 1990s neighborhoods.

Objective: Practice peak strategic hiding and searching skill across a multi-round Manhunt tournament.

Players: Whole group (6+)

Materials: 1-2 flashlights | A larger safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5456;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Slalom Championship

90s Inspiration: A championship-format version of the kick-scooter slalom courses popular in the late 1990s.

Objective: Practice consistent slalom weaving across a full timed head-to-head tournament.

Players: 2-4 players

Materials: A kick scooter | A helmet | Cones | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5457;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Championship

90s Inspiration: A championship-format version of the homemade chalk Twister game.

Objective: Practice peak balance and flexibility across a multi-round elimination Twister tournament.

Players: 3+ players

Materials: Playground chalk

Follow the steps below to play!' WHERE question_id = 5458;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Championship

90s Inspiration: The playground yo-yo competitions that were the ultimate showcase of 1990s trick skills.

Objective: Practice performing a sequence of tricks smoothly for a friendly judged competition.

Players: 2-4 players

Materials: 1 yo-yo per competitor

Follow the steps below to play!' WHERE question_id = 5459;
UPDATE dbo.PacketQuestions SET prompt = N'🚩 Capture the Flag: Advanced

Objective: Design and execute a multi-role team strategy involving scouts, guards, and runners.

Players: Teams of 2+ (2 or more teams)

Materials: 2 flags | Cones for boundaries and jail zones | Colored pinnies for teams

Follow the steps below to play!' WHERE question_id = 4102;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Ultimate Frisbee League

Objective: Play a full-length ultimate frisbee game applying complete rules and defensive strategy.

Players: Teams of 2+ (2 or more teams)

Materials: 1 flying disc | Cones for field boundaries and end zones | Pinnies for 2 teams

Follow the steps below to play!' WHERE question_id = 4103;

UPDATE dbo.PacketQuestions SET prompt = N'🏈 Flag Football Scrimmage

Objective: Run a structured flag football scrimmage applying downs, positions, and play strategy.

Players: Teams of 2+ (2 or more teams)

Materials: 1 football | Flag belts | Cones for field markers and end zones

Follow the steps below to play!' WHERE question_id = 4104;

UPDATE dbo.PacketQuestions SET prompt = N'🏗️ Team Obstacle Course Design

Objective: Design, build, and test a challenging obstacle course while considering safety and fairness.

Players: 3+ players

Materials: Cones, hula hoops, jump ropes, chalk, and other available yard equipment

Follow the steps below to play!' WHERE question_id = 4105;

UPDATE dbo.PacketQuestions SET prompt = N'🔐 Scavenger Hunt Cipher

Objective: Decode simple ciphers and clues to locate a sequence of hidden checkpoints.

Players: 1+ (solo or group)

Materials: Cipher clue cards (simple letter-shift codes) | Hidden checkpoint markers

Follow the steps below to play!' WHERE question_id = 4106;

UPDATE dbo.PacketQuestions SET prompt = N'⚽ Kickball Strategy League

Objective: Apply advanced kickball strategy including defensive positioning and kicking placement.

Players: Teams of 2+ (2 or more teams)

Materials: 1 kickball | 4 bases | Scorecard

Follow the steps below to play!' WHERE question_id = 4107;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Disc Golf Challenge

Objective: Complete a full disc golf course using strategic throws to minimize total throw count.

Players: 1+ (solo or group)

Materials: 1-2 flying discs | 8-9 target markers around the play area

Follow the steps below to play!' WHERE question_id = 4108;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Team Relay Championship

Objective: Coordinate a multi-leg relay combining running, jumping, and balance stations across a full team.

Players: Teams of 2+ (2 or more teams)

Materials: Cones, a jump rope, a balance beam or line, a baton

Follow the steps below to play!' WHERE question_id = 4109;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Orienteering Challenge

Objective: Use a compass and paced distances to navigate a multi-point course as accurately and quickly as possible.

Players: 1+ (solo or group)

Materials: Compass (or compass app) | Course map with 6-8 numbered checkpoints and bearings

Follow the steps below to play!' WHERE question_id = 4110;

UPDATE dbo.PacketQuestions SET prompt = N'💪 Tug of War Tournament

Objective: Compete in a bracket-style tug of war tournament, adjusting team strategy between matches.

Players: Teams of 2+ (2 or more teams)

Materials: 1 thick rope | Chalk for center lines | Tournament bracket sheet

Follow the steps below to play!' WHERE question_id = 4111;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Masters

Objective: Apply advanced four-square techniques and special rules in competitive play.

Players: 4+ players

Materials: 1 bouncy ball | Chalk for the court | List of ''special rule'' cards (optional advanced moves)

Follow the steps below to play!' WHERE question_id = 4112;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Team Building Trust Walk

Objective: Build communication and trust by guiding a blindfolded partner safely through a simple course.

Players: 2 players

Materials: Blindfolds (bandanas) | Cones or soft obstacles to navigate around

Follow the steps below to play!' WHERE question_id = 4113;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Speedball Basics

Objective: Combine soccer, basketball, and football movements in a fast-paced hybrid game.

Players: Teams of 2+ (2 or more teams)

Materials: 1 soccer-style ball | Cones for boundaries and goals

Follow the steps below to play!' WHERE question_id = 4114;

UPDATE dbo.PacketQuestions SET prompt = N'💧 Water Relay Olympics

Objective: Compete in a multi-station water-themed relay combining speed, balance, and teamwork.

Players: Teams of 2+ (2 or more teams)

Materials: Buckets, sponges, cups, water balloons | Cones marking 3-4 stations

Follow the steps below to play!' WHERE question_id = 4115;

UPDATE dbo.PacketQuestions SET prompt = N'🌉 Paper Bridge Engineering Challenge

Objective: Design and test a paper bridge that can hold as much weight as possible.

Players: 1+ (solo or group)

Materials: Several sheets of paper | Tape | 2 books or blocks (bridge supports) | Small weights (coins, small toys)

Follow the steps below to play!' WHERE question_id = 4172;

UPDATE dbo.PacketQuestions SET prompt = N'🏠 Household Item Olympics

Objective: Compete across multiple mini-events using only everyday household items.

Players: 2-4 players

Materials: Cups, socks, spoons, paper, string — whatever''s on hand

Follow the steps below to play!' WHERE question_id = 4173;

UPDATE dbo.PacketQuestions SET prompt = N'🏕️ Natural Materials Shelter Build

Objective: Design and build a small shelter or structure using only materials found outside.

Players: 1+ (solo or group)

Materials: Sticks, leaves, and other natural materials found outside | String (optional, for lashing sticks together)

Follow the steps below to play!' WHERE question_id = 4174;

UPDATE dbo.PacketQuestions SET prompt = N'📦 Cardboard Box Derby

Objective: Design and race simple cardboard vehicles down a ramp, testing speed and distance.

Players: 1+ (solo or group)

Materials: Small cardboard boxes or cardboard scraps | Tape | Bottle caps or small wheels (optional) | A ramp (a board or cardboard sheet propped up)

Follow the steps below to play!' WHERE question_id = 4175;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Sock and Spoon Trebuchet

Objective: Build a simple lever-based launcher and test its accuracy and distance.

Players: 1+ (solo or group)

Materials: 1 spoon | A rubber band | A pivot point (a block or stack of books) | Sock balls to launch

Follow the steps below to play!' WHERE question_id = 4176;

UPDATE dbo.PacketQuestions SET prompt = N'⚖️ Rock Balancing Art Challenge

Objective: Use patience, precision, and an understanding of balance to stack rocks into artistic sculptures.

Players: 1+ (solo or group)

Materials: 8-10 rocks of varying sizes and shapes

Follow the steps below to play!' WHERE question_id = 4177;

UPDATE dbo.PacketQuestions SET prompt = N'📰 Newspaper Fashion Design Race

Objective: Work in teams to design and ''construct'' a wearable outfit from newspaper as fast as possible.

Players: Teams of 2+ (2 or more teams)

Materials: A stack of newspaper per team | Tape | Scissors (with grown-up supervision)

Follow the steps below to play!' WHERE question_id = 4178;

UPDATE dbo.PacketQuestions SET prompt = N'🧩 Silent Line-Up Challenge

Objective: Practice nonverbal communication by organizing the group in order without talking.

Players: 3+ players

Materials: None — just a group of friends and no talking!

Follow the steps below to play!' WHERE question_id = 4228;

UPDATE dbo.PacketQuestions SET prompt = N'📖 One-Word Story

Objective: Build a story together where each person can only add a single word at a time.

Players: 2-4 players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4229;

UPDATE dbo.PacketQuestions SET prompt = N'🗣️ Debate Circle: Advanced

Objective: Practice building a structured argument with reasons and evidence on the spot.

Players: 2-4 players

Materials: None — just voices and quick thinking!

Follow the steps below to play!' WHERE question_id = 4230;

UPDATE dbo.PacketQuestions SET prompt = N'🎭 Freeze Frame Tableau

Objective: Work as a group to instantly create a frozen scene representing a given theme.

Players: 3+ players

Materials: None — just bodies and imagination!

Follow the steps below to play!' WHERE question_id = 4231;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Trust Walk

Objective: Build trust and communication by guiding a partner safely using only your voice.

Players: 2 players

Materials: None — just a partner and open space!

Follow the steps below to play!' WHERE question_id = 4232;

UPDATE dbo.PacketQuestions SET prompt = N'🧠 Memory Chain

Objective: Practice memory and listening by repeating and adding to a growing list.

Players: 2-4 players

Materials: None — just memory and voices!

Follow the steps below to play!' WHERE question_id = 4233;

UPDATE dbo.PacketQuestions SET prompt = N'🤔 Would You Rather Tournament

Objective: Debate and vote through a bracket of silly ''would you rather'' dilemmas.

Players: 4+ players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4234;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Trick Course

80s Inspiration: Adds trick-hopping challenges (spins, backward hops) onto the traditional hopscotch course.

Objective: Master advanced hopping tricks layered onto a standard hopscotch course.

Players: 1+ (solo or group)

Materials: Playground chalk | A beanbag marker

Follow the steps below to play!' WHERE question_id = 4284;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Advanced Strategy

80s Inspiration: A more advanced strategic layer added onto the classic Kick the Can game.

Objective: Apply layered team strategy, including decoys and timed sneaks, to outsmart the guard.

Players: 4+ players

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!' WHERE question_id = 4285;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Pro Rules

80s Inspiration: Adds advanced ''pro'' rule variations to the classic Four Square blacktop game.

Objective: Apply advanced four square rules, including special serves and challenge moves.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk

Follow the steps below to play!' WHERE question_id = 4286;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Double Dutch Freestyle

80s Inspiration: Freestyle Double Dutch routines were a showcase skill on playgrounds throughout the 1980s.

Objective: Create and perform an original freestyle double dutch routine with tricks.

Players: 3+ players

Materials: 2 jump ropes

Follow the steps below to play!' WHERE question_id = 4287;

UPDATE dbo.PacketQuestions SET prompt = N'⚾ Wall Ball Tournament

80s Inspiration: A full tournament structure built around the enduring recess classic, wall ball.

Objective: Compete in a full bracket tournament applying advanced wall ball rules and scoring.

Players: 2-4 players

Materials: 1 rubber ball | A flat outdoor wall | A bracket sheet

Follow the steps below to play!' WHERE question_id = 4288;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Jacks Championship

80s Inspiration: The classic game of jacks, played through its traditional leveled progression of picking up increasing numbers of pieces per toss.

Objective: Compete through the full progression of jacks levels, from onesies to tensies.

Players: 1+ (solo or group)

Materials: A set of jacks (or small stones/bottle caps) | 1 small bouncy ball

Follow the steps below to play!' WHERE question_id = 4289;

UPDATE dbo.PacketQuestions SET prompt = N'🖍️ Chalk Relay Obstacle

80s Inspiration: Blends several classic 1980s chalk pavement games into a single relay challenge.

Objective: Combine hopscotch hopping and tic-tac-toe tossing into one multi-station chalk relay.

Players: Teams of 2+ (2 or more teams)

Materials: Playground chalk | Beanbags

Follow the steps below to play!' WHERE question_id = 4290;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Grand League

80s Inspiration: A league-format version of the classic Red Rover team game.

Objective: Practice team leadership and strategy across a multi-team league format.

Players: Whole group (6+)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5348;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon Grand Tournament

80s Inspiration: A grand-tournament version of the classic Steal the Bacon game.

Objective: Practice advanced retrieval strategy across a full bracket tournament with multiple teams.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!' WHERE question_id = 5349;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Grand Championship

80s Inspiration: A grand-championship version of the classic field-day potato sack race.

Objective: Practice consistent racing performance across a full field-day-style championship.

Players: 2-4 players

Materials: Soft pillowcases or cloth sacks | Cones for marked lanes

Follow the steps below to play!' WHERE question_id = 5350;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Masters

80s Inspiration: A masters-level version of the classic egg-and-spoon race.

Objective: Practice mastering balance under pressure across a full elimination tournament.

Players: 2-4 players

Materials: Large spoons | Small soft balls or pom-poms | Cones for marked lanes

Follow the steps below to play!' WHERE question_id = 5351;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Wheelbarrow Race Grand Finals

80s Inspiration: A grand-finals version of the classic field-day wheelbarrow race.

Objective: Practice sustained teamwork and strength across a full elimination bracket.

Players: Teams of 2+ (2 or more teams)

Materials: A soft grassy or padded surface | Cones for marked lanes

Follow the steps below to play!' WHERE question_id = 5352;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Leader Rotation

80s Inspiration: An advanced version of the classic Mother May I game with rotating leadership.

Objective: Practice leadership by taking turns creating fair, creative step challenges for the group.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5353;

UPDATE dbo.PacketQuestions SET prompt = N'👻 Ghost in the Graveyard Championship

80s Inspiration: A bigger, more strategic version of the classic 1980s dusk hide-and-seek game.

Objective: Practice advanced stealth, teamwork, and quick sprinting in a large-group version of the classic game.

Players: Whole group (6+)

Materials: None -- just open space with hiding spots | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5354;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick Championship

70s Inspiration: A championship-format version of the classic 1970s pogo stick bouncing contest.

Objective: Practice peak bounce-count endurance across a full head-to-head contest.

Players: 2-4 players

Materials: Pogo sticks (child-sized), one per competitor

Follow the steps below to play!' WHERE question_id = 5404;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Flying Championship

70s Inspiration: A championship-format version of the classic 1970s park kite-flying contest.

Objective: Practice sustained flying skill and height management across a timed group competition.

Players: 2-4 players

Materials: 1 kite with string per player

Follow the steps below to play!' WHERE question_id = 5405;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Grand Finals

70s Inspiration: The grand finals of the classic 1970s water balloon toss tournament.

Objective: Practice peak precision tossing in a single deciding final round.

Players: 2 players

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5406;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Rodeo Championship

70s Inspiration: A championship-format version of the full 1970s neighborhood bike rodeo.

Objective: Practice peak precision across a full multi-station bike rodeo competition.

Players: 1+ (solo or group)

Materials: Bikes | Cones for multiple stations | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5407;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Grand Tournament

70s Inspiration: A grand-tournament version of the classic 1970s playground game Spud.

Objective: Practice advanced strategy and consistency across a full bracket-style Spud tournament.

Players: 4+ players

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5408;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard Slalom Masters

70s Inspiration: The most advanced slalom format of the classic 1970s skateboarding boom.

Objective: Practice mastery-level slalom control across the toughest, most tightly spaced cone course.

Players: 1+ (solo or group)

Materials: A skateboard | A helmet | 8-10 closely spaced cones | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5409;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Grand Prix

70s Inspiration: The friendly ''Grand Prix'' Big Wheel races that capped off many 1970s summer block parties.

Objective: Practice peak steady-speed pedaling across a full multi-lap Grand-Prix-style race.

Players: 2-4 players

Materials: Big Wheels or similar ride-on trikes, one per racer | Cones marking a full lap course

Follow the steps below to play!' WHERE question_id = 5410;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Championship

90s Inspiration: A championship-format version of the inline-skating slalom courses from the 1990s.

Objective: Practice peak slalom speed and control across a full timed skating competition.

Players: 1+ (solo or group)

Materials: Inline skates | A helmet and pads | Cones | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5460;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun Grand Battle

90s Inspiration: The all-out neighborhood water wars that were the ultimate 1990s summer showdown.

Objective: Practice large-group strategy and teamwork in a full multi-team water gun tournament.

Players: Whole group (6+)

Materials: Water guns, one per player | A large marked play area | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5461;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Masters

90s Inspiration: The most advanced format of the classic 1990s recess game Grounders.

Objective: Practice mastery-level quick reactions across the most demanding Grounders format.

Players: 4+ players

Materials: Multiple playground equipment pieces spread widely | Players rotating as ''It''

Follow the steps below to play!' WHERE question_id = 5462;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Manhunt Masters

90s Inspiration: The master-level Manhunt games that became legendary in some 1990s neighborhoods.

Objective: Practice the most advanced hiding, searching, and communication strategy across a full Manhunt season.

Players: Whole group (6+)

Materials: 1-2 flashlights | A large, safe, agreed-upon area at dusk | A grown-up to supervise

Follow the steps below to play!' WHERE question_id = 5463;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Slalom Masters

90s Inspiration: The most advanced scooter slalom format from the height of the late-1990s scooter craze.

Objective: Practice mastery-level scooter control across the toughest, most tightly spaced cone course.

Players: 1+ (solo or group)

Materials: A kick scooter | A helmet | 8-10 closely spaced cones | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5464;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Masters

90s Inspiration: The ultimate mastery-level format of the homemade chalk Twister craze.

Objective: Practice the most demanding balance combinations in a mastery-level chalk Twister showdown.

Players: 1+ (solo or group)

Materials: Playground chalk | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5465;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Masters

90s Inspiration: The showcase yo-yo routines that crowned the true yo-yo masters of the 1990s playground scene.

Objective: Practice combining multiple tricks into one smooth, judged routine at the highest skill level.

Players: 1+ (solo or group)

Materials: 1 yo-yo per competitor

Follow the steps below to play!' WHERE question_id = 5466;

UPDATE dbo.PacketQuestions SET prompt = N'🚩 Capture the Flag: Championship

Objective: Lead a full team through a multi-round championship applying complex strategy and sportsmanship.

Players: Teams of 2+ (2 or more teams)

Materials: 2 flags | Cones for boundaries and jail zones | Pinnies for teams

Follow the steps below to play!' WHERE question_id = 4116;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Ultimate Frisbee Tournament

Objective: Compete in a bracket-style ultimate frisbee tournament applying full rules and sportsmanship (the ''Spirit of the Game'').

Players: Teams of 2+ (2 or more teams)

Materials: 1 flying disc per field | Cones for boundaries and end zones | Bracket sheet

Follow the steps below to play!' WHERE question_id = 4117;

UPDATE dbo.PacketQuestions SET prompt = N'🏈 Flag Football League

Objective: Play a full flag football league match applying offensive plays, defensive coverage, and scoring strategy.

Players: Teams of 2+ (2 or more teams)

Materials: 1 football | Flag belts | Cones for yard markers and end zones | Scorecard

Follow the steps below to play!' WHERE question_id = 4118;

UPDATE dbo.PacketQuestions SET prompt = N'🧗 Leadership Obstacle Course

Objective: Take turns leading a team through an obstacle course using only verbal instructions.

Players: 3+ players

Materials: Cones, hula hoops, jump ropes for an obstacle course | Blindfolds (optional challenge mode)

Follow the steps below to play!' WHERE question_id = 4119;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Orienteering Expedition

Objective: Navigate an extended multi-checkpoint course using compass bearings, pacing, and map reading as a team.

Players: 2-4 players

Materials: Compass (or compass app) | Detailed course map with 8-10 checkpoints and bearings/distances

Follow the steps below to play!' WHERE question_id = 4120;

UPDATE dbo.PacketQuestions SET prompt = N'🥏 Disc Golf Tournament

Objective: Compete across a full disc golf course, applying strategic throw selection to achieve the lowest score.

Players: 1+ (solo or group)

Materials: 1-2 flying discs per player | 9-hole course with target markers | Scorecards

Follow the steps below to play!' WHERE question_id = 4121;

UPDATE dbo.PacketQuestions SET prompt = N'🗝️ Team Strategy Scavenger Hunt

Objective: Plan and execute a team strategy to efficiently solve multi-step clues and puzzles across a wide area.

Players: 3+ players

Materials: 6-8 multi-step clue cards (riddles, simple ciphers, math clues) | Hidden final prize

Follow the steps below to play!' WHERE question_id = 4122;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Speedball Match

Objective: Apply combined soccer/basketball/football rules in a full competitive speedball match.

Players: Teams of 2+ (2 or more teams)

Materials: 1 soccer-style ball | Cones for boundaries and goals | Pinnies for 2 teams

Follow the steps below to play!' WHERE question_id = 4123;

UPDATE dbo.PacketQuestions SET prompt = N'💪 Tug of War Finals

Objective: Compete in a high-stakes tug of war final applying refined team strategy and timing.

Players: Teams of 2+ (2 or more teams)

Materials: 1 thick rope | Chalk for center line | Tournament bracket sheet showing finalists

Follow the steps below to play!' WHERE question_id = 4124;

UPDATE dbo.PacketQuestions SET prompt = N'🔁 Relay Olympics

Objective: Compete across a full multi-event relay Olympics combining speed, skill, and teamwork events.

Players: Teams of 2+ (2 or more teams)

Materials: Cones, jump ropes, batons, balance beams, and other relay equipment

Follow the steps below to play!' WHERE question_id = 4125;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Team Building Challenge Course

Objective: Solve a series of cooperative physical challenges that require full-team communication and trust.

Players: Whole group (6+)

Materials: Jump ropes, hula hoops, a tarp or blanket, cones

Follow the steps below to play!' WHERE question_id = 4126;

UPDATE dbo.PacketQuestions SET prompt = N'⚽ Kickball Championship

Objective: Apply full strategic kickball play across a championship-level multi-inning match.

Players: Teams of 2+ (2 or more teams)

Materials: 1 kickball | 4 bases | Scorecard

Follow the steps below to play!' WHERE question_id = 4127;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Pro League

Objective: Compete in an ongoing four-square league applying advanced strategy and special move rules.

Players: 4+ players

Materials: 1 bouncy ball | Chalk for the court | League standings sheet

Follow the steps below to play!' WHERE question_id = 4128;

UPDATE dbo.PacketQuestions SET prompt = N'🏃 Fitness Circuit Relay

Objective: Complete a fast-paced circuit combining strength, cardio, and agility stations as a team.

Players: Teams of 2+ (2 or more teams)

Materials: Cones for 6 stations | A jump rope | A stopwatch (or phone timer)

Follow the steps below to play!' WHERE question_id = 4129;

UPDATE dbo.PacketQuestions SET prompt = N'🗼 Paper Tower Engineering Challenge

Objective: Design and build the tallest free-standing paper tower that can support a weight on top.

Players: 1+ (solo or group)

Materials: A stack of paper | Tape | A small weight (like a small book or apple) to place on top

Follow the steps below to play!' WHERE question_id = 4179;

UPDATE dbo.PacketQuestions SET prompt = N'🏆 Household Item Triathlon

Objective: Compete across three different skill-based mini-events using everyday items.

Players: 2-4 players

Materials: A ball or sock ball, a spoon, cups, and other household items

Follow the steps below to play!' WHERE question_id = 4180;

UPDATE dbo.PacketQuestions SET prompt = N'🧭 Nature Survival Skills Challenge

Objective: Practice basic outdoor skills like shelter-building, direction-finding, and identifying materials.

Players: 1+ (solo or group)

Materials: Sticks, leaves, and natural materials found outside | A simple compass (optional)

Follow the steps below to play!' WHERE question_id = 4181;

UPDATE dbo.PacketQuestions SET prompt = N'⛵ Cardboard Boat Regatta

Objective: Design and test a small cardboard/foil boat for how much weight it can float before sinking.

Players: 1+ (solo or group)

Materials: Cardboard scraps or aluminum foil | Tape | A tub or basin of water | Small weights (coins)

Follow the steps below to play!' WHERE question_id = 4182;

UPDATE dbo.PacketQuestions SET prompt = N'🌉 String and Stick Bridge Challenge

Objective: Design a small bridge using sticks and string, then test its strength.

Players: 1+ (solo or group)

Materials: Several sticks | String or yarn | Two supports (books or blocks) | Small weights to test with

Follow the steps below to play!' WHERE question_id = 4183;

UPDATE dbo.PacketQuestions SET prompt = N'💡 Recycled Materials Invention Fair

Objective: Design and build a useful invention using only recycled household materials.

Players: 1+ (solo or group)

Materials: Clean recyclables (cardboard, bottles, paper, caps) | Tape or glue

Follow the steps below to play!' WHERE question_id = 4184;

UPDATE dbo.PacketQuestions SET prompt = N'🕐 Natural Compass and Shadow Clock Challenge

Objective: Build a simple shadow clock using a stick and track how shadows change over time.

Players: 1+ (solo or group)

Materials: 1 stick | Small stones or markers | A sunny outdoor spot | A watch or phone clock (for reference only)

Follow the steps below to play!' WHERE question_id = 4185;

UPDATE dbo.PacketQuestions SET prompt = N'🗣️ Formal Debate Showdown

Objective: Practice structured, respectful argument with opening statements, rebuttals, and closing remarks.

Players: Teams of 2+ (2 or more teams)

Materials: None — just voices, quick thinking, and 2 teams!

Follow the steps below to play!' WHERE question_id = 4235;

UPDATE dbo.PacketQuestions SET prompt = N'🧠 Memory Palace Challenge

Objective: Practice memory techniques by linking a growing list of items to a mental journey.

Players: 1+ (solo or group)

Materials: None — just memory and imagination!

Follow the steps below to play!' WHERE question_id = 4236;

UPDATE dbo.PacketQuestions SET prompt = N'🎭 Improv Scene Building

Objective: Practice quick creative thinking by building an unscripted scene together with a partner.

Players: 2 players

Materials: None — just imagination, voices, and a partner!

Follow the steps below to play!' WHERE question_id = 4237;

UPDATE dbo.PacketQuestions SET prompt = N'🤝 Blind Trust Formation

Objective: Work as a full group, using only verbal guidance, to form a specific shape together.

Players: Whole group (6+)

Materials: None — just a group of friends and no peeking!

Follow the steps below to play!' WHERE question_id = 4238;

UPDATE dbo.PacketQuestions SET prompt = N'📖 Collaborative Mystery Story

Objective: Build a mystery story together, each adding a clue or twist in turn.

Players: 2-4 players

Materials: None — just imagination and voices!

Follow the steps below to play!' WHERE question_id = 4239;

UPDATE dbo.PacketQuestions SET prompt = N'🧩 Silent Sorting Challenge

Objective: Communicate and organize as a group using only gestures, no talking or writing.

Players: 3+ players

Materials: None — just a group of friends and no talking!

Follow the steps below to play!' WHERE question_id = 4240;

UPDATE dbo.PacketQuestions SET prompt = N'😉 Wink Assassin Tournament

Objective: Sharpen observation and deduction skills in an advanced elimination-style wink-detective game.

Players: 4+ players

Materials: None — just eyes and a group of friends!

Follow the steps below to play!' WHERE question_id = 4241;

UPDATE dbo.PacketQuestions SET prompt = N'🦶 Hopscotch Innovator Challenge

80s Inspiration: Takes creative ownership of the traditional hopscotch format, inviting players to reinvent it.

Objective: Design a completely original hopscotch course layout, then teach others to play it.

Players: 1+ (solo or group)

Materials: Playground chalk | A beanbag marker

Follow the steps below to play!' WHERE question_id = 4291;

UPDATE dbo.PacketQuestions SET prompt = N'🥤 Kick the Can Strategy League

80s Inspiration: A league format that treats the classic Kick the Can game as an ongoing strategic competition.

Objective: Compete across multiple structured rounds, refining team strategy each time.

Players: 4+ players

Materials: 1 empty plastic bottle or bucket (the ''can'')

Follow the steps below to play!' WHERE question_id = 4292;

UPDATE dbo.PacketQuestions SET prompt = N'🔲 Four Square Masters Retro League

80s Inspiration: A full league season built around the enduring blacktop classic, Four Square.

Objective: Compete in a season-long four square league, tracking standings across multiple matches.

Players: 4+ players

Materials: 1 bouncy ball | Playground chalk | A league standings sheet

Follow the steps below to play!' WHERE question_id = 4293;

UPDATE dbo.PacketQuestions SET prompt = N'🪢 Double Dutch Performance Challenge

80s Inspiration: Reflects the competitive Double Dutch performance teams that became a genuine sport through the 1980s.

Objective: Choreograph and perform a synchronized double dutch routine with multiple jumpers.

Players: 4+ players

Materials: 2 jump ropes

Follow the steps below to play!' WHERE question_id = 4294;

UPDATE dbo.PacketQuestions SET prompt = N'⚾ Wall Ball Grand Championship

80s Inspiration: The ultimate tournament format for the classic recess wall-ball game.

Objective: Compete in a full tournament with escalating skill challenges to determine an overall champion.

Players: 2-4 players

Materials: 1 rubber ball | A flat outdoor wall | A bracket sheet

Follow the steps below to play!' WHERE question_id = 4295;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Jacks Speed Championship

80s Inspiration: Adds a speed-run challenge to the traditional leveled game of jacks.

Objective: Race through the full jacks progression as fast as possible while maintaining accuracy.

Players: 1+ (solo or group)

Materials: A set of jacks (or small stones/bottle caps) | 1 small bouncy ball | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 4296;

UPDATE dbo.PacketQuestions SET prompt = N'🏆 Retro Playground Pentathlon

80s Inspiration: Combines five different 1980s playground classics into one multi-event competition, like a track-and-field pentathlon.

Objective: Compete across five classic playground events to determine an all-around champion.

Players: 1+ (solo or group)

Materials: Playground chalk | A jump rope | A bouncy ball | Beanbags | A set of jacks

Follow the steps below to play!' WHERE question_id = 4297;

UPDATE dbo.PacketQuestions SET prompt = N'🙌 Red Rover Legends Cup

80s Inspiration: The most advanced format of the classic Red Rover team game.

Objective: Practice top-level team strategy and communication across a full multi-team cup format.

Players: Whole group (6+)

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5355;

UPDATE dbo.PacketQuestions SET prompt = N'👑 Mother May I Grandmaster Round

80s Inspiration: The most advanced format of the classic Mother May I game.

Objective: Practice inventing and negotiating fair, creative step challenges at an advanced level.

Players: 3+ players

Materials: None -- just open space!

Follow the steps below to play!' WHERE question_id = 5356;

UPDATE dbo.PacketQuestions SET prompt = N'🥓 Steal the Bacon World Series

80s Inspiration: The most advanced format of the classic Steal the Bacon game.

Objective: Practice elite-level retrieval strategy across a best-of-several-rounds series between two top teams.

Players: Teams of 2+ (2 or more teams)

Materials: 1-2 soft objects (rolled socks or beanbags)

Follow the steps below to play!' WHERE question_id = 5357;

UPDATE dbo.PacketQuestions SET prompt = N'🛍️ Sack Race Ultimate Finals

80s Inspiration: The final, ultimate round of the classic field-day potato sack race.

Objective: Practice peak hopping consistency in a single ultimate final race.

Players: 2-4 players

Materials: Soft pillowcases or cloth sacks | Cones for a marked lane

Follow the steps below to play!' WHERE question_id = 5358;

UPDATE dbo.PacketQuestions SET prompt = N'🥄 Egg and Spoon Grand Masters Cup

80s Inspiration: The final, ultimate round of the classic field-day egg-and-spoon race.

Objective: Practice mastering precision balance under the pressure of a final head-to-head cup match.

Players: 2-4 players

Materials: Large spoons | Small soft balls or pom-poms | Cones for a marked lane

Follow the steps below to play!' WHERE question_id = 5359;

UPDATE dbo.PacketQuestions SET prompt = N'🦵 Wheelbarrow Race Legends League

80s Inspiration: The most advanced format of the classic field-day wheelbarrow race.

Objective: Practice sustained partner strength and trust across a full multi-pair league format.

Players: Teams of 2+ (2 or more teams)

Materials: A soft grassy or padded surface | Cones for marked lanes

Follow the steps below to play!' WHERE question_id = 5360;

UPDATE dbo.PacketQuestions SET prompt = N'🎪 80s Field Day Showdown

80s Inspiration: A capstone celebration combining several classic 1980s field-day games into one big showdown.

Objective: Practice a wide range of retro field-day skills across several linked mini-stations in one big event.

Players: Whole group (6+)

Materials: Soft pillowcases or cloth sacks | Large spoons and small soft balls | Soft cloth ties for partner races | Cones or markers for each station

Follow the steps below to play!' WHERE question_id = 5361;

UPDATE dbo.PacketQuestions SET prompt = N'🦘 Pogo Stick Masters

70s Inspiration: The most advanced pogo stick bouncing contest format from the 1970s craze.

Objective: Practice mastery-level bouncing endurance and control at the highest difficulty.

Players: 1+ (solo or group)

Materials: Pogo sticks (child-sized), one per competitor

Follow the steps below to play!' WHERE question_id = 5411;

UPDATE dbo.PacketQuestions SET prompt = N'🪁 Kite Flying Masters

70s Inspiration: The most advanced kite-flying format enjoyed by dedicated 1970s kite hobbyists.

Objective: Practice mastery-level kite control, combining height, duration, and simple tricks.

Players: 1+ (solo or group)

Materials: 1 kite with string per player

Follow the steps below to play!' WHERE question_id = 5412;

UPDATE dbo.PacketQuestions SET prompt = N'🎈 Water Balloon Toss Masters

70s Inspiration: The ultimate mastery-level version of the classic 1970s water balloon toss.

Objective: Practice the most advanced tossing precision across the longest distances yet.

Players: 2 players

Materials: Small water balloons | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5413;

UPDATE dbo.PacketQuestions SET prompt = N'🚲 Bike Rodeo Masters

70s Inspiration: The master-class bike rodeo format that capped off the best 1970s neighborhood bike skills events.

Objective: Practice the highest level of bike control across the most demanding rodeo course.

Players: 1+ (solo or group)

Materials: Bikes | Cones for a demanding multi-station course | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5414;

UPDATE dbo.PacketQuestions SET prompt = N'🏐 Spud Masters League

70s Inspiration: A league-format version of the classic 1970s playground game Spud, for a big group.

Objective: Practice the most advanced group strategy and awareness across an ongoing league format.

Players: Whole group (6+)

Materials: 1 soft, lightweight ball

Follow the steps below to play!' WHERE question_id = 5415;

UPDATE dbo.PacketQuestions SET prompt = N'🛹 Skateboard Trick Masters

70s Inspiration: The trick-combo showcases that top 1970s skateboarders were known for.

Objective: Practice combining slalom control with a simple, safe trick for the ultimate skateboarding showcase.

Players: 1+ (solo or group)

Materials: A skateboard | A helmet | Cones | A flat, smooth surface

Follow the steps below to play!' WHERE question_id = 5416;

UPDATE dbo.PacketQuestions SET prompt = N'🚗 Big Wheel Grand Prix Masters

70s Inspiration: The legendary multi-lap Big Wheel Grand Prix races that ended many epic 1970s summers.

Objective: Practice the ultimate combination of speed, cornering, and endurance across the longest Big Wheel race yet.

Players: 2-4 players

Materials: Big Wheels or similar ride-on trikes, one per racer | Cones marking a full multi-turn lap course

Follow the steps below to play!' WHERE question_id = 5417;

UPDATE dbo.PacketQuestions SET prompt = N'🛼 Rollerblade Slalom Masters

90s Inspiration: The most advanced inline-skating showcase from the peak of the 1990s craze.

Objective: Practice the highest level of skating control combining slalom, one-foot glides, and stopping.

Players: 1+ (solo or group)

Materials: Inline skates | A helmet and pads | Cones | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5467;

UPDATE dbo.PacketQuestions SET prompt = N'💦 Water Gun World Championship

90s Inspiration: The legendary all-day water gun tournaments that capped off epic 1990s summers.

Objective: Practice the ultimate combination of strategy, teamwork, and accuracy in a grand water gun finale.

Players: Whole group (6+)

Materials: Water guns, one per player | A large marked play area with hiding spots | Towels for drying off

Follow the steps below to play!' WHERE question_id = 5468;

UPDATE dbo.PacketQuestions SET prompt = N'🛝 Grounders Grand Champion

90s Inspiration: The grand-champion format of the classic 1990s recess game Grounders.

Objective: Practice the ultimate combination of speed, awareness, and safe climbing across an extended tournament.

Players: 4+ players

Materials: Multiple playground equipment pieces spread widely | Players rotating as ''It''

Follow the steps below to play!' WHERE question_id = 5469;

UPDATE dbo.PacketQuestions SET prompt = N'🔦 Manhunt Grand Finale

90s Inspiration: The legendary season-ending Manhunt finales that neighborhood kids talked about for years.

Objective: Practice the ultimate combination of stealth, strategy, and teamwork in a climactic final round.

Players: Whole group (6+)

Materials: 1-2 flashlights | The largest safe, agreed-upon area available at dusk | Multiple grown-ups to supervise

Follow the steps below to play!' WHERE question_id = 5470;

UPDATE dbo.PacketQuestions SET prompt = N'🛴 Scooter Grand Prix

90s Inspiration: The legendary end-of-summer scooter showcases that capped off the late-1990s scooter craze.

Objective: Practice combining slalom skill, speed, and a simple trick in one ultimate scooter showcase.

Players: 1+ (solo or group)

Materials: A kick scooter | A helmet | Cones | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5471;

UPDATE dbo.PacketQuestions SET prompt = N'🎯 Chalk Twister Grand Champion

90s Inspiration: The grand-champion format of the homemade chalk Twister craze at its most competitive.

Objective: Practice the ultimate balance and flexibility test across a multi-round elimination showdown.

Players: 1+ (solo or group)

Materials: Playground chalk | A stopwatch or phone timer

Follow the steps below to play!' WHERE question_id = 5472;

UPDATE dbo.PacketQuestions SET prompt = N'🪀 Yo-Yo Grand Masters

90s Inspiration: The grand finale yo-yo showcases that crowned the true legends of the 1990s playground yo-yo scene.

Objective: Practice the ultimate trick routine, combining every skill learned into one polished final performance.

Players: 1+ (solo or group)

Materials: 1 yo-yo per competitor

Follow the steps below to play!' WHERE question_id = 5473;
GO
