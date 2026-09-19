# First-project-

NAME: The Last Harvest
GAME STRUCTURE
Day 1
You arrive at the farm.
You have:
3 seeds
5 water
100% health
Your objective:
"Harvest enough food to survive the night."
You plant your crops.
Explore the farm.
Find resources.
Eventually:
SUNSET
A message appears:
Something is coming.
Night begins.
A creature appears.
You protect your crops.
________________________________________
Day 2
The farm looks different.
Some crops have grown.
But one has become strange.
A giant black root is growing underneath it.
You can:
A
Harvest it.
Get lots of food.
But the root grows.
B
Destroy it.
Lose the harvest.
But the farm becomes safer.
C
Leave it.
Nothing happens immediately.
But something changes later.
________________________________________
🧠 Simple game mechanics
You don't need complicated mechanics.
Movement
Top-down player movement.
W
↑
A ← Player → D
↓
S
Interaction
Press E near objects.
[E] Harvest
[E] Water
[E] Plant
[E] Pick up
Inventory
Something extremely simple:
┌─────────────────────┐
│ INVENTORY            │
│                     │
│ 🌾 Wheat       x12   │
│ 🌱 Seeds        x4   │
│ 🪵 Wood         x8   │
│ 🍎 Food         x6   │
└─────────────────────┘
Day/Night
Simple timer:
DAY 1

☀️  08:00
      ↓
     12:00
      ↓
     18:00
      ↓
🌙 NIGHT
You don't need real-time days. You can just make each day 2–3 minutes.
________________________________________
👾 The enemy
Don't make 10 different enemies.
Make one enemy.
Call it:
The Wither
It appears at night.
Its objective:
Destroy your crops.
The player can:
•	Attack it 
•	Run away 
•	Build barriers 
•	Protect crops 
Simple AI:
Find nearest crop
        ↓
Walk toward crop
        ↓
Attack crop
        ↓
If player attacks
        ↓
Chase player
That's enough.
________________________________________
🌾 The actual "Harvest" mechanic
This is where you can make your game stand out.
Each crop has a Harvest Value.
Example:
Wheat
Growth: ████████░░ 80%
Value: 2

Golden Wheat
Growth: ██████████ 100%
Value: 15
But there's also:
Soil Health
SOIL HEALTH

████████░░ 80%
Harvesting repeatedly reduces soil health.
If it reaches zero:
Nothing grows.
The player therefore has to decide:
Do I harvest everything now?
or
Do I sacrifice today's food for tomorrow's harvest?
That's directly connected to the theme.
________________________________________
Art direction
Don't make it visually complicated.
I'd go for:
Top-down pixel art
Something like:
🌲 🌲 🌲 🌲 🌲 🌲

🌲     🌾 🌾 🌾
       🌾 🧑 🌾
       🌾 🌾 🌾

   🏠 FARM

🌲 🌲 🌲 🌲 🌲
You can divide your assets into:
Environment
•	Grass 
•	Dirt 
•	Water 
•	Trees 
•	Rocks 
•	Fence 
•	House 
Crops
•	Seed 
•	Small crop 
•	Medium crop 
•	Mature crop 
•	Harvested crop 
Characters
•	Player 
•	Wither 
UI
•	Health 
•	Food 
•	Seeds 
•	Day 
•	Time 
•	Soil health 
That's a manageable asset list.
________________________________________
👥 Split the work between your team
Since you're already using GitHub, I'd divide it cleanly:
Person 1 — Player
•	Movement 
•	Animation 
•	Collision 
•	Interaction 
Person 2 — Farming
•	Planting 
•	Growth 
•	Watering 
•	Harvesting 
•	Inventory 
Person 3 — World
•	Map 
•	Environment 
•	Day/night 
•	NPC/enemy 
Person 4 — Game systems
•	UI 
•	Menus 
•	Win/lose conditions 
•	Sound 
•	Game balancing 
And keep everything merged into main through your Git workflow.
________________________________________
🏆 A really good ending
After surviving several days, the player reaches the final harvest.
The mysterious root underneath the farm finally reveals itself.
The player discovers that the farm wasn't dying.
It was being harvested by something else.
The player gets one final choice:
HARVEST
Take everything.
Huge score.
The land dies.
SACRIFICE
Destroy the crops.
The land survives.
RESTORE
Use all your accumulated resources to restore the soil.
The farm comes back to life.
Then show:
THE HARVEST IS NOT WHAT YOU TAKE.
IT'S WHAT YOU LEAVE BEHIND.

