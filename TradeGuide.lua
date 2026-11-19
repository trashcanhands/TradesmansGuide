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
local headerText = contentFrame:CreateFontString(nil, "OVERLAY", headerFont)
headerText:SetPoint("TOP", contentFrame, "TOP", 0, -6)
headerText:SetText("")

-- Store all text lines
local textLines = {}

local craftTabBarHeight = 28
local craftTabBar = CreateFrame("Frame", nil, contentFrame)
craftTabBar:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, -30)
craftTabBar:SetPoint("TOPRIGHT", contentFrame, "TOPRIGHT", 0, -30)
craftTabBar:SetHeight(craftTabBarHeight)
craftTabBar:SetFrameLevel(contentFrame:GetFrameLevel() + 10)
craftTabBar:Hide()

local craftTabBarBg = craftTabBar:CreateTexture(nil, "BACKGROUND")
craftTabBarBg:SetColorTexture(0, 0, 0, 0.3)
craftTabBarBg:SetAllPoints(craftTabBar)

local craftTabBarEdge = craftTabBar:CreateTexture(nil, "ARTWORK")
craftTabBarEdge:SetColorTexture(1, 0.82, 0, 0.5)
craftTabBarEdge:SetHeight(2)
craftTabBarEdge:SetPoint("BOTTOMLEFT", craftTabBar, "BOTTOMLEFT", 0, 0)
craftTabBarEdge:SetPoint("BOTTOMRIGHT", craftTabBar, "BOTTOMRIGHT", 0, 0)

local CRAFT_TABS = { "Overview", "Leveling", "Trainers" }
local craftTabButtons = {}
for idx, label in ipairs(CRAFT_TABS) do
    local btn = CreateFrame("Button", nil, craftTabBar, "UIPanelButtonTemplate")
    btn:SetWidth(110)
    btn:SetHeight(24)
    btn:SetPoint("LEFT", craftTabBar, "LEFT", 6 + (idx - 1) * 114, 0)
    btn:SetText(label)
    craftTabButtons[idx] = btn
end

local craftCardFrames = {}
local bracketPillButtons = {}

-- Function to clear content
local function ClearContent()
    for i, line in ipairs(textLines) do
        line:Hide()
    end
    textLines = {}
    for _, card in ipairs(craftCardFrames) do
        card:Hide()
    end
    for _, pill in ipairs(bracketPillButtons) do
        pill:Hide()
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

local BRACKET_BANNER_MARKERS = { "Levels:", "Fishing:", "Cooking:", "Fishing Quest", "Cooking Quest" }

local function IsLevelsBannerStart(contentTable, i)
    local a, b, c = contentTable[i], contentTable[i + 1], contentTable[i + 2]
    if not (IsSeparatorLine(a) and IsSeparatorLine(c)) then
        return false
    end
    if type(b) ~= "string" or IsSeparatorLine(b) or b == "" then
        return false
    end
    for _, marker in ipairs(BRACKET_BANNER_MARKERS) do
        if b:find(marker, 1, true) then
            return true
        end
    end
    return false
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

