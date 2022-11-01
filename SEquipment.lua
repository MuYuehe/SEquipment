--========================================================--
--                     SEQUIPMENT                         --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/04/19                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.SEquipment" ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                     SavedVariables                    --
-----------------------------------------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
    _SVDB:SetDefault {
        IsLevelShow = {
            true, true, true, true, true, true, true,
        },
        LevelSetPartLocation = {
            2, --self
            2, --target
            2, --bag
            2, --bank
            2, --guild bank
        },
        LevelSetPartSize = {
            15, --self
            15, --target
            15, --bag
            15, --bank
            15, --guild bank
        },
        SettingOption = {
            true, true, true, true, true, true, true,
        },
        FontStyleSet = 1,
        FrameScaleSet = 1,
    }
    Clamp(_SVDB.FrameScaleSet, 0.5, 2)
    for _, value in ipairs(_SVDB.LevelSetPartSize) do
        Clamp(value, 10, 20)
    end
    for _, value in ipairs(_SVDB.LevelSetPartLocation) do
        Clamp(value, 1, 2)
    end
end

-----------------------------------------------------------
--                         UIMenu                        --
-----------------------------------------------------------

class "UIMenu" (function(_ENV)
    inherit "Dialog"

    __Bubbling__ { TreeView = "OnNodeClick" }
    event "OnNodeClick"

    function AddTreeNode(self, value)
        self:GetChild("TreeView"):AddTreeNode(value)
    end

    local function UIMenu_Hide(self)
        self:GetParent():Hide()
    end

    __Template__ {
        TreeView = TreeView,
        ExitButton = UIPanelButton,
        Info = SEFontString,
    }
    function __ctor(self)
        self:GetChild("ExitButton").OnClick = UIMenu_Hide
    end
end)

class "HomePage" (function(_ENV)
    inherit "Frame"

    __Template__ {
        BorderFrame = Frame,
        ScrollFrame = FauxScrollFrame,
        Info = FontString,
        Border = Frame,
        {
            ScrollFrame = {
                {
                    ScrollChild = {
                        Info = FontString,
                    },
                },
            },
        },
    }
    function __ctor(self)

    end
end)

class "GeneralPage" (function(_ENV)
    inherit "Frame"

    event "OnValueChanged"

    function Set_Select_Value(self, idx, val)
        local child = self:GetChild("FirstFrame"):GetChild("combobox")
        child.Items[idx] = val
    end

    function Set_ScondFrame_Value(self, value)
        value:SetParent(self:GetChild("SecondFrame").ScrollChild)
    end

    local function SEMainUIect_OnClick(self, ...)
        return OnValueChanged(self:GetParent():GetParent(), self, ...)
    end

    __Template__ {
        FirstFrame = Frame,
        SecondFrame = FauxScrollFrame,
        SecondBorder = Frame,
        {
            FirstFrame = {
                Info = FontString,
                combobox = ComboBox,
                trackbar = TrackBar,
            },
            SecondFrame = {
                Info = FontString,
            }
        }
    }
    function __ctor(self)
        self:GetChild("FirstFrame"):GetChild("combobox"):ClearItems()
        self:GetChild("FirstFrame"):GetChild("combobox").OnSelectChanged = SEMainUIect_OnClick
        self:GetChild("FirstFrame"):GetChild("trackbar").OnValueChanged = SEMainUIect_OnClick
    end
end)

class "LevelWidget" (function(_ENV)
    inherit "Frame"

    event "OnValueChanged"

    function Set_Info(self, text)
        local child = self:GetChild("Info")
        child:SetText(text)
    end

    function Set_ComboBox(self, idx, val)
        local child = self:GetChild("combobox")
        child.Items[idx] = val
    end

    local function checkbutton_OnClick(self, value)
        if self:GetName() == "checkbutton" then
            value = self:GetChecked()
        end
        return OnValueChanged(self:GetParent(), value, self)
    end

    __Template__ {
        Info = FontString,
        checkbutton = UICheckButton,
        combobox = ComboBox,
        trackbar = TrackBar,
    }
    function __ctor(self)
        self:GetChild("checkbutton").OnClick = checkbutton_OnClick
        self:GetChild("combobox").OnSelectChanged = checkbutton_OnClick
        self:GetChild("trackbar").OnValueChanged = checkbutton_OnClick
        self:GetChild("combobox"):ClearItems()
    end
end)

