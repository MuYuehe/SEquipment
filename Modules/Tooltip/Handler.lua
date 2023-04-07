Scorpio "SEquipment.core.tooltip.handler" ""

local guids = { ["time"] = time(), ["times"] = 0 }
__SecureHook__ (GameTooltip, "ProcessInfo") __Async__()
function Hook_GameTooltip_ProcessInfo(self, info)
    Next()
    if not _Config.showtooltiplevel:GetValue() then return end
    if not info or not info.tooltipData or not info.tooltipData.guid then return end

    local guid = info.tooltipData.guid
    if not C_PlayerInfo.GUIDIsPlayer(guid) then return end
    local _, unit = self:GetUnit()
    if not unit or unit == "" or guid ~= UnitGUID(unit) then return end
    if not CanInspect(unit) or not UnitIsVisible(unit) then return end
    local data = guids[guid]
    if data and data.avgLevel > 0 and time() - data["time"] < 600 then
        return AddExtraLine(guid, data.avgLevel, data.specName, data.argbHex)
    end
    AddExtraLine(guid, "...")

    if time() - guids["time"] < 600 and guids["times"] > 6 then
        return AddExtraLine(guid, "a/n")
    end

    Delay(1)
    -- 防止鼠标一闪而过也去NotifyInspect()占用请求资源
    if guid ~= UnitGUID("mouseover") then
        return
    end
    ClearInspectPlayer()
    NotifyInspect(unit)
end
__SecureHook__ "NotifyInspect" __Async__()
function Hook_NotifyInspect(unit)
    if not unit or unit == "" then
        return
    end

    local guid = UnitGUID(unit)
    if not guid then return end --好像确实会返回nil啊,谨慎一点
    -- local data = guids[guid]
    if not guids[guid] then
        guids[guid] = {
            ["guid"]        = guid,
            ["spec"]        = nil,
            ["avgLevel"]    = -1,
            ["argbHex"]     = nil,
            ["time"]        = time(), --TODO
        }
    end
    AddExtraLine(guid, "......")
    local inspectGUID = NextEvent("INSPECT_READY")
    if time() - guids["time"] > 600 and not (InspectFrame and InspectFrame:IsShown()) then
        guids["time"] = time()
        guids["times"]= 1
    end
    guids["times"] = guids["times"] + 1

    if guid ~= inspectGUID then return end

    local specID, specName, classFile, icon, className, argbHex  = GetUnitSpec(unit)
    local avgLevel  = C_PaperDollInfo.GetInspectItemLevel(unit)
    guids[guid] = {
        ["guid"]        = guid,
        ["spec"]        = specName,
        ["avgLevel"]    = avgLevel,
        ["argbHex"]     = argbHex,
        ["time"]        = time(), --TODO
    }
    if guid == UnitGUID("mouseover") then
        AddExtraLine(guid, avgLevel, specName, argbHex)
    end
end