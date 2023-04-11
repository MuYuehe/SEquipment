Scorpio "SEquipment.core.bag" ""
--======================--
import "SEquipment.data"
--======================--
class "ButtonInfo" (function (_ENV)
    inherit "Frame"

    property "data"     { type = Table, handler = function(self, data)
        self:SetShown(data and (data["itemType"] == ARMOR or data["itemType"] == WEAPON))
        if not data then return end
        if data["itemType"] ~= ARMOR and data["itemType"] ~= WEAPON then return end

        self.part       = data["itemEquipLoc"]
        self.level      = data["itemLevel"]
        -- ==================================== --
        if SEData.GetSetID(data["setID"]) then
            self.itemColor = {["hex"]="",["r"]=0.93,["g"]=0.38,["b"]=0.35 }
        else
            self.itemColor = data["itemQuality"]
        end
    end}
    __Observable__()
    property "part"          { type = String, default = ""}
    __Observable__()
    property "level"         { type = Number, default = 0}
    __Observable__()
    property "itemColor"    { type = Table }

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