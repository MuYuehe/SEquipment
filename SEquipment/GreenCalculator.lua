-- 副属性计算器
-- 精通
local MasteryEffect = {
-- dk
    [250] = 2,
    [251] = 2,
    [252] = 2.26,
-- dh
    [577] = 1.8,
    [581] = 2.5,
-- xd
    [102] = 1.1,
    [103] = 2,
    [104] = 0.5,
    [105] = 0.5,
-- lr
    [253] = 1.9,
    [254] = 0.625,
    [255] = 1.66,
-- fs
    [62] = 1.2,
    [63] = 0.75,
    [64] = 1,
-- ws
    [268] = 1,
    [270] = 4.2,
    [269] = 1.25,
-- qs
    [65] = 1.5,
    [66] = 1,
    [70] = 1.6,
-- ms
    [256] = 1.35,
    [257] = 1.25,
    [258] = 0.5,
-- dz
    [259] = 1.7,
    [260] = 1.45,
    [261] = 2.45,
-- sm
    [262] = 1.876,
    [263] = 2,
    [264] = 3,
-- ss
    [265] = 2.5,
    [266] = 1.45,
    [267] = 2,
-- zs
    [71] = 1.1,
    [72] = 1.46,
    [73] = 0.5,
}
-- 基础精通
local BaseMastery = {
    [250] = 16,
    [251] = 16,
    [252] = 18,

    [577] = 14,
    [581] = 24,

    [102] = 9,
    [103] = 16,
    [104] = 4,
    [105] = 4,

    [253] = 15,
    [254] = 5,
    [255] = 13,

    [62] = 9.6,
    [63] = 6,
    [64] = 8,

    [268] = 8,
    [270] = 34,
    [269] = 10,

    [65] = 12,
    [66] = 8,
    [70] = 13,

    [256] = 10.8,
    [257] = 10,
    [258] = 4,

    [259] = 14,
    [260] = 18,
    [261] = 19.6,

    [262] = 15,
    [263] = 0.64,
    [264] = 24,

    [265] = 20,
    [266] = 12,
    [267] = 8,
    
    [71] = 9,
    [72] = 11,
    [73] = 4,
}
-- 基础暴击
local BaseCrit = {
    [250] = 5,
    [251] = 5,
    [252] = 5,

    [577] = 10,
    [581] = 10,

    [102] = 5,
    [103] = 10,
    [104] = 10,
    [105] = 5,

    [253] = 10,
    [254] = 10,
    [255] = 10,

    [62] = 5,
    [63] = 5,
    [64] = 5,

    [268] = 10,
    [270] = 5,
    [269] = 10,

    [65] = 5,
    [66] = 5,
    [70] = 5,

    [256] = 5,
    [257] = 5,
    [258] = 5,

    [259] = 10,
    [260] = 10,
    [261] = 10,

    [262] = 10,
    [263] = 10,
    [264] = 10,

    [265] = 5,
    [266] = 5,
    [267] = 5,
    
    [71] = 5,
    [72] = 5,
    [73] = 5,
}

