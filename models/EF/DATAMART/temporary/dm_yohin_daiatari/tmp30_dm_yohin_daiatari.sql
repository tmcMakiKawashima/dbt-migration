with temp20 as (
    select * from {{ref('tmp20_dm_yohin_daiatari')}}
),
jutyunokikaito as(
    select * from {{ref('dm_yohin_juchunoki_kaito')}}
)
select
    tmp_nokijunsyu, --[tmp]納期遵守
    tmp_nokijunsyu_priority, --[tmp]納期遵守（ソート優先度）
    tmp_nokiokuredays, --[tmp]納期差
    '' as m_nokijunsyu,                --メーカー即納可否：todo
    '' as m_nokijunsyu_priority,       --メーカー納期遵守：todo
    '' as m_nokiokuredays,             --メーカー即納遅延日数:todo
    --[メーカー]b/o有無
    case
        when m_boskstime = '' then '0'
        else '1'
    end m_boflg,
    hanbaiten,  --販売店コード
    usercd,     --お客様コード
    kjusrnm,    --お客様名漢字
    kaisya,     --会社コード
    senter,     --センター区分
    tenpo,      --店舗区分 
    tshamei,    --車名コード
    hdkb,       --払出区分
    youtokbn,   --用途区分
    frmkb as frmkbn,     --フレーム区分
    frmno,      --フレーム№
    hankata,    --販売型式
    '' as juchu_ymd, --車両受注日
    vlt_ymd,    --vlt出力日
    sk_ymd,     --終検日
    hiytdd,     --配車予定日
    haisya_ymd, --配車日
    ftdd,       --振当日
    shimuke_cd dlrcd,      --仕向先コード
    smkmeijpjh, --仕向先名本部
    smkmeijpjs, --仕向先名支社
    tchumon,    --トヨタ注文№
    jznjusin as juchuymd,--tmp受注日（事前情報受信日）
    hinban,     --品番
    jutyusu as juchusu,    --tmp受注数（受注数量）
    pname,      --品番名称
    hattyuhi as hachuymd,   --tmp発注日
    m_syubetsu as m_ordesybt, --メーカーオーダー種別
    makercd,    --メーカーコード
    tkskbn as m_tkskbn,   --メーカー一般直送区分
    chumon,     --tmp-メーカー注文№
    m_juchuymd, --メーカー受注日
    m_jhinban,  --メーカー受注品番
    -- m_juchusu,  --メーカー受注数
    m_bosu,     --メーカーbo数
    m_martflg, -- メーカーマル超flg
    -- m_ptopflg, -- メーカーptopflg
    m_shinban,  --メーカー出荷品番
    -- m_hsnoytime, -- メーカー初回納入予定日時
    -- m_hstaytime, -- メーカー初回棚入予定日時
    m_hssyytime,    --メーカー初回出荷予定日時
    -- m_hstoytime, -- メーカー初回到着予定日時
    -- m_honoytime, -- メーカー前回納入予定日時
    -- m_hotaytime, -- メーカー前回棚入予定日時
    -- m_hssyytime, -- メーカー前回出荷予定日時
    -- m_hstoytime, -- メーカー前回到着予定日時
    m_hnnoytime,    --メーカー最新納入予定日時
    -- m_hntaytime, -- メーカー最新棚入予定日時
    -- m_ipsyytmie, -- メーカーインプット出荷予定日時
    m_hnsyytime,    --メーカー最新出荷予定日時
    m_hntoytime,    --メーカーtmp到着予定日（最新到着予定日時）
    m_syukkaymd,    --メーカー出荷日
    m_syukkasu,     --メーカー出荷数
    -- m_keikanissu, -- メーカー経過日数
    '' as m_hntotime,   --tmp到着予定日
    zaikyote as nonyuyoteiymd,    --tmp納入予定日（在庫引当予定日）
    nyukoymd,       --tmp入庫日
    nyukosu,        --tmp入庫数
    syukkoymd,      --tmp出庫日
    syukkosu,  --tmp出庫数   
    '' as syukkaymd,      --tmp出荷日
    ttyote as ttyoteymd,  --販売店当初着工予定日
    tyakko as tyakkoymd,  --販売店着工日（確定着工日）
    toytdd,     --登録予定日
    todd,       --車両登録日
    nsqbdy,     --車両納車希望日
    nsdd,       --車両納車日
    m_kaknoukbn as m_kaknoukbn, --トヨタ格納拠点区分（メーカー格納拠点区分）
    m_thibusyocd,   --トヨタ手配部署コード（メーカー手配担当部署cd）
    m_thitatocd,    --トヨタ手配担当者コード（メーカー手配担当者cd）
    m_tehaikbn,     --トヨタ手配区分（メーカー手配区分）
    temp20.ldts ldts -- snapshot作成用
from temp20
left outer join jutyunokikaito
on shimuke_cd = m_dlrcd -- 仕向先コード/メーカー仕向先cd
and hatuhinb = m_jhinban -- 発注品番/メーカー受注品番
and chumon = m_ordeno -- 注文no/メーカー注文no
and hattyuhi = m_juchuymd -- 発注日/メーカー受注日
and odersyu = m_syubetsu -- オーダー種別/メーカーオーダー種別