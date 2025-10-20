local guideFrame = CreateFrame("Frame", "GuideFrame", UIParent)
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
contentChild:SetHeight(100)
contentFrame:SetScrollChild(contentChild)

-- After creating contentChild, add a header
local headerText = contentChild:CreateFontString(nil, "OVERLAY", "CombatLogFont")
headerText:SetPoint("TOP", contentChild, "TOP", 0, -10)
headerText:SetText("")  -- Start emptys

-- Get the scrollbar
local scrollBar = getglobal("ProfGuideScrollFrameScrollBar")

-- Enable mouse wheel scrolling
contentFrame:EnableMouseWheel(true)
contentFrame:SetScript("OnMouseWheel", function()
    local current = contentFrame:GetVerticalScroll()
    local maxScroll = contentFrame:GetVerticalScrollRange()
    
    if arg1 > 0 then
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

local function DisplayContent(contentTable, professionData)
    ClearContent()
    
    -- Set header if it exists
    if professionData.headerText then
        headerText:SetText(professionData.headerText)
        headerText:Show()
    else
        headerText:Hide()
    end
    
    local yOffset = -40  -- Start lower to make room for header
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



-- Store herbalism UI elements
    local herbalismUI = {
    textFrame = nil,
    mapFrame = nil,
    mapTexture = nil,
    zoneButtons = {},
    navButtons = {},
    currentSection = 1
}

-- Function to clear herbalism UI
    local function ClearHerbalismUI()
      if herbalismUI.headerText then
        herbalismUI.headerText:Hide()
    end
      if herbalismUI.textFrame then
        herbalismUI.textFrame:Hide()
    end
      if herbalismUI.mapFrame then
        herbalismUI.mapFrame:Hide()
    end
        if herbalismUI.sectionIndicator then
        herbalismUI.sectionIndicator:Hide()
    end
      for i, btn in ipairs(herbalismUI.zoneButtons) do
        btn:Hide()
    end
      for i, btn in ipairs(herbalismUI.navButtons) do
        btn:Hide()
    end
      herbalismUI.zoneButtons = {}
      herbalismUI.navButtons = {}
    end

local function ShowHerbalismSection(sectionIndex)
    if not Herbalism or not Herbalism.sections then
        return
    end
    
    local section = Herbalism.sections[sectionIndex]
    if not section then
        return
    end
    
    herbalismUI.currentSection = sectionIndex
    
-- UPDATE THE SECTION INDICATOR
    if herbalismUI.sectionIndicator then
        herbalismUI.sectionIndicator:SetText("Section " .. sectionIndex .. " of " .. table.getn(Herbalism.sections))
    end
    
-- Clear old zone buttons
    for i, btn in ipairs(herbalismUI.zoneButtons) do
        btn:Hide()
    end
    herbalismUI.zoneButtons = {}
    
-- Update text
    herbalismUI.textFrame:SetText(section.title .. "\n\n" .. section.description)
    
-- Create zone buttons with wrapping
    local xOffset = 20
    local yOffset = -280
    local buttonWidth = 165  -- Adjust to your button width
    local buttonSpacing = 5
    local maxWidth = 540  -- Maximum width before wrapping
    
    for i, zone in ipairs(section.zones) do
        -- Check if button would go off screen
        if xOffset + buttonWidth > maxWidth then
            xOffset = 20  -- Reset to left
            yOffset = yOffset - 30  -- Move down one row
        end
        
        local btn = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
        btn:SetWidth(buttonWidth)
        btn:SetHeight(25)
        btn:SetPoint("TOPLEFT", contentChild, "TOPLEFT", xOffset, yOffset)
        btn:SetText(zone.name)
        btn.mapPath = zone.map
        
        btn:SetScript("OnClick", function()
            for j, b in ipairs(herbalismUI.zoneButtons) do
                b:GetNormalTexture():SetVertexColor(1, 1, 1)
            end
            herbalismUI.mapTexture:SetTexture(this.mapPath)
        end)
        
        btn:Show()
        table.insert(herbalismUI.zoneButtons, btn)
        
        xOffset = xOffset + buttonWidth + buttonSpacing
    end
    
-- Calculate how far down the buttons went
    local buttonRowHeight = math.abs(yOffset) + 10  -- Extra padding
    
-- Set default map
    if section.zones[1] then
        herbalismUI.mapTexture:SetTexture(section.zones[1].map)
    end
end

-- Function to display herbalism content
    local function DisplayHerbalism()
    ClearContent()
    ClearHerbalismUI()
    
-- Hide the normal header (used by other professions)
    if headerText then
        headerText:Hide()
    end
 
-- Create herbalism-specific header if it doesn't exist
    if not herbalismUI.headerText then
        herbalismUI.headerText = contentChild:CreateFontString(nil, "OVERLAY", "CombatLogFont")
        herbalismUI.headerText:SetPoint("TOP", contentChild, "TOP", 0, -10)
    end  
 
-- Set herbalism header
    if Herbalism.headerText then
        herbalismUI.headerText:SetText(Herbalism.headerText)
        herbalismUI.headerText:Show()
        
    end
 
   if not Herbalism or not Herbalism.sections then
        print("ERROR: Herbalism data not found!")
        return
    end
    
-- Create text display area
    if not herbalismUI.textFrame then
        herbalismUI.textFrame = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        herbalismUI.textFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 10, -40)
        herbalismUI.textFrame:SetWidth(530)
        herbalismUI.textFrame:SetJustifyH("LEFT")
        herbalismUI.textFrame:SetJustifyV("TOP")
    end
    
