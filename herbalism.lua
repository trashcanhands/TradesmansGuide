Herbalism = {
    buttonText = "Herbalism",
    headerText = "THE HERBALIST",
    
    sections = {
        {
            title = "Levels: [1-70]",
            description = [[
------------------------------------------------------------------------------------------------
Every starter zone is filled with herbs. It doesn't really matter which one you choose.
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Peacebloom]|r
     Requires |cFF1EFF00[Herbalism 1]|r
|cFFFFFFFF[Silverleaf]|r
     Requires |cFF1EFF00[Herbalism 1]|r
|cFFFFFFFF[Earthroot]|r
     Requires |cFF1EFF00[Herbalism 15]|r

ZONE OPTIONS:
All |cFF66B2FFStarter Zones|r have similar herb density.
------------------------------------------------------------------------------------------------
]],
            zones = {
                {name = "Durotar", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Durotar_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Durotar_2"
                }},
                {name = "Mulgore", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Mulgore_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Mulgore_2"
                }},
                {name = "Tirisfal Glades", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Tirisfal_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Tirisfal_2"
                }},
                {name = "Elwynn Forest", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Elwynn_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Elwynn_2"
                }},
                {name = "Teldrassil", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Teldrassil_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Teldrassil_2"
                }},
                {name = "Dun Morogh", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\DunMorogh_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\DunMorogh_2"
                }}
            }
        },
        {
            title = "Levels: [70-115]",
            description = [[
------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Journeyman Herbalist]|r (Requires character level 10; Raises Cap [75] > [150])
WHERE: 
      Any major city Herbalism trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Mageroyal]|r
     Requires |cFF1EFF00[Herbalism 50]|r
|cFFFFFFFF[Briarthorn]|r
     Requires |cFF1EFF00[Herbalism 70]|r
|cFFFFFFFF[Stranglekelp]|r (underwater)
     Requires |cFF1EFF00[Herbalism 85]|r

|cFFFFD700Stranglekelp requires herbalism 85, so you can't pick them right away.|r

ZONE OPTIONS:
|cFF66B2FFThe Barrens|r - Large zone, abundant herbs
|cFF66B2FFSilverpine Forest|r - Good herb density
|cFF66B2FFLoch Modan|r - Compact and efficient
|cFF66B2FFDarkshore|r - Coastal zone with Stranglekelp
------------------------------------------------------------------------------------------------
]],
            zones = {
                {name = "The Barrens", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\TheBarrens_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\TheBarrens_2"
                }},
                {name = "Silverpine Forest", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Silverpine_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Silverpine_2"
                }},
                {name = "Loch Modan", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\LochModan_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\LochModan_2"
                }},
                {name = "Darkshore", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Darkshore_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Darkshore_2"
                }}
            }
        },
        {
            title = "Levels: [115-170]",
            description = [[
------------------------------------------------------------------------------------------------
TRAIN: 
      |cFF1EFF00[Expert Herbalist]|r (Requires character level 20; Raises Cap [150] > [225])
WHERE: 
      Any major city Herbalism trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Bruiseweed]|r
     Requires |cFF1EFF00[Herbalism 100]|r
|cFFFFFFFF[Wild Steelbloom]|r
     Requires |cFF1EFF00[Herbalism 115]|r
|cFFFFFFFF[Stranglekelp]|r (underwater)
     Requires |cFF1EFF00[Herbalism 85]|r
|cFFFFFFFF[Kingsblood]|r
     Requires |cFF1EFF00[Herbalism 125]|r
|cFFFFFFFF[Liferoot]|r
     Requires |cFF1EFF00[Herbalism 150]|r

|cFFFFD700Kingsblood requires herbalism 125, and Liferoot requires herbalism 150.|r
|cFFFFD700You should only gather these after you pass those skill levels.|r

ZONE OPTIONS:
|cFF66B2FFHillsbrad Foothills|r - Excellent variety (WARNING: Heavy PvP zone for Alliance)
|cFF66B2FFWetlands|r - Swampy terrain with Liferoot
|cFF66B2FFStonetalon Mountains|r - Good Wild Steelbloom
------------------------------------------------------------------------------------------------
]],
            zones = {
                {name = "Hillsbrad Foothills", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Hillsbrad_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Hillsbrad_2"
                }},
                {name = "Wetlands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Wetlands_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Wetlands_2"
                }},
                {name = "Stonetalon Mountains", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Stonetalon_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Stonetalon_2"
                }}
            }
        },
        
        {
            title = "Levels: [170-205]",
            description = [[
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Kingsblood]|r
     Requires |cFF1EFF00[Herbalism 125]|r
|cFFFFFFFF[Liferoot]|r
     Requires |cFF1EFF00[Herbalism 150]|r
|cFFFFFFFF[Fadeleaf]|r
     Requires |cFF1EFF00[Herbalism 160]|r
|cFFFFFFFF[Goldthorn]|r
     Requires |cFF1EFF00[Herbalism 170]|r
|cFFFFFFFF[Khadgar's Whisker]|r
     Requires |cFF1EFF00[Herbalism 185]|r

|cFFFFD700Khadgar's Whisker requires herbalism 185, so you can't pick them right away.|r

ZONE OPTIONS:
|cFF66B2FFStranglethorn Vale|r - Dense jungle, many spawns (WARNING: Heavy PvP activity)
|cFF66B2FFArathi Highlands|r - Safer alternative
------------------------------------------------------------------------------------------------
]],           
            zones = {
                {name = "Stranglethorn Vale", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Stranglethorn_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Stranglethorn_2"
                }},
                {name = "Arathi Highlands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Arathi_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Arathi_2"
                }}
            }
        },
        {
            title = "Levels: [205-230]",
            description = [[
------------------------------------------------------------------------------------------------
TRAIN:
      |cFF1EFF00[Artisan Herbalist]|r (Requires character level 35; Raises Cap [225] > [300])
WHERE:
      Any major city Herbalism trainer
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Purple Lotus]|r
     Requires |cFF1EFF00[Herbalism 210]|r
|cFFFFFFFF[Firebloom]|r
     Requires |cFF1EFF00[Herbalism 205]|r

ZONE OPTIONS:
|cFF66B2FFTanaris|r - Large desert zone with Firebloom
|cFF66B2FFSearing Gorge|r - More compact farming
------------------------------------------------------------------------------------------------
]],
            zones = {
                {name = "Tanaris", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Tanaris_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Tanaris_2"
                }},
                {name = "Searing Gorge", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\SearingGorge_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\SearingGorge_2"
                }}
            }
        },
        {
            title = "Levels: [230-270]",
            description = [[
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Sungrass]|r
     Requires |cFF1EFF00[Herbalism 230]|r
|cFFFFFFFF[Purple Lotus]|r
     Requires |cFF1EFF00[Herbalism 210]|r
|cFFFFFFFF[Ghost Mushroom]|r
     Requires |cFF1EFF00[Herbalism 245]|r
|cFFFFFFFF[Golden Sansam]|r
     Requires |cFF1EFF00[Herbalism 260]|r

|cFFFFD700There is a cave marked with red X - it has many Ghost Mushrooms inside.|r
|cFFFFD700You can only pick them with herbalism skill 245.|r

ZONE:
|cFF66B2FFHinterlands|r - Good high-level herb spawns
Route: Follow paths through the zone
------------------------------------------------------------------------------------------------
]],
            zones = {
                {name = "Hinterlands", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Hinterlands_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Hinterlands_2"
                }}
            }
        },
        {
            title = "Levels: [270-300]",
            description = [[
------------------------------------------------------------------------------------------------
Herb List:
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Sungrass]|r
     Requires |cFF1EFF00[Herbalism 230]|r
|cFFFFFFFF[Gromsblood]|r
     Requires |cFF1EFF00[Herbalism 250]|r
|cFFFFFFFF[Golden Sansam]|r
     Requires |cFF1EFF00[Herbalism 260]|r
|cFFFFFFFF[Dreamfoil]|r
     Requires |cFF1EFF00[Herbalism 270]|r
|cFFFFFFFF[Mountain Silversage]|r
     Requires |cFF1EFF00[Herbalism 280]|r
|cFFFFFFFF[Plaguebloom]|r
     Requires |cFF1EFF00[Herbalism 285]|r

BEST ZONE:
|cFF66B2FFFelwood|r - Best zone for final levels
All end-game herbs spawn here
Route: Zigzag through zone, full circles

RECOMMENDED: Stay in Felwood from 270-300
------------------------------------------------------------------------------------------------
]],
            zones = {
                {name = "Felwood", map = {
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Felwood_1",
                    "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Felwood_2"
                }}
            }
        }
    }
}