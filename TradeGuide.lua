local guideFrame = CreateFrame("Frame", "GuideFrame", UIParent, "BackdropTemplate")
guideFrame:SetWidth(750)
guideFrame:SetHeight(800)
guideFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, 0)
guideFrame:SetBackdrop({
    bgFile = "Interface\\BUTTONS\\WHITE8X8",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border",
    tile = false, 
    tileSize = 16, 
    edgeSize = 26,
    insets = { left = 1, right = 1, top = 1, bottom = 1 }
})
guideFrame:SetBackdropColor(0, 0, 0, 0.9)
guideFrame:SetBackdropBorderColor(1, 1, 1, 1)

guideFrame:Hide()
guideFrame:SetMovable(true)
guideFrame:EnableMouse(true)
guideFrame:RegisterForDrag("LeftButton")
guideFrame:SetScript("OnDragStart", function()
    guideFrame:StartMoving()
end)
guideFrame:SetScript("OnDragStop", function()
    guideFrame:StopMovingOrSizing()
end)

local titleText = guideFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
titleText:SetPoint("CENTER", guideFrame, "TOP", 0, -30)
titleText:SetText("PROFESSIONS LEVELING GUIDE")

local closeButton = CreateFrame("Button", "CloseWindowButton", guideFrame, "UIPanelCloseButton")
closeButton:SetPoint("TOPRIGHT", guideFrame, "TOPRIGHT", -5, -5)
closeButton:SetScript("OnClick", function()
    guideFrame:Hide()
end)

-- Content area - ScrollFrame
local contentFrame = CreateFrame("ScrollFrame", "ProfGuideScrollFrame", guideFrame, "UIPanelScrollFrameTemplate")
contentFrame:SetPoint("TOPLEFT", guideFrame, "TOPLEFT", 150, -60)
contentFrame:SetPoint("BOTTOMRIGHT", guideFrame, "BOTTOMRIGHT", -30, 10)

-- Create a child frame for the scroll frame
local contentChild = CreateFrame("Frame", "ProfGuideScrollChild", contentFrame)
contentChild:SetWidth(550)
contentChild:SetHeight(500)
contentFrame:SetScrollChild(contentChild)

-- After creating contentChild, add a header
local headerFont = _G["CombatLogFont"] and "CombatLogFont" or "GameFontNormalLarge"
local headerText = contentChild:CreateFontString(nil, "OVERLAY", headerFont)
headerText:SetPoint("TOP", contentChild, "TOP", 0, -10)
headerText:SetText("")

-- Get the scrollbar
local scrollBar = contentFrame.ScrollBar or _G["ProfGuideScrollFrameScrollBar"]

-- Enable mouse wheel scrolling
contentFrame:EnableMouseWheel(true)
contentFrame:SetScript("OnMouseWheel", function(self, delta)
    local current = contentFrame:GetVerticalScroll()
    local maxScroll = contentFrame:GetVerticalScrollRange()
    
    if delta > 0 then
        contentFrame:SetVerticalScroll(math.max(0, current - 30))
    else
        contentFrame:SetVerticalScroll(math.min(maxScroll, current + 30))
    end
    
    if scrollBar then
        scrollBar:SetValue(contentFrame:GetVerticalScroll())
    end
end)

-- Store all text lines
local textLines = {}

-- Function to clear content
local function ClearContent()
    for i, line in ipairs(textLines) do
        line:Hide()
    end
    textLines = {}
end

-- Helper function to display maps (handles both single and multi-tile)
local function DisplayMap(mapFrame, mapData)
    -- Clear existing textures
    if mapFrame.textures then
        for i, tex in ipairs(mapFrame.textures) do
            tex:Hide()
        end
    end
    mapFrame.textures = {}
    
    -- Check if multi-tile (table) or single (string)
    if type(mapData) == "table" and mapData.path then
        local tile = mapFrame:CreateTexture(nil, "ARTWORK")
        tile:SetAllPoints(mapFrame)
        tile:SetTexture(mapData.path)
        if mapData.texCoord then
            tile:SetTexCoord(mapData.texCoord[1], mapData.texCoord[2], mapData.texCoord[3], mapData.texCoord[4])
        end
        tile:Show()
        table.insert(mapFrame.textures, tile)
    elseif type(mapData) == "table" then
        -- Multi-tile map
        local tileWidth = mapFrame:GetWidth() / #mapData
        local tileHeight = mapFrame:GetHeight()
        
        for i, tilePath in ipairs(mapData) do
            local tile = mapFrame:CreateTexture(nil, "ARTWORK")
            tile:SetWidth(tileWidth)
            tile:SetHeight(tileHeight)
            
            if i == 1 then
                tile:SetPoint("LEFT", mapFrame, "LEFT", 0, 0)
            else
                tile:SetPoint("LEFT", mapFrame.textures[i-1], "RIGHT", 0, 0)
            end
            
            tile:SetTexture(tilePath)
            tile:Show()
            table.insert(mapFrame.textures, tile)
        end
    else
        -- Single tile map
        local tile = mapFrame:CreateTexture(nil, "ARTWORK")
        tile:SetAllPoints(mapFrame)
        tile:SetTexture(mapData)
        tile:Show()
        table.insert(mapFrame.textures, tile)
    end
