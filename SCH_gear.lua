function init_weaponns()
    send_command('gs c set MainWeapons '..windower.to_shift_jis('ムサ')
    ..'; wait 1;  gs c set SubWeapons ' ..windower.to_shift_jis('コーンスー'))
end


function init_gear_sets()
    --ロックスタイル番号
    lockstyleset  =109
    lockstyleset_white  = 110
    lockstyleset_black  = 111

    
    --武器
    gear['ムサ']                                    = { name="ムサ"}
 --   gear['オパショーロ']                            = { name="オパショーロ"}
    gear['コーンスー']                              = { name="コーンスー"}
    gear['エンキストラップ']                        = { name="エンキストラップ"}
    gear['ブンジロッド']                            = { name="ブンジロッド"}
	gear['ハーミットワンド']                            = { name="ハーミットワンド"}
    gear['デイブレイクワンド']                      = { name="デイブレイクワンド"}
	gear['マフィックカジェル']                      = { name="マフィックカジェル"}
    gear['マレヴォレンス']                          = { name="マレヴォレンス", augments={'INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+10','"Fast Cast"+5',}}
    gear['アムラピシールド']                        = { name="アムラピシールド"}
	gear['玄冥盾']                        = { name="玄冥盾"}
	gear['カルミナス']                        = { name="カルミナス"}
	gear['チャンターシールド']                        = { name="チャンターシールド"}


    --ジョブマント
    gear.JobMantle                                  = { }
    gear.JobMantle.Idle                             = { name="ルッフケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%'}}
    gear.JobMantle.Melee                            = { name="ルッフケープ", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Damage taken-5%'}}
    gear.JobMantle.MGC                              = { name="ルッフケープ", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%'}}


    --トレハン
    sets.TreasureHunter = {
        ammo="完璧な幸運の卵",
        body="ヴォルトジュポン",
        waist="チャークベルト"
    }


    --監視バフ
    sets.buff['机上演習']                           = { head="ＡＣボード+2",body="ＰＤガウン+3",waist="エンブラサッシュ",}
    sets.buff['電光石火の章']                       = { feet="ＰＤローファー+3"}
    sets.buff['疾風迅雷の章']                       = { feet="ＰＤローファー+3"}
    sets.buff['意気昂然の章']                       = { head="ＡＢボネット+2"}
    sets.buff['気炎万丈の章']                       = { head="ＡＢボネット+2"}
    sets.buff['令狸執鼠の章']                       = { hands="ＡＢブレーサー+2"}
    sets.buff['簡素清貧の章']                       = { legs="ＡＢパンツ+2"}
    sets.buff['勤倹小心の章']                       = { legs="ＡＢパンツ+2"}
    sets.buff['虚誘掩殺の策']                       = { feet="ＡＢローファー+2"}
    sets.buff['震天動地の章']                       = { 
   -- main="ハーミットワンド",
    main="マフィックカジェル",
    sub="チャンターシールド",
    ammo="ストンチタスラム+1",
    head={ name="ＡＭコイフ+1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}},
    body="ゼンディックローブ",
    hands="ＡＣブレーサー+3",
    legs="ピンガズボン+1",
    feet="ＡＣローファー+4",
    neck="オルンミラトルク",
    waist="エンブラサッシュ",
    left_ear="ディグニタリピアス",
    right_ear="エテオレートピアス",
    left_ring="シーリチリング+1",
    right_ring="シーリチリング+1",
    back={ name="ルッフケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	} 
    
    
    --アビ着替え
    sets.precast.JA['連環計']                       = { legs="ＰＤパンツ+3"}
    sets.precast.JA['白のグリモア']                 = { }
    sets.precast.JA['黒のグリモア']                 = { }
    sets.precast.JA['戦術魔道書']                   = { }
    sets.precast.JA['机上演習']                     = { }
    sets.precast.JA['以逸待労の計']                 = { }
    sets.precast.JA['大悟徹底']                     = { body="ＰＤガウン+3"}
    sets.precast.JA['ライブラ']                     = { }
    sets.precast.JA['カペルエミサリウス']           = { }

    
    --待機装備（通常）
    sets.idle = {
    ammo="ストンチタスラム+1",
    head="ＡＢボネット+2",
    body="ＡＢガウン+2",
    hands="ニャメガントレ",
    legs="ＡＢパンツ+2",
    feet="ニャメソルレット",
    neck="ロリケートトルク+1",
    waist="キャリアーサッシュ",
    left_ear="アレテデルルナ+1",
    right_ear="アスプロピアス",
    left_ring="メフィタスリング+1",
    right_ring="シュネデックリング",
        back=gear.JobMantle.Idle,
    }


    --待機装備（リフレ）
    sets.idle.Refresh = {
        ammo="ストンチタスラム+1",
        head="ニャメヘルム",
        body="ニャメメイル",
        hands="ニャメガントレ", 
        legs="ニャメフランチャ", 
        feet="ニャメソルレット", 
        neck="シビルスカーフ",
        waist="無の腰当",
        left_ear="マリグナスピアス",
        right_ear="アスプロピアス",
        left_ring="スティキニリング+1",
        right_ring="シュネデックリング",
        back=gear.JobMantle.Idle,
    }

    --待機装備（↓精霊魔法）
    sets.idle.seirei = {
	main="ブンジロッド",
    sub="アムラピシールド",
    }

    --待機装備（↓計略魔法）
    sets.idle.keiryaku = {
    main="ブンジロッド",
    sub="カルミナス",
    }

    --待機装備（↑装備戻し）
    sets.idle.modoshi = {
    main={ name="ムサ", augments={'Path: C',}},
    sub="コーンスー",
    }

    --抜刀装備（通常）
    sets.engaged = {
--    main="マフィックカジェル",
--    sub="玄冥盾",
    ammo="サピエンスオーブ",
    head={ name="マーリンフード", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+15',}},
    body="ゼンディックローブ",
    hands="ＡＣブレーサー+3",
    legs="ピンガズボン+1",
    feet="ＡＣローファー+4",
    neck="オルンミラトルク",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ロケイシャスピアス",
    left_ring="キシャールリング",
    right_ring="メランリング",
    }


    --FC
    sets.precast.FC = {
    main="ムサ",
	sub="コーンスー",
    ammo="サピエンスオーブ",
    head={ name="マーリンフード", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+15',}},
    body="ＡＢガウン+2",
    hands="ＡＣブレーサー+3",
    legs="アグゥスロップス",
    feet="ＡＣローファー+4",
    neck="オルンミラトルク",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="アスプロピアス",
    left_ring="キシャールリング",
    right_ring="メランリング",
    back=gear.JobMantle.Idle,
    }

    
    --FC（黒のグリモア・震天用）
    --黒のロックスタイルと同じ片手棍＋盾にして、着替えの点滅で連携のエフェクトが消えないようにする
    --（両手棍のムサに持ち替えると見た目が変わって点滅する）。SCH.lua の job_post_precast で着る
    --FC合計80%（サポなしのジェールでも上限）＋ＡＣローファー+4のグリモア中の詠唱時間-12%
    sets.precast.FC.Black = {
    main="マフィックカジェル",
    sub="チャンターシールド",
    ammo="サピエンスオーブ",
    head={ name="マーリンフード", augments={'"Fast Cast"+7','MND+10','"Mag.Atk.Bns."+15',}},
    body="マーリンジュバ",
    hands="ＡＣブレーサー+3",
    legs="ピンガズボン+1",
    feet="ＡＣローファー+4",
    neck="オルンミラトルク",
    waist="エンブラサッシュ",
    left_ear="マリグナスピアス",
    right_ear="ロケイシャスピアス",
    left_ring="キシャールリング",
    right_ring="ラハブリング",
    back=gear.JobMantle.Idle,
    }

    --FC（黒のグリモア・震天用 / FCが余るとき）
    --サポ赤の特性FCで上限80%を超えるときは、耳と指を震天中の装備（モクシャ）と同じにする
    --外すFC: ロケイシャ2 + キシャール4 + ラハブ2 = 8 → 装備のFCは72%
    sets.precast.FC.BlackSurplus = set_combine(sets.precast.FC.Black, {
    left_ear="ディグニタリピアス",
    right_ear="マリグナスピアス",
    left_ring="シーリチリング+1",
    right_ring="シーリチリング+1",
    })

    --上の2セットの装備FC（%）。SCH.lua でサポの特性FCと足して80%に届くか判定する
    fc_gear_value = {Black = 80, BlackSurplus = 72}


    --FC（ディスペガ用）
    sets.precast.FC['ディスペガ'] = set_combine( sets.precast.FC,{main="デイブレイクワンド",})


    --FC（インパクト用）
    sets.precast.FC['インパクト'] = set_combine( sets.precast.FC,{head=empty,body="トワイライトプリス",})


    --WSダメージ
    sets.precast.WS.Damage = {
        ammo="コイストボダー",
        head="ニャメヘルム",
        body="ニャメメイル",
        hands="ニャメガントレ", 
        legs="ニャメフランチャ", 
        feet="ニャメソルレット", 
        neck="コンバタントトルク",
        waist={ name="セールフィベルト+1", augments={'Path: A',}},
        left_ear={ name="胡蝶のイヤリング", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear="テロスピアス",
        left_ring="シーリチリング+1",
        right_ring="シーリチリング+1",
        back="無の外装",
    }


    --WS魔攻
    sets.precast.WS.Magic = {
        ammo={ name="ガストリタスラム+1", augments={'Path: A',}},
        head="ニャメヘルム",
        body="ニャメメイル",
        hands="ニャメガントレ", 
        legs="ニャメフランチャ", 
        feet="ニャメソルレット", 
        neck={ name="アギュトストール+2", augments={'Path: A',}},
        waist="スクリミルコード+1",
        left_ear="マリグナスピアス",
        right_ear="王将の耳飾り",
        left_ring="フレキリング",
        right_ring="コーネリアリング",
        back=gear.JobMantle.MGC ,
    }
    
	    sets.precast.WS["イオリアンエッジ"] = set_combine(sets.precast.WS.Magic,{
    ammo="オシャシャの原論文",
    waist="風輪の帯",
    left_ear="マリグナスピアス",
    right_ear="王将の耳飾り",
    left_ring="フレキリング",
    right_ring="コーネリアリング",
   }) 
	
	    sets.precast.WS["ミルキル"] = set_combine(sets.precast.WS.Magic,{
    ammo="ストンチタスラム+1",
    head="ＰＤボード+4",
    body="ＰＤガウン+3",
    hands="ＰＤブレーサー+3",
    legs={ name="アマリクスロップス", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}},
    feet="ＡＢローファー+2",
    neck="サンクトネックレス",
    waist="神術帯+1",
    left_ear="エテオレートピアス",
    right_ear="ロケイシャスピアス",
    left_ring="メフィタスリング+1",
    right_ring="メランリング",
    back={ name="ルッフケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
   })
   
    
    --共通WS定義読み込み
    init_weapon_skill()

    
    --弱体魔法
    sets.midcast['弱体魔法'] = {
    main={ name="ムサ", augments={'Path: C',}},
    sub="コーンスー",
    ammo="ペムフレドタスラム",
    head="ＡＢボネット+2",
    body="ＡＢガウン+2",
    hands="ＡＣブレーサー+3",
    legs={ name="カイロンホーズ", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+9',}},
    feet="ＡＢローファー+2",
    neck={ name="アギュトストール+2", augments={'Path: A',}},
    waist="無の腰当",
    left_ear="マリグナスピアス",
    right_ear="王将の耳飾り",
    left_ring="キシャールリング",
    right_ring="スティキニリング+1",
    back={ name="オリストケープ+1", augments={'Path: A',}},
    }


    --ディスペガ
    sets.midcast['ディスペガ'] = set_combine(sets.midcast['弱体魔法'],{
        main="デイブレイクワンド",
        sub="アムラピシールド"
    })


    --インパクト
    sets.midcast['インパクト']  = set_combine(sets.midcast['弱体魔法'],{
        head=empty,body="トワイライトプリス",
    })
    
    
    --スタン
    sets.midcast['スタン']      = set_combine(sets.midcast['弱体魔法'],{
        ammo="ペムフレドタスラム"
    })


    --精霊魔法
    sets.midcast['精霊魔法'] = {
--    main="オパショーロ",
--    sub="エンキストラップ",
    main="ブンジロッド",
    sub="アムラピシールド",
    ammo="ガストリタスラム+1",
    head="ＰＤボード+4",
    --body="アグゥローブ",
	body="ＡＢガウン+2",
    --hands="アグゥゲージ",
	hands="ＡＢブレーサー+2",
    legs="アグゥスロップス",
    feet="ＡＢローファー+2",
    neck={ name="アギュトストール+2", augments={'Path: A',}},
    waist="八輪の帯",
    left_ear="マリグナスピアス",
    right_ear="王将の耳飾り",
    left_ring="メタモルリング+1",
    right_ring="フレキリング",
    back="オリストケープ+1",
    }
    
    
    --低位精霊魔法
    sets.midcast['精霊魔法'].weak = set_combine(sets.midcast['精霊魔法'],{
    })
    
    
    --メルトン
    sets.midcast['メルトン'] =  set_combine(sets.midcast['精霊魔法'],{
	main="ブンジロッド",
    sub="アムラピシールド",
    ammo="ガストリタスラム+1",
    head="ＡＢボネット+2",
    body="アグゥローブ",
    hands="アグゥゲージ",
    legs="アグゥスロップス",
    feet="ＡＢローファー+2",
    neck={ name="アギュトストール+2", augments={'Path: A',}},
    waist="闇輪の帯",
    left_ear="王将の耳飾り",
    right_ear={ name="アバテルピアス+1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+13','Enmity-3',}},
    left_ring="メタモルリング+1",
    right_ring="アルコンリング",
	back=gear.JobMantle.MGC,
	})


    --計略系
    sets.midcast.Helix = set_combine(sets.midcast['精霊魔法'] ,{
    main="ブンジロッド",
    sub="カルミナス",
    ammo="ガストリタスラム+1",
    head="ＡＢボネット+2",
    body="ＡＢガウン+2",
    hands="ＡＢブレーサー+2",
    legs="アグゥスロップス",
    feet="ＡＢローファー+2",
    neck={ name="アギュトストール+2", augments={'Path: A',}},
    waist="スクリミルコード",
    left_ear="マリグナスピアス",
    right_ear="王将の耳飾り",
    left_ring="メタモルリング+1",
    right_ring="フレキリング",
    back={ name="ブックワームケープ", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
    })


    --光門の計II
    sets.midcast["光門の計II"] = set_combine(sets.midcast.Helix,{main="デイブレイクワンド"})


    --アスピル系
    sets.midcast.Aspir = set_combine(sets.midcast['精霊魔法'] ,{
        --main="ルビカンディティー",
    main="ブンジロッド",
    sub="アムラピシールド",
    ammo="ペムフレドタスラム",
    head="妖蟲の髪飾り+1",
    body="ＡＢガウン+2",
    hands="ＡＣブレーサー+3",
    legs="ＰＤパンツ+3",
    feet="アグゥピガッシュ",
    neck="エーラペンダント",
    waist="風鳥の帯",
    left_ear="マリグナスピアス",
    right_ear="王将の耳飾り",
    left_ring="エバネセンスリング",
    right_ring="アルコンリング",
    back={ name="ブックワームケープ", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
    })


    --ドレイン系
    sets.midcast.Drain = sets.midcast.Aspir


    --強化魔法
    sets.midcast['強化魔法'] = {
    main={ name="ムサ", augments={'Path: C',}},
    sub="コーンスー",
    ammo="ペムフレドタスラム",
    head={ name="テルキネキャップ", augments={'"Elemental Siphon"+35','Enh. Mag. eff. dur. +10',}},
    body="ＰＤガウン+3",
    hands="ＡＢブレーサー+2",
    legs={ name="テルキネブラコーニ", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="テルキネピガッシュ", augments={'Enh. Mag. eff. dur. +10',}},
    neck="ホクスニトルク",
    waist="エンブラサッシュ",
    left_ear="磁界の耳",
    right_ear="カラミタスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="メランリング",
    back={ name="ルッフケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    }

    
    --陣系
    sets.midcast.Storm = set_combine(sets.midcast['強化魔法'], {
	feet="ＰＤローファー+3",
	})


    --リジェネ
    sets.midcast.Regen = set_combine(sets.midcast['強化魔法'], {
    main={ name="ムサ", augments={'Path: C',}},
    sub="コーンスー",
    ammo="ペムフレドタスラム",
    head="ＡＢボネット+2",
    body={ name="テルキネシャジュブ", augments={'Enh. Mag. eff. dur. +10',}},
    hands="ＡＢブレーサー+2",
    legs={ name="テルキネブラコーニ", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="テルキネピガッシュ", augments={'Enh. Mag. eff. dur. +10',}},
    neck="ホクスニトルク",
    waist="エンブラサッシュ",
    left_ear="磁界の耳",
    right_ear="カラミタスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="メランリング",
    back={ name="ブックワームケープ", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
	})


    --リフレシュ
    sets.midcast.Refresh = set_combine(sets.midcast['強化魔法'], {
    main={ name="ムサ", augments={'Path: C',}},
    sub="コーンスー",
    ammo="ペムフレドタスラム",
    head="ＡＭコイフ+1",
    body={ name="テルキネシャジュブ", augments={'Enh. Mag. eff. dur. +10',}},
    hands="ＡＢブレーサー+2",
    legs={ name="テルキネブラコーニ", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="テルキネピガッシュ", augments={'Enh. Mag. eff. dur. +10',}},
    neck="ホクスニトルク",
    waist="エンブラサッシュ",
    left_ear="磁界の耳",
    right_ear="カラミタスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="メランリング",
    back={ name="ブックワームケープ", augments={'INT+4','Helix eff. dur. +20','"Regen" potency+4',}},
	})


    --バ系
    sets.midcast.BarElement = set_combine(sets.midcast['強化魔法'], {legs="シェダルサラウィル"})


    --ストンスキン
    sets.midcast['ストンスキン'] = set_combine(sets.midcast['強化魔法'], {legs="シェダルサラウィル",neck="ノデンズゴルゲット",left_ear="アースクライピアス",waist="ジーゲルサッシュ"})


    --アクアベール
    sets.midcast['アクアベール'] = set_combine(sets.midcast['強化魔法'], {
	main="バドースロッド",
    sub="アムラピシールド",
    ammo="ペムフレドタスラム",
    head={ name="ＡＭコイフ+1", augments={'INT+12','Mag. Acc.+25','Enmity-6',}},
    body="ＰＤガウン+3",
    hands="ＡＢブレーサー+2",
    legs="シェダルサラウィル",
    feet={ name="テルキネピガッシュ", augments={'Enh. Mag. eff. dur. +10',}},
    neck="ロリケートトルク+1",
    waist="エンパチコスロープ",
    left_ear="磁界の耳",
    right_ear="カラミタスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="メランリング",
    back={ name="ルッフケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	})
      
    
    --ケアル
    sets.midcast.Cure = {
    main={ name="ムサ", augments={'Path: C',}},
    sub="コーンスー",
    ammo="ストンチタスラム+1",
    head={ name="ヴァニヤフード", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
    body="ＡＢガウン+2",
    hands="ＰＤブレーサー+3",
    legs="ピンガズボン+1",
    feet={ name="ケカスブーツ+1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
	neck="ノデンズゴルゲット",
    waist="神術帯+1",
    left_ear="メンデカントピアス",
    right_ear="カラミタスピアス",
    left_ring="ゼラチナスリング+1",
    right_ring="レベッチェリング",
    back={ name="ルッフケープ", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
    }
    
    --カーズナ
    sets.midcast.Cursna={
        hands="ヒエロスミトン",
        feet="ＧＥガロッシュ+1",
        neck="デビリスメダル",
        left_ring="メネロスリング",
        right_ring="ハオマリング",
        back="オレタニアケープ+1",
    }
end
