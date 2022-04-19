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
            true,
            true,
            true,
            true,
            true,
            true,
            true,
        },
        LevelSetPartLocation = {
            2, --self
            2, --target
            2, --bag
            2, --bank
            2, --guild bank
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
        SettingOption = {
            true,
            true,
            true,
            true,
            true,
            true,
            true,
        },
        FontStyleSet = 1,
        FrameScaleSet = 1,
    }
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
        Info = FontString,
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
    -- print(meta:GetName(),val)
    if meta:GetName() == "combobox" then
        _SVDB.FontStyleSet = val
        Style.UpdateSkin("Default", {
            [EquipInfoFontString] = {
                location = { Anchor("LEFT") },
                font     = {
                    font   = SEFontStyle[val].value,
                    height = 14,
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
    widget:SetPoint("TOPLEFT", 5 - 155 * (index % 2 - 1), value1 + value2)
    for k, v in ipairs(EquipNameLocation) do
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
function OnEnable(self)
    local child = GeneralFrame:GetChild("FirstFrame")
    Style[child].combobox.SelectedValue = _SVDB.FontStyleSet
    Style[child].trackbar.value         = _SVDB.FrameScaleSet
    for index, _ in ipairs(LevelSetPartHeaderText) do
        child = GeneralFrame:GetChild("SecondFrame").ScrollChild:GetChild("widget" .. index)
        Style[child].checkbutton.checked    = _SVDB.IsLevelShow[index]
        Style[child].combobox.SelectedValue = _SVDB.LevelSetPartLocation[index]
        Style[child].trackbar.value         = _SVDB.LevelSetPartSize[index]
    end
    for index, _ in ipairs(Options) do
        child = PlayerFrame:GetChild("checkbutton" .. index)
        Style[child].checked = _SVDB.SettingOption[index]
    end
end

-- /CMD
__SlashCmd__ "SE"
function enableModule()
    SEMainUI:Show()
end