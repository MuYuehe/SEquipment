Scorpio "SEquipment.core.tooltip.handler" ""

local guids = {}
__SecureHook__ (GameTooltip, "ProcessInfo") __Async__()
function Hook_GameTooltip_ProcessInfo(self, info)

    if not _Config.showtooltiplevel:GetValue() then return end
    if not info or not info.tooltipData then return end

    local guid = info.tooltipData.guid
    if not guid then return end
    if not C_PlayerInfo.GUIDIsPlayer(guid) then return end
    local _, unitId = self:GetUnit()
    if not unitId or guid ~= UnitGUID(unitId) then return end
    local data = guids[guid]
    if data and data.avgItemLevelEquipped > 0 then
        return AddExtraLine(guid, data.avgItemLevelEquipped, data.specName, data.argbHex)
    end
    if not CanInspect(unitId) or not UnitIsVisible(unitId) then return end

    AddExtraLine(guid, "...")
    Delay(1)
    if guid ~= UnitGUID("mouseover") then
        return
    end
    ClearInspectPlayer()
    NotifyInspect(unitId)
end
__SecureHook__ "NotifyInspect" __Async__()
function Hook_NotifyInspect(unitid)
    if not unitid or not UnitGUID(unitid) then
        return
    end
    local guid = UnitGUID(unitid)
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
    AddExtraLine(guid, "......")
    local inspectGuid = NextEvent("INSPECT_READY")
    if guid ~= inspectGuid then return end

    local specName = GetUnitSpec(unitid)
    local argbHex = GettUnitColor(unitid)
    local avgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unitid)
    data.avgItemLevelEquipped = avgItemLevelEquipped
    data.specName = specName
    data.argbHex = argbHex
    data.guid = guid

    if data.guid == UnitGUID("mouseover") then
        AddExtraLine(data.guid, data.avgItemLevelEquipped, data.specName, data.argbHex)
    end
end