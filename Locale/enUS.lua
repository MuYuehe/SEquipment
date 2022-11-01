--========================================================--
--               SEquipment US Locale                     --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/04/12                              --
--========================================================--

--========================================================--
Scorpio             "BaseConfig.Locale.enUS"              ""
--========================================================--
local L = _Locale("enUS", true)
-----------------------------------------------------------
--                      Locale                           --
-----------------------------------------------------------

if not L then return end

L["Home"]                     = "Home"
L["General"]                  = "General"
L["Font Set"]                 = "Font Set"
L["Font"]                     = "Font"
L["Frame Scale"]              = "Scale"
L["Level Set"]                = "Level Show Set"
L["Show"]                     = "Show"
L["Size"]                     = "Size"
L["Location"]                 = "Location"
L["Level Self"]               = "Self"
L["Level Target"]             = "Target"
L["Level Bag"]                = "Bag"
L["Level Bank"]               = "Bank"
L["Level Guild"]              = "Guild"
L["Level GB"]                 = "Guild Bank"
L["Level Chat"]               = "Chat"
L["Player"]                   = "Player"
L["Show List Module"]         = "Show List Module"
L["Show Level Module"]        = "Show Level Module"
L["Show Specialization"]      = "Show Specialization Module"
L["Show Slots"]               = "Show SlotsPart Module"
L["Show Stats Icon"]          = "Show Stats Type Module"
L["Show GemEnchant"]          = "Show Gem Module"
L["Show Attributes"]          = "Show Attributes Module"
L["Show Attributes Percent"]  = "Show Attributes Percent Module"
L["Target"]                   = "Target"
L["Show Target Module"]       = "Show Target Module"
L["Show Self Simultaneously"] = "While Observing The Target, Display The Own Equipment List Panel"
L["Exit"]                     = "Exit"
L["DEFAULT"]                  = "Default"
L["Crit"]                     = "C"
L["Haste"]                    = "H"
L["Mastery"]                  = "M"
L["Versatility"]              = "V"
L["CritLong"]                 = "C"
L["HasteLong"]                = "H"
L["MasteryLong"]              = "M"
L["VersatilityLong"]          = "V"
L["Head"]                     = "HEA"
L["Neck"]                     = "NEC"
L["Shoulders"]                = "SHO"
L["Chest"]                    = "CHE"
L["Waist"]                    = "WAI"
L["Legs"]                     = "LEG"
L["Feet"]                     = "FEE"
L["Wrist"]                    = "WRI"
L["Hands"]                    = "HAN"
L["Finger"]                   = "FIN"
L["Trinket"]                  = "TRI"
L["Back"]                     = "BAC"
L["Main Hand"]                = "MHA"
L["Off Hand"]                 = "OHA"
L["TOP"]                      = "TOP"
L["BOTTOM"]                   = "BOTTOM"
L["LEFT"]                     = "LEFT"
L["RIGHT"]                    = "RIGHT"
L["CENTER"]                   = "CENTER"
L["TOPLEFT"]                  = "TOPLEFT"
L["TOPRIGHT"]                 = "TOPRIGHT"
L["BOTTOMLEFT"]               = "BOTTOMLEFT"
L["BOTTOMRIGHT"]              = "BOTTOMRIGHT"
L["Gem"]                      = "GemNum"
L["Suit"]                     = "SuitNum"
L["Empty GemSlot"]            = "Empty GemSlot"



--------------------------------------------------
--                   ChangeLog                  --
--------------------------------------------------
L["Log"]          = "ChangeLog\n"
L["Log1 Time"]    = "2022/10/1"
L["Log1 Version"] = "V2.3.0 Beta\n"
L["Log1 Text"]    = "1.For the emergency maintenance of 10.0, some functions are lost due to API changes.\n"
    .. "2.Subsequent equipment level display will be released when 10.0 is officially launched.\n"
    -- .. '3.Delete the position of some parts, now only two options of "top" and "bottom" are retained, and the text of equipment parts will change with the level position\n'
    -- .. "4.The comprehensive optimization of the code is completed. At that time, the update progress of this plug-in will slow down. In the future, only maintenance updates will be made after the game version is updated, and new functions will not be added or deleted (except localization)\n"
    -- .. "5.Consolidated player and target options, now they use unified options\n"
    -- .. "6.Update version number V2.1.0, this version is a medium version update, fixes a lot of errors and code redundancy\n"
