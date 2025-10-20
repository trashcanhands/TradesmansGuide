Mining = {
    buttonText = "Mining",
    headerText = "THE MINER",
    
    sections = {
        {
            title = "LEVELS: 1 - 65",
            description = [[
ORES TO MINE:
|cFFFFFFFF[Copper Ore]|r - Skill 1
Found in low-level zones everywhere

ZONE OPTIONS:

HORDE ZONES:
|cFF66B2FFDurotar|r - Orc/Troll starting zone
|cFF66B2FFMulgore|r - Tauren starting zone
|cFF66B2FFTirisfal Glades|r - Undead starting zone

ALLIANCE ZONES:
|cFF66B2FFElwynn Forest|r - Human starting zone
|cFF66B2FFDun Morogh|r - Dwarf/Gnome starting zone
|cFF66B2FFTeldrassil|r - Night Elf starting zone

NOTE: All |cFF66B2FFStarter Zones|r have similar copper density
Mine every Copper node you see - stockpile for later use

TIPS & BONUSES:
|cFF00FF00[Enchant Gloves - Mining]|r: +5 Mining skill
Copper/Tin/Iron/Mithril smelting grants skill points
Check smelting recipes at your trainer!
Always carry extra Mining Picks!

------------------------------------------------------------------------------------------------
TRAIN: |cFFFFFFFF[Journeyman Miner]|r (Raise Cap 75>150; Requires character level 10)
WHERE: Any major city Mining trainer
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Durotar", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Durotar.blp"},
                {name = "Mulgore", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Mulgore.blp"},
                {name = "Tirisfal Glades", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Tirisfal.blp"},
                {name = "Elwynn Forest", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Elwynn.blp"},
                {name = "Darkshore", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Darkshore.blp"},
                {name = "Dun Morogh", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\DunMorogh.blp"}
            }
        },
        {
            title = "LEVELS: 65 - 125",
            description = [[
ORES TO MINE:
|cFFFFFFFF[Tin Ore]|r - Skill 65
|cFF00FF00[Silver Ore]|r - Skill 75 (uncommon spawns)
Found in mid-level zones

ZONE OPTIONS:
|cFF66B2FFHillsbrad Foothills|r - Large zone, many caves
|cFF66B2FFRedridge Mountains|r - Good ore density
|cFF66B2FFAshenvale|r - Compact and efficient
|cFF66B2FFThe Barrens|r - Coastal zone with caves

TIP: Save Silver Ore for crafting or selling
TIP: Mine Copper nodes if no Tin available

------------------------------------------------------------------------------------------------
TRAIN: |cFFFFFFFF[Expert Miner]|r (Raise Cap 150>225; Requires character level 20)
WHERE: Any major city Mining trainer
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Hillsbrad Foothills", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Hillsbrad.blp"},
                {name = "Redridge Mountains", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Redridge.blp"},
                {name = "Ashenvale", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Ashenvale.blp"},
                {name = "The Barrens", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\TheBarrens.blp"}
            }
        },
        {
            title = "LEVELS: 125 - 175",
            description = [[
ORES TO MINE:
|cFFFFFFFF[Iron Ore]|r - Skill 125
|cFF00FF00[Gold Ore]|r - Skill 155 (uncommon spawns)
Found in mid-to-high level zones

ZONE OPTIONS:
|cFF66B2FFArathi Highlands|r - Excellent ore variety (WARNING: Heavy PvP zone for Alliance)
|cFF66B2FFDesolace|r - Many caves and cliffs
|cFF66B2FFThousand Needles|r - Desert zone with cliffs

TIP: Save Gold Ore - very valuable]],
            zones = {
                {name = "Arathi Highlands", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Arathi.blp"},
                {name = "Desolace", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Desolace.blp"},
                {name = "Thousand Needles", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\ThousandNeedles.blp"}
            }
        },
        {
            title = "LEVELS: 175 - 245",
            description = [[
ORES TO MINE:
|cFFFFFFFF[Mithril Ore]|r - Skill 175
|cFF00FF00[Truesilver Ore]|r - Skill 230 (rare spawns)
Found in high-level zones

ZONE OPTIONS:
|cFF66B2FFHinterlands|r - Excellent Mithril density
|cFF66B2FFTanaris|r - Large desert zone

TIP: Truesilver spawns where Mithril spawns
TIP: Check cave systems thoroughly

------------------------------------------------------------------------------------------------
TRAIN: |cFFFFFFFF[Artisan Miner]|r (Raise Cap 225>300; Requires character level 35)
WHERE: Any major city Mining trainer
------------------------------------------------------------------------------------------------]],
            zones = {
                {name = "Hinterlands", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Hinterlands.blp"},
                {name = "Tanaris", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Tanaris.blp"}
            }
        },
        {
            title = "LEVELS: 245 - 275",
            description = [[
ORES TO MINE:
|cFFFFFFFF[Thorium Ore]|r - Skill 245
|cFF9D9D9D[Small Thorium Vein]|r - Easier to find
|cFFFFFFFF[Rich Thorium Vein]|r - Better yields

ZONE OPTIONS:
|cFF66B2FFUn'Goro Crater|r - Small Thorium veins
|cFF66B2FFBlasted Lands|r - Mixed Thorium spawns
|cFF66B2FFFelwood|r - Rich Thorium density

Route: Circle the outer rim of Un'Goro]],
            zones = {
                {name = "Un'Goro Crater", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\UnGoroCrater.blp"},
                {name = "Blasted Lands", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\BlastedLands.blp"},
                {name = "Felwood", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Felwood.blp"}
            }
        },
        {
            title = "LEVELS: 275 - 300",
            description = [[
ORES TO MINE:
|cFFFFFFFF[Rich Thorium Vein]|r - Skill 275
Focus on Rich Thorium for faster skill gains

BEST ZONES:
|cFF66B2FFEastern Plaguelands|r - Excellent Rich Thorium
Route: Full zone circles

|cFF66B2FFWinterspring|r - High-level zone
Route: Follow mountain paths

|cFF66B2FFUn'Goro Crater|r - Rich Thorium on outer rim

RECOMMENDED: Eastern Plaguelands for 275-300

VALUABLE ORES:
Arcane Crystals - Rare drop from Rich Thorium
Black Diamonds - Rare drop from Rich Thorium
Azerothian Diamonds - Rare gem drops
]],
            zones = {
                {name = "Un'Goro Crater", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\UnGoroCraterRich.blp"},
                {name = "Eastern Plaguelands", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\EasternPlaguelands.blp"},
                {name = "Winterspring", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\Winterspring.blp"},
                {name = "Burning Steppes", map = "Interface\\AddOns\\TradeGuide\\Maps\\Mining\\BurningSteppes.blp"}
            }
        }
    }
}