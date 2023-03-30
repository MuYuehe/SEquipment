Scorpio "SEquipment.core.tooltip.handler" ""

local guids = {}

__SecureHook__ (GameTooltip, "ProcessInfo")
function Hook_GameTooltip_ProcessInfo(self, info)

    if not _Config.showtooltiplevel:GetValue() then return end
    if not info or not info.tooltipData then return end

    local _, unitId = self:GetUnit()
    local guid = info.tooltipData.guid
    if not unitId or UnitGUID(unitId) ~= guid or (not C_PlayerInfo.GUIDIsPlayer(guid)) then return end

    local data = guids[guid]
    local avgItemLevelEquipped, specName

    if data then
        avgItemLevelEquipped = data.avgItemLevelEquipped
        specName = data.specName
        AddExtraLine(guid, avgItemLevelEquipped, specName)
    else
        AddExtraLine(guid, "n/a", "...")
    end

    NotifyInspect(unitId)
end

__SystemEvent__ "INSPECT_READY"
function EVENT_INSPECT_READY(guid)

    if guid ~= UnitGUID("mouseover") then return end

    local unitToken = UnitTokenFromGUID(guid)
    local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unitToken)
    local specID, specName = GetInspectSpecialization(unitToken), ""
    if specID and specID > 0 then
        specName = select(2, GetSpecializationInfoByID(specID))
    end
    AddExtraLine(guid, avgItemLevelEquipped, specName)

    local data = guids[guid]
    if data then
        data.avgItemLevelEquipped = avgItemLevelEquipped
        data.specName = specName
    else
        data = {
            avgItemLevelEquipped    = avgItemLevelEquipped,
            specName                = specName,
        }
        guids[guid] = data
    end
end