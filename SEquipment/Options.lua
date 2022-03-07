local ADDON_NAME,SEquipment = ...
local SE = SEquipment

local _, ns = ...
local L = ns.L or {}

local DB={
    ShowPlayerInfo = true,
    ShowTargetInfo = true,
    ShowTooltip = true,
    ShowWholeStat = true,
    -- ShowEquipLevel = true,
    ShowClassColorFrame = true,
}
local options = {
    {key = "ShowPlayerInfo"},
    {key = "ShowTargetInfo"},
    {key = "ShowTooltip"},
    {key = "ShowWholeStat"},
    -- {key = "ShowEquipLevel"},
    {key = "ShowClassColorFrame"},
}

local vars = CreateFrame("Frame")
vars:RegisterEvent("ADDON_LOADED")
vars:SetScript("OnEvent",function (self,event,name)
    if event == "ADDON_LOADED" and name == ADDON_NAME then
        self:UnregisterEvent("ADDON_LOADED")
        if SEquipmentDB == nil then
            SEquipmentDB = DB
        end
        SE.DB = SEquipmentDB
        SE:CreateOptions()
        -- SE:HookScript()
    end
end)

function SEquipment:CreateOptions()
    SE.options = CreateFrame("Frame",nil)
    SE.options.name = "SEquipment"
    InterfaceOptions_AddCategory(SE.options)

    SE.options.title = SE.options:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
    SE.options.title:SetPoint("TOPLEFT",16,-16)
    SE.options.title:SetText("|cff87CEEBS|r|cffEF5555E|r|cffA0522DQ|r|cff6ED73AU|r|cffFE4500I|r|cff3399EAP|r|cffFFFFFFment|r".." "..GetAddOnMetadata(ADDON_NAME,"Version"))

    local ButtonFrame = Frame("Button_",SE.options,200,200,1,0,0,0)
    ButtonFrame:SetPoint("TOPLEFT",20,-50)

    for k, v in pairs(options) do
        local name = v.key
        local ButtonFrame_Son = Frame("Button_Son_"..k,ButtonFrame,200,30,0,1,0,0)
        ButtonFrame_Son:SetPoint("TOPLEFT",0,(k-1)*(-35))
        ButtonFrame_Son.ItemString = ButtonFrame_Son:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
        ButtonFrame_Son.ItemString:SetText(L[name])
        ButtonFrame_Son.ItemString:SetPoint("LEFT",40,2)
        local Button = CreateFrame("CheckButton","button"..k,ButtonFrame_Son,"ChatConfigCheckButtonTemplate")
        Button:SetSize(30,30)
        Button:SetPoint("LEFT",0,0)

        Button:SetChecked(SE.DB[name])
        -- print(SE.DB.name)
        Button:SetScript("OnClick",function (self)
            if SE.DB[name] == true then
                SEquipmentDB[name] = false
                SE.DB[name] = false
                self:SetChecked(false)
            else
                SEquipmentDB[name] = true
                SE.DB[name] = true
                self:SetChecked(true)
            end
        end)
    end
end