with nokikaito as (
    select
        *,
        (m_syukkaymd + m_keikanissu)::varchar(8) as m_hntotime,
        case
            when m_boskstime <> ''
                then
                    '1'
                else
                    '0'
        end m_boflg
    from {{ ref('dm_hosyuhin_juchunoki_kaito') }}
),
juhattyu as (
    select * exclude(kyouhan, siten),
        concat(kyouhan, siten) dlrcd
    from {{ref('dm_hosyuhin_tmp_juhattyuuriage')}}
    where tkskbn in ('1', '3', '4')
)
select
    case
        when
            try_to_date(nokiymd, 'yyyyMMdd') <= try_to_date(shitei, 'yyyyMMdd') -- (TMP)納期日が(販売店)納期指定日以前の場合
        then
            case
                when
                    jchusu <= syukkei --(TMP)出庫数が(TMP)受注数以上である場合
                then
                    '◯'
                else -- (TMP)出庫数が(TMP)受注数未満である場合
                    '未判定'
            end
        when
            try_to_date(nokiymd, 'yyyyMMdd') > try_to_date(shitei, 'yyyyMMdd') -- (TMP)納期日が(販売店)納期指定日より未来日の場合
        then
            '✕'
        else -- 上記に該当しない場合
            '未判定'
    end tmp_nokijunsyu, --[TMP]納期遵守
    case
        when
            try_to_date(nokiymd, 'yyyyMMdd') <= try_to_date(shitei, 'yyyyMMdd') --(TMP)納期日が(販売店)納期指定日以前の場合
        then
            case
                when
                    jchusu <= syukkei -- (TMP)出庫数が(TMP)受注数以上である場合
                then
                    3
                else -- (TMP) 出庫数が(TMP)受注数未満である場合
                    2
            end
        when
            try_to_date(nokiymd, 'yyyyMMdd') > try_to_date(shitei, 'yyyyMMdd') -- (TMP)納期日が(販売店)納期指定日より未来日の場合
        then
            1
        else -- 上記に該当しない場合
            2
    end tmp_nokijunsyu_priority, --[TMP]納期遵守（ソート優先度）
    case
        when
            try_to_date(nokiymd, 'yyyyMMdd') is not null
            and try_to_date(shitei, 'yyyyMMdd') is not null
        then
            datediff(
                day, try_to_date(shitei, 'yyyyMMdd'), try_to_date(nokiymd, 'yyyyMMdd')
            )
        else
            null
    end tmp_nokiokuredays, --[TMP]納期差
    case
        when
            try_to_date(m_hntotime, 'yyyyMMdd') <= try_to_date(nyukayd, 'yyyyMMdd') --(メーカー)TMP到着日（推定）が（TMP）納入予定日以前の場合
        then
            case
                when
                    m_juchusu <= m_syukkasu -- （メーカー）出荷数が（メーカー）受注数以上である場合
                then
                    '◯'
                else -- (メーカー)出荷数が（メーカー）受注数未満である場合
                    '未判定'
            end
        when
            try_to_date(m_hntotime, 'yyyyMMdd') > try_to_date(nyukayd, 'yyyyMMdd') -- (メーカー)TMP到着日（推定）が（TMP）納入予定日より未来日の場合
        then
            '✕'
        else -- 上記に該当しない場合
            '未判定'
    end m_nokijunsyu, --参考[メーカー]納期遵守（推定）
    case
        when
            try_to_date(m_hntotime, 'yyyyMMdd') <= try_to_date(nyukayd, 'yyyyMMdd') -- (メーカー)TMP到着日（推定）が（TMP）納入予定日以前の場合
        then
            case
                when
                    m_juchusu <= m_syukkasu -- (メーカー)出荷数が（メーカー）受注数以上である場合
                then
                    3
                else -- (メーカー)出荷数が（メーカー）受注数未満である場合
                    2
            end
        when
            try_to_date(m_hntotime, 'yyyyMMdd') > try_to_date(nyukayd, 'yyyyMMdd') -- (メーカー)TMP到着日（推定）が（TMP）納入予定日より未来日の場合
        then
            1
        else -- 上記に該当しない場合
            2
    end m_nokijunsyu_priority, --参考[メーカー]納期遵守（ソート優先度）
    case
        when
            try_to_date(m_hntotime, 'yyyyMMdd') is not null
            and try_to_date(nyukayd, 'yyyyMMdd') is not null
        then
            datediff(
                day,
                try_to_date(m_hntotime, 'yyyyMMdd'),
                try_to_date(nyukayd, 'yyyyMMdd')
            )
        else
            null
    end m_nokiokuredays, --参考[メーカー]納期差（推定）
    m_boflg, --[メーカー]BO無
    hanbaiten, --販売店コード
    usercd, --お客様コード
    kjusrnm, --お客様名
    dlrcd, --仕向先コード
    smkmeijpjh, --仕向先名本部
    smkmeijpjs, --仕向先名支社
    jdenno, --販売店-TMP注文No.
    jchuymd, --[TMP]受注日
    hinban, --[TMP]受注品番
    jchusu, --[TMP]受注数
    pname, --品番名称
    honbuigai, --[TMP]納期指定本部以外出庫対象
    kakuhositei, --[TMP]在庫確保タイミング指定対象
    chuzan_hachuymd hchuymd, --[TMP]メーカー発注日
    m_syubetsu m_ordesybt, --[TMP]オーダー種別
    makercd, --[TMP]メーカーコード
    tkskbn m_tkskbn, --[メーカー]一般直送区分
    chumon, --TMP-メーカー注文No.
    m_juchuymd, --[メーカー]受注日
    m_jhinban, --[メーカー]受注品番
    m_juchusu, --[メーカー]受注数
    m_bosu, --[メーカー]B/O数
    m_martflg, --[トヨタ]マル超FLG
    m_ptopflg, --[トヨタ]PTOPFLG
    m_shinban, --[メーカー]出荷品番
    m_iphonyoyakuymd m_iphonyoyakubi, --[トヨタ]IP本予約日
    m_hnhonyoyakuymd m_honyoyakubi, --[トヨタ]本予約日（最新）
    m_nokishiteiyoyakuymd m_noshiyoteibi, --[トヨタ]納指予約日
    m_hskkbn, --[メーカー]回答区分（BO時点）
    m_hsnoytime, --[メーカー]納入予定日（BO時点）
    m_hstaytime, --[メーカー]棚入予定日（BO時点）
    m_hssyytime, --[メーカー]出荷予定日（BO時点）
    m_hstoytime, --[メーカー]TMP到着予定日（BO時点）
    m_hokkbn, --[メーカー]回答区分（前回）
    m_honoytime, --[メーカー]納入予定日（前回）
    m_hotaytime, --[メーカー]棚入予定日（前回）
    case
        when
            m_honksyytime is not null
        then
            m_honksyytime
        when
            m_honksyytime is null
            and m_hosyytime is not null
        then
            m_hosyytime
        else
            null
    end m_hosyytime, --[メーカー]出荷予定日（前回）
    m_hotoytime, --[メーカー]TMP到着予定日（前回）
    m_mkaitocd, --[メーカー]未回答CD
    m_hnkkbn, --[メーカー]回答区分（最新）
    m_hnnoytime, --[メーカー]納入予定日（最新）
    m_hntaytime, --[メーカー]棚入予定日（最新）
    m_ipsyytmie, --[トヨタ]インプット出荷予定日
    case
        when
            m_hnnksyytime is not null
        then
            m_hnnksyytime
        when
            m_hnnksyytime is null
            and m_hnsyytime is not null
        then
            m_hnsyytime
        else
            null
    end m_hnsyytime, --[メーカー]出荷予定日（最新）
    m_hntoytime, --[メーカー]TMP到着予定日（最新）
    m_hnskiboymd m_saishinsyukkakiboubi, --[TMP]トヨタ出荷希望日（最新）
    m_hsskiboymd m_syokaisyukkakiboubi, --[TMP]トヨタ出荷希望日（初回）
    m_hoskiboymd m_zenkaisyukkakiboubi, --[TMP]トヨタ出荷希望日（前回）
    m_syukkaymd, --[メーカー]出荷日
    m_syukkasu, --[メーカー]出荷数
    m_keikanissu, --輸送LT（推定）
    m_hntotime, --[メーカー]TMP到着日（推定）
    hkkanymd tyakukiboymd, --[TMP]メーカー到着希望日
    nyukayd nonyuyoteiymd, --[TMP]納入予定日
    nyukoymd, --[TMP]入庫日
    ndasiymd syukkoymd, --[TMP]出庫日
    syukkei syukkosu, --[TMP]出庫数
    syukayotei_min, --[TMP]出荷予定日（初回）
    syukayoteibinno_min, --[TMP]出荷予定日便No（初回）
    syukayotei_prev, --[TMP]出荷予定日（前回）
    syukayoteibinno_prev, --[TMP]出荷予定日便No（前回）
    syukayotei_max, --[TMP]出荷予定日（最新）
    syukayoteibinno_max, --[TMP]出荷予定日便No（最新）
    syuka syukkayoteiymd, --[TMP]出荷予定日
    '' as syukkaymd, --*[TMP]出荷日
    nokiymd, --[TMP]納期日
    shitei, --[販売店]納期指定日
    m_kaknoukbn, --[トヨタ]格納拠点区分
    m_thibusyocd, --[トヨタ]手配部署コード
    m_thitatocd, --[トヨタ]手配担当者コード
    m_tehaikbn, --[トヨタ]手配区分
    m_rimak1, --[トヨタ]リマークⅰ
    m_rimak2, --[トヨタ]リマークⅱ
    m_pendid, --[トヨタ]ペンディングID
    m_pensu, --[トヨタ]ペンディング数
    m_pentime, --[トヨタ]ペンディング日時
    m_skzflg, --[トヨタ]出荷済FLG
    m_canzmflg, --[トヨタ]キャンセル済FLG
    m_skibohenkokaisu, --[トヨタ]出荷希望日変更回数
    m_hshonyoyakuymd, --[トヨタ]本予約日（初回）
    m_allnosicansu, --[トヨタ]キャンセル数量（総量）
    m_hnnosicansu, --[トヨタ]キャンセル数量（最新）
    m_hnnosicantime, --[トヨタ]キャンセル日時（最新）
    m_honosicantime, --[トヨタ]キャンセル日時（前回）
    m_hsnosicantime, --[トヨタ]キャンセル日時（初回）
    m_nosicankaisu, --[トヨタ]キャンセル回数
    m_kariyoyakuymd, --[トヨタ]仮予約日
    m_hnnosikbn, --[トヨタ]納指状態区分（最新）
    m_hsnosikbn, --[トヨタ]納指状態区分（初回）
    m_honosikbn, --[トヨタ]納指状態区分（前回）
    case
        when
            m_juchusu is not null and m_allnosicansu is not null
        then
            m_juchusu - m_allnosicansu
        when
            m_juchusu is not null and m_allnosicansu is null
        then
            m_juchusu
     else null
    end m_cannosizansu, --[メーカー]キャンセル後残数
    case
        when
            m_hsnksyytime is not null
        then
            m_hsnksyytime 
        when
            m_hsnksyytime is null
            and m_hssyytime is not null
        then
            m_hssyytime
        else
            null
    end m_hsnksyytime, --[メーカー]出荷予定日（初回）
    case
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') <= try_to_date(m_hnskiboymd, 'yyyyMMdd')
        then
            '◯'
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') > try_to_date(m_hnskiboymd, 'yyyyMMdd')
        then
            '✕'
        else
            '未判定'
    end m_kiboujunsyu, --[トヨタ]出荷希望日遵守
    case
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') <= try_to_date(m_hnskiboymd, 'yyyyMMdd')
        then
            '3'
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') > try_to_date(m_hnskiboymd, 'yyyyMMdd')
        then
            '1'
        else
            '2'
    end m_kiboujunsyu_priority, --[トヨタ]出荷希望日遵守（ソート優先度）
    case
        when
            m_syukkaymd is not null
            and m_hnskiboymd is not null
        then
            datediff(
                day,
                try_to_date(m_syukkaymd, 'yyyyMMdd'), 
                try_to_date(m_hnskiboymd, 'yyyyMMdd')
            )
        else
            null
    end m_kibouokuredays, --[トヨタ]出荷希望日差
    case
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') <= try_to_date(m_hsnksyytime, 'yyyyMMdd')
        then
            '◯'
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') > try_to_date(m_hsnksyytime, 'yyyyMMdd')
        then
            '✕'
        when
            try_to_date(m_hsnksyytime, 'yyyyMMdd') is null
        then
            '✕(初回未回答)'
        else
            '未判定'
    end m_hsnksyyjunsyu, --[トヨタ]初回回答遵守
    case
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') <= try_to_date(m_hsnksyytime, 'yyyyMMdd')
        then
            '3'
        when
            try_to_date(m_syukkaymd, 'yyyyMMdd') > try_to_date(m_hsnksyytime, 'yyyyMMdd')
        then
            '1'
        when
            try_to_date(m_hsnksyytime, 'yyyyMMdd') is null
        then
            '1'
        else
            '2'
    end m_hsnksyyjunsyu_priority, --[トヨタ]初回回答順守（ソート優先度）
    m_jurrsymd, --[トヨタ]受注リリース日
    m_srsirskcd, --[メーカー]商流仕入先CD
    m_kozyocd, --[メーカー]商流仕入先工場CD
    m_brsirskcd, --[メーカー]物流仕入先CD
    m_nonukyokbn, --[トヨタ]納入拠点区分
    m_ukeirecd, --[トヨタ]受入CD
    m_nonyutni, --[トヨタ]納入単位
    m_picloke, --[トヨタ]出庫ロケ
    m_sykikicd, --[トヨタ]職域CD
    m_sksijbsy, --[トヨタ]出庫指示場所
    m_zaihikbn, --[トヨタ]在非区分
    m_cycle4, --[トヨタ]サイクル
    m_kjnziknisu3, --[トヨタ]基準在庫日数
    m_kjnziksu, --[トヨタ]基準在庫数
    m_anzenzaikonisu, --[トヨタ]安全在庫日数
    m_anznzksu, --[トヨタ]安全在庫数
    m_nonyult, --[トヨタ]納入L/T
    m_nbscd, --[トヨタ]納入拠点CD
    m_orosibacd, --[トヨタ]降し場CD
    m_brsirskkojocd, --[トヨタ]物流仕入先工場CD
    m_pikcptime, --出庫完日
    m_paktime, --梱完日
    mkbn tmp_mkbn, -- （tmp）メーカー区分
    nyukkten tmp_nyukkten, -- （tmp）入庫拠点
    renban tmp_renban, -- （tmp）連番
    jchutime tmp_jchutime, -- （tmp）受注時間
    jdenno tmp_jdenno, -- （tmp）受注伝票№
    bokten tmp_bokten, -- （tmp）ｂ／ｏ管理拠点
    skankten tmp_skankten, -- （tmp）物流主管拠点
    inkten tmp_inkten, -- （tmp）入力拠点
    jchukbn tmp_jchukbn, -- （tmp）受注区分
    nouhkbn tmp_nouhkbn, -- （tmp）納品区分
    flnouhkbn tmp_flnouhkbn, -- （tmp）フォロー納品区分
    jtantou tmp_jtantou, -- （tmp）受注担当者
    utantou tmp_utantou, -- （tmp）お客様発注担当者
    denk tmp_denk, -- （tmp）伝区
    flcd tmp_flcd, -- （tmp）フォローコード
    remark1 tmp_remark1, -- （tmp）リマーク１
    remark2 tmp_remark2, -- （tmp）リマーク２
    riyuu tmp_riyuu, -- （tmp）理由コード
    kasyuu tmp_kasyuu, -- （tmp）加修先お客様コード
    hanf tmp_hanf, -- （tmp）販売店フラグ
    urikbn tmp_urikbn, -- （tmp）売上区分
    urisflg tmp_urisflg, -- （tmp）売上出庫フラグ
    genkacd tmp_genkacd, -- （tmp）原価コード
    pricekn tmp_pricekn, -- （tmp）ｋ／ｎ
    nouhbaik tmp_nouhbaik, -- （tmp）納品書売価
    tekibaik tmp_tekibaik, -- （tmp）適用売価
    pricelp tmp_pricelp, -- （tmp）ｌ／ｐ
    zanteikk tmp_zanteikk, -- （tmp）暫定価格フラグ
    kclas tmp_kclas, -- （tmp）価格クラス
    hinsij tmp_hinsij, -- （tmp）品番価格指示コード
    tanteki tmp_tanteki, -- （tmp）単価適用コード
    sshinmok tmp_sshinmok, -- （tmp）ｓｓ品目コード
    gaitoles tmp_gaitoles, -- （tmp）該当レスコード
    pkanflg tmp_pkanflg, -- （tmp）ピース換算フラグ
    bunricd tmp_bunricd, -- （tmp）分離強制コード
    nyutime tmp_nyutime, -- （tmp）入荷予定時間
    nyukayk tmp_nyukayk, -- （tmp）入荷予定日区分
    daihin tmp_daihin, -- （tmp）代替新品番
    daimkbn tmp_daimkbn, -- （tmp）代替新品番　メーカー区分
    hchuhzaikbn tmp_hchuhzaikbn, -- （tmp）発注引在区分
    noshi_hachuymd tmp_hchuymd, -- （tmp）発注日
    hisouktn tmp_hisouktn, -- （tmp）配送拠点
    syakptn tmp_syakptn, -- （tmp）集約パターン
    syakkbn tmp_syakkbn, -- （tmp）集約区分
    hbinno tmp_hbinno, -- （tmp）配達便№
    syukkbn tmp_syukkbn, -- （tmp）出庫区分
    syukktn tmp_syukktn, -- （tmp）出庫拠点
    nokiuri tmp_nokiuri, -- （tmp）納期指定売上日
    binno tmp_binno, -- （tmp）便№
    hkwatasitm tmp_hkwatasitm, -- （tmp）引渡時間
    nokikbn tmp_nokikbn, -- （tmp）納期区分
    hkkanymd tmp_hkkanymd, -- （tmp）ｂ／ｏ引当完了日（ｂ／ｏ処理日）
    hkkantime tmp_hkkantime, -- （tmp）ｂ／ｏ引当完了時間（ｂ／ｏ処理時間）
    syukknoymd tmp_syukknoymd, -- （tmp）出荷可能日
    syukknotime tmp_syukknotime, -- （tmp）出荷可能時間
    defkaito tmp_defkaito, -- （tmp）デフォルト回答フラグ
    syoriflg tmp_syoriflg, -- （tmp）処理済フラグ
    motokyouhan tmp_motokyouhan, -- （tmp）委託元共販店コード
    motousercd tmp_motousercd, -- （tmp）委託元お客様コード
    buturyuflg tmp_buturyuflg, -- （tmp）物流委託フラグ
    kakakuskb tmp_kakakuskb, -- （tmp）価格決定識別
    nokiknflg tmp_nokiknflg, -- （tmp）納期完了フラグ
    skbseq tmp_skbseq, -- （tmp）識別ｓｅｑ
    dainohin tmp_dainohin, -- （tmp）台当り納品方法
    dailblumu tmp_dailblumu, -- （tmp）台当りラベル有無
    noudaiseq tmp_noudaiseq, -- （tmp）納指台当りｓｅｑ
    bincount tmp_bincount, -- （tmp）便当り台数カウント
    binbinno tmp_binbinno, -- （tmp）便当り便№
    binsimet tmp_binsimet, -- （tmp）便当り締時間
    binsamcd tmp_binsamcd, -- （tmp）便当りサマリコード
    binsyuarer tmp_binsyuarer, -- （tmp）便当り出庫エリア
    jyurjflg tmp_jyurjflg, -- （tmp）受注時リジェクトフラグ
    tsyukymd tmp_tsyukymd, -- （tmp）tmc出荷日
    current_timestamp::TIMESTAMP_NTZ as ldts, -- dm作成時の時間
    jh.ldts as ldts_snapshot -- snapshot作成用
from juhattyu jh
left outer join nokikaito nk
on jh.dlrcd = nk.m_dlrcd
and jh.hinban = iff(jh.tkskbn = '4', nk.m_shinban, nk.m_jhinban)
and jh.chumon = nk.m_ordeno
and jh.chuzan_hachuymd = nk.m_juchuymd