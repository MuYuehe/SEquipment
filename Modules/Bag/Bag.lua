Scorpio "SEquipment.core.bag" ""

class "ButtonInfo" (function (_ENV)
    inherit "Frame"

    property "data"     { type = Table, handler = function(self, data)
        if data["itemLink"] and (data["itemType"] == 4 or data["itemType"] == 2) then
            self:Show()
        else
            self:Hide() return
        end
        self.width      = data["width"]
        self.height     = data["height"]
        self.part       = data["itemEquipLoc"]
        self.level      = data["itemRealLevel"]
        self.quality    = data["itemQuality"]
    end}
    __Observable__()
    property "width"         { type = Number, default = 0}
    __Observable__()
    property "height"        { type = Number, default = 0}
    __Observable__()
    property "part"          { type = String, default = ""}
    __Observable__()
    property "level"         { type = Number, default = 0}
    __Observable__()
    property "quality"       { type = Number, default = 0}
    __Template__ {
        partFont    = FontString,
        LevelFont   = FontString,
    }

    function __ctor(self)
        -- ^.^
    end
end)
Style.UpdateSkin("Default",{
    [ButtonInfo] = {
        width                       = Wow.FromUIProperty("width"),
        height                      = Wow.FromUIProperty("height"),
        location                    = { Anchor("CENTER")},
        partFont                    = {
            Text                    = Wow.FromUIProperty("part"):Map("x=>_G[x]"),
            TextColor               = Wow.FromUIProperty("quality"):Map("x=>ITEM_QUALITY_COLORS[x]"),
            Font                    = {
                font                = STANDARD_TEXT_FONT,
                height              = 12,
                outline             = "NORMAL",
            },
            location                = { Anchor("TOP") },
        },
        LevelFont                   = {
            Text                    = Wow.FromUIProperty("level"),
            TextColor               = Wow.FromUIProperty("quality"):Map("x=>ITEM_QUALITY_COLORS[x]"),
            Font                    = {
                font                = STANDARD_TEXT_FONT,
                height              = 15,
                outline             = "NORMAL",
            },
            location                = { Anchor("BOTTOM") },
        }
    }
})