class "PlayerPage" (function(_ENV)
    inherit "Frame"

    __Template__ {}
    function __ctor(self) end
end)

class "CheckButton_Widget" (function(_ENV)
    inherit "UICheckButton"
end)

-- 创建元素
SEMainUI     = UIMenu("SEMainUI")
SEMainUI:Hide()
HomeFrame    = HomePage("HomePage", SEMainUI)
GeneralFrame = GeneralPage("GeneralFrame", SEMainUI)
PlayerFrame  = PlayerPage("PlayerFrame", SEMainUI)
GeneralFrame:Hide()
PlayerFrame:Hide()
-- 添加菜单
SEMainUI:AddTreeNode(L["Home"])
SEMainUI:AddTreeNode(L["General"])
SEMainUI:AddTreeNode(L["Player"])
-- 菜单按钮功能
function SEMainUI:OnNodeClick(value)
    HomeFrame:Hide()
    GeneralFrame:Hide()
    PlayerFrame:Hide()
    if value == L["Home"] then HomeFrame:Show()
    elseif value == L["General"] then GeneralFrame:Show()
    elseif value == L["Player"] then PlayerFrame:Show() end
end

-- 设定字体样式,跟界面尺寸大小
function GeneralFrame:OnValueChanged(meta, val)
    if meta:GetName() == "combobox" then
        _SVDB.FontStyleSet = val
        Style.UpdateSkin("Default", {
            [SEFontString] = {
                font = {
                    font   = SEFontStyle[val].value,
                    height = 14,
                }
            },
            [SGFontString] = {
                font = {
                    font   = SEFontStyle[val].value,
                    height = 12,
                }
            }
        })
    else
        _SVDB.FrameScaleSet = val
        if (PaperDollFrame and PaperDollFrame.ItemListFrame) then
            PaperDollFrame.ItemListFrame:SetScale(val)
        end
        if (InspectPaperDollFrame and InspectPaperDollFrame.ItemListFrame) then
            InspectPaperDollFrame.ItemListFrame:SetScale(val)
        end
    end
end

-- 添加选项
for index, value in ipairs(SEFontStyle) do
    GeneralFrame:Set_Select_Value(index, value.text)
end

-- 添加子元素
for index, value in ipairs(LevelSetPartHeaderText) do
    local widget = LevelWidget("widget" .. index)
    local value1 = ((-120) * (math.floor(index / 2)) - 20) * (index % 2)
    local value2 = ((-120) * (index / 2 - 1) - 20) * ((index + 1) % 2)
    widget:Set_Info(value)
    GeneralFrame:Set_ScondFrame_Value(widget)
    Style[widget].location = { Anchor("TOPLEFT", 5 - 155 * (index % 2 - 1), value1 + value2) }
    -- 制定工会与聊天等级显示样式
    if index > 5 then
        Style[widget].size = Size(150, 30)
        Style[widget].location = { Anchor("TOPLEFT", 160, -260 - (index - 6) * 50) }
        widget:GetChild("combobox"):Hide()
        widget:GetChild("trackbar"):Hide()
    end
    for k, v in ipairs(EquipInfoLocation) do
        widget:Set_ComboBox(k, v)
    end
    function widget:OnValueChanged(val, meta)
        if type(val) == "boolean" then
            _SVDB.IsLevelShow[index] = val
        elseif meta:GetName() == "combobox" then
            _SVDB.LevelSetPartLocation[index] = val
        else
            _SVDB.LevelSetPartSize[index] = val
        end
    end
end
-- 添加子元素
for index, value in ipairs(Options) do
    local checkbutton = CheckButton_Widget("checkbutton" .. index, PlayerFrame)
    checkbutton:SetPoint("TOPLEFT", 5, -10 - 25 * (index - 1))
    Style[checkbutton].label = { text = value, location = { Anchor("LEFT", 30, 0) } }
    function checkbutton:OnClick()
        _SVDB.SettingOption[index] = self:GetChecked()
    end
