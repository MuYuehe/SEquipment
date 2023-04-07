Scorpio "SEquipment.core.unit" ""
--======================--
import "SEquipment.data"
import "SEquipment.Layout"
--======================--
L = _Locale
--======================--
-- Constant
--======================--
local PER_ITEM_HEIGHT = 23
local PER_ICON_HEIGHT = 20
--======================--
-- Default Class
--======================--
class "UnitInfoFrame"       (function (_ENV)
    inherit "Frame"

    property "data" { type = Table, handler = function(self, table)
        if not table then return end

        self.avgLevel       = STAT_AVERAGE_ITEM_LEVEL .. ":" .. table["avgItemLevel"]
        self.specIcon       = table["specIcon"]
        self.classFileName  = table["classFileName"]
    end}
    __Observable__()
    property "avgLevel" { type = String + Number, default = ""}
    property "specIcon" { type = String + Number, default = "", handler = function(self, specIcon)
        if type(specIcon) == "number" then
            self:GetChild("SpecFrame"):GetChild("texture"):SetTexture(specIcon)
        elseif type(specIcon) == "string" then
            self:GetChild("SpecFrame"):GetChild("texture"):SetTexture("Interface/ICONS/ClassIcon_" .. specIcon)
        end
    end}
    __Template__ {
        LeveFrame = Frame,
        SpecFrame = Frame,
        HideFrame = Frame,
        {
            HideFrame = { texture = Texture},
            LeveFrame = { font = FontString},
            SpecFrame = { texture = Texture},
        }
    }
    function __ctor(self)
        -- ^.^
        self:Hide()
        self:GetChild("HideFrame").OnMouseUp = function()
            self:Hide()
        end
    end
end)
class "StatsInfoFrame"      (function (_ENV)
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
class "ItemStatsInfoFrame"  (function (_ENV)
    inherit "Frame"

    property "data" { type = Table, handler = function(self, data)

        -- ===================================== --
        self.versaNum   = data["ITEM_MOD_VERSATILITY"]
        self.critNum    = data["ITEM_MOD_CRIT_RATING_SHORT"]
        self.hasteNum   = data["ITEM_MOD_HASTE_RATING_SHORT"]
        self.masteryNum = data["ITEM_MOD_MASTERY_RATING_SHORT"]
    end}
    property "critNum"      {type = Number, handler = function(self, num)
        local frame = self:GetChild("CritIconFrame")
        frame:SetShown( num ~= 0 )
    end}
    property "hasteNum"     {type = Number, handler = function(self, num)
        local frame = self:GetChild("HastIconFrame")
        frame:SetShown( num ~= 0 )
    end}
    property "masteryNum"   {type = Number, handler = function(self, num)
        local frame = self:GetChild("MastIconFrame")
        frame:SetShown( num ~= 0 )
    end}
    property "versaNum"     {type = Number, handler = function(self, num)
        local frame = self:GetChild("VersIconFrame")
        frame:SetShown( num ~= 0 )
    end}

    __Template__ {
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
    }
    function __ctor(self)
        -- nothing to do
    end
end)
class "ItemBaseInfoFrame"   (function (_ENV)
    inherit "Frame"

    property "data"         { type = Table, handler = function(self, data)
        -- ===================================== --
        self.itemLink       = data["itemLink"]
        self.itemLevel      = data["itemLevel"]
        self.itemName       = data["itemName"]
        self.itemEquipLoc   = data["itemEquipLoc"]
        self.itemSetID      = data["setID"]
        self.itemQuality    = data["itemQuality"]
    end}
    property "itemLink"         { type = String }
    __Observable__()
    property "itemLevel"        { type = Number }
    property "itemEquipLoc"     { type = String }
    property "itemSetID"        { type = Number }
    __Observable__()
    property "itemColor"        { type = Table }
    property "itemName"         {type = String, handler = function(self, str)
        local frame = self:GetChild("NameFrame")
        local fontString = frame:GetChild("font")
        fontString:SetText(str)
        Next(function()
            frame:SetWidth(fontString:GetWidth())
        end)
    end}
    property "itemQuality"  { type = Table, handler = function(self, table)
        if SEData.GetSetID(self.itemSetID) then
            self.itemColor = {["hex"]="",["r"]=0.93,["g"]=0.38,["b"]=0.35 }
        else
            self.itemColor = table
        end
    end}
    property "isLevelShow" { type = Boolean, handler = function(self, bol)
        self:GetChild("LevlFrame"):SetShown(bol)
        self:SetShown(self.isNameShow or bol)
    end}
    property "isNameShow" { type = Boolean, handler = function(self, bol)
        self:GetChild("NameFrame"):SetShown(bol)
        self:SetShown(self.isLevelShow or bol)
    end}
    __Template__ {
        LevlFrame = Frame,
        NameFrame = Frame,
        {
            LevlFrame = { font = FontString },
            NameFrame = { font = FontString },
        }
    }
    function __ctor(self)
        local fontString = self:GetChild("LevlFrame"):GetChild("font")
        self.OnEnter                            = function()
            fontString:SetText(self.itemEquipLoc)
        end
        self.OnLeave                            = function()
            fontString:SetText(self.itemLevel)
        end
    end
end)
class "ItemExtraInfoFrame"  (function (_ENV)
    inherit "Frame"

    property "data"             { type = Table, handler = function(self, data)
        -- ============================================ --
        self.gemID1     = data["gemID1"]
        self.gemID2     = data["gemID2"]
        self.gemID3     = data["gemID3"]
        self.gemID4     = data["gemID4"]
        self.enchantID  = data["enchantID"]
        -- ============================================ --
        local bol = XDictionary(data).Values:Any(function(x) return x ~= false end)
        self:SetShown(bol and self.isExtraInfoShown)
    end}
    property "gemID1"           { type = String + Boolean, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        local frame = self:GetChild("Gem1Frame")
        frame:SetShown(id and true)
        if not id then return end
        frame:GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "gemID2"           { type = String + Boolean, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        local frame = self:GetChild("Gem2Frame")
        frame:SetShown(id and true)
        if not id then return end
        frame:GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "gemID3"           { type = String + Boolean, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        local frame = self:GetChild("Gem3Frame")
        frame:SetShown(id and true)
        if not id then return end
        frame:GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "gemID4"           { type = String + Boolean, handler = function(self, id)
        -- 首先判断id是否为空,如果为空,则隐藏此宝石得frame,并不再执行,否则显示
        local frame = self:GetChild("Gem4Frame")
        frame:SetShown(id and true)
        if not id then return end
        frame:GetChild("texture"):SetTexture(GetItemIcon(id))
    end}
    property "enchantID"        { type = String + Boolean, handler = function(self, id)
        -- 通过判断bol是否为真,控制附魔frame得显示与隐藏
        local frame = self:GetChild("EnchFrame")
        frame:SetShown(id and true)
        if not id then return end
        local enchantItemID = SEData.GetEnchantItemID(id) --暂时只收录了10.0的相关附魔
        if enchantItemID then
            local enchantLink = select(2, GetItemInfo(enchantItemID))
            self.enchantItemLink = enchantLink or ""
        end
        frame:GetChild("texture"):SetTexture("Interface/ICONS/inv_misc_enchantedscroll")
    end}
    property "enchantItemLink"  { type = String }
    property "isExtraInfoShown" { type = Boolean + String, default = false, handler = function(self, bol)
        self:SetShown(bol)
    end}
    __Template__ {
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
    }
    function __ctor(self)
        local gem1Frame = self:GetChild("Gem1Frame")
        local gem2Frame = self:GetChild("Gem2Frame")
        local gem3Frame = self:GetChild("Gem3Frame")
        local gem4Frame = self:GetChild("Gem4Frame")
        local enchFrame = self:GetChild("EnchFrame")
        gem1Frame.OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID1))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        gem1Frame.OnLeave   =   function()
            GameTooltip:Hide()
        end
        gem2Frame.OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID2))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        gem2Frame.OnLeave   =   function()
            GameTooltip:Hide()
        end
        gem3Frame.OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID3))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        gem3Frame.OnLeave   =   function()
            GameTooltip:Hide()
        end
        gem4Frame.OnEnter   =   function()
            local gemlink = select(2, GetItemInfo(self.gemID4))
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetHyperlink(gemlink)
            GameTooltip:Show()
        end
        gem4Frame.OnLeave   =   function()
            GameTooltip:Hide()
        end
        enchFrame.OnEnter   =   function()
            if self.enchantItemLink then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(self.enchantItemLink)
                GameTooltip:Show()
            end
        end
        enchFrame.OnLeave   =   function()
            GameTooltip:Hide()
        end
    end
