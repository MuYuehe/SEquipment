--========================================================--
--               SEquipment UI Menu Bank                  --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio     "BaseConfig.MainInterface.General.Bank"        ""
--========================================================--
L = _Locale

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end

-----------------------------------------------------------
--                         Bank                          --
-----------------------------------------------------------
__SecureHook__()
function BankFrameItemButton_Update (button)
    ShowItemLevelAndPart(button:GetParent():GetParent(),4)
end
__Async__()
function OnEnable(self)
    if not IsAddOnLoaded("Blizzard_GuildBankUI") then
        while NextEvent("ADDON_LOADED") ~= "Blizzard_GuildBankUI" do end
    end
    if _SVDB.IsLevelShow[5] then
        hooksecurefunc(GuildBankFrame, "Update", function(self)
            local GUILDBANK_SLOTS_PER_TAB = 98
            local GUILDBANK_SLOTS_PER_GROUP = 14
            local tabID = GetCurrentGuildBankTab()
            for i = 1, GUILDBANK_SLOTS_PER_TAB do
                local index = math.fmod(i,GUILDBANK_SLOTS_PER_GROUP)
                if index == 0 then
                    index = GUILDBANK_SLOTS_PER_GROUP
                end
                local column = math.ceil((i-0.5)/GUILDBANK_SLOTS_PER_GROUP)
                local button = self.Columns[column].Buttons[index]
                local itemLink =  GetGuildBankItemLink(tabID,i)
                local Colors,itemType,LocName,itemLevel
                if itemLink then
                    Colors,itemType,LocName,itemLevel = GetContainerItemInfo(itemLink)
                end
                local levelshowLeveltext = FontString("levelshowLeveltext",button)
                if (itemType == WEAPON  or itemType == ARMOR) and _SVDB.IsLevelShow[5] then
                    Style[levelshowLeveltext]    = {
                        text = tostring(itemLevel),
                        location = { Anchor(ItemLocation[_SVDB.LevelSetPartLocation[5]])},
                        Textcolor = Color(Colors.r,Colors.b,Colors.b),
                        font        = {
                            font    = SEFontStyle[_SVDB.FontStyleSet].value,
                            height  = _SVDB.LevelSetPartSize[5],
                            monochrome = false,
                            outline = "NORMAL"
                        },
                    }
                else
                    Style[levelshowLeveltext]    = {
                        text = "",
                    }
                end
            end
        end)
    end
end
