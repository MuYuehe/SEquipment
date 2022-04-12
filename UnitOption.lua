--========================================================--
--           SEquipment UI Menu UnitOption                --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio        "BaseConfig.MainInterface.UnitOption"      ""
--========================================================--
L = _Locale
----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
    _SVDB:SetDefault {
        SettingOption = {
                true,
                true,
                true,
                true,
                true,
                true,
                true,
        }
    }
end

local Options = {
    L["Show List Module"], L["Show Specialization"],
    L["Show Stats Icon"], L["Show Slots"],
    L["Show Level Module"], L["Show GemEnchant"],
    L["Show Attributes"],
}
----------------------------
--       UI Hierarchy     --
----------------------------
function OnEnable(self)
    for index, value in ipairs(Options) do
        local PlayerOption  = SECheckButton("PlayerOption" .. index, PlayerFrame)
        -- Style --
        Style[PlayerOption] = {
            location = { Anchor("TOPLEFT", 5, -10 - 25 * (index - 1)) },
            label    = {
                text     = value,
                location = { Anchor("LEFT", 30, 0) }
            }
        }
        -- SavedVariables --
        PlayerOption:SetChecked(_SVDB.SettingOption[index])
        __Async__()
        function PlayerOption:OnClick(button)
            if button == "LeftButton" then
                _SVDB.SettingOption[index] = self:GetChecked()
                FireSystemEvent("CHANGE_FRAME_STYLE")
            end
        end
    end
end