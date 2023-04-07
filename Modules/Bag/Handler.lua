Scorpio "SEquipment.core.bag.handler" ""

__SecureHook__ "SetItemButtonQuality" __Async__()
function Hook_SetItemButtonQuality(self, quality, itemIDOrLink, ...)
    Next()
    local buttonID = self:GetID()
    local buttonName = self:GetName()
    if not buttonID or not buttonName then return end

    -- Bag/Bank 缩小范围,只允许通过bag/bank,由于我使用测试账号的原因,拍卖行等没法测试,所以过滤掉了拍卖行
    if string.find(buttonName, "ContainerFrame") or string.find(buttonName, "BankFrame") then
        -- 设置不显示则返回,如果存在self.extraFrame,则隐藏self.extraFrame
        if not _Config.showbag:GetValue() or self.isBag or (not itemIDOrLink) then
            if self.extraFrame then self.extraFrame:Hide() end
            return
        end
        if not self.hasItem then
            if self.extraFrame then self.extraFrame:Hide() end
            return
        end
        if not self.extraFrame then
            self.extraFrame = ButtonInfo(buttonName .. "Info", self)
            self.extraFrame:SetAllPoints()
        end
        local containerName = self:GetParent():GetName()
        local bagID = self:GetBagID()
        local info = C_Container.GetContainerItemInfo(bagID, buttonID)
        itemIDOrLink = info.hyperlink

        local data = GetItemUseInfo(itemIDOrLink, buttonID)
        self.extraFrame.data = data["itemInfo"]
    end
end

__AddonSecureHook__ ("Blizzard_InspectUI", "InspectPaperDollItemSlotButton_Update") __Async__()
function Hook_InspectPaperDollItemSlotButton_Update(self)
    Next()
    -- 槽中没有物品则返回,如果self.extraFrame存在,则隐藏self.extraFrame
    if not self.hasItem then
        if self.extraFrame then
            self.extraFrame:Hide()
        end
        return
    end
    -- 如果为衬衫以及战袍则返回
    local buttonID = self:GetID()
    if buttonID == 4 or buttonID == 19 then
        return
    end
    -- 如果self.extraFrame不存在则创建self.extraFrame
    if not self.extraFrame then
        self.extraFrame = ButtonInfo(self:GetName() .. "Info", self)
        self.extraFrame:SetAllPoints()
    end
    -- 如果设置不显示则返回并隐藏self.extraFrame
    if not _Config.showpaperdoll:GetValue() then
        self.extraFrame:Hide()
        return
    end
    -- 获取信息并显示出来
    local itemLink = GetInventoryItemLink(InspectFrame and InspectFrame.unit, buttonID)
    local data = GetItemUseInfo(itemLink, buttonID)
    self.extraFrame.data = data["itemInfo"]
end

__SecureHook__ "PaperDollItemSlotButton_Update" __Async__()
function Hook_PaperDollItemSlotButton_Update(self)
    Next()
    -- 槽中没有物品则返回,如果self.extraFrame存在,则隐藏self.extraFrame
    local textureName = GetInventoryItemTexture("player", self:GetID());
    if not textureName then
        if self.extraFrame then
            self.extraFrame:Hide()
        end
        return
    end
    -- 如果为衬衫以及战袍则返回
    local buttonID = self:GetID()
    if buttonID == 4 or buttonID == 19 then
        return
    end
    -- 如果self.extraFrame不存在则创建self.extraFrame
    if not self.extraFrame then
        self.extraFrame = ButtonInfo(self:GetName() .. "Info", self)
        self.extraFrame:SetAllPoints()
    end
    -- 如果设置不显示则返回并隐藏self.extraFrame
    if not _Config.showpaperdoll:GetValue() then
        self.extraFrame:Hide()
        return
    end
    -- 获取信息并显示出来
    local itemLink = GetInventoryItemLink("player", buttonID)
    local data = GetItemUseInfo(itemLink, buttonID)
    self.extraFrame.data = data["itemInfo"]
end