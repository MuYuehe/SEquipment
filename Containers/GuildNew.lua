--========================================================--
--              SEquipment UI Menu GuildNew               --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio    "BaseConfig.MainInterface.General.GuildNew"    ""
--========================================================--
L = _Locale

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

----------------------------
--     Data Collection    --
----------------------------
local GuildNewsItemCache = {}
__SecureHook__()
function GuildNewsButton_SetText(button, font_color, text, text1, text2, ...)
    if (text2 and type(text2) == "string") and _SVDB.IsLevelShow[6] then
        local link = string.match(text2, "|H(item:%d+:.-)|h.-|h")
        if (link) then
            local level = GuildNewsItemCache[link] or select(4,GetItemInfo(link))
            if level and (tonumber(level) > 0) then
                GuildNewsItemCache[link] = level
                text2 = text2:gsub("(%|Hitem:%d+:.-%|h%[)(.-)(%]%|h)", "%1"..level..":%2%3")
                button.text:SetFormattedText(text, text1, text2, ...)
            end
        end
    end
end