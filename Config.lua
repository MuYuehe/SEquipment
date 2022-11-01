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
NUM_RESET = 0
local standardFont
local leftbrackets = "("
local rightbrackets = ")"
if _Locale("zhCN") then
    leftbrackets = "（"
    rightbrackets = "）"
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
LevelLocation     = { "TOP","BOTTOM", }
PartLocation      = { "BOTTOM", "TOP", }
EquipInfoLocation = { L["TOP"], L["BOTTOM"], }
LevelSetPartHeaderText = {
    L["Level Self"], L["Level Target"]
}
-- LevelSetPartHeaderText = {
--     L["Level Self"], L["Level Target"], L["Level Bag"],
--     L["Level Bank"], L["Level GB"], L["Level Guild"],
--     L["Level Chat"]
-- }
Options = {
    L["Show List Module"], L["Show Specialization"],
    L["Show Stats Icon"], L["Show Slots"],
    L["Show Level Module"], L["Show GemEnchant"],
    L["Show Attributes"],
}
-- 不要模仿
local Parts = {
    L["Head"],      L["Neck"],      L["Shoulders"], "",
    L["Chest"],     L["Waist"],     L["Legs"],      L["Feet"],
    L["Wrist"],     L["Hands"],     L["Finger"],    L["Trinket"],
    L["Main Hand"], L["Off Hand"],  L["Main Hand"], L["Back"],
    L["Main Hand"], "",             "",             L["Chest"],
    L["Main Hand"], L["Off Hand"],  L["Off Hand"],  "",
    "",             L["Main Hand"], "",             "",
}
--裝備清單
SlotButton = {
    { index = 1, name = HEADSLOT, },
    { index = 2, name = NECKSLOT, },
    { index = 3, name = SHOULDERSLOT, },
    { index = 5, name = CHESTSLOT, },
    { index = 6, name = WAISTSLOT, },
    { index = 7, name = LEGSSLOT, },
    { index = 8, name = FEETSLOT, },
    { index = 9, name = WRISTSLOT, },
    { index = 10, name = HANDSSLOT, },
    { index = 11, name = FINGER0SLOT, },
    { index = 12, name = FINGER1SLOT, },
    { index = 13, name = TRINKET0SLOT, },
    { index = 14, name = TRINKET1SLOT, },
    { index = 15, name = BACKSLOT, },
    { index = 16, name = MAINHANDSLOT, },
    { index = 17, name = SECONDARYHANDSLOT, },
}
-- local EnchantParts = {
--     [5]  = { 1, CHESTSLOT },
--     [8]  = { 1, FEETSLOT },
--     [11] = { 1, FINGER0SLOT },
--     [12] = { 1, FINGER1SLOT },
--     [15] = { 1, BACKSLOT },
--     [16] = { 1, MAINHANDSLOT },
--     [17] = { 1, SECONDARYHANDSLOT },
-- }
-- Base Stats
local BaseStats = {
    -------MasteryEffect,BaseMastery,BaseCrit
    -- dk
    [250] = { 2, 16, 5, },
    [251] = { 2, 16, 5, },
    [252] = { 2.26, 18, 5, },
    -- dh
    [577] = { 1.8, 14, 10, },
    [581] = { 3,   24, 10, },
    -- xd
    [102] = { 1.1, 9, 5, },
    [103] = { 2, 16, 10, },
    [104] = { 0.5, 4, 10, },
    [105] = { 0.5, 4, 5, },
    -- lr
    [253] = { 1.9, 15, 10, },
    [254] = { 0.625, 5, 10, },
    [255] = { 1.66, 13, 10, },
    -- fs
    [62]  = { 1.2, 9.6, 5, },
    [63]  = { 0.75, 6, 5, },
    [64]  = { 1, 8, 5, },
    -- ws
    [268] = { 1, 8, 10, },
    [270] = { 4.2, 34, 5, },
    [269] = { 1.25, 10, 10, },
    -- qs
    [65]  = { 1.5, 12, 5, },
    [66]  = { 1, 8, 5, },
    [70]  = { 1.6, 13, 5, },
    -- ms
    [256] = { 1.35, 10.8, 5, },
    [257] = { 1.25, 10, 5, },
    [258] = { 0.5, 4, 5, },
    -- dz
    [259] = { 1.7, 14, 10, },
    [260] = { 1.45, 18, 10, },
    [261] = { 2.45, 19.6, 10, },
    -- sm
    [262] = { 1.876, 15, 10, },
    [263] = { 2, 0.64, 10, },
    [264] = { 3, 24, 10, },
    -- ss
    [265] = { 2.5, 20, 5, },
    [266] = { 1.45, 12, 5, },
    [267] = { 2, 8, 5, },
    -- zs
    [71]  = { 1.1, 9, 5, },
    [72]  = { 1.4, 11, 5, },
    [73]  = { 0.5, 4, 5, },
}
-----------------------------------------------------------
--                      Function                         --
-----------------------------------------------------------
class "SEFontString" { FontString }
class "SGFontString" { FontString }
Style.UpdateSkin("Default", {
    [SEFontString] = {
        font     = {
            font   = SEFontStyle[1].value,
            height = 14,
        }
    },
    [SGFontString] = {
        font     = {
            font   = SEFontStyle[1].value,
            height = 12,
        }
    }
})
----------------------------
--      GetEquipInfo      --
--  Name,Quality,EquipLoc --
----------------------------
function Get_Item_Info(link)
    local name      = ""
    local quality   = ""
    local itemType  = ""
    local equipLoc  = ""
    if link then
        if not C_Item.IsItemDataCachedByID(link) then return name,quality,itemType,equipLoc end
        name,_,quality  = GetItemInfo(link)
        itemType        = select(6,GetItemInfo(link))
        local invType   = C_Item.GetItemInventoryTypeByID(link)
        if invType ~= 0 then
            equipLoc    = Parts[invType]
        end
        return name,quality,itemType,equipLoc
    else
        return name,quality,itemType,equipLoc
    end
