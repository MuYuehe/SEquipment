Scorpio "SEquipment.core.unit.handler" ""
--======================--
-- Specialized Func
--======================--
local function Make_Per_ItemFrame(slotID, itemLink, unit, parent)
	local extraFrame = PerSlotFrame(unit .. "ExtraInfo" .. slotID, parent)
	extraFrame.data = GetItemUseInfo(itemLink, slotID, unit)
end
--======================--
-- 初始化预加载 --
--======================--
__Async__()
function OnEnable(self)
	-- Player 初始化
	PlayerInfoFrame = UnitInfoFrame("PlayerInfoFrame", PaperDollFrame)
	PlayerStatsInfoFrame = StatsInfoFrame("PlayerStatsInfoFrame", PlayerInfoFrame)
	PlayerTileFrame = TitleFrame("PlayerTileFrame", PlayerInfoFrame)
	-- Target 初始化
	TargetInfoFrame = UnitInfoFrame("TargetInfoFrame")
	TargetTileFrame = TitleFrame("TargetTileFrame", TargetInfoFrame)
	for i = 1, 17, 1 do
		Make_Per_ItemFrame(i, nil, "player", PlayerInfoFrame)
		Make_Per_ItemFrame(i, nil, "target", TargetInfoFrame)
	end

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
	-- __Async__()
	function LocalInspectFrame:OnShow()
		-- Delay(1)
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
	local argbHex, specName = GettUnitColor(unit), GetUnitSpec(unit)
	local avgItemLevel, avgItemLevelEquipped = GetAverageItemLevel()
	PlayerTileFrame.unitInfo = string.format("%s%s%d(%d)", argbHex, specName, floor(avgItemLevelEquipped),floor(avgItemLevel))
end
--======================--
-- Action
--======================--
local targetTitleInfo = {}
__AddonSecureHook__ ("Blizzard_InspectUI", "InspectPaperDollItemSlotButton_Update") __Async__()
function Hook_InspectPaperDollItemSlotButton_Update(self)
	Next()
	local slotID = self:GetID()
	if slotID == 4 or slotID == 19 then
		return
	end
	-- 获取平均装等以及天赋(只执行一次)
	if not targetTitleInfo.guid or targetTitleInfo.guid ~= UnitGUID( InspectFrame and InspectFrame.unit) then
		local unit = InspectFrame.unit
		targetTitleInfo.guid = UnitGUID(unit)
		local argbHex, specName = GettUnitColor(unit), GetUnitSpec(unit)
		local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unit)

		TargetTileFrame.unitInfo = string.format("%s%s%d", argbHex, specName, floor(avgItemLevelEquipped))
		if TargetInfoFrame:GetParent() == InspectFrame then
			return
		end
		TargetInfoFrame:SetParent(InspectFrame)
		TargetInfoFrame:SetPoint("TOPLEFT", InspectFrame, "TOPRIGHT", -3, 0)
	end

	local itemLink = GetInventoryItemLink(InspectFrame and InspectFrame.unit, slotID)
	Make_Per_ItemFrame(slotID, itemLink, "target", TargetInfoFrame)
end

__SecureHook__ "PaperDollItemSlotButton_Update" __Async__()
function Hook_PaperDollItemSlotButton_Update(self)
	Next()
	if self.isBag then return end
	local slotID = self:GetID()
	if slotID == 4 or slotID == 19 then
		return
	end

	local itemLink = GetInventoryItemLink("player", slotID)
	Make_Per_ItemFrame(slotID, itemLink, "player", PlayerInfoFrame)
end