--========================================================--
--           SEquipment UI Menu SetItemLevel              --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.SEquipment.SetItemLevel" ""
--========================================================--
L = _Locale

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

----------------------------
--        Function        --
----------------------------
-- PlayerPaperDollFrame
__SecureHook__()
function PaperDollItemSlotButton_OnShow(self)
    local itemLink = GetInventoryItemLink("player", self:GetID())
    Set_Per_Item_Level(self, itemLink, 1)
end

__SecureHook__()
function PaperDollItemSlotButton_OnEvent(self, event, id, ...)
    if (event == "PLAYER_EQUIPMENT_CHANGED" and self:GetID() == id) then
        local itemLink = GetInventoryItemLink("player", self:GetID())
        Set_Per_Item_Level(self, itemLink, 1)
    end
end

__SecureHook__()
function EquipmentFlyout_DisplayButton(self)
    if not self.location then return end
    local player, bank, bags, voidStorage, slot, bag = select(1, EquipmentManager_UnpackLocation(self.location))
    if (not player) and (not bank) and (not bags) and (not voidStorage) then
        return
    end
    if voidStorage then
        Set_Per_Item_Level(self, nil, 1)
    elseif bags then
        local itemLink = GetContainerItemLink(bag, slot)
        Set_Per_Item_Level(self, itemLink, 1)
    else
        local itemLink = GetInventoryItemLink("player", slot)
        Set_Per_Item_Level(self, itemLink, 1)
    end

end

-- TargetPaperDollFrame
__AddonSecureHook__ "Blizzard_InspectUI"
function InspectPaperDollItemSlotButton_Update(self)
    local itemLink = GetInventoryItemLink(InspectFrame.unit, self:GetID())
    Set_Per_Item_Level(self, itemLink, 2)
end

-- Bag
-- funtion
function Set_Per_Item_Level_For_Bag(self, number)
    for i = 1, self.size do
        local button   = _G[self:GetName() .. "Item" .. i]
        local itemlink = GetContainerItemLink(self:GetID(), button:GetID())
        Set_Per_Item_Level(button, itemlink, number)
    end
end

__SecureHook__()
function ContainerFrame_Update(self)
    if not self.size then
        return
    end
    if self:GetID() < 5 then
        Set_Per_Item_Level_For_Bag(self, 3)
    else
        Set_Per_Item_Level_For_Bag(self, 4)
    end
end

-- Bank
__SecureHook__()
function BankFrameItemButton_Update(self)
    if not self:GetName() then
        return
    end
    local itemlink = GetContainerItemLink(-1, self:GetID())
    Set_Per_Item_Level(self, itemlink, 4)
end

-- GuildBank
__Async__()
function OnEnable()
    if not IsAddOnLoaded("Blizzard_GuildBankUI") then
        while NextEvent("ADDON_LOADED") ~= "Blizzard_GuildBankUI" do end
    end
    if not _SVDB.IsLevelShow[5] then
        return
    end
    __SecureHook__(GuildBankFrame)
    function Update(self)
        local GUILDBANK_SLOTS_PER_TAB   = 98
        local GUILDBANK_SLOTS_PER_GROUP = 14
        local tabID                     = GetCurrentGuildBankTab()
        for i = 1, GUILDBANK_SLOTS_PER_TAB do
            local index = math.fmod(i, GUILDBANK_SLOTS_PER_GROUP)
            if index == 0 then
                index = GUILDBANK_SLOTS_PER_GROUP
            end
            local column   = math.ceil((i - 0.5) / GUILDBANK_SLOTS_PER_GROUP)
            local button   = self.Columns[column].Buttons[index]
            local itemLink = GetGuildBankItemLink(tabID, i)
            Set_Per_Item_Level(button, itemLink, 4)
        end
    end
end

