--========================================================--
--             SEquipment UI Menu BagAddons               --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio   "BaseConfig.MainInterface.General.BagAddons"    ""
--========================================================--
L = _Locale

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

----------------------------
--     Addons For Bag     --
----------------------------
-- LiteBag
if IsAddOnLoaded("LiteBag") then
    __SecureHook__()
    function LiteBagPanel_UpdateBag(self)
        if self:GetID() < 5 and self:GetID() ~= -1 then
            ShowItemLevelAndPart(self,3)
        else
            ShowItemLevelAndPart(self,4)
        end
    end
end
-- Bagnon
if IsAddOnLoaded("Bagnon") then
    __SecureHook__(Bagnon.Item)
    function Update(self)
        if self:GetParent():GetID() < 5 and self:GetParent():GetID() ~= -1 then
            Per_ShowItemLevel(self,3)
        else
            Per_ShowItemLevel(self,4)
        end
    end
end
-- Combuctor
if IsAddOnLoaded("Combuctor") then
    __SecureHook__(Combuctor.Item)
    function Update(self)
        if self:GetParent():GetID() < 5 and self:GetParent():GetID() ~= -1 then
            Per_ShowItemLevel(self,3)
        else
            Per_ShowItemLevel(self,4)
        end
    end
end
-- ArkInventory,BagView,AdiBags
-- 该插件有自己的装等显示模块儿,我只需禁用自己的某些模块儿即可
if IsAddOnLoaded("ArkInventory") or IsAddOnLoaded("BagView") or IsAddOnLoaded("AdiBags") then
    function OnEnable(self)
        for i = 3, 5 do
            Style[LevelSetFrame].ScrollChild    = {
                ["LevelSetPart"..i]             = {
                    ["LevelSetPartShow"..i]     = {
                        Enabled                 = false,
                    },
                    ["LevelSetPartLocation"..i] = {
                        Toggle                  = {
                            Enabled                 = false,
                        }
                    },
                    ["LevelSetPartSize"..i]     = {
                        Enabled                 = false,
                    }
                },
            }
        end
    end
end