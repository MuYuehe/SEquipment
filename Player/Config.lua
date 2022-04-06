--========================================================--
--           SEquipment ListFrame Player Config           --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.MainInterface.PlayerListFrame.Config" ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                     PlayerConfig                      --
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
__SecureHook__()
function SetPaperDollBackground(model, unit)
    if model == CharacterModelFrame and unit == "player" then
        EquipInfo                                                                       = GetEquipInfo("player")
        EquipNameMaxLong = GetNameLongMax(EquipInfo)
        EquipedGemInfo,EquipedGemNumber                                                 = GetEquipedGemInfo(EquipInfo)
        SpecInfo = GetSpecInfo("player")
        EachEquipInfo,CritNumber,HasteNumber,MasteryNumber,VersaNumber,NullGemNumber,SetEquipNumber    = GetEachEquipInfo("player")
        StatsNumberList                                                                 ={
                                                                                            CritNumber,
                                                                                            HasteNumber,
                                                                                            MasteryNumber,
                                                                                            VersaNumber,
                                                                                        }
        UpdateListFrame(EquipNameMaxLong,EquipInfo)
        SEUpdateEquipList(EquipInfo,EachEquipInfo,EquipedGemNumber,NullGemNumber,StatsNumberList,SetEquipNumber)
    end
end

__SystemEvent__ "PLAYER_EQUIPMENT_CHANGED"
function PLAYEREQUIPMENT_UPDATE()
    EquipInfo                                                                       = GetEquipInfo("player")
    EquipNameMaxLong = GetNameLongMax(EquipInfo)
    EquipedGemInfo,EquipedGemNumber                                                 = GetEquipedGemInfo(EquipInfo)
    SpecInfo = GetSpecInfo("player")
    EachEquipInfo,CritNumber,HasteNumber,MasteryNumber,VersaNumber,NullGemNumber,SetEquipNumber    = GetEachEquipInfo("player")
    StatsNumberList                                                                 ={
                                                                                        CritNumber,
                                                                                        HasteNumber,
                                                                                        MasteryNumber,
                                                                                        VersaNumber,
                                                                                     }
    UpdateListFrame(EquipNameMaxLong,EquipInfo)
    SEUpdateEquipList(EquipInfo,EachEquipInfo,EquipedGemNumber,NullGemNumber,StatsNumberList,SetEquipNumber)
end

__SystemEvent__ "PLAYER_TALENT_UPDATE"
function PLAYERTALENT_UPDATE()
    SpecInfo                                                                        = GetSpecInfo("player")
    SEUpdateTalentList(SpecInfo)
end

__SecureHook__()
function PaperDollFrame_SetItemLevel(statFrame, unit)
    Style[PlayerHeaderLeftFont] = {
        text                    = statFrame.tooltip
    }
end

---------------------------
--     PlayerSetting     --
---------------------------
function SEUpdateTalentList(spec)
    Style[PlayerHeaderRightFont]                        = {
        text                                            = spec[2],
    }
