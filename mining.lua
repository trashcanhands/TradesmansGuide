Mining = {
    buttonText = "Mining",
    headerText = "THE MINER",
    
    sections = {
        {
            title = "|cFFFF8000PARTLY VERIFIED: bracket matches Wowhead, details unconfirmed|r",
            description = [[------------------------------------------------------------------------------------------------
Preface
------------------------------------------------------------------------------------------------
Don't forget to buy a |cFFFFFFFFMining Pick|r from the Mining Supply vendor near your trainer. No need to equip, just have one in your bags.
|cFF00FF00[Enchant Gloves - Mining]|r: +2 Mining skill, |cFF00FF00[Enchant Gloves - Advanced Mining]|r: +5
Smelt Copper x130 (1-65). Keep 60 Copper Bars for Bronze
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
            title = "Levels: [65-125]  |cFFFF8000PARTLY VERIFIED: bracket matches Wowhead, details unconfirmed|r",
            description = [[------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Journeyman Miner]|r (Requires Mining 50; Raises Cap [75] > [150])
      NOTE: No character level is required for this rank on gathering
      professions (per icy-veins.com's Forever professions overview).
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

Smelt: Tin x60 (65-75), Bronze x60 (75-100), Silver x70 (100-125)
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
            title = "Levels: [125-175]  |cFFFF8000PARTLY VERIFIED: bracket matches Wowhead, details unconfirmed|r",
            description = [[------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Expert Miner]|r (Requires character level 10, Mining 125; Raises Cap [150] > [225])
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

Smelt: Iron x35 (125-140), none 140-155, Gold x60 (155-185)
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
            title = "Levels: [175-245]  |cFFFF8000PARTLY VERIFIED: bracket matches Wowhead, details unconfirmed|r",
            description = [[------------------------------------------------------------------------------------------------
TRAIN:
      |cFF1EFF00[Artisan Miner]|r (Requires character level 25, Mining 200; Raises Cap [225] > [300])
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
            title = "Levels: [245-275]  |cFFFF8000UNVERIFIED: Vanilla WoW data, not checked for Forever|r",
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
            title = "Levels: [275-300]  |cFFFF8000UNVERIFIED: Vanilla WoW data, not checked for Forever|r",
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
        },
        {
            title = "Forever Additions  |cFF1EFF00VERIFIED: Wowhead Forever guide|r",
            description = [[------------------------------------------------------------------------------------------------
Mining Boosting Equipment and Enchants
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Miner's Cape]|r: +2 effective skill
|cFFFFFFFF[Goblin Mining Helmet]|r: +5 effective skill
|cFF00FF00[Enchant Gloves - Mining]|r: +2 effective skill
|cFF00FF00[Enchant Gloves - Advanced Mining]|r: +5 effective skill
------------------------------------------------------------------------------------------------
Other Mining Equipment
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Smelting Pants]|r: -25% crafting time for Smelt Copper, Tin,
      Bronze and Silver
|cFFFFFFFF[Rockslicer]|r: lets non-Miners mine Copper, Tin, Silver and Iron
      Veins; drops with 30 charges
------------------------------------------------------------------------------------------------
Where to Find Ore Veins (skill breakpoints)
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Copper Vein]|r: 25/50/100 - Rough Stone, Malachite, Tigerseye,
      Shadowgem (20+ zones, from starter areas to Zephras Isle)
|cFFFFFFFF[Tin Vein]|r: 65/90/115/165 - Coarse Stone, Moss Agate,
      Shadowgem, Jade, Lesser Moonstone
|cFFFFFFFF[Silver Vein]|r: 75/100/125/175 - Moss Agate, Shadowgem,
      Lesser Moonstone
|cFFFFFFFF[Iron Deposit]|r: 125/150/175/225 - Heavy Stone, Jade,
      Lesser Moonstone, Citrine, Aquamarine
|cFFFFFFFF[Gold Vein]|r: 155/180/205/255 - Jade, Lesser Moonstone, Citrine
|cFFFFFFFF[Mithril Deposit]|r (incl. Ooze Covered): 175/200/225/275 -
      Solid Stone, Citrine, Aquamarine, Star Ruby, Black Vitriol
|cFFFFFFFF[Truesilver Deposit]|r (incl. Ooze Covered): 230/255/280/330 -
      Citrine, Aquamarine, Star Ruby
|cFFFFFFFF[Dark Iron Deposit]|r: 230/255/280/330 - Black Vitriol, Blood of
      the Mountain, Black Diamond
|cFFFFFFFF[Small Thorium Vein]|r (incl. Ooze Covered): 245/270/295/345 -
      Dense Stone, Star Ruby, Black Vitriol, Blue Sapphire, Large Opal,
      Azerothian Diamond
|cFFFFFFFF[Rich Thorium Vein]|r (incl. Ooze Covered): 275/300/325/375 -
      Dense Stone, Star Ruby, Blue Sapphire, Large Opal, Arcane Crystal,
      Huge Emerald, Azerothian Diamond
------------------------------------------------------------------------------------------------
Smelting Bars (skill-up thresholds)
------------------------------------------------------------------------------------------------
|cFF1EFF00[Smelt Copper]|r: 1/25/47/70 - 1 Copper Ore -> 1 Copper Bar
|cFF1EFF00[Smelt Tin]|r: 65/75 - 1 Tin Ore -> 1 Tin Bar
|cFF1EFF00[Smelt Bronze]|r: 65/90/115 - 1 Copper Bar + 1 Tin Bar -> 2 Bronze Bar
|cFF1EFF00[Smelt Silver]|r: 75/100/112/125 - 1 Silver Ore -> 1 Silver Bar
|cFF1EFF00[Smelt Iron]|r: 125/130/135/140 - 1 Iron Ore -> 1 Iron Bar
|cFF1EFF00[Smelt Gold]|r: 155/170/177/185 - 1 Gold Ore -> 1 Gold Bar
|cFF1EFF00[Smelt Steel]|r: 165 - 1 Iron Bar + 1 Coal -> 1 Steel Bar
|cFF1EFF00[Smelt Mithril]|r: 175 - 1 Mithril Ore -> 1 Mithril Bar
|cFF1EFF00[Smelt Truesilver]|r: 230 - 1 Truesilver Ore -> 1 Truesilver Bar
|cFF1EFF00[Smelt Dark Iron]|r: 230 - 8 Dark Iron Ore -> 1 Dark Iron Bar
|cFF1EFF00[Smelt Thorium]|r: 250 - 1 Thorium Ore -> 1 Thorium Bar
NOTE: These are Wowhead's Forever thresholds; may differ from the
      Vanilla smelting route earlier in this guide.
------------------------------------------------------------------------------------------------
New Ores and Bars
------------------------------------------------------------------------------------------------
New endgame bars: |cFFFFFFFF[Legionite Bar]|r, |cFFFFFFFF[Heavy Thorium Bar]|r,
      |cFFFFFFFF[Azerothium Bar]|r
Legionite Bar currently comes only from Alchemists transmuting Heavy
      Thorium Bars.
New ore: |cFFFFFFFF[Heavy Thorium Ore]|r - locations/requirements unknown.
Bonus drops while mining: |cFFFFFFFF[Pyrite]|r, |cFFFFFFFF[Bauxite]|r,
      |cFFFFFFFF[Pitchblende]|r - odds and Scarce material ties unknown.
------------------------------------------------------------------------------------------------
New Mining Recipes
------------------------------------------------------------------------------------------------
|cFF1EFF00[Lodestone]|r: skill 20, trainer
|cFF1EFF00[Rock Garden]|r: skill 140, drops from Relic Guardian
      (Excavation Site: Wetlands)
|cFF1EFF00[Smelt Azerothium]|r: skill 275, trainer
|cFF1EFF00[Smelt Heavy Thorium]|r: skill 300, trainer
|cFF1EFF00[Molten Foundry]|r: skill 300, from Blueprint: Molten Foundry
------------------------------------------------------------------------------------------------
Mining Legacy Perks
------------------------------------------------------------------------------------------------
|cFF1EFF00[Bountiful Harvest]|r (5 ranks): +20% Scarce materials from
      Mining, Herbalism and Skinning
|cFF1EFF00[Performance Bonus]|r (5 ranks): 5% chance for 100% extra
      Merchant's Favor on supply crate turn-in
|cFF1EFF00[Working Overtime]|r (5 ranks): +4% chance to gain a skill
      point from primary, secondary and class tradeskills
|cFF1EFF00[Dedicated Study]|r (1 rank): Raises your lowest primary or
      secondary tradeskill by 1 (25s cast, 23hr cooldown)
------------------------------------------------------------------------------------------------]]
        }
    }
}