{{ config(snowflake_warehouse='DBT_WH') }}

-- データ結合３
with
    temp20 as (select * from {{ ref("tmp20_dm_tmc_ippan_jutyunokikaito") }}),
    temp20_tehai as (select * from {{ ref("tmp20_tehai_dm_tmc_ippan_jutyunokikaito") }})
select
    temp20.* exclude (
        kaknoukbn, -- 格納拠点区分
        jurrsymd, -- 受注リリース日
        srsirskcd, -- 商流仕入先CD
        kozyocd, -- 工場CD
        brsirskcd, -- 物流仕入先CD
        nonukyokbn, -- 納入拠点区分
        ukeirecd, -- 受入CD
        nonyutni, -- 納入単位
        picloke, -- 出庫ロケ
        sykikicd, -- 職域CD
        sksijbsy, -- 出庫指示場所（ラベル出力場所）
        check1_ordrkey, --オーダーキー nullチェック用
        check2_ordrkey, --オーダーキー nullチェック用
        check3_ordrkey --オーダーキー nullチェック用
    ),
    tehai.* exclude(
        dlrcd, -- 仕向先CD
        syubetsu, -- オーダー種別
        yusokbn, -- 輸送CD
        odrno, -- オーダーNo
        juchuymd, -- 受注日
        jhinban -- 受注品番
    )
from temp20
left outer join
    temp20_tehai tehai
    on temp20.dlrcd = tehai.dlrcd -- 仕向先CD
    and temp20.syubetsu = tehai.syubetsu -- オーダー種別
    and temp20.yusokbn = tehai.yusokbn -- 輸送CD
    and temp20.odrno = tehai.odrno -- オーダーNo
    and temp20.juchuymd = tehai.juchuymd -- 受注日
    and temp20.jhinban = tehai.jhinban -- 受注品番
