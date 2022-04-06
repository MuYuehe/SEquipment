Scorpio "BaseConfig.Locale.enUS" ""
local L = _Locale("enUS",true)

if not L then
    return
end

L["Home"]                           = "Home"
L["General"]                        = "General"
    L["Font Set"]                   = "Font Set"
        L["Font"]                   = "Font"
        L["Font Size"]              = "Size"
    L["Level Set"]                  = "Level Show Set"
        L["Show"]                   = "Show"
        L["Size"]                   = "Size"
        L["Location"]               = "Location"
        L["Level Self"]             = "Self"
        L["Level Target"]           = "Target"
        L["Level Bag"]              = "Bag"
        L["Level Bank"]             = "Bank"
        L["Level Guild"]            = "Guild"
        L["Level GB"]               = "Guild Bank"
        L["Level Chat"]             = "Chat"
L["Player"]                         = "Player"
    L["Show Player Module"]         = "Show Player Module"
    L["Show Level Module"]          = "Show Level Module"
    L["Show Specialization"]        = "Show Specialization Module"
    L["Show Slots"]                 = "Show SlotsPart Module"
    L["Show Stats Icon"]            = "Show Stats Type Module"
    L["Show GemEnchant"]            = "Show Gem Module"
    L["Show Attributes"]            = "Show Attributes Module"
    L["Show Attributes Percent"]    = "Show Attributes Percent Module"
L["Target"]                         = "Target"
    L["Show Target Module"]         = "Show Target Module"
    L["Show Self Simultaneously"]   ="While Observing The Target, Display The Own Equipment List Panel"
L["Exit"]                           = "Exit"
L["DEFAULT"]                        = "Default"
L["Crit"]                           = "C"
L["Haste"]                          = "H"
L["Mastery"]                        = "M"
L["Versatility"]                    = "V"
L["CritLong"]                       = "Crit"
L["HasteLong"]                      = "Haste"
L["MasteryLong"]                    = "Mastery"
L["VersatilityLong"]                = "Versa"
L["Head"]                           = "HEA"
L["Neck"]                           = "NEC"
L["Shoulders"]                      = "SHO"
L["Chest"]                          = "CHE"
L["Waist"]                          = "WAI"
L["Legs"]                           = "LEG"
L["Feet"]                           = "FEE"
L["Wrist"]                          = "WRI"
L["Hands"]                          = "HAN"
L["Finger1"]                        = "FIN"
L["Finger2"]                        = "FIN"
L["Trinket1"]                       = "TRI"
L["Trinket2"]                       = "TRI"
L["Back"]                           = "BAC"
L["Main Hand"]                      = "MHA"
L["Off Hand"]                       = "OHA"






--------------------------------------------------
--                   ChangeLog                  --
--------------------------------------------------
L["Log"]                            = "ChangeLog\n"
L["Log1 Time"]                      = "2022/4/6"
L["Log1 Version"]                   = "V2.0.1\n"
L["Log1 Text"]                      = "1.Modify the quality color display, now it can correctly display different quality colors\n"
                                        .."2.For the font size setting in the general menu, it is now preset to 14-16, and this option will be updated in the large version + new, and the frame under the influence of the text size will be adjusted.\n"
                                        .."3.Adjust the display order of the target observation frame, and now it is correctly placed after the Blizzard_InspectUI is loaded, and the error that the InspectPaperDollFrame frame cannot be found will not be reported.\n"
                                        .."4.Some bloated code was removed as smaller functions were added\n"
                                        .."5.The home page is now replaced with a changelog page, showing details of future releases\n"
                                        .."6.Update version number V2.0.1, this version is an emergency repair version, which is a minor version update\n"