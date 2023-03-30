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
__Config__(_Config, "titleunitinfo", RangeValue[{10, 20, 1}], 15)
function SetTitleUnitInfo(size)
	assert(size == _Config.titleunitinfo:GetValue())
end
__Config__(_Config, "levelfontsize", RangeValue[{10, 20, 1}], 15)
function SetLevelFontSize(size)
	assert(size == _Config.levelfontsize:GetValue())
end
__Config__(_Config, "namefontsize", RangeValue[{10, 20, 1}], 15)
function SetNameFontSize(size)
	assert(size == _Config.namefontsize:GetValue())
end
__Config__(_Config, "statsiconfontsize", RangeValue[{10, 20, 1}], 15)
function SetStatsIconFontsize(size)
	assert(size == _Config.statsiconfontsize:GetValue())
end
__Config__(_Config, "statsfontsize", RangeValue[{10, 20, 1}], 15)
function SetStatsFontsize(size)
	assert(size == _Config.statsfontsize:GetValue())
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

__Config__(_Config, "showpaperdoll", true)
function ShowPaperDoll(enabled)
    assert(enabled == _Config.showpaperdoll:GetValue())
end

__Config__(_Config, "showbag", true)
function ShowBag(enabled)
    assert(enabled == _Config.showbag:GetValue())
end

__Config__(_Config, "showtooltiplevel", true)
function ShowTooltipLevel(enabled)
    assert(enabled == _Config.showtooltiplevel:GetValue())
end

-- 四个图标的颜色,等级和等级背景, 属性字体颜色
-- The data type is a color
__Config__(_Config, "criticoncolor", ColorType, {r = 1, g = 0.5, b = 0.3})
function SetCritColor(color)
	assert(color == _Config.criticoncolor:GetValue())
end
__Config__(_Config, "hasteiconcolor", ColorType, {r = 0.9, g = 1, b = 0.1})
function SetHasteColor(color)
	assert(color == _Config.hasteiconcolor:GetValue())
end
__Config__(_Config, "masteryiconcolor", ColorType, {r = 0.6, g = 0.08, b = 0.75})
function SetMasteryColor(color)
	assert(color == _Config.masteryiconcolor:GetValue())
end
__Config__(_Config, "versaiconcolor", ColorType, {r = 0.1, g = 0.3, b = 1})
function SetVersaColor(color)
	assert(color == _Config.versaiconcolor:GetValue())
end
__Config__(_Config, "levelfontcolor", ColorType, { r = 0, g = 0.8, b = 1})
function SetLevelColor(color)
	assert(color == _Config.levelfontcolor:GetValue())
end
__Config__(_Config, "levelbackcolor", ColorType, { r = 0.06, g = 0.21, b = 0.02})
function SetLevelBackColor(color)
	assert(color == _Config.levelbackcolor:GetValue())
end
__Config__(_Config, "statsfontcolor", ColorType, { r = 1, g = 0.8, b = 0})
function SetStatsFontColor(color)
	assert(color == _Config.statsfontcolor:GetValue())
end
__Config__(_Config, "unitinfobackcolor", ColorType, { r = 0.18, g = 0.15, b = 0.14})
function SetUnitInfoBackColor(color)
	assert(color == _Config.unitinfobackcolor:GetValue())
end
__Config__(_Config, "unitinfobordercolor", ColorType, { r = 0.3, g = 0.3, b = 0.3})
function SetUnitInfoBorderColor(color)
	assert(color == _Config.unitinfobordercolor:GetValue())
end