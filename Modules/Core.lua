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

-- get one piece equip`s info
function GetItemUseInfo(itemLink,slotID, unit)
    local dict = Dictionary()
	dict["slotID"] = slotID
	if itemLink then
		-- itemLink info
		local itemLink_string = { "start", "itemID", "enchantID", "gemID1", "gemID2", "gemID3", "gemID4" }
		-- GetItemInfo info
		local itemLink_api = { "itemName", "itemLink", "itemQuality" }
		-- get realLevel
		local effectLevel = GetDetailedItemLevelInfo(itemLink)
		local itemEquipLoc, _, itemType = select(4, GetItemInfoInstant(itemLink))
		local itemLink_dictionary = Dictionary(itemLink_string, {strsplit(":",itemLink)})
		local itemInfo_dictionary = Dictionary(itemLink_api, {GetItemInfo(itemLink)})
		local itemStats_dictionary = Dictionary(GetItemStats(itemLink))
		dict = dict:Update(itemLink_dictionary)
		dict = dict:Update(itemInfo_dictionary)
		dict = dict:Update(itemStats_dictionary)
		dict["itemRealLevel"] = effectLevel
		dict["itemEquipLoc"] = itemEquipLoc
		dict["itemType"] = itemType
		dict["unit"] = unit
	end

	return dict
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

-- 获取unit专精
function GetUnitSpec(unit)
	local specID, specName
	if unit =="player" then
		specID = GetSpecialization()
		specName = select(2, GetSpecializationInfoByID(specID))
	else
		specID = GetInspectSpecialization(unit)
		if specID and specID > 0 then
			specName = select(2, GetSpecializationInfoByID(specID))
		end
	end
	local className = UnitClass(unit)
	return specName or className or ""
end

-- 获取职业颜色
function GettUnitColor(unit)
	local _, classFilename = UnitClass(unit)
	local argbHex = select(4,GetClassColor(classFilename))
	return "|c" .. argbHex or ""
end