end

local function DisplayContent(contentTable, professionData)
    ClearContent()
    
    -- Set header if it exists
    if professionData.headerText then
        headerText:SetText(professionData.headerText)
        headerText:Show()
    else
        headerText:Hide()
    end
    
    local yOffset = -40
    for i, text in ipairs(contentTable) do
        local line = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        line:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 10, yOffset)
        line:SetWidth(530)
        line:SetJustifyH("LEFT")
        line:SetText(text)
        line:SetTextColor(1, 1, 0.6)
        line:Show()
        
        table.insert(textLines, line)
        yOffset = yOffset - 13
    end
    
    contentChild:SetHeight(math.abs(yOffset) + 20)
    contentFrame:UpdateScrollChildRect()
end

local gatherGuides = {}

local function ClearAllGathering()
    for _, guide in ipairs(gatherGuides) do
        guide.clear()
    end
end

local function NewGatheringGuide(globalName, layout)
    local ui = {
        textFrame = nil,
        mapFrame = nil,
        zoneButtons = {},
        navButtons = {},
        currentSection = 1
    }
    local guide = { ui = ui }

    function guide.clear()
        if ui.headerText then
            ui.headerText:Hide()
        end
        if ui.textFrame then
            ui.textFrame:Hide()
        end
        if ui.mapFrame then
            ui.mapFrame:Hide()
        end
        if ui.sectionIndicator then
            ui.sectionIndicator:Hide()
        end
        for _, btn in ipairs(ui.zoneButtons) do
            btn:Hide()
        end
        for _, btn in ipairs(ui.navButtons) do
            btn:Hide()
        end
        ui.zoneButtons = {}
        ui.navButtons = {}
    end

    local function ShowSection(sectionIndex)
        local data = _G[globalName]
        if not data or not data.sections then
            return
        end

        local section = data.sections[sectionIndex]
        if not section then
            return
        end

        ui.currentSection = sectionIndex

        if ui.sectionIndicator then
            ui.sectionIndicator:SetText("Section " .. sectionIndex .. " of " .. #data.sections)
        end

        for _, btn in ipairs(ui.zoneButtons) do
            btn:Hide()
        end
        ui.zoneButtons = {}

        ui.textFrame:SetText(section.title .. "\n\n" .. section.description)

        if section.zones and #section.zones > 0 then
            ui.mapFrame:Show()
            local xOffset = 20
            local yOffset = layout.zoneY
            local buttonWidth = 165
            local buttonSpacing = 5
            local maxWidth = 540

            for _, zone in ipairs(section.zones) do
                if xOffset + buttonWidth > maxWidth then
                    xOffset = 20
                    yOffset = yOffset - 30
                end

                local btn = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
                btn:SetWidth(buttonWidth)
                btn:SetHeight(25)
                btn:SetPoint("TOPLEFT", contentChild, "TOPLEFT", xOffset, yOffset)
                btn:SetText(zone.name)
                btn.mapPath = zone.map

                btn:SetScript("OnClick", function(self)
                    DisplayMap(ui.mapFrame, self.mapPath)
                end)

                btn:Show()
                table.insert(ui.zoneButtons, btn)

                xOffset = xOffset + buttonWidth + buttonSpacing
            end

            DisplayMap(ui.mapFrame, section.zones[1].map)
        else
            ui.mapFrame:Hide()
        end
    end

    function guide.display()
        ClearContent()
        ClearAllGathering()

        if headerText then
            headerText:Hide()
        end

        local data = _G[globalName]
        if not data or not data.sections then
            print("ERROR: " .. globalName .. " data not found!")
            return
        end

        if not ui.headerText then
            ui.headerText = contentChild:CreateFontString(nil, "OVERLAY", headerFont)
            ui.headerText:SetPoint("TOP", contentChild, "TOP", 0, -10)
        end
        if data.headerText then
            ui.headerText:SetText(data.headerText)
            ui.headerText:Show()
        end

        if not ui.textFrame then
            ui.textFrame = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            ui.textFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 10, -40)
            ui.textFrame:SetWidth(530)
            ui.textFrame:SetJustifyH("LEFT")
            ui.textFrame:SetJustifyV("TOP")
        end

        if not ui.mapFrame then
            ui.mapFrame = CreateFrame("Frame", nil, contentChild, "BackdropTemplate")
            ui.mapFrame:SetWidth(530)
            ui.mapFrame:SetHeight(layout.mapHeight)
            ui.mapFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, layout.mapY)
            ui.mapFrame:SetBackdrop({
                bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
                edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
                tile = true,
                tileSize = 16,
                edgeSize = 16,
                insets = { left = 4, right = 4, top = 4, bottom = 4 }
            })
            ui.mapFrame:SetBackdropColor(0, 0, 0, 1)
            ui.mapFrame.textures = {}
        end

        local prevButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
        prevButton:SetWidth(100)
        prevButton:SetHeight(25)
        prevButton:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, layout.navY)
        prevButton:SetText("<< Previous")
        prevButton:SetScript("OnClick", function()
            if ui.currentSection > 1 then
                ShowSection(ui.currentSection - 1)
            end
        end)
        prevButton:Show()
        table.insert(ui.navButtons, prevButton)

        local nextButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
        nextButton:SetWidth(100)
        nextButton:SetHeight(25)
        nextButton:SetPoint("TOPRIGHT", contentChild, "TOPRIGHT", -20, layout.navY)
        nextButton:SetText("Next >>")
        nextButton:SetScript("OnClick", function()
            if ui.currentSection < #data.sections then
                ShowSection(ui.currentSection + 1)
            end
        end)
        nextButton:Show()
        table.insert(ui.navButtons, nextButton)

        local sectionIndicator = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        sectionIndicator:SetPoint("TOP", contentChild, "TOP", 0, layout.navY - 5)
        sectionIndicator:SetText("Section " .. ui.currentSection .. " of " .. #data.sections)
        ui.sectionIndicator = sectionIndicator

        ui.textFrame:Show()
        ui.mapFrame:Show()

        ShowSection(1)

        contentChild:SetHeight(1000)
        contentFrame:UpdateScrollChildRect()
    end

    table.insert(gatherGuides, guide)
    return guide
end

local herbalismGuide = NewGatheringGuide("Herbalism", { zoneY = -480, navY = -550, mapY = -580, mapHeight = 400 })
local miningGuide = NewGatheringGuide("Mining", { zoneY = -550, navY = -620, mapY = -650, mapHeight = 400 })
local skinningGuide = NewGatheringGuide("Skinning", { zoneY = -480, navY = -550, mapY = -580, mapHeight = 355 })

local SETS = {
    {
        tab = "Forever Updated",
        tabName = "ForeverTabButton",
        tip = "Guides checked against Wowhead's Forever pages",
        gathering = { "Herbalism", "Mining", "Skinning" },
        crafting = {
            { "Alchemy", "Alchemy" },
            { "Cooking", "Cooking" },
            { "FirstAid", "First Aid" },
            { "Fishing", "Fishing" },
            { "Tailoring", "Tailoring" },
        },
    },
    {
        tab = "Classic (Pending)",
        tabName = "ClassicTabButton",
        tip = "Classic (pending Forever update)",
        gathering = {},
        crafting = {
            { "Blacksmithing", "Blacksmithing" },
            { "Enchanting", "Enchanting" },
            { "Engineering", "Engineering" },
            { "Leatherworking", "Leatherworking" },
        },
    },
}

local function ShowCraft(globalName)
    ClearAllGathering()
    contentFrame:SetVerticalScroll(0)
    local data = _G[globalName]
    if data and data.content then
        DisplayContent(data.content, data)
    else
        print("ERROR: " .. globalName .. " data not found!")
    end
end

local gatherActions = {}
for name, guide in pairs({ Herbalism = herbalismGuide, Mining = miningGuide, Skinning = skinningGuide }) do
    gatherActions[name] = function()
        guide.display()
        contentFrame:SetVerticalScroll(0)
    end
end

local function AddHeader(parent, text, y)
    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("TOP", parent, "TOPLEFT", 80, y)
    label:SetText(text)
    local rule = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    rule:SetPoint("TOP", parent, "TOPLEFT", 80, y - 16)
    rule:SetText("============")
end

local function AddButton(parent, name, text, y, onClick)
    local btn = CreateFrame("Button", name, parent, "UIPanelButtonTemplate")
    btn:SetWidth(120)
    btn:SetHeight(30)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 20, y)
    btn:SetText(text)
    btn:SetScript("OnClick", onClick)
    return btn