-- Create map frame
    if not herbalismUI.mapFrame then
        herbalismUI.mapFrame = CreateFrame("Frame", nil, contentChild)
        herbalismUI.mapFrame:SetWidth(530)
        herbalismUI.mapFrame:SetHeight(400)
        herbalismUI.mapFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, -415)
        herbalismUI.mapFrame:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        herbalismUI.mapFrame:SetBackdropColor(0, 0, 0, 1)
        
        herbalismUI.mapTexture = herbalismUI.mapFrame:CreateTexture(nil, "ARTWORK")
        herbalismUI.mapTexture:SetAllPoints(herbalismUI.mapFrame)
    end
    
-- Create navigation buttons (Previous/Next)
    local prevButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
    prevButton:SetWidth(100)
    prevButton:SetHeight(25)
    prevButton:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, -375)
    prevButton:SetText("<< Previous")
    prevButton:SetScript("OnClick", function()
        if herbalismUI.currentSection > 1 then
            ShowHerbalismSection(herbalismUI.currentSection - 1)
        end
    end)
    prevButton:Show()
    table.insert(herbalismUI.navButtons, prevButton)
    
    local nextButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
    nextButton:SetWidth(100)
    nextButton:SetHeight(25)
    nextButton:SetPoint("TOPRIGHT", contentChild, "TOPRIGHT", -20, -375)
    nextButton:SetText("Next >>")
    nextButton:SetScript("OnClick", function()
        if herbalismUI.currentSection < table.getn(Herbalism.sections) then
            ShowHerbalismSection(herbalismUI.currentSection + 1)
        end
    end)
    nextButton:Show()
    table.insert(herbalismUI.navButtons, nextButton)
    
-- Section indicator
    local sectionIndicator = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionIndicator:SetPoint("TOP", contentChild, "TOP", 0, -380)
    sectionIndicator:SetText("Section " .. herbalismUI.currentSection .. " of " .. table.getn(Herbalism.sections))
    herbalismUI.sectionIndicator = sectionIndicator
    
-- Show frames
    herbalismUI.textFrame:Show()
    herbalismUI.mapFrame:Show()
    
-- Display first section
    ShowHerbalismSection(1)
    
-- Adjust scroll height
    contentChild:SetHeight(1000)
    contentFrame:UpdateScrollChildRect()
end


-- Store mining UI elements
local miningUI = {
    textFrame = nil,
    mapFrame = nil,
    mapTexture = nil,
    zoneButtons = {},
    navButtons = {},
    currentSection = 1
}