end
----------------------------
-- GetAvgItemLevelEquiped --
--       Only Target      --
----------------------------
function Get_Inspect_Item_Level(unit)
    local AvgItemLevelEquiped =  C_PaperDollInfo.GetInspectItemLevel(unit)
    if AvgItemLevelEquiped then
        return ("%.1f"):format(AvgItemLevelEquiped)
    else
        return ""
    end
end
----------------------------
--    GetEquipedGemInfo   --
--           Gem          --
----------------------------
function Get_Equiped_Info(link)
    local Gem1              = 0
    local Gem2              = 0
    local Gem3              = 0
    local Gem4              = 0
    local ExistGemNumber    = 0
    if not link then
        return Gem1,Gem2,Gem3,Gem4,ExistGemNumber
    end
    local linkinfo          = {}--非返回值
    for i, v in pairs({strsplit(":", link)}) do
        if #v > 0 then
            linkinfo[i]     = v
        else
            linkinfo[i]     = 1
        end
        if i == 7 then
            break;
        end
    end
    for k, v in pairs(linkinfo) do
        -- key>1,直接开始遍历宝石跟附魔
        -- 如果存在宝石,则存入宝石的ID,否则存入的value为 1
        if k == 4 and v ~= 1 then
            Gem1            = v
            ExistGemNumber  = ExistGemNumber + 1
        elseif k == 5 and v ~= 1 then
            Gem2            = v
            ExistGemNumber  = ExistGemNumber + 1
        elseif k == 6 and v ~= 1 then
            Gem3            = v
            ExistGemNumber  = ExistGemNumber + 1
        elseif k == 7 and v ~= 1 then
            Gem4            = v
            ExistGemNumber  = ExistGemNumber + 1
        end
    end
    return Gem1,Gem2,Gem3,Gem4,ExistGemNumber
