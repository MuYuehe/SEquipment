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
NoMeanOneFont = FontString("NoMeanOneFont",HomeFrame)
NoMeanTwoFont = FontString("NoMeanTwoFont",HomeFrame)
-- HomeFrame:Hide()

-- Style --
Style[NoMeanOneFont]                = {
    location                        = { Anchor("CENTER",0,30) },
        text                        = "WELCOME",
        font                        = {
            font                    = STANDARD_TEXT_FONT,
            height                  = 30,
        }
}

Style[NoMeanTwoFont]                = {
    location                        = { Anchor("CENTER",0,-30) },
        text                        = "SEQUIPMENT",
        font                        = {
            font                    = STANDARD_TEXT_FONT,
            height                  = 30,
        }
}