-- Function to clear mining UI
local function ClearMiningUI()
    if miningUI.headerText then
        miningUI.headerText:Hide()
    end
    if miningUI.textFrame then
        miningUI.textFrame:Hide()
    end
    if miningUI.mapFrame then
        miningUI.mapFrame:Hide()
    end
    if miningUI.sectionIndicator then
        miningUI.sectionIndicator:Hide()
    end
    for i, btn in ipairs(miningUI.zoneButtons) do
        btn:Hide()
    end
    for i, btn in ipairs(miningUI.navButtons) do
        btn:Hide()
    end
    miningUI.zoneButtons = {}
    miningUI.navButtons = {}
end

local function ShowMiningSection(sectionIndex)
    if not Mining or not Mining.sections then
        return
    end
    
    local section = Mining.sections[sectionIndex]
    if not section then
        return
    end
    
    miningUI.currentSection = sectionIndex
    
    -- UPDATE THE SECTION INDICATOR
    if miningUI.sectionIndicator then
        miningUI.sectionIndicator:SetText("Section " .. sectionIndex .. " of " .. table.getn(Mining.sections))
    end
    
    -- Clear old zone buttons
    for i, btn in ipairs(miningUI.zoneButtons) do
        btn:Hide()
    end
    miningUI.zoneButtons = {}
    
    -- Update text
    miningUI.textFrame:SetText(section.title .. "\n\n" .. section.description)
    
    -- Create zone buttons with wrapping
    local xOffset = 20
    local yOffset = -450
    local buttonWidth = 165
    local buttonSpacing = 5
    local maxWidth = 540
    
    for i, zone in ipairs(section.zones) do
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
        
        btn:SetScript("OnClick", function()
            for j, b in ipairs(miningUI.zoneButtons) do
                b:GetNormalTexture():SetVertexColor(1, 1, 1)
            end
            miningUI.mapTexture:SetTexture(this.mapPath)
        end)
        
        btn:Show()
        table.insert(miningUI.zoneButtons, btn)
        
        xOffset = xOffset + buttonWidth + buttonSpacing
    end
    
    -- Set default map
    if section.zones[1] then
        miningUI.mapTexture:SetTexture(section.zones[1].map)
    end
end

-- Function to display mining content
local function DisplayMining()
    ClearContent()
    ClearHerbalismUI()
    ClearMiningUI()
    
    -- Hide the normal header
    if headerText then
        headerText:Hide()
    end
 
    -- Create mining-specific header
    if not miningUI.headerText then
        miningUI.headerText = contentChild:CreateFontString(nil, "OVERLAY", "CombatLogFont")
        miningUI.headerText:SetPoint("TOP", contentChild, "TOP", 0, -10)
    end  
 
    -- Set mining header
    if Mining.headerText then
        miningUI.headerText:SetText(Mining.headerText)
        miningUI.headerText:Show()
    end
 
    if not Mining or not Mining.sections then
        print("ERROR: Mining data not found!")
        return
    end
    
    -- Create text display area
    if not miningUI.textFrame then
        miningUI.textFrame = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        miningUI.textFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 10, -40)
        miningUI.textFrame:SetWidth(530)
        miningUI.textFrame:SetJustifyH("LEFT")
        miningUI.textFrame:SetJustifyV("TOP")
    end
    
    -- Create map frame
    if not miningUI.mapFrame then
        miningUI.mapFrame = CreateFrame("Frame", nil, contentChild)
        miningUI.mapFrame:SetWidth(530)
        miningUI.mapFrame:SetHeight(400)
        miningUI.mapFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, -560)
        miningUI.mapFrame:SetBackdrop({
            bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
            edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
            tile = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4 }
        })
        miningUI.mapFrame:SetBackdropColor(0, 0, 0, 1)
        
        miningUI.mapTexture = miningUI.mapFrame:CreateTexture(nil, "ARTWORK")
        miningUI.mapTexture:SetAllPoints(miningUI.mapFrame)
    end
    
    -- Create navigation buttons
    local prevButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
    prevButton:SetWidth(100)
    prevButton:SetHeight(25)
    prevButton:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, -515)
    prevButton:SetText("<< Previous")
    prevButton:SetScript("OnClick", function()
        if miningUI.currentSection > 1 then
            ShowMiningSection(miningUI.currentSection - 1)
        end
    end)
    prevButton:Show()
    table.insert(miningUI.navButtons, prevButton)
    
    local nextButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
    nextButton:SetWidth(100)
    nextButton:SetHeight(25)
    nextButton:SetPoint("TOPRIGHT", contentChild, "TOPRIGHT", -20, -515)
    nextButton:SetText("Next >>")
    nextButton:SetScript("OnClick", function()
        if miningUI.currentSection < table.getn(Mining.sections) then
            ShowMiningSection(miningUI.currentSection + 1)
        end
    end)
    nextButton:Show()
    table.insert(miningUI.navButtons, nextButton)
    
    -- Section indicator
    local sectionIndicator = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    sectionIndicator:SetPoint("TOP", contentChild, "TOP", 0, -520)
    sectionIndicator:SetText("Section " .. miningUI.currentSection .. " of " .. table.getn(Mining.sections))
    miningUI.sectionIndicator = sectionIndicator
    
    -- Show frames
    miningUI.textFrame:Show()
    miningUI.mapFrame:Show()
    
    -- Display first section
    ShowMiningSection(1)
    
    -- Adjust scroll height
    contentChild:SetHeight(1000)
    contentFrame:UpdateScrollChildRect()
