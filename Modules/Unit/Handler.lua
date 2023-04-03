Scorpio "SEquipment.core.unit.handler" ""
--======================--
-- Specialized Func
--======================--
local function GetPerItemData(slotID, itemLink, unit, parent)
	local extraFrame = PerSlotFrame(unit .. "ExtraInfo" .. slotID, parent)
	extraFrame.data = GetItemUseInfo(itemLink, slotID, unit)
end
--======================--
-- 初始化预加载 --
--======================--
__Async__()
function OnEnable(self)
	--========Player========--
	PlayerInfoFrame = UnitInfoFrame("PlayerInfoFrame")
	PlayerStatsInfoFrame = StatsInfoFrame("PlayerStatsInfoFrame", PlayerInfoFrame)
	--=========Target========--
	TargetInfoFrame = UnitInfoFrame("TargetInfoFrame")
	--=========Init========--
	for i = 1, 17, 1 do
		GetPerItemData(i, nil, "player", PlayerInfoFrame)
		GetPerItemData(i, nil, "target", TargetInfoFrame)
	end
	--========Player========--
	LocalCharacterFrame = GetWrapperUI(CharacterFrame)
	function LocalCharacterFrame:OnShow()
		if PlayerInfoFrame:GetParent() ~= PaperDollFrame then
			PlayerInfoFrame:SetParent(PaperDollFrame)
			PlayerInfoFrame:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT", -3, 0)
		end
		PlayerInfoFrame:Show()
	end
	function LocalCharacterFrame:OnHide()
		PlayerInfoFrame:Hide()
	end
	--=========Target========--
	if not IsAddOnLoaded("Blizzard_InspectUI") then
        -- 循环等待只到目标插件加载
        while NextEvent("ADDON_LOADED") ~= "Blizzard_InspectUI" do end
    end
    -- 开始初始化
	if TargetInfoFrame:GetParent() ~= InspectFrame then
		TargetInfoFrame:SetParent(InspectFrame)
		TargetInfoFrame:SetPoint("TOPLEFT", InspectFrame, "TOPRIGHT", -3, 0)
	end
	LocalInspectFrame = GetWrapperUI(InspectFrame)
	function LocalInspectFrame:OnHide()
		TargetInfoFrame:Hide()
	end
	function LocalInspectFrame:OnShow()
		if InspectFrame and InspectFrame.unit then
			local unit = InspectFrame.unit
			local specID, specName, classFile, specIcon, className, argbHex = GetUnitSpec(unit)
			local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unit)
			local data = {}
			data["avgItemLevel"] = argbHex .. floor(avgItemLevelEquipped)
			data["specIcon"] = specIcon or classFile or ""
			TargetInfoFrame.data = data
		end
		TargetInfoFrame:Show()
	end
end
--======================--
-- self
--======================--
-- 获取自身绿字属性
__SecureHook__ "PaperDollFrame_UpdateStats" __Async__()
function Hook_PaperDollFrame_UpdateStats()
	Next()
	PlayerStatsInfoFrame.critData 		= { P_GetCritChance("player") }
	PlayerStatsInfoFrame.hasteData 		= { P_GetHaste("player") }
	PlayerStatsInfoFrame.versaData 		= { P_GetVersa("player") }
	PlayerStatsInfoFrame.masteryData 	= { P_GetMastery("player") }
end
-- 自身获取专精/平均等级/最大等级
__SecureHook__ "PaperDollFrame_SetItemLevel"
function Hook_PaperDollFrame_SetItemLevel(statFrame, unit)
	local specID, specName, classFile, specIcon, className, argbHex = GetUnitSpec(unit)
	local _, avgItemLevelEquipped = GetAverageItemLevel()
	local data = {}
	data["avgItemLevel"] = argbHex .. floor(avgItemLevelEquipped)
	data["specIcon"] = specIcon or classFile or ""
	PlayerInfoFrame.data = data
end
--======================--
-- Action
--======================--
__AddonSecureHook__ ("Blizzard_InspectUI", "InspectPaperDollItemSlotButton_Update") __Async__()
function Hook_InspectPaperDollItemSlotButton_Update(self)
	Next()
	local slotID = self:GetID()
	if not (InspectFrame and InspectFrame.unit) then return end
	if slotID == 4 or slotID == 19 then return end

	local unit = InspectFrame.unit
	local itemLink = GetInventoryItemLink(unit, slotID)
	GetPerItemData(slotID, itemLink, "target", TargetInfoFrame)
end

__SecureHook__ "PaperDollItemSlotButton_Update" __Async__()
function Hook_PaperDollItemSlotButton_Update(self)
	Next()
	local slotID = self:GetID()
	if self.isBag or slotID == 4 or slotID == 19 then return end

	local itemLink = GetInventoryItemLink("player", slotID)
	GetPerItemData(slotID, itemLink, "player", PlayerInfoFrame)
end