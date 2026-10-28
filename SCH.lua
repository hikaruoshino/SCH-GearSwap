-- =============================================================================
-- SCH.lua : 学者 (Scholar) GearSwap メインロジック
-- =============================================================================

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    set_language('japanese')
    include('weather_obi.lua') -- 陣・天候・曜日対応 八輪の帯判定モジュール
end


function job_setup()
    -- 監視バフ一覧（章・策）
    state.Buff['意気昂然の章']      = buffactive['意気昂然の章'] or false
    state.Buff['一心精進の章']      = buffactive['一心精進の章'] or false
    state.Buff['簡素清貧の章']      = buffactive['簡素清貧の章'] or false
    state.Buff['机上演習:蓄積中']   = buffactive['机上演習:蓄積中'] or false
    state.Buff['気炎万丈の章']      = buffactive['気炎万丈の章'] or false
    state.Buff['虚誘掩殺の策']      = buffactive['虚誘掩殺の策'] or false
    state.Buff['勤倹小心の章']      = buffactive['勤倹小心の章'] or false
    state.Buff['疾風迅雷の章']      = buffactive['疾風迅雷の章'] or false
    state.Buff['震天動地の章']      = buffactive['震天動地の章'] or false
    state.Buff['天衣無縫の章']      = buffactive['天衣無縫の章'] or false
    state.Buff['電光石火の章']      = buffactive['電光石火の章'] or false
    state.Buff['不惜身命の章']      = buffactive['不惜身命の章'] or false
    state.Buff['無憂無風の章']      = buffactive['無憂無風の章'] or false
    state.Buff['令狸執鼠の章']      = buffactive['令狸執鼠の章'] or false
    
    -- ★キャスティングモードに Normal と MB（マジックバースト）を追加
    state.CastingMode:options('Normal', 'MB')

    state.IdleMode:options('Normal', 'Refresh')
    state.OffenseMode:options('Normal', 'SubtleBlow')
    state.WeaponskillMode:options('Normal', 'SubtleBlow')

    state.MainWeapons       = M{'ムサ','ブンジロッド','マフィックカジェル','マレヴォレンス','デイブレイクワンド','ハーミットワンド'}
    state.SubWeapons        = M{'コーンスー','アムラピシールド','玄冥盾','エンキストラップ','カルミナス','チャンターシールド'}
    state.VagaryMode        = M(false, 'Vagary')
    state.TreasureHunter    = M(false)

    send_command('bind ~f7 gs c cycle VagaryMode')
end


function user_unload()
    send_command('unbind ~f7')
end


-- サポ赤のジョブ特性ファストキャスト (%)。サポLv 15=10 / 35=15 / 55=20
-- 学者のマスターレベル21ならサポLv53で15。シェオル ジェールのようにサポLvが0なら0
local function sub_job_fast_cast()
    if player.sub_job ~= '赤' then return 0 end
    local lv = player.sub_job_level or 0
    if lv >= 55 then return 20
    elseif lv >= 35 then return 15
    elseif lv >= 15 then return 10
    end
    return 0
end


