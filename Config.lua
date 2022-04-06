--========================================================--
--               SEquipment Base Config                   --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio                 "BaseConfig"                      ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                   StandardParts                       --
-----------------------------------------------------------

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

----------------------------
--     Data Collection    --
----------------------------
local standardFont
if _Locale("zhCN") then
    standardFont="Fonts\\ARKai_T.ttf"
elseif _Locale("zhTW") then
    standardFont = "Fonts\\blei00d.TTF"
elseif _Locale("ruRU") then
    standardFont = "Fonts\\FRIZQT___CYR.TTF"
elseif _Locale("koKR") then
    standardFont = "Fonts\\2002.TTF"
end
SEFontStyle={
    {
        text = L["DEFAULT"],
        value = standardFont
    },
    {
		text	= "Arial",
		value	= "Fonts\\ARIALN.TTF"
	},
    {
		text	= "Skurri",
		value	= "Fonts\\skurri.ttf"
	},
	{
		text	= "Morpheus",
		value	= "Fonts\\MORPHEUS.ttf"
	}
}
-- 纹理路径
TexturePath={
    [[Interface\AddOns\SEquipment\statsicons\CRIT]],
    [[Interface\AddOns\SEquipment\statsicons\HASTE]],
    [[Interface\AddOns\SEquipment\statsicons\MASTERY]],
    [[Interface\AddOns\SEquipment\statsicons\VERSATILITY]],
}
StatsName = {
    L["Crit"],
    L["Haste"],
    L["Mastery"],
    L["Versatility"],
}
StatsLongName = {
    L["CritLong"],L["HasteLong"],L["MasteryLong"],L["VersatilityLong"],
}
StatsIconColor = {
    {r=1,g=0.5,b=0.3,},{r=0.9,g=1,b=0.1,},{r=0.8,g=0.1,b=1,},{r=0.1,g=0.3,b=1,},
}
ItemLocation = {
    "TOP","BOTTOM","LEFT","RIGHT","CENTER",
    "TOPLEFT","TOPRIGHT","BOTTOMLEFT","BOTTOMRIGHT",
}

----------------------------
--        MainDialog      --
--only one,can be defined --
----------------------------
class "SEDialog" { Dialog }
Style.UpdateSkin("Default",{
    [SEDialog]                      = {
        size                        = Size(600,400),
        resizable                   = false,
        -- 标准件正常情况没有Header
        Header                      = {
            text                    = "",
        },
        CloseButton                 = {
            location                = { },
        },
    }
})
----------------------------
--        MenuFrame       --
-- Frame used in set menu --
----------------------------
class "SESetMenuFrame" { Frame }
Style.UpdateSkin("Default",{
    [SESetMenuFrame]                = {
        backdrop={
            bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
            edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
            tile                    = true,
            tileSize                = 0,
            edgeSize                = 15,
            insets                  = {
                                        left    = 0,
                                        right   = 0,
                                        top     = 0,
                                        bottom  = 0,
            },
        },
        backdropcolor               = Color(0,0,0,0),
        backdropbordercolor         = Color(0,0,0,0),
    }
})
----------------------------
--         Button         --
----------------------------
class "SEButton" { UIPanelButton }
Style.UpdateSkin("Default",{
    [SEButton]                      = {
        size                        = Size(80,20),
        text                        = "",
    }
})
----------------------------
--       CheckButton      --
----------------------------
class "SECheckButton" { UICheckButton }
Style.UpdateSkin("Default",{
    [SECheckButton]                 = {
        size                        = Size(32,32),
        -- Checked                     = true,
    }
})
----------------------------
--         ComboBox       --
----------------------------
class "SEComboBox" { ComboBox }
Style.UpdateSkin("Default",{
    [SEComboBox]                    = {
        -- height=50,
    }
})
----------------------------
--         TrackBar       --
----------------------------
class "SETrackBar" { TrackBar }
Style.UpdateSkin("Default",{
    [SETrackBar]                    = {
        valueStep                   = 5,
    }
})
----------------------------
--     FauxScrollFrame    --
----------------------------
class "SEScrollFrame" { FauxScrollFrame }
Style.UpdateSkin("Default",{
    [SEScrollFrame]                 = {
        backdrop={
            bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
            edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
            tile                    = true,
            tileSize                = 0,
            edgeSize                = 15,
            insets                  = { left    =1,
                                        right   =1,
                                        top     =1,
                                        bottom  =1,
                                    }
        },
        backdropcolor               = Color(0,0,0,0),
        backdropbordercolor         = Color(1,1,1,1),
        ScrollBar                   = {
            location                = {
                                        Anchor("TOPRIGHT", -5, -15, nil, "TOPRIGHT"),
                                        Anchor("BOTTOMRIGHT", -5, 15, nil, "BOTTOMRIGHT"),
            },
        },
    }
})
----------------------------
--     TreeNodeClasses    --
----------------------------
            -- usage --