end
----------------------------
--       GetSpecInfo      --
--     Name,ID,IconID     --
----------------------------
function Get_Spec_Info(unit)
    local name      = ""
    local id        = 0
    local iconId    = 0
    if GetInspectSpecialization(unit) and unit ~= "player" then
        id,name,_,iconId = GetSpecializationInfoByID(GetInspectSpecialization(unit))
    elseif UnitClass(unit) and GetSpecialization() and unit == "player" then
        local _,_,ClassID = UnitClass("player")
        id,name,_,iconId = GetSpecializationInfoForClassID(ClassID,GetSpecialization())
    end
    return name,id,iconId
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
function GetEachEquipInfo(link)
    local CritNumber            = 0
    local HasteNumber           = 0
    local MasteryNumber         = 0
    local VersaNumber           = 0
    local EmptyGemNumber        = 0     --未镶嵌宝石数量
    local ItemLevel             = 0
    local EnchantInfo           = ""
    local isPVPSet              = false --查看是否为具有PVP属性
    local ItemSetId             = ""
    if (not link) then
        return ItemLevel, CritNumber, HasteNumber, MasteryNumber, VersaNumber, EmptyGemNumber, EnchantInfo, isPVPSet, ItemSetId
    end
    -- 拿到套装的ID,不是套装的返回值为 nil
    ItemSetId                   = select(16,GetItemInfo(link))
    -- 保持返回值一致性
    if ItemSetId == nil then ItemSetId = "" end
    for _,left,right in GetGameTooltipLines("Hyperlink",link) do
        if left then
            -- 拿到附魔信息
            if string.match(left, ENCHANTS) then
                EnchantInfo = left
            end
            -- 爆击词条
            if string.find(left,STAT_CRITICAL_STRIKE) and string.find(left,"+") then
                CritNumber      = CritNumber + tonumber(string.match(left,"%d+"))

            -- 急速词条
            elseif string.find(left,STAT_HASTE) and string.find(left,"+") then
                HasteNumber     = HasteNumber + tonumber(string.match(left, "%d+"))

            -- 精通词条
            elseif string.find(left,STAT_MASTERY) and string.find(left,"+") then
                MasteryNumber   = MasteryNumber + tonumber(string.match(left, "%d+"))

            -- 全能词条
            elseif string.find(left,STAT_VERSATILITY) and string.find(left,"+") then
                VersaNumber     = VersaNumber + tonumber(string.match(left, "%d+"))

            -- 物品装等
            elseif string.find(left,ITEM_LEVEL) then
                ItemLevel       = tonumber(string.match(left,"%d+"))

            -- 未镶嵌宝石数目
            elseif IsDominationGem(left,Sockets) then
                EmptyGemNumber  = EmptyGemNumber + 1
            
            -- 判断此装备是否有PVP效果
            elseif string.find(left,"PvP") then
                isPVPSet = true
            end
        end
    end
    return ItemLevel, CritNumber, HasteNumber, MasteryNumber, VersaNumber, EmptyGemNumber, EnchantInfo, isPVPSet, ItemSetId
end
-- 判断表中有无元素
function IsDominationGem(meta,table)
    for _, value in ipairs(table) do
        if tostring(meta) == tostring(value) then
            return true
        end
    end
    return false
end
----------------------------
--     GetStatsPercent    --
----------------------------
-- function GetStatsPercent(number,statsname,unit,SpecID)
--     if not BaseStats[SpecID] then
--         return ""
--     end
--     local _,_,raceID = UnitRace(unit)
--     local Percent = 0
--     if raceID == 1 then
--         number = number * (1 + 0.02)
--     end
--     if statsname == 1 or statsname == 3 then
--         -- 暴击 精通
--         if number <=1050 then
--             Percent = number/35
--         elseif number > 1050 and number <= 1400 then
--             Percent = 30 + (number-1050)*0.9/35
--         elseif number > 1400 and number <= 1750 then
--             Percent = 39 + (number-1400)*0.8/35
--         elseif number > 1750 and number <= 2100 then
--             Percent = 47 + (number-1750)*0.7/35
--         elseif number > 2100 and number <= 2800 then
--             Percent = 54 + (number-2100)*0.6/35
--         elseif number > 2800 and number <= 7000 then
--             Percent = 66 + (number-2800)*0.5/35
--         else
--             Percent = 126
--         end
--         if statsname == 3 and BaseStats[SpecID][1] then
--             Percent = Percent * BaseStats[SpecID][1] --XXX精通系数 GetMasteryEffect()
--         end
--     elseif statsname == 2 then
--         -- 急速
--         if number <=990 then
--             Percent = number/33
--         elseif number > 990 and number <= 1320 then
--             Percent = 30 + (number-990)*0.9/33
--         elseif number > 1320 and number <= 1650 then
--             Percent = 39 + (number-1320)*0.8/33
--         elseif number > 1650 and number <= 1980 then
--             Percent = 47 + (number-1650)*0.7/33
--         elseif number > 1980 and number <= 2640 then
--             Percent = 54 + (number-1980)*0.6/33
--         elseif number > 2640 and number <= 6600 then
--             Percent = 66 + (number-2640)*0.5/33
--         else
--             Percent = 126
--         end
--     elseif statsname == 4 then
--         -- 全能
--         if number <=1200 then
--             Percent = number/40
--         elseif number > 1200 and number <= 1600 then
--             Percent = 30 + (number-1200)*0.9/40
--         elseif number > 1600 and number <= 2000 then
--             Percent = 39 + (number-1600)*0.8/40
--         elseif number > 2000 and number <= 2400 then
--             Percent = 47 + (number-200)*0.7/40
--         elseif number > 2400 and number <= 3200 then
--             Percent = 54 + (number-2400)*0.6/40
--         elseif number > 3200 and number <= 8000 then
--             Percent = 66 + (number-3200)*0.5/40
--         else
--             Percent = 126
--         end
--     end
--     if statsname == 1 and BaseStats[SpecID][3] then
--         Percent = Percent + BaseStats[SpecID][3]
--         if raceID == 10 or raceID == 4 or raceID == 12 then
--             Percent = Percent + 1
--         end
--     elseif statsname == 2 then
--         if raceID == 7 then
--             Percent = Percent + 1
--         end
--     elseif statsname == 3 and BaseStats[SpecID][2] then
--         Percent = Percent + BaseStats[SpecID][2]
--     elseif statsname == 4 then
--         if raceID == 28 or raceID == 32 then
--             Percent = Percent + 1
--         end
--     end
--     return ("%.1f"):format(Percent).."%"
-- end

