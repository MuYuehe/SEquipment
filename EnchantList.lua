local EnchantList = {
    [6163] = "12爆击",
    [6164] = "16爆击",
    [6165] = "12急速",
    [6166] = "16急速",
    [6167] = "12精通",
    [6168] = "16精通",
    [6169] = "12全能",
    [6170] = "16全能",
}

function Eloon(id)
    local number = 0
    if EnchantList[id] then
        number = 1
    end
    return number
end

function GetEnchantStat(id)
    return EnchantList[id]
end