local function ExtractRangeAfter(clean, marker)
    local idx = clean:find(marker, 1, true)
    if not idx then
        return nil
    end
    local rest = clean:sub(idx + #marker)
    local lo, hi = rest:match("(%d+)%s*%-%s*(%d+)")
    if lo and hi then
        return lo .. "-" .. hi
    end
    local single = rest:match("(%d+)")
    if single then
        return single
    end
    return nil
end

local function ExtractLevelsRangeLabel(bannerText)
    local clean = bannerText:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")

    local fishingRange = ExtractRangeAfter(clean, "Fishing:")
    local cookingRange = ExtractRangeAfter(clean, "Cooking:")

    if fishingRange and cookingRange then
        return "F " .. fishingRange .. " / C " .. cookingRange
    elseif fishingRange then
        return "Fishing " .. fishingRange
    elseif cookingRange then
        return "Cooking " .. cookingRange
    end

    if clean:find("Fishing Quest", 1, true) then
        return "Fishing Quest"
    end
    if clean:find("Cooking Quest", 1, true) then
        return "Cooking Quest"
    end

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

local function ComputeCraftStructure(contentTable)
    local total = #contentTable
    local bannerStarts = {}
    for i = 1, total do
        if IsLevelsBannerStart(contentTable, i) then
            table.insert(bannerStarts, i)
        end
    end

    if #bannerStarts == 0 then
        return nil
    end

    local trainerBlockFor = {}
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
                        trainerBlockFor[b] = { startIdx = i - 1, trainIdx = i, closeIdx = closeIdx }
                    end
                end
            end
        end
    end

    local overviewEnd
    if trainerBlockFor[bannerStarts[1]] then
        overviewEnd = trainerBlockFor[bannerStarts[1]].startIdx - 1
    else
        overviewEnd = bannerStarts[1] - 1
    end

    local overview = {}
    for i = 1, overviewEnd do
        table.insert(overview, contentTable[i])
    end

    local brackets = {}
    for k, b in ipairs(bannerStarts) do
        local tb = trainerBlockFor[b]
        local trainerLines = {}
        if tb then
            for i = tb.trainIdx, tb.closeIdx - 1 do
                table.insert(trainerLines, contentTable[i])
            end
        end

        local craftStart = b + 3
        while contentTable[craftStart] == "" do
            craftStart = craftStart + 1
        end

        local nextBoundary = bannerStarts[k + 1]
        if nextBoundary and trainerBlockFor[nextBoundary] then
            nextBoundary = trainerBlockFor[nextBoundary].startIdx
        end
        local craftEnd = (nextBoundary or (total + 1)) - 1
        while craftEnd >= craftStart and (contentTable[craftEnd] == "" or IsSeparatorLine(contentTable[craftEnd])) do
            craftEnd = craftEnd - 1
        end

        local craftLines = {}
        for i = craftStart, craftEnd do
            table.insert(craftLines, contentTable[i])
        end

        table.insert(brackets, {
            label = ExtractLevelsRangeLabel(contentTable[b + 1]),
            trainerLines = trainerLines,
            craftLines = craftLines,
        })
    end

    return { overview = overview, brackets = brackets }
end

local function ParseLevelingBlocks(lines)
    local blocks = {}
    local i = 1
    local n = #lines
    local pendingSubrange = nil
    local plainBuf = {}

    local function flushPlain()
        while #plainBuf > 0 and plainBuf[#plainBuf] == "" do
            table.remove(plainBuf)
        end
        while #plainBuf > 0 and plainBuf[1] == "" do
            table.remove(plainBuf, 1)
        end
        if #plainBuf > 0 then
            table.insert(blocks, { type = "plain", lines = plainBuf })
        end
        plainBuf = {}
    end

    local function isStopLine(l)
        return l == nil or l == "" or l:match("^NOTE:") or l:match("^Craft:")
            or l == "OR" or l:match("^%[|cFF%x%x%x%x%x%x")
    end

    while i <= n do
        local line = lines[i]
        if type(line) == "string" and line:match("^%[|cFF%x%x%x%x%x%x.-|r%]$") then
            pendingSubrange = line:match("^%[|cFF%x%x%x%x%x%x(.-)|r%]$")
            i = i + 1
        elseif type(line) == "string" and line:match("^Craft:") then
            flushPlain()
            local card = { type = "card", subrange = pendingSubrange, title = line }
            pendingSubrange = nil
            i = i + 1
            if lines[i] and lines[i]:match("^Requires:") then
                local req = lines[i]
                i = i + 1
                while not isStopLine(lines[i]) do
                    req = req .. " " .. lines[i]
                    i = i + 1
                end
                card.req = req
            end
            while lines[i] and lines[i]:match("^NOTE:") do
                local note = lines[i]
                i = i + 1
                while not isStopLine(lines[i]) do
                    note = note .. " " .. lines[i]
                    i = i + 1
                end
                card.note = card.note and (card.note .. "  " .. note) or note
            end
            table.insert(blocks, card)
        else
            table.insert(plainBuf, line)
            i = i + 1
        end
    end
    flushPlain()
    return blocks
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

local craftStructureCache = {}
local currentCraftProfession = nil
local CRAFT_CONTENT_TOP = -74
local RenderLevelingTab
local ShowLevelingBracket
local SetActiveCraftTab

local function HighlightCraftTab(tabIndex)
    for idx, btn in ipairs(craftTabButtons) do
        if idx == tabIndex then
            btn:LockHighlight()
        else
            btn:UnlockHighlight()
        end
    end
end

local function BuildRecipeCard(index, x, y, width, cardData)
    local card = craftCardFrames[index]
    if not card then
        card = CreateFrame("Frame", nil, contentChild)

        local bg = card:CreateTexture(nil, "BACKGROUND")
        bg:SetColorTexture(1, 1, 1, 0.05)
        bg:SetAllPoints(card)

        local top = card:CreateTexture(nil, "ARTWORK")
        top:SetColorTexture(1, 0.82, 0, 0.45)
        top:SetHeight(2)
        top:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
        top:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)

        local bottom = card:CreateTexture(nil, "ARTWORK")
        bottom:SetColorTexture(1, 0.82, 0, 0.45)
        bottom:SetHeight(2)
        bottom:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 0)
        bottom:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", 0, 0)

        local left = card:CreateTexture(nil, "ARTWORK")
        left:SetColorTexture(1, 0.82, 0, 0.45)
        left:SetWidth(2)
        left:SetPoint("TOPLEFT", card, "TOPLEFT", 0, 0)
        left:SetPoint("BOTTOMLEFT", card, "BOTTOMLEFT", 0, 0)

        local right = card:CreateTexture(nil, "ARTWORK")
        right:SetColorTexture(1, 0.82, 0, 0.45)
        right:SetWidth(2)
        right:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, 0)
        right:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", 0, 0)

        local icon = card:CreateTexture(nil, "ARTWORK")
        icon:SetColorTexture(0.22, 0.18, 0.1, 0.9)
        icon:SetWidth(36)
        icon:SetHeight(36)
        icon:SetPoint("TOPLEFT", card, "TOPLEFT", 10, -10)

        local title = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        title:SetJustifyH("LEFT")
        title:SetJustifyV("TOP")
        title:SetTextColor(1, 1, 1)

        local req = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        req:SetJustifyH("LEFT")
        req:SetJustifyV("TOP")
        req:SetTextColor(0.85, 0.8, 0.55)

        local note = card:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        note:SetJustifyH("LEFT")
        note:SetJustifyV("TOP")
        note:SetTextColor(0.5, 0.85, 0.5)

        card.icon = icon
        card.title = title
        card.req = req
        card.note = note
        craftCardFrames[index] = card
    end

    card:ClearAllPoints()
    card:SetPoint("TOPLEFT", contentChild, "TOPLEFT", x, y)
    card:SetWidth(width)

    local textX = 10 + 36 + 10
    local textWidth = width - textX - 10

    local titleText = cardData.title
    if cardData.subrange then
        titleText = "|cFFFFD700[" .. cardData.subrange .. "]|r  " .. titleText
    end

    card.title:ClearAllPoints()
    card.title:SetPoint("TOPLEFT", card, "TOPLEFT", textX, -10)
    card.title:SetWidth(textWidth)
    card.title:SetText(titleText)
    card.title:Show()

    local cursorY = -10 - card.title:GetStringHeight() - 4

    if cardData.req then
        card.req:ClearAllPoints()
        card.req:SetPoint("TOPLEFT", card, "TOPLEFT", textX, cursorY)
        card.req:SetWidth(textWidth)
        card.req:SetText(cardData.req)
        card.req:Show()
        cursorY = cursorY - card.req:GetStringHeight() - 4
    else
        card.req:Hide()
    end

    if cardData.note then
        card.note:ClearAllPoints()
        card.note:SetPoint("TOPLEFT", card, "TOPLEFT", textX, cursorY)
        card.note:SetWidth(textWidth)
        card.note:SetText(cardData.note)
        card.note:Show()
        cursorY = cursorY - card.note:GetStringHeight() - 4
    else
        card.note:Hide()
    end

    local textBlockHeight = -cursorY + 6
    local cardHeight = math.max(36 + 20, textBlockHeight + 10)
    card:SetHeight(cardHeight)
    card.icon:Show()
    card:Show()

    return cardHeight