end

local setFrames = {}
local tabButtons = {}

local function SelectSet(index)
    for i, frame in ipairs(setFrames) do
        if i == index then
            frame:Show()
            tabButtons[i]:Disable()
        else
            frame:Hide()
            tabButtons[i]:Enable()
        end
    end
end

for index, set in ipairs(SETS) do
    local frame = CreateFrame("Frame", nil, guideFrame)
    frame:SetWidth(150)
    frame:SetHeight(700)
    frame:SetPoint("TOPLEFT", guideFrame, "TOPLEFT", 0, 0)
    setFrames[index] = frame

    local y = -150
    AddHeader(frame, "GATHERING:", y)
    y = y - 40
    if #set.gathering == 0 then
        local none = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        none:SetPoint("TOP", frame, "TOPLEFT", 80, y - 8)
        none:SetText("None yet")
        none:SetTextColor(0.6, 0.6, 0.6)
        y = y - 40
    end
    for _, name in ipairs(set.gathering) do
        AddButton(frame, name .. "Button", name, y, gatherActions[name])
        y = y - 40
    end

    y = y - 10
    AddHeader(frame, "CRAFTING:", y)
    y = y - 40
    for _, entry in ipairs(set.crafting) do
        local globalName = entry[1]
        AddButton(frame, globalName .. "Button", entry[2], y, function()
            ShowCraft(globalName)
        end)
        y = y - 40
    end

    local tab = CreateFrame("Button", set.tabName, guideFrame, "UIPanelButtonTemplate")
    tab:SetWidth(120)
    tab:SetHeight(28)
    tab:SetPoint("TOPLEFT", guideFrame, "TOPLEFT", 20, -62 - (index - 1) * 34)
    tab:SetText(set.tab)
    tab:SetScript("OnClick", function()
        SelectSet(index)
    end)
    tab:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText(set.tip)
        GameTooltip:Show()
    end)
    tab:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    tabButtons[index] = tab