function job_post_precast(spell, action, spellMap, eventArgs)
    -- ★黒のグリモア・黒の補遺・震天動地の章の間は、精霊魔法とメルトンの FC を
    --   sets.precast.FC.Black（ロックスタイルと同じ片手棍＋盾）にする。
    --   両手棍のムサに持ち替えると点滅して、震天の連携や MB 前に連携のエフェクトが消えるため。
    --   インパクトは専用の FC セット（トワイライトプリス）を崩さないよう対象外
    local is_black = buffactive['黒のグリモア'] or buffactive['黒の補遺'] or buffactive['震天動地の章']
    local is_nuke = (spell.skill == '精霊魔法' and spell.name ~= 'インパクト') or spell.name == 'メルトン'
    if is_black and is_nuke and sets.precast.FC.Black then
        -- サポの特性FCを足しても上限80%に届くなら、耳と指を震天中の装備（モクシャ）と同じにする
        local surplus = sets.precast.FC.BlackSurplus and fc_gear_value
            and (fc_gear_value.BlackSurplus + sub_job_fast_cast() >= 80)
        equip(surplus and sets.precast.FC.BlackSurplus or sets.precast.FC.Black)
    end

    -- ★電光石火の章・疾風迅雷の章の足 (天候が一致する魔法の詠唱時間・再詠唱時間を短縮) は、
    --   「魔法使用時に装備している必要がある」(FF11用語辞典 ペダゴギアタイア)。詠唱時間は詠唱を始めた時点で決まるので、
    --   詠唱中 (job_post_midcast) に加えて、ここでも着る。FC のセットより後に着て、足を上書きする
    if spell.action_type == 'Magic' and spell.name ~= 'インパクト' then
        for _, buff in ipairs({'電光石火の章', '疾風迅雷の章'}) do
            if buffactive[buff] and sets.buff[buff]
            and not (spell.name == 'オーラ' and buff == '電光石火の章') then   -- midcast と同じく、オーラでは着ない
                equip(sets.buff[buff])
            end
        end
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- ★震天動地の章バフの判定
    local is_shinten = state.Buff['震天動地の章'] or buffactive['震天動地の章']

    -- 戦術魔道書バフ装備の上書き処理
    for buff, active in pairs(state.Buff) do
        if active and sets.buff[buff] then
            if spell.name == 'インパクト' 
            or (spell.name == 'オーラ' and (buff == '電光石火の章' or buff == '簡素清貧の章')) then
                -- 特定魔法での上書き無効化
            else
                equip(sets.buff[buff])
            end
        end
    end 

    -- ★震天動地の章が発動中の場合は、属性帯（get_hachirin）を着替えずにスキップし、
    --   sets.buff['震天動地の章']（手：ＡＢガウン+3等）を最優先で確実に装備する
    if is_shinten then
        if sets.buff['震天動地の章'] then
            equip(sets.buff['震天動地の章'])
        end
    else
        -- 震天動地の章が発動していない時のみ、腰を自動で着替える
        -- ダメージを与える精霊魔法 (計略魔法を含む) とメルトン: 学者も MB をするので、すべて同じように
        --   属性帯 (学者の陣・天候・曜日) とオルペウスサッシュ (対象との距離) のうち、効果が大きいほう
        -- 精霊弱体 (バーン等) とインパクトは命中重視のセットを崩さないため着替えない (BLM.lua と同じ)
        local is_nuke = (spell.skill == '精霊魔法' and spellMap ~= 'ElementalEnfeeble' and spell.name ~= 'インパクト')
        if is_nuke or spell.name == 'メルトン' then
            local waist = get_elemental_waist(spell)
            if waist then
                equip(waist)
            end
        elseif spellMap == 'Cure' or spellMap == 'Curaga' then
            -- 回復魔法: 天候・曜日で効果がプラスなら属性帯
            equip(get_hachirin(spell.element))
        end
    end
end


function job_customize_idle_set(idleSet)
    if state.Buff['机上演習:蓄積中'] then
        idleSet = set_combine(idleSet, sets.buff['机上演習'])
    end
    return idleSet
end


function job_state_change(stateField, newValue, oldValue)
    -- user-globals.lua が無い・user_state_change が無いときも落ちないようにする (PLD.lua・RNG.lua と同じ)
    if user_state_change then
        user_state_change(stateField, newValue, oldValue)
    end
    if stateField == 'Vagary' then
        if newValue then
            equip(sets.precast.FC)
            disable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
        else
            enable('range','ammo','head','neck','left_ear','right_ear','body','hands','left_ring','right_ring','back','waist','legs','feet')
            IdleMelee()
        end
    end
end


function job_buff_change(buff, gain)
    if buff == "机上演習:蓄積中" and gain then 
        equip(sets.buff['机上演習'])
    end
end


-- ▼▼▼▼▼▼ 震天動地連携用設定 ▼▼▼▼▼▼
sc_mb = {
    ['溶解'] = {'炎'},
    ['硬化'] = {'氷'},
    ['炸裂'] = {'風'},
    ['切断'] = {'土'},
    ['衝撃'] = {'雷'},
    ['振動'] = {'水'},
    ['貫通'] = {'光'},
    ['収縮'] = {'闇'},
    ['核熱'] = {'炎', '光'},
    ['重力'] = {'土', '闇'},
    ['分解'] = {'風', '雷'},
    ['湾曲'] = {'氷', '水'},
}


