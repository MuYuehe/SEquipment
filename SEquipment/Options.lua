local ADDON_NAME,SEquipment = ...
local SE = SEquipment

local DB={
    button1 = true,
    button2 = true,
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
    local ButtonFrame_Son1 = Frame("Button_Son1_",ButtonFrame,200,30,0,1,0,0)
    ButtonFrame_Son1:SetPoint("TOPLEFT",0,0)
    ButtonFrame_Son1.ItemString = ButtonFrame_Son1:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    ButtonFrame_Son1.ItemString:SetText("显示自身面板")
    ButtonFrame_Son1.ItemString:SetPoint("LEFT",40,2)
    local Button1 = CreateFrame("CheckButton","button1",ButtonFrame_Son1,"ChatConfigCheckButtonTemplate")
    Button1:SetSize(30,30)
    Button1:SetPoint("LEFT",0,0)

    local ButtonFrame_Son2 = Frame("Button_Son2_",ButtonFrame,200,30,0,1,0,0)
    ButtonFrame_Son2:SetPoint("TOPLEFT",0,-35)
    ButtonFrame_Son2.ItemString = ButtonFrame_Son2:CreateFontString(nil,"ARTWORK","GameFontNormalSmall")
    ButtonFrame_Son2.ItemString:SetText("显示目标面板")
    ButtonFrame_Son2.ItemString:SetPoint("LEFT",40,2)
    local Button2 = CreateFrame("CheckButton","button2",ButtonFrame_Son2,"ChatConfigCheckButtonTemplate")
    Button2:SetSize(30,30)
    Button2:SetPoint("LEFT",0,0)
    
    Button1:SetChecked(SE.DB.button1)
    Button1:SetScript("OnClick",function (self)
        if SE.DB.button1 == true then
            SEquipmentDB.button1 = false
            SE.DB.button1 = false
            self:SetChecked(false)
        else
            SEquipmentDB.button1 = true
            SE.DB.button1 = true
            self:SetChecked(true)
        end
    end)

    Button2:SetChecked(SE.DB.button2)
    Button2:SetScript("OnClick",function (self)
        if SE.DB.button2 == true then
            SEquipmentDB.button2 = false
            SE.DB.button2 = false
            self:SetChecked(false)
        else
            SEquipmentDB.button2 = true
            SE.DB.button2 = true
            self:SetChecked(true)
        end
    end)

end
