local SESlots={
    {index=1,name=INVSLOT_HEAD},--头
    {index=2,name=INVSLOT_NECK},--脖子
    {index=3,name=INVSLOT_SHOULDER},--肩膀
    {index=5,name=INVSLOT_CHEST},--胸
    {index=6,name=INVSLOT_WAIST},--腰
    {index=7,name=INVSLOT_LEGS},--腿
    {index=8,name=INVSLOT_FEET},--脚
    {index=9,name=INVSLOT_WRIST},--手腕
    {index=10,name=INVSLOT_HAND},--手
    {index=11,name=INVSLOT_FINGER1},--手指1
    {index=12,name=INVSLOT_FINGER2},--手指2
    {index=13,name=INVSLOT_TRINKET1},--饰品1
    {index=14,name=INVSLOT_TRINKET2},--饰品2
    {index=15,name=INVSLOT_BACK},--披风
    {index=16,name=INVSLOT_MAINHAND},--主手
    {index=17,name=INVSLOT_OFFHAND},--副手
}

local SESlots_E = {
    {index = 1,name = INVSLOT_CHEST},
    {index = 2,name = INVSLOT_WRIST},
    {index = 3,name = INVSLOT_FINGER1},
    {index = 4,name = INVSLOT_FINGER2},
    {index = 5,name = INVSLOT_BACK},
    {index = 6,name = INVSLOT_FEET},
    {index = 7,name = INVSLOT_HAND},
    {index = 8,name = INVSLOT_MAINHAND},
    {index = 9,name = INVSLOT_OFFHAND},
}

local SESlots_G={
    {index="Interface\\AddOns\\SEquipment\\statsicons\\CRIT",name="ITEM_MOD_CRIT_RATING_SHORT",CName="爆击"},--爆击
    {index="Interface\\AddOns\\SEquipment\\statsicons\\HASTE",name="ITEM_MOD_HASTE_RATING_SHORT",CName="急速"},--急速
    {index="Interface\\AddOns\\SEquipment\\statsicons\\MASTERY",name="ITEM_MOD_MASTERY_RATING_SHORT",CName="精通"},--精通
    {index="Interface\\AddOns\\SEquipment\\statsicons\\VERSATILITY",name="ITEM_MOD_VERSATILITY",CName="全能"},--全能
}

local font = "Fonts\\ARKai_T.TTF"
-- 框体集合
local frames={}
local backdrop={
    bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile=true,
    tileSize=8,
    edgeSize=10,
    insets={ left=0,right=0,top=0,bottom=0},
}
-- 创建框体函数
function Frame(name,parent,width,hight,r,g,b,a)
    if not frames[name] then
        frames[name] = CreateFrame("Frame",nil,parent,"BackdropTemplate")
        frames[name]:SetBackdrop(backdrop)
        frames[name]:SetBackdropBorderColor(0,0,0,0)
    end
    local Frame = frames[name]
    if width and hight then
        Frame:SetSize(width,hight)
    end
    if r and g and b and a then
        Frame:SetBackdropColor(r,g,b,a)
    end

    return Frame