----------------------------
--      Pure Function     --
----------------------------
function Sum_Table(table)
    local sum = 0
    for index, value in ipairs(table) do
        if value then
            sum = sum + tonumber(value)
        end
    end
    return sum
end
function Get_FontString_Width(text)
    local GetWidthFontString = FontString("GetWidthFontString")
    GetWidthFontString:SetText(text)
    GetWidthFontString:Hide()
    return GetWidthFontString:GetStringWidth()
end
function Get_Useful_Info(table)
    local number = 0
    for index, value in ipairs(table) do
        if not (value == "" or value == 0) then
            number = number + 1
        end
    end
    return number
end
function Get_Max_String_Width(table)
    local String = 0
    for _, value in ipairs(table) do
        if value > String then
            String = value
        end
    end
    return String
end
function Get_Same_Mate(list)
    local currentValue = {}
    local resultTable = {}
    for _, value in ipairs(list) do
        -- 判断是否在当前表中
        local boolean = true
        for _, v in ipairs(currentValue) do
            if v == value then
                boolean = false
                break
            end
        end
        while boolean do
            -- 不在当前表则嵌入表
            table.insert(currentValue, value)
            local time = 0
            -- 找到相同元素
            for i, v in ipairs(list) do
                if v == value then
                    time = time + 1
                end
            end
            if time >= 1 then
                table.insert(resultTable, value..leftbrackets..time..rightbrackets)
            end
            -- 防止死循环
            break
        end
    end
    return resultTable
end
----------------------------
-- Set Level To Container --
--   Level,Part,Quality   --
----------------------------
function Set_Per_Item_Level(self,link,number)
    local leveltext                             = FontString("leveltext",self)
    local parttext                              = FontString("parttext",self)
    if link and _SVDB and _SVDB.IsLevelShow[number] then
        local name,quality,itemType,equipLoc    = Get_Item_Info(link)
        if not (itemType == WEAPON or itemType == ARMOR) then
            Style[leveltext]                    = {
                text                            = "",
            }
            Style[parttext]                     = {
                text                            = "",
            }
            return
        end
        local itemlevel                         = select(1,GetEachEquipInfo(link))
        if itemlevel == 0 then
            itemlevel                           = ""
        end
        local SET_ITEM_QUALITY_COLOR            = ITEM_QUALITY_COLORS[quality].hex
        Style[leveltext]                        = {
            text                                = SET_ITEM_QUALITY_COLOR..tostring(itemlevel),
            location                            = { Anchor(LevelLocation[_SVDB.LevelSetPartLocation[number]])},
            font                                = {
                font                            = SEFontStyle[_SVDB.FontStyleSet].value,
                height                          = _SVDB.LevelSetPartSize[number],
                monochrome                      = false,
                outline                         = "NORMAL"
            }
        }
        Style[parttext]                         = {
            text                                = SET_ITEM_QUALITY_COLOR..equipLoc,
            location                            = { Anchor(PartLocation[_SVDB.LevelSetPartLocation[number]]) },
            font                                = {
                font                            = SEFontStyle[_SVDB.FontStyleSet].value,
                height                          = _SVDB.LevelSetPartSize[number] - 4,
                monochrome                      = false,
                outline                         = "NORMAL"
            }
        }
    else
        Style[leveltext]                        = {
            text                                = "",
        }
        Style[parttext]                         = {
            text                                = "",
        }
    end
end