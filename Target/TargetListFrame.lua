--========================================================--
--               SEquipment ListFrame Target              --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio    "BaseConfig.MainInterface.TargetListFrame"     ""
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
TargetScanFrame                         = SESetMenuFrame("TargetScanFrame")
------------
-- Header --
------------
    TargetHeaderFrame                       = SESetMenuFrame("TargetHeaderFrame",TargetScanFrame)
        TargetHeaderLeftFont                = EquipInfoFontString("TargetHeaderLeftFont",TargetHeaderFrame)
        TargetHeaderRightFont               = EquipInfoFontString("TargetHeaderRightFont",TargetHeaderFrame)
---------------
-- EquipList --
---------------
    TargetEquipListFrame                    = SESetMenuFrame("TargetEquipListFrame",TargetScanFrame)
        TargetStatsIconFrameList            = SESetMenuFrame("TargetStatsIconFrameList",TargetEquipListFrame)
        TargetEquipPartFrameList            = SESetMenuFrame("TargetEquipPartFrameList",TargetEquipListFrame)
        TargetEquipLevelFrameList           = SESetMenuFrame("TargetEquipLevelFrameList",TargetEquipListFrame)
        TargetEquipNameFrameList            = SESetMenuFrame("TargetEquipNameFrameList",TargetEquipListFrame)
----------------
--     Gem    --
----------------
    TargetGemInfoFrame                      = SESetMenuFrame("TargetGemInfoFrame",TargetScanFrame)
        TargetGemInfoText                   = EquipInfoFontString("TargetGemInfoText",TargetGemInfoFrame)
-----------------
-- StatsNumber --
-----------------
    TargetStatsNumberFrame                  = SESetMenuFrame("TargetStatsNumberFrame",TargetScanFrame)
        TargetStatsNameList                 = SESetMenuFrame("TargetStatsNameList",TargetStatsNumberFrame)
        TargetStatsNumberList               = SESetMenuFrame("TargetStatsNumberList",TargetStatsNumberFrame)
        TargetStatsPercentList              = SESetMenuFrame("TargetStatsPercentList",TargetStatsNumberFrame)
---------------
-- EquipList --
---------------
for k = 1, 16 do
--------------------
-- StatsIconFrame --
--------------------
    local TargetStatsIconFrame          = EquipInfoFrame("TargetStatsIconFrame"..k,TargetStatsIconFrameList)
    for i = 1, 4 do
        local TargetStatsIconPart       = StatsIconFrame("TargetStatsIconPart"..i..k,TargetStatsIconFrame)
            local TargetStatsIconTexture= Texture("TargetStatsIconTexture"..i..k,TargetStatsIconPart)
            local TargetStatsIconText   = StatsIconText("TargetStatsIconText"..i..k,TargetStatsIconPart)
    end
-------------------------
-- TargetEquipPartInfo --
-------------------------
    local TargetEquipPartFrame          = EquipInfoPartAndLevel("TargetEquipPartFrame"..k,TargetEquipPartFrameList)
        local TargetEquipPartText       = EquipInfoFontString("TargetEquipPartText"..k,TargetEquipPartFrame)
--------------------------
-- TargetEquipLevelInfo --
--------------------------
    local TargetEquipLevelFrame         = EquipInfoPartAndLevel("TargetEquipLevelFrame"..k,TargetEquipLevelFrameList)
        local TargetEquipLevelText      = EquipInfoFontString("TargetEquipLevelText"..k,TargetEquipLevelFrame)
-------------------------
-- TargetEquipNameInfo --
-------------------------
    local TargetEquipNameFrame          = EquipInfoPartAndLevel("TargetEquipNameFrame"..k,TargetEquipNameFrameList)
        local TargetEquipNameText       = EquipInfoFontString("TargetEquipNameText"..k,TargetEquipNameFrame)
        local TargetNullGemwarnFrame    = StatsIconFrame("TargetNullGemwarnFrame"..k,TargetEquipNameFrame)
            local TargetNullGemwarnTexture  = Texture("TargetNullGemwarnTexture"..k,TargetNullGemwarnFrame)
end
-----------------
-- StatsNumber --
-----------------
for i = 1, 4 do
    local TargetStatsName               = SESetMenuFrame("TargetStatsName"..i,TargetStatsNameList)
        local TargetStatsNameText       = EquipInfoFontString("TargetStatsNameText"..i,TargetStatsName)
    local TargetStatsNumber             = SESetMenuFrame("TargetStatsNumber"..i,TargetStatsNumberList)
        local TargetStatsNumberText     = EquipInfoFontString("TargetStatsNumberText"..i,TargetStatsNumber)
    local TargetStatsPercent            = SESetMenuFrame("TargetStatsPercent"..i,TargetStatsPercentList)
        local TargetStatsPercentText    = EquipInfoFontString("TargetStatsPercentText"..i,TargetStatsPercent)
end