-- Style.ActiveSkin("SETreeNode",Tree) --
Style.RegisterSkin("SETreeNode",{
    [TreeView.TreeNodeClasses[1]]   = {
        inherit="default",
        Toggle                      = {
            location                = { Anchor("TOPLEFT", 0, -2) },
        },
        ButtonText                  = {
            location                = { Anchor("LEFT",15,0) }
        }
    },
})
----------------------------
--        StatsIcon       --
--    Frame,Texture,Text  --
----------------------------
class "StatsIconFrame"      { Frame }
class "StatsIconText"       { FontString }
Style.UpdateSkin("Default",{
    [StatsIconFrame]                = {
        backdrop={
            bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
            edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
            tile                    = true,
            tileSize                = 0,
            edgeSize                = 15,
            insets                  = {
                                        left    = 0,
                                        right   = 0,
                                        top     = 0,
                                        bottom  = 0,
                                    },
        },
        backdropcolor               = Color(0,0,0,0),
        backdropbordercolor         = Color(0,0,0,0),
        size                        = Size(18,18),
        EnableMouseClicks           = true,
        EnableMouse                 = true,
    },
})

----------------------------
--        EquipInfo       --
--     Part,Level,Name    --
----------------------------
class "EquipInfoFrame"          { Frame }
class "EquipInfoPartAndLevel"   { Frame }
class "EquipInfoFontString"     { FontString }
Style.UpdateSkin("Default",{
    [EquipInfoFrame]                = {
        backdrop={
            bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
            edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
            tile                    = true,
            tileSize                = 0,
            edgeSize                = 15,
            insets                  = {
                                        left    = 0,
                                        right   = 0,
                                        top     = 0,
                                        bottom  = 0,
                                    },
        },
        backdropcolor               = Color(0,0,0,0),
        backdropbordercolor         = Color(0,0,0,0),
        height                      = 18,
    },
    [EquipInfoPartAndLevel]         = {
        backdrop={
            bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
            edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
            tile                    = true,
            tileSize                = 0,
            edgeSize                = 15,
            insets                  = {
                                        left    = 0,
                                        right   = 0,
                                        top     = 0,
                                        bottom  = 0,
                                    },
        },
        backdropcolor               = Color(0,0,0,0),
        backdropbordercolor         = Color(0,0,0,0),
        width                       = 36,
        height                      = 18,
    },
})
------------------
-- 整合字体设置  --
------------------
-- function OnEnable(self)
    Style.UpdateSkin("Default",{
        [EquipInfoFontString]       = {
            location                = { Anchor("LEFT") },
            font                    = {
                font                = SEFontStyle[1].value,
                -- font                = SEFontStyle[_SVDB.FontStyleSet].value,
                height              = 15,
            }
        },
    -- })
    -- Style.UpdateSkin("Default",{
        [StatsIconText]             = {
            location                = { Anchor("CENTER") },
            font                    = {
                font                = SEFontStyle[1].value,
                -- font                = SEFontStyle[_SVDB.FontStyleSet].value,
                height              = 15,
            }
        },
    })