end

local function RenderPlainBlockLines(lines, x, y, width)
    for _, text in ipairs(lines) do
        local line = contentChild:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        line:SetPoint("TOPLEFT", contentChild, "TOPLEFT", x, y)
        line:SetWidth(width)
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
        y = y - lineHeight
    end
    return y
end

local function RenderBracketPills(globalName, brackets, activeIndex, x, y, width)
    for _, pill in ipairs(bracketPillButtons) do
        pill:Hide()
    end

    local gap = 6
    local curX = x
    local curY = y
    local usedRow = false

    for idx, bracket in ipairs(brackets) do
        local pill = bracketPillButtons[idx]
        if not pill then
            pill = CreateFrame("Button", nil, contentChild, "UIPanelButtonTemplate")
            bracketPillButtons[idx] = pill
        end

        pill:SetHeight(22)
        pill:SetText(bracket.label)
        local fs = pill:GetFontString()
        local textWidth = 60
        if fs then
            fs:SetWordWrap(false)
            textWidth = fs:GetStringWidth()
        end
        local pillWidth = math.min(width, math.max(60, textWidth + 24))
        pill:SetWidth(pillWidth)

        if usedRow and curX + pillWidth > x + width then
            curX = x
            curY = curY - 28
        end
        usedRow = true

        pill:ClearAllPoints()
        pill:SetPoint("TOPLEFT", contentChild, "TOPLEFT", curX, curY)
        pill:SetScript("OnClick", function()
            ShowLevelingBracket(globalName, idx)
        end)

        if idx == activeIndex then
            pill:LockHighlight()
        else
            pill:UnlockHighlight()
        end

        pill:Show()
        curX = curX + pillWidth + gap
    end

    return curY - 28
