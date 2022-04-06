--========================================================--
--           SEquipment ListFrame Target Config           --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.MainInterface.TargetListFrame.Config" ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                     TargetConfig                      --
-----------------------------------------------------------

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

----------------------------
--          Event         --
----------------------------
__SystemEvent__()
function ADDON_LOADED(addon)
    if addon == "Blizzard_InspectUI" then
        TargetScanFrame:SetParent(InspectPaperDollFrame)
        Style[TargetScanFrame]                  = {
            location                            = { Anchor("TOPLEFT",0,0,"InspectPaperDollFrame","TOPRIGHT")},
        }
    end
end
__Async__()
function OnEnable()
    while Wait("INSPECT_READY") do
        Next()
        
        local EquipInfo,EquipNameMaxLongm,EquipedGemInfo,EquipedGemNumber
        local EachEquipInfo,CritNumber,HasteNumber,MasteryNumber,VersaNumber,NullGemNumber,SetEquipNumber
        EquipInfo                                                                       = GetEquipInfo("target")
        -- print(#EquipInfo)
        EquipNameMaxLong = GetNameLongMax(EquipInfo)
        EquipedGemInfo,EquipedGemNumber                                                 = GetEquipedGemInfo(EquipInfo)
        SpecInfo = GetSpecInfo("target")
        AvgItemLevelEquiped = GetAvgItemLevelEquiped("target")
        EachEquipInfo,CritNumber,HasteNumber,MasteryNumber,VersaNumber,NullGemNumber,SetEquipNumber    = GetEachEquipInfo("target")
        StatsNumberList                                                                 ={
                                                                                            CritNumber,
                                                                                            HasteNumber,
                                                                                            MasteryNumber,
                                                                                            VersaNumber,
                                                                                        }
        UpdateListFrame(EquipNameMaxLong,EquipInfo)
        SEUpdateEquipList(EquipInfo,EachEquipInfo,EquipedGemNumber,NullGemNumber,StatsNumberList,SetEquipNumber)
        SEUpdateTalentList(SpecInfo)
        SEUpdateAvgLevel(AvgItemLevelEquiped)
        TargetScanFrame:Show()
    end
end

__AddonSecureHook__ "Blizzard_InspectUI"
function HideUIPanel(frame, skipSetPoint)
    if frame == InspectFrame then
        UpdateListFrame(0,{})
        TargetScanFrame:Hide()
    end
end

---------------------------
--     TargetSetting     --
---------------------------
function SEUpdateTalentList(spec)
    Style[TargetHeaderRightFont]                        = {
        text                                            = spec[2],
    }
end

function SEUpdateAvgLevel(avg)
    Style[TargetHeaderLeftFont]                         = {
        text                                            = tostring(avg),
    }
end

function SEUpdateEquipList(equipinfo,eachequipinfo,equipgemnumber,nullgemnumber,statsnumberlist,setequipumber)
    -- 更新装备列表
    local children = {TargetStatsIconFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            local child = {value:GetChildren()}
            for i, v in ipairs(child) do
                if eachequipinfo[index][i] == 0 then
                    v:Hide()
                else
                    v:Show()
                end
            end
            value:Show()
        else
            value:Hide()
        end
    end
    children = {TargetEquipPartFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            Style[value]                        = {
                ["TargetEquipPartText"..index]  = {
                    text                        = eachequipinfo[index][7],
                }
            }
            value:Show()
        else
            value:Hide()
        end
    end
    children = {TargetEquipLevelFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            Style[value]                        = {
                ["TargetEquipLevelText"..index] = {
                    text                        = tostring(eachequipinfo[index][5]),
                }
            }
            value:Show()
        else
            value:Hide()
        end
    end
    children = {TargetEquipNameFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            Style[value]                        = {
                width                           = 6*(#(equipinfo[index][1])),
                ["TargetEquipNameText"..index]  = {
                    text                        = (equipinfo[index][2]),
                }
            }
            value:Show()
            -- 添加宝石显示(如果有的话)
            local child = value:GetChildren()
            if eachequipinfo[index][6] then
                Style[child]                    = {
                    location                    = { Anchor("LEFT",6*(#(equipinfo[index][1])),0)}
                }
                child:Show()
            else
                child:Hide()
            end
            -- 添加Tooltip处理
            value:SetScript("OnEnter",function (self)
                GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
                GameTooltip:SetInventoryItem("target",eachequipinfo[index][8])
                GameTooltip:Show()
            end)
            value:SetScript("OnLeave",function (self)
                GameTooltip:Hide()
            end)
        else
            value:Hide()
        end
    end
    -- 更新宝石信息
    if setequipumber >= 2 and setequipumber < 4 then
    Style[TargetGemInfoText]                            = {
        text                                            ="宝石:".." "..equipgemnumber.."/"..(equipgemnumber+nullgemnumber).."    圣墓两件套"
    }
    elseif setequipumber >= 4 then
    Style[TargetGemInfoText]                            = {
        text                                            ="宝石:".." "..equipgemnumber.."/"..(equipgemnumber+nullgemnumber).."    圣墓四件套"
    }
    elseif setequipumber < 2 then
    Style[TargetGemInfoText]                            = {
        text                                            ="宝石:".." "..equipgemnumber.."/"..(equipgemnumber+nullgemnumber).."    无套装"
    }
    end
    -- 更新属性数字信息
    children = {TargetStatsNumberList:GetChildren()}
    for index, value in ipairs(children) do
        Style[value]                                    = {
            ["TargetStatsNumberText"..index]            = {
                text                                    = tostring(statsnumberlist[index]),
            }
        }
    end
    children = {TargetStatsPercentList:GetChildren()}
    for index, value in ipairs(children) do
        Style[value]                                    = {
            ["TargetStatsPercentText"..index]           = {
                text                                    = GetStatsPercent(statsnumberlist[index],index,"target",SpecInfo),
            }
        }
    end
end
-- 这里是更新框体大小的
function UpdateListFrame(equipnamemaxlong,equipinfo)
    -- 确定TargetScanFrame/TargetHeaderFrame的宽度
    local children = {TargetEquipNameFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if #equipinfo == 0 then
            Style[value]                                = {
                width                                   = 1
            }
        else
            Style[value]                                = {
                width                                   = 6*(#(equipinfo[index][1]))
            }
        end
        
        if index == #equipinfo then
            break
        end
    end
    Style[TargetEquipNameFrameList]                     = {
        width                                           = 6*equipnamemaxlong,
        height                                          = (#equipinfo)*18,
    }
    Style[TargetStatsIconFrameList]                     = {
        height                                          = (#equipinfo)*18,
    }
    Style[TargetEquipPartFrameList]                     = {
        height                                          = (#equipinfo)*18,
    }
    Style[TargetEquipLevelFrameList]                    = {
        height                                          = (#equipinfo)*18,
    }
    Style[TargetEquipListFrame]                         = {
        width                                           = TargetStatsIconFrameList:GetWidth()+TargetEquipPartFrameList:GetWidth()
                                                            +TargetEquipLevelFrameList:GetWidth()+TargetEquipNameFrameList:GetWidth(),
        height                                          = (#equipinfo)*18,
    }
    if #equipinfo == 0 then
        Style[TargetEquipListFrame]                     = {
            height                                      = 1,
        }
    end
    -- TargetHeaderFrame的宽度
    if TargetEquipNameFrameList:GetWidth() > 6 then
        Style[TargetHeaderFrame]                        = {
            width                                       = TargetEquipListFrame:GetWidth(),
        }
    else
        Style[TargetHeaderFrame]                        = {
            width                                       = 250,
        }
    end
    -- TargetScanFrame的宽度
    if TargetEquipNameFrameList:GetWidth() > 6 then
        Style[TargetScanFrame]                          = {
            width                                       = TargetEquipListFrame:GetWidth()+15,
            height                                      = TargetHeaderFrame:GetHeight()+TargetEquipListFrame:GetHeight()
                                                            +TargetGemInfoFrame:GetHeight()+TargetStatsNumberFrame:GetHeight()+7,
        }
    else
        Style[TargetScanFrame]                          = {
            width                                       = 265,
            height                                      = TargetHeaderFrame:GetHeight()+TargetEquipListFrame:GetHeight()
                                                            +TargetGemInfoFrame:GetHeight()+TargetStatsNumberFrame:GetHeight()+7,
        }
    end
end