--========================================================--
--                SEquipment UI Menu Bag                  --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio     "BaseConfig.MainInterface.General.Bag"        ""
--========================================================--
L = _Locale

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

-----------------------------------------------------------
--                         Bag                           --
-----------------------------------------------------------
__SecureHook__()
function ContainerFrame_Update(self)
    if self:GetID() < 5 then
        ShowItemLevelAndPart(self,3)
    else
        ShowItemLevelAndPart(self,4)
    end
end