--------------------------------------------------------
--                      Style                         --
--------------------------------------------------------
-------------
--   Main  --
-------------
Style[TargetScanFrame]                  = {
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
    backdropcolor                       = Color(0,0,0,0.7),
    backdropbordercolor                 = Color(0,0,0,1),
    -- 宽度跟高度是会变化的值,这里不做固定值赋值
}
------------
-- Header --
------------
Style[TargetHeaderFrame]                = {
    location                            = { Anchor("TOPLEFT",5,-5) },
    -- 高度虽然是固定的,但是高度被选项影响,所以这里也不用固定值赋值
    -- LeftFont因为是默认Style,所以不需要修改,而RightFont需要靠在右边,所以要修改下默认的Style
    TargetHeaderRightFont               = {
        location                        = { Anchor("RIGHT") },
    }
}
---------------
-- EquipList --
---------------
Style[TargetEquipListFrame]             = {
    location                            = { Anchor("TOPLEFT",0,0,"TargetHeaderFrame","BOTTOMLEFT") },
    -- 高度跟宽度由装备中最长名字跟装备数量决定,所以这里不用固定值赋值
    -- 属性图标\装备部位\等级,由于受到选项影响,所以不做固定值赋值
    -- 高度已经赋值
    TargetStatsIconFrameList            = {
        location                        = { Anchor("TOPLEFT",0,0) },
    },
    TargetEquipPartFrameList            = {
        location                        = { Anchor("TOPLEFT",0,0,"TargetStatsIconFrameList","TOPRIGHT") },
    },
    TargetEquipLevelFrameList           = {
        location                        = { Anchor("TOPLEFT",0,0,"TargetEquipPartFrameList","TOPRIGHT") },
    },
    -- 名字宽度受到最大名字长度影响,所以也不做固定值赋值
    TargetEquipNameFrameList            = {
        location                        = { Anchor("TOPLEFT",0,0,"TargetEquipLevelFrameList","TOPRIGHT") },
    },
}
for k = 1, 16 do
    for i = 1, 4 do
        Style[TargetStatsIconFrameList] = {
            ["TargetStatsIconFrame"..k] = {
                location                = { Anchor("TOPLEFT",0,(1-k)*18)},
                -- 因为宽度是固定的,当它的父框架宽度变成1的会后,它只是直接隐藏,所以不需要修改高度宽度,这里直接做成固定值
                -- 而它的Style里高度已经定义好了,这里只需要定义宽度即可
                width                   = 72,
                ["TargetStatsIconPart"..i..k]               = {
                    -- Style已经有默认宽度高度了,这里不需要定义
                    location                                = { Anchor("LEFT",18*(i-1),0) },
                    ["TargetStatsIconTexture"..i..k]        = {
                        File                                = TexturePath[i],
                        SetAllPoints                        = true,
                    },
                    ["TargetStatsIconText"..i..k]           = {
                        text                                = StatsName[i],
                        TextColor                           = Color(StatsIconColor[i].r,StatsIconColor[i].g,StatsIconColor[i].b),
                    }
                }
            }
        }
    end
    Style[TargetEquipPartFrameList]                         = {
        ["TargetEquipPartFrame"..k]                         = {
            location                                        = { Anchor("TOPLEFT",0,(1-k)*(18))},
            -- 高度宽度已经有默认值了
        }
    }
    Style[TargetEquipLevelFrameList]                        = {
        ["TargetEquipLevelFrame"..k]                        = {
            location                                        = { Anchor("TOPLEFT",0,(1-k)*(18))},
            -- 高度宽度已经有默认值了
        }
    }
    Style[TargetEquipNameFrameList]                         = {
        ["TargetEquipNameFrame"..k]                         = {
            location                                        = { Anchor("TOPLEFT",0,(1-k)*(18))},
            -- 宽度是由最长名字决定,这里不做固定值赋值
            ["TargetNullGemwarnFrame"..k]                   = {
                -- 宽度高度有默认值,但是固定位置随着装备名字长度改变
                ["TargetNullGemwarnTexture"..k]             = {
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
Style[TargetGemInfoFrame]               = {
    location                            = { Anchor("TOPLEFT",0,0,"TargetEquipListFrame","BOTTOMLEFT")},
    -- 这里选择将宝石栏的宽度固定,因为太长也不太美观
    width                               = 150,
    -- 宝石栏中的文字是随机的,不做固定值赋值
}
-----------------
-- StatsNumber --
-----------------
-- 属性栏这里我也做成固定宽度高度,因为太长也不美观
-- 如果选项选择隐藏,我不需要将属性栏的高度设置成1,而是直接Hide()可以,因为它是左后一个Frame,没有Frame依附于它
Style[TargetStatsNumberFrame]           = {
    location                            = { Anchor("TOPLEFT",0,0,"TargetGemInfoFrame","BOTTOMLEFT")},
    width                               = 150,
    TargetStatsNameList                 = {
        location                        = { Anchor("TOPLEFT",0,0)},
        size                            = Size(50,80)
    },
    TargetStatsNumberList               = {
        location                        = { Anchor("TOPLEFT",50,0)},
        size                            = Size(50,80)
    },
    TargetStatsPercentList              = {
        location                        = { Anchor("TOPLEFT",100,0)},
        size                            = Size(50,80)
    }
}
for i = 1, 4 do
    Style[TargetStatsNameList]          = {
        ["TargetStatsName"..i]          = {
            width                       = 50,
            height                      = 20,
            location                    = { Anchor("TOP",0,(1-i)*20)},
            ["TargetStatsNameText"..i]  = {
                text                    = StatsLongName[i]..":",
            },
        }
    }
    Style[TargetStatsNumberList]        = {
        ["TargetStatsNumber"..i]        = {
            width                       = 50,
            height                      = 20,
            location                    = { Anchor("TOP",0,(1-i)*20)},
        }
    }
    Style[TargetStatsPercentList]       = {
        ["TargetStatsPercent"..i]       = {
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
    if _SVDB.TargetOption[3] then
        Style[TargetStatsIconFrameList]                 = {
            width                                       = 72,
            alpha                                       = 1,
        }
    else
        Style[TargetStatsIconFrameList]                 = {
            width                                       = 1,
            alpha                                       = 0,
        }
    end
-- 初始化部位
    if _SVDB.TargetOption[4] then
        Style[TargetEquipPartFrameList]                 = {
            width                                       = 36,
            alpha                                       = 1,
        }
    else
        Style[TargetEquipPartFrameList]                 = {
            width                                       = 1,
            alpha                                       = 0,
        }
    end
-- 初始化等级
    if _SVDB.TargetOption[5] then
        Style[TargetEquipLevelFrameList]                = {
            width                                       = 36,
            alpha                                       = 1,
        }
    else
        Style[TargetEquipLevelFrameList]                = {
            width                                       = 1,
            alpha                                       = 0,
        }
    end
-- 初始化装备列表的宽度
-- 这里只能设置宽度,因为初始化得时候不知道装备有多少个,不能确定高度
    Style[TargetEquipListFrame]                         = {
        -- 宽度由属性图标\部位\等级\名称四个框架的宽度决定,
        -- 初始化时期名称框体宽度为0
        width                                           = TargetStatsIconFrameList:GetWidth()+TargetEquipPartFrameList:GetWidth()
                                                            +TargetEquipLevelFrameList:GetWidth()+TargetEquipNameFrameList:GetWidth(),
    }
-- 初始化HeaderFrame
    if _SVDB.TargetOption[2] then
        Style[TargetHeaderFrame]                        = {
            height                                      = 30,
            alpha                                       = 1,
        }
        if TargetEquipNameFrameList:GetWidth() > 6 then
            Style[TargetHeaderFrame]                    = {
                width                                   = TargetEquipListFrame:GetWidth(),
            }
        else
            Style[TargetHeaderFrame]                    = {
                width                                   = 250,
            }
        end
    else
        Style[TargetHeaderFrame]                        = {
            height                                      = 1,
            alpha                                       = 0,
        }
    end
-- 初始化宝石框体
    if _SVDB.TargetOption[6] then
        Style[TargetGemInfoFrame]                       = {
            height                                      = 20,
            alpha                                       = 1,
        }
    else
        Style[TargetGemInfoFrame]                       = {
            height                                      = 1,
            alpha                                       = 0,
        }
    end
-- 初始化属性框体
    if _SVDB.TargetOption[7] then
        Style[TargetStatsNumberFrame]                   = {
            height                                      = 80,
        }
        TargetStatsNumberFrame:Show()
    else
        Style[TargetStatsNumberFrame]                   = {
            height                                      = 1,
        }
        TargetStatsNumberFrame:Hide()
    end
    if _SVDB.TargetOption[8] then
        TargetStatsPercentList:Show()
    else
        TargetStatsPercentList:Hide()
    end
-- 初始化主框体
    if _SVDB.TargetOption[1] then
        if TargetEquipNameFrameList:GetWidth() > 6 then
            Style[TargetScanFrame]                      = {
                width                                   = TargetEquipListFrame:GetWidth()+15,
                height                                  = TargetHeaderFrame:GetHeight()+TargetEquipListFrame:GetHeight()
                                                            +TargetGemInfoFrame:GetHeight()+TargetStatsNumberFrame:GetHeight()+7,
            }
        else
            Style[TargetScanFrame]                      = {
                width                                   = 265,
                height                                  = TargetHeaderFrame:GetHeight()+TargetEquipListFrame:GetHeight()
                                                            +TargetGemInfoFrame:GetHeight()+TargetStatsNumberFrame:GetHeight()+7,
            }
        end
        TargetScanFrame:Show()
    else
        Style[TargetScanFrame]                          = {
            width                                       = 0,
            height                                      = 0,
        }
        TargetScanFrame:Hide()
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