-- end
-----------------------------------------------------------
--                      Function                         --
-----------------------------------------------------------

----------------------------
--      GetEquipInfo      --
--    Name,Link,Quality   --
----------------------------
function GetEquipInfo(unit)
    local EquipInfoList = {}
    for i = 1, 17, 1 do
        local EachItem = {
            "",-- name
            "",-- link
            "",-- quality
        }
        if GetInventoryItemLink(unit,i) then
            EachItem[1],EachItem[2],EachItem[3]=GetItemInfo(GetInventoryItemLink(unit,i))
            if i ~= 4 then
                -- 获取非空装备列表,空插槽被忽略
                table.insert(EquipInfoList,EachItem)
            end
        end
    end
    return EquipInfoList
end
----------------------------
-- GetAvgItemLevelEquiped --
----------------------------
function GetAvgItemLevelEquiped(unit)
    local AvgItemLevelEquiped = "未知"
    if unit == "player" then
        _,AvgItemLevelEquiped = GetAverageItemLevel()
    elseif unit == "target" then
        AvgItemLevelEquiped = C_PaperDollInfo.GetInspectItemLevel(unit)
    end
    if AvgItemLevelEquiped ~= "未知" then
        return ("%.1f"):format(AvgItemLevelEquiped)
    end
    return AvgItemLevelEquiped
end
----------------------------
--    GetEquipedGemInfo   --
--        Number,ID       --
----------------------------
function GetEquipedGemInfo(links)
    local AllGemInfo = {}
    local GemNumber= 0
    for _,va in ipairs(links) do
        local LinkInfo = {}
        local EachGemInfo = {
            1,--Gem1
            1,--Gem2
            1,--Gem3
            1,--Gem4
            0,--ItemID
        }
        if va[2] ~= "" and va[2] ~= nil then
            for k, v in pairs({strsplit(":", va[2])}) do
                if #v > 0 then
                    LinkInfo[k] = v
                else
                    LinkInfo[k]=1
                end
                if k==7 then
                    break;
                end
            end
            for key, value in pairs(LinkInfo) do
                -- key>2,直接开始遍历宝石
                -- 如果存在宝石,则存入宝石的ID,否则存入的value为 1
                if key==4 and value ~= 1 then
                    EachGemInfo[1]=value
                    GemNumber=GemNumber+1
                elseif key==5 and value ~= 1 then
                    EachGemInfo[2]=value
                    GemNumber=GemNumber+1
                elseif key==6 and value ~= 1 then
                    EachGemInfo[3]=value
                    GemNumber=GemNumber+1
                elseif key==7 and value ~= 1 then
                    EachGemInfo[4]=value
                    GemNumber=GemNumber+1
                elseif key == 2 then
                    EachGemInfo[5] = value
                end
            end
        end
        table.insert(AllGemInfo,EachGemInfo)
    end
    return AllGemInfo,GemNumber
end
----------------------------
--       GetSpecInfo      --
--      Number,ID,Icon    --
----------------------------
function GetSpecInfo(unit)
    local SpecInfo = {
        0,-- ID
        "",-- name
        0,-- IconID
    }
    if GetInspectSpecialization(unit) and unit == "target" then
        SpecInfo[1],SpecInfo[2],_,SpecInfo[3] = GetSpecializationInfoByID(GetInspectSpecialization(unit))
    elseif UnitClass(unit) and GetSpecialization() and unit == "player" then
        local _,_,ClassID = UnitClass(unit)
        SpecInfo[1],SpecInfo[2],_,SpecInfo[3] = GetSpecializationInfoForClassID(ClassID,GetSpecialization())
    end
    return SpecInfo