end
function SEUpdateEquipList(equipinfo,eachequipinfo,equipgemnumber,nullgemnumber,statsnumberlist,setequipumber)
    -- 更新装备列表
    local children = {PlayerStatsIconFrameList:GetChildren()}
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
    children = {PlayerEquipPartFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            Style[value]                        = {
                ["PlayerEquipPartText"..index]  = {
                    text                        = eachequipinfo[index][7],
                }
            }
            value:Show()
        else
            value:Hide()
        end
    end
    children = {PlayerEquipLevelFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            Style[value]                        = {
                ["PlayerEquipLevelText"..index] = {
                    text                        = tostring(eachequipinfo[index][5]),
                }
            }
            value:Show()
        else
            value:Hide()
        end
    end
    children = {PlayerEquipNameFrameList:GetChildren()}
    for index, value in ipairs(children) do
        if index <= #equipinfo then
            Style[value]                        = {
                width                           = 6*GetNameLongMax(equipinfo)-10,
                ["PlayerEquipNameText"..index]  = {
                    text                        = (equipinfo[index][2]),
                }
            }
            value:Show()
            -- 添加宝石显示(如果有的话)
            local child = value:GetChildren()
            if eachequipinfo[index][6] then
                Style[child]                    = {
                    location                    = { Anchor("LEFT",6*GetNameLongMax(equipinfo)-10,0)}
                }
                child:Show()
            else
                child:Hide()
            end
            -- 添加Tooltip处理
            value:SetScript("OnEnter",function (self)
                GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
                GameTooltip:SetInventoryItem("player",eachequipinfo[index][8])
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
    Style[PlayerGemInfoText]                            = {
        text                                            ="宝石:".." "..equipgemnumber.."/"..(equipgemnumber+nullgemnumber).."    圣墓两件套"
    }
    elseif setequipumber >= 4 then
    Style[PlayerGemInfoText]                            = {
        text                                            ="宝石:".." "..equipgemnumber.."/"..(equipgemnumber+nullgemnumber).."    圣墓四件套"
    }
    elseif setequipumber < 2 then
    Style[PlayerGemInfoText]                            = {
        text                                            ="宝石:".." "..equipgemnumber.."/"..(equipgemnumber+nullgemnumber).."    无套装"
    }
    end
    -- 更新属性数字信息
    children = {PlayerStatsNumberList:GetChildren()}
    for index, value in ipairs(children) do
        Style[value]                                    = {
            ["PlayerStatsNumberText"..index]            = {
                text                                    = tostring(statsnumberlist[index]),
            }
        }
    end
    children = {PlayerStatsPercentList:GetChildren()}
    for index, value in ipairs(children) do
        Style[value]                                    = {
            ["PlayerStatsPercentText"..index]           = {
                text                                    = GetStatsPercent(statsnumberlist[index],index,"player",SpecInfo),
            }
        }
    end
end
-- 这里是更新框体大小的
function UpdateListFrame(equipnamemaxlong,equipinfo)
    -- 确定PlayerScanFrame/PlayerHeaderFrame的宽度
    local children = {PlayerEquipNameFrameList:GetChildren()}
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
    Style[PlayerEquipNameFrameList]                     = {
        width                                           = 6*equipnamemaxlong,
        height                                          = (#equipinfo)*18,
    }
    Style[PlayerStatsIconFrameList]                     = {
        height                                          = (#equipinfo)*18,
    }
    Style[PlayerEquipPartFrameList]                     = {
        height                                          = (#equipinfo)*18,
    }
    Style[PlayerEquipLevelFrameList]                    = {
        height                                          = (#equipinfo)*18,
    }
    Style[PlayerEquipListFrame]                         = {
        width                                           = PlayerStatsIconFrameList:GetWidth()+PlayerEquipPartFrameList:GetWidth()
                                                            +PlayerEquipLevelFrameList:GetWidth()+PlayerEquipNameFrameList:GetWidth(),
        height                                          = (#equipinfo)*18,
    }
    if #equipinfo == 0 then
        Style[PlayerEquipListFrame]                     = {
            height                                      = 1,
        }
    end
    -- PlayerHeaderFrame的宽度
    if PlayerEquipNameFrameList:GetWidth() > 6 then
        Style[PlayerHeaderFrame]                        = {
            width                                       = PlayerEquipListFrame:GetWidth(),
        }
    else
        Style[PlayerHeaderFrame]                        = {
            width                                       = 250,
        }
    end
    -- PlayerScanFrame的宽度
    if PlayerEquipNameFrameList:GetWidth() > 6 then
        Style[PlayerScanFrame]                          = {
            width                                       = PlayerEquipListFrame:GetWidth()+15,
            height                                      = PlayerHeaderFrame:GetHeight()+PlayerEquipListFrame:GetHeight()
                                                            +PlayerGemInfoFrame:GetHeight()+PlayerStatsNumberFrame:GetHeight()+7,
        }
    else
        Style[PlayerScanFrame]                          = {
            width                                       = 265,
            height                                      = PlayerHeaderFrame:GetHeight()+PlayerEquipListFrame:GetHeight()
                                                            +PlayerGemInfoFrame:GetHeight()+PlayerStatsNumberFrame:GetHeight()+7,
        }
    end
end