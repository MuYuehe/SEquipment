--========================================================--
--               SEquipment ListFrame Player              --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio    "BaseConfig.MainInterface.PlayerListFrame"     ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                       ListFrame                       --
-----------------------------------------------------------

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

-----------------------------------------------------------
--                   StandardParts                       --
-----------------------------------------------------------

----------------------------
--       UI Assembly      --425-80-20-37-((16*18)==256)
----------------------------
-------------
--   Main  --
-------------
PlayerScanFrame                         = SESetMenuFrame("PlayerScanFrame",PaperDollFrame)
------------
-- Header --
------------
    PlayerHeaderFrame                       = SESetMenuFrame("PlayerHeaderFrame",PlayerScanFrame)
        PlayerHeaderLeftFont                = EquipInfoFontString("PlayerHeaderLeftFont",PlayerHeaderFrame)
        PlayerHeaderRightFont               = EquipInfoFontString("PlayerHeaderRightFont",PlayerHeaderFrame)
---------------
-- EquipList --
---------------
    PlayerEquipListFrame                    = SESetMenuFrame("PlayerEquipListFrame",PlayerScanFrame)
        PlayerStatsIconFrameList            = SESetMenuFrame("PlayerStatsIconFrameList",PlayerEquipListFrame)
        PlayerEquipPartFrameList            = SESetMenuFrame("PlayerEquipPartFrameList",PlayerEquipListFrame)
        PlayerEquipLevelFrameList           = SESetMenuFrame("PlayerEquipLevelFrameList",PlayerEquipListFrame)
        PlayerEquipNameFrameList            = SESetMenuFrame("PlayerEquipNameFrameList",PlayerEquipListFrame)
----------------
--     Gem    --
----------------
    PlayerGemInfoFrame                      = SESetMenuFrame("PlayerGemInfoFrame",PlayerScanFrame)
        PlayerGemInfoText                   = EquipInfoFontString("PlayerGemInfoText",PlayerGemInfoFrame)
-----------------
-- StatsNumber --
-----------------
    PlayerStatsNumberFrame                  = SESetMenuFrame("PlayerStatsNumberFrame",PlayerScanFrame)
        PlayerStatsNameList                 = SESetMenuFrame("PlayerStatsNameList",PlayerStatsNumberFrame)
        PlayerStatsNumberList               = SESetMenuFrame("PlayerStatsNumberList",PlayerStatsNumberFrame)
        PlayerStatsPercentList              = SESetMenuFrame("PlayerStatsPercentList",PlayerStatsNumberFrame)
---------------
-- EquipList --
---------------
for k = 1, 16 do
--------------------
-- StatsIconFrame --
--------------------
    local PlayerStatsIconFrame          = EquipInfoFrame("PlayerStatsIconFrame"..k,PlayerStatsIconFrameList)
    for i = 1, 4 do
        local PlayerStatsIconPart       = StatsIconFrame("PlayerStatsIconPart"..i..k,PlayerStatsIconFrame)
            local PlayerStatsIconTexture= Texture("PlayerStatsIconTexture"..i..k,PlayerStatsIconPart)
            local PlayerStatsIconText   = StatsIconText("PlayerStatsIconText"..i..k,PlayerStatsIconPart)
    end
-------------------------
-- PlayerEquipPartInfo --
-------------------------
    local PlayerEquipPartFrame          = EquipInfoPartAndLevel("PlayerEquipPartFrame"..k,PlayerEquipPartFrameList)
        local PlayerEquipPartText       = EquipInfoFontString("PlayerEquipPartText"..k,PlayerEquipPartFrame)
--------------------------
-- PlayerEquipLevelInfo --
--------------------------
    local PlayerEquipLevelFrame         = EquipInfoPartAndLevel("PlayerEquipLevelFrame"..k,PlayerEquipLevelFrameList)
        local PlayerEquipLevelText      = EquipInfoFontString("PlayerEquipLevelText"..k,PlayerEquipLevelFrame)
