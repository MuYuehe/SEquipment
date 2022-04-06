--========================================================--
--                SEquipment UI Menu Chat                 --
--                                                        --
-- Author      :  汐染晨风                                 --
-- Create Date :  2022/03/28                              --
--========================================================--

--========================================================--
Scorpio      "BaseConfig.MainInterface.General.Chat"      ""
--========================================================--
L = _Locale

----------------------------
--     SavedVariables     --
----------------------------
function OnLoad(self)
    _SVDB = SVManager("SEquipment_DB", "SEquipment_DB_Char")
end
----------------------------
--        Function        --
----------------------------
local ChatMsgCaches = {}
local function InsertLevelMsg(msg)
    if (msg and type(msg) == "string") then
        local link = string.match(msg, "|H(item:%d+:.-)|h.-|h")
        if link then
            local level = ChatMsgCaches[link] or select(4,GetItemInfo(link))
            if level and tonumber(level) > 0 then
                ChatMsgCaches[link] = level
                msg = msg:gsub("(%|Hitem:%d+:.-%|h%[)(.-)(%]%|h)", "%1"..level..":%2%3")
            end
        end
    end
    return msg
end
local function filter(self, event, msg, ...)
    if _SVDB and _SVDB.IsLevelShow[7] then
        msg = InsertLevelMsg(msg)
    end
    return false, msg, ...
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BATTLEGROUND", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_LOOT", filter)
