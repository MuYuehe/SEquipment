--========================================================--
--                 SEquipment UI Menu                     --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio           "BaseConfig.MainInterface"              ""
--========================================================--
L = _Locale
-----------------------------------------------------------
--                         UIMenu                        --
-----------------------------------------------------------

----------------------------
--       UI Hierarchy     --
----------------------------
SEMainUI                            = SEDialog("SEMainUI")
    MenuTree                        = TreeView("MenuTreeName",SEMainUI)
    ExitButton                      =SEButton("ExitButton",SEMainUI)
    SEVersion                       =FontString("SEVersion",SEMainUI)
        HomeFrame                   =SESetMenuFrame("HomeFrame",SEMainUI)
        GeneralFrame                =SESetMenuFrame("GeneralFrame",SEMainUI)
        PlayerFrame                 =SESetMenuFrame("PlayerFrame",SEMainUI)
        TargetFrame                 =SESetMenuFrame("TargetFrame",SEMainUI)
SEMainUI:Hide()
        GeneralFrame:Hide()
        PlayerFrame:Hide()
        TargetFrame:Hide()
-- Style --
Style[SEMainUI]                     = {
    location                        = { Anchor("CENTER") },
    Header                          = {
        text                        = "|cff87CEEBS|r|cffEF5555E|r|cffA0522DQ|r|cff6ED73AU|r|cffFE4500I|r|cff3399EAP|r|cffFFFFFFment|r"
    },
}

Style[MenuTree]                     = {
    location                        = { Anchor("LEFT",15) },
    size                            = Size(150,320),
    backdropColor                   = Color(0,0,0,0),
}
Style.ActiveSkin("SETreeNode",MenuTreeName)
MenuTree:AddTreeNode(L["Home"])
MenuTree:AddTreeNode(L["General"])
MenuTree:AddTreeNode(L["Player"])
MenuTree:AddTreeNode(L["Target"])


Style[ExitButton]                   = {
    location                        = { Anchor("BOTTOMRIGHT",-15,15) },
    text                            = L["Exit"],
}

Style[SEVersion]                    = {
    location                        = { Anchor("BOTTOMLEFT",15,15) },
    text                            = L["Log1 Version"],
    textcolor                       = Color(0.5,0.5,0.5,1),
}

Style[HomeFrame]={
    size                            = Size(400,320),
    location                        = {Anchor("RIGHT",-15,0)},
    backdropbordercolor             = Color(1,1,1,1),
}
Style[GeneralFrame]={
    size                            = Size(400,320),
    location                        = {Anchor("RIGHT",-15,0)},
    backdropbordercolor             = Color(1,1,1,1),
}
Style[PlayerFrame]={
    size                            = Size(400,320),
    location                        = {Anchor("RIGHT",-15,0)},
    backdropbordercolor             = Color(1,1,1,1),
}
Style[TargetFrame]={
    size                            = Size(400,320),
    location                        = {Anchor("RIGHT",-15,0)},
    backdropbordercolor             = Color(1,1,1,1),
}

-- /CMD
__SlashCmd__ "SE"
function enableModule()
    SEMainUI:Show()
end

-- Event
function MenuTree:OnNodeClick(path)
    HomeFrame:Hide()
    GeneralFrame:Hide()
    PlayerFrame:Hide()
    TargetFrame:Hide()
    if path == L["Home"] then
        HomeFrame:Show()
    elseif path == L["General"] then
        GeneralFrame:Show()
    elseif path == L["Player"] then
        PlayerFrame:Show()
    elseif path == L["Target"] then
        TargetFrame:Show()
    end
end
__Async__()
function ExitButton:OnClick(button)
    if button == "LeftButton" then
        SEMainUI:Hide()
    end
end