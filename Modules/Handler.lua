Scorpio "SEquipment.core.handler" ""

------------------------------------------------------
-- Specialized Func
------------------------------------------------------
local function Make_Per_ItemFrame(slotID,itemLink, unit,parent)

	local table = { slotID = slotID }
	if itemLink then
		table = P_GetItemFrame_Per(itemLink,slotID)
	end
	table["unit"] = unit
	local perSlotFrame = PerSlotFrame(unit .. "Slot" .. slotID, parent)
	perSlotFrame.data = table
end
-- =========== --
-- 初始化预加载 --
-- =========== --
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

__SecureHook__ "PaperDollFrame_UpdateStats" __Async__()
function Hook_PaperDollFrame_UpdateStats()
	Next()

	PlayerStatsInfoFrame.critData = {P_GetCritChance("player")}
	PlayerStatsInfoFrame.hasteData = {P_GetHaste("player")}
	PlayerStatsInfoFrame.versaData = {P_GetVersa("player")}
	PlayerStatsInfoFrame.masteryData = {P_GetMastery("player")}
end

-- 包装
PaperDollFrame = GetWrapperUI(PaperDollFrame)
function PaperDollFrame:OnShow()
	for i = 1, 17, 1 do
		local itemLink = GetInventoryItemLink("player", i)
		Make_Per_ItemFrame(i, itemLink, "player", PlayerInfoFrame)
	end
end

__SystemEvent__ "PLAYER_EQUIPMENT_CHANGED" __Async__()
function EVENT_PLAYER_EQUIPMENT_CHANGED(slotId)
	Next()
	local itemLink = GetInventoryItemLink("player", slotId)
	Make_Per_ItemFrame(slotId, itemLink, "player", PlayerInfoFrame)
end

-- target
local inspectUnit = ""
__SystemEvent__ "INSPECT_READY"
function EVENT_INSPECT_READY(guid)
	if not (InspectFrame and InspectFrame.unit and UnitGUID(InspectFrame.unit) == guid) then
		return
	end

	inspectUnit = InspectFrame.unit

	local id = GetInspectSpecialization(inspectUnit)
	local className, classFilename = UnitClass(inspectUnit)
	local argbHex = select(4,GetClassColor(classFilename))
	if id ~= 0 then
		className = select(2, GetSpecializationInfoByID(id))
	end
	local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(inspectUnit);
	TargetTileFrame.unitInfo = string.format("|c%s%s%d", argbHex, className, floor(avgItemLevelEquipped))

	if TargetInfoFrame:GetParent() == InspectFrame then
		return
	end
	TargetInfoFrame:SetParent(InspectFrame)
	TargetInfoFrame:SetPoint("TOPLEFT", InspectFrame, "TOPRIGHT", -3, 0)
end

__AddonSecureHook__  ("Blizzard_InspectUI","InspectPaperDollItemSlotButton_Update")
function Hook_InspectPaperDollItemSlotButton_Update(button)
	if inspectUnit == "" then
		return
	end
	local slotID = button:GetID()
	if slotID == 4 or slotID == 19 then return end
	local itemLink = GetInventoryItemLink(inspectUnit, slotID)

	Make_Per_ItemFrame(slotID, itemLink, "target", TargetInfoFrame)
end

-- 自身获取专精/平均等级/最大等级
__SecureHook__ "PaperDollFrame_SetItemLevel"
function Hook_PaperDollFrame_SetItemLevel(statFrame, unit)
	local id = GetInspectSpecialization(unit)
	local className, classFilename = UnitClass(unit)
	local argbHex = select(4,GetClassColor(classFilename))
	if id ~= 0 then
		className = select(2, GetSpecializationInfoByID(id))
	end
	local avgItemLevel, avgItemLevelEquipped, avgItemLevelPvP = GetAverageItemLevel();
	PlayerTileFrame.unitInfo = string.format("|c%s%s%d(%d)", argbHex, className, floor(avgItemLevelEquipped),floor(avgItemLevel))
end