end

RenderLevelingTab = function(globalName, bracketIndex)
    local data = _G[globalName]
    local struct = craftStructureCache[globalName]
    if not data or not struct then
        return
    end

    if bracketIndex < 1 then
        bracketIndex = 1
    elseif bracketIndex > #struct.brackets then
        bracketIndex = #struct.brackets
    end
    struct.lastBracket = bracketIndex

    ClearContent()

    if data.headerText then
        headerText:SetText(data.headerText)
        headerText:Show()
    else
        headerText:Hide()
    end

    local leftMargin = 10
    local contentWidth = 840 - leftMargin

    local y = RenderBracketPills(globalName, struct.brackets, bracketIndex, leftMargin, CRAFT_CONTENT_TOP, contentWidth)
    y = y - 10

    local bracket = struct.brackets[bracketIndex]
    local blocks = ParseLevelingBlocks(bracket.craftLines)

    local gap = 10
    local cardWidth = (contentWidth - gap) / 2
    local cardIdx = 0
    local pendingLeft = nil

    local function placeCard(cardData, colX, width)
        cardIdx = cardIdx + 1
        return BuildRecipeCard(cardIdx, colX, y, width, cardData)
    end

    local function flushPendingAlone()
        if pendingLeft then
            local h = placeCard(pendingLeft, leftMargin, cardWidth)
            y = y - h - gap
            pendingLeft = nil
        end
    end

    for _, blk in ipairs(blocks) do
        if blk.type == "card" then
            if pendingLeft then
                local leftH = placeCard(pendingLeft, leftMargin, cardWidth)
                local rightH = placeCard(blk, leftMargin + cardWidth + gap, cardWidth)
                y = y - math.max(leftH, rightH) - gap
                pendingLeft = nil
            else
                pendingLeft = blk
            end
        else
            flushPendingAlone()
            y = RenderPlainBlockLines(blk.lines, leftMargin, y, contentWidth)
            y = y - 6
        end
    end
    flushPendingAlone()

    contentChild:SetHeight(math.abs(y) + 20)
    contentFrame:UpdateScrollChildRect()

    HighlightCraftTab(2)
end

ShowLevelingBracket = function(globalName, bracketIndex)
    local struct = craftStructureCache[globalName]
    if not struct then
        return
    end
    struct.activeTab = 2
    RenderLevelingTab(globalName, bracketIndex)
    contentFrame:SetVerticalScroll(0)
end

local function BuildTrainersContent(struct)
    local lines = {}
    local any = false
    local sep = "------------------------------------------------------------------------------------------------"
    for _, bracket in ipairs(struct.brackets) do
        if #bracket.trainerLines > 0 then
            any = true
            table.insert(lines, sep)
            table.insert(lines, bracket.label)
            table.insert(lines, sep)
            for _, l in ipairs(bracket.trainerLines) do
                table.insert(lines, l)
            end
            table.insert(lines, "")
        end
    end
    if not any then
        table.insert(lines, "No separate trainer listings for this profession.")
    end
    return lines
