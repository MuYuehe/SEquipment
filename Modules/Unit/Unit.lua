Scorpio "SEquipment.core.unit" ""
--======================--
import "SEquipment.data"
import "SEquipment.Layout"
--======================--
L = _Locale
--======================--
-- Constant
--======================--
PER_ITEM_HEIGHT = 20
--======================--
-- Default Class
--======================--
class "UnitInfoFrame" (function (_ENV)
    inherit "Frame"

    function __ctor(self)
        -- ^.^
    end
end)

class "StatsInfoFrame" (function (_ENV)
    inherit "Frame"

    property "critData" { type = Table, handler = function(self, table)
        self.critName       = table[4] .. ":"
        self.critPercent    = table[1] .. "%"
        self.critNumber     = "+" .. table[2]
    end}
    property "hasteData" { type = Table, handler = function(self, table)
        self.hasteName       = table[4] .. ":"
        self.hastePercent    = table[1] .. "%"
        self.hasteNumber     = "+" .. table[2]
    end}
    property "masteryData" { type = Table, handler = function(self, table)
        self.masteryName       = table[4] .. ":"
        self.masteryPercent    = table[1] .. "%"
        self.masteryNumber     = "+" .. table[2]
    end}
    property "versaData" { type = Table, handler = function(self, table)
        self.versaName       = table[4] .. ":"
        self.versaPercent    = table[1] .. "%"
        self.versaNumber     = "+" .. table[2]
    end}
    __Observable__()
    property "critName" { type = String, default = ""}
    __Observable__()
    property "critPercent" { type = String, default = ""}
    __Observable__()
    property "critNumber" { type = String, default = ""}
    __Observable__()
    property "hasteName" { type = String, default = ""}
    __Observable__()
    property "hastePercent" { type = String, default = ""}
    __Observable__()
    property "hasteNumber" { type = String, default = ""}
    __Observable__()
    property "masteryName" { type = String, default = ""}
    __Observable__()
    property "masteryPercent" { type = String, default = ""}
    __Observable__()
    property "masteryNumber" { type = String, default = ""}
    __Observable__()
    property "versaName" { type = String, default = ""}
    __Observable__()
    property "versaPercent" { type = String, default = ""}
    __Observable__()
    property "versaNumber" { type = String, default = ""}

    __Template__ {
        CritInfoFrame = Frame,
        HastInfoFrame = Frame,
        MastInfoFrame = Frame,
        VersInfoFrame = Frame,
        {
            CritInfoFrame   = {
                name        = Frame,
                percent     = Frame,
                number      = Frame,
                {
                    name    = { font = FontString },
                    percent = { font = FontString },
                    number  = { font = FontString },
                }
            },
            HastInfoFrame = {
                name        = Frame,
                percent     = Frame,
                number      = Frame,
                {
                    name    = { font = FontString },
                    percent = { font = FontString },
                    number  = { font = FontString },
                }
            },
            MastInfoFrame = {
                name        = Frame,
                percent     = Frame,
                number      = Frame,
                {
                    name    = { font = FontString },
                    percent = { font = FontString },
                    number  = { font = FontString },
                }
            },
            VersInfoFrame = {
                name        = Frame,
                percent     = Frame,
                number      = Frame,
                {
                    name    = { font = FontString },
                    percent = { font = FontString },
                    number  = { font = FontString },
                }
            },
        }
    }

    function __ctor(self)
        -- ^.^
    end
end)

