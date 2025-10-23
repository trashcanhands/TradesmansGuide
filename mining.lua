Mining = {
    buttonText = "Mining",
    headerText = "THE MINER",
    
    sections = {
        {
            title = "Levels: [1-65]",
            description = [[
------------------------------------------------------------------------------------------------
Every starter zone is filled with |cFFFFFFFF[Copper Ore]|r, it doesn't really matter which one you choose.

|cFFFFD700IMPORTANT: Night Elf players have to wait until they get to Darkshore before they can|r
|cFFFFD700start leveling mining because Teldrassil doesn't have any Copper Ore.|r

|cFFFFD700Don't forget to buy a Mining Pick from the Mining Supply vendor near your trainer!|r
|cFFFFD700You don't have to equip it, but you have to have one in your inventory.|r
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Copper Ore]|r
     Requires |cFF1EFF00[Mining 1]|r

ZONE OPTIONS:

HORDE ZONES:
|cFF66B2FFDurotar|r - Orc/Troll starting zone
|cFF66B2FFMulgore|r - Tauren starting zone
|cFF66B2FFTirisfal Glades|r - Undead starting zone

ALLIANCE ZONES:
|cFF66B2FFElwynn Forest|r - Human starting zone
|cFF66B2FFDun Morogh|r - Dwarf/Gnome starting zone
|cFF66B2FFDarkshore|r - Night Elf alternative (no copper in Teldrassil!)

NOTE: All |cFF66B2FFStarter Zones|r have similar copper density
Mine every Copper node you see - stockpile for later use

TIPS & BONUSES:
|cFF00FF00[Enchant Gloves - Mining]|r: +5 Mining skill
Copper smelting grants skill points
Check smelting recipes at your trainer!
Always carry extra Mining Picks!
]],
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
            description = [[
------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Journeyman Miner]|r (Requires character level 10, Mining 50; Raises Cap [75] > [150])
WHERE: 
      Any major city Mining trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Tin Ore]|r
     Requires |cFF1EFF00[Mining 65]|r
|cFFFFFFFF[Copper Ore]|r
     Requires |cFF1EFF00[Mining 1]|r
|cFF00FF00[Silver Ore]|r
     Requires |cFF1EFF00[Mining 75]|r (uncommon spawns)

|cFFFFD700At 75 you can learn how to smelt Silver Ore, this will help you get to 125.|r
|cFFFFD700Silver Ore and bars sell for roughly the same - buy the ore and sell the bars|r
|cFFFFD700at the Auction House.|r

ZONE OPTIONS:
|cFF66B2FFHillsbrad Foothills|r - Large zone, many caves
|cFF66B2FFRedridge Mountains|r - Good ore density
|cFF66B2FFAshenvale|r - Compact and efficient
|cFF66B2FFThe Barrens|r - Coastal zone with caves

|cFFFFD700Low level players should skip the two caves marked with red circles.|r

TIP: Save Silver Ore for crafting or selling
TIP: Mine Copper nodes if no Tin available
]],
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
            description = [[
------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Expert Miner]|r (Requires character level 20, Mining 125; Raises Cap [150] > [225])
WHERE: 
      Any major city Mining trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Iron Ore]|r
     Requires |cFF1EFF00[Mining 125]|r
|cFFFFFFFF[Tin Ore]|r
     Requires |cFF1EFF00[Mining 65]|r
|cFF00FF00[Gold Ore]|r
     Requires |cFF1EFF00[Mining 155]|r (uncommon spawns)

|cFFFFD700At 155 you can learn how to smelt Gold Ore. Buy around 30 Gold Ore then smelt them,|r
|cFFFFD700this should get you to around 175. Same as with Silver Ore - buy them, smelt them,|r
|cFFFFD700and sell the bars at the Auction House.|r

ZONE OPTIONS:
|cFF66B2FFArathi Highlands|r - Excellent ore variety

|cFFFFD700There are 4 caves marked with red circles on the map - make sure to go all the way|r
|cFFFFD700to the end of each cave because you won't see all veins from the entrance.|r

|cFFFFD700Low level players should skip all 4 caves!|r
|cFFFF0000Low level Alliance players should take a detour and go south of Hammerfall!|r

|cFF66B2FFDesolace|r - Many caves and cliffs
|cFF66B2FFThousand Needles|r - Desert zone with cliffs

TIP: Save Gold Ore - very valuable
------------------------------------------------------------------------------------------------
]],
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
            description = [[
------------------------------------------------------------------------------------------------
TRAIN:
      |cFF1EFF00[Artisan Miner]|r (Requires character level 35, Mining 220; Raises Cap [225] > [300])
WHERE:
      Any major city Mining trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Mithril Ore]|r
     Requires |cFF1EFF00[Mining 175]|r
|cFF00FF00[Truesilver Ore]|r
     Requires |cFF1EFF00[Mining 230]|r (rare spawns)

ZONE OPTIONS:
|cFF66B2FFHinterlands|r - Excellent Mithril density

|cFFFFD700The red route should be skipped by lower level players because the area is filled|r
|cFFFFD700with level 62 elites. Lower level players might also want to consider skipping the|r
|cFFFFD700cave marked with a red circle on the map. (depends on your gear/class)|r

|cFF66B2FFTanaris|r - Large desert zone

TIP: Truesilver spawns where Mithril spawns
TIP: Check cave systems thoroughly
------------------------------------------------------------------------------------------------
]],
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
            description = [[
------------------------------------------------------------------------------------------------
Ore List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Mithril Ore]|r
     Requires |cFF1EFF00[Mining 175]|r
|cFF00FF00[Truesilver Ore]|r
     Requires |cFF1EFF00[Mining 230]|r (rare spawns)
|cFFFFFFFF[Thorium Ore]|r
     Requires |cFF1EFF00[Mining 245]|r
|cFF9D9D9D[Small Thorium Vein]|r
     Requires |cFF1EFF00[Mining 245]|r (easier to find)

ZONE OPTIONS:
|cFF66B2FFUn'Goro Crater|r - Small Thorium veins

|cFFFFD700There are 2-3 mineral veins in the two caves marked with red circles on the map.|r
|cFFFFD700Lower level players should probably skip the cave to the south.|r
|cFFFFD700It really depends on your level/gear/class.|r

Route: Circle the outer rim of Un'Goro

|cFF66B2FFBlasted Lands|r - Mixed Thorium spawns
|cFF66B2FFFelwood|r - Rich Thorium density
------------------------------------------------------------------------------------------------
]],
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
     Requires |cFF1EFF00[Mining 245]|r
|cFFFFFFFF[Mithril Ore]|r
     Requires |cFF1EFF00[Mining 175]|r
|cFFFFFFFF[Rich Thorium Vein]|r
     Requires |cFF1EFF00[Mining 275]|r

|cFFFFD700Now you can mine Rich Thorium Veins too.|r
Focus on Rich Thorium for faster skill gains

BEST ZONES:
|cFF66B2FFUn'Goro Crater|r - Rich Thorium on outer rim

|cFFFFD700Almost the same as the previous Un'Goro route, but now it includes Rich Thorium Veins.|r

|cFF66B2FFEastern Plaguelands|r - Excellent Rich Thorium
Route: Full zone circles

|cFF66B2FFWinterspring|r - High-level zone
Route: Follow mountain paths

RECOMMENDED: Eastern Plaguelands for 275-300

VALUABLE ORES:
Arcane Crystals - Rare drop from Rich Thorium
Black Diamonds - Rare drop from Rich Thorium
Azerothian Diamonds - Rare gem drops
------------------------------------------------------------------------------------------------
]],
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