-------------------------
-- PlayerEquipNameInfo --
-------------------------
    local PlayerEquipNameFrame          = EquipInfoPartAndLevel("PlayerEquipNameFrame"..k,PlayerEquipNameFrameList)
        local PlayerEquipNameText       = EquipInfoFontString("PlayerEquipNameText"..k,PlayerEquipNameFrame)
        local PlayerNullGemwarnFrame    = StatsIconFrame("PlayerNullGemwarnFrame"..k,PlayerEquipNameFrame)
            local PlayerNullGemwarnTexture  = Texture("PlayerNullGemwarnTexture"..k,PlayerNullGemwarnFrame)
end
-----------------
-- StatsNumber --
-----------------
for i = 1, 4 do
    local PlayerStatsName               = SESetMenuFrame("PlayerStatsName"..i,PlayerStatsNameList)
        local PlayerStatsNameText       = EquipInfoFontString("PlayerStatsNameText"..i,PlayerStatsName)
    local PlayerStatsNumber             = SESetMenuFrame("PlayerStatsNumber"..i,PlayerStatsNumberList)
        local PlayerStatsNumberText     = EquipInfoFontString("PlayerStatsNumberText"..i,PlayerStatsNumber)
    local PlayerStatsPercent            = SESetMenuFrame("PlayerStatsPercent"..i,PlayerStatsPercentList)
        local PlayerStatsPercentText    = EquipInfoFontString("PlayerStatsPercentText"..i,PlayerStatsPercent)
end

--------------------------------------------------------
--                      Style                         --
--------------------------------------------------------
-------------
--   Main  --
-------------
Style[PlayerScanFrame]                  = {
    backdrop={
        bgFile                          = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
        edgeFile                        = [[Interface\Tooltips\UI-Tooltip-Border]],
        tile                            = true,
        tileSize                        = 0,
        edgeSize                        = 15,
        insets                          = {
                                            left    = 2,
                                            right   = 2,
                                            top     = 2,
                                            bottom  = 2,
        },
    },
    location                            = { Anchor("TOPLEFT",0,0,"PaperDollFrame","TOPRIGHT")},
    backdropcolor                       = Color(0,0,0,0.7),
    backdropbordercolor                 = Color(0,0,0,1),
    -- 宽度跟高度是会变化的值,这里不做固定值赋值
}
------------
-- Header --
------------
Style[PlayerHeaderFrame]                = {
    location                            = { Anchor("TOPLEFT",5,-5) },
    -- 高度虽然是固定的,但是高度被选项影响,所以这里也不用固定值赋值
    -- LeftFont因为是默认Style,所以不需要修改,而RightFont需要靠在右边,所以要修改下默认的Style
    PlayerHeaderRightFont               = {
        location                        = { Anchor("RIGHT") },
    }
}
---------------
-- EquipList --
---------------
Style[PlayerEquipListFrame]             = {
    location                            = { Anchor("TOPLEFT",0,0,"PlayerHeaderFrame","BOTTOMLEFT") },
    -- 高度跟宽度由装备中最长名字跟装备数量决定,所以这里不用固定值赋值
    -- 属性图标\装备部位\等级,由于受到选项影响,所以不做固定值赋值
    -- 高度已经赋值
    PlayerStatsIconFrameList            = {
        location                        = { Anchor("TOPLEFT",0,0) },
    },
    PlayerEquipPartFrameList            = {
        location                        = { Anchor("TOPLEFT",0,0,"PlayerStatsIconFrameList","TOPRIGHT") },
    },
    PlayerEquipLevelFrameList           = {
        location                        = { Anchor("TOPLEFT",0,0,"PlayerEquipPartFrameList","TOPRIGHT") },
    },
    -- 名字宽度受到最大名字长度影响,所以也不做固定值赋值
    PlayerEquipNameFrameList            = {
        location                        = { Anchor("TOPLEFT",0,0,"PlayerEquipLevelFrameList","TOPRIGHT") },
    },
}
for k = 1, 16 do
    for i = 1, 4 do
        Style[PlayerStatsIconFrameList] = {
            ["PlayerStatsIconFrame"..k] = {
                location                = { Anchor("TOPLEFT",0,(1-k)*18)},
                -- 因为宽度是固定的,当它的父框架宽度变成1的会后,它只是直接隐藏,所以不需要修改高度宽度,这里直接做成固定值
                -- 而它的Style里高度已经定义好了,这里只需要定义宽度即可
                width                   = 72,
                ["PlayerStatsIconPart"..i..k]               = {
                    -- Style已经有默认宽度高度了,这里不需要定义
                    location                                = { Anchor("LEFT",18*(i-1),0) },
                    ["PlayerStatsIconTexture"..i..k]        = {
                        File                                = TexturePath[i],
                        SetAllPoints                        = true,
                    },
                    ["PlayerStatsIconText"..i..k]           = {
                        text                                = StatsName[i],
                        TextColor                           = Color(StatsIconColor[i].r,StatsIconColor[i].g,StatsIconColor[i].b),
                    }
                }
            }
        }
    end
    Style[PlayerEquipPartFrameList]                         = {
        ["PlayerEquipPartFrame"..k]                         = {
            location                                        = { Anchor("TOPLEFT",0,(1-k)*(18))},
            -- 高度宽度已经有默认值了
        }
    }
    Style[PlayerEquipLevelFrameList]                        = {
        ["PlayerEquipLevelFrame"..k]                        = {
            location                                        = { Anchor("TOPLEFT",0,(1-k)*(18))},
            -- 高度宽度已经有默认值了
        }
    }
    Style[PlayerEquipNameFrameList]                         = {
        ["PlayerEquipNameFrame"..k]                         = {
            location                                        = { Anchor("TOPLEFT",0,(1-k)*(18))},
            -- 宽度是由最长名字决定,这里不做固定值赋值
            ["PlayerNullGemwarnFrame"..k]                   = {
                -- 宽度高度有默认值,但是固定位置随着装备名字长度改变
                ["PlayerNullGemwarnTexture"..k]             = {
                    File                                    = [[Interface\FriendsFrame\informationicon]],
                    SetAllPoints                            = true,
                }
            }
        }
    }
