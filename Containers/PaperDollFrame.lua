--========================================================--
--           SEquipment UI Menu PaperDollFrame            --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio "BaseConfig.MainInterface.General.PaperDollFrame" ""
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


----------------------------
--        Function        --
----------------------------
local function InsetPaperDollLevel(button,unit,number)
    if (not button) then
        return
    end
    local buttonID = button:GetID()
    if unit then
        local itemLink = GetInventoryItemLink(unit,buttonID)
        Min_ShowItemLevel(itemLink,number,button)
    end
    
end
__SecureHook__()
function PaperDollItemSlotButton_OnShow(self,isBag)
    InsetPaperDollLevel(self,"player",1)
end
__SecureHook__()
function PaperDollItemSlotButton_OnEvent(self,event,id,...)
    if event == "PLAYER_EQUIPMENT_CHANGED" and self:GetID() == id then
        InsetPaperDollLevel(self,"player",1)
    end
end
__SystemEvent__()
function ADDON_LOADED(addon)
    if addon == "Blizzard_InspectUI" then
        for _, value in ipairs({
    InspectHeadSlot,    InspectNeckSlot,    InspectShoulderSlot,    InspectBackSlot,
    InspectChestSlot,   InspectWristSlot,   InspectHandsSlot,       InspectWaistSlot,
    InspectLegsSlot,    InspectFeetSlot,    InspectFinger0Slot,     InspectFinger1Slot,
    InspectTrinket0Slot,InspectTrinket1Slot,InspectMainHandSlot,    InspectSecondaryHandSlot,
    InspectShirtSlot,   InspectTabardSlot
}) do
            InsetPaperDollLevel(value)
        end
    end
end
__Async__()
function OnEnable()
    while Wait("INSPECT_READY") and IsAddOnLoaded("Blizzard_InspectUI") do
        Next()
        for _, value in ipairs({
                InspectHeadSlot,    InspectNeckSlot,    InspectShoulderSlot,    InspectBackSlot,
                InspectChestSlot,   InspectWristSlot,   InspectHandsSlot,       InspectWaistSlot,
                InspectLegsSlot,    InspectFeetSlot,    InspectFinger0Slot,     InspectFinger1Slot,
                InspectTrinket0Slot,InspectTrinket1Slot,InspectMainHandSlot,    InspectSecondaryHandSlot,
                InspectShirtSlot,   InspectTabardSlot
            }) do
            InsetPaperDollLevel(value,InspectFrame.unit,2)
        end
    end
end
