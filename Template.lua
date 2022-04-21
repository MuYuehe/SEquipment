--========================================================--
--                     TEMPLATE                           --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/04/19                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.SEquipment.Template" ""
--========================================================--
L                    = _Locale
-----------------------------------------------------------
--                                                       --
-----------------------------------------------------------
SCROLLFRAME_BACKDROP = {
    bgFile   = [[Interface\chatframe\chatframebackground]],
    edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
    tile     = true,
    tileSize = 0,
    edgeSize = 15,
    insets   = { left = 2, right = 2, top = 2, bottom = 2, }
}
BACKDROP             = {
    bgFile   = [[Interface\chatframe\chatframebackground]],
    edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
    tile     = true,
    tileSize = 0,
    edgeSize = 15,
    insets   = { left = 0, right = 0, top = 0, bottom = 0, }
}

Style.UpdateSkin("Default", {
    [UIMenu] = {
        size        = Size(600, 400),
        resizable   = false,
        location    = { Anchor("CENTER") },
        CloseButton = {
            location = {},
        },
        Header      = {
            text = "|cff87CEEBS|r|cffEF5555E|r|cffA0522DQ|r|cff6ED73AU|r|cffFE4500I|r|cff3399EAP|r|cffFFFFFFment|r"
        },
        TreeView    = {
            size          = Size(150, 320),
            location      = { Anchor("LEFT", 15) },
            backdropcolor = Color(0, 0, 0, 0),
        },
        ExitButton  = {
            size     = Size(80, 20),
            location = { Anchor("BOTTOMRIGHT", -15, 15) },
            text     = L["Exit"],
        },
        Info        = {
            location = { Anchor("BOTTOMLEFT", 15, 15) },
            text = L["Log1 Version"],
            textcolor = Color(0.5, 0.5, 0.5, 1),
        }
    },
    [HomePage] = {
        size                = Size(400, 320),
        location            = { Anchor("RIGHT", -15, 0) },
        backdrop            = BACKDROP,
        backdropcolor       = Color(0, 0, 0, 0),
        backdropbordercolor = Color(1, 1, 1, 1),
        BorderFrame         = {
            size                = Size(380, 250),
            location            = { Anchor("BOTTOM", 0, 5) },
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(1, 1, 1, 0.3),
        },
        ScrollFrame         = {
            size                = Size(380, 240),
            backdrop            = SCROLLFRAME_BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(1, 1, 1, 0),
            location            = { Anchor("BOTTOM", 0, 10) },
            ScrollBar           = {
                location = {
                    Anchor("TOPRIGHT", -5, -15, nil, "TOPRIGHT"),
                    Anchor("BOTTOMRIGHT", -5, 15, nil, "BOTTOMRIGHT"),
                },
            },
            ScrollChild         = {
                Info = {
                    location  = { Anchor("TOPLEFT", 5, -5) },
                    text      = L["Log"] .. L["Log1 Time"] .. " " .. L["Log1 Version"] .. '|cff' .. "e6cc80" .. L["Log1 Text"],
                    textcolor = Color(1, 1, 1, 1),
                    JustifyH  = "LEFT",
                    Indented  = false,
                    WordWrap  = true,
                    width     = 350,
                    font      = {
                        font   = SEFontStyle[1].value,
                        height = 15,
                    }
                }
            },
        },
        Info                = {
            location = { Anchor("TOPLEFT", 10, -20) },
            text     = '|cff00ccff' .. L["Log"],
            font     = {
                font   = SEFontStyle[1].value,
                height = 30,
            }
        },
        Border              = {
            size                = Size(380, 250),
            location            = { Anchor("BOTTOM", 0, 5) },
            backdropbordercolor = Color(1, 1, 1, 0.3),
        },
    },
    [GeneralPage] = {
        size                = Size(400, 320),
        location            = { Anchor("RIGHT", -15, 0) },
        backdrop            = BACKDROP,
        backdropcolor       = Color(0, 0, 0, 0),
        backdropbordercolor = Color(1, 1, 1, 1),
        FirstFrame          = {
            size                = Size(380, 70),
            location            = { Anchor("TOP", 0, -25) },
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(1, 1, 1, 0.3),
            Info                = {
                location = { Anchor("TOPLEFT", 5, 15) },
                text = L["Font Set"],
                textcolor = Color(1, 1, 1, 1)
            },
            combobox            = {
                size     = Size(200, 30),
                location = { Anchor("LEFT", 0, -10) },
                label    = {
                    text      = L["Font"],
                    textcolor = Color(1, 0.84, 0, 1),
                    location  = { Anchor("LEFT", 20, 25, nil, "LEFT") }
                }
            },
            trackbar            = {
                size           = Size(150, 20),
                location       = { Anchor("RIGHT", -15, -10) },
                minMaxValues   = MinMax(0.5, 2),
                valueStep      = .1,
                obeyStepOnDrag = true,
                MinText        = {
                    text = "",
                },
                MaxText        = {
                    text = "",
                },
                label          = {
                    text      = L["Frame Scale"],
                    textcolor = Color(1, 0.84, 0, 1),
                    location  = { Anchor("LEFT", 0, 20, nil, "LEFT") }
                }
            }
        },
        SecondFrame         = {
            size                = Size(380, 190),
            location            = { Anchor("TOP", 0, -120) },
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(1, 1, 1, 0),
            ScrollBar           = {
                location = {
                    Anchor("TOPRIGHT", -5, -15, nil, "TOPRIGHT"),
                    Anchor("BOTTOMRIGHT", -5, 15, nil, "BOTTOMRIGHT"),
                },
            },
            Info                = {
                location  = { Anchor("TOPLEFT", 5, 20) },
                text      = L["Level Set"],
                textcolor = Color(1, 1, 1, 1)
            }
        },
        SecondBorder        = {
            size                = Size(380, 200),
            location            = { Anchor("TOP", 0, -115) },
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(1, 1, 1, 0.3),
        },
    },
    [LevelWidget] = {
        size                = Size(150, 100),
        backdrop            = BACKDROP,
        backdropcolor       = Color(0, 0, 0, 0),
        backdropbordercolor = Color(1, 1, 1, 0.3),
        Info                = {
            location  = { Anchor("TOPLEFT", 5, 15) },
            textcolor = Color(1, 1, 1, 1)
        },
        checkbutton         = {
            size     = Size(32, 32),
            location = { Anchor("TOPLEFT", 5) },
            label    = {
                text     = L["Show"],
                location = { Anchor("LEFT", 30, 0) }
            }
        },
        combobox            = {
            size     = Size(170, 30),
            location = { Anchor("LEFT", -10, 9) },
            label    = {
                text      = L["Location"],
                textcolor = Color(1, 0.84, 0, 1),
                location  = { Anchor("RIGHT", -15, 25, nil, "RIGHT") }
            }
        },
        trackbar            = {
            size     = Size(130, 20),
            location = { Anchor("BOTTOM", 0, 25) },

            minMaxValues   = MinMax(1, 50),
            valueStep      = 1,
            obeyStepOnDrag = true,
        }
    },
    [PlayerPage] = {
        size                = Size(400, 320),
        location            = { Anchor("RIGHT", -15, 0) },
        backdrop            = BACKDROP,
        backdropcolor       = Color(0, 0, 0, 0),
        backdropbordercolor = Color(1, 1, 1, 0.3),
    },
    [CheckButton_Widget] = {
        size = Size(32, 32),
    },
    [MainFrame] = {
        backdrop            = SCROLLFRAME_BACKDROP,
        backdropcolor       = Color(0, 0, 0, 0.7),
        backdropbordercolor = Color(0, 0, 0, 1),
        TopFrame            = {
            location = { Anchor("TOPLEFT", 5, 0) },
            Left_Info = {
                location = { Anchor("LEFT") },
            },
            Right_Info = {
                location = { Anchor("RIGHT") },
            }
        },
        EquipListFrame      = {
            size                = Size(100, 288),
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
        },
        GemSuitFrame        = {
            width               = 150,
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
            Left_Info           = {
                location = { Anchor("LEFT") },
            },
            Right_Info          = {
                location = { Anchor("LEFT", 80) },
            }
        },
        BottomFrame         = {
            width               = 150,
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
            Crit                = {
                size                = Size(150, 20),
                location            = { Anchor("TOPLEFT") },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                Title               = {
                    location = { Anchor("LEFT") },
                    text = L["CritLong"],
                },
                Number              = {
                    location = { Anchor("LEFT", 50, 0) },
                    textcolor = Color(0, 1, 0),
                },
                Percent             = {
                    location = { Anchor("LEFT", 100, 0) },
                    textcolor = Color(0, 1, 0),
                },
            },
            Haste               = {
                size                = Size(150, 20),
                location            = { Anchor("TOPLEFT", 0, -20) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                Title               = {
                    location = { Anchor("LEFT") },
                    text = L["HasteLong"],
                },
                Number              = {
                    location = { Anchor("LEFT", 50, 0) },
                    textcolor = Color(0, 1, 0)
                },
                Percent             = {
                    location = { Anchor("LEFT", 100, 0) },
                    textcolor = Color(0, 1, 0)
                },
            },
            Mastery             = {
                size                = Size(150, 20),
                location            = { Anchor("TOPLEFT", 0, -40) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                Title               = {
                    location = { Anchor("LEFT") },
                    text = L["MasteryLong"],
                },
                Number              = {
                    location = { Anchor("LEFT", 50, 0) },
                    textcolor = Color(0, 1, 0)
                },
                Percent             = {
                    location = { Anchor("LEFT", 100, 0) },
                    textcolor = Color(0, 1, 0)
                },
            },
            Versa               = {
                size                = Size(150, 20),
                location            = { Anchor("TOPLEFT", 0, -60) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                Title               = {
                    location = { Anchor("LEFT") },
                    text = L["VersatilityLong"],
                },
                Number              = {
                    location = { Anchor("LEFT", 50, 0) },
                    textcolor = Color(0, 1, 0)
                },
                Percent             = {
                    location = { Anchor("LEFT", 100, 0) },
                    textcolor = Color(0, 1, 0)
                },
            },
        },
    },
    [Per_Equip] = {
        height              = 18,
        backdrop            = BACKDROP,
        backdropcolor       = Color(0, 0, 0, 0),
        backdropbordercolor = Color(0, 0, 0, 0),
        IconFrame           = {
            height              = 18,
            location            = { Anchor("LEFT") },
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
            Crit                = {
                size                = Size(18, 18),
                location            = { Anchor("LEFT", 0, 0) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    File = [[Interface\AddOns\SEquipment\Media\CRIT]],
                    SetAllPoints = true,
                },
                Info                = {
                    location = { Anchor("CENTER") },
                    text = L["Crit"],
                    textcolor = Color(1, 0.5, 0.3),
                }
            },
            Haste               = {
                size                = Size(18, 18),
                location            = { Anchor("LEFT", 18, 0) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    File = [[Interface\AddOns\SEquipment\Media\HASTE]],
                    SetAllPoints = true,
                },
                Info                = {
                    location = { Anchor("CENTER") },
                    text = L["Haste"],
                    textcolor = Color(0.9, 1, 0.1),
                }
            },
            Mastery             = {
                size                = Size(18, 18),
                location            = { Anchor("LEFT", 36, 0) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    File = [[Interface\AddOns\SEquipment\Media\MASTERY]],
                    SetAllPoints = true,
                },
                Info                = {
                    location = { Anchor("CENTER") },
                    text = L["Mastery"],
                    textcolor = Color(0.8, 0.1, 1),
                }
            },
            Versa               = {
                size                = Size(18, 18),
                location            = { Anchor("LEFT", 54, 0) },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    File = [[Interface\AddOns\SEquipment\Media\VERSATILITY]],
                    SetAllPoints = true,
                },
                Info                = {
                    location = { Anchor("CENTER") },
                    text = L["Versatility"],
                    textcolor = Color(0.1, 0.3, 1),
                }
            },
        },
        PartFrame           = {
            height              = 18,
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0),
            backdropbordercolor = Color(0, 0, 0),
            TextureFrame        = {
                size                = Size(34, 16),
                location            = { Anchor("CENTER") },
                backdrop            = {
                    bgFile   = [[Interface\chatframe\chatframebackground]],
                    edgeFile = [[Interface\Buttons\WHITE8X8]],
                    tile     = true,
                    tileSize = 0,
                    edgeSize = 1,
                    insets   = {
                        left   = 0,
                        right  = 0,
                        top    = 0,
                        bottom = 0,
                    },
                },
                backdropcolor       = Color(0, 0.9, 0.9, 0.2),
                backdropbordercolor = Color(0, 0.9, 0.9, 0.7),
                Info                = {
                    location = { Anchor("CENTER") },
                    textcolor = Color(0, 0.8, 1, 1),
                }
            },
        },
        LevelFrame          = {
            height              = 18,
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
            Info                = {
                location = { Anchor("CENTER") },
                textcolor = Color(1, 1, 1)
            }
        },
        NameFrame           = {
            height              = 18,
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
            Info                = {
                location = { Anchor("LEFT") },
            },
        },
        GemEnFrame          = {
            height              = 12,
            backdrop            = BACKDROP,
            backdropcolor       = Color(0, 0, 0, 0),
            backdropbordercolor = Color(0, 0, 0, 0),
            Enchant             = {
                height              = 12,
                location            = { Anchor("LEFT") },
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    size = Size(12, 12),
                    location = { Anchor("CENTER") },
                    File = [[Interface\Cursor\Quest]],
                    Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
                }
            },
            Gem1                = {
                height              = 12,
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    size = Size(12, 12),
                    location = { Anchor("CENTER") },
                    File = [[Interface\Cursor\Quest]],
                    Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
                }
            },
            Gem2                = {
                height              = 12,
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    size = Size(12, 12),
                    location = { Anchor("CENTER") },
                    File = [[Interface\Cursor\Quest]],
                    Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
                }
            },
            Gem3                = {
                height              = 12,
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    size = Size(12, 12),
                    location = { Anchor("CENTER") },
                    File = [[Interface\Cursor\Quest]],
                    Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
                }
            },
            Gem4                = {
                height              = 12,
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    size = Size(12, 12),
                    location = { Anchor("CENTER") },
                    File = [[Interface\Cursor\Quest]],
                    Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
                }
            },
            Empty               = {
                height              = 12,
                backdrop            = BACKDROP,
                backdropcolor       = Color(0, 0, 0, 0),
                backdropbordercolor = Color(0, 0, 0, 0),
                texture             = {
                    size = Size(12, 12),
                    location = { Anchor("CENTER") },
                    File = [[Interface\Cursor\Quest]],
                    Mask = [[Interface\FriendsFrame\Battlenet-Portrait]],
                }
            },
        },
    },
})