end
-- Load SavedVariables
SEMainUI:SetScript("OnShow",function (self)
    local child                         = GeneralFrame:GetChild("FirstFrame")
    Style[child].combobox.SelectedValue = _SVDB.FontStyleSet
    Style[child].trackbar.value         = _SVDB.FrameScaleSet
    for index, _ in ipairs(LevelSetPartHeaderText) do
              child                         = GeneralFrame:GetChild("SecondFrame").ScrollChild:GetChild("widget" .. index)
        Style[child].checkbutton.checked    = _SVDB.IsLevelShow[index]
        Style[child].combobox.SelectedValue = _SVDB.LevelSetPartLocation[index]
        Style[child].trackbar.value         = _SVDB.LevelSetPartSize[index]
    end
    for index, _ in ipairs(Options) do
        child = PlayerFrame:GetChild("checkbutton" .. index)
        Style[child].checked = _SVDB.SettingOption[index]
    end
end)

-- /CMD
__SlashCmd__ "SE"
function enableModule()
    SEMainUI:Show()
end

-----------------------------------------------------------
--                       EquipList                       --
-----------------------------------------------------------

class "MainFrame" (function(_ENV)
    inherit "Frame"
    -- method
    -- 刷新Oy,跟各个子元素的定位
    function Refresh(self)
        local TopFrame_Height       = 32
        local EquipListFrame_Height = 288
        local GemSuitFrame_Height   = 20
        local BottomFrame_Height    = 80
        if not _SVDB.SettingOption[2] then TopFrame_Height = 0      end
        if not _SVDB.SettingOption[6] then GemSuitFrame_Height = 0  end
        if not _SVDB.SettingOption[7] then BottomFrame_Height = 0   end

        Style[self].height = TopFrame_Height + EquipListFrame_Height + GemSuitFrame_Height + BottomFrame_Height + 5
        Style[self:GetChild("TopFrame")].height         = TopFrame_Height
        Style[self:GetChild("GemSuitFrame")].height     = GemSuitFrame_Height
        Style[self:GetChild("BottomFrame")].height      = BottomFrame_Height

        Style[self:GetChild("EquipListFrame")].location = { Anchor("TOPLEFT", 5, 0 - TopFrame_Height) }
        Style[self:GetChild("GemSuitFrame")].location   = { Anchor("TOPLEFT", 5, 0 - TopFrame_Height - EquipListFrame_Height) }
        Style[self:GetChild("BottomFrame")].location    = { Anchor("TOPLEFT", 5, 0 - TopFrame_Height - EquipListFrame_Height - GemSuitFrame_Height) }
    end
    -- 刷新Ox,各个子元素的宽度
    function Refresh_Ox(self, val)
        Style[self].width = val + 10
        Style[self:GetChild("TopFrame")].width = val
    end
    -- 设定平均装等
    function Set_AvgLevel_Info(self, val)
        Style[self:GetChild("TopFrame"):GetChild("Left_Info")].text = val
    end
    -- 设定天赋
    function Set_Spec_Info(self, val)
        Style[self:GetChild("TopFrame"):GetChild("Right_Info")].text = val
    end
    -- 设定宝石信息
    function Set_Gem_Info(self, val1,val2)
        if val1 + val2 == 0 then
            Style[self:GetChild("GemSuitFrame"):GetChild("Left_Info")].text = ""
            Style[self:GetChild("GemSuitFrame"):GetChild("Right_Info")].location = { Anchor("LEFT") }
        else
            Style[self:GetChild("GemSuitFrame"):GetChild("Left_Info")].text = L["Gem"] .. ":" .. val1 .. "/" .. val1 + val2
            Style[self:GetChild("GemSuitFrame"):GetChild("Right_Info")].location = { Anchor("LEFT", 80, 0) }
        end
    end
    -- 设定套装信息
    function Set_Suit_Info(self, val)
        Style[self:GetChild("GemSuitFrame"):GetChild("Right_Info")].text = val
    end
    -- 设定装备面板子元素
    function Set_EquipList_Child(self, val,idx)
        val:SetParent(self:GetChild("EquipListFrame"))
        Style[val].location = { Anchor("TOPLEFT", 0, (-18) * (idx - 1)) }
    end
    -- 设定属性数值
    function Set_Stat_Number(self,val)
        Style[self:GetChild("BottomFrame"):GetChild("Crit"):GetChild("Number")].text    = tostring(val[1])
        Style[self:GetChild("BottomFrame"):GetChild("Haste"):GetChild("Number")].text   = tostring(val[2])
        Style[self:GetChild("BottomFrame"):GetChild("Mastery"):GetChild("Number")].text = tostring(val[3])
        Style[self:GetChild("BottomFrame"):GetChild("Versa"):GetChild("Number")].text   = tostring(val[4])
    end
    -- 设定属性百分比
    function Set_Stat_Percent(self, val)
        Style[self:GetChild("BottomFrame"):GetChild("Crit"):GetChild("Percent")].text   = tostring(val[1])
        Style[self:GetChild("BottomFrame"):GetChild("Haste"):GetChild("Percent")].text  = tostring(val[2])
        Style[self:GetChild("BottomFrame"):GetChild("Mastery"):GetChild("Percent")].text= tostring(val[3])
        Style[self:GetChild("BottomFrame"):GetChild("Versa"):GetChild("Percent")].text  = tostring(val[4])
    end

    __Template__ {
        TopFrame                    = Frame,
        EquipListFrame              = Frame,
        GemSuitFrame                = Frame,
        BottomFrame                 = Frame,
        {
            TopFrame                = {
                Left_Info           = SEFontString,
                Right_Info          = SEFontString,
            },
            GemSuitFrame            = {
                Left_Info           = SEFontString,
                Right_Info          = SGFontString,
            },
            BottomFrame             = {
                Crit                = Frame,
                Haste               = Frame,
                Mastery             = Frame,
                Versa               = Frame,
                {
                    Crit            = {
                        Title       = SEFontString,
                        Number      = SEFontString,
                        Percent     = SEFontString,
                    },
                    Haste           = {
                        Title       = SEFontString,
                        Number      = SEFontString,
                        Percent     = SEFontString,
                    },
                    Mastery         = {
                        Title       = SEFontString,
                        Number      = SEFontString,
                        Percent     = SEFontString,
                    },
                    Versa           = {
                        Title       = SEFontString,
                        Number      = SEFontString,
                        Percent     = SEFontString,
                    },
                }
            }
        }
    }
    function __ctor(self) end
end)