end

SelectSet(1)

local function ShowFrame()
    guideFrame:Show()
end

if Alchemy and Alchemy.content then
    DisplayContent(Alchemy.content, Alchemy)
end

SLASH_PROFGUIDE1 = "/profguide"
SLASH_PROFGUIDE2 = "/pg"
SlashCmdList["PROFGUIDE"] = function()
    ShowFrame()
end

-------------------------------------------------------
-- MINIMAP BUTTON
-------------------------------------------------------

local minimapButton = CreateFrame("Button", "TG_MinimapButton", Minimap)
minimapButton:SetWidth(33)
minimapButton:SetHeight(33)
minimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
minimapButton:SetFrameStrata("MEDIUM")
minimapButton:SetFrameLevel(8)

local overlay = minimapButton:CreateTexture(nil, "OVERLAY")
overlay:SetWidth(56)
overlay:SetHeight(56)
overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")
overlay:SetPoint("TOPLEFT", 0, 0)

local icon = minimapButton:CreateTexture(nil, "BACKGROUND")
icon:SetWidth(20)
icon:SetHeight(20)
icon:SetTexture("Interface\\Icons\\Trade_Engineering")
icon:SetPoint("CENTER", 0, 1)

local highlight = minimapButton:CreateTexture(nil, "HIGHLIGHT")
highlight:SetWidth(33)
highlight:SetHeight(33)
highlight:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
highlight:SetBlendMode("ADD")

minimapButton:SetMovable(true)
minimapButton:EnableMouse(true)
minimapButton:RegisterForClicks("LeftButtonUp")
minimapButton:RegisterForDrag("RightButton")

minimapButton:SetScript("OnClick", function()
    if guideFrame:IsShown() then
        guideFrame:Hide()
    else
        guideFrame:Show()
    end
end)

minimapButton:SetScript("OnDragStart", function()
    minimapButton:StartMoving()
end)

minimapButton:SetScript("OnDragStop", function()
    minimapButton:StopMovingOrSizing()
end)

minimapButton:SetScript("OnEnter", function()
    GameTooltip:SetOwner(minimapButton, "ANCHOR_RIGHT")
    GameTooltip:AddLine("Trader's Guide")
    GameTooltip:AddLine("|cFF00FF00Left-click|r to open Trader's Guide Window", 1, 1, 1)
    GameTooltip:AddLine("|cFF0080FFRight-click|r and drag to move", 1, 1, 1)
    GameTooltip:Show()
end)

minimapButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

minimapButton:Show()