end




local makingHeader = guideFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
makingHeader:SetPoint("LEFT", guideFrame, "TOPLEFT", 45, -168)
makingHeader:SetText("CRAFTING:")
local makingHeaderBreak = guideFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
makingHeaderBreak:SetPoint("LEFT", guideFrame, "TOPLEFT", 15, -188)
makingHeaderBreak:SetText("============")


-- Alchemy button
local alchemyButton = CreateFrame("Button", "AlchemyButton", guideFrame, "UIPanelButtonTemplate")
alchemyButton:SetWidth(120)
alchemyButton:SetHeight(30)
alchemyButton:SetPoint("TOPLEFT", guideFrame, "TOPLEFT", 20, -200)
alchemyButton:SetText("Alchemy")
alchemyButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Alchemy and Alchemy.content then
        DisplayContent(Alchemy.content, Alchemy)
    else
        print("ERROR: Alchemy data not found!")
    end
end)

-- Blacksmithing button
local blacksmithingButton = CreateFrame("Button", "BlacksmithingButton", guideFrame, "UIPanelButtonTemplate")
blacksmithingButton:SetWidth(120)
blacksmithingButton:SetHeight(30)
blacksmithingButton:SetPoint("TOP", alchemyButton, "BOTTOM", 0, -10)
blacksmithingButton:SetText("Blacksmithing")
blacksmithingButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Blacksmithing and Blacksmithing.content then
        DisplayContent(Blacksmithing.content, Blacksmithing)
    else
        print("ERROR: Blacksmithing data not found!")
    end
end)

-- Cooking button
local cookingButton = CreateFrame("Button", "CookingButton", guideFrame, "UIPanelButtonTemplate")
cookingButton:SetWidth(120)
cookingButton:SetHeight(30)
cookingButton:SetPoint("TOP", blacksmithingButton, "BOTTOM", 0, -10)
cookingButton:SetText("Cooking")
cookingButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Cooking and Cooking.content then
        DisplayContent(Cooking.content, Cooking)
    else
        print("ERROR: Cooking data not found!")
    end
end)

-- Enchanting button
local enchantingButton = CreateFrame("Button", "EnchantingButton", guideFrame, "UIPanelButtonTemplate")
enchantingButton:SetWidth(120)
enchantingButton:SetHeight(30)
enchantingButton:SetPoint("TOP", cookingButton, "BOTTOM", 0, -10)
enchantingButton:SetText("Enchanting")
enchantingButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Enchanting and Enchanting.content then
        DisplayContent(Enchanting.content, Enchanting)
    else
        print("ERROR: Enchanting data not found!")
    end
