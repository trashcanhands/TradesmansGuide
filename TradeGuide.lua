local guideFrame = CreateFrame("Frame", "GuideFrame", UIParent, "ButtonFrameTemplate")
guideFrame:SetWidth(1050)
guideFrame:SetHeight(800)
guideFrame:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 16, -16)
guideFrame:SetPortraitToAsset("Interface\\AddOns\\TradeGuide\\icon")
guideFrame:SetTitle("TRADESMAN'S GUIDE")
guideFrame.Inset:ClearAllPoints()
guideFrame.Inset:SetPoint("TOPLEFT", guideFrame, "TOPLEFT", 150, -60)
guideFrame.Inset:SetPoint("BOTTOMRIGHT", guideFrame, "BOTTOMRIGHT", -6, 5)

TradeGuideDB = TradeGuideDB or {}

if TradeGuideDB.point then
    guideFrame:ClearAllPoints()
    guideFrame:SetPoint(TradeGuideDB.point.point, UIParent, TradeGuideDB.point.relativePoint, TradeGuideDB.point.x, TradeGuideDB.point.y)
end

guideFrame:Hide()
guideFrame:SetMovable(true)
guideFrame:EnableMouse(true)
guideFrame:SetClampedToScreen(true)
guideFrame:RegisterForDrag("LeftButton")
guideFrame:SetScript("OnDragStart", function()
    guideFrame:StartMoving()
end)
guideFrame:SetScript("OnDragStop", function()
    guideFrame:StopMovingOrSizing()
    local point, _, relativePoint, x, y = guideFrame:GetPoint()
    TradeGuideDB.point = { point = point, relativePoint = relativePoint, x = x, y = y }
end)

local contentFrame = CreateFrame("ScrollFrame", "ProfGuideScrollFrame", guideFrame, "ScrollFrameTemplate")
contentFrame:SetPoint("TOPLEFT", guideFrame.Inset, "TOPLEFT", 4, -4)
contentFrame:SetPoint("BOTTOMRIGHT", guideFrame.Inset, "BOTTOMRIGHT", -24, 4)
contentFrame.ScrollBar:SetHideIfUnscrollable(true)

local contentChild = CreateFrame("Frame", "ProfGuideScrollChild", contentFrame)
contentChild:SetWidth(850)
contentChild:SetHeight(500)
contentFrame:SetScrollChild(contentChild)

local headerFont = _G["CombatLogFont"] and "CombatLogFont" or "GameFontNormalLarge"
local headerText = contentChild:CreateFontString(nil, "OVERLAY", headerFont)
headerText:SetPoint("TOP", contentChild, "TOP", 0, -10)
headerText:SetText("")

-- Store all text lines
local textLines = {}

local craftSidebarWidth = 170

local craftSidebar = CreateFrame("Frame", nil, contentFrame)
craftSidebar:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, 0)
craftSidebar:SetPoint("BOTTOMLEFT", contentFrame, "BOTTOMLEFT", 0, 0)
craftSidebar:SetWidth(craftSidebarWidth)
craftSidebar:SetFrameLevel(contentFrame:GetFrameLevel() + 10)
craftSidebar:Hide()

local craftSidebarBg = craftSidebar:CreateTexture(nil, "BACKGROUND")
craftSidebarBg:SetColorTexture(0, 0, 0, 0.35)
craftSidebarBg:SetAllPoints(craftSidebar)

local craftSidebarEdge = craftSidebar:CreateTexture(nil, "ARTWORK")
craftSidebarEdge:SetColorTexture(1, 0.82, 0, 0.5)
craftSidebarEdge:SetWidth(2)
craftSidebarEdge:SetPoint("TOPRIGHT", craftSidebar, "TOPRIGHT", 0, 0)
craftSidebarEdge:SetPoint("BOTTOMRIGHT", craftSidebar, "BOTTOMRIGHT", 0, 0)

local craftSidebarButtons = {}