end
----------------------------
--     GetEachEquipInfo   --
----------------------------
--Crit,Haste,Mastery,Versa--
--EquipLevel,NullGemNumber--
--    total attributes    --
----------------------------
-- Socket Type
local Sockets = {
    EMPTY_SOCKET_BLUE,              EMPTY_SOCKET_COGWHEEL,
    EMPTY_SOCKET_CYPHER,            EMPTY_SOCKET_DOMINATION,
    EMPTY_SOCKET_HYDRAULIC,         EMPTY_SOCKET_META,
    EMPTY_SOCKET_NO_COLOR,          EMPTY_SOCKET_PRISMATIC,
    EMPTY_SOCKET_PUNCHCARDBLUE,     EMPTY_SOCKET_PUNCHCARDRED,
    EMPTY_SOCKET_PUNCHCARDYELLOW,   EMPTY_SOCKET_RED,
    EMPTY_SOCKET_YELLOW,
}
local Parts = {
    L["Head"],L["Neck"],L["Shoulders"],0,L["Chest"],L["Waist"],L["Legs"],L["Feet"],L["Wrist"],
    L["Hands"],L["Finger1"],L["Finger2"],L["Trinket1"],L["Trinket2"],L["Back"],L["Main Hand"],L["Off Hand"],
}
function GetEachEquipInfo(unit)
    local AllItem={}
    local CritNumber            = 0
    local HasteNumber           = 0
    local MasteryNumber         = 0
    local VersaNumber           = 0
    local NormalGemNumber       = 0
    local SetNumber             = 0
    for i = 1, 17, 1 do
        local EachItem={
            0,-- CritNumber
            0,-- HasteNumber
            0,-- MasteryNumber
            0,-- VersaNumber
            "",-- ItemLevel
            false,-- IsNullGem
            Parts[i],--SlotName
            i,--SlotID
            "",--套装词条
        }
        for _,left,right in GetGameTooltipLines("InventoryItem",unit,i,false,true) do
            if left then
                -- 爆击词条
                if string.find(left,STAT_CRITICAL_STRIKE) and string.find(left,"+") then
                    EachItem[1]=tonumber(string.match(left,"%d+"))
                    CritNumber=CritNumber+tonumber(string.match(left,"%d+"))
                
                -- 急速词条
                elseif string.find(left,STAT_HASTE) and string.find(left,"+") then
                    EachItem[2]=tonumber(string.match(left,"%d+"))
                    HasteNumber=HasteNumber+tonumber(string.match(left,"%d+"))
                
                -- 精通词条
                elseif string.find(left,STAT_MASTERY) and string.find(left,"+") then
                    EachItem[3]=tonumber(string.match(left,"%d+"))
                    MasteryNumber=MasteryNumber+tonumber(string.match(left,"%d+"))
                
                -- 全能词条
                elseif string.find(left,STAT_VERSATILITY) and string.find(left,"+") then
                    EachItem[4]=tonumber(string.match(left,"%d+"))
                    VersaNumber=VersaNumber+tonumber(string.match(left,"%d+"))
                
                -- 物品装等
                elseif string.find(left,ITEM_LEVEL) then
                    EachItem[5]=tonumber(string.match(left,"%d+"))

                -- 宝石数目
                elseif IsDominationGem(left,Sockets) then
                    EachItem[6]=true
                    NormalGemNumber=NormalGemNumber+1
                -- 查看套装件数
                elseif string.find(left,"/5") and EachItem[5] >= 239 then
                    SetNumber = SetNumber + 1
                end
            end
        end
        -- 忽略了没有装备的插槽
        if (type(EachItem[5]) == "number" and EachItem[5] > 0 and i ~= 4) then
            table.insert(AllItem,EachItem)
        end
    end
    return AllItem,CritNumber,HasteNumber,MasteryNumber,VersaNumber,NormalGemNumber,SetNumber
end
-- 判断表中有无元素
function IsDominationGem(meta,table)
    local Boolean = false
    for index, value in ipairs(table) do
        if tostring(meta) == tostring(value) then
            Boolean = true
        end
    end
    return Boolean
