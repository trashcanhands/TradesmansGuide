# Tradesman's Guide

An in-game leveling guide for every profession. Pick a trade and get the materials you need, exactly what to craft at each skill range, where to train, and (for Herbalism, Mining and Skinning) farming route maps for each zone.

Built for **WoW: Forever**.

![Main window](docs/images/main-window.png)

## Features

- **Nine profession guides:** Alchemy, Blacksmithing, Cooking, Enchanting, Engineering, First Aid, Fishing, Leatherworking and Tailoring.
- **Fishing+Cooking guide:** wow-professions.com's combined route for leveling both at once, alongside the standalone Fishing and Cooking pages.
- **Camping guide:** the shared campfire/camp-item system, covering every profession's camp items and crafting stations in one reference page.
- **Full material lists** up front, so you know what to gather or buy before you start.
- **Step-by-step skill ranges** showing what to craft and the materials each range needs.
- **Trainer locations**, marked by faction: `[H]` Horde, `[A]` Alliance, `[N]` Neutral.
- **Gathering guides** for Herbalism, Mining and Skinning, split into sections by skill level. (Herbalism and Mining currently sit on the Classic tab, pending confirmation of Forever's node placements - see Notes.)
- **Farming route maps** for 19 Herbalism zones, 22 Mining zones and 9 Skinning zones, switchable with one click.

![Gathering view](docs/images/gathering-view.png)

Example of a farming route map (Herbalism, Durotar):

![Herbalism route map example](docs/images/herbalism-map-example.png)

## Installation

1. Download this repository (**Code > Download ZIP**) or clone it.
2. Make sure the folder is named exactly `TradeGuide`. Not `TradesmansGuide`, and not a folder nested inside another folder. The map images load from `Interface\AddOns\TradeGuide\Maps`, so the name matters.
3. Put the `TradeGuide` folder in your AddOns directory. For the Forever beta that is:

```
World of Warcraft/_classic_beta_/Interface/AddOns/TradeGuide
```

4. Start the game (or `/reload`) and make sure **Tradesman's Guide** is enabled on the AddOns screen.

The finished layout should look like this:

```
AddOns/
  TradeGuide/
    TradeGuide.toc
    TradeGuide.lua
    alchemy.lua
    blacksmithing.lua
    camping.lua
    cooking.lua
    enchanting.lua
    engineering.lua
    firstaid.lua
    fishing.lua
    fishingcooking.lua
    herbalism.lua
    leatherworking.lua
    mining.lua
    skinning.lua
    tailoring.lua
    Maps/
      Herbalism/
      Mining/
      Skinning/
```

## Usage

Open the guide with either slash command:

```
/pg
/profguide
```

You can also click the minimap button. Left-click toggles the window, and right-click and drag moves the button.

![Minimap button](docs/images/minimap-button.png)

- Use the two tabs at the top left to switch between **Forever Updated** guides (verified or sourced specifically for Forever) and **Classic (Pending)** guides that are carried over from Classic and not yet confirmed for Forever. Each tab has its own Gathering and Crafting buttons.
- Use the buttons on the left to pick a profession. Crafting guides are a scrollable list; use the mouse wheel or the scroll bar. **Camping** sits at the bottom of the Crafting list on the Forever Updated tab, set off by a divider since it's a cross-profession reference page rather than a profession of its own.
- In **Herbalism**, **Mining** and **Skinning**, use **Previous** and **Next** to move between skill-level sections, and the zone buttons to change the route map.
- Drag the window by its body to move it.

The window and minimap button positions are not saved between sessions.

## Notes

- Requires a WoW: Forever client (Interface `16001`, the beta value). The interface number may need to change when Forever releases.
- **wow-professions.com is this guide's primary source of truth.** Until the official wiki covers Forever, every crafting page (Alchemy, Blacksmithing, Camping, Cooking, Enchanting, Engineering, First Aid, Fishing, Fishing+Cooking, Leatherworking, Tailoring) is built from wow-professions.com's Forever leveling guides. Every section is stamped in-game: **VERIFIED** means the content matches wow-professions.com's Forever guide. **UNVERIFIED** means wow-professions.com itself calls that range untested in the Forever beta, and the route shown is a Classic-era carryover until it's confirmed.
- **Herbalism and Mining** have no Forever guide on wow-professions.com yet, so those two pages use wow-professions.com's Classic guide instead, stamped **SOURCE: wow-professions.com (Classic guide)**. Gathering node placements appear to have changed in Forever versus Classic, so the bundled farming route maps for these two professions aren't confirmed accurate yet - new maps will need to be built from scratch once the actual Forever node layout is known. Until then, both pages live on the **Classic (Pending)** tab.
- **Skinning** has no guide of any kind on wow-professions.com, but its route and farming maps come from Wowhead's dedicated **WoW: Forever** Skinning guide (wowhead.com/forever) rather than a Classic one - that source already reflects Forever's node layout, so despite not being wow-professions.com-sourced, Skinning stays on the **Forever Updated** tab, stamped **VERIFIED: Wowhead Forever guide**.
- This guide was originally written for Turtle WoW. Recipe, vendor and zone details may differ on Forever, so double-check anything that looks off.
- The original Turtle WoW (1.12) version is preserved in the git history at commit `7edd6c0`. It uses a different API and will not load on Forever.

## Author

trashcanhands