end
----------------
--     Gem    --
----------------
Style[PlayerGemInfoFrame]               = {
    location                            = { Anchor("TOPLEFT",0,0,"PlayerEquipListFrame","BOTTOMLEFT")},
    -- 这里选择将宝石栏的宽度固定,因为太长也不太美观
    width                               = 150,
    -- 宝石栏中的文字是随机的,不做固定值赋值
}
-----------------
-- StatsNumber --
-----------------
-- 属性栏这里我也做成固定宽度高度,因为太长也不美观
-- 如果选项选择隐藏,我不需要将属性栏的高度设置成1,而是直接Hide()可以,因为它是左后一个Frame,没有Frame依附于它
Style[PlayerStatsNumberFrame]           = {
    location                            = { Anchor("TOPLEFT",0,0,"PlayerGemInfoFrame","BOTTOMLEFT")},
    width                               = 150,
    PlayerStatsNameList                 = {
        location                        = { Anchor("TOPLEFT",0,0)},
        size                            = Size(50,80)
    },
    PlayerStatsNumberList               = {
        location                        = { Anchor("TOPLEFT",50,0)},
        size                            = Size(50,80)
    },
    PlayerStatsPercentList              = {
        location                        = { Anchor("TOPLEFT",100,0)},
        size                            = Size(50,80)
    }
}
for i = 1, 4 do
    Style[PlayerStatsNameList]          = {
        ["PlayerStatsName"..i]          = {
            width                       = 50,
            height                      = 20,
            location                    = { Anchor("TOP",0,(1-i)*20)},
            ["PlayerStatsNameText"..i]  = {
                text                    = StatsLongName[i]..":",
            },
        }
    }
    Style[PlayerStatsNumberList]        = {
        ["PlayerStatsNumber"..i]        = {
            width                       = 50,
            height                      = 20,
            location                    = { Anchor("TOP",0,(1-i)*20)},
        }
    }
    Style[PlayerStatsPercentList]       = {
        ["PlayerStatsPercent"..i]       = {
            width                       = 50,
            height                      = 20,
            location                    = { Anchor("TOP",0,(1-i)*20)},
        }
    }
end


----------------------------------------------------------
--                  Initialize ListFrame                --
----------------------------------------------------------
function OnEnable(self)
    InitializeData()
end

-- 初始化函数
function InitializeData()
-- 初始化属性图标
    if _SVDB.PlayerOption[3] then
        Style[PlayerStatsIconFrameList]                 = {
            width                                       = 72,
            alpha                                       = 1,
        }
    else
        Style[PlayerStatsIconFrameList]                 = {
            width                                       = 1,
            alpha                                       = 0,
        }
    end
