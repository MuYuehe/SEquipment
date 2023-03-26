Scorpio "SEquipment.core.bag.handler" ""


local tooltip = CreateFrame("GameTooltip", "SEtooltip", UIParent, "GameTooltipTemplate")

__SecureHook__ "SetItemButtonQuality" __Async__()
function Hook_SetItemButtonQuality(self, quality, itemIDOrLink, ...)

    if self.isBag then return end

    local width, height = self:GetSize()
    local buttonID = self:GetID()
    local buttonName = self:GetName()
    local containerName = self:GetParent():GetName()
    local buttonFrame = ButtonInfo(buttonName .. buttonID .. "Info", self)
    -- Bag
    if string.find(containerName, "Container") and _Config.showbag:GetValue() == false or itemIDOrLink == nil then
        buttonFrame:Hide()
        return
    end
    -- Bank
    if string.find(containerName, "BankSlots") then
        tooltip:SetInventoryItem("player",self:GetInventorySlot())
        itemIDOrLink = select(2, tooltip:GetItem())

        if _Config.showbank:GetValue() == false or itemIDOrLink == nil then
            buttonFrame:Hide()
            return
        end
    end
    -- player
    if (not string.find(containerName, "Inspect")) and string.find(containerName, "PaperDoll") then
        itemIDOrLink = GetInventoryItemLink("player", buttonID)
        if _Config.showpaperdoll:GetValue() == false or itemIDOrLink == nil then
            buttonFrame:Hide()
            return
        end
    end
    -- target
    if string.find(containerName, "InspectPaperDoll") then
        itemIDOrLink = GetInventoryItemLink(InspectFrame and InspectFrame.unit, buttonID)
        if _Config.showpaperdoll:GetValue() == false or itemIDOrLink == nil then
            buttonFrame:Hide()
            return
        end
    end
    local table = GetItemUseInfo(itemIDOrLink, buttonID)
    table["width"] = width
    table["height"] = height
    buttonFrame.data = table
    buttonFrame:Show()
end