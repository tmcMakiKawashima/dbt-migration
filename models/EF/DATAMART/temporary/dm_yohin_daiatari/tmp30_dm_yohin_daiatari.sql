with temp20 as (
    select * from {{ref('tmp20_DM_YOHIN_DAIATARI')}}
    where TKSKBN in ('1', '3', '4')
),
jutyunokikaito as(
    select * from {{ref('DM_YOHIN_JUCHUNOKI_KAITO')}}
)
select
    TMP_NOKIJUNSYU,
    TMP_NOKIJUNSYU_PRIORITY,
    TMP_NOKIOKUREDAYS,
    '' as M_NOKIJUNSYU,                --メーカー即納可否：TODO
    '' as M_NOKIJUNSYU_PRIORITY,       --メーカー納期遵守：TODO
    '' as M_NOKIOKUREDAYS,             --メーカー即納遅延日数:TODO
    --B/Oフラグ
    CASE
        WHEN TKSKBN = '1' THEN
            CASE
                WHEN M_BOSKSTIME is not NULL THEN '1'
                ELSE '0'
            END
        WHEN TKSKBN = '3' or TKSKBN = '4' THEN
            CASE 
                WHEN M_BOSKSTIME is not NULL THEN '1'
                ELSE '0'
            END
        ELSE NULL
    END M_BOFLG,
    M_MARTFLG,
    TKSKBN M_TKSKBN,   --メーカー一般直送区分
    TCHUMON,    --販売店-TMP注文№
    CHUMON,     --TMP-メーカー注文№
    HANBAITEN,  --販売店コード
    USERCD,     --お客様コード
    KJUSRNM,    --お客様名
    KAISYA,     --お客様会社コード
    SENTER,     --お客様センター区分
    TENPO,      --お客様店舗区分 
    MAKERCD,    --メーカーコード
    SHIMUKE_CD DLRCD,      --仕向先コード
    SMKMEIJPJH, --仕向先名本部
    SMKMEIJPJS, --仕向先名支社
    HINBAN,     --品番
    PNAME,      --品番名称
    M_JHINBAN,  --メーカー受注品番
    M_SHINBAN,  --メーカー出荷品番
    TSHAMEI,    --車名コード
    HDKB,       --払い出し区分
    YOUTOKBN,   --用途区分
    FRMKB,     --フレーム区分
    FRMNO,      --フレーム№
    HANKATA,    --販売型式
    '' as V_JUTYUYMD, --車両受注日
    VLT_YMD,    --VLT出力日
    SK_YMD,     --終検日
    HIYTDD,     --配車予定日
    HAISYA_YMD, --配車日
    FTDD,       --振出日
    JUTYUSU JUCHUSU,    --TMP受注数
    JZNJUSIN JZNJUSINYMD,--TMP受注日
    HATTYUHI HACHUYMD,   --TMP発注日
    M_JUCHUYMD, --メーカー受注日
    ODERSYU M_ORDESYBT, --メーカーオーダー種別
    M_BOSU,     --メーカーBO数
    M_HNNOYTIME,    --メーカー納入予定
    M_HSSYYTIME,    --メーカー初回出荷予定日
    M_HNSYYTIME,    --メーカー最新出荷予定日
    M_SYUKKAYMD,    --メーカー出荷日
    M_SYUKKASU,     --メーカー出荷数
    M_HNTOYTIME,    --メーカーTMP到着予定日
    '' as M_HNTOTIME,   --TMP到着予定日 :TODO
    ZAIKYOTE NONYUYOTEIYMD,    --TMP納入予定日
    NYUKOYMD,       --TMP入庫日
    NYUKOSU,        --TMP入庫数
    SYUKKOYMD,      --TMP出庫日
    SYUKKOSU,  --TMP出庫数   
    '' as SYUKKAYMD,      --TMP出荷日
    TTYOTE TTYOTEYMD,  --販売店当初着工予定日
    TYAKKO TYAKKOYMD,  --販売店着工日
    TOYTDD,     --登録予定日
    TODD,       --車両登録日
    NSDD,       --車両納車日
    NSQBDY,     --車両納車希望日
    M_KAKNOUKBN M_KAKNOUKBN,    --トヨタ格納拠点区分
    M_THIBUSYOCD,   --トヨタ手配部署コード
    M_THITATOCD,    --トヨタ手配担当者コード
    M_TEHAIKBN      --トヨタ手配区分
from temp20
left outer join jutyunokikaito
on SHIMUKE_CD = M_DLRCD
and HATUHINB = M_JHINBAN
and CHUMON = M_ORDENO
and HATTYUHI = M_JUCHUYMD
and ODERSYU = M_SYUBETSU
