--========================================================--
--                SEquipment UI Menu Target               --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.MainInterface.TargetListFrame.Config.Target" ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                          Target                       --
-----------------------------------------------------------

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
    _SVDB:SetDefault {
        TargetOption = {
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
--       UI Hierarchy     --
----------------------------
local TargetOptions = {
    L["Show Target Module"],    L["Show Specialization"],
    L["Show Stats Icon"],       L["Show Slots"],
    L["Show Level Module"],     L["Show GemEnchant"],
    L["Show Attributes"],       L["Show Attributes Percent"],
}
function OnEnable(self)
    for index, value in ipairs(TargetOptions) do
        local TargetOption = SECheckButton("TargetOption"..index,TargetFrame)
        -- Style --
        Style[TargetOption]                 = {
            location                        = { Anchor("TOPLEFT",5,-10-25*(index-1)) },
            label                           = {
                text                        = value,
                location                    = {Anchor("LEFT",30,0)}
            }
        }
        -- SavedVariables --
        TargetOption:SetChecked(_SVDB.TargetOption[index])
        __Async__()
        function TargetOption:OnClick(button)
            if button == "LeftButton" then
                _SVDB.TargetOption[index] = self:GetChecked()
                InitializeData()
            end
        end
    end
end