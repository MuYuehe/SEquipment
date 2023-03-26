Scorpio "SEquipment.data" ""
--======================--
namespace  "SEquipment.data"
--======================--
L = _Locale
--======================--
-- Constant
--======================--
SET_DATA = {
    [1525] = "狂怒风暴护甲",
    [1524] = "狂怒风暴之鳞",
    [1533] = "美德白银甲胄",
    [1529] = "雷翼劫猎者的伪装",
    [1538] = "行走高山之岩",
    [1528] = "失落唤地者的戎装",
    [1523] = "狂怒风暴之皮",
    [1537] = "鳞誓教徒的向往",
    [1531] = "水晶学士之缚",
    [1526] = "魅影霜巢遗骸",
    [1535] = "牢窟探秘者的工具",
    [1534] = "巨龙圣职者的华服",
    [1536] = "注能大地元素",
    [1527] = "穹缚复仇者的飞行服",
    [1532] = "悟拳裹甲",
    [1521] = "狂怒风暴斗披",
    [1530] = "觉醒者之鳞",
    [1514] = "破龙者的护甲",
    [1510] = "地平线骑手的外衣",
    [1516] = "青纹布法衣",
    [1512] = "破龙者的战甲",
    [1509] = "玩闹幽魂的毛皮",
    [1515] = "纺织时序布甲",
    [1511] = "破龙者的外袍",
    [1513] = "破龙者的外衣",
    [1520] = "巨龙驭手护甲",
}

STATS_FONT = {
    L["crit"],
    L["haste"],
    L["mastery"],
    L["versa"],
}

STATS_TEXTURE = "Interface/AddOns/SEquipment/Modules/Texture/crit"
--======================--
-- Class
--======================--
class "SEData" (function (_ENV)
    function GetSetID(id)       return SET_DATA[id]     end
    function GetSetTable()      return SET_DATA         end
    function GetStatsFont(id)   return STATS_FONT[id]   end
    function GetStatsFontTable()     return STATS_FONT       end
    function GetStatsTexture()  return STATS_TEXTURE    end
end)