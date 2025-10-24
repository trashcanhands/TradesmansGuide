Mining = {
    buttonText = "Mining",
    headerText = "THE MINER",
    
    sections = {
        {
            title = "",
            description = [[------------------------------------------------------------------------------------------------
Preface
------------------------------------------------------------------------------------------------
Don't forget to buy a |cFFFFFFFFMining Pick|r from the Mining Supply vendor near your trainer. No need to equip, just have one in your bags.
|cFF00FF00[Enchant Gloves - Mining]|r: +5 Mining skill
Copper Smelting grants skill points
Check Smelting recipes at your trainer
|cFFFF0000Red Circles|r indicate Caves where you can find good amounts of ore
------------------------------------------------------------------------------------------------

Levels: [1-65]
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Copper Ore]|r
     Requires |cFF33FFFF[Mining 1]|r
------------------------------------------------------------------------------------------------
ZONE OPTIONS:
------------------------------------------------------------------------------------------------
|cFFFF0000[H]|r |cFF33FF99Durotar|r - Orc/Troll starting zone
|cFFFF0000[H]|r |cFF33FF99Mulgore|r - Tauren starting zone
|cFFFF0000[H]|r |cFF33FF99Tirisfal Glades|r - Undead starting zone

|cFF66B2FF[A]|r |cFF33FF99Elwynn Forest|r - Human starting zone (Low level players: skip both caves)
|cFF66B2FF[A]|r |cFF33FF99Dun Morogh|r - Dwarf/Gnome starting zone
|cFF66B2FF[A]|r |cFF33FF99Darkshore|r - Night Elf alternative, as |cFF33FF99Teldrassil|r has no copper

NOTE: All |cFF33FF99Starter Zones|r have similar copper density
Mine every Copper node you see (stockpile for later)







------------------------------------------------------------------------------------------------
Farming Route Maps:
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Durotar", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Durotar_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Durotar_2"
                }},
                {name = "Mulgore", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Mulgore_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Mulgore_2"
                }},
                {name = "Tirisfal Glades", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Tirisfal_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Tirisfal_2"
                }},
                {name = "Elwynn Forest", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Elwynn_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Elwynn_2"
                }},
                {name = "Darkshore", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Darkshore_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Darkshore_2"
                }},
                {name = "Dun Morogh", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\DunMorogh_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\DunMorogh_2"
                }}
            }
        },
        {
            title = "Levels: [65-125]",
            description = [[------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Journeyman Miner]|r (Requires character level 10, Mining 50; Raises Cap [75] > [150])
WHERE: 
      Any major city Mining trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Tin Ore]|r
     Requires |cFF33FFFF[Mining 65]|r
|cFFFFFFFF[Copper Ore]|r
     Requires |cFF33FFFF[Mining 1]|r
|cFF00FF00[Silver Ore]|r
     Requires |cFF33FFFF[Mining 75]|r (uncommon spawns)

At 75 you can learn how to smelt Silver Ore, this will help you get to 125
Silver Ore and bars sell for roughly the same - buy the ore and sell the bars|r at [|cFFFFFF00Auction House|r]

ZONE OPTIONS:
|cFF33FF99Hillsbrad Foothills|r - Large zone, many caves
|cFF33FF99Redridge Mountains|r - Good ore density
|cFF33FF99Ashenvale|r - Compact and efficient
|cFF33FF99The Barrens|r - Coastal zone with caves

TIP: Save Silver Ore for crafting or selling
TIP: Mine Copper nodes if no Tin available








------------------------------------------------------------------------------------------------
Farming Route Maps:
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Hillsbrad Foothills", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Hillsbrad_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Hillsbrad_2"
                }},
                {name = "Redridge Mountains", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Redridge_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Redridge_2"
                }},
                {name = "Ashenvale", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Ashenvale_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Ashenvale_2"
                }},
                {name = "The Barrens", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\TheBarrens_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\TheBarrens_2"
                }}
            }
        },
        {
            title = "Levels: [125-175]",
            description = [[------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Expert Miner]|r (Requires character level 20, Mining 125; Raises Cap [150] > [225])
WHERE: 
      Any major city Mining trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Iron Ore]|r
     Requires |cFF33FFFF[Mining 125]|r
|cFFFFFFFF[Tin Ore]|r
     Requires |cFF33FFFF[Mining 65]|r
|cFF00FF00[Gold Ore]|r
     Requires |cFF33FFFF[Mining 155]|r (uncommon spawns)

At 155 you can learn how to smelt Gold Ore. Buy around 30 Gold Ore then smelt them,this should get you to around 175
Same as with Silver Ore - buy them, smelt them, and sell the bars at the [|cFFFFFF00Auction House|r]

------------------------------------------------------------------------------------------------
ZONE OPTIONS:
------------------------------------------------------------------------------------------------
|cFF33FF99Arathi Highlands|r - Excellent ore variety
There are 4 caves, make sure to go all the way to the end of each cave because you won't see all veins from the entrance
Low level players: skip all 4 caves
Low level Alliance players should take a detour and go south of |cFF33FF99Hammerfall|r

|cFF33FF99Desolace|r - Many caves and cliffs
|cFF33FF99Thousand Needles|r - Desert zone with cliffs

TIP: Save Gold Ore - very valuable
------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------
Farming Route Maps:
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Arathi Highlands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Arathi_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Arathi_2"
                }},
                {name = "Desolace", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Desolace_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Desolace_2"
                }},
                {name = "Thousand Needles", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\ThousandNeedles_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\ThousandNeedles_2"
                }}
            }
        },
        {
            title = "Levels: [175-245]",
            description = [[------------------------------------------------------------------------------------------------
TRAIN:
      |cFF1EFF00[Artisan Miner]|r (Requires character level 35, Mining 220; Raises Cap [225] > [300])
WHERE:
      Any major city Mining trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Mithril Ore]|r
     Requires |cFF33FFFF[Mining 175]|r
|cFF00FF00[Truesilver Ore]|r
     Requires |cFF33FFFF[Mining 230]|r (rare spawns)

------------------------------------------------------------------------------------------------
ZONE OPTIONS:
------------------------------------------------------------------------------------------------
|cFF33FF99Hinterlands|r - Excellent Mithril density
Low level players: skip red route (filled with level 62 elites)
Low level players: skip the caves (depends on your gear/class)

|cFF33FF99Tanaris|r - Large desert zone

TIP: Truesilver spawns where Mithril spawns
TIP: Check cave systems thoroughly
------------------------------------------------------------------------------------------------










------------------------------------------------------------------------------------------------
Farming Route Maps:
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Hinterlands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Hinterlands_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Hinterlands_2"
                }},
                {name = "Tanaris", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Tanaris_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Tanaris_2"
                }}
            }
        },
        {
            title = "Levels: [245-275]",
            description = [[------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Mithril Ore]|r
     Requires |cFF33FFFF[Mining 175]|r
|cFF00FF00[Truesilver Ore]|r
     Requires |cFF33FFFF[Mining 230]|r (rare spawns)
|cFFFFFFFF[Thorium Ore]|r
     Requires |cFF33FFFF[Mining 245]|r
|cFF9D9D9D[Small Thorium Vein]|r
     Requires |cFF33FFFF[Mining 245]|r (easier to find)

------------------------------------------------------------------------------------------------
ZONE OPTIONS:
------------------------------------------------------------------------------------------------
|cFF33FF99Un'Goro Crater|r - Small Thorium veins
There are 2-3 mineral veins in the two caves marked with red circles on the map
Low level players: skip both cave (depends on your gear/class)
Route: Circle the outer rim of Un'Goro

|cFF33FF99Blasted Lands|r - Mixed Thorium spawns
|cFF33FF99Felwood|r - Rich Thorium density
------------------------------------------------------------------------------------------------














------------------------------------------------------------------------------------------------
Farming Route Maps:
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Un'Goro Crater", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\UnGoroCrater_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\UnGoroCrater_2"
                }},
                {name = "Blasted Lands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\BlastedLands_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\BlastedLands_2"
                }},
                {name = "Felwood", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Felwood_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Felwood_2"
                }}
            }
        },
        {
            title = "Levels: [275-300]",
            description = [[
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Thorium Ore]|r
     Requires |cFF33FFFF[Mining 245]|r
|cFFFFFFFF[Mithril Ore]|r
     Requires |cFF33FFFF[Mining 175]|r
|cFFFFFFFF[Rich Thorium Vein]|r
     Requires |cFF33FFFF[Mining 275]|r

|cFFFFD700Now you can mine Rich Thorium Veins too.|r
Focus on Rich Thorium for faster skill gains

------------------------------------------------------------------------------------------------
ZONE OPTIONS:
------------------------------------------------------------------------------------------------
|cFF33FF99Un'Goro Crater|r - Rich Thorium on outer rim
Almost the same as the previous Un'Goro route, but now it includes Rich Thorium Veins

|cFF33FF99Eastern Plaguelands|r - Excellent Rich Thorium
Route: Full zone circles

|cFF33FF99Winterspring|r - High-level zone
Route: Follow mountain paths

RECOMMENDED: |cFF33FF99Eastern Plaguelands|r for 275-300

VALUABLE ORES:
Arcane Crystals - Rare drop from Rich Thorium
Black Diamonds - Rare drop from Rich Thorium
Azerothian Diamonds - Rare gem drops
------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------
Farming Route Maps:
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Un'Goro Crater", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\UnGoroCraterRich_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\UnGoroCraterRich_2"
                }},
                {name = "Eastern Plaguelands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\EasternPlaguelands_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\EasternPlaguelands_2"
                }},
                {name = "Winterspring", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Winterspring_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Winterspring_2"
                }},
                {name = "Burning Steppes", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\BurningSteppes_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\BurningSteppes_2"
                }}
            }
        }
    }
}