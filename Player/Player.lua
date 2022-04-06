--========================================================--
--                SEquipment UI Menu Player               --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.MainInterface.PlayerListFrame.Config.Player" ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                          Player                       --
-----------------------------------------------------------

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
    _SVDB:SetDefault {
        PlayerOption = {
            true,
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
----------------------------
--     Data Collection    --
----------------------------
local PlayerOptions = {
    L["Show Player Module"],    L["Show Specialization"],
    L["Show Stats Icon"],       L["Show Slots"],
    L["Show Level Module"],     L["Show GemEnchant"],
    L["Show Attributes"],       L["Show Attributes Percent"],
}
----------------------------
--       UI Hierarchy     --
----------------------------
function OnEnable(self)
    for index, value in ipairs(PlayerOptions) do
        local PlayerOption = SECheckButton("PlayerOption"..index,PlayerFrame)
        -- Style --
        Style[PlayerOption]                 = {
            location                        = { Anchor("TOPLEFT",5,-10-25*(index-1)) },
            label                           = {
                text                        = value,
                location                    = {Anchor("LEFT",30,0)}
            }
        }
        -- SavedVariables --
        PlayerOption:SetChecked(_SVDB.PlayerOption[index])
        __Async__()
        function PlayerOption:OnClick(button)
            if button == "LeftButton" then
                _SVDB.PlayerOption[index]   = self:GetChecked()
                InitializeData()
            end
        end
    end
end
