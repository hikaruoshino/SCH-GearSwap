-- =============================================================================
-- weather_obi.lua : 天候・曜日・学者の陣（Storms）対応 属性帯 / 八輪の帯 自動判定モジュール (v3)
-- =============================================================================
-- 判定には GearSwap が用意する world.weather_element / world.weather_intensity / world.day_element を使う。
--   ・GearSwap 本体 (refresh.lua の weather_update) が、学者の陣 (バフ ID 178〜185) を弱天候 (強さ 1)、
--     陣II (バフ ID 589〜596) を強天候 (強さ 2) として天候を上書きしている。
--     陣は自分にだけ効く天候なので、陣が掛かっていればゾーンの天候より陣が優先される。
--   ・天候名や陣の名前の文字列では判定しない。陣の日本語名 (熱波の陣・烈風の陣・疾雷の陣・極光の陣・妖霧の陣 …) の
--     書き間違いや、陣IIの英語名が陣Iと同じ "Firestorm" であることの影響を受けない。言語設定にも左右されない。
--
-- 属性帯 / 八輪の帯の効果 (常に発動するようになる):
--   同属性の天候 +10% (強天候 +25%) / 同属性の曜日 +10%
--   反属性の天候 -10% (強天候 -25%) / 反属性の曜日 -10%
--   合計がプラスのときだけ帯を装備する。
-- =============================================================================

local element_map = {
    ['Fire'] = '火', ['Water'] = '水', ['Lightning'] = '雷', ['Thunder'] = '雷',
    ['Earth'] = '土', ['Wind'] = '風', ['Ice'] = '氷', ['Light'] = '光', ['Dark'] = '闇',
    ['火'] = '火', ['水'] = '水', ['雷'] = '雷', ['土'] = '土',
    ['風'] = '風', ['氷'] = '氷', ['光'] = '光', ['闇'] = '闇',
}

-- その属性に強い (=その属性の効果を下げる) 属性
local weaken_element = {
    ['火'] = '水', ['水'] = '雷', ['雷'] = '土', ['土'] = '風',
    ['風'] = '氷', ['氷'] = '火', ['光'] = '闇', ['闇'] = '光',
}

-- 天候の強さごとの効果 (%)
local weather_bonus = { [1] = 10, [2] = 25 }
local day_bonus = 10

-- 所持している個別の属性帯を設定（火輪の帯、風輪の帯、闇輪の帯）
-- それ以外の属性は nil のため、自動的に 八輪の帯（hachirin）が適用されます
local elemental_obi = {
    ['火'] = {waist="火輪の帯"},
    ['水'] = nil, -- 八輪の帯を使用
    ['雷'] = nil, -- 八輪の帯を使用
    ['土'] = nil, -- 八輪の帯を使用
    ['風'] = {waist="風輪の帯"},
    ['氷'] = nil, -- 八輪の帯を使用
    ['光'] = nil, -- 八輪の帯を使用
    ['闇'] = {waist="闇輪の帯"},
}

local hachirin = {waist="八輪の帯"}

-- spell_element の魔法・技に帯を付けたときの効果 (%) を返す。属性が無いものは nil
function get_obi_bonus(spell_element)
    local elem = element_map[spell_element]
    if not elem then return nil end   -- 無属性・なし・物理など
    local weak_elem = weaken_element[elem]

    local bonus = 0

    -- 天候 (陣・陣II を含む)
    local weather_elem = element_map[world.weather_element]
    local power = weather_bonus[tonumber(world.weather_intensity) or 0] or 0
    if weather_elem == elem then
        bonus = bonus + power
    elseif weather_elem == weak_elem then
        bonus = bonus - power
    end

    -- 曜日
    local day_elem = element_map[world.day_element]
    if day_elem == elem then
        bonus = bonus + day_bonus
    elseif day_elem == weak_elem then
        bonus = bonus - day_bonus
    end

    return bonus
end

-- 帯を付けたほうが得なら、装備する帯 (個別の帯があれば優先、無ければ八輪の帯) を返す。損・効果なしなら nil
function get_hachirin(spell_element)
    local bonus = get_obi_bonus(spell_element)
    if not bonus or bonus <= 0 then return nil end
    return elemental_obi[element_map[spell_element]] or hachirin
end

-- -----------------------------------------------------------------------------
-- オルペウスサッシュ: 対象に近いほど属性ダメージ +1〜15%
--   距離 1.93 以内で +15%、13 以上で +1%、その間は距離に比例して下がる (BG-Wiki の値。間の距離は直線で近似)
--   距離は GearSwap の spell.target.distance (自分と対象の中心どうしの距離)
-- -----------------------------------------------------------------------------
local orpheus = {waist="オルペウスサッシュ"}
local ORPHEUS_NEAR, ORPHEUS_FAR = 1.93, 13
local ORPHEUS_MAX, ORPHEUS_MIN = 15, 1

-- 対象までの距離からオルペウスサッシュの効果 (%) を返す。距離が分からなければ nil
function get_orpheus_bonus(distance)
    distance = tonumber(distance)
    if not distance then return nil end
    if distance <= ORPHEUS_NEAR then return ORPHEUS_MAX end
    if distance >= ORPHEUS_FAR then return ORPHEUS_MIN end
    local rate = (distance - ORPHEUS_NEAR) / (ORPHEUS_FAR - ORPHEUS_NEAR)
    return ORPHEUS_MAX - (ORPHEUS_MAX - ORPHEUS_MIN) * rate
end

-- 属性帯 (天候・曜日) とオルペウスサッシュ (距離) のうち、効果が大きいほうの腰装備を返す。
-- 同じなら、対象が動いても効果が変わらない帯を選ぶ。どちらも効果が無ければ nil (セットの腰装備のまま)
function get_elemental_waist(spell)
    local obi_bonus = get_obi_bonus(spell.element)
    if not obi_bonus then return nil end   -- 属性の無いもの
    local orpheus_bonus = get_orpheus_bonus(spell.target and spell.target.distance)

    if obi_bonus > 0 and (not orpheus_bonus or obi_bonus >= orpheus_bonus) then
        return elemental_obi[element_map[spell.element]] or hachirin
    end
    if orpheus_bonus then return orpheus end
    return nil
end