end
----------------------------
--     GetQualityColor    --
--          r,g,b         --
----------------------------
function GetQualityColor(table)
    local Colors = {}
    for index,value in ipairs(table) do
        local Color = {
            r=0,
            g=0,
            b=0,
        }
        if value[3]~="" and value[3] ~= nil then
            Color.r,Color.g,Color.b=GetItemQualityColor(value[3])
            Colors[index] = Color
        end
    end
    return Colors
end
----------------------------
--     GetStatsPercent    --
----------------------------
-- Base Stats
local BaseStats = {
-------MasteryEffect,BaseMastery,BaseCrit
-- dk
    [250] = { 2,        16,     5,},
    [251] = { 2,        16,     5,},
    [252] = { 2.26,     18,     5,},
-- dh
    [577] = { 1.8,      14,     10,},
    [581] = { 2.5,      24,     10,},
-- xd
    [102] = { 1.1,      9,      5,},
    [103] = { 2,        16,     10,},
    [104] = { 0.5,      4,      10,},
    [105] = { 0.5,      4,      5,},
-- lr
    [253] = { 1.9,      15,     10,},
    [254] = { 0.625,    5,      10,},
    [255] = { 1.66,     13,     10,},
-- fs
    [62]  = { 1.2,      9.6,    5,},
    [63]  = { 0.75,     6,      5,},
    [64]  = { 1,        8,      5,},
-- ws
    [268] = { 1,        8,      10,},
    [270] = { 4.2,      34,     5,},
    [269] = { 1.25,     10,     10,},
-- qs
    [65]  = { 1.5,      12,     5,},
    [66]  = { 1,        8,      5,},
    [70]  = { 1.6,      13,     5,},
-- ms
    [256] = { 1.35,     10.8,   5,},
    [257] = { 1.25,     10,     5,},
    [258] = { 0.5,      4,      5,},
-- dz
    [259] = { 1.7,      14,     10,},
    [260] = { 1.45,     18,     10,},
    [261] = { 2.45,     19.6,   10,},
-- sm
    [262] = { 1.876,    15,     10,},
    [263] = { 2,        0.64,   10,},
    [264] = { 3,        24,     10,},
-- ss
    [265] = { 2.5,      20,     5,},
    [266] = { 1.45,     12,     5,},
    [267] = { 2,        8,      5,},
-- zs
    [71]  = { 1.1,      9,      5,},
    [72]  = { 1.4,      11,     5,},
    [73]  = { 0.5,      4,      5,},
}
function GetStatsPercent(number,statsname,unit,SpecID)
    if not BaseStats[SpecID[1]] then
        return ""
    end
    local _,_,raceID = UnitRace(unit)
    local Percent = 0
    if raceID == 1 then
        number = number * (1 + 0.02)
    end
    if statsname == 1 or statsname == 3 then
        -- 暴击 精通
        if number <=1050 then
            Percent = number/35
        elseif number > 1050 and number <= 1400 then
            Percent = 30 + (number-1050)*0.9/35
        elseif number > 1400 and number <= 1750 then
            Percent = 39 + (number-1400)*0.8/35
        elseif number > 1750 and number <= 2100 then
            Percent = 47 + (number-1750)*0.7/35
        elseif number > 2100 and number <= 2800 then
            Percent = 54 + (number-2100)*0.6/35
        elseif number > 2800 and number <= 7000 then
            Percent = 66 + (number-2800)*0.5/35
        else
            Percent = 126
        end
        if statsname == 3 and BaseStats[SpecID[1]][1] then
            Percent = Percent * BaseStats[SpecID[1]][1] --XXX精通系数 GetMasteryEffect()
        end
    elseif statsname == 2 then
        -- 急速
        if number <=990 then
            Percent = number/33
        elseif number > 990 and number <= 1320 then
            Percent = 30 + (number-990)*0.9/33
        elseif number > 1320 and number <= 1650 then
            Percent = 39 + (number-1320)*0.8/33
        elseif number > 1650 and number <= 1980 then
            Percent = 47 + (number-1650)*0.7/33
        elseif number > 1980 and number <= 2640 then
            Percent = 54 + (number-1980)*0.6/33
        elseif number > 2640 and number <= 6600 then
            Percent = 66 + (number-2640)*0.5/33
        else
            Percent = 126
        end
    elseif statsname == 4 then
        -- 全能
        if number <=1200 then
            Percent = number/40
        elseif number > 1200 and number <= 1600 then
            Percent = 30 + (number-1200)*0.9/40
        elseif number > 1600 and number <= 2000 then
            Percent = 39 + (number-1600)*0.8/40
        elseif number > 2000 and number <= 2400 then
            Percent = 47 + (number-200)*0.7/40
        elseif number > 2400 and number <= 3200 then
            Percent = 54 + (number-2400)*0.6/40
        elseif number > 3200 and number <= 8000 then
            Percent = 66 + (number-3200)*0.5/40
        else
            Percent = 126
        end
    end
    if statsname == 1 and BaseStats[SpecID[1]][3] then
        Percent = Percent + BaseStats[SpecID[1]][3]
        if raceID == 10 or raceID == 4 or raceID == 12 then
            Percent = Percent + 1
        end
    elseif statsname == 2 then
        if raceID == 7 then
            Percent = Percent + 1
        end
    elseif statsname == 3 and BaseStats[SpecID[1]][2] then
        Percent = Percent + BaseStats[SpecID[1]][2]
    elseif statsname == 4 then
        if raceID == 28 or raceID == 32 then
            Percent = Percent + 1
        end
    end
    return ("%.1f"):format(Percent).."%"
