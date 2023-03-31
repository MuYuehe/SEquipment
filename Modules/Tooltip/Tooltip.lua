Scorpio "SEquipment.core.tooltip" ""

local avgLevelLine = STAT_AVERAGE_ITEM_LEVEL .. ":"

function AddExtraLine(guid, avgLevel, specName, argbHex)
    specName = specName or "..."
    argbHex = argbHex or ""
    local _, unitID = GameTooltip:GetUnit()
    if not unitID or UnitGUID(unitID) ~= guid then return end

    local leftText = string.format("%s%s", avgLevelLine, avgLevel)
    local rightText = string.format("%s%s", argbHex, specName)

    local leftLine, rightLine = GetLevelLine(GameTooltip, avgLevelLine)
    if leftLine then
        leftLine:SetText(leftText)
        rightLine:SetText(rightText)
    else
        GameTooltip:AddDoubleLine(leftText, rightText)
    end
    GameTooltip:Show()
end