class "Per_Equip" (function(_ENV)
    inherit "Frame"

    -- 刷新Ox,设定宽度,以及子元素定位
    function Refresh(self)
        local NameFrame_Width   = self.width
        local GemEnFrame_Width  = self.Gwidth
        local IconFrame_Width   = 72
        local PartFrame_Width   = 36
        local LevelFrame_Width  = 36
        if not _SVDB.SettingOption[3] then IconFrame_Width = 0 self:GetChild("IconFrame"):Hide() else self:GetChild("IconFrame"):Show() end
        if not _SVDB.SettingOption[4] then PartFrame_Width = 0 self:GetChild("PartFrame"):Hide() end
        if not _SVDB.SettingOption[5] then LevelFrame_Width = 0 end

        Style[self].width                           = IconFrame_Width + PartFrame_Width + LevelFrame_Width + NameFrame_Width + GemEnFrame_Width
        self.WholeWidth                             = IconFrame_Width + PartFrame_Width + LevelFrame_Width + NameFrame_Width + GemEnFrame_Width
        Style[self:GetChild("IconFrame")].width     = IconFrame_Width + GemEnFrame_Width
        Style[self:GetChild("PartFrame")].width     = PartFrame_Width
        Style[self:GetChild("LevelFrame")].width    = LevelFrame_Width

        Style[self:GetChild("PartFrame")].location  = { Anchor("LEFT", IconFrame_Width, 0) }
        Style[self:GetChild("LevelFrame")].location = { Anchor("LEFT", IconFrame_Width + PartFrame_Width, 0) }
        Style[self:GetChild("NameFrame")].location  = { Anchor("LEFT", IconFrame_Width + PartFrame_Width + LevelFrame_Width, 0) }
        Style[self:GetChild("GemEnFrame")].location = { Anchor("LEFT", IconFrame_Width + PartFrame_Width + LevelFrame_Width + NameFrame_Width, 0) }
    end
    -- 设定图标显示
    function Set_Icon_Show_Hide(self,val)
        if val[1] == 0 then
            self:GetChild("IconFrame"):GetChild("Crit"):Hide()
        else
            self:GetChild("IconFrame"):GetChild("Crit"):Show()
        end
        if val[2] == 0 then
            self:GetChild("IconFrame"):GetChild("Haste"):Hide()
        else
            self:GetChild("IconFrame"):GetChild("Haste"):Show()
        end
        if val[3] == 0 then
            self:GetChild("IconFrame"):GetChild("Mastery"):Hide()
        else
            self:GetChild("IconFrame"):GetChild("Mastery"):Show()
        end
        if val[4] == 0 then
            self:GetChild("IconFrame"):GetChild("Versa"):Hide()
        else
            self:GetChild("IconFrame"):GetChild("Versa"):Show()
        end
    end
    -- 设定部位名称
    function Set_Part_Info(self, val)
        if val == "" then
            self:GetChild("PartFrame"):Hide()
        else
            self:GetChild("PartFrame"):Show()
        end
        Style[self:GetChild("PartFrame"):GetChild("TextureFrame"):GetChild("Info")].text = val
    end
    -- 设定等级
    function Set_Level_Info(self, val)
        Style[self:GetChild("LevelFrame"):GetChild("Info")].text = val
    end
    -- 设定装备名称
    function Set_Name_Info(self, val)
        Style[self:GetChild("NameFrame"):GetChild("Info")].text = val
        Style[self:GetChild("NameFrame")].width = self.width
    end
    -- 设定宝石附魔图标
    function Set_Gem_En_Icon(self,val)
        local child         = self:GetChild("GemEnFrame")
        local Enchant_Width = 12
        local Gem1_Width    = 12
        local Gem2_Width    = 12
        local Gem3_Width    = 12
        local Gem4_Width    = 12
        local Empty_Width   = 12
        if val[1] ~= "" then
            Style[child:GetChild("Enchant"):GetChild("texture")].File = GetItemIcon(128537)
            child:GetChild("Enchant"):Show()
            child:GetChild("Enchant").Glink = val[1]
        else
            Enchant_Width = 0
            child:GetChild("Enchant"):Hide()
        end
        if val[2] ~= 0 then
            Style[child:GetChild("Gem1"):GetChild("texture")].File = GetItemIcon(val[2])
            child:GetChild("Gem1"):Show()
            child:GetChild("Gem1").Glink = val[2]
        else
            Gem1_Width = 0
            child:GetChild("Gem1"):Hide()
        end
        if val[3] ~= 0 then
            Style[child:GetChild("Gem2"):GetChild("texture")].File = GetItemIcon(val[3])
            child:GetChild("Gem2"):Show()
            child:GetChild("Gem2").Glink = val[3]
        else
            Gem2_Width = 0
            child:GetChild("Gem2"):Hide()
        end
        if val[4] ~= 0 then
            Style[child:GetChild("Gem3"):GetChild("texture")].File = GetItemIcon(val[4])
            child:GetChild("Gem3"):Show()
            child:GetChild("Gem3").Glink = val[4]
        else
            Gem3_Width = 0
            child:GetChild("Gem3"):Hide()
        end
        if val[5] ~= 0 then
            Style[child:GetChild("Gem4"):GetChild("texture")].File = GetItemIcon(val[5])
            child:GetChild("Gem4"):Show()
            child:GetChild("Gem4").Glink = val[5]
        else
            Gem4_Width = 0
            child:GetChild("Gem4"):Hide()
        end
        if val[6] ~= 0 then
            Style[child:GetChild("Empty"):GetChild("texture")].File = [[Interface\Cursor\Quest]]
            child:GetChild("Empty"):Show()
            child:GetChild("Empty").Glink = L["Empty GemSlot"]
        else
            Empty_Width = 0
            child:GetChild("Empty"):Hide()
        end
        Style[child].width                      = Enchant_Width + Gem1_Width + Gem2_Width + Gem3_Width + Gem4_Width + Empty_Width
        Style[child:GetChild("Enchant")].width  = Enchant_Width
        Style[child:GetChild("Gem1")].width     = Gem1_Width
        Style[child:GetChild("Gem2")].width     = Gem2_Width
        Style[child:GetChild("Gem3")].width     = Gem3_Width
        Style[child:GetChild("Gem4")].width     = Gem4_Width
        Style[child:GetChild("Empty")].width    = Empty_Width

        Style[child:GetChild("Gem1")].location  = { Anchor("LEFT", Enchant_Width + 4, 0) }
        Style[child:GetChild("Gem2")].location  = { Anchor("LEFT", Enchant_Width + Gem1_Width + 4, 0) }
        Style[child:GetChild("Gem3")].location  = { Anchor("LEFT", Enchant_Width + Gem1_Width + Gem2_Width + 4, 0) }
        Style[child:GetChild("Gem4")].location  = { Anchor("LEFT", Enchant_Width + Gem1_Width + Gem2_Width + Gem3_Width + 4, 0) }
        Style[child:GetChild("Empty")].location = { Anchor("LEFT", Enchant_Width + Gem1_Width + Gem2_Width + Gem3_Width + Gem4_Width + 4, 0) }
    end
    -- 设定鼠标提示
    local function Set_Tooltip_Show(self)
        if self:GetParent().link then
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetInventoryItem(self:GetParent().unit, self:GetParent().index)
            GameTooltip:Show()
        end
    end
    local function Set_Tooltip_GemEn_Show(self)
        if self.Glink then
            local isHover = string.match(self.Glink, ENCHANTS)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            if isHover or self.Glink == L["Empty GemSlot"] then
                GameTooltip:SetText(self.Glink)
            else
                GameTooltip:SetHyperlink(select(2, GetItemInfo(self.Glink)))
            end
            GameTooltip:Show()
        end
    end
    local function Set_Tooltip_Hide(self)
        GameTooltip:Hide()
    end

    __Template__ {
        IconFrame               = Frame,
        PartFrame               = Frame,
        LevelFrame              = Frame,
        NameFrame               = Frame,
        GemEnFrame              = Frame,
        {
            IconFrame           = {
                Crit            = Frame,
                Haste           = Frame,
                Mastery         = Frame,
                Versa           = Frame,
                {
                    Crit        = {
                        texture = Texture,
                        Info    = SEFontString,
                    },
                    Haste       = {
                        texture = Texture,
                        Info    = SEFontString,
                    },
                    Mastery     = {
                        texture = Texture,
                        Info    = SEFontString,
                    },
                    Versa       = {
                        texture = Texture,
                        Info    = SEFontString,
                    },
                }
            },
            PartFrame           = {
                TextureFrame    = Frame,
                {
                    TextureFrame= {
                        Info    = SEFontString,
                    }
                }
            },
            LevelFrame          = {
                Info            = SEFontString,
            },
            NameFrame           = {
                Info            = SEFontString,
            },
            GemEnFrame          = {
                Enchant         = Frame,
                Gem1            = Frame,
                Gem2            = Frame,
                Gem3            = Frame,
                Gem4            = Frame,
                Empty           = Frame,
                {
                    Enchant     = {
                        texture = Texture,
                    },
                    Gem1        = {
                        texture = Texture,
                    },
                    Gem2        = {
                        texture = Texture,
                    },
                    Gem3        = {
                        texture = Texture,
                    },
                    Gem4        = {
                        texture = Texture,
                    },
                    Empty       = {
                        texture = Texture,
                    }
                }
            }
        }
    }
    function __ctor(self)
        self:GetChild("NameFrame").OnEnter          = Set_Tooltip_Show
        self:GetChild("NameFrame").OnLeave          = Set_Tooltip_Hide
        self:GetChild("GemEnFrame"):GetChild("Enchant").OnEnter = Set_Tooltip_GemEn_Show
        self:GetChild("GemEnFrame"):GetChild("Gem1").OnEnter    = Set_Tooltip_GemEn_Show
        self:GetChild("GemEnFrame"):GetChild("Gem2").OnEnter    = Set_Tooltip_GemEn_Show
        self:GetChild("GemEnFrame"):GetChild("Gem3").OnEnter    = Set_Tooltip_GemEn_Show
        self:GetChild("GemEnFrame"):GetChild("Gem4").OnEnter    = Set_Tooltip_GemEn_Show
        self:GetChild("GemEnFrame"):GetChild("Empty").OnEnter   = Set_Tooltip_GemEn_Show
        self:GetChild("GemEnFrame"):GetChild("Enchant").OnLeave = Set_Tooltip_Hide
        self:GetChild("GemEnFrame"):GetChild("Gem1").OnLeave    = Set_Tooltip_Hide
        self:GetChild("GemEnFrame"):GetChild("Gem2").OnLeave    = Set_Tooltip_Hide
        self:GetChild("GemEnFrame"):GetChild("Gem3").OnLeave    = Set_Tooltip_Hide
        self:GetChild("GemEnFrame"):GetChild("Gem4").OnLeave    = Set_Tooltip_Hide
        self:GetChild("GemEnFrame"):GetChild("Empty").OnLeave   = Set_Tooltip_Hide
    end
end)