-- TODO 判断是否需要先应用样式,如果有问题,再应用
-- __InstantApplyStyle__()
class "PerSlotFrame" (function (_ENV)
    inherit "Frame"

    property "data" { type = Table, handler = function(self, table)
        -- table值为其中一件装备得信息,什么条件下继续向下进行,table["itemLink"]不为空
        if not table["itemLink"] then
            -- 如果table["itemLink"] == nil, 则不继续执行 return, 同时此Frame需要Hide()
            self:Hide()
            return
        end
        -- 分配table中值到各个property中
        self.itemLink   = table["itemLink"]
        self.slotID     = table["slotID"] --用于确定frame在layout中的顺序
        self.unit       = table["unit"]
        -- ==================== --
        self.itemLevl   = table["itemRealLevel"]
        self.itemName   = table["itemName"]
        self.itemQuality= table["itemQuality"]
        -- ==================== --
        -- 标记套装
        local setID = select(16, GetItemInfo(self.itemLink))
        if SEData.GetSetID(setID) then
            self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):GetChild("font"):SetTextColor(0.93, 0.38, 0.35)
        else
            local r, g, b = ITEM_QUALITY_COLORS[self.itemQuality].r, ITEM_QUALITY_COLORS[self.itemQuality].g, ITEM_QUALITY_COLORS[self.itemQuality].b
            self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):GetChild("font"):SetTextColor(r, g, b)
        end
        -- ==================== --
        self.hasCrit    = table["ITEM_MOD_CRIT_RATING_SHORT"] ~= nil
        self.hasHaste   = table["ITEM_MOD_HASTE_RATING_SHORT"] ~= nil
        self.hasMastery = table["ITEM_MOD_MASTERY_RATING_SHORT"] ~= nil
        self.hasVersa   = table["ITEM_MOD_VERSATILITY"] ~= nil
        -- ==================== --
        self.gemID1     = table["gemID1"]
        self.gemID2     = table["gemID2"]
        self.gemID3     = table["gemID3"]
        self.gemID4     = table["gemID4"]
        self.hasEnchant = table["enchantID"] ~= ""
        -- ==================== --
        if self.gemID1 == "" and self.gemID2 == "" and self.gemID3 == ""
                and self.gemID4 == "" and ( not self.hasEnchant)
                or ( not self.isExtraInfoShown) then
            self:GetChild("ExtraInfoFrame"):Hide()
        else
            self:GetChild("ExtraInfoFrame"):Show()
        end
        -- ==================== --
        self:Show()
    end}
    property "nameFontsize" { type = Number, default = 15, handler = function(self, size)
        if self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):GetWidth() < 1 then
            return
        end
        self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):SetWidth(
            self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):GetChild("font"):GetStringWidth())
    end}
    property "itemLink" { type = String, default = ""}
    property "slotID" { type = Number, handler = function(self, id)
        -- 前面有个TitleFrame,所以装备列表从2开始往下顺序
        self:SetID(id + 1)
    end}
    property "unit"     {type = String, default = "" }
    __Observable__()
    property "itemLevl" { type = Number, default = 0 }
    property "itemName" { type = String, default = "", handler = function(self, name)
        -- 拿到name之后,因为之前已经验证过table,所以这里不需要再次验证name
        self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):GetChild("font"):SetText(name)
        -- 由于fontstring渲染机制的原因,只有再parent:OnUpdate的时候才会进行渲染
        -- 所以这里可以等待一帧再获取fontstring的width
        -- TODO 但由于下一帧处理width的原因,可能发生一些不希望的情况,外部获取width的时候还处于上一帧,
        -- TODO 可能拿到的还是未处理的值,这就需要进一步处理关系了
        Next(function()
            -- 其实由于渲染问题,还有很多情况需要处理,例如通过GetStringWidth/GetWidth获取的并不是实际长度,
            -- 而是浮点长度,但由于FontString的width并不是一个整数,这里还是不要取整赋值
            self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):SetWidth(
                self:GetChild("EquipInfoFrame"):GetChild("NameFrame"):GetChild("font"):GetStringWidth())
        end)
    end}
    __Observable__()
    property "itemQuality"  { type = Number, default = 0 }
    property "hasCrit"      { type = Boolean, handler = function(self, bol)
        -- 通过bol的真假判断装备是否有此绿字属性,真则显示
        if bol then
            self:GetChild("StatsIconFrame"):GetChild("CritIconFrame"):Show()
        else
            self:GetChild("StatsIconFrame"):GetChild("CritIconFrame"):Hide()
        end
    end}
    property "hasHaste"      { type = Boolean, handler = function(self, bol)
        -- 通过bol的真假判断装备是否有此绿字属性,真则显示
        if bol then
            self:GetChild("StatsIconFrame"):GetChild("HastIconFrame"):Show()
        else
            self:GetChild("StatsIconFrame"):GetChild("HastIconFrame"):Hide()
        end
    end}
    property "hasMastery"      { type = Boolean, handler = function(self, bol)
        -- 通过bol的真假判断装备是否有此绿字属性,真则显示
        if bol then
            self:GetChild("StatsIconFrame"):GetChild("MastIconFrame"):Show()
        else
            self:GetChild("StatsIconFrame"):GetChild("MastIconFrame"):Hide()
        end
    end}
    property "hasVersa"      { type = Boolean, handler = function(self, bol)
        -- 通过bol的真假判断装备是否有此绿字属性,真则显示
        if bol then
            self:GetChild("StatsIconFrame"):GetChild("VersIconFrame"):Show()
        else
            self:GetChild("StatsIconFrame"):GetChild("VersIconFrame"):Hide()
        end
    end}
    property "isExtraInfoShown" {type = Boolean + String, default = false, handler = function(self, bol)
        if bol then
            self:GetChild("ExtraInfoFrame"):Show()
        else
            self:GetChild("ExtraInfoFrame"):Hide()
        end
    end}
    property "gemID1"       { type = Number + String, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        if id == "" then
            self:GetChild("ExtraInfoFrame"):GetChild("Gem1Frame"):Hide()
            return
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem1Frame"):Show()
        self:GetChild("ExtraInfoFrame"):GetChild("Gem1Frame"):GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "gemID2"   { type = Number + String, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        if id == "" then
            self:GetChild("ExtraInfoFrame"):GetChild("Gem2Frame"):Hide()
            return
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem2Frame"):Show()
        self:GetChild("ExtraInfoFrame"):GetChild("Gem2Frame"):GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "gemID3"   { type = Number + String, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        if id == "" then
            self:GetChild("ExtraInfoFrame"):GetChild("Gem3Frame"):Hide()
            return
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem3Frame"):Show()
        self:GetChild("ExtraInfoFrame"):GetChild("Gem3Frame"):GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "gemID4"   { type = Number + String, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        if id == "" then
            self:GetChild("ExtraInfoFrame"):GetChild("Gem4Frame"):Hide()
            return
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem4Frame"):Show()
        self:GetChild("ExtraInfoFrame"):GetChild("Gem4Frame"):GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "hasEnchant" { type = Boolean, handler = function(self, bol)
        -- 通过判断bol是否为真,控制附魔frame得显示与隐藏
        if bol then
            self:GetChild("ExtraInfoFrame"):GetChild("EnchFrame"):Show()
        else
            self:GetChild("ExtraInfoFrame"):GetChild("EnchFrame"):Hide()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("EnchFrame"):GetChild("texture"):SetTexture("Interface/ICONS/inv_misc_enchantedscroll")
    end}


    __Template__ {
        StatsIconFrame = Frame,
        EquipInfoFrame = Frame,
        ExtraInfoFrame = Frame,
        {
            StatsIconFrame = {
                CritIconFrame = Frame,
                HastIconFrame = Frame,
                MastIconFrame = Frame,
                VersIconFrame = Frame,
                {
                    CritIconFrame = { texture = Texture, font = FontString },
                    HastIconFrame = { texture = Texture, font = FontString },
                    MastIconFrame = { texture = Texture, font = FontString },
                    VersIconFrame = { texture = Texture, font = FontString },
                }
            },
            EquipInfoFrame = {
                LevlFrame = Frame,
                NameFrame = Frame,
                {
                    LevlFrame = { font = FontString },
                    NameFrame = { font = FontString },
                }
            },
            ExtraInfoFrame = {
                Gem1Frame = Frame,
                Gem2Frame = Frame,
                Gem3Frame = Frame,
                Gem4Frame = Frame,
                EnchFrame = Frame,
                {
                    Gem1Frame    = { texture = Texture },
                    Gem2Frame    = { texture = Texture },
                    Gem3Frame    = { texture = Texture },
                    Gem4Frame    = { texture = Texture },
                    EnchFrame    = { texture = Texture },
                }
            },
        },
    }

    function __ctor(self)
        self:GetChild("EquipInfoFrame"):GetChild("NameFrame").OnEnter   =   function()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetInventoryItem(self.unit, self.slotID)
            GameTooltip:Show()
        end
        self:GetChild("EquipInfoFrame"):GetChild("NameFrame").OnLeave   =   function()
            GameTooltip:Hide()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem1Frame").OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID1))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem1Frame").OnLeave   =   function()
            GameTooltip:Hide()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem2Frame").OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID2))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem2Frame").OnLeave   =   function()
            GameTooltip:Hide()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem3Frame").OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID3))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem3Frame").OnLeave   =   function()
            GameTooltip:Hide()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem4Frame").OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID4))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        self:GetChild("ExtraInfoFrame"):GetChild("Gem4Frame").OnLeave   =   function()
            GameTooltip:Hide()
        end
    end
end)