end)
class "ItemInfoFrame"       (function (_ENV)
    inherit "Frame"

    property "data" { type = Table, handler = function(self, data)
        -- ======================================== --
        self.unit       = data["unit"]
        self.slotID     = data["slotID"]
        -- ======================================== --
        self:SetShown(data["itemInfo"] and true)
        if not data["itemInfo"] then return end
        self.statsData  = data["statsInfo"]
        self.baseData   = data["itemInfo"]
        self.extraData  = data["extraInfo"]
    end}
    property "unit" { type = String }
    __Observable__()
    property "slotID" { type = Number }
    property "statsData" { type = Table, handler = function(self, data)
        self:GetChild("StatsInfoFrame").data = data
    end}
    property "baseData" { type = Table, handler = function(self, data)
        self:GetChild("BaseInfoFrame").data = data
    end}
    property "extraData" {type = Table, handler = function(self, data)
        self:GetChild("ExtraInfoFrame").data = data
    end}
    __Template__ {
        StatsInfoFrame  = ItemStatsInfoFrame,
        BaseInfoFrame   = ItemBaseInfoFrame,
        ExtraInfoFrame  = ItemExtraInfoFrame,
    }
    function __ctor(self)
        self.OnEnter = function()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetInventoryItem(self.unit, self.slotID)
            GameTooltip:Show()
        end
        self.OnLeave = function()
            GameTooltip:Hide()
        end
    end
end)
--======================--
-- Default Style
--======================--
Style.UpdateSkin("Default",{
    [UnitInfoFrame]         = {
        location                    = _Config.location:Map(function(loc)
                                        return { Anchor("TOPLEFT", loc["x"], loc["y"], nil, "TOPRIGHT" ) }
        end),
        Scale                       = _Config.MainScale,
        LayoutManager               = VerticalLayoutManager(true, false),
        height                      = 1,
        minResize                   = Size(1, CharacterFrame:GetHeight() - 1),
        backdrop = {
            edgeFile                = [[Interface/AddOns/SEquipment/Modules/Texture/border]],
            bgFile                  = [[Interface/AddOns/SEquipment/Modules/Texture/background]],
            edgeSize                = 10,
            insets                  = {left = 2,right = 2,top = 2, bottom = 2}
        },
        backdropbordercolor         = _Config.unitinfobordercolor,
        backdropcolor               = _Config.unitinfobackcolor,
        padding                     = {
            top                     = 40,
            left                    = 5,
            right                   = 5,
            bottom                  = 2,
        },
        HideFrame                   = {
            size                    = Size(30,30),
            location                = { Anchor("BOTTOMLEFT", 3, 3)},
            texture                 = {
                file                = [[Interface/Cursor/Item]],
                Rotation            = 3.14/2,
                SetAllPoints        = true,
            }
        },
        LeveFrame                   = {
            size                    = Size( 100, 40),
            location                = { Anchor("TOPLEFT")},
            font                    = {
                Text                = Wow.FromUIProperty("avgLevel"),
                Font                = _Config.titleunitinfo:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                location            = { Anchor("LEFT", 10, 0) },
            }
        },
        SpecFrame                   = {
            size                    = Size(40,40),
            location                = { Anchor("TOPRIGHT", -3, -3)},
            alpha                   = 0.8,
            texture                 = {
                SetAllPoints        = true,
                Mask                = [[Interface/COMMON/Indicator-Gray]],
            }
        }
    },
    [StatsInfoFrame]        = {
        visible                     = _Config.ShowStatsFrame,
        LayoutManager               = VerticalLayoutManager(false, false),
        size                        = Size(150, 80),
        location                    = { Anchor("TOPLEFT", 0, - CharacterFrame:GetHeight()) },
        backdrop = {
            edgeFile                = [[Interface/AddOns/SEquipment/Modules/Texture/border]],
            bgFile                  = [[Interface/AddOns/SEquipment/Modules/Texture/background]],
            edgeSize                = 10,
            insets                  = {left = 2,right = 2,top = 2, bottom = 2}
        },
        backdropbordercolor         = _Config.unitinfobordercolor,
        backdropcolor               = _Config.unitinfobackcolor,
        padding                     = {
            top                     = 2,
            left                    = 5,
            right                   = 5,
            bottom                  = 2,
        },
        CritInfoFrame               = {
            id                      = 1,
            LayoutManager           = HorizontalLayoutManager(false, false),
            width                   = 1,
            name                    = {
                id                  = 1,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("critName"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("critPercent"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("critNumber"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
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
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("hastePercent"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("hasteNumber"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
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
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("masteryPercent"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("masteryNumber"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
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
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            percent                 = {
                id                  = 2,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("versaPercent"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
            number                  = {
                id                  = 3,
                Size                = Size(50, 20), --此处直接固定了,影响不大
                font                = {
                    Text            = Wow.FromUIProperty("versaNumber"),
                    Font            = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                    TextColor       = _Config.statsfontcolor,
                    location        = { Anchor("LEFT")},
                }
            },
        },
    },
    [ItemStatsInfoFrame]    = {
        Visible                             = _Config.ShowStatsIcon,
        size                                = Size(PER_ITEM_HEIGHT * 4, PER_ITEM_HEIGHT),
        CritIconFrame                       = {
            size                            = Size(PER_ICON_HEIGHT, PER_ICON_HEIGHT),
            location                        = { Anchor("CENTER", - PER_ITEM_HEIGHT * 3 / 2, 0) },
            texture                         = {
                file                        = SEData.GetStatsTexture(),
                SetAllPoints                = true,
                VertexColor                 = _Config.criticoncolor,
            },
            font                            = {
                Text                        = SEData.GetStatsFont(1),
                Font                        = _Config.statsiconfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.criticoncolor,
                location                    = { Anchor("CENTER") },
            },
        },
        HastIconFrame                       = {
            size                            = Size(PER_ICON_HEIGHT, PER_ICON_HEIGHT),
            location                        = { Anchor("CENTER", - PER_ITEM_HEIGHT / 2, 0) },
            texture                         = {
                file                        = SEData.GetStatsTexture(),
                SetAllPoints                = true,
                VertexColor                 = _Config.hasteiconcolor,
            },
            font                            = {
                Text                        = SEData.GetStatsFont(2),
                Font                        = _Config.statsiconfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.hasteiconcolor,
                location                    = { Anchor("CENTER") },
            },
        },
        MastIconFrame                       = {
            size                            = Size(PER_ICON_HEIGHT, PER_ICON_HEIGHT),
            location                        = { Anchor("CENTER", PER_ITEM_HEIGHT / 2, 0) },
            texture                         = {
                file                        = SEData.GetStatsTexture(),
                SetAllPoints                = true,
                VertexColor                 = _Config.masteryiconcolor,
            },
            font                            = {
                Text                        = SEData.GetStatsFont(3),
                Font                        = _Config.statsiconfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.masteryiconcolor,
                location                    = { Anchor("CENTER") },
            },
        },
        VersIconFrame                       = {
            size                            = Size(PER_ICON_HEIGHT, PER_ICON_HEIGHT),
            location                        = { Anchor("CENTER", PER_ITEM_HEIGHT * 3 / 2, 0) },
            texture                         = {
                file                        = SEData.GetStatsTexture(),
                SetAllPoints                = true,
                VertexColor                 = _Config.versaiconcolor,
            },
            font                            = {
                Text                        = SEData.GetStatsFont(4),
                Font                        = _Config.statsiconfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.versaiconcolor,
                location                    = { Anchor("CENTER") },
            },
        },
    },
    [ItemBaseInfoFrame]     = {
        isLevelShow                         = _Config.ShowLevel,
        isNameShow                          = _Config.ShowEquipmentName,
        size                                = Size(PER_ITEM_HEIGHT * 3, PER_ITEM_HEIGHT),
        LayoutManager                       = HorizontalLayoutManager(false, false),
        LevlFrame                           = {
            id                              = 1,
            size                            = Size(PER_ITEM_HEIGHT * 2, PER_ITEM_HEIGHT),
            font                            = {
                Text                        = Wow.FromUIProperty("itemLevel"),
                Font                        = _Config.levelfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.levelfontcolor,
                location                    = { Anchor("CENTER")},
            },
            backdrop                        = {
                bgFile                      = [[Interface/AddOns/SEquipment/Modules/Texture/background]],
                insets                      = {left = 5,right = 5,top = 2, bottom = 2}
            },
            backdropcolor                   = _Config.levelbackcolor,
        },
        NameFrame                           = {
            id                              = 2,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            font                            = {
                Font                        = _Config.namefontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = _Config.namefontsize:GetValue()} end),
                TextColor                   = Wow.FromUIProperty("itemColor"),
                location                    = { Anchor("LEFT") },
            },
        },
    },
    [ItemExtraInfoFrame]    = {
        isExtraInfoShown                    = _Config.ShowEnchantGem,
        LayoutManager                       = HorizontalLayoutManager(false, false),
        size                                = Size(PER_ITEM_HEIGHT * 5, PER_ITEM_HEIGHT),
        Gem1Frame                           = {
            id                              = 1,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                file                        = [[Interface/ICONS/inv_misc_enchantedscroll]],
                Mask                        = [[Interface/COMMON/Indicator-Gray]],
            },
        },
        Gem2Frame                           = {
            id                              = 2,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                file                        = [[Interface/ICONS/inv_misc_enchantedscroll]],
                Mask                        = [[Interface/COMMON/Indicator-Gray]],
            },
        },
        Gem3Frame                           = {
            id                              = 3,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                file                        = [[Interface/ICONS/inv_misc_enchantedscroll]],
                Mask                        = [[Interface/COMMON/Indicator-Gray]],
            },
        },
        Gem4Frame                           = {
            id                              = 4,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                file                        = [[Interface/ICONS/inv_misc_enchantedscroll]],
                Mask                        = [[Interface/COMMON/Indicator-Gray]],
            },
        },
        EnchFrame                           = {
            id                              = 5,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                Mask                        = [[Interface/COMMON/Indicator-Gray]],
            },
        },
    },
    [ItemInfoFrame]         = {
        id                                  = Wow.FromUIProperty("slotID"):Map(function(id)
                                                local uid = id
                                                if id > 4 then uid = id - 1 end
                                                return uid
        end),
        LayoutManager                       = HorizontalLayoutManager(false, false),
        size                                = Size(PER_ITEM_HEIGHT * 12, PER_ITEM_HEIGHT),
        StatsInfoFrame                      = {
            id                              = 1,
        },
        BaseInfoFrame                       = {
            id                              = 2,
        },
        ExtraInfoFrame                      = {
            id                              = 3,
        },
    },
})