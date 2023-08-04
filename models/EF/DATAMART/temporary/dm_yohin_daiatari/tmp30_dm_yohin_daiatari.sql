with temp20 as (
    select * from {{ref('tmp20_dm_yohin_daiatari')}}
),
jutyunokikaito as(
    select * from {{ref('dm_yohin_juchunoki_kaito')}}
)
select
    TMP_NOKIJUNSYU, --[TMP]納期遵守
    TMP_NOKIJUNSYU_PRIORITY, --[TMP]納期遵守（ソート優先度）
    TMP_NOKIOKUREDAYS, --[TMP]納期差
    '' as M_NOKIJUNSYU,                --メーカー即納可否：TODO
    '' as M_NOKIJUNSYU_PRIORITY,       --メーカー納期遵守：TODO
    '' as M_NOKIOKUREDAYS,             --メーカー即納遅延日数:TODO
    --[メーカー]B/O有無
    CASE
        WHEN M_BOSKSTIME = '' THEN '0'
        ELSE '1'
    END M_BOFLG,
    HANBAITEN,  --販売店コード
    USERCD,     --お客様コード
    KJUSRNM,    --お客様名漢字
    KAISYA,     --会社コード
    SENTER,     --センター区分
    TENPO,      --店舗区分 
    TSHAMEI,    --車名コード
    HDKB,       --払出区分
    YOUTOKBN,   --用途区分
    FRMKB as FRMKBN,     --フレーム区分
    FRMNO,      --フレーム№
    HANKATA,    --販売型式
    '' as JUCHU_YMD, --車両受注日
    VLT_YMD,    --VLT出力日
    SK_YMD,     --終検日
    HIYTDD,     --配車予定日
    HAISYA_YMD, --配車日
    FTDD,       --振当日
    SHIMUKE_CD DLRCD,      --仕向先コード
    SMKMEIJPJH, --仕向先名本部
    SMKMEIJPJS, --仕向先名支社
    TCHUMON,    --トヨタ注文№
    JZNJUSIN as JUCHUYMD,--TMP受注日（事前情報受信日）
    HINBAN,     --品番
    JUTYUSU as JUCHUSU,    --TMP受注数（受注数量）
    PNAME,      --品番名称
    HATTYUHI as HACHUYMD,   --TMP発注日
    M_SYUBETSU as M_ORDESYBT, --メーカーオーダー種別
    MAKERCD,    --メーカーコード
    TKSKBN as M_TKSKBN,   --メーカー一般直送区分
    CHUMON,     --TMP-メーカー注文№
    M_JUCHUYMD, --メーカー受注日
    M_JHINBAN,  --メーカー受注品番
    -- M_JUCHUSU,  --メーカー受注数
    M_BOSU,     --メーカーBO数
    M_MARTFLG, -- メーカーマル超FLG
    -- M_PTOPFLG, -- メーカーPTOPFLG
    M_SHINBAN,  --メーカー出荷品番
    -- M_HSNOYTIME, -- メーカー初回納入予定日時
    -- M_HSTAYTIME, -- メーカー初回棚入予定日時
    M_HSSYYTIME,    --メーカー初回出荷予定日時
    -- M_HSTOYTIME, -- メーカー初回到着予定日時
    -- M_HONOYTIME, -- メーカー前回納入予定日時
    -- M_HOTAYTIME, -- メーカー前回棚入予定日時
    -- M_HSSYYTIME, -- メーカー前回出荷予定日時
    -- M_HSTOYTIME, -- メーカー前回到着予定日時
    M_HNNOYTIME,    --メーカー最新納入予定日時
    -- M_HNTAYTIME, -- メーカー最新棚入予定日時
    -- M_IPSYYTMIE, -- メーカーインプット出荷予定日時
    M_HNSYYTIME,    --メーカー最新出荷予定日時
    M_HNTOYTIME,    --メーカーTMP到着予定日（最新到着予定日時）
    M_SYUKKAYMD,    --メーカー出荷日
    M_SYUKKASU,     --メーカー出荷数
    -- M_KEIKANISSU, -- メーカー経過日数
    '' as M_HNTOTIME,   --TMP到着予定日
    ZAIKYOTE as NONYUYOTEIYMD,    --TMP納入予定日（在庫引当予定日）
    NYUKOYMD,       --TMP入庫日
    NYUKOSU,        --TMP入庫数
    SYUKKOYMD,      --TMP出庫日
    SYUKKOSU,  --TMP出庫数   
    '' as SYUKKAYMD,      --TMP出荷日
    TTYOTE as TTYOTEYMD,  --販売店当初着工予定日
    TYAKKO as TYAKKOYMD,  --販売店着工日（確定着工日）
    TOYTDD,     --登録予定日
    TODD,       --車両登録日
    NSQBDY,     --車両納車希望日
    NSDD,       --車両納車日
    M_KAKNOUKBN as M_KAKNOUKBN, --トヨタ格納拠点区分（メーカー格納拠点区分）
    M_THIBUSYOCD,   --トヨタ手配部署コード（メーカー手配担当部署CD）
    M_THITATOCD,    --トヨタ手配担当者コード（メーカー手配担当者CD）
    M_TEHAIKBN      --トヨタ手配区分（メーカー手配区分）
from temp20
left outer join jutyunokikaito
on SHIMUKE_CD = M_DLRCD -- 仕向先コード/メーカー仕向先CD
and HATUHINB = M_JHINBAN -- 発注品番/メーカー受注品番
and CHUMON = M_ORDENO -- 注文No/メーカー注文No
and HATTYUHI = M_JUCHUYMD -- 発注日/メーカー受注日
and ODERSYU = M_SYUBETSU -- オーダー種別/メーカーオーダー種別