end

local function RenderOverviewTab(globalName)
    local data = _G[globalName]
    local struct = craftStructureCache[globalName]
    DisplayContent(struct.overview, data, CRAFT_CONTENT_TOP, 10)
    contentFrame:SetVerticalScroll(0)
end

local function RenderTrainersTab(globalName)
    local data = _G[globalName]
    local struct = craftStructureCache[globalName]
    local lines = BuildTrainersContent(struct)
    DisplayContent(lines, data, CRAFT_CONTENT_TOP, 10)
    contentFrame:SetVerticalScroll(0)
end

SetActiveCraftTab = function(globalName, tabIndex)
    local struct = craftStructureCache[globalName]
    if not struct then
        return
    end
    struct.activeTab = tabIndex
    HighlightCraftTab(tabIndex)

    if tabIndex == 1 then
        RenderOverviewTab(globalName)
    elseif tabIndex == 2 then
        RenderLevelingTab(globalName, struct.lastBracket or 1)
        contentFrame:SetVerticalScroll(0)
    elseif tabIndex == 3 then
        RenderTrainersTab(globalName)
    end
end

local function ShowCraftProfession(globalName)
    ClearAllGathering()
    local data = _G[globalName]
    if not data or not data.content then
        print("ERROR: " .. globalName .. " data not found!")
        return
    end

    currentCraftProfession = globalName

    local struct = craftStructureCache[globalName]
    if struct == nil then
        struct = ComputeCraftStructure(data.content)
        craftStructureCache[globalName] = struct or false
    end

    if not struct then
        craftTabBar:Hide()
        DisplayContent(data.content, data)
        contentFrame:SetVerticalScroll(0)
        return
    end

    craftTabBar:Show()
    for idx, btn in ipairs(craftTabButtons) do
        btn:SetScript("OnClick", function()
            SetActiveCraftTab(globalName, idx)
        end)
    end

    SetActiveCraftTab(globalName, struct.activeTab or 1)
end

local gatherActions = {}
for name, guide in pairs({ Herbalism = herbalismGuide, Mining = miningGuide, Skinning = skinningGuide }) do
    gatherActions[name] = function()
        craftTabBar:Hide()
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
            ShowCraftProfession(globalName)
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

local HUB_CONTENT = {
    "----------------------------------------------------------------------------------------------",
    "WELCOME",
    "----------------------------------------------------------------------------------------------",
    "Pick a gathering or crafting profession from the sidebar on the left to get started.",
    "",
    "These guides are built specifically for Turtle WoW's |cFF1EFF00Forever|r ruleset, sourced from",
    "wow-professions.com/forever and checked in-game.",
    "",
    "----------------------------------------------------------------------------------------------",
    "GATHERING",
    "----------------------------------------------------------------------------------------------",
    "|cFF1EFF00Herbalism|r, |cFF1EFF00Mining|r, |cFF1EFF00Skinning|r",
    "",
    "----------------------------------------------------------------------------------------------",
    "CRAFTING",
    "----------------------------------------------------------------------------------------------",
    "|cFF1EFF00Alchemy|r, |cFF1EFF00Blacksmithing|r, |cFF1EFF00Cooking|r, |cFF1EFF00Enchanting|r,",
    "|cFF1EFF00Engineering|r, |cFF1EFF00First Aid|r, |cFF1EFF00Fishing|r, |cFF1EFF00Fishing+Cooking|r,",
    "|cFF1EFF00Leatherworking|r, |cFF1EFF00Lockpicking|r, |cFF1EFF00Tailoring|r",
    "",
    "----------------------------------------------------------------------------------------------",
    "CAMPING & REPUTATION",
    "----------------------------------------------------------------------------------------------",
    "|cFF1EFF00Camping|r, |cFF1EFF00Merchant's Favor|r",
}

local HUB_DATA = { headerText = "TRADESMAN'S GUIDE" }

local function ShowHub()
    ClearAllGathering()
    currentCraftProfession = nil
    craftTabBar:Hide()
    DisplayContent(HUB_CONTENT, HUB_DATA)
end

ShowHub()

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