-- Function to clear content
local function ClearContent()
    for i, line in ipairs(textLines) do
        line:Hide()
    end
    textLines = {}
    craftSidebar:Hide()
    for _, btn in ipairs(craftSidebarButtons) do
        btn:Hide()
    end
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
    local canvas = mapFrame.canvas or mapFrame
    
    -- Check if multi-tile (table) or single (string)
    if type(mapData) == "table" and mapData.path then
        local tile = canvas:CreateTexture(nil, "ARTWORK")
        tile:SetAllPoints(canvas)
        tile:SetTexture(mapData.path)
        if mapData.texCoord then
            tile:SetTexCoord(mapData.texCoord[1], mapData.texCoord[2], mapData.texCoord[3], mapData.texCoord[4])
        end
        tile:Show()
        table.insert(mapFrame.textures, tile)
    elseif type(mapData) == "table" then
        -- Multi-tile map
        local tileWidth = canvas:GetWidth() / #mapData
        local tileHeight = canvas:GetHeight()
        
        for i, tilePath in ipairs(mapData) do
            local tile = canvas:CreateTexture(nil, "ARTWORK")
            tile:SetWidth(tileWidth)
            tile:SetHeight(tileHeight)
            
            if i == 1 then
                tile:SetPoint("LEFT", canvas, "LEFT", 0, 0)
            else
                tile:SetPoint("LEFT", mapFrame.textures[i-1], "RIGHT", 0, 0)
            end
            
            tile:SetTexture(tilePath)
            tile:Show()
            table.insert(mapFrame.textures, tile)
        end
    else
        -- Single tile map
        local tile = canvas:CreateTexture(nil, "ARTWORK")
        tile:SetAllPoints(canvas)
        tile:SetTexture(mapData)
        tile:Show()
        table.insert(mapFrame.textures, tile)
    end
end

local function IsSeparatorLine(text)
    return type(text) == "string" and text:match("^%-%-+$") ~= nil
end

local function HexToRGB(hex)
    local r = tonumber(hex:sub(1, 2), 16) / 255
    local g = tonumber(hex:sub(3, 4), 16) / 255
    local b = tonumber(hex:sub(5, 6), 16) / 255
    return r, g, b
end

local WHERE_CHIP_PATTERN = "^%s*|cFF(%x%x%x%x%x%x)%[%a%]|r%s*|cFF33FF99%[(.-)%]|r%s*/%s*|cFF33FF99%[(.-)%]|r%s*$"

local function IsLevelsBannerStart(contentTable, i)
    local a, b, c = contentTable[i], contentTable[i + 1], contentTable[i + 2]
    if not (IsSeparatorLine(a) and IsSeparatorLine(c)) then
        return false
    end
    if type(b) ~= "string" or IsSeparatorLine(b) or b == "" then
        return false
    end
    return b:find("Levels:", 1, true) ~= nil
end

local function IsAnyBannerStart(contentTable, i)
    local a, b, c = contentTable[i], contentTable[i + 1], contentTable[i + 2]
    if not (IsSeparatorLine(a) and IsSeparatorLine(c)) then
        return false
    end
    if type(b) ~= "string" or IsSeparatorLine(b) or b == "" then
        return false
    end
    return true
end

local function ExtractLevelsRangeLabel(bannerText)
    local clean = bannerText:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")
    local lo, hi = clean:match("(%d+)%s*%-%s*(%d+)")
    if lo and hi then
        return "Levels " .. lo .. "-" .. hi
    end
    local single = clean:match("(%d+)")
    if single then
        return "Level " .. single
    end
    return "Levels"
end

