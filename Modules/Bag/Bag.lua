Scorpio "SEquipment.core.bag" ""
--======================--
import "SEquipment.data"
--======================--
class "ButtonInfo" (function (_ENV)
    inherit "Frame"

    property "data"     { type = Table, handler = function(self, data)
        self:SetShown(data["itemType"] == ARMOR or data["itemType"] == WEAPON)
        if data["itemType"] ~= ARMOR and data["itemType"] ~= WEAPON then return end

        self.part       = data["itemEquipLoc"]
        self.level      = data["itemLevel"]
        self.setID      = data["setID"]
        self.quality    = data["itemQuality"]
    end}
    __Observable__()
    property "part"          { type = String, default = ""}
    __Observable__()
    property "level"         { type = Number, default = 0}
    __Observable__()
    property "itemColor"    { type = Table }
    property "setID"        { type = Number }
    property "quality"      { type = Table, handler = function(self, table)
        if SEData.GetSetID(self.setID) then
            self.itemColor = {["hex"]="",["r"]=0.93,["g"]=0.38,["b"]=0.35 }
        else
            self.itemColor = table
        end
    end}

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
        partFont                    = {
            Text                    = Wow.FromUIProperty("part"),
            TextColor               = Wow.FromUIProperty("itemColor"),
            Font                    = {
                font                = STANDARD_TEXT_FONT,
                height              = 12,
                outline             = "NORMAL",
            },
            location                = { Anchor("TOP") },
        },
        LevelFont                   = {
            Text                    = Wow.FromUIProperty("level"),
            TextColor               = Wow.FromUIProperty("itemColor"),
            Font                    = {
                font                = STANDARD_TEXT_FONT,
                height              = 15,
                outline             = "NORMAL",
            },
            location                = { Anchor("BOTTOM") },
        }
    }
})