local function Create_Item_List_Frame(parent)
    if not parent.ItemListFrame then
        local Main_Frame = MainFrame("Main_Frame",parent)
        Main_Frame:SetScale(_SVDB.FrameScaleSet) --初始化尺寸比例
        for k, v in ipairs(SlotButton) do
            local Per_Equip_Frame = Per_Equip("Per_Equip_Frame"..k)
            Main_Frame:Set_EquipList_Child(Per_Equip_Frame,k)
            Main_Frame["Equip" .. k] = Per_Equip_Frame
        end
        Style[Main_Frame].location = { Anchor("TOPLEFT", 0, 0, parent:GetName(), "TOPRIGHT") }
        parent:HookScript("OnHide", function(self) Main_Frame:Hide() end)
        parent.ItemListFrame = Main_Frame
        
    end
    FireSystemEvent("MAIN_FRAME_CREATED", parent.ItemListFrame)
    return parent.ItemListFrame
end

function Show_Item_List_Frame(unit,parent)
    if not parent:IsVisible() then return end
    local Main_Frame = Create_Item_List_Frame(parent)
    -- 获取天赋,天赋id,天赋图标id
    local specname, specid, specIconid = Get_Spec_Info(unit)
    -- 设定总属性
    local Sum_Crit, Sum_Haste, Sum_Mastery, Sum_Versa = 0, 0, 0, 0
    -- 设定总空宝石槽,总镶嵌宝石
    local Sum_Empty_Gem, Sum_Exist_Gem = 0, 0
    -- 设定套装集合
    local ItemSetIdTable = {}
    for k, v in ipairs(SlotButton) do
        -- 获取装备槽链接
        local link = GetInventoryItemLink(unit, v.index)
        -- 获取物品名称,品质,类型,部位
        local name, quality, itemType, equipLoc = Get_Item_Info(link)
        -- 设定品质颜色
        local SET_ITEM_QUALITY_COLOR
        -- 获取装备等级,属性值,空宝石,附魔,是否pvp装备,套装id|打包属性值
        local ItemLevel, CritNumber, HasteNumber, MasteryNumber, VersaNumber, EmptyGemNumber, EnchantInfo, isPVPSet, ItemSetId = GetEachEquipInfo(link)
        local CHMV = { CritNumber, HasteNumber, MasteryNumber, VersaNumber }
        -- 获取附魔,宝石,信息,以及存在的宝石数|将宝石打包
        local Gem1, Gem2, Gem3, Gem4, ExistGemNumber = Get_Equiped_Info(link)
        local GemTable = { EnchantInfo, Gem1, Gem2, Gem3, Gem4, EmptyGemNumber }
        -- 套装不为空放入套装集合中
        if ItemSetId ~= "" then table.insert(ItemSetIdTable, GetItemSetInfo(ItemSetId)) end
        -- 等级为0,设定为空
        if ItemLevel == 0 then ItemLevel = "" end
        -- 获取品质颜色
        if ITEM_QUALITY_COLORS[quality] and ItemSetId == "" then
            -- 非套装
            SET_ITEM_QUALITY_COLOR = ITEM_QUALITY_COLORS[quality].hex
        elseif ItemSetId ~= "" and isPVPSet then
            -- PVP套装
            SET_ITEM_QUALITY_COLOR = "|cffd5504d"
        elseif ItemSetId ~= "" and (not isPVPSet) then
            -- 非PVP套装
            SET_ITEM_QUALITY_COLOR = "|cff2bae85"
        else
            -- 没拿到装备信息
            SET_ITEM_QUALITY_COLOR = ""
        end
        -- 计算属性总值
        Sum_Crit        = Sum_Crit      + CritNumber
        Sum_Haste       = Sum_Haste     + HasteNumber
        Sum_Mastery     = Sum_Mastery   + MasteryNumber
        Sum_Versa       = Sum_Versa     + VersaNumber
        Sum_Empty_Gem   = Sum_Empty_Gem + EmptyGemNumber
        Sum_Exist_Gem   = Sum_Exist_Gem + ExistGemNumber
        
        -- 填充值
        local Per_Equip_Frame   = Main_Frame["Equip" .. k]
        Per_Equip_Frame.unit    = unit
        Per_Equip_Frame.index   = v.index
        Per_Equip_Frame.link    = link
        Per_Equip_Frame.width   = Get_FontString_Width(name)
        Per_Equip_Frame.Gwidth  = Get_Useful_Info(GemTable) * 16
        Per_Equip_Frame:Set_Icon_Show_Hide(CHMV)
        Per_Equip_Frame:Set_Part_Info(equipLoc)
        Per_Equip_Frame:Set_Level_Info(tostring(ItemLevel))
        Per_Equip_Frame:Set_Name_Info(SET_ITEM_QUALITY_COLOR .. name)
        Per_Equip_Frame:Set_Gem_En_Icon(GemTable)
        Per_Equip_Frame:Refresh()
    end
    -- 获取总属性值集合
    local SUM_CHMV = { Sum_Crit, Sum_Haste, Sum_Mastery, Sum_Versa }
    -- local SUM_CHMV_PERCENT = { GetStatsPercent(Sum_Crit, 1, unit, specid), GetStatsPercent(Sum_Haste, 2, unit, specid), GetStatsPercent(Sum_Mastery, 3, unit, specid), GetStatsPercent(Sum_Versa, 4, unit, specid)}
    -- 显示天赋,平均装等信息
    Main_Frame:Set_Spec_Info(specname)
    if unit == "player" then
        hooksecurefunc("PaperDollFrame_SetItemLevel", function(statFrame, ...) Main_Frame:Set_AvgLevel_Info(statFrame.tooltip) end)
    else
        Main_Frame:Set_AvgLevel_Info(Get_Inspect_Item_Level(unit))
    end
    -- 显示宝石,套装信息
    Main_Frame:Set_Gem_Info(Sum_Exist_Gem, Sum_Empty_Gem)
    Main_Frame:Set_Suit_Info(table.concat(Get_Same_Mate(ItemSetIdTable)))
    Main_Frame:Set_Stat_Number(SUM_CHMV)
    -- Main_Frame:Set_Stat_Percent(SUM_CHMV_PERCENT)
    FireSystemEvent("MAIN_FRAME_COMPLETED",Main_Frame)

    return Main_Frame
