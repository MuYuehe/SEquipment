--========================================================--
--                 SEquipment UI Menu Home                --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio        "BaseConfig.MainInterface.Home"            ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                          Home                         --
-----------------------------------------------------------

----------------------------
--       UI Hierarchy     --
----------------------------
local ChangeLogFrame        = SEScrollFrame("ChangeLog", HomeFrame)
local ChangeLogFont         = FontString("ChangeLogFont",HomeFrame)
local ChangeLogFrameBorder  = SESetMenuFrame("ChangeLogFrameBorder",HomeFrame)
    local ChangeLog1Frame   = SESetMenuFrame("ChangeLog1Frame",ChangeLogFrame.ScrollChild)
    local ChangeLog1        = FontString("ChangeLog1",ChangeLog1Frame)
Style[ChangeLogFrame]       = {
    location                = { Anchor("BOTTOM",0,10)},
    size                    = Size(380,240),
    backdropbordercolor             = Color(1,1,1,0),
}
Style[ChangeLogFont]        = {
    location                = { Anchor("TOPLEFT",10,-20)},
    text                    = '|cff00ccff'..L["Log"],
    font                    = {
        font                = SEFontStyle[1].value,
        height              = 30,
    }
}
Style[ChangeLogFrameBorder] = {
    size                    = Size(380,250),
    location                = { Anchor("BOTTOM",0,5)},
    backdropbordercolor             = Color(1,1,1,0.3),
}
Style[ChangeLogFrame].ScrollChild = {
    ChangeLog1Frame         = {
        location            = { Anchor("TOPLEFT",5,5)},
        size                = Size(350,750),
    }
}
Style[ChangeLog1Frame]      = {
    ChangeLog1              = {
        location            = { Anchor("TOPLEFT",0,-5)},
        text                = L["Log"]..L["Log1 Time"]..L["Log1 Version"]..'|cff'.."e6cc80"..L["Log1 Text"]..L["Log1 Text"],
        textcolor           = Color(1,1,1,1),
        JustifyH            = "LEFT",
        Indented            = false,
        WordWrap            = true,
        width               = 350,
        font                = {
            font            = SEFontStyle[1].value,
            height          = 15,
        }
    }
}