function GetPercent(number,n,SpecNumber,raceID)
    local Num, num= number, n
    local Percent = 0

    if SEquipmentDB.ShowWholeStat == true and raceID == 1 then
        Num = Num * (1 + 0.02)
    end

    if num == 1 or num == 3 then
        -- 暴击 精通
        if Num <=1050 then
            Percent = Num/35
        elseif Num > 1050 and Num <= 1400 then
            Percent = 30 + (Num-1050)*0.9/35
        elseif Num > 1400 and Num <= 1750 then
            Percent = 39 + (Num-1400)*0.8/35
        elseif Num > 1750 and Num <= 2100 then
            Percent = 47 + (Num-1750)*0.7/35
        elseif Num > 2100 and Num <= 2800 then
            Percent = 54 + (Num-2100)*0.6/35
        elseif Num > 2800 and Num <= 7000 then
            Percent = 66 + (Num-2800)*0.5/35
        else
            Percent = 126
        end
        
        if num == 3 then
            Percent = Percent * MasteryEffect[SpecNumber] --XXX精通系数 GetMasteryEffect()
            -- print(MasteryEffect[SpecNumber])
            -- print(GetMasteryEffect())
            -- print(35/8.33)
        end
    elseif num == 2 then
        -- 急速
        if Num <=990 then
            Percent = Num/33
        elseif Num > 990 and Num <= 1320 then
            Percent = 30 + (Num-990)*0.9/33
        elseif Num > 1320 and Num <= 1650 then
            Percent = 39 + (Num-1320)*0.8/33
        elseif Num > 1650 and Num <= 1980 then
            Percent = 47 + (Num-1650)*0.7/33
        elseif Num > 1980 and Num <= 2640 then
            Percent = 54 + (Num-1980)*0.6/33
        elseif Num > 2640 and Num <= 6600 then
            Percent = 66 + (Num-2640)*0.5/33
        else
            Percent = 126
        end
    elseif num == 4 then
        -- 全能
        if Num <=1200 then
            Percent = Num/40
        elseif Num > 1200 and Num <= 1600 then
            Percent = 30 + (Num-1200)*0.9/40
        elseif Num > 1600 and Num <= 2000 then
            Percent = 39 + (Num-1600)*0.8/40
        elseif Num > 2000 and Num <= 2400 then
            Percent = 47 + (Num-200)*0.7/40
        elseif Num > 2400 and Num <= 3200 then
            Percent = 54 + (Num-2400)*0.6/40
        elseif Num > 3200 and Num <= 8000 then
            Percent = 66 + (Num-3200)*0.5/40
        else
            Percent = 126
        end
    end

    if SEquipmentDB.ShowWholeStat == true then
        if num == 1 then
            -- if raceID == 1 then
            --     Percent = Percent * (1 + 0.02)
            -- end
            Percent = Percent + BaseCrit[SpecNumber]
            if raceID == 10 or raceID == 4 or raceID == 12 then
                Percent = Percent + 1
            end
        elseif num == 2 then
            -- if raceID == 1 then
            --     Percent = Percent * (1 + 0.02)
            -- else
            if raceID == 7 then
                Percent = Percent + 1
            end
        elseif num == 3 then
            -- if raceID == 1 then
            --     Percent = Percent * (1 + 0.02)
            -- end
            Percent = Percent + BaseMastery[SpecNumber]
        elseif num == 4 then
            -- if raceID == 1 then
            --     Percent = Percent * (1 + 0.02)
            -- else
            if raceID == 28 or raceID == 32 then
                Percent = Percent + 1
            end
        end
    end
    return Percent
end


--[[
    6170 == 全能 16
    6186 == 精通 16
    6164 == 暴击 16
    6166 == 急速 16
    6163 == 暴击 12
    6165 == 急速 12
    6167 == 精通 12
    6169 == 全能 12
]]
--[[
精通系数：
wst 1
ns  4.19999
ws 1.25
kbz 1.39999
wqz 1.1000
zst  1.5
]]

--[[
10血精灵  爆击 +1%
7侏儒    急速 +1%
1人类    绿字增加百分之2
4关于暗夜精灵的属性 ，白天加1%爆击，晚上加1%急速，但是所有的副本都被设置成了白天，所以暗夜精灵我觉得可以默认加1%爆击，毕竟副本才是真！！！

12狼人    爆击 +1%

28至高岭牛头人  全能 +1%
32库尔提拉斯人  全能 +1%

]]

--[[

1 爆击---- 35
2 急速 XXXX 33
3 精通---- 35
4 全能 XXXX 40
]]
-- 暴击&精通
--[[
    x为属性的数值
    30%无惩罚  数值阈值=30*35=1050 即小于等于这个数值，无收益惩罚
    30-39%惩罚10% 数值阈值:(x-1050)*0.9/35=9 x=1050+350=1400
    39-47%惩罚20% 数值阈值:(x-1400)*0.8/35=8 x=1400+350=1750
    47-54%惩罚30% 数值阈值:(x-1750)*0.7/35=7 x=1750+350=2100
    54-66%惩罚40% 数值阈值:(x-2100)*0.6/35=12 x=2100+700=2800
    66-126%惩罚50% 数值阈值:(x-2800)*0.5/35=60 x=2800+
    126-无收益
]]