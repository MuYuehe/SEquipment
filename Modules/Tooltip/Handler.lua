Scorpio "SEquipment.core.tooltip.handler" ""

local guids = {}

__SecureHook__ (GameTooltip, "ProcessInfo")
function Hook_GameTooltip_ProcessInfo(self, info)

    if not _Config.showtooltiplevel:GetValue() then return end
    if not info or not info.tooltipData then return end

    local guid = info.tooltipData.guid
    if not guid then return end
    local _, unitId = self:GetUnit()
    if not unitId or guid ~= UnitGUID(unitId) then return end

    local data = guids[guid]
    if data and data.avgItemLevelEquipped > 0 then
        return AddExtraLine(guid, data.avgItemLevelEquipped, data.specName, data.argbHex)
    end
    if not CanInspect(unitId) or not UnitIsVisible(unitId) then return end

    ClearInspectPlayer()
    NotifyInspect(unitId)
    AddExtraLine(guid, "...")
end

__SecureHook__ "NotifyInspect"
function Hook_NotifyInspect(unitid)
    local guid = UnitGUID(unitid)
    if not guid then
        return
    end
    local data = guids[guid]
    if not data then
        data = {
            guid = guid,
            spec = nil,
            avgItemLevelEquipped = -1,
            argbHex = nil,
        }
        guids[guid] = data
    end
end

__SystemEvent__ "INSPECT_READY" __Async__()
function EVENT_INSPECT_READY(guid)
    if (not guids[guid]) then return end

    local data = guids[guid]
    local unitId = UnitTokenFromGUID(guid)
    local specName = GetUnitSpec(unitId)
    local argbHex = GettUnitColor(unitId)
    local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unitId)

    data.avgItemLevelEquipped = avgItemLevelEquipped
    data.specName = specName
    data.argbHex = argbHex
    data.guid = guid

    FireSystemEvent("INSPECT_READY_END", data)
end

__SystemEvent__ "INSPECT_READY_END"
function EVENT_INSPECT_READY_END(data)
    if data.guid == UnitGUID("mouseover") then
        AddExtraLine(data.guid, data.avgItemLevelEquipped, data.specName, data.argbHex)
    end
end