local function ComputeCraftPages(contentTable)
    local total = #contentTable
    local bannerStarts = {}
    for i = 1, total do
        if IsLevelsBannerStart(contentTable, i) then
            table.insert(bannerStarts, i)
        end
    end

    if #bannerStarts == 0 then
        return nil, nil
    end

    local pullTarget = {}
    for i = 1, total do
        if contentTable[i] == "TRAIN:" then
            local closeIdx = nil
            for j = i + 1, total do
                if IsSeparatorLine(contentTable[j]) then
                    closeIdx = j
                    break
                end
            end
            if closeIdx then
                local d = closeIdx + 1
                while contentTable[d] == "" do
                    d = d + 1
                end
                for _, b in ipairs(bannerStarts) do
                    if d == b then
                        pullTarget[b] = pullTarget[b] and math.min(pullTarget[b], i - 1) or (i - 1)
                    end
                end
            end
        end
    end

    local pageStarts = {}
    for _, b in ipairs(bannerStarts) do
        table.insert(pageStarts, pullTarget[b] or b)
    end

    if pageStarts[1] then
        local back = pageStarts[1] - 1
        while contentTable[back] == "" do
            back = back - 1
        end
        if back >= 3 and IsAnyBannerStart(contentTable, back - 2) then
            pageStarts[1] = back - 2
        end
    end

    local pages = {}
    local labels = {}
    if pageStarts[1] > 1 then
        local overview = {}
        for i = 1, pageStarts[1] - 1 do
            table.insert(overview, contentTable[i])
        end
        table.insert(pages, overview)
        table.insert(labels, "Overview")
    end

    for k, s in ipairs(pageStarts) do
        local e = (pageStarts[k + 1] or (total + 1)) - 1
        local page = {}
        for i = s, e do
            table.insert(page, contentTable[i])
        end
        table.insert(pages, page)
        table.insert(labels, ExtractLevelsRangeLabel(contentTable[bannerStarts[k] + 1]))
    end

    return pages, labels
end

