Scorpio "SEquipment.core.tooltip.handler" ""

local guids = {}
__SecureHook__ (GameTooltip, "ProcessInfo") __Async__()
function Hook_GameTooltip_ProcessInfo(self, info)
    Next()
    if not _Config.showtooltiplevel:GetValue() then return end
    if not info or not info.tooltipData then return end

    local guid = info.tooltipData.guid
    if not guid then return end
    if not C_PlayerInfo.GUIDIsPlayer(guid) then return end
    local _, unitId = self:GetUnit()
    if not unitId or guid ~= UnitGUID(unitId) then return end
    if not CanInspect(unitId) or not UnitIsVisible(unitId) then AddExtraLine(guid, "a/n") return end
    local data = guids[guid]
    if data and data.avgItemLevelEquipped > 0 then
        return AddExtraLine(guid, data.avgItemLevelEquipped, data.specName, data.argbHex)
    else
        data = {
            guid = guid,
            spec = nil,
            avgItemLevelEquipped = -1,
            argbHex = nil,
        }
        guids[guid] = data
    end
    AddExtraLine(guid, "...")
    Delay(1)
    -- 防止鼠标一闪而过也去NotifyInspect()占用请求资源
    if guid ~= UnitGUID("mouseover") then
        return
    end
    ClearInspectPlayer()
    NotifyInspect(unitId)
end
__SecureHook__ "NotifyInspect" __Async__()
function Hook_NotifyInspect(unitid)
    if not unitid or unitid == "" then
        return
    end
    local guid = UnitGUID(unitid)
    if not guid then
        return
    end
    local data = guids[guid]

    AddExtraLine(guid, "......")
    local inspectGuid = NextEvent("INSPECT_READY")
    if guid ~= inspectGuid or not data then return end

    local specID, specName, classFile, icon, className, argbHex  = GetUnitSpec(unitid)
    local avgItemLevelEquipped  = C_PaperDollInfo.GetInspectItemLevel(unitid)
    data.avgItemLevelEquipped   = avgItemLevelEquipped
    data.specName               = specName or className or ""
    data.argbHex                = argbHex
    data.guid                   = guid

    if data.guid == UnitGUID("mouseover") then
        AddExtraLine(guid, avgItemLevelEquipped, specName, argbHex)
    end
end