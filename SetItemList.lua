--========================================================--
--           SEquipment UI Menu SetItemList               --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.MainInterface.UnitOption.SetItemList" ""
--========================================================--
L = _Locale
----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end
-- 创建模板
local function Create_Item_List_Frame(parent)
    if not parent.ItemListFrame then
        local Main_Frame = SESetMenuFrame("Main_Frame",parent)
        Main_Frame:SetScale(_SVDB.FrameScaleSet)
            Style[Main_Frame] = {
                backdrop={
                    bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
                    edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
                    tile                    = true,
                    tileSize                = 0,
                    edgeSize                = 15,
                    insets                  = {
                                                left    = 2,
                                                right   = 2,
                                                top     = 2,
                                                bottom  = 2,
                    },
                },
                backdropcolor               = Color(0,0,0,0.7),
                backdropbordercolor         = Color(0,0,0,1),
                location            = { Anchor("TOPLEFT", 0, 0, parent:GetName(), "TOPRIGHT") }
            }
        Main_Frame.Header_Frame = SESetMenuFrame("Header_Frame",Main_Frame)
        Main_Frame.Header_Frame.Header_Left_Text = EquipInfoFontString("Header_Left_Frame",Main_Frame.Header_Frame)
        Main_Frame.Header_Frame.Header_Right_Text = EquipInfoFontString("Header_Right_Frame",Main_Frame.Header_Frame)
            Style[Main_Frame.Header_Frame] = {
                location = { Anchor("TOPLEFT",5,0)}
            }
            Style[Main_Frame.Header_Frame.Header_Left_Text] = {
                -- 待填写
            }
            Style[Main_Frame.Header_Frame.Header_Right_Text] = {
                location = { Anchor("RIGHT")}
                -- 待填写
            }
        Main_Frame.Icon_Frame     = SESetMenuFrame("Icon_Frame",Main_Frame)
        Main_Frame.Part_Frame     = SESetMenuFrame("Part_Frame",Main_Frame)
        Main_Frame.Level_Frame    = SESetMenuFrame("Level_Frame",Main_Frame)
        Main_Frame.Name_Frame     = SESetMenuFrame("Name_Frame",Main_Frame)
            Style[Main_Frame.Icon_Frame] = {
                width = 72,
                height = 288,
            }
            Style[Main_Frame.Part_Frame] = {
                width = 36,
                height = 288,
            }
            Style[Main_Frame.Level_Frame] = {
                width = 36,
                height = 288,
            }
            Style[Main_Frame.Name_Frame] = {
                height = 288,
            }
        for i, v in ipairs(SlotButton) do
            local Per_Icon_Frame = SESetMenuFrame("Per_Icon_Frame"..i,Main_Frame.Icon_Frame)
                Style[Per_Icon_Frame] = {
                    size = Size(72,18),
                    location = { Anchor("TOP",0,(-18)*(i-1))}
                }
            for j = 1, 4 do
                local Mini_Icon_Frame = StatsIconFrame("Mini_Icon_Frame"..i..j,Per_Icon_Frame)
                local Mini_Icon_Texture = Texture("Mini_Icon_Texture"..i..j,Mini_Icon_Frame)
                local Mini_Icon_Text = EquipInfoFontString("Mini_Icon_Text"..i..j,Mini_Icon_Frame)
                    Style[Mini_Icon_Frame] = {
                        location = { Anchor("LEFT",18*(j-1),0)}
                    }
                    Style[Mini_Icon_Texture] = {
                        File = TexturePath[j],
                        SetAllPoints = true,
                    }
                    Style[Mini_Icon_Text] = {
                        text = StatsName[j],
                        textcolor = Color(StatsIconColor[j].r,StatsIconColor[j].g,StatsIconColor[j].b),
                        location = { Anchor("CENTER")}
                    }
                Per_Icon_Frame["MiniIcon"..i..j] = Mini_Icon_Frame
            end
            local Per_Part_Frame = EquipInfoPartAndLevel("Per_Part_Frame"..i,Main_Frame.Part_Frame)
            local Per_Part_Texture_Frame = SESetMenuFrame("Per_Part_Texture_Frame" .. i, Per_Part_Frame)
            Per_Part_Texture_Frame.Per_Part_Text = EquipInfoFontString("Per_Part_Text" .. i, Per_Part_Texture_Frame)
                Style[Per_Part_Frame] = {
                    location = { Anchor("TOP",0,(-18)*(i-1))}
                }
                Style[Per_Part_Texture_Frame] = {
                    backdrop            = {
                        bgFile   = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
                        edgeFile = [["Interface\Buttons\WHITE8X8"]],
                        tile     = true,
                        tileSize = 0,
                        edgeSize = 1,
                        insets   = {
                            left   = 0,
                            right  = 0,
                            top    = 0,
                            bottom = 0,
                        },
                    },
                    backdropcolor       = Color(0, 0.9, 0.9, 0.2),
                    backdropbordercolor = Color(0, 0.9, 0.9, 0.2),
                    location            = { Anchor("CENTER") },
                    size = Size(32,16)
                }
                Style[Per_Part_Texture_Frame.Per_Part_Text] = {
                    location = { Anchor("CENTER")}
                    -- 待填写
                }
            local Per_Level_Frame = EquipInfoPartAndLevel("Per_Level_Frame"..i,Main_Frame.Level_Frame)
            Per_Level_Frame.Per_Level_Text = EquipInfoFontString("Per_Level_Text"..i,Per_Level_Frame)
                Style[Per_Level_Frame] = {
                    location = { Anchor("TOP",0,(-18)*(i-1))}
                }
                Style[Per_Level_Frame.Per_Level_Text] = {
                    location = { Anchor("CENTER") },
                    textcolor = Color(1,1,1)
                    -- 待填写
                }
            local Per_Name_Frame = SESetMenuFrame("Per_Name_Frame"..i,Main_Frame.Name_Frame)
            Per_Name_Frame.Per_Name_Text = EquipInfoFontString("Per_Name_Text"..i,Per_Name_Frame)
                Per_Name_Frame.index = v.index
                Style[Per_Name_Frame] = {
                    height = 18,
                    location = { Anchor("TOPLEFT",0,(-18)*(i-1))}
                }
                Style[Per_Name_Frame.Per_Name_Text] = {
                    location = { Anchor("LEFT")},
                    -- 待填写
                }
            Per_Name_Frame:SetScript("OnEnter",function (self)
                if self.link then
                    GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
                    GameTooltip:SetInventoryItem(self:GetParent():GetParent().unit, self.index)
                    -- local InsertText = _G["GameTooltipTextLeft2"]:GetText()
                    -- InsertText = "\124cff1eff00下面是隐身的小胖球\124r\n"..InsertText
                    -- _G["GameTooltipTextLeft2"]:SetText(InsertText)
                    -- _G["GameTooltipTextLeft2"]:SetSpacing(200)
                    GameTooltip:Show()
                end
            end)
            Per_Name_Frame:SetScript("OnLeave",function (self)
                GameTooltip:Hide()
            end)
            Per_Name_Frame:Hide()
            Main_Frame["Icon"..i] = Per_Icon_Frame
            Main_Frame["Part" .. i] = Per_Part_Texture_Frame
            Main_Frame["Level"..i] = Per_Level_Frame
            Main_Frame["Name"..i] = Per_Name_Frame
            FireSystemEvent("ITEM_ICON_FRAME_CREATE",Per_Icon_Frame)
            FireSystemEvent("ITEM_PART_FRAME_CREATE", Per_Part_Texture_Frame)
            FireSystemEvent("ITEM_LEVEL_FRAME_CREATE",Per_Level_Frame)
            FireSystemEvent("ITEM_NAME_FRAME_CREATE",Per_Name_Frame)
        end
        Main_Frame.Gem_Suit_Frame = SESetMenuFrame("Gem_Suit_Frame",Main_Frame)
        Main_Frame.Gem_Suit_Frame.Gem_Text = EquipInfoFontString("Gem_Text",Main_Frame.Gem_Suit_Frame)
        Main_Frame.Gem_Suit_Frame.Suit_Text = EquipInfoFontString("Suit_Text",Main_Frame.Gem_Suit_Frame)
            Style[Main_Frame.Gem_Suit_Frame] = {
                width = 150,
            }
            Style[Main_Frame.Gem_Suit_Frame.Gem_Text] = {
                -- 待填写
            }
            Style[Main_Frame.Gem_Suit_Frame.Suit_Text] = {
                location = { Anchor("LEFT",80)},
                font                    = {
                    font                = SEFontStyle[1].value,
                    height              = 10,
                }
                -- 待填写
            }
        
        Main_Frame.Stats_Frame = SESetMenuFrame("Stats_Frame",Main_Frame)
            Style[Main_Frame.Stats_Frame] = {
                width = 150,
            }
        for i = 1, 4 do
            local Per_Stats_Frame = SESetMenuFrame("Per_Stats_Frame"..i,Main_Frame.Stats_Frame)
            local One_Stats_Name = EquipInfoFontString("One_Stats_Name"..i,Per_Stats_Frame)
            Per_Stats_Frame.Two_Stats_Name = EquipInfoFontString("Two_Stats_Name"..i,Per_Stats_Frame)
            Per_Stats_Frame.Thr_Stats_Name = EquipInfoFontString("Thr_Stats_Name"..i,Per_Stats_Frame)
                Style[Per_Stats_Frame] = {
                    size = Size(150,20),
                    location = { Anchor("TOP",0,(-20)*(i-1))}
                }
                Style[One_Stats_Name] = {
                    -- 待填写
                text = StatsLongName[i]..":"
                }
                Style[Per_Stats_Frame.Two_Stats_Name] = {
                    location = { Anchor("LEFT",50)},
                    textcolor = Color(0,1,0)
                    -- 待填写
                }
                Style[Per_Stats_Frame.Thr_Stats_Name] = {
                    location = { Anchor("LEFT",100)},
                    textcolor = Color(0, 1, 0)
                    -- 待填写
                }
            Main_Frame["Stats"..i] = Per_Stats_Frame
        end
        -- function parent:OnHide() Main_Frame:Hide() end
        parent:HookScript("OnHide", function(self) Main_Frame:Hide() end)
        parent.ItemListFrame = Main_Frame
        FireSystemEvent("MAIN_FRAME_CREATED", Main_Frame, parent, "MAIN_FRAME_CREATED")
    end

    return parent.ItemListFrame
end
-- 初始化面板
__SystemEvent__ "MAIN_FRAME_CREATED" "PAPERDOLLFRAME_SHOWN" "INSPECT_READY_COMPLETED_DONE"
function MAIN_FRAME_STYLE(frame,parent,event)
    -- Header
    local HeaderHeight = 32
    if _SVDB.SettingOption[2] then
        Style[frame.Header_Frame] = {
            height = HeaderHeight,
        }
        frame.Header_Frame:Show()
    else
        HeaderHeight = 0
        Style[frame.Header_Frame] = {
            height = HeaderHeight,
        }
        frame.Header_Frame:Hide()
    end
    -- frame.Header_Frame:InstantApplyStyle()
    -- Icon
    local IconWidth = 72
    if _SVDB.SettingOption[3] then
        Style[frame.Icon_Frame] = {
            width = IconWidth,
            location = { Anchor("TOPLEFT",5,(-1)*(HeaderHeight))}
        }
        frame.Icon_Frame:Show()
    else
        IconWidth = 0
        Style[frame.Icon_Frame] = {
            width = IconWidth,
        }
        frame.Icon_Frame:Hide()
    end
    -- frame.Icon_Frame:InstantApplyStyle()
    -- Part
    local PartWidth = 36
    if _SVDB.SettingOption[4] then
        Style[frame.Part_Frame] = {
            width = PartWidth,
            location = { Anchor("TOPLEFT",IconWidth + 5,(-1)*(HeaderHeight))}
        }
        frame.Part_Frame:Show()
    else
        PartWidth = 0
        Style[frame.Part_Frame] = {
            width = PartWidth,
        }
        frame.Part_Frame:Hide()
    end
    -- frame.Part_Frame:InstantApplyStyle()
    -- Level
    local LevelWidth = 36
    if _SVDB.SettingOption[5] then
        Style[frame.Level_Frame] = {
            width = LevelWidth,
            location = { Anchor("TOPLEFT",IconWidth + PartWidth + 5,(-1)*(HeaderHeight))}
        }
        frame.Level_Frame:Show()
    else
        LevelWidth = 0
        Style[frame.Level_Frame] = {
            width = LevelWidth,
        }
        frame.Level_Frame:Hide()
    end
    -- frame.Level_Frame:InstantApplyStyle()
    -- Name
    Style[frame.Name_Frame] = {
        location = { Anchor("TOPLEFT",IconWidth + PartWidth + LevelWidth + 5,(-1)*(HeaderHeight))}
    }
    -- frame.Name_Frame:InstantApplyStyle()
    -- Gem
    local GemSuitHeight = 20
    if _SVDB.SettingOption[6] then
        Style[frame.Gem_Suit_Frame] = {
            height = GemSuitHeight,
            location = { Anchor("TOPLEFT",5,(-1)*(HeaderHeight + 288)) }
        }
        frame.Gem_Suit_Frame:Show()
    else
        GemSuitHeight = 0
        Style[frame.Gem_Suit_Frame] = {
            height = GemSuitHeight,
        }
        frame.Gem_Suit_Frame:Hide()
    end
    -- frame.Gem_Suit_Frame:InstantApplyStyle()
    -- Stats
    local StatsHeight = 80
    if _SVDB.SettingOption[7] then
        Style[frame.Stats_Frame] = {
            height = StatsHeight,
            location = { Anchor("TOPLEFT",5,(-1)*(HeaderHeight + GemSuitHeight + 288))}
        }
        frame.Stats_Frame:Show()
    else
        StatsHeight = 0
        Style[frame.Stats_Frame] = {
            height = StatsHeight,
        }
        frame.Stats_Frame:Hide()
    end
    -- frame.Stats_Frame:InstantApplyStyle()
    frame.IniWidth = IconWidth + PartWidth + LevelWidth
    if _SVDB.SettingOption[1] then
        Style[frame] = {
            height = HeaderHeight + GemSuitHeight + StatsHeight + 293,
        }
        frame:Show()
    else
        Style[frame] = {
            height = 0,
        }
        frame:Hide()
    end
    Style.UpdateSkin("Default", {
        [EquipInfoFontString] = {
            location = { Anchor("LEFT") },
            font     = {
                font   = SEFontStyle[_SVDB.FontStyleSet].value,
                height = 14,
            }
        }
    })
    if event == "PAPERDOLLFRAME_SHOWN" or event == "INSPECT_READY_COMPLETED_DONE" then
        FireSystemEvent("MAIN_FRAME_STYLE_UPDATE", frame, parent, "MAIN_FRAME_STYLE_UPDATE")
    end
end
-- 显示面板
function Show_Item_List_Frame(unit,parent)
    if not parent:IsShown() then return end
    local Main_Frame = Create_Item_List_Frame(parent)
    Main_Frame.unit = unit
    local specname,specid,specIconid = Get_Spec_Info(unit)
    local Header_Frame = Main_Frame.Header_Frame
        Style[Header_Frame.Header_Right_Text] = {
            text = specname,
        }
    if unit == "player" then
        hooksecurefunc("PaperDollFrame_SetItemLevel",function (statFrame,...)
            Style[Header_Frame.Header_Left_Text] = {
                text = statFrame.tooltip
            }
        end)
    else
        Style[Header_Frame.Header_Left_Text] = {
            text = Get_Inspect_Item_Level(unit)
        }
    end
    local Sum_Crit,Sum_Haste,Sum_Mastery,Sum_Versa = 0,0,0,0
    local Sum_Empty_Gem,Sum_Exist_Gem = 0,0
    local ItemSetIdTable = {} --词条表
    -- 总计数,暴击,急速,精通,全能,宝石,套装
    for i, v in ipairs(SlotButton) do
        local link = GetInventoryItemLink(unit, v.index)
        local name,quality,itemType,equipLoc = Get_Item_Info(link)
        local SET_ITEM_QUALITY_COLOR
        local ItemLevel, CritNumber, HasteNumber, MasteryNumber, VersaNumber, EmptyGemNumber, EnchantInfo, isPVPSet, ItemSetId = GetEachEquipInfo(link)
        if ItemSetId ~= "" then
            table.insert(ItemSetIdTable, GetItemSetInfo(ItemSetId))
        end
        if ITEM_QUALITY_COLORS[quality] and ItemSetId == "" then
            -- 非套装
            SET_ITEM_QUALITY_COLOR = ITEM_QUALITY_COLORS[quality].hex
        elseif ItemSetId ~= "" and isPVPSet then
            -- PVP套装
            SET_ITEM_QUALITY_COLOR = "|cffd5504d"
        elseif ItemSetId ~= "" and (not isPVPSet) then
            -- 非PVP套装
            SET_ITEM_QUALITY_COLOR = "|cff2bae85"
        else
            -- 没拿到装备信息
            SET_ITEM_QUALITY_COLOR = ""
        end
        if ItemLevel == 0 then
            ItemLevel = ""
        end
        local Enchant,Gem1,Gem2,Gem3,Gem4,ExistGemNumber = Get_Equiped_Info(link)
        local GemTable = { Gem1, Gem2, Gem3, Gem4 }
        -- [[*****]]
        Sum_Crit = Sum_Crit + CritNumber
        Sum_Haste = Sum_Haste + HasteNumber
        Sum_Mastery = Sum_Mastery + MasteryNumber
        Sum_Versa = Sum_Versa + VersaNumber
        Sum_Empty_Gem = Sum_Empty_Gem + EmptyGemNumber
        Sum_Exist_Gem = Sum_Exist_Gem + ExistGemNumber

        local Per_Icon_Frame = Main_Frame["Icon"..i]
        local CHMV = {CritNumber,HasteNumber,MasteryNumber,VersaNumber}
        for j = 1, 4 do
            local Mini_Icon_Frame = Per_Icon_Frame["MiniIcon"..i..j]
            if CHMV[j] == 0 then
                Mini_Icon_Frame:Hide()
            else
                Mini_Icon_Frame:Show()
            end
        end
        local Per_Part_Texture_Frame = Main_Frame["Part" .. i]
        Per_Part_Texture_Frame.quality = quality
        Per_Part_Texture_Frame.link = link
        if Per_Part_Texture_Frame.link then
            Per_Part_Texture_Frame:Show()
        else
            Per_Part_Texture_Frame:Hide()
        end
            Style[Per_Part_Texture_Frame.Per_Part_Text] = {
            text = '|cff00ccff'..equipLoc
            }
        local Per_Level_Frame = Main_Frame["Level"..i]
            Style[Per_Level_Frame.Per_Level_Text] = {
                text = tostring(ItemLevel)
            }
        local Per_Name_Frame = Main_Frame["Name"..i]
        Per_Name_Frame.link = link
        Per_Name_Frame.unit = unit
        local GetWidthFontString = FontString("GetWidthFontString",UIParent)
        GetWidthFontString:SetText(SET_ITEM_QUALITY_COLOR .. name)
        GetWidthFontString:Hide()
        local NameTextWidth = GetWidthFontString:GetStringWidth()
        Per_Name_Frame.Iniwidth = NameTextWidth
            Style[Per_Name_Frame] = {
                width = NameTextWidth
            }
            Style[Per_Name_Frame.Per_Name_Text] = {
                text = SET_ITEM_QUALITY_COLOR..name
            }
        
        -- Per_Name_Frame.Per_Name_Text:SetText(SET_ITEM_QUALITY_COLOR .. name)
        -- local NameTextWidth = Per_Name_Frame.Per_Name_Text:GetStringWidth()
        -- Per_Name_Frame.width = Per_Name_Frame
        -- Per_Name_Frame.Per_Name_Text:InstantApplyStyle()
        Per_Name_Frame:Show()
        -- Per_Name_Frame:SetWidth(NameTextWidth)
        -- Per_Name_Frame:InstantApplyStyle()
        FireSystemEvent("PER_ITEM_ICON_FRAME_UPDATE",Per_Icon_Frame)
        FireSystemEvent("PER_ITEM_PART_FRAME_UPDATE", Per_Part_Texture_Frame)
        FireSystemEvent("PER_ITEM_LEVEL_FRAME_UPDATE", Per_Level_Frame)
        FireSystemEvent("PER_ITEM_NAME_FRAME_UPDATE", Per_Name_Frame, v.index, GemTable, EmptyGemNumber, EnchantInfo)
    end
    local Gem_Suit_Frame = Main_Frame.Gem_Suit_Frame
    if Sum_Exist_Gem + Sum_Empty_Gem == 0 then
        Style[Gem_Suit_Frame.Gem_Text] = {
            text = ""
        }
    else
        Style[Gem_Suit_Frame.Gem_Text] = {
            text = L["Gem"]..":"..Sum_Exist_Gem.."/"..Sum_Exist_Gem + Sum_Empty_Gem
        }
    end
    if #ItemSetIdTable == 0 then
        Style[Gem_Suit_Frame.Suit_Text] = {
            text = ""
        }
    else
        Style[Gem_Suit_Frame.Suit_Text] = {
            text = table.concat(Get_Same_Mate(ItemSetIdTable))
        }
    end
    local SUM_CHMV = {Sum_Crit,Sum_Haste,Sum_Mastery,Sum_Versa}
    for i = 1, 4 do
        local Per_Stats_Frame = Main_Frame["Stats"..i]
        Style[Per_Stats_Frame.Two_Stats_Name] = {
            text = tostring(SUM_CHMV[i])
        }
        Style[Per_Stats_Frame.Thr_Stats_Name] = {
            text = GetStatsPercent(SUM_CHMV[i],i,unit,specid)
        }
    end

    FireSystemEvent("MAIN_FRAME_CREATE_COMPLETED",Main_Frame,parent)

    return Main_Frame
end
-- 设定边框
__SystemEvent__ "MAIN_FRAME_CREATE_COMPLETED" "MAIN_FRAME_STYLE_UPDATE"
function Main_FRAME_STYLE(frame,parent)
    local Max_StringWidth = {}
    for i, v in ipairs(SlotButton) do
        local Per_Name_Frame = frame["Name"..i]
        Max_StringWidth[i] = tonumber(Per_Name_Frame.width)
    end
    Style[frame.Name_Frame] = {
        width = Get_Max_String_Width(Max_StringWidth)
    }
    Style[frame.Header_Frame] = {
        width = frame.IniWidth + Get_Max_String_Width(Max_StringWidth),
    }
    Style[frame] = {
        width = frame.IniWidth + Get_Max_String_Width(Max_StringWidth) + 10,
    }
    -- frame:InstantApplyStyle()
    frame:Show()
end

PaperDollFrame:HookScript("OnShow",function (self)
    Show_Item_List_Frame("player",self)
    FireSystemEvent("PAPERDOLLFRAME_SHOWN", self.ItemListFrame, self, "PAPERDOLLFRAME_SHOWN")
end)
__SystemEvent__()
function PLAYER_EQUIPMENT_CHANGED()
    if PaperDollFrame and PaperDollFrame:IsShown() then
        Show_Item_List_Frame("player",PaperDollFrame)
    end
end
local guids = {}
__SecureHook__()
function NotifyInspect(unit)
    local guid = UnitGUID(unit)
    if not guid then
        return
    end
        guids[guid] = guid
    FireSystemEvent("NOTIFY_INSPECT_READY", guid)
end

__Async__()
function OnEnable()
    while Wait("INSPECT_READY") do
        Next()
        FireSystemEvent("INSPECT_READY_COMPLETED")
    end
end
__SystemEvent__()
function UNIT_INVENTORY_CHANGED(unit)
    if InspectFrame and InspectFrame.unit and InspectFrame.unit == unit then
        FireSystemEvent("UNIT_INVENTORY_CHANGED_COMPLETED", unit)
    end
end
__SystemEvent__()
function UNIT_INVENTORY_CHANGED_COMPLETED(unit)
    if InspectFrame and InspectFrame.unit and InspectFrame.unit == unit then
        local frame = Show_Item_List_Frame(unit, InspectPaperDollFrame)
        FireSystemEvent("UNIT_INVENTORY_CHANGED_COMPLETED_DONE",frame)
    end
end
__SystemEvent__()
function INSPECT_READY_COMPLETED()
    if InspectFrame and InspectFrame.unit then
        local frame = Show_Item_List_Frame(InspectFrame.unit, InspectPaperDollFrame)
        FireSystemEvent("INSPECT_READY_COMPLETED_DONE", frame, InspectPaperDollFrame)
    end
end
__AddonSecureHook__ "Blizzard_InspectUI"
function ClearInspectPlayer()
    InspectPaperDollFrame.ItemListFrame:Hide()
end

-- Gem Enchant
-- 模板
local function Create_Gem_Enchant(frame,index)
    if not frame.iconframe then
        local Icon_List = SESetMenuFrame("Icon_List"..frame.unit..index,frame)
        Style[Icon_List] = {
            height = 16,
            location = { Anchor("RIGHT")}
        }
        for i = 1, 5 do
            local Icon = SESetMenuFrame("Icon" .. frame.unit .. index .. i, Icon_List)
            Icon.Icon_Texture = Texture("Icon_Texture" .. frame.unit .. index .. i, Icon)
            Style[Icon] = {
                size = Size(12,12),
                location = { Anchor("RIGHT",-(16)*(i-1),0)},
            }
            Style[Icon.Icon_Texture] = {
                size = Size(12,12),
                -- 待填写
                -- File = [[Interface\Cursor\Quest]],
                location = { Anchor("CENTER")},
                Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
            }
            Icon:SetScript("OnEnter", function(self)
                if self.link then
                    local isHover = string.match(self.link, ENCHANTS)
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                    if isHover or self.link == L["Empty GemSlot"] then
                        GameTooltip:SetText(self.link)
                    else
                        GameTooltip:SetHyperlink(select(2,GetItemInfo(self.link)))
                    end
                    GameTooltip:Show()
                end
            end)
            Icon:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)
            Icon_List["Icon" .. frame.unit .. index .. i] = Icon
        end
        frame.iconframe = Icon_List
    end
    return frame.iconframe
end

__SystemEvent__()
function PER_ITEM_NAME_FRAME_UPDATE(frame, index, gemtable,emptygemnumber,enchantinfo)
    local Icon_List = Create_Gem_Enchant(frame, index)
    -- 拿到有用数据
    -- 是否有附魔,几个镶嵌的宝石,是否有空宝石槽
    local UsefulInfo = {}
    local TextureFile = {}
    if enchantinfo ~= "" then
        table.insert(UsefulInfo, enchantinfo)
        table.insert(TextureFile, GetItemIcon(128537))
    end
    for _, value in ipairs(gemtable) do
       if value ~= 0 then
           table.insert(UsefulInfo,value)
           table.insert(TextureFile, GetItemIcon(value))
       end
    end
    if emptygemnumber > 0 then
        table.insert(UsefulInfo, L["Empty GemSlot"])
        table.insert(TextureFile, [[Interface\Cursor\Quest]])
    end
    Style[Icon_List] = {
        width = (#UsefulInfo) * (16)
    }
    for i = 1, 5 do
        local Icon = Icon_List["Icon" .. frame.unit .. index .. i]
        if i <= #UsefulInfo then
            Icon.link = UsefulInfo[i]
            Style[Icon.Icon_Texture] = {
                File = TextureFile[i]
            }
            Icon:Show()
        else
            Icon:Hide()
        end
    end
    local Realwidth = tonumber(frame.Iniwidth) + (#UsefulInfo) * (16)
    frame.width = Realwidth
    Style[frame] = {
        width = Realwidth
    }
end