class "TitleFrame" (function (_ENV)
    inherit "Frame"

    property "unitInfo" { type = String, default = "",handler = function(self, info)
        self:GetChild("font"):SetText(info)

        Next(function ()
            self:SetWidth(self:GetChild("font"):GetWidth())
        end)
    end}

    __Template__ {
        font = FontString
    }
    function __ctor(self)
        -- ^.^
    end
end)
--======================--
-- Default Style
--======================--
Style.UpdateSkin("Default",{
    [UnitInfoFrame] = {
        location                    = _Config.location:Map(function(loc)
            return { Anchor("TOPLEFT", loc["x"], loc["y"], nil, "TOPRIGHT" ) }
        end),
        Scale                       = _Config.MainScale,
        LayoutManager               = VerticalLayoutManager(false, false),
        height                      = 1,
        -- minResize                   = Size(1, CharacterFrame:GetHeight() - 1),
        backdrop = {
            edgeFile                = [[Interface/AddOns/SEquipment/Modules/Texture/border]],
            -- bgFile                  = [[Interface/Tooltips/UI-Tooltip-Background-Azerite]],
            bgFile                  = [[Interface/AddOns/SEquipment/Modules/Texture/background]],
            edgeSize                = 10,
            insets                  = {left = 2,right = 2,top = 2, bottom = 2}
        },
        backdropbordercolor         = _Config.unitInfoBorderColor,
        backdropcolor               = _Config.unitInfoBackColor,
        padding                     = {
            top                     = 2,
            left                    = 5,
            right                   = 5,
            bottom                  = 2,
        }
    },
    [TitleFrame] = {
        id                          = 1,
        width                       = 1,
        height                      = 20, --决定把这个大小固定下来
        font                        = {
            Text                    = Wow.FromUIProperty("unitInfo"),
            Font                    = _Config.titleUnitInfo:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
            -- TextColor               = _Config.titleUnitInfoColor,
            location                = { Anchor("LEFT") },
        },
    },
    [PerSlotFrame] = {
        nameFontsize                = _Config.nameFontsize,
        LayoutManager               = HorizontalLayoutManager(false, false),
        width                       = 1,
        -- 属性图标样式
        StatsIconFrame              = {
            LayoutManager           = HorizontalLayoutManager(true, false),
            width                   = 1,
            id                      = 1,
            Visible                 = _Config.ShowStatsIcon, --控制是否可见
            CritIconFrame           = {
                id                  = 1,
                Size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    file            = SEData.GetStatsTexture(),
                    SetAllPoints    = true,
                    VertexColor     = _Config.critIconColor,
                },
                font                = {
                    Text            = SEData.GetStatsFont(1),
                    Font            = _Config.statsIconFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.critIconColor,
                    location        = { Anchor("CENTER") },
                }
            },
            HastIconFrame           = {
                id                  = 2,
                Size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    file            = SEData.GetStatsTexture(),
                    SetAllPoints    = true,
                    VertexColor     = _Config.hasteIconColor,
                },
                font                = {
                    Text            = SEData.GetStatsFont(2),
                    Font            = _Config.statsIconFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.hasteIconColor,
                    location        = { Anchor("CENTER") },
                }
            },
            MastIconFrame           = {
                id                  = 3,
                Size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    file            = SEData.GetStatsTexture(),
                    SetAllPoints    = true,
                    VertexColor     = _Config.MasteryIconColor,
                },
                font                = {
                    Text            = SEData.GetStatsFont(3),
                    Font            = _Config.statsIconFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.MasteryIconColor,
                    location        = { Anchor("CENTER") },
                }
            },
            VersIconFrame           = {
                id                  = 4,
                Size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    file            = SEData.GetStatsTexture(),
                    SetAllPoints    = true,
                    VertexColor     = _Config.VersaIconColor,
                },
                font                = {
                    Text            = SEData.GetStatsFont(4),
                    Font            = _Config.statsIconFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.VersaIconColor,
                    location        = { Anchor("CENTER") },
                }
            },
        },
        EquipInfoFrame              = {
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            id                      = 2,
            --TODO 控制是否可见
            LevlFrame               = {
                id                  = 1,
                Visible             = _Config.ShowLevel, --控制是否可见
                Size                = Size(PER_ITEM_HEIGHT * 2, PER_ITEM_HEIGHT),
                font                = {
                    Text            = Wow.FromUIProperty("itemLevl"),
                    Font            = _Config.levelFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.levelFontColor,
                    location        = { Anchor("CENTER")},
                },
                backdrop            = {
                    bgFile          = [[Interface/AddOns/SEquipment/Modules/Texture/background]],
                    insets          = {left = 5,right = 5,top = 2, bottom = 2}
                },
                backdropcolor       = _Config.levelBackColor,
            },
            NameFrame               = {
                id                  = 2,
                Visible             = _Config.ShowEquipmentName, --控制是否可见
                Height              = PER_ITEM_HEIGHT,
                font                = {
                    Font            = _Config.nameFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    -- TextColor       = Wow.FromUIProperty("itemQuality"):Map("x=>ITEM_QUALITY_COLORS[x]"),
                    location        = { Anchor("LEFT")},
                },
            },
        },
        isExtraInfoShown            = _Config.ShowEnchantGem:Map(function(x) return x == true end), --控制ExtraInfoFrame是否可见
        ExtraInfoFrame              = {
            -- Visible                 = _Config.ShowEnchantGem, --控制ExtraInfoFrame是否可见
            id                      = 3,
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            Gem1Frame               = {
                id                  = 1,
                size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    SetAllPoints    = true,
                    file            = [[Interface/ICONS/inv_misc_enchantedscroll]],
                    Mask            = [[Interface/COMMON/Indicator-Gray]],
                },
            },
            Gem2Frame               = {
                id                  = 2,
                size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    SetAllPoints    = true,
                    file            = [[Interface/ICONS/inv_misc_enchantedscroll]],
                    Mask            = [[Interface/COMMON/Indicator-Gray]],
                },
            },
            Gem3Frame               = {
                id                  = 3,
                size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    SetAllPoints    = true,
                    file            = [[Interface/ICONS/inv_misc_enchantedscroll]],
                    Mask            = [[Interface/COMMON/Indicator-Gray]],
                },
            },
            Gem4Frame               = {
                id                  = 4,
                size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    SetAllPoints    = true,
                    file            = [[Interface/ICONS/inv_misc_enchantedscroll]],
                    Mask            = [[Interface/COMMON/Indicator-Gray]],
                },
            },
            EnchFrame               = {
                id                  = 5,
                size                = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
                texture             = {
                    SetAllPoints    = true,
                    -- file            = [[Interface/ICONS/inv_misc_enchantedscroll]],
                    Mask            = [[Interface/COMMON/Indicator-Gray]],
                },
            },
        },
    },
    [StatsInfoFrame] = {
        visible = _Config.ShowStatsFrame,
        id              = 19, --用于对接自动布局框架,后续有需求可以改成动态 19是因为除去战袍只剩17个槽位,然后还有个TitleFrame id = 1,所以按顺序此frame的id为19
        LayoutManager   = VerticalLayoutManager(false, false),
        height          = 1,
        CritInfoFrame               = {
            id                      = 1,
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            name                    = {
                id                  = 1,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("critName"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("critPercent"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("critNumber"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
        },
        HastInfoFrame               = {
            id                      = 2,
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            name                    = {
                id                  = 1,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("hasteName"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("hastePercent"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("hasteNumber"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
        },
        MastInfoFrame               = {
            id                      = 3,
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            name                    = {
                id                  = 1,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("masteryName"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("masteryPercent"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("masteryNumber"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
        },
        VersInfoFrame               = {
            id                      = 4,
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            name                    = {
                id                  = 1,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("versaName"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("versaPercent"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("versaNumber"),
                    Font            = _Config.statsFontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsFontColor,
                    location        = { Anchor("LEFT")},
                }
            },
        },
    },
})