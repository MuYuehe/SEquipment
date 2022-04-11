--========================================================--
--                SEquipment UI Menu General              --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio        "BaseConfig.MainInterface.General"         ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                         General                       --
-----------------------------------------------------------

----------------------------
--       UI Assembly      --
----------------------------
class "GeneralAssemblyFrame"    { Frame }
class "GeneralAssemblyComboBox" { ComboBox }
class "GeneralAssemblyTrackBar" { TrackBar }
Style.UpdateSkin("Default",{
    [GeneralAssemblyFrame]          = {
        backdrop={
            bgFile                  = [[Interface\Tooltips\UI-Tooltip-Backgroung]],
            edgeFile                = [[Interface\Tooltips\UI-Tooltip-Border]],
            tile                    = true,
            tileSize                = 0,
            edgeSize                = 15,
            insets                  = {
                                        left    =1,
                                        right   =1,
                                        top     =1,
                                        bottom  =1,
            }
        },
        size                        = Size(150,100),
        backdropcolor               = Color(0,0,0,0),
        backdropbordercolor         = Color(1,1,1,0.3),
    },
    [GeneralAssemblyComboBox]       = {
        size                        = Size(170,30),
        location                    = { Anchor("LEFT",-10,9) },
        label                       = {
            text                    = L["Location"],
            textcolor               = Color(1,0.84,0,1),
            location                = {Anchor("RIGHT",-15,25,nil,"RIGHT")}
        }
    },
    [GeneralAssemblyTrackBar]       = {
        size                        = Size(130,20),
        location                    = { Anchor("BOTTOM",0,25) },

        minMaxValues                = MinMax(1,50),
        valueStep                   = 1,
        obeyStepOnDrag              = true,
    },
})

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
    _SVDB:SetDefault {
        IsLevelShow = {
            true,
            true,
            true,
            true,
            true,
            true,
            true,
        },
        LevelSetPartLocation = {
            2,--self
            2,--target
            2,--bag
            2,--bank
            2,--guild bank
        },
        LevelSetPartSize = {
            15,
            15,
            15,
            15,
            15,
            15,
            15,
        },
        FontStyleSet = 1,
        FrameScaleSet = 15,
    }
end
----------------------------
--     Data Collection    --
----------------------------
local LevelSetPartHeaderText = {
    L["Level Self"],L["Level Target"],L["Level Bag"],
    L["Level Bank"],L["Level GB"],    L["Level Guild"],
    L["Level Chat"]
}
EquipNameLocation = {
    L["TOP"],L["BOTTOM"],L["LEFT"],L["RIGHT"],L["CENTER"],L["TOPLEFT"],
    L["TOPRIGHT"],L["BOTTOMLEFT"],L["BOTTOMRIGHT"],
}
----------------------------
--       UI Hierarchy     --
----------------------------
FontSetFrame                    = SESetMenuFrame("FontSetFrame",GeneralFrame)
    FontSetHeader               = FontString("FontSetHeader",FontSetFrame)
    FontStyleSet                = SEComboBox("FontStyleSet",FontSetFrame)
    FrameScaleSet               = SETrackBar("FrameScaleSet",FontSetFrame)
OnlyFrameBorder                 = SESetMenuFrame("OnlyFrameBorder",GeneralFrame)
LevelSetFrame                   = SEScrollFrame("LevelSetFrame",GeneralFrame)
    LevelSetHeader              = FontString("LevelSetHeader",LevelSetFrame)