-- Chat
local ChatMsgCaches = {}
local function InsertLevelMsg(msg)
    if (msg and type(msg) == "string") then
        local link = string.match(msg, "|H(item:%d+:.-)|h.-|h")
        if link then
            local level = ChatMsgCaches[link] or select(4, GetItemInfo(link))
            if level and tonumber(level) > 0 then
                ChatMsgCaches[link] = level
                msg = msg:gsub("(%|Hitem:%d+:.-%|h%[)(.-)(%]%|h)", "%1" .. level .. ":%2%3")
            end
        end
    end
    return msg
end

local function filter(self, event, msg, ...)
    if _SVDB and _SVDB.IsLevelShow[7] then
        msg = InsertLevelMsg(msg)
    end
    return false, msg, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filter)
-- GuildNew
local GuildNewsItemCache = {}
__SecureHook__()
function GuildNewsButton_SetText(button, font_color, text, text1, text2, ...)
    if (text2 and type(text2) == "string") and _SVDB.IsLevelShow[6] then
        local link = string.match(text2, "|H(item:%d+:.-)|h.-|h")
        if (link) then
            local level = GuildNewsItemCache[link] or select(4, GetItemInfo(link))
            if level and (tonumber(level) > 0) then
                GuildNewsItemCache[link] = level
                text2 = text2:gsub("(%|Hitem:%d+:.-%|h%[)(.-)(%]%|h)", "%1" .. level .. ":%2%3")
                button.text:SetFormattedText(text, text1, text2, ...)
            end
        end
    end
end

-- For BagAddons
-- LiteBag
if IsAddOnLoaded("LiteBag") then
    __SecureHook__()
    function LiteBagPanel_UpdateBag(self)
        if not self.size then
            return
        end
        if self:GetID() < 5 and self:GetID() ~= -1 then
            Set_Per_Item_Level_For_Bag(self, 3)
        else
            Set_Per_Item_Level_For_Bag(self, 4)
        end
    end
end
-- Bagnon
-- TinyInspect Code
__SystemEvent__()
function PLAYER_LOGIN()
    -- For Bagnon
    if (Bagnon and Bagnon.Item and Bagnon.Item.Update) then
        hooksecurefunc(Bagnon.Item, "Update", function(self)
            local itemLink = GetContainerItemLink(self:GetBag(), self:GetID())
            if self:GetBag() < 5 and self:GetBag() ~= -1 then
                Set_Per_Item_Level(self, itemLink, 3)
            else
                Set_Per_Item_Level(self, itemLink, 4)
            end
        end)
    elseif (Bagnon and Bagnon.ItemSlot and Bagnon.ItemSlot.Update) then
        hooksecurefunc(Bagnon.ItemSlot, "Update", function(self)
            local itemLink = GetContainerItemLink(self:GetBag(), self:GetID())
            if self:GetBag() < 5 and self:GetBag() ~= -1 then
                Set_Per_Item_Level(self, itemLink, 3)
            else
                Set_Per_Item_Level(self, itemLink, 4)
            end
        end)
    end
end

-- Combuctor
if IsAddOnLoaded("Combuctor") then
    __SecureHook__(Combuctor.Item)
    function Update(self)
        local itemLink = GetContainerItemLink(self:GetParent():GetID(), self:GetID())
        if self:GetParent():GetID() < 5 and self:GetParent():GetID() ~= -1 then
            Set_Per_Item_Level(self, itemLink, 3)
        else
            Set_Per_Item_Level(self, itemLink, 4)
        end
    end
end
-- ArkInventory,BagView,AdiBags
-- 该插件有自己的装等显示模块儿,我只需禁用自己的某些模块儿即可
if IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("BagView") or IsAddOnLoaded("AdiBags") then
    for i = 3, 5 do
        local child = GeneralFrame:GetChild("SecondFrame").ScrollChild:GetChild("widget" .. i)
        Style[child].checkbutton.Enabled = false
        Style[child].combobox.Toggle.Enabled = false
        Style[child].trackbar.Enabled = false
    end
end
