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
class "UnitMainFrame"       (function (_ENV)
    inherit "Frame"

    property "data"     { type = Table, handler = function(self, table)
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
        LeveFrame               = Frame,
        SpecFrame               = Frame,
        HideFrame               = Frame,
        {
            HideFrame           = { texture = Texture},
            LeveFrame           = { font = FontString},
            SpecFrame           = { texture = Texture},
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
class "PerStatsFrame"       (function (_ENV)
    inherit "Frame"

    property "data"     { type = Table, handler = function(self, data)
        -- ======================================== --
        self.name           = data[4] .. ":"
        self.percent        = data[1] .. "%"
        self.number         = "+" .. data[2]
    end}
    __Observable__()
    property "name"     { type = String }
    __Observable__()
    property "percent"  { type = String }
    __Observable__()
    property "number"   { type = String }
    __Template__ {
        name                = Frame,
        percent             = Frame,
        number              = Frame,
        {
            name            = { font = FontString },
            percent         = { font = FontString },
            number          = { font = FontString },
        }
    }
    function __ctor(self)
        -- ^.^
    end
end)
class "UnitStatsFrame"      (function (_ENV)
    inherit "Frame"

    property "crit" { type = Table ,handler = function(self, data)
        self:GetChild("critFrame").data = data
    end}
    property "haste" { type = Table ,handler = function(self, data)
        self:GetChild("hasteFrame").data = data
    end}
    property "mastery" { type = Table ,handler = function(self, data)
        self:GetChild("masteryFrame").data = data
    end}
    property "versa" { type = Table ,handler = function(self, data)
        self:GetChild("versaFrame").data = data
    end}
    __Template__ {
        critFrame           = PerStatsFrame,
        hasteFrame          = PerStatsFrame,
        masteryFrame        = PerStatsFrame,
        versaFrame          = PerStatsFrame,
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
        -- ===================================== --
        if data["setID"] and data["itemQualityNum"] <= 4 then
            self.itemColor = {["hex"]="",["r"]=0.93,["g"]=0.38,["b"]=0.35 }
        else
            self.itemColor = data["itemQuality"]
        end
    end}
    property "itemLink"         { type = String }
    __Observable__()
    property "itemLevel"        { type = Number }
    property "itemEquipLoc"     { type = String }
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
        self.emptySlots = data["emptySlots"]
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
    property "emptySlots"       { type = Boolean, handler = function(self, bol)
        self:GetChild("EmptySlot"):SetShown(bol)
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
        EmptySlot = Frame,
        EnchFrame = Frame,
        {
            Gem1Frame    = { texture = Texture },
            Gem2Frame    = { texture = Texture },
            Gem3Frame    = { texture = Texture },
            Gem4Frame    = { texture = Texture },
            EmptySlot    = { texture = Texture },
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
        local frame = self:GetChild("BaseInfoFrame")
        self.OnEnter = function()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetInventoryItem(self.unit, self.slotID)
            GameTooltip:Show()
        end
        self.OnLeave = function()
            GameTooltip:Hide()
        end
        frame.OnEnter = function()
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetInventoryItem(self.unit, self.slotID)
            GameTooltip:Show()
        end
        frame.OnLeave = function()
            GameTooltip:Hide()
        end
    end
end)
--======================--
-- Default Style
--======================--
Style.UpdateSkin("Default",{
    [UnitMainFrame]                         = {
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
    [ItemStatsInfoFrame]                    = {
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
    [ItemBaseInfoFrame]                     = {
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
    [ItemExtraInfoFrame]                    = {
        isExtraInfoShown                    = _Config.ShowEnchantGem,
        LayoutManager                       = HorizontalLayoutManager(false, false),
        size                                = Size(PER_ITEM_HEIGHT * 6, PER_ITEM_HEIGHT),
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
        EmptySlot                           = {
            id                              = 5,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                file                        = [[Interface/MINIMAP/TRACKING/QuestBlob]],
            },
        },
        EnchFrame                           = {
            id                              = 6,
            size                            = Size(PER_ITEM_HEIGHT, PER_ITEM_HEIGHT),
            texture                         = {
                SetAllPoints                = true,
                Mask                        = [[Interface/COMMON/Indicator-Gray]],
            },
        },
    },
    [ItemInfoFrame]                         = {
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
    [PerStatsFrame]                         = {
        size                                = Size(150, 20),
        name                                = {
            size                            = Size(50,20),
            location                        = { Anchor("LEFT")},
            font                            = {
                Text                        = Wow.FromUIProperty("name"),
                Font                        = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.statsfontcolor,
                location                    = { Anchor("LEFT")},
            },
        },
        percent                             = {
            size                            = Size(50,20),
            location                        = { Anchor("CENTER") },
            font                            = {
                Text                        = Wow.FromUIProperty("percent"),
                Font                        = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.statsfontcolor,
                location                    = { Anchor("LEFT")},
            }
        },
        number                              = {
            size                            = Size(50,20),
            location                        = { Anchor("RIGHT") },
            font                            = {
                Text                        = Wow.FromUIProperty("number"),
                Font                        = _Config.statsfontsize:Map(function(size) return { font = STANDARD_TEXT_FONT, height = size} end),
                TextColor                   = _Config.statsfontcolor,
                location                    = { Anchor("LEFT")},
            }
        }
    },
    [UnitStatsFrame]                        = {
        visible                             = _Config.ShowStatsFrame,
        LayoutManager                       = VerticalLayoutManager(false, false),
        size                                = Size(150, 80),
        location                            = { Anchor("TOPLEFT", 0, - CharacterFrame:GetHeight()) },
        backdrop                            = {
            edgeFile                        = [[Interface/AddOns/SEquipment/Modules/Texture/border]],
            bgFile                          = [[Interface/AddOns/SEquipment/Modules/Texture/background]],
            edgeSize                        = 10,
            insets                          = {left = 2,right = 2,top = 2, bottom = 2}
        },
        backdropbordercolor                 = _Config.unitinfobordercolor,
        backdropcolor                       = _Config.unitinfobackcolor,
        padding                             = {
            -- top                             = 5,
            left                            = 5,
            right                           = 5,
            -- bottom                          = 5,
        },
        critFrame                           = {
            id                              = 1,
        },
        hasteFrame                          = {
            id                              = 2,
        },
        masteryFrame                        = {
            id                              = 3,
        },
        versaFrame                          = {
            id                              = 4,
        }
    },
})