local function DisplayContent(contentTable, professionData, topOffset, leftMargin)
    ClearContent()

    -- Set header if it exists
    if professionData.headerText then
        headerText:SetText(professionData.headerText)
        headerText:Show()
    else
        headerText:Hide()
    end

    leftMargin = leftMargin or 10
    local contentWidth = 840 - leftMargin

    local yOffset = topOffset or -40
    local i = 1
    local total = #contentTable
    while i <= total do
        local text = contentTable[i]
        local nextLine = contentTable[i + 1]
        local afterNext = contentTable[i + 2]
        local isBanner = IsSeparatorLine(text) and IsSeparatorLine(afterNext)
            and type(nextLine) == "string" and nextLine ~= "" and not IsSeparatorLine(nextLine)

        if isBanner then
            local barHeight = 22
            yOffset = yOffset - 8

            local bar = contentChild:CreateTexture(nil, "BACKGROUND")
            bar:SetColorTexture(0, 0, 0, 0.45)
            bar:SetPoint("TOPLEFT", contentChild, "TOPLEFT", leftMargin, yOffset)
            bar:SetWidth(contentWidth)
            bar:SetHeight(barHeight)
            table.insert(textLines, bar)

            local topBorder = contentChild:CreateTexture(nil, "ARTWORK")
            topBorder:SetColorTexture(1, 0.82, 0, 0.7)
            topBorder:SetPoint("BOTTOMLEFT", bar, "TOPLEFT", 0, 0)
            topBorder:SetWidth(contentWidth)
            topBorder:SetHeight(2)
            table.insert(textLines, topBorder)

            local bottomBorder = contentChild:CreateTexture(nil, "ARTWORK")
            bottomBorder:SetColorTexture(1, 0.82, 0, 0.7)
            bottomBorder:SetPoint("TOPLEFT", bar, "BOTTOMLEFT", 0, 0)
            bottomBorder:SetWidth(contentWidth)
            bottomBorder:SetHeight(2)
            table.insert(textLines, bottomBorder)

            local label = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label:SetPoint("LEFT", bar, "LEFT", 8, 0)
            label:SetText(nextLine)
            label:SetTextColor(1, 1, 1)
            label:Show()
            table.insert(textLines, label)

            yOffset = yOffset - barHeight - 6
            i = i + 3
        elseif IsSeparatorLine(text) then
            local rule = contentChild:CreateTexture(nil, "ARTWORK")
            rule:SetColorTexture(1, 0.82, 0, 0.6)
            rule:SetPoint("TOPLEFT", contentChild, "TOPLEFT", leftMargin, yOffset - 6)
            rule:SetWidth(contentWidth)
            rule:SetHeight(2)
            table.insert(textLines, rule)

            yOffset = yOffset - 13
            i = i + 1
        elseif text == "WHERE:" then
            local label = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            label:SetPoint("TOPLEFT", contentChild, "TOPLEFT", leftMargin, yOffset)
            label:SetWidth(contentWidth)
            label:SetJustifyH("LEFT")
            label:SetText(text)
            label:SetTextColor(1, 1, 0.6)
            label:Show()
            table.insert(textLines, label)

            local labelHeight = label:GetStringHeight()
            if labelHeight < 15 then
                labelHeight = 15
            end
            yOffset = yOffset - labelHeight
            i = i + 1

            local chips = {}
            while i <= total do
                local candidate = contentTable[i]
                if candidate == "" then
                    i = i + 1
                else
                    local color, name, loc = candidate:match(WHERE_CHIP_PATTERN)
                    if color then
                        table.insert(chips, { color = color, name = name, loc = loc })
                        i = i + 1
                    else
                        break
                    end
                end
            end

            if #chips > 0 then
                local rowHeight = 22
                local gap = 6
                local xCursor = leftMargin
                local rowY = yOffset - 4
                local maxX = leftMargin + contentWidth

                for _, chip in ipairs(chips) do
                    local r, g, b = HexToRGB(chip.color)
                    local chipText = (chip.loc and chip.loc ~= "") and (chip.name .. "  -  " .. chip.loc) or chip.name

                    local textFS = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                    textFS:SetText(chipText)
                    textFS:SetTextColor(1, 1, 1)
                    local textWidth = textFS:GetStringWidth()
                    local chipWidth = textWidth + 16

                    if xCursor + chipWidth > maxX and xCursor > leftMargin then
                        xCursor = leftMargin
                        rowY = rowY - (rowHeight + 4)
                    end

                    local chipBg = contentChild:CreateTexture(nil, "BACKGROUND")
                    chipBg:SetColorTexture(0, 0, 0, 0.4)
                    chipBg:SetPoint("TOPLEFT", contentChild, "TOPLEFT", xCursor, rowY)
                    chipBg:SetWidth(chipWidth)
                    chipBg:SetHeight(rowHeight)
                    table.insert(textLines, chipBg)

                    local edgeTop = contentChild:CreateTexture(nil, "ARTWORK")
                    edgeTop:SetColorTexture(r, g, b, 0.9)
                    edgeTop:SetPoint("TOPLEFT", chipBg, "TOPLEFT", 0, 0)
                    edgeTop:SetWidth(chipWidth)
                    edgeTop:SetHeight(2)
                    table.insert(textLines, edgeTop)

                    local edgeBottom = contentChild:CreateTexture(nil, "ARTWORK")
                    edgeBottom:SetColorTexture(r, g, b, 0.9)
                    edgeBottom:SetPoint("BOTTOMLEFT", chipBg, "BOTTOMLEFT", 0, 0)
                    edgeBottom:SetWidth(chipWidth)
                    edgeBottom:SetHeight(2)
                    table.insert(textLines, edgeBottom)

                    local edgeLeft = contentChild:CreateTexture(nil, "ARTWORK")
                    edgeLeft:SetColorTexture(r, g, b, 0.9)
                    edgeLeft:SetPoint("TOPLEFT", chipBg, "TOPLEFT", 0, 0)
                    edgeLeft:SetWidth(2)
                    edgeLeft:SetHeight(rowHeight)
                    table.insert(textLines, edgeLeft)

                    local edgeRight = contentChild:CreateTexture(nil, "ARTWORK")
                    edgeRight:SetColorTexture(r, g, b, 0.9)
                    edgeRight:SetPoint("TOPRIGHT", chipBg, "TOPRIGHT", 0, 0)
                    edgeRight:SetWidth(2)
                    edgeRight:SetHeight(rowHeight)
                    table.insert(textLines, edgeRight)

                    textFS:ClearAllPoints()
                    textFS:SetPoint("CENTER", chipBg, "CENTER", 0, 0)
                    textFS:Show()
                    table.insert(textLines, textFS)

                    xCursor = xCursor + chipWidth + gap
                end

                yOffset = rowY - rowHeight - 6
            end
        else
            local line = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
            line:SetPoint("TOPLEFT", contentChild, "TOPLEFT", leftMargin, yOffset)
            line:SetWidth(contentWidth)
            line:SetJustifyH("LEFT")
            line:SetText(text)
            line:SetTextColor(1, 1, 0.6)
            line:Show()

            table.insert(textLines, line)
            local lineHeight = line:GetStringHeight()
            local minHeight = 15
            if text == "" then
                minHeight = 24
            end
            if lineHeight < minHeight then
                lineHeight = minHeight
            end
            yOffset = yOffset - lineHeight
            i = i + 1
        end
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

    local function ShowMap(mapData)
        local height = layout.mapHeight
        if type(mapData) == "table" and mapData.aspect then
            height = math.floor(824 / mapData.aspect) + 6
        end
        ui.mapFrame:SetHeight(height)
        ui.mapFrame.canvas:SetHeight(height - 6)
        DisplayMap(ui.mapFrame, mapData)
        contentChild:SetHeight(math.abs(ui.mapTop) + height + 20)
        contentFrame:UpdateScrollChildRect()
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

        local y = -40 - ui.textFrame:GetStringHeight() - 14
        local hasZones = section.zones and #section.zones > 0

        if hasZones then
            local xOffset = 20
            local buttonWidth = 165
            local buttonSpacing = 5
            local maxWidth = 840

            for _, zone in ipairs(section.zones) do
                if xOffset + buttonWidth > maxWidth then
                    xOffset = 20
                    y = y - 27
                end

                local btn = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
                btn:SetWidth(buttonWidth)
                btn:SetHeight(22)
                btn:SetPoint("TOPLEFT", contentChild, "TOPLEFT", xOffset, y)
                btn:SetText(zone.name)
                btn.mapPath = zone.map

                btn:SetScript("OnClick", function(self)
                    ShowMap(self.mapPath)
                end)

                btn:Show()
                table.insert(ui.zoneButtons, btn)

                xOffset = xOffset + buttonWidth + buttonSpacing
            end
            y = y - 36
        end

        ui.prevButton:ClearAllPoints()
        ui.prevButton:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, y)
        ui.nextButton:ClearAllPoints()
        ui.nextButton:SetPoint("TOPRIGHT", contentChild, "TOPRIGHT", -20, y)
        ui.sectionIndicator:ClearAllPoints()
        ui.sectionIndicator:SetPoint("TOP", contentChild, "TOP", 0, y - 5)
        y = y - 32

        ui.mapTop = y
        if hasZones then
            ui.mapFrame:ClearAllPoints()
            ui.mapFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, y)
            ui.mapFrame:Show()
            ShowMap(section.zones[1].map)
        else
            ui.mapFrame:Hide()
            contentChild:SetHeight(math.abs(y) + 20)
            contentFrame:UpdateScrollChildRect()
        end
        contentFrame:SetVerticalScroll(0)
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
            ui.textFrame:SetWidth(830)
            ui.textFrame:SetJustifyH("LEFT")
            ui.textFrame:SetJustifyV("TOP")
        end

        if not ui.mapFrame then
            ui.mapFrame = CreateFrame("Frame", nil, contentChild, "InsetFrameTemplate")
            ui.mapFrame:SetWidth(830)
            ui.mapFrame:SetHeight(layout.mapHeight)
            ui.mapFrame:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, -80)
            ui.mapFrame.canvas = CreateFrame("Frame", nil, ui.mapFrame)
            ui.mapFrame.canvas:SetPoint("TOPLEFT", ui.mapFrame, "TOPLEFT", 3, -3)
            ui.mapFrame.canvas:SetWidth(824)
            ui.mapFrame.canvas:SetHeight(layout.mapHeight - 6)
            ui.mapFrame.textures = {}
        end

        local prevButton = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
        prevButton:SetWidth(100)
        prevButton:SetHeight(22)
        prevButton:SetPoint("TOPLEFT", contentChild, "TOPLEFT", 20, -50)
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
        nextButton:SetHeight(22)
        nextButton:SetPoint("TOPRIGHT", contentChild, "TOPRIGHT", -20, -50)
        nextButton:SetText("Next >>")
        nextButton:SetScript("OnClick", function()
            if ui.currentSection < #data.sections then
                ShowSection(ui.currentSection + 1)
            end
        end)
        nextButton:Show()
        table.insert(ui.navButtons, nextButton)

        local sectionIndicator = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        sectionIndicator:SetPoint("TOP", contentChild, "TOP", 0, -55)
        sectionIndicator:SetText("Section " .. ui.currentSection .. " of " .. #data.sections)
        ui.sectionIndicator = sectionIndicator
        ui.prevButton = prevButton
        ui.nextButton = nextButton

        ui.textFrame:Show()
        ui.mapFrame:Show()

        ShowSection(1)
    end

    table.insert(gatherGuides, guide)
    return guide
end

local herbalismGuide = NewGatheringGuide("Herbalism", { mapHeight = 355 })
local miningGuide = NewGatheringGuide("Mining", { mapHeight = 355 })
local skinningGuide = NewGatheringGuide("Skinning", { mapHeight = 355 })

local SETS = {
    {
        tab = "Forever Updated",
        tabName = "ForeverTabButton",
        tip = "Guides sourced specifically for Forever",
        gathering = { "Herbalism", "Mining", "Skinning" },
        crafting = {
            { "Alchemy", "Alchemy" },
            { "Blacksmithing", "Blacksmithing" },
            { "Cooking", "Cooking" },
            { "Enchanting", "Enchanting" },
            { "Engineering", "Engineering" },
            { "FirstAid", "First Aid" },
            { "Fishing", "Fishing" },
            { "FishingCooking", "Fishing+Cooking" },
            { "Leatherworking", "Leatherworking" },
            { "Lockpicking", "Lockpicking" },
            { "Tailoring", "Tailoring" },
            { "Camping", "Camping" },
            { "MerchantsFavor", "Merchant's Favor" },
        },
        craftingDividerBefore = "Camping",
    },
}

local craftPageCache = {}
local currentCraftProfession = nil
local ShowCraftPage

local function BuildCraftSidebar(globalName, labels, activeIndex)
    for _, btn in ipairs(craftSidebarButtons) do
        btn:Hide()
    end

    if not labels or #labels < 2 then
        craftSidebar:Hide()
        return
    end

    craftSidebar:Show()

    local y = -10
    for idx, labelText in ipairs(labels) do
        local btn = craftSidebarButtons[idx]
        if not btn then
            btn = CreateFrame("Button", nil, craftSidebar, "UIPanelButtonTemplate")
            btn:SetWidth(craftSidebarWidth - 16)
            btn:SetHeight(24)
            craftSidebarButtons[idx] = btn
        end

        btn:SetPoint("TOPLEFT", craftSidebar, "TOPLEFT", 8, y)
        btn:SetText(labelText)
        btn:SetScript("OnClick", function()
            ShowCraftPage(globalName, idx)
        end)

        if idx == activeIndex then
            btn:LockHighlight()
        else
            btn:UnlockHighlight()
        end

        btn:Show()
        y = y - 28
    end
end

ShowCraftPage = function(globalName, pageIndex)
    local data = _G[globalName]
    if not data or not data.content then
        print("ERROR: " .. globalName .. " data not found!")
        return
    end

    local cached = craftPageCache[globalName]
    if not cached then
        local pages, labels = ComputeCraftPages(data.content)
        cached = { pages = pages, labels = labels }
        craftPageCache[globalName] = cached
    end

    currentCraftProfession = globalName

    if not cached.pages then
        DisplayContent(data.content, data)
        BuildCraftSidebar(globalName, nil, nil)
        contentFrame:SetVerticalScroll(0)
        return
    end

    if pageIndex < 1 then
        pageIndex = 1
    elseif pageIndex > #cached.pages then
        pageIndex = #cached.pages
    end

    local hasSidebar = #cached.pages > 1
    local leftMargin = hasSidebar and (craftSidebarWidth + 20) or 10

    DisplayContent(cached.pages[pageIndex], data, -40, leftMargin)
    BuildCraftSidebar(globalName, cached.labels, pageIndex)
    contentFrame:SetVerticalScroll(0)
end

local function ShowCraft(globalName)
    ClearAllGathering()
    ShowCraftPage(globalName, 1)
end

local gatherActions = {}
for name, guide in pairs({ Herbalism = herbalismGuide, Mining = miningGuide, Skinning = skinningGuide }) do
    gatherActions[name] = function()
        guide.display()
        contentFrame:SetVerticalScroll(0)
    end
end

local function AddHeader(parent, text, y)
    local barWidth = 130
    local barHeight = 20

    local bar = parent:CreateTexture(nil, "BACKGROUND")
    bar:SetColorTexture(0, 0, 0, 0.45)
    bar:SetWidth(barWidth)
    bar:SetHeight(barHeight)
    bar:SetPoint("TOP", parent, "TOPLEFT", 80, y)

    local topBorder = parent:CreateTexture(nil, "ARTWORK")
    topBorder:SetColorTexture(1, 0.82, 0, 0.7)
    topBorder:SetWidth(barWidth)
    topBorder:SetHeight(2)
    topBorder:SetPoint("BOTTOM", bar, "TOP", 0, 0)

    local bottomBorder = parent:CreateTexture(nil, "ARTWORK")
    bottomBorder:SetColorTexture(1, 0.82, 0, 0.7)
    bottomBorder:SetWidth(barWidth)
    bottomBorder:SetHeight(2)
    bottomBorder:SetPoint("TOP", bar, "BOTTOM", 0, 0)

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    label:SetPoint("CENTER", bar, "CENTER", 0, 0)
    label:SetText(text)
    label:SetTextColor(1, 1, 1)
end

local function AddButton(parent, name, text, y, onClick)
    local btn = CreateFrame("Button", name, parent, "UIPanelButtonTemplate")
    btn:SetWidth(120)
    btn:SetHeight(24)
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
        else
            frame:Hide()
        end
    end
    if #SETS > 1 then
        PanelTemplates_SetTab(guideFrame, index)
    end
end

for index, set in ipairs(SETS) do
    local frame = CreateFrame("Frame", nil, guideFrame)
    frame:SetWidth(150)
    frame:SetHeight(700)
    frame:SetPoint("TOPLEFT", guideFrame, "TOPLEFT", 0, 0)
    setFrames[index] = frame

    local y = -80
    AddHeader(frame, "GATHERING:", y)
    y = y - 34
    for _, name in ipairs(set.gathering) do
        AddButton(frame, name .. "Button", name, y, gatherActions[name])
        y = y - 28
    end

    y = y - 10
    AddHeader(frame, "CRAFTING:", y)
    y = y - 34
    for _, entry in ipairs(set.crafting) do
        local globalName = entry[1]
        if set.craftingDividerBefore == globalName then
            y = y - 8
            local divider = frame:CreateTexture(nil, "ARTWORK")
            divider:SetTexture("Interface\\Common\\UI-TooltipDivider-Transparent")
            divider:SetWidth(120)
            divider:SetHeight(8)
            divider:SetPoint("TOP", frame, "TOPLEFT", 80, y + 4)
            y = y - 12
        end
        AddButton(frame, globalName .. "Button", entry[2], y, function()
            ShowCraft(globalName)
        end)
        y = y - 28
    end

    if #SETS > 1 then
        local tab = CreateFrame("Button", set.tabName, guideFrame, "PanelTabButtonTemplate")
        tab:SetID(index)
        if index == 1 then
            tab:SetPoint("TOPLEFT", guideFrame, "BOTTOMLEFT", 11, 2)
        end
        tab:SetText(set.tab)
        tab:SetScript("OnClick", function()
            SelectSet(index)
            TradeGuideDB.selectedSet = index
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
end

if #SETS > 1 then
    PanelTemplates_SetNumTabs(guideFrame, #SETS)
end

if not SETS[TradeGuideDB.selectedSet] then
    TradeGuideDB.selectedSet = 1
end
SelectSet(TradeGuideDB.selectedSet)

local function ShowFrame()
    guideFrame:Show()
end

if Alchemy and Alchemy.content then
    DisplayContent(Alchemy.content, Alchemy)
end

SLASH_PROFGUIDE1 = "/tradeguide"
SLASH_PROFGUIDE2 = "/tg"
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
icon:SetTexture("Interface\\AddOns\\TradeGuide\\icon")
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
    GameTooltip:AddLine("Tradesman's Guide")
    GameTooltip:AddLine("|cFF00FF00Left-click|r to open Tradesman's Guide Window", 1, 1, 1)
    GameTooltip:AddLine("|cFF0080FFRight-click|r and drag to move", 1, 1, 1)
    GameTooltip:Show()
end)

minimapButton:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

minimapButton:Show()
