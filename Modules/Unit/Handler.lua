Scorpio "SEquipment.core.unit.handler" ""

--======================--
-- Player
--======================--
local isFlushInHide = true --是否在characterframe隐藏的时候触发PLAYER_EQUIPMENT_CHANGED
local PlayerInfoFrame = UnitMainFrame("PlayerInfoFrame", CharacterFrame)
local PlayerStatsInfoFrame = UnitStatsFrame("PlayerStatsInfoFrame", PlayerInfoFrame)
for i = 1, 17, 1 do
	if i ~= 4 then
		local itemInfoFrame = ItemInfoFrame("playerItemInfo" .. i, PlayerInfoFrame)
		itemInfoFrame.data = GetItemUseInfo(nil, i, "player")
	end
end
local LocalCharacterFrame = GetWrapperUI(CharacterFrame)
function LocalCharacterFrame:OnShow()
	for i = 1, 17, 1 do
		if not isFlushInHide then break end
		if i ~= 4 then
			local itemLink = GetInventoryItemLink("player", i)
			local itemInfoFrame = ItemInfoFrame("playerItemInfo" .. i, PlayerInfoFrame)
			itemInfoFrame.data = GetItemUseInfo(itemLink, i, "player")
		end
	end
	isFlushInHide = false
	PlayerInfoFrame:Show()
end
function LocalCharacterFrame:OnHide()
	PlayerInfoFrame:Hide()
end
__SystemEvent__ "PLAYER_EQUIPMENT_CHANGED" __Async__()
function EVENT_PLAYER_EQUIPMENT_CHANGED(slotID, hasCurrent)
	Next()
	if slotID == 4 or slotID == 19 then return end
	if not CharacterFrame:IsShown() then isFlushInHide = true end

	local itemLink = GetInventoryItemLink("player", slotID)
	local itemInfoFrame = ItemInfoFrame("playerItemInfo" .. slotID, PlayerInfoFrame)
	itemInfoFrame.data = GetItemUseInfo(itemLink, slotID, "player")
end
-- 获取自身绿字属性
__SecureHook__ "PaperDollFrame_UpdateStats" __Async__()
function Hook_PaperDollFrame_UpdateStats()
	Next()
	PlayerStatsInfoFrame.crit 		= { P_GetCritChance("player") }
	PlayerStatsInfoFrame.haste 		= { P_GetHaste("player") }
	PlayerStatsInfoFrame.versa 		= { P_GetVersa("player") }
	PlayerStatsInfoFrame.mastery 	= { P_GetMastery("player") }
end
-- 自身获取专精/平均等级/最大等级
__SecureHook__ "PaperDollFrame_SetItemLevel"
function Hook_PaperDollFrame_SetItemLevel(statFrame, unit)
	local specID, specName, classFile, specIcon, className, argbHex = GetUnitSpec(unit)
	local _, avgItemLevelEquipped = GetAverageItemLevel()
	local data = {
		["avgItemLevel"] 	= argbHex .. floor(avgItemLevelEquipped),
		["specIcon"] 		= specIcon or classFile or "",
	}
	PlayerInfoFrame.data = data
end
--======================--
-- Target
--======================--
local TargetInfoFrame = UnitMainFrame("TargetInfoFrame")
--=========Init========--
for i = 1, 17, 1 do
	if i ~= 4 then
		local itemInfoFrame = ItemInfoFrame("targetItemInfo" .. i, TargetInfoFrame)
		itemInfoFrame.data = GetItemUseInfo(nil, i, "target")
	end
end
__Async__()
function OnEnable(self)
	--=========Target========--
	if not IsAddOnLoaded("Blizzard_InspectUI") then
        -- 循环等待只到目标插件加载
        while NextEvent("ADDON_LOADED") ~= "Blizzard_InspectUI" do end
    end
    -- 开始初始化
	TargetInfoFrame:SetParent(InspectFrame)
	TargetInfoFrame:SetPoint("TOPLEFT", InspectFrame, "TOPRIGHT", 0, 0)
	local LocalInspectFrame = GetWrapperUI(InspectFrame)

	function LocalInspectFrame:OnShow()
		if InspectFrame and InspectFrame.unit then
			local unit = InspectFrame.unit
			local specID, specName, classFile, specIcon, className, argbHex = GetUnitSpec(unit)
			local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unit)
			local data = {
				["avgItemLevel"] = argbHex .. floor(avgItemLevelEquipped),
				["specIcon"] = specIcon or classFile or "",
			}
			TargetInfoFrame.data = data
		end
		TargetInfoFrame:Show()
	end
	function LocalInspectFrame:OnHide()
		TargetInfoFrame:Hide()
	end
end
__AddonSecureHook__ ("Blizzard_InspectUI", "InspectPaperDollItemSlotButton_Update") __Async__()
function Hook_InspectPaperDollItemSlotButton_Update(self)
	Next()
	local slotID = self:GetID()
	if not (InspectFrame and InspectFrame.unit) then return end
	if slotID == 4 or slotID >= 19 then return end

	local unit = InspectFrame.unit
	local itemLink = GetInventoryItemLink(unit, slotID)
	local itemInfoFrame = ItemInfoFrame("targetItemInfo" .. slotID, TargetInfoFrame)
	itemInfoFrame.data = GetItemUseInfo(itemLink, slotID, "target")
end