end)

-- Engineering button
local engineeringButton = CreateFrame("Button", "EngineeringButton", guideFrame, "UIPanelButtonTemplate")
engineeringButton:SetWidth(120)
engineeringButton:SetHeight(30)
engineeringButton:SetPoint("TOP", enchantingButton, "BOTTOM", 0, -10)
engineeringButton:SetText("Engineering")
engineeringButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Engineering and Engineering.content then
        DisplayContent(Engineering.content, Engineering)
    else
        print("ERROR: Engineering data not found!")
    end
end)

-- FirstAid button
local firstaidButton = CreateFrame("Button", "FirstAidButton", guideFrame, "UIPanelButtonTemplate")
firstaidButton:SetWidth(120)
firstaidButton:SetHeight(30)
firstaidButton:SetPoint("TOP", engineeringButton, "BOTTOM", 0, -10)
firstaidButton:SetText("FirstAid")
firstaidButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if FirstAid and FirstAid.content then
        DisplayContent(FirstAid.content, FirstAid)
    else
        print("ERROR: FirstAid data not found!")
    end
end)

-- Leatherworking button
local leatherworkingButton = CreateFrame("Button", "LeatherworkingButton", guideFrame, "UIPanelButtonTemplate")
leatherworkingButton:SetWidth(120)
leatherworkingButton:SetHeight(30)
leatherworkingButton:SetPoint("TOP", firstaidButton, "BOTTOM", 0, -10)
leatherworkingButton:SetText("Leatherworking")
leatherworkingButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Leatherworking and Leatherworking.content then
        DisplayContent(Leatherworking.content, Leatherworking)
    else
        print("ERROR: Leatherworking data not found!")
    end
end)

-- Tailoring button
local tailoringButton = CreateFrame("Button", "TailoringButton", guideFrame, "UIPanelButtonTemplate")
tailoringButton:SetWidth(120)
tailoringButton:SetHeight(30)
tailoringButton:SetPoint("TOP", leatherworkingButton, "BOTTOM", 0, -10)
tailoringButton:SetText("Tailoring")
tailoringButton:SetScript("OnClick", function()
        ClearHerbalismUI()
        ClearMiningUI()
        contentFrame:SetVerticalScroll(0)
    if Tailoring and Tailoring.content then
        DisplayContent(Tailoring.content, Tailoring)
    else
        print("ERROR: Tailoring data not found!")
    end
end)

local gatherHeader = guideFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
gatherHeader:SetPoint("CENTER", leatherworkingButton, "CENTER", 0, -70)
gatherHeader:SetText("GATHERING:")
local gatherHeaderBreak = guideFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
gatherHeaderBreak:SetPoint("CENTER", leatherworkingButton, "CENTER", 0, -90)
gatherHeaderBreak:SetText("============")

-- Herbalism button
local herbalismButton = CreateFrame("Button", "HerbalismButton", guideFrame, "UIPanelButtonTemplate")
herbalismButton:SetWidth(120)
herbalismButton:SetHeight(30)
herbalismButton:SetPoint("TOP", leatherworkingButton, "BOTTOM", 0, -90)
herbalismButton:SetText("Herbalism")

herbalismButton:SetScript("OnClick", function()
    ClearMiningUI()
    DisplayHerbalism()
    contentFrame:SetVerticalScroll(0)
    
end)

-- Mining button
local miningButton = CreateFrame("Button", "MiningButton", guideFrame, "UIPanelButtonTemplate")
miningButton:SetWidth(120)
miningButton:SetHeight(30)
miningButton:SetPoint("TOP", herbalismButton, "BOTTOM", 0, -10)
miningButton:SetText("Mining")

miningButton:SetScript("OnClick", function()
    ClearHerbalismUI()
    DisplayMining()
    contentFrame:SetVerticalScroll(0)
end)

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