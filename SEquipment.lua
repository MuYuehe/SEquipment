Scorpio "SEquipment" ""

function OnLoad(self)
    _Addon:SetSavedVariable("SEquipment_DB") -- Bind the saved variable where the config is saved
    :UseConfigPanel()                  -- Enable the auto-gen config panel
end
--- Declare a slash command to open the config panel
__SlashCmd__ "se"
function OnSlashCmdOpen()
	_Addon:ShowConfigUI()
end

__Config__(_Config, RangeValue[{0.5, 2, 0.1}], 1)
function MainScale(scale)
    assert(scale == _Config.MainScale:GetValue())
end
__Config__(_Config, "titleUnitInfo", RangeValue[{10, 20, 1}], 15)
function SetTitleUnitInfo(size)
	assert(size == _Config.titleUnitInfo:GetValue())
end
__Config__(_Config, "levelFontsize", RangeValue[{10, 20, 1}], 15)
function SetLevelFontSize(size)
	assert(size == _Config.levelFontsize:GetValue())
end
__Config__(_Config, "nameFontsize", RangeValue[{10, 20, 1}], 15)
function SetNameFontSize(size)
	assert(size == _Config.nameFontsize:GetValue())
end
__Config__(_Config, "statsIconFontsize", RangeValue[{10, 20, 1}], 15)
function SetStatsIconFontsize(size)
	assert(size == _Config.statsIconFontsize:GetValue())
end
__Config__(_Config, "statsFontsize", RangeValue[{10, 20, 1}], 15)
function SetStatsFontsize(size)
	assert(size == _Config.statsFontsize:GetValue())
end

-- The data type is a member struct with two members, data like `{ x = 1, y = 3 }`
__Config__(_Config, "location", {
	x = Number,
	y = Number,
}, { x = -3, y = 0})
function SetLocation(loc)
	assert(loc == _Config.location:GetValue())
end

__Config__(_Config, true)
function ShowLevel(enabled)
    assert(enabled == _Config.ShowLevel:GetValue())
end

__Config__(_Config, true)
function ShowEquipmentName(enabled)
    assert(enabled == _Config.ShowEquipmentName:GetValue())
end

__Config__(_Config, true)
function ShowEnchantGem(enabled)
    assert(enabled == _Config.ShowEnchantGem:GetValue())
end

__Config__(_Config, true)
function ShowStatsIcon(enabled)
    assert(enabled == _Config.ShowStatsIcon:GetValue())
end

__Config__(_Config, true)
function ShowStatsFrame(enabled)
    assert(enabled == _Config.ShowStatsFrame:GetValue())
end

-- 四个图标的颜色,等级和等级背景, 属性字体颜色
-- The data type is a color
__Config__(_Config, "critIconColor", ColorType, {r = 1, g = 0.5, b = 0.3})
function SetCritColor(color)
	assert(color == _Config.critIconColor:GetValue())
end
__Config__(_Config, "hasteIconColor", ColorType, {r = 0.9, g = 1, b = 0.1})
function SetHasteColor(color)
	assert(color == _Config.hasteIconColor:GetValue())
end
__Config__(_Config, "MasteryIconColor", ColorType, {r = 0.6, g = 0.08, b = 0.75})
function SetMasteryColor(color)
	assert(color == _Config.MasteryIconColor:GetValue())
end
__Config__(_Config, "VersaIconColor", ColorType, {r = 0.1, g = 0.3, b = 1})
function SetVersaColor(color)
	assert(color == _Config.VersaIconColor:GetValue())
end
__Config__(_Config, "levelFontColor", ColorType, { r = 0, g = 0.8, b = 1})
function SetLevelColor(color)
	assert(color == _Config.levelFontColor:GetValue())
end
__Config__(_Config, "levelBackColor", ColorType, { r = 0.06, g = 0.21, b = 0.02})
function SetLevelBackColor(color)
	assert(color == _Config.levelBackColor:GetValue())
end
__Config__(_Config, "statsFontColor", ColorType, { r = 1, g = 0.8, b = 0})
function SetStatsFontColor(color)
	assert(color == _Config.statsFontColor:GetValue())
end
__Config__(_Config, "unitInfoBackColor", ColorType, { r = 0.18, g = 0.15, b = 0.14})
function SetUnitInfoBackColor(color)
	assert(color == _Config.unitInfoBackColor:GetValue())
end
__Config__(_Config, "unitInfoBorderColor", ColorType, { r = 0.3, g = 0.3, b = 0.3})
function SetUnitInfoBorderColor(color)
	assert(color == _Config.unitInfoBorderColor:GetValue())
end