function custom_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'lockstyleset' then -- ロックスタイル固定処理
        if cmdParams[2] == 'black' then
            send_command('gs c set MainWeapons '..windower.to_shift_jis('ブンジロッド')..'; wait 0.1; gs c set SubWeapons '..windower.to_shift_jis('アムラピシールド')..'; wait 0.1; input /lockstyleset '.. (lockstyleset_black or '100'))
        elseif cmdParams[2] == 'white' then
            send_command('gs c set MainWeapons '..windower.to_shift_jis('ムサ')..'; wait 0.1; gs c set SubWeapons '..windower.to_shift_jis('コーンスー')..'; wait 0.1; input /lockstyleset '.. (lockstyleset_white or '100'))
        else
            send_command('gs c set MainWeapons '..windower.to_shift_jis('ムサ')..'; wait 0.1; gs c set SubWeapons '..windower.to_shift_jis('コーンスー')..'; wait 0.1; input /lockstyleset '.. (lockstyleset or '100'))
        end

    elseif cmdParams[1] == 'sc' then -- 【学者】震天動地連携処理
        if cmdParams[2] == 'start' then
            disp_start_skillchain_message(cmdParams[3], cmdParams[4])
        elseif cmdParams[2] == 'end' then
            disp_end_skillchain_message(cmdParams[3], cmdParams[4])
        else
            windower.add_to_chat(123, '無効な引数です: ' .. table.concat(cmdParams, ' '))
        end
    end
end


function get_auto_translate_char_squence(phrase)
    local at_start = 0xFD
    local at_end = 0xFD
    local at_type = 0x02
    local at_lang = 0x01

    local at_entry = gearswap.res.auto_translates:with('ja', phrase)
    if not at_entry or not at_entry.id or at_entry.id == 0 then
        -- 辞書に無い場合は生テキストにフォールバック
        return windower.to_shift_jis(phrase)
    end

    local phrase_id = at_entry.id
    local phrase_id_upper = bit.band(bit.rshift(phrase_id, 8), 0xFF)
    local phrase_id_lower = bit.band(phrase_id, 0xFF)

    return string.char(at_start, at_type, at_lang, phrase_id_upper, phrase_id_lower, at_end)
end


function disp_start_skillchain_message(sc_name, count)
    if not sc_mb[sc_name] then
        windower.add_to_chat(123, '[SC] 未定義の連携名: ' .. tostring(sc_name))
        return
    end

    count = count or ''

    local sc_msg = get_auto_translate_char_squence(sc_name)
    local sc_mb_msg = {}

    for i, v in ipairs(sc_mb[sc_name]) do
        sc_mb_msg[i] = get_auto_translate_char_squence(v)
    end

    local msg = 'input /p '..windower.to_shift_jis(count)..sc_msg

    for i, v in ipairs(sc_mb_msg) do
        msg = msg..v
    end

    local start_msg = get_auto_translate_char_squence('準備中です。')

    msg = msg..start_msg..windower.to_shift_jis('   → ')..' <t> <scall21>'
    send_command('wait 0.2; '..msg)
end


function disp_end_skillchain_message(sc_name, count)
    if not sc_mb[sc_name] then
        windower.add_to_chat(123, '[SC] 未定義の連携名: ' .. tostring(sc_name))
        return
    end

    count = count or ''

    local sc_msg = get_auto_translate_char_squence(sc_name)
    local sc_mb_msg = {}

    for i, v in ipairs(sc_mb[sc_name]) do
        sc_mb_msg[i] = get_auto_translate_char_squence(v)
    end

    local msg = 'input /p '..windower.to_shift_jis(count)..sc_msg

    for i, v in ipairs(sc_mb_msg) do
        msg = msg..v
    end

    local end_msg = get_auto_translate_char_squence('全力で攻撃だ！')

    msg = msg..end_msg..windower.to_shift_jis(' → ')..' <t> '..windower.to_shift_jis('※').. '<recast='..windower.to_shift_jis("戦術魔道書")..'>'
    -- 開始の合図 (0.2 秒後) と同じマクロで続けて呼ばれると、2 つのチャット入力が同じ瞬間に重なって
    -- 「コマンドでエラーがあったようです」になる (2026-10-12、核熱専用マクロの ①→③)。終了の合図は 1 秒遅らせる
    send_command('wait 1.2; '..msg)
end
-- ▲▲▲▲▲▲ 震天動地連携用設定 ▲▲▲▲▲▲