-- 初始化部位
    if _SVDB.PlayerOption[4] then
        Style[PlayerEquipPartFrameList]                 = {
            width                                       = 36,
            alpha                                       = 1,
        }
    else
        Style[PlayerEquipPartFrameList]                 = {
            width                                       = 1,
            alpha                                       = 0,
        }
    end
-- 初始化等级
    if _SVDB.PlayerOption[5] then
        Style[PlayerEquipLevelFrameList]                = {
            width                                       = 36,
            alpha                                       = 1,
        }
    else
        Style[PlayerEquipLevelFrameList]                = {
            width                                       = 1,
            alpha                                       = 0,
        }
    end
-- 初始化装备列表的宽度
-- 这里只能设置宽度,因为初始化得时候不知道装备有多少个,不能确定高度
    Style[PlayerEquipListFrame]                         = {
        -- 宽度由属性图标\部位\等级\名称四个框架的宽度决定,
        -- 初始化时期名称框体宽度为0
        width                                           = PlayerStatsIconFrameList:GetWidth()+PlayerEquipPartFrameList:GetWidth()
                                                            +PlayerEquipLevelFrameList:GetWidth()+PlayerEquipNameFrameList:GetWidth(),
    }
-- 初始化HeaderFrame
    if _SVDB.PlayerOption[2] then
        Style[PlayerHeaderFrame]                        = {
            height                                      = 30,
            alpha                                       = 1,
        }
        if PlayerEquipNameFrameList:GetWidth() > 6 then
            Style[PlayerHeaderFrame]                    = {
                width                                   = PlayerEquipListFrame:GetWidth(),
            }
        else
            Style[PlayerHeaderFrame]                    = {
                width                                   = 250,
            }
        end
    else
        Style[PlayerHeaderFrame]                        = {
            height                                      = 1,
            alpha                                       = 0,
        }
    end
-- 初始化宝石框体
    if _SVDB.PlayerOption[6] then
        Style[PlayerGemInfoFrame]                       = {
            height                                      = 20,
            alpha                                       = 1,
        }
    else
        Style[PlayerGemInfoFrame]                       = {
            height                                      = 1,
            alpha                                       = 0,
        }
    end
-- 初始化属性框体
    if _SVDB.PlayerOption[7] then
        Style[PlayerStatsNumberFrame]                   = {
            height                                      = 80,
        }
        PlayerStatsNumberFrame:Show()
    else
        Style[PlayerStatsNumberFrame]                   = {
            height                                      = 1,
        }
        PlayerStatsNumberFrame:Hide()
    end
    if _SVDB.PlayerOption[8] then
        PlayerStatsPercentList:Show()
    else
        PlayerStatsPercentList:Hide()
    end
-- 初始化主框体
    if _SVDB.PlayerOption[1] then
        if PlayerEquipNameFrameList:GetWidth() > 6 then
            Style[PlayerScanFrame]                      = {
                width                                   = PlayerEquipListFrame:GetWidth()+15,
                height                                  = PlayerHeaderFrame:GetHeight()+PlayerEquipListFrame:GetHeight()
                                                            +PlayerGemInfoFrame:GetHeight()+PlayerStatsNumberFrame:GetHeight()+7,
            }
        else
            Style[PlayerScanFrame]                      = {
                width                                   = 265,
                height                                  = PlayerHeaderFrame:GetHeight()+PlayerEquipListFrame:GetHeight()
                                                            +PlayerGemInfoFrame:GetHeight()+PlayerStatsNumberFrame:GetHeight()+7,
            }
        end
        PlayerScanFrame:Show()
    else
        Style[PlayerScanFrame]                          = {
            width                                       = 0,
            height                                      = 0,
        }
        PlayerScanFrame:Hide()
    end
-- 初始化字体
    Style.UpdateSkin("Default",{
        [EquipInfoFontString]       = {
            location                = { Anchor("LEFT") },
            font                    = {
                font                = SEFontStyle[_SVDB.FontStyleSet].value,
                height              = _SVDB.FontSizeSet,
            }
        },
        [StatsIconText]             = {
            location                = { Anchor("CENTER") },
            font                    = {
                font                = SEFontStyle[_SVDB.FontStyleSet].value,
                height              = _SVDB.FontSizeSet,
            }
        },
    })
end