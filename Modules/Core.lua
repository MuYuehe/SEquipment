Scorpio "SEquipment.core" ""
--======================--
-- Api
--======================--
-- 获取暴击
function P_GetCritChance(unit)
	if unit ~= "player" then
		return;
	end

    local rating;
	local spellCrit, rangedCrit, meleeCrit;
    -- 暴击率
	local critChance;

	-- Start at 2 to skip physical damage
	local holySchool = 2;
	local minCrit = GetSpellCritChance(holySchool);

    for i=(holySchool+1), MAX_SPELL_SCHOOLS do
		spellCrit = GetSpellCritChance(i);
		minCrit = min(minCrit, spellCrit);
	end
	spellCrit = minCrit
	rangedCrit = GetRangedCritChance();
	meleeCrit = GetCritChance();

	if (spellCrit >= rangedCrit and spellCrit >= meleeCrit) then
		critChance = spellCrit;
		rating = CR_CRIT_SPELL;
	elseif (rangedCrit >= meleeCrit) then
		critChance = rangedCrit;
		rating = CR_CRIT_RANGED;
	else
		critChance = meleeCrit;
		rating = CR_CRIT_MELEE;
	end

    -- 额外暴击率+ 额外暴击数
    local extraCritChance = GetCombatRatingBonus(rating);
	local extraCritRating = GetCombatRating(rating);
    return format("%.1f", critChance), extraCritRating, format("%.1f",extraCritChance), ITEM_MOD_CRIT_RATING_SHORT
end
-- 获取精通
function P_GetMastery(unit)
	if unit ~= "player" then
		return;
	end

    -- 总精通
	local mastery, bonusCoeff = GetMasteryEffect();
    -- 额外精通率
	local masteryBonus = GetCombatRatingBonus(CR_MASTERY) * bonusCoeff;
    -- GetCombatRating(CR_MASTERY) 额外精通数
    return format("%.1f",mastery), GetCombatRating(CR_MASTERY), format("%.1f",masteryBonus),ITEM_MOD_MASTERY_RATING_SHORT
end
-- 获取急速
function P_GetHaste(unit)
	if unit ~= "player" then
		return;
	end

    local haste = GetHaste();
    local rating = CR_HASTE_MELEE;
	-- 返回总急速率,额外急速,额外急速率
	return format("%.1f", haste), GetCombatRating(rating), format("%.1f",GetCombatRatingBonus(rating)), ITEM_MOD_HASTE_RATING_SHORT
end
-- 获取全能
function P_GetVersa(unit)
	if unit ~= "player" then
		return;
	end

	local versatility = GetCombatRating(CR_VERSATILITY_DAMAGE_DONE);
	local versatilityDamageBonus = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE);
	local versatilityDamageTakenReduction = GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_TAKEN) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_TAKEN);
	-- 总全能率,额外全能数,伤害治疗提高率,减伤率
	return format("%.1f", versatilityDamageBonus), versatility,format("%.1f", versatilityDamageTakenReduction),ITEM_MOD_VERSATILITY
end
-- Item是否有空宝石孔
function IsItemEmptySlots(stats, table)
	local socketNumber, gemNumber = 0, 0
	for k, v in pairs(stats) do
		if string.find(k, "EMPTY_SOCKET_") then
			socketNumber = v
			break
		end
	end
	for _, v in pairs(table) do
		if v and v ~= "" then
			gemNumber = gemNumber + 1
		end
	end
	return socketNumber > gemNumber
end

-- 获取item相关信息
function GetItemUseInfo(itemLink,slotID, unit)
	local data = {}

	if itemLink and itemLink ~= "" then
		local _, itemID, enchantID, gemID1, gemID2, gemID3, gemID4
		local itemEquipLoc, itemType, itemName, itemQuality, setID
		-- get realLevel
		local itemLevel 	= GetDetailedItemLevelInfo(itemLink)
		local statsTable 	= GetItemStats(itemLink)
		_, itemID, enchantID, gemID1, gemID2, gemID3, gemID4 = strsplit(":",itemLink)
		itemName, _, itemQuality, _, _, itemType, _, _, itemEquipLoc, _, _, _, _, _, _, setID = GetItemInfo(itemLink)
		data = {
			["itemInfo"] 			= {
				["itemID"] 			= itemID,
				["itemLink"] 		= itemLink,
				["itemName"] 		= itemName or "",
				["itemQualityNum"]	= itemQuality,
				["itemQuality"] 	= ITEM_QUALITY_COLORS[itemQuality],
				["itemEquipLoc"]	= _G[itemEquipLoc] or "",
				["itemType"] 		= itemType or "",
				["itemLevel"] 		= itemLevel or 0,
				["setID"] 			= setID,
			},
			["extraInfo"]			= {
				["gemID1"] 			= gemID1 and gemID1 ~= "" and gemID1,
				["gemID2"] 			= gemID2 and gemID2 ~= "" and gemID2,
				["gemID3"] 			= gemID3 and gemID3 ~= "" and gemID3,
				["gemID4"] 			= gemID4 and gemID4 ~= "" and gemID4,
				["enchantID"] 		= enchantID and enchantID ~= "" and enchantID,
				["emptySlots"]		= IsItemEmptySlots(statsTable, {gemID1, gemID2, gemID3, gemID4}),
			},
			["statsInfo"]			= {
				["ITEM_MOD_CRIT_RATING_SHORT"] 		= statsTable and statsTable["ITEM_MOD_CRIT_RATING_SHORT"] or 0,
				["ITEM_MOD_HASTE_RATING_SHORT"] 	= statsTable and statsTable["ITEM_MOD_HASTE_RATING_SHORT"] or 0,
				["ITEM_MOD_MASTERY_RATING_SHORT"] 	= statsTable and statsTable["ITEM_MOD_MASTERY_RATING_SHORT"] or 0,
				["ITEM_MOD_VERSATILITY"] 			= statsTable and statsTable["ITEM_MOD_VERSATILITY"] or 0,
			},
		}
	end
	data["slotID"] 					= slotID
	data["unit"] 					= unit
	return data
end

-- 获取tooltip含关键字的行
function GetLevelLine(tooltip, keyword)
    local line, text
    for i = 2, tooltip:NumLines() do
        line = _G[tooltip:GetName() .. "TextLeft" .. i]
        text = line:GetText() or ""
        if string.find(text, keyword) then
            return line, _G[tooltip:GetName() .. "TextRight" .. i]
        end
    end
end

-- 获取unit职业相关信息
function GetUnitSpec(unit)
	local specID, specName, classFile, icon, className, argbHex
	if unit =="player" then
		specID = GetSpecialization()
		specName, _, icon = select(2, GetSpecializationInfo(specID))
	else
		specID = GetInspectSpecialization(unit)
		if specID and specID > 0 then
			specName, _, icon = select(2, GetSpecializationInfoByID(specID))
		end
	end
	className, classFile = UnitClass(unit)
	argbHex = select(4,GetClassColor(classFile))
	return specID, specName, classFile, icon, className, "|c" .. argbHex or ""
end