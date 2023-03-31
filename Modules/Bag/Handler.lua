Scorpio "SEquipment.core.bag.handler" ""

__SecureHook__ "SetItemButtonQuality" __Async__()
function Hook_SetItemButtonQuality(self, quality, itemIDOrLink, ...)
    Next()

    if self.isBag or (not itemIDOrLink) then
        if self.buttonFrame then self.buttonFrame:Hide() end
        return
    end

    local buttonID = self:GetID()
    local buttonName = self:GetName()
    if not buttonID or not buttonName then return end

    local bagID = self:GetBagID()
    if not self.buttonFrame then self.buttonFrame = ButtonInfo(buttonName .. "Info", self) end

    local width, height = self:GetSize()
    local containerName = self:GetParent():GetName()
    local bagID = self:GetBagID()
    -- Bag/Bank
    if bagID then
        if not _Config.showbag:GetValue() then
            self.buttonFrame:Hide()
            return
        end
        local info = C_Container.GetContainerItemInfo(bagID, buttonID) --10.0加入的新api,与GetContainerItemInfo不同
        itemIDOrLink = info.hyperlink
    end
    -- player
    if (not string.find(containerName, "Inspect")) and string.find(containerName, "PaperDoll") then
        itemIDOrLink = GetInventoryItemLink("player", buttonID)
        if not _Config.showpaperdoll:GetValue() then
            self.buttonFrame:Hide()
            return
        end
    end
    -- target
    if string.find(containerName, "InspectPaperDoll") then
        itemIDOrLink = GetInventoryItemLink(InspectFrame and InspectFrame.unit, buttonID)
        if not _Config.showpaperdoll:GetValue() then
            self.buttonFrame:Hide()
            return
        end
    end

    local table = GetItemUseInfo(itemIDOrLink, buttonID)
    table["width"] = width
    table["height"] = height
    self.buttonFrame.data = table
    self.buttonFrame:Show()
end

-- 夭寿的InspectPaperDollItemSlotButton_Update在button.hasItem = nil的情况不走SetItemButtonQuality
__AddonSecureHook__ ("Blizzard_InspectUI", "InspectPaperDollItemSlotButton_Update")
function Hook_InspectPaperDollItemSlotButton_Update(self)
    if not self.hasItem and self.buttonFrame then
        self.buttonFrame:Hide()
    end
end