end

__SystemEvent__ "MAIN_FRAME_CREATED"
function Style_Change(frame)
    frame:Refresh()
end
__SystemEvent__ "MAIN_FRAME_COMPLETED"
function Style_Change_(frame)
    local Max_StringWidth = {}
    for k, v in ipairs(SlotButton) do
        local Per_Equip_Frame = frame["Equip" .. k]
        Max_StringWidth[k] = tonumber(Per_Equip_Frame.WholeWidth)
    end
    frame:Refresh_Ox(Get_Max_String_Width(Max_StringWidth))
    if not _SVDB.SettingOption[1] then frame:Hide() else frame:Show() end
end
-- Player Show
__SecureHook__()
function PaperDollItemSlotButton_OnShow(self)
    NUM_RESET = NUM_RESET + 1
    if NUM_RESET == 18 then
        FireSystemEvent("PAPERDOLL_BUTTON_READY",PaperDollFrame)
    end
end
__SecureHook__()
function PaperDollItemSlotButton_OnHide(self)
    NUM_RESET = 0
end
__SystemEvent__()
function PAPERDOLL_BUTTON_READY(frame)
    Show_Item_List_Frame("player", frame)
end
__SystemEvent__()
function PLAYER_EQUIPMENT_CHANGED()
    if PaperDollFrame and PaperDollFrame:IsShown() then
        Show_Item_List_Frame("player", PaperDollFrame)
    end
end

-- Target Show
__Async__()
function OnEnable()
    while Wait("INSPECT_READY") do
        Next()
        FireSystemEvent("INSPECT_READY_COMPLETED")
    end
    while Wait("UNIT_INVENTORY_CHANGED") do
        Next()
        FireSystemEvent("UNIT_INVENTORY_CHANGED_COMPLETED")
    end
end
__SystemEvent__ "INSPECT_READY_COMPLETED" "UNIT_INVENTORY_CHANGED_COMPLETED"
function INSPECT_EQUIP_SHOW()
    if InspectFrame and InspectFrame.unit then
        local frame = Show_Item_List_Frame(InspectFrame.unit, InspectPaperDollFrame)
    end
end