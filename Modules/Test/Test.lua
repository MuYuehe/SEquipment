Scorpio "SEquipment.Test" ""

-- __SecureHook__ "SetItemButtonQuality"
-- function Hook_SetItemButtonQuality(self, quality, itemIDOrLink,...)
--     if self.isBag then
--         return
--     end

--     -- local bagID = self:GetBagID() --可以判断是否为包裹
--     -- C_Container.GetContainerItemInfo(bagID, self:GetID()) --10.0加入的新api,与GetContainerItemInfo不同
-- end

__SystemEvent__ "NAME_PLATE_UNIT_ADDED" "FORBIDDEN_NAME_PLATE_UNIT_ADDED"
function EVENT_NAME_PLATE_UNIT_ADDED(unitToken)
    local namePlateFrameBase = C_NamePlate.GetNamePlateForUnit(unitToken, issecure());
    if not namePlateFrameBase.f then
        namePlateFrameBase.f = Frame(namePlateFrameBase:GetName() .. "TestClassIcon", namePlateFrameBase)
        namePlateFrameBase.f:SetPoint("CENTER",0, 40)
        namePlateFrameBase.f:SetSize(40, 40)

        namePlateFrameBase.tex = namePlateFrameBase.f:CreateTexture()
        namePlateFrameBase.tex:SetAllPoints(namePlateFrameBase.f)
        -- namePlateFrameBase.tex:SetTexture("Interface/GLUES/CHARACTERCREATE/UI-CHARACTERCREATE-CLASSES")
    end
    local className, class = UnitClass(unitToken)

    namePlateFrameBase.tex:SetMask("Interface/COMMON/Indicator-Gray")
    namePlateFrameBase.tex:SetTexture("Interface/ICONS/ClassIcon_" .. class)
end