-- Style --
Style[FontSetFrame]                 = {
    size=Size(380,70),
    location={Anchor("TOP",0,-25)},
    backdropbordercolor=Color(1,1,1,0.3),
}
Style[FontSetHeader]                = {
    location={Anchor("TOPLEFT",5,15)},
            text=L["Font Set"],
            textcolor=Color(1,1,1,1)
}
Style[FontStyleSet]                 = {
    size                            = Size(200,30),
    location                        = {Anchor("LEFT",0,-10)},
    label                           = {
        text                        = L["Font"],
        textcolor                   = Color(1,0.84,0,1),
        location                    = {Anchor("LEFT",20,25,nil,"LEFT")}
    }
}
Style[FrameScaleSet]                = {
    size                            = Size(150,20),
    location                        = { Anchor("RIGHT",-15,-10) },
    minMaxValues                    = MinMax(0.5,2),
    valueStep                       = .1,
    obeyStepOnDrag                  = true,
    MinText                         = {
        text                        = "",
    },
    MaxText                         = {
        text                        = "",
    },
    label                           = {
        text                        = L["Frame Scale"],
        textcolor                   = Color(1,0.84,0,1),
        location                    = { Anchor("LEFT",0,20,nil,"LEFT") }
    }
}
Style[OnlyFrameBorder]              = {
    size                            = Size(380,200),
    location                        = { Anchor("TOP",0,-115) },
    backdropbordercolor             = Color(1,1,1,0.3),
}
Style[LevelSetFrame]                = {
    size                            = Size(380,190),
    location                        = { Anchor("TOP",0,-120) },
    backdropbordercolor             = Color(1,1,1,0),
}
Style[LevelSetHeader]               = {
    location                        = { Anchor("TOPLEFT",5,20) },
    text                            = L["Level Set"],
    textcolor                       = Color(1,1,1,1)
}
-- Assembly
function OnEnable(self)
    for i = 1, 7 do
        local LevelSetPart            = GeneralAssemblyFrame("LevelSetPart"..i,LevelSetFrame.ScrollChild)
            local LevelSetPartHeader  = FontString("LevelSetPartHeader"..i,LevelSetPart)
            local LevelSetPartShow    = SECheckButton("LevelSetPartShow"..i,LevelSetPart)
            local LevelSetPartLocation= GeneralAssemblyComboBox("LevelSetPartLocation"..i,LevelSetPart)
            local LevelSetPartSize    = GeneralAssemblyTrackBar("LevelSetPartSize"..i,LevelSetPart)
        
        -- Style --
        -- ((-120)*(i//2)-20)(i%2)
            -- 奇数的时候i%2为1,偶数为0
            --[[
                1-0=1-1//2
                3-1=3-3//2
                5-2=5-5//2
                7-3=7-7//2
                -20,-20
                -140,-140
                -260,-260
                2,4,6,8,10
                0,1,2,3,4
                i/2-1
            ]]
            -- ((-120)*(i/2-1))((i+1)%2)
            -- 奇数的时候为0,偶数为1
        local value1 = ((-120)*(math.floor(i/2))-20)*(i%2)
        local value2 = ((-120)*(i/2-1)-20)*((i+1)%2)
        Style[LevelSetFrame].ScrollChild    = {
            ["LevelSetPart"..i]             = {
                size                        = Size(150,100),
                location                    = { Anchor("TOPLEFT",5-155*(i%2-1),value1 + value2)},
            },
        }
        Style[LevelSetPart]                 = {
            ["LevelSetPartHeader"..i]       = {
                location                    = { Anchor("TOPLEFT",5,15) },
                text                        = LevelSetPartHeaderText[i],
                textcolor                   = Color(1,1,1,1)
            },
            ["LevelSetPartShow"..i]         = {
                location                    = { Anchor("TOPLEFT",5) },
                label                       = {
                    text                    = L["Show"],
                    location                = { Anchor("LEFT",30,0) }
                }
            },
        }
        if i>5 then
            Style[LevelSetFrame].ScrollChild= {
                ["LevelSetPart"..i]         = {
                    size                    = Size(150,30),
                    location                = { Anchor("TOPLEFT",160,-260-(i-6)*50)},
                },
            }
            LevelSetPartLocation:Hide()
            LevelSetPartSize:Hide()
        end
        -- Initialization --
        LevelSetPartLocation:ClearItems()
        for index, value in ipairs(EquipNameLocation) do
            LevelSetPartLocation.Items[index] = value
        end

        -- SavedVariables --
        LevelSetPartShow:SetChecked(_SVDB.IsLevelShow[i])
        LevelSetPartLocation.SelectedValue = _SVDB.LevelSetPartLocation[i]
        LevelSetPartSize:SetValue(_SVDB.LevelSetPartSize[i])
        -- CheckButton
        __Async__()
        function LevelSetPartShow:OnClick(button)
            if button == "LeftButton" then
                _SVDB.IsLevelShow[i] = self:GetChecked()
            end
        end
        -- ComboBox
        __Async__()
        function LevelSetPartLocation:OnSelectChanged(value)
            _SVDB.LevelSetPartLocation[i] = self.SelectedValue
        end
        -- TrackBar
        __Async__()
        function LevelSetPartSize:OnValueChanged(value)
            _SVDB.LevelSetPartSize[i] = value
        end
    end

-- Initialization --
    FontStyleSet:ClearItems()
    for index, value in ipairs(SEFontStyle) do
        FontStyleSet.Items[index]=value.text
    end

    -- SavedVariables --
    FontStyleSet.SelectedValue = _SVDB.FontStyleSet
    FrameScaleSet:SetValue(_SVDB.FrameScaleSet)
    __Async__()
    function FontStyleSet:OnSelectChanged(value)
        _SVDB.FontStyleSet = value
        -- 设置字体
    Style.UpdateSkin("Default",{
        [EquipInfoFontString]       = {
            location                = { Anchor("LEFT") },
            font                    = {
                font                = SEFontStyle[_SVDB.FontStyleSet].value,
                height              = 14,
            }
        }
    })
    end
    __Async__()
    function FrameScaleSet:OnValueChanged(value)
        if (PaperDollFrame and PaperDollFrame.ItemListFrame) then
            PaperDollFrame.ItemListFrame:SetScale(value)
        end
        if (InspectPaperDollFrame and InspectPaperDollFrame.ItemListFrame) then
            InspectPaperDollFrame.ItemListFrame:SetScale(value)
        end
        _SVDB.FrameScaleSet = value
    end
end