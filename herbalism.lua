Herbalism = {
    buttonText = "Herbalism",
    headerText = "THE HERBALIST",

    sections = {
        {
            title = "Levels: [1-70]  |cFF1EFF00VERIFIED: wow-professions.com Forever guide|r",
            description = [[------------------------------------------------------------------------------------------------
Preface
------------------------------------------------------------------------------------------------
|cFFFFFFFF[Find Herbs]|r is learned with Herbalism but is off by default. Turn it on in the
Professions window and put it on your action bar. You can only track one thing at a
time, so not herbs and minerals together, and tracking turns off when you die.
The routes favor Herbalism speed, so they do not always pick the best herbs for Alchemy.
NOTE: SOURCE: wow-professions.com's Forever guide, which is based on the Forever beta.
The site has not yet tested the higher levels on live.
------------------------------------------------------------------------------------------------
TRAIN: |cFF1EFF00[Apprentice Herbalism]|r (10 Copper)
      |cFFFF0000[H]|r |cFF33FF99[Zor'la]|r / |cFF33FF99[Valley of Trials, Durotar]|r
      |cFFFF0000[H]|r |cFF33FF99[Garan Sunstrider]|r / |cFF33FF99[Camp Narache, Mulgore]|r
      |cFFFF0000[H]|r |cFF33FF99[Florence Nightshade]|r / |cFF33FF99[Deathknell, Tirisfal Glades]|r

      |cFF66B2FF[A]|r |cFF33FF99[Nancy Songflower]|r / |cFF33FF99[Elwynn Forest]|r
      |cFF66B2FF[A]|r |cFF33FF99[Emrys Flintbeard]|r / |cFF33FF99[Dun Morogh]|r
      |cFF66B2FF[A]|r |cFF33FF99[Eleyna Duskbreeze]|r / |cFF33FF99[Aldrassil, Teldrassil]|r
NOTE: These junior trainers only teach up to skill 75.
Zephras Isle (Skyborne): there is no trainer in Thendal Village. Take the quest
|cFFFFD700[! Harvesting Windstones]|r and pick |cFFFFFFFF[Wild Harvest]|r as the reward.
------------------------------------------------------------------------------------------------
TRAIN: |cFF1EFF00[Journeyman Herbalism]|r (Requires Herbalism 50; 5 Silver; Raises Cap [75] > [150])
Learn it from a main trainer, not a junior trainer: see the Trainers section.
------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Peacebloom]|r
|cFFFFFFFF[Silverleaf]|r
|cFFFFFFFF[Earthroot]|r (Herbalism 15)
------------------------------------------------------------------------------------------------
ZONE OPTIONS:
Starting-zone herbs are plentiful and respawn fast: without a mount you can simply run
in circles and pick them as they appear.
|cFFFF0000[H]|r |cFF33FF99Durotar|r
|cFFFF0000[H]|r |cFF33FF99Mulgore|r
|cFFFF0000[H]|r |cFF33FF99Tirisfal Glades|r

|cFF66B2FF[A]|r |cFF33FF99Elwynn Forest|r
|cFF66B2FF[A]|r |cFF33FF99Dun Morogh|r
|cFF66B2FF[A]|r |cFF33FF99Teldrassil|r

|cFFFFD700[N]|r |cFF33FF99Zephras Isle|r
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Peacebloom" },
                { name = "Silverleaf" },
                { name = "Earthroot", level = 15 },
            },
            zones = {
                {name = "Durotar", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Durotar"}},
                {name = "Mulgore", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Mulgore"}},
                {name = "Tirisfal Glades", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\TirisfalGlades"}},
                {name = "Elwynn Forest", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\ElwynnForest"}},
                {name = "Dun Morogh", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\DunMorogh"}},
                {name = "Teldrassil", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Teldrassil"}},
                {name = "Zephras Isle", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\ZephrasIsle"}}
            }
        },
        {
            title = "Levels: [70-115]  |cFF1EFF00VERIFIED: wow-professions.com Forever guide|r",
            description = [[------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Mageroyal]|r
|cFFFFFFFF[Briarthorn]|r
|cFFFFFFFF[Stranglekelp]|r (Herbalism 85)
------------------------------------------------------------------------------------------------
ZONE OPTIONS:
|cFF33FF99Silverpine Forest|r - Respawns in the lower part are fast enough to run small circles
      in the marked area. With a mount, running up and down the main road to the loop
      should also work (the site tested it without a mount only).
|cFF33FF99Loch Modan|r - A very easy route, with perhaps slightly fewer herbs than Darkshore.
|cFF33FF99Darkshore|r - Herbs are everywhere. The loop can be extended to the upper part of the
      map or run as smaller circles in different areas. Easy and relaxed.
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Mageroyal" },
                { name = "Briarthorn" },
                { name = "Stranglekelp", level = 85 },
            },
            zones = {
                {name = "Silverpine Forest", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\SilverpineForest"}},
                {name = "Loch Modan", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\LochModan"}},
                {name = "Darkshore", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Darkshore"}}
            }
        },
        {
            title = "Levels: [115-170]  |cFF1EFF00VERIFIED: wow-professions.com Forever guide|r",
            description = [[------------------------------------------------------------------------------------------------
TRAIN: |cFF1EFF00[Expert Herbalism]|r (Requires Herbalism 125; 50 Silver; Raises Cap [150] > [225])
Trainers: see the Trainers section.
------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Bruiseweed]|r
|cFFFFFFFF[Wild Steelbloom]|r
|cFFFFFFFF[Stranglekelp]|r
|cFFFFFFFF[Kingsblood]|r (Herbalism 125)
|cFFFFFFFF[Liferoot]|r (Herbalism 150)
------------------------------------------------------------------------------------------------
ZONE OPTIONS:
|cFF33FF99Hillsbrad Foothills|r - Running the loop gives the herbs enough time to respawn (the
      site tested it without a mount only).
|cFF33FF99Stonetalon Mountains|r - All three numbered areas are good:
      1. Mobs around level 14-15. The lowest-level area where these herbs are safe to farm.
      2. A good alternative if someone is already farming area 1. Mobs around level 25.
      3. Usually crowded, with many mobs. Only worth it above 125: it has more Kingsblood.
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Bruiseweed" },
                { name = "Wild Steelbloom" },
                { name = "Stranglekelp" },
                { name = "Kingsblood", level = 125 },
                { name = "Liferoot", level = 150 },
            },
            zones = {
                {name = "Hillsbrad Foothills", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\HillsbradFoothills"}},
                {name = "Stonetalon Mountains", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\StonetalonMountains"}}
            }
        },
        {
            title = "Levels: [170-205]  |cFFFF8000UNVERIFIED: wow-professions.com route, not yet tested on live|r",
            description = [[------------------------------------------------------------------------------------------------
NOTE: These are the standard Classic routes. The beta level cap was 30, so the site
could not test them and plans to revise this section after leveling on live.
------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Kingsblood]|r
|cFFFFFFFF[Liferoot]|r
|cFFFFFFFF[Fadeleaf]|r
|cFFFFFFFF[Goldthorn]|r
|cFFFFFFFF[Khadgar's Whisker]|r (Herbalism 185)
------------------------------------------------------------------------------------------------
ZONE OPTIONS:
|cFF33FF99Stranglethorn Vale|r
|cFF33FF99Arathi Highlands|r
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Kingsblood" },
                { name = "Liferoot" },
                { name = "Fadeleaf" },
                { name = "Goldthorn" },
                { name = "Khadgar's Whisker", level = 185 },
            },
            zones = {
                {name = "Stranglethorn Vale", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\StranglethornVale"}},
                {name = "Arathi Highlands", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\ArathiHighlands"}}
            }
        },
        {
            title = "Levels: [205-230]  |cFFFF8000UNVERIFIED: wow-professions.com route, not yet tested on live|r",
            description = [[------------------------------------------------------------------------------------------------
TRAIN: |cFF1EFF00[Artisan Herbalism]|r (Requires Herbalism 200; 5 Gold; Raises Cap [225] > [300])
Learn it before you leave: neither Tanaris nor Searing Gorge has a trainer, and
without it you have to fly back at 225. Trainers: see the Trainers section.
------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Purple Lotus]|r
|cFFFFFFFF[Firebloom]|r
------------------------------------------------------------------------------------------------
ZONE OPTIONS:
|cFF33FF99Tanaris|r
|cFF33FF99Searing Gorge|r
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Purple Lotus" },
                { name = "Firebloom" },
            },
            zones = {
                {name = "Tanaris", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Tanaris"}},
                {name = "Searing Gorge", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\SearingGorge"}}
            }
        },
        {
            title = "Levels: [230-270]  |cFFFF8000UNVERIFIED: wow-professions.com route, not yet tested on live|r",
            description = [[------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Sungrass]|r
|cFFFFFFFF[Purple Lotus]|r
|cFFFFFFFF[Golden Sansam]|r
|cFFFFFFFF[Ghost Mushroom]|r (Herbalism 245)
------------------------------------------------------------------------------------------------
ZONE:
|cFF33FF99The Hinterlands|r - The cave marked with a red X has many Ghost Mushrooms, but you
      need Herbalism 245 to pick them.
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Sungrass" },
                { name = "Purple Lotus" },
                { name = "Golden Sansam" },
                { name = "Ghost Mushroom", level = 245 },
            },
            zones = {
                {name = "The Hinterlands", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\TheHinterlands"}}
            }
        },
        {
            title = "Levels: [270-300]  |cFFFF8000UNVERIFIED: wow-professions.com route, not yet tested on live|r",
            description = [[------------------------------------------------------------------------------------------------
Herb List:
|cFFFFFFFF[Sungrass]|r
|cFFFFFFFF[Gromsblood]|r
|cFFFFFFFF[Golden Sansam]|r
|cFFFFFFFF[Dreamfoil]|r
|cFFFFFFFF[Mountain Silversage]|r
|cFFFFFFFF[Plaguebloom]|r
------------------------------------------------------------------------------------------------
ZONE:
|cFF33FF99Felwood|r
------------------------------------------------------------------------------------------------]],
            materials = {
                { name = "Sungrass" },
                { name = "Gromsblood" },
                { name = "Golden Sansam" },
                { name = "Dreamfoil" },
                { name = "Mountain Silversage" },
                { name = "Plaguebloom" },
            },
            zones = {
                {name = "Felwood", map = {path = "Interface\\AddOns\\TradeGuide\\Maps\\Herbalism\\Felwood"}}
            }
        },
        {
            title = "Trainers  |cFF1EFF00VERIFIED: wow-professions.com Forever guide|r",
            description = [[------------------------------------------------------------------------------------------------
Journeyman, Expert and Artisan trainers:
------------------------------------------------------------------------------------------------
      |cFFFF0000[H]|r |cFF33FF99[Jandi]|r / |cFF33FF99[The Drag, Orgrimmar]|r
      |cFFFF0000[H]|r |cFF33FF99[Komin Winterhoof]|r / |cFF33FF99[Thunder Bluff]|r
      |cFFFF0000[H]|r |cFF33FF99[Martha Alliestar]|r / |cFF33FF99[The Apothecarium, Undercity]|r
      |cFFFF0000[H]|r |cFF33FF99[Mishiki]|r / |cFF33FF99[Sen'jin Village, Durotar]|r
      |cFFFF0000[H]|r |cFF33FF99[Faruza]|r / |cFF33FF99[Brill, Tirisfal Glades]|r
      |cFFFF0000[H]|r |cFF33FF99[Aranae Venomblood]|r / |cFF33FF99[Tarren Mill, Hillsbrad Foothills]|r
      |cFFFF0000[H]|r |cFF33FF99[Angrun]|r / |cFF33FF99[Grom'gol Base Camp, Stranglethorn Vale]|r
      |cFFFF0000[H]|r |cFF33FF99[Ruw]|r / |cFF33FF99[Camp Mojache, Feralas]|r

      |cFF66B2FF[A]|r |cFF33FF99[Tannysa]|r / |cFF33FF99[Mage Quarter, Stormwind City]|r
      |cFF66B2FF[A]|r |cFF33FF99[Shylamiir]|r / |cFF33FF99[The Park, Stormwind City]|r
      |cFF66B2FF[A]|r |cFF33FF99[Reyna Stonebranch]|r / |cFF33FF99[The Great Forge, Ironforge]|r
      |cFF66B2FF[A]|r |cFF33FF99[Firodren Mooncaller]|r / |cFF33FF99[The Temple Gardens, Darnassus]|r
      |cFF66B2FF[A]|r |cFF33FF99[Herbalist Pomeroy]|r / |cFF33FF99[Elwynn Forest]|r
      |cFF66B2FF[A]|r |cFF33FF99[Malorne Bladeleaf]|r / |cFF33FF99[Dolanaar, Teldrassil]|r
      |cFF66B2FF[A]|r |cFF33FF99[Kali Healtouch]|r / |cFF33FF99[Thelsamar, Loch Modan]|r
      |cFF66B2FF[A]|r |cFF33FF99[Alma Jainrose]|r / |cFF33FF99[Lakeshire, Redridge Mountains]|r
      |cFF66B2FF[A]|r |cFF33FF99[Telurinon Moonshadow]|r / |cFF33FF99[Menethil Harbor, Wetlands]|r
      |cFF66B2FF[A]|r |cFF33FF99[Cylania Rootstalker]|r / |cFF33FF99[Silverwind Refuge, Ashenvale]|r
      |cFF66B2FF[A]|r |cFF33FF99[Brant Jasperbloom]|r / |cFF33FF99[Theramore Isle, Dustwallow Marsh]|r

      |cFFFFD700[N]|r |cFF33FF99[Malvor]|r / |cFF33FF99[Nighthaven, Moonglade]|r
      |cFFFFD700[N]|r |cFF33FF99[Flora Silverwind]|r / |cFF33FF99[Booty Bay, Stranglethorn Vale]|r
      |cFFFFD700[N]|r |cFF33FF99[Halassa Fernbreeze]|r / |cFF33FF99[Shen'dar Village, Zephras Isle]|r
      |cFFFFD700[N]|r |cFF33FF99[Syriel Nightrain]|r / |cFF33FF99[Valanaar, Zephras Isle]|r
NOTE: Herbalist Pomeroy is in a cottage in the hills between Stormwind and Northshire.
------------------------------------------------------------------------------------------------
Training costs: Apprentice 10 Copper, Journeyman 5 Silver, Expert 50 Silver,
Artisan 5 Gold. No character level is required for any rank.
------------------------------------------------------------------------------------------------
Skill bonuses:
|cFFFFFFFF[Enchant Gloves - Herbalism]|r +2 and |cFFFFFFFF[Enchant Gloves - Advanced Herbalism]|r +5, from an
      enchanter
|cFFFFFFFF[Herbalist's Gloves]|r +5, a world drop; check the Auction House
|cFFFFFFFF[Goldthorn Tea]|r +15. The recipe is sold by Henry Stern in Razorfen Downs and needs
      Cooking 175: take the left path at the start, go to the stables at the end,
      break the walls and talk to him.
|cFFFF0000[H]|r |cFFFFFFFF[Apothecary Gloves]|r +2, from the quest |cFF1EFF00[Serpentbloom]|r, given by
      |cFF33FF99[Apothecary Zamah]|r in Thunder Bluff; the herbs it requires are picked up in
      Wailing Caverns.
------------------------------------------------------------------------------------------------]]
        },
        {
            title = "Forever Additions  |cFF1EFF00VERIFIED: wow-professions.com Forever guide|r",
            description = [[------------------------------------------------------------------------------------------------
New Herbs:
|cFFFFFFFF[Marefoil]|r, |cFFFFFFFF[Demonsage]|r, |cFFFFFFFF[Death Lotus]|r, |cFFFFFFFF[Frilled Lichen]|r,
|cFFFFFFFF[Rosecap]|r, and |cFFFFFFFF[Stranglevine]|r.

Death Lotus can be found on any herb in Mount Hyjal while wearing the Lotus
Claw glove enchant. Frilled Lichen comes from Earthroot, Mageroyal,
Briarthorn or Stranglekelp; Rosecap from Kingsblood, Fadeleaf or Goldthorn
(the site says probably a few more). Marefoil, Demonsage and Stranglevine's
locations are not yet known.

NOTE: the site states three of these six are "Scarce" materials - a chance
to get one while picking other herbs, rather than being picked directly -
but does not say which three.

Herb Seeds (found while picking herbs; plant in a Greenhouse or combine in
a Seed Hybridizer): Commonplace, Uncommon, Unusual, Scarce.

Camping items for Campfires:
      |cFFFFFFFF[Incense Candle]|r: skill 20, from the trainer
      |cFFFFFFFF[Greenhouse]|r: skill 140, blueprint dropped by |cFF33FF99[Shadetooth]|r /
      |cFF33FF99[Excavation Site, Wetlands]|r
      |cFFFFFFFF[Seed Hybridizer]|r: skill 300, from a Blueprint (drop source not yet known)
------------------------------------------------------------------------------------------------]]
        }
    }
}