end
-- 创建模板
function CreateSEFrame(parent,unit)
    local MainFrame = Frame("Main_"..unit,parent,200,425,0,0,0,0.7)

    local HeadFrame = Frame("Head_"..unit,MainFrame,200,30,1,0,0,0)
    HeadFrame:SetPoint("TOPLEFT",0,0)

    HeadFrame.ItemString = HeadFrame.ItemString or HeadFrame:CreateFontString(nil,"ARTWORK","ChatFontNormal")
    HeadFrame.ItemString:SetPoint("CENTER",0,0)

    local AvgItemLevelEquipped
    if unit == "player" then
        _,AvgItemLevelEquipped = GetAverageItemLevel()
    elseif unit == "target" then
        AvgItemLevelEquipped = C_PaperDollInfo.GetInspectItemLevel(unit)
    end
    HeadFrame.ItemString:SetText(("装等:%.1f"):format(AvgItemLevelEquipped).."  ".."天赋:"..GetSpec(unit))
    HeadFrame.ItemString:SetFont(font,14)

    local InfoFrame = Frame("Info_"..unit,MainFrame,200,270,0,1,0,0)
    InfoFrame:SetPoint("TOPLEFT",0,-30)

    local InfoListFrame = Frame("InfoList_"..unit,InfoFrame,140,270,0,1,0,0)
    InfoListFrame:SetPoint("TOPLEFT",70,0)

    local SplitLine = Frame("SL_"..unit,InfoFrame,2,270,1,1,1,0)
    SplitLine:SetPoint("TOPLEFT",67,0)

    local InfoGreenFrame = Frame("InfoGreen_"..unit,InfoFrame,60,270,0,0,1,0)
    InfoGreenFrame:SetPoint("TOPLEFT",5,0)

    local GemFrame = Frame("Gem_"..unit,MainFrame,200,25,0,1,0,0)
    GemFrame:SetPoint("TOPLEFT",0,-300)
    GemFrame.ItemString = GemFrame:CreateFontString(nil,"ARTWORK","ChatFontNormal")
    GemFrame.ItemString:SetPoint("CENTER",0,0)
    GemFrame.ItemString:SetFont(font,14)

    local TongYuFrame = Frame("TongYu_"..unit,MainFrame,200,40,0,1,0,0)
    TongYuFrame:SetPoint("TOPLEFT",0,-385)
    TongYuFrame.ItemString = TongYuFrame:CreateFontString(nil,"ARTWORK","ChatFontNormal")
    TongYuFrame.ItemString:SetPoint("CENTER",0,0)
    TongYuFrame.ItemString:SetFont(font,14)

    local StatsFrame = Frame("Stats_"..unit,MainFrame,200,60,1,0,0,0)
    StatsFrame:SetPoint("TOPLEFT",0,-325)
    local Green_L = {}
    local Green_R = {}
    for k, v in pairs(SESlots_G) do
        local StatsFrame_Son_LEFT = Frame("Stats_Son_LEFT_"..k..unit,StatsFrame,50,15,0,0,0,0)
        StatsFrame_Son_LEFT:SetPoint("TOPLEFT",0,(k-1)*(-15))
        StatsFrame_Son_LEFT.ItemString = StatsFrame_Son_LEFT:CreateFontString(nil,"ARTWORK","ChatFontNormal")
        StatsFrame_Son_LEFT.ItemString:SetPoint("LEFT",3,0)
        StatsFrame_Son_LEFT.ItemString:SetFont(font,14)
        Green_L[k] = StatsFrame_Son_LEFT.ItemString

        local StatsFrame_Son_RIGHT = Frame("Stats_Son_RIGHT_"..k..unit,StatsFrame,50,15,0,0,0,0)
        StatsFrame_Son_RIGHT:SetPoint("TOPLEFT",50,(k-1)*(-15))
        StatsFrame_Son_RIGHT.ItemString = StatsFrame_Son_RIGHT:CreateFontString(nil,"ARTWORK","ChatFontNormal")
        StatsFrame_Son_RIGHT.ItemString:SetPoint("LEFT",0,0)
        StatsFrame_Son_RIGHT.ItemString:SetFont(font,14)
        Green_R[k] = StatsFrame_Son_RIGHT.ItemString
    end
    
    local ItemString = {}
    local Tex = {}


    for key, value in pairs(SESlots) do
        local InfoListFrame_Son = Frame("InfoList_Son_"..key..unit,InfoListFrame,140,270/#SESlots,0,1,0,0)
        InfoListFrame_Son:SetPoint("TOPLEFT",0,-(key-1)*(270/#SESlots))

        local InfoGreenFrame_Son = Frame("InfoGreen_Son_"..key..unit,InfoGreenFrame,60,270/#SESlots,0,0,1,0)
        InfoGreenFrame_Son:SetPoint("TOPLEFT",0,-(key-1)*(270/#SESlots))

        InfoListFrame_Son.ItemString = InfoListFrame_Son:CreateFontString(nil,"ARTWORK","ChatFontNormal")
        InfoListFrame_Son.ItemString:SetPoint("LEFT",0,0)
        InfoListFrame_Son.ItemString:SetFont(font,14)
        ItemString[key] = InfoListFrame_Son.ItemString

        Tex[key] = {}
        for k, v in pairs(SESlots_G) do
            local InfoGreenFrame_Son_Part = Frame("InfoGreen_Son_Part_"..k..key..unit,InfoGreenFrame_Son,15,270/#SESlots,0,0,1,0)
            InfoGreenFrame_Son_Part:SetPoint("TOPLEFT",(k-1)*15,0)

            local InfoGreenFrame_Son_Part_Mix = Frame("InfoGreen_Son_Part_Mix"..k..key..unit,InfoGreenFrame_Son_Part,15,15,0,0,1,0)
            InfoGreenFrame_Son_Part_Mix:SetPoint("RIGHT",0,0)

            InfoGreenFrame_Son_Part_Mix.Tex = InfoGreenFrame_Son_Part_Mix:CreateTexture()
            InfoGreenFrame_Son_Part_Mix.Tex:SetAllPoints(InfoGreenFrame_Son_Part_Mix)

            Tex[key][k] = InfoGreenFrame_Son_Part_Mix.Tex
        end
    end

    return MainFrame,ItemString,Tex,HeadFrame.ItemString,Green_L,Green_R,GemFrame.ItemString,TongYuFrame.ItemString
end
-- 获取装备链接与名字
function GetInvList(unit)
    local InvLink = {}
    local InvName = {}
    for key, value in pairs(SESlots) do
        local ItemLocation = GetInventoryItemLink(unit,value.index)
        if ItemLocation ~= nil then
            InvName[key] = GetItemInfo(ItemLocation)
            InvLink[key] = ItemLocation
        else
            InvLink[key] = ""
            InvName[key] = ""
        end
    end

    return InvName,InvLink
end
-- 获取插槽数目（区分统御与其他宝石）
function GetGemsAll(unit)
    local number,TongYuNumber = 0,0
    local _,InvLink = GetInvList(unit)
    local stats = {}
    for key, value in pairs(SESlots) do
        if InvLink[key] ~= "" then
          stats = GetItemStats(InvLink[key])
          for k , v in pairs(stats) do
              if string.find(k,"EMPTY_SOCKET_") then
                  for i = 1, v do
                      number = number + 1
                  end
              end
              if string.find(k,"EMPTY_SOCKET_DOMINATION") then
                  for i = 1, v do
                      TongYuNumber = TongYuNumber + 1
                  end
              end
          end
        end
    end
    number = number - TongYuNumber
    
    return number,TongYuNumber
end
-- 获取实际宝石数（区分统御与其他宝石）
function GetGems(unit)
    -- 普通插槽实际宝石数
    local GemNumber = 0
    -- 统御插槽实际宝石数
    local TongYu = {}
    local TongYuNumber = 0
    local _,InvLink = GetInvList(unit)
    for key, value in pairs(SESlots) do
        if InvLink[key] ~= "" then
            local LinkInfo = GetInfomation(InvLink[key])
            if LinkInfo[4] then
                if Bloon(tonumber(LinkInfo[4]))==1 then
                    table.insert(TongYu,GetDominateName(tonumber(LinkInfo[4])))
                    TongYuNumber = TongYuNumber + 1
                else
                    GemNumber = GemNumber + 1
                end
            end
            if LinkInfo[5] then
                if Bloon(tonumber(LinkInfo[5]))==1 then
                    table.insert(TongYu,GetDominateName(tonumber(LinkInfo[5])))
                    TongYuNumber = TongYuNumber + 1
                else
                    GemNumber = GemNumber + 1
                end
            end
            if LinkInfo[6] then
                if Bloon(tonumber(LinkInfo[6]))==1 then
                    table.insert(TongYu,GetDominateName(tonumber(LinkInfo[6])))
                    TongYuNumber = TongYuNumber + 1
                else
                    GemNumber = GemNumber + 1
                end
            end
            if LinkInfo[7] then
                if Bloon(tonumber(LinkInfo[7]))==1 then
                    table.insert(TongYu,GetDominateName(tonumber(LinkInfo[7])))
                    TongYuNumber = TongYuNumber + 1
                else
                    GemNumber = GemNumber + 1
                end
            end
        end
    end

    return GemNumber,TongYu,TongYuNumber
end

-- 获取可附魔总数与可附魔装备链接
function GetEnchantNumber(unit,Slots)
    local Slot = Slots
    local number = 0
    local EnchantLink = {}
    for key, value in pairs(Slot) do
        local ItemLocation = GetInventoryItemLink(unit,value.name)
        if ItemLocation ~= nil then
            number = number + 1
            EnchantLink[key] = ItemLocation
        end
    end
    
    return number,EnchantLink
end
-- 获取实际附魔数
function GetEnchantActuallyNmuber(enchantlink)
    local number = 0
    local LinkInfo = {}
    for key, value in pairs(enchantlink) do
        LinkInfo = GetInfomation(value)
        if LinkInfo[3] then
            number = number + 1
        end
    end

    return number
end
-- 获取装备信息（包括附魔、宝石）
function GetInfomation(link)
    local LinkInfo = {}
    for k, v in pairs({strsplit(":", link)}) do
        if #v > 0 then
            LinkInfo[k] = v
        end
    end

    return  LinkInfo
end
-- 防止装备名字过长显示
function CutInvName(InvName)
    local NameList = InvName
    for key, value in pairs(NameList) do
        if string.len(value) > 18 and value ~= "" then
            NameList[key] = string.sub(value,1,15).."..."
        elseif string.len(value) <= 18 and value ~= "" then
            NameList[key] = value
        end
    end

    return NameList
end
-- 获取装备品质与等级（目前传家宝等级获取不稳定）
function GetInvInfo(InvLink)
    local LinkList = InvLink
    local ItemQuality = {}
    local ItemLevel = {}
    for key, value in pairs(LinkList) do

        if value ~= "" then
            local _,_,itemQuality = GetItemInfo(value)
            local itemLevel = GetDetailedItemLevelInfo(value)
            ItemQuality[key] = itemQuality
            ItemLevel[key] = itemLevel
        else
            ItemQuality[key] = ""
            ItemLevel[key] = ""
        end
    end

    return ItemQuality,ItemLevel
end
-- 获取装备品质颜色
function GetInvColor(ItemQuality)
    local r,g,b,a
    if ItemQuality ~= "" then
        r,g,b=GetItemQualityColor(ItemQuality)
        a=0.8
    else
        r,g,b,a=0,0,0,0
    end
    
    return r,g,b,a
end
-- 获取装备绿字
function GetInvStats(InvLink,Slots_G)
    local LinkList,Slots = InvLink,Slots_G
    local Stats = {}
    local CritNumber,HasteNumber,MasteryNumber,VersatilityNumber = 0,0,0,0
    for key, value in pairs(LinkList) do
        Stats[key]={}
        if value ~= "" then
            local stats = GetItemStats(value)
            if stats[Slots[1].name] then
                Stats[key][1] = 1
                CritNumber = CritNumber + tonumber(stats[Slots[1].name])
            else
                Stats[key][1] = 0
            end
            if stats[Slots[2].name] then
                Stats[key][2] = 1
                HasteNumber = HasteNumber + tonumber(stats[Slots[2].name])
            else
                Stats[key][2] = 0
            end
            if stats[Slots[3].name] then
                Stats[key][3] = 1
                MasteryNumber = MasteryNumber + tonumber(stats[Slots[3].name])
            else
                Stats[key][3] = 0
            end
            if stats[Slots[4].name] then
                Stats[key][4] = 1
                VersatilityNumber = VersatilityNumber + tonumber(stats[Slots[4].name])
            else
                Stats[key][4] = 0
            end
        else
            Stats[key][1] = 0
            Stats[key][2] = 0
            Stats[key][3] = 0
            Stats[key][4] = 0
        end
    end
    return Stats,CritNumber,HasteNumber,MasteryNumber,VersatilityNumber
end
-- 获取天赋名称
function GetSpec(unit)
    local SpecID,_,SpecName
    if unit == "player" then
        local _,_,ClassID = UnitClass(unit)
        SpecID = GetSpecialization()
        if SpecID then
            _,SpecName = GetSpecializationInfoForClassID(ClassID,SpecID)
        else
            SpecName = "未知"
        end
    elseif unit == "target" then
        SpecID = GetInspectSpecialization(unit)
        if SpecID ~= 0  and CanInspect(unit) then
            _,SpecName = GetSpecializationInfoByID(SpecID)
        else
            SpecName = "未知"
        end
    end

    return SpecName
end

-- 无关函数
function TableLen(table)
    local long = 0
    for key, value in pairs(table) do
        long = long + 1
    end

    return long
end

function ShowChangeItem(unit,ItemString,Tex,ILevel,Green_L,Green_R,Gem,TongYu)
    local InvName,InvLink = GetInvList(unit)
    local NameList = CutInvName(InvName)
    local ItemQuality,ItemLevel = GetInvInfo(InvLink)
    local Stats,CritNumber,HasteNumber,MasteryNumber,VersatilityNumber = GetInvStats(InvLink,SESlots_G)
    local GreenAll = {CritNumber,HasteNumber,MasteryNumber,VersatilityNumber}

    local EnchantNumber,EnchantLink = GetEnchantNumber(unit,SESlots_E)
    local RealEnchantNumber = GetEnchantActuallyNmuber(EnchantLink)
    local GemRealNumber,TongYuInfo,TongYuRealNumber = GetGems(unit)
    local GemAlls,TongYuAlls = GetGemsAll(unit)
    local _,AvgItemLevelEquipped= GetAverageItemLevel()
    ILevel:SetText(("装等:%.1f"):format(AvgItemLevelEquipped).."  ".."天赋:"..GetSpec(unit))
    Gem:SetText("附魔:"..EnchantNumber.."/"..RealEnchantNumber.."宝石:"..GemAlls.."/"..GemRealNumber.."".."统御:"..TongYuAlls.."/"..TongYuRealNumber)
    Gem:SetTextColor(1,0.9,0,0.7)
    if TableLen(TongYuInfo) == 5 then
        TongYu:SetText(table.concat(TongYuInfo,""))
    else
        TongYu:SetText(table.concat(TongYuInfo,"/"))
    end
    TongYu:SetTextColor(1,0.9,0,0.7)
    for k, v in pairs(SESlots_G) do
        Green_L[k]:SetText(v.CName..":")
        Green_L[k]:SetTextColor(1,0.9,0,0.7)
        Green_R[k]:SetText("+"..GreenAll[k].."     +"..("%.1f"):format(GetPercent(GreenAll[k],k)).."%")
        Green_R[k]:SetTextColor(0,0.9,0.1,0.7)
    end
    for key, value in pairs(SESlots) do
        local ItemString_Get = ItemString[key]
        local r,g,b,a = GetInvColor(ItemQuality[key])
        ItemString_Get:SetText(ItemLevel[key].." "..NameList[key])
        ItemString_Get:SetTextColor(r,g,b,a)

        for k, v in pairs(SESlots_G) do
            local Tex_Get = Tex[key][k]

            if Stats[key][k] == 1 then
                Tex_Get:SetTexture(SESlots_G[k].index)
            else
                Tex_Get:SetTexture("")
            end
        end
    end
end

-- [[************************主体**************************]]
local a = 0

local PlayerFrame,ItemString_P,Tex_P,ILevel_P,Green_L_P,Green_R_P,Gem_P,TongYu_P = CreateSEFrame(CharacterFrame,"player")
PlayerFrame:SetBackdropBorderColor(0,0,0,1)
PlayerFrame:SetPoint("TOPRIGHT",200,0)

local TargetFrame,ItemString_T,Tex_T,ILevel_T,Green_L_T,Green_R_T,Gem_T,TongYu_T

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("ADDON_LOADED")
EventFrame:RegisterEvent("INSPECT_READY")
EventFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
EventFrame:RegisterEvent("PLAYER_TALENT_UPDATE")

EventFrame:SetScript("OnEvent",function (self,event,...)
    -- 观察目标界面时将显示装备列表
    if event == "INSPECT_READY" then
        local inspecteeGUID = ...
        if inspecteeGUID == UnitGUID("target") and TargetFrame ~= nil and ItemString_T ~= nil and Tex_T ~= nil and ILevel_T ~= nil and Green_L_T ~= nil and Green_R_T ~= nil and Gem_T ~= nil and TongYu_T ~= nil then
            ShowChangeItem("target",ItemString_T,Tex_T,ILevel_T,Green_L_T,Green_R_T,Gem_T,TongYu_T)
            if a == 0 then
                ShowChangeItem("player",ItemString_P,Tex_P,ILevel_P,Green_L_P,Green_R_P,Gem_P,TongYu_P)
                a = 1
            end
            if SEquipmentDB.button2 == true then
                if SEquipmentDB.button1 == true then
                    PlayerFrame:SetParent(InspectFrame)
                    PlayerFrame:SetPoint("TOPRIGHT",401,0)
                    PlayerFrame:Show()
                else
                    PlayerFrame:Hide()
                end
                TargetFrame:Show()
            else
                if SEquipmentDB.button1 == true then
                    PlayerFrame:SetParent(InspectFrame)
                    PlayerFrame:SetPoint("TOPRIGHT",200,0)
                    PlayerFrame:Show()
                else
                    PlayerFrame:Hide()
                end
                TargetFrame:Hide()
            end
            PlayerFrame:SetScale(InspectFrame:GetHeight()/425)
            TargetFrame:SetScale(InspectFrame:GetHeight()/425)
        end
    end

    -- 观察目标界面时创建目标装备列表框体
    if event == "ADDON_LOADED" then
        local addon = ...
        if addon == "Blizzard_InspectUI" then
            TargetFrame,ItemString_T,Tex_T,ILevel_T,Green_L_T,Green_R_T,Gem_T,TongYu_T = CreateSEFrame(InspectFrame,"target")
            TargetFrame:SetBackdropBorderColor(0,0,0,1)
            TargetFrame:SetPoint("TOPRIGHT",200,0)
        end
    end

    -- 更换装备、更换天赋，更新玩家装备列表
    if (event == "PLAYER_EQUIPMENT_CHANGED" or event == "PLAYER_TALENT_UPDATE") and a == 1 then
        ShowChangeItem("player",ItemString_P,Tex_P,ILevel_P,Green_L_P,Green_R_P,Gem_P,TongYu_P)
    end
end)

CharacterFrame:HookScript("OnShow",function (self)
    if SEquipmentDB.button1 == true then
        if (InspectFrame and InspectFrame:IsShown() == false) or InspectFrame == nil then
                PlayerFrame:SetParent(CharacterFrame)
                PlayerFrame:SetPoint("TOPRIGHT",200,1)
        end
        PlayerFrame:Show()
    else
        PlayerFrame:Hide()
    end
    ShowChangeItem("player",ItemString_P,Tex_P,ILevel_P,Green_L_P,Green_R_P,Gem_P,TongYu_P)
PlayerFrame:SetScale(CharacterFrame:GetHeight()/425)
    a = 1
end)