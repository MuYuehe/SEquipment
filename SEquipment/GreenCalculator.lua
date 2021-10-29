-- 副属性计算器

function GetPercent(number,n)
    local Num, num= number, n
    local Percent = 0
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
    elseif num == 2 then
        -- 急速
        if Num <=990 then
            Percent = Num/33
        elseif Num > 990 and Num <= 1320 then
            Percent = 30 + (Num-1050)*0.9/33
        elseif Num > 1320 and Num <= 1650 then
            Percent = 39 + (Num-1400)*0.8/33
        elseif Num > 1650 and Num <= 1980 then
            Percent = 47 + (Num-1750)*0.7/33
        elseif Num > 1980 and Num <= 2640 then
            Percent = 54 + (Num-2100)*0.6/33
        elseif Num > 2640 and Num <= 6600 then
            Percent = 66 + (Num-2800)*0.5/33
        else
            Percent = 126
        end
    elseif num == 4 then
        -- 全能
        if Num <=1200 then
            Percent = Num/35
        elseif Num > 1200 and Num <= 1600 then
            Percent = 30 + (Num-1050)*0.9/40
        elseif Num > 1600 and Num <= 2000 then
            Percent = 39 + (Num-1400)*0.8/40
        elseif Num > 2000 and Num <= 2400 then
            Percent = 47 + (Num-1750)*0.7/40
        elseif Num > 2400 and Num <= 3200 then
            Percent = 54 + (Num-2100)*0.6/40
        elseif Num > 3200 and Num <= 8000 then
            Percent = 66 + (Num-2800)*0.5/40
        else
            Percent = 126
        end
    end

    return Percent
end
