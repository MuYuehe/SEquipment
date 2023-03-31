Scorpio "SEquipment.core.unit.handler" ""
--======================--
-- Specialized Func
--======================--
function Make_Per_ItemFrame(slotID, itemLink, unit, parent)
	local perSlotFrame = PerSlotFrame(unit .. "Slot" .. slotID, parent)
	perSlotFrame.data = GetItemUseInfo(itemLink, slotID, unit)
end
--======================--
-- 初始化预加载 --
--======================--
function OnEnable()
	-- Player 初始化
	PlayerInfoFrame = UnitInfoFrame("PlayerInfoFrame", PaperDollFrame)
	PlayerStatsInfoFrame = StatsInfoFrame("PlayerStatsInfoFrame", PlayerInfoFrame)
	PlayerTileFrame = TitleFrame("PlayerTileFrame", PlayerInfoFrame)
	for i = 1, 17, 1 do
		Make_Per_ItemFrame(i, nil, "player", PlayerInfoFrame)
	end
	-- Target 初始化
	TargetInfoFrame = UnitInfoFrame("TargetInfoFrame")
	TargetTileFrame = TitleFrame("TargetTileFrame", TargetInfoFrame)
	for i = 1, 17, 1 do
		Make_Per_ItemFrame(i, nil, "target", TargetInfoFrame)
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
-- target
--======================--
__SystemEvent__ "INSPECT_READY"
function EVENT_INSPECT_READY(guid)
	if not (InspectFrame and InspectFrame.unit and UnitGUID(InspectFrame.unit) == guid) then
		return
	end
	-- 获取InspectFrame的unit
	local unit = InspectFrame.unit
	-- 获取unit的class以及平均等级
	local argbHex, specName = GettUnitColor(unit), GetUnitSpec(unit)
	local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unit)
	TargetTileFrame.unitInfo = string.format("%s%s%d", argbHex, specName, floor(avgItemLevelEquipped))
	-- TargetInfoFrame设置parent,如果已经设置了不再继续
	if TargetInfoFrame:GetParent() == InspectFrame then
		return
	end
	TargetInfoFrame:SetParent(InspectFrame)
	TargetInfoFrame:SetPoint("TOPLEFT", InspectFrame, "TOPRIGHT", -3, 0)
end
--======================--
-- 大统一了
--======================--
__SecureHook__ "SetItemButtonQuality" __Async__()
function Hook_SetItemButtonQuality(self, quality, itemLink, ...)
	Next()
	
	if self.isBag then return end

	local slotID = self:GetID()
	if slotID == 4 or slotID == 19 then return end

	local containerName = self:GetParent():GetName()
	if string.find(containerName, "PaperDoll") and (not string.find(containerName, "Inspect")) then
		Make_Per_ItemFrame(slotID, GetInventoryItemLink("player", slotID), "player", PlayerInfoFrame)
		return
	end

	if string.find(containerName, "InspectPaperDoll") then
		Make_Per_ItemFrame(slotID, GetInventoryItemLink(InspectFrame and InspectFrame.unit, slotID), "target", TargetInfoFrame)
		return
	end
end

-- 结果还是要另行处理(希望找到下一个完美hook)
__AddonSecureHook__ ("Blizzard_InspectUI", "InspectPaperDollItemSlotButton_Update")
function Hook_InspectPaperDollItemSlotButton_Update(self)
    if not self.hasItem  then
        Make_Per_ItemFrame(self:GetID(), nil, "target", TargetInfoFrame)
    end
end