end

----------------------------
--      Pure Function     --
----------------------------
function GetNameLongMax(table)
    local max = 1
    for _, value in ipairs(table) do
        if value[1] ~= nil then
            if max == 1 then
                max = #(value[1])
            end
            if max < #(value[1]) then
                max = #(value[1])
            end
        end
    end
    return max
end

----------------------------
-- Get Container ItemInfo --
--   Level,Part,Quality   --
----------------------------
function SEGetContainerItemInfo(itemLink)
    local Color
    local itemQuality = select(3,GetItemInfo(itemLink))
    local itemLevel = select(4,GetItemInfo(itemLink))
    local itemType = select(6,GetItemInfo(itemLink))
    local itemEquipLoc = select(9,GetItemInfo(itemLink))
    local LocName = _G[itemEquipLoc]
    if itemQuality then
        Color = ITEM_QUALITY_COLORS[itemQuality].hex
    end
    return Color,itemType,LocName,itemLevel
end
----------------------------
-- Set Level To Container --
--   Level,Part,Quality   --
----------------------------
function ShowItemLevelAndPart(bag,number)
    if not bag.size then
        return
    end
    for i = 1, bag.size do
        local button = _G[bag:GetName().."Item"..i]
        Per_ShowItemLevel(button,number)
    end
end

function Per_ShowItemLevel(self,number)
    local itemLink = GetContainerItemLink(self:GetParent():GetID(),self:GetID())
    Min_ShowItemLevel(itemLink,number,self)
end

function Min_ShowItemLevel(link,number,self)
    local Colors,itemType,LocName,itemLevel
    if link then
        Colors,itemType,LocName,itemLevel = SEGetContainerItemInfo(link)
    end
    local levelshowLeveltext = FontString("levelshowLeveltext",self)
    if (itemType == WEAPON  or itemType == ARMOR) and _SVDB.IsLevelShow[number] then
        Style[levelshowLeveltext]    = {
            text = Colors..tostring(itemLevel),
            location = { Anchor(ItemLocation[_SVDB.LevelSetPartLocation[number]])},
            font        = {
                font    = SEFontStyle[_SVDB.FontStyleSet].value,
                height  = _SVDB.LevelSetPartSize[number],
                monochrome = false,
                outline = "NORMAL"
            },
        }
    else
        Style[levelshowLeveltext]    = {
            text = "",
        }
    end
end