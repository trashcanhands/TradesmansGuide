# Tradesman's Guide

## [v1.3.0](https://github.com/trashcanhands/TradesmansGuide/tree/v1.3.0) (2026-11-13)
[Full Changelog](https://github.com/trashcanhands/TradesmansGuide/compare/v1.2.0...v1.3.0) [Previous Releases](https://github.com/trashcanhands/TradesmansGuide/releases)

- Sync 9 Forever profession files with post-launch site changes  
    Full two-direction sync for cooking, enchanting, engineering, firstaid,  
    fishing, leatherworking, tailoring, fishingcooking, and camping (last  
    checked 2026-10-29, before Forever's 2026-11-04 launch). Plus a trainer  
    roster recount for alchemy and blacksmithing, already synced today.  
    Forward (site changed):  
    - leatherworking.lua and tailoring.lua: large route rewrites from skill  
      ~130 up, mirroring blacksmithing's earlier below-225 change. Two-route  
      forks collapsed into single routes; Expert/Artisan boundaries shifted;  
      specialization requirement bumped to skill 225/level 40 (leatherworking).  
      Tailoring's old 225-300 Runecloth Bag/Belt/Gloves content replaced with  
      the site's new 200-300 Artisan steps and two unconfirmed world-drop  
      candidates past skill 265.  
    - cooking.lua: Artisan 225-275/275-300 split merged into one 225-300 tier  
      with the site's current recipe set; 150-175 and 175-225 quantities  
      raised; new Goblin Deviled Clams option; campfire-learning note fixed.  
    - enchanting.lua: 165-200 route flipped (Soul Dust path is now default);  
      225-250 tier simplified to a single recipe; Soul/Vision Dust totals  
      recomputed.  
    - engineering.lua: 175-194 beta workaround (split Solid Blasting Powder +  
      mandatory Iron Grenade) replaced with the site's direct 60x step;  
      Heavy Stone/Iron Bar/Silk Cloth header entries corrected.  
    - firstaid.lua: Artisan 225-240 Superior Healing Potion replaced with  
      Mageweave Bandage (recipe no longer on the site); 210-225 quantity  
      raised; Major Healing Potion vendor added; VanHowzen location fixed.  
    - blacksmithing.lua, alchemy.lua: trainer rosters recounted, one missing  
      Apprentice trainer added to blacksmithing, plus its previously-missing  
      Armorsmithing/Weaponsmithing specialization block.  
    - camping.lua: Journeyman Campfire Kit Use requirement and bug note  
      corrected; stale beta-disclaimer preface line dropped.  
    Reverse (unsourced leftovers removed):  
    - leatherworking.lua: Barbaric Leggings, Wicked Leather Bracers, and  
      several Artisan-tier alternative recipes with no current site  
      counterpart.  
    - tailoring.lua: Runecloth Bag pattern/craft, the Mageweave-scarcity and  
      100-120 shortcut alternatives, and both farming-route blocks (the site  
      no longer describes farming for this profession).  
    - fishingcooking.lua: Spotted Yellowtail recipe (not sold by Gikkix  
      anymore); Alterac Swiss guidance flipped from "skip" to "buy" to match  
      the Artisan Cooking quest, which already assumed it was bought.  
    - cooking.lua: "all 3 recipes" corrected to "both recipes" for Gikkix.  
    Material List headers recomputed from the new routes for all affected  
    files, cross-checked against wow-professions.com's own shopping-list  
    totals where available. All files validated: CRLF intact, Lua syntax  
    clean, no lines over 96 visible characters, no comments.  
    Co-Authored-By: Claude Sonnet 5 <noreply@anthropic.com>  
    Claude-Session: https://claude.ai/code/session\_01VmciZ1ZNkfgGM24wLypvKZ  
- Sync alchemy and blacksmithing routes with the post-launch site  
    Forward (site changed):  
    - alchemy.lua: 225-300 rewritten to the site's new route (26 Nature  
      Protection Potion to 235, 36 Elixir of Greater Intellect to 265, 47 Elixir  
      of Greater Defense to 300, Superior Mana Potion as the alternative).  
      Material list recomputed.  
    - blacksmithing.lua: main route updated throughout (5 Runed Copper Gauntlets,  
      18 Runed Copper Belt at 80-95, 30 Green Iron Bracers, Solid Grinding Stone  
      at 175, 20 Golden Scale Bracers, 17 Mithril Plate Pants, Heavy Mithril Axe  
      at 210) and 225-300 replaced with the site's Forever route (Dense  
      Sharpening Stone, Heavy Mithril Boots, the four Imperial Plate quest plans).  
      Material list recomputed and matches the site's shopping lists.  
    Reverse (unsourced leftovers removed):  
    - alchemy.lua: Draught of Detect Undead, Elixir of Shadow Power and Major  
      Frenzy Potion steps, which the site no longer lists.  
    - blacksmithing.lua: the Vanilla-data 225-300 blocks, the Steel Breastplate /  
      Steel Plate Helm alternative, and Rough Bronze Leggings.  
    Steps above 225 stay marked unverified: the site has not tested them on live.  
    Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>  
    Claude-Session: https://claude.ai/code/session\_0157DtUrRt1gThyvkdgcAmv6  
- Update TradeGuide.lua  
    Unify addon name, references and slash commands to match actual addon name of Tradesman's Guide.  
- Use the custom addon icon for the window portrait and minimap button  
    Co-Authored-By: Claude Fable 5.2 <noreply@anthropic.com>  
    Claude-Session: https://claude.ai/code/session\_0157DtUrRt1gThyvkdgcAmv6  
