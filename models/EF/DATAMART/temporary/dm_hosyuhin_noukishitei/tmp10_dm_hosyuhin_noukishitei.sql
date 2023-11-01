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
            try_to_date(nokiymd, 'yyyymmdd') <= try_to_date(shitei, 'yyyymmdd')
        then
            '◯'
        when
            try_to_date(nokiymd, 'yyyymmdd') > try_to_date(shitei, 'yyyymmdd')
        then
            '✕'
        else
            '未判定'
    end tmp_nokijunsyu, --[TMP]納期遵守
    case
        when
            try_to_date(nokiymd, 'yyyymmdd') <= try_to_date(shitei, 'yyyymmdd')
        then
            3
        when
            try_to_date(nokiymd, 'yyyymmdd') > try_to_date(shitei, 'yyyymmdd')
        then
            1
        else
            2
    end tmp_nokijunsyu_priority, --[TMP]納期遵守（ソート優先度）
    case
        when
            try_to_date(nokiymd, 'yyyymmdd') is not null
            and try_to_date(shitei, 'yyyymmdd') is not null
        then
            datediff(
                day, try_to_date(shitei, 'yyyymmdd'), try_to_date(nokiymd, 'yyyymmdd')
            )
        else
            null
    end tmp_nokiokuredays, --[TMP]納期差
    case
        when
            try_to_date(m_hntotime, 'yyyymmdd') <= try_to_date(nyukayd, 'yyyymmdd')
        then
            '◯'
        when
            try_to_date(m_hntotime, 'yyyymmdd') > try_to_date(nyukayd, 'yyyymmdd')
        then
            '✕'
        else
            '未判定'
    end m_nokijunsyu, --参考[メーカー]納期遵守（推定）
    case
        when
            try_to_date(m_hntotime, 'yyyymmdd') <= try_to_date(nyukayd, 'yyyymmdd')
        then
            '3'
        when
            try_to_date(m_hntotime, 'yyyymmdd') > try_to_date(nyukayd, 'yyyymmdd')
        then
            '1'
        else
            '2'
    end m_nokijunsyu_priority, --参考[メーカー]納期遵守（ソート優先度）
    case
        when
            try_to_date(m_hntotime, 'yyyymmdd') is not null
            and try_to_date(nyukayd, 'yyyymmdd') is not null
        then
            datediff(
                day,
                try_to_date(m_hntotime, 'yyyymmdd'),
                try_to_date(nyukayd, 'yyyymmdd')
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
    hchuymd, --[TMP]メーカー発注日
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
    nyukosu, --[TMP]入庫数
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
    iff(m_juchusu is null, 0 , m_juchusu)
    - iff(m_allnosicansu is null, 0, m_allnosicansu) m_cannosizansu, --[メーカー]キャンセル後残数
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
            try_to_date(m_syukkaymd, 'yyyymmdd') <= try_to_date(m_hnskiboymd, 'yyyymmdd')
        then
            '◯'
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') > try_to_date(m_hnskiboymd, 'yyyymmdd')
        then
            '✕'
        else
            '未判定'
    end m_kiboujunsyu, --[トヨタ]出荷希望日遵守
    case
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') <= try_to_date(m_hnskiboymd, 'yyyymmdd')
        then
            '3'
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') > try_to_date(m_hnskiboymd, 'yyyymmdd')
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
                try_to_date(m_syukkaymd, 'yyyymmdd'), 
                try_to_date(m_hnskiboymd, 'yyyymmdd')
            )
        else
            null
    end m_kibouokuredays, --[トヨタ]出荷希望日差
    case
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') <= try_to_date(m_hsnksyytime, 'yyyymmdd')
        then
            '◯'
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') > try_to_date(m_hsnksyytime, 'yyyymmdd')
        then
            '✕'
        when
            try_to_date(m_hsnksyytime, 'yyyymmdd') is null
        then
            '✕(初回未回答)'
        else
            '未判定'
    end m_hsnksyyjunsyu, --[トヨタ]初回回答遵守
    case
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') <= try_to_date(m_hsnksyytime, 'yyyymmdd')
        then
            '3'
        when
            try_to_date(m_syukkaymd, 'yyyymmdd') > try_to_date(m_hsnksyytime, 'yyyymmdd')
        then
            '1'
        when
            try_to_date(m_hsnksyytime, 'yyyymmdd') is null
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
    m_paktime --梱完日
from juhattyu jh
left outer join nokikaito nk
on jh.dlrcd = nk.m_dlrcd
and jh.hinban = iff(jh.tkskbn = '4', nk.m_shinban, nk.m_jhinban)
and jh.chumon = nk.m_ordeno
and jh.hchuymd = nk.m_juchuymd