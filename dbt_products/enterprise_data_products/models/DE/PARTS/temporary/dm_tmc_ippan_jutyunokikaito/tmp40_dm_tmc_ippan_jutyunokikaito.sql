{{ config(snowflake_warehouse='DBT_WH') }}

-- データ結合６
with
    temp30 as (select * from {{ ref("tmp30_dm_tmc_ippan_jutyunokikaito") }}),
    tehai_kanban as (
        select
            tyotathb, -- 調達品番
            kaknoukbn, -- 格納拠点区分
            tekiyokaisiymd, -- 適用開始日
            tekiyosyuryoymd, -- 適用終了日
            hinbankaisiymd, -- 品番適用開始日
            hinbansryoymd, -- 品番適用終了日
            tehaikaisiymd, -- 手配開始日
            tehaisryoymd, -- 手配終了日
            --
            thibusyocd, -- 手配担当部署CD
            thitatocd, -- 手配担当者CD
            tehaikbn, -- 手配区分
            zaihikbn, -- 在非区分
            cycle4, -- サイクル
            kjnziknisu3, -- 基準在庫日数
            kjnziksu, -- 基準在庫数
            anzenzaikonisu, -- 安全在庫日数
            anznzksu, -- 安全在庫数
            nonyult, -- 納入L/T
            nbscd, -- 納入拠点CD
            orosibacd, -- 降し場CD
            brsirskkojocd, -- 物流仕入先工場CD
            tyotathb as check_tyotathb --調達品番 nullチェック用
        from {{ ref("stg_dvsf509a") }} -- 手配かんばんマスタ
    ),
    syukkabin as (
        select 
            dlrcd, -- 仕向先CD
            syubetsu, -- オーダー種別
            yusokbn, -- 輸送区分
            max(keikanissu) keikanissu -- 経過日数
        from {{ ref("stg_cvn35dsyukabin") }} -- 出荷便TBL
        group by all
    )
select
    temp30.*,
    tehai.* exclude(
        tyotathb, -- 調達品番
        kaknoukbn, -- 格納拠点区分
        tekiyokaisiymd, -- 適用開始日
        tekiyosyuryoymd, -- 適用終了日
        hinbankaisiymd, -- 品番適用開始日
        hinbansryoymd, -- 品番適用終了日
        tehaikaisiymd, -- 手配開始日
        tehaisryoymd -- 手配終了日
    ),
    syukkabin.keikanissu, -- 経過日数
    syukkabin.dlrcd as check_dlrcd -- 仕向先コード nullチェック用
from temp30
left outer join
    tehai_kanban tehai
    on temp30.tehai_shinban = tehai.tyotathb -- 出荷品番(手配情報取得対象品番)/調達品番
    and temp30.kaknoukbn = tehai.kaknoukbn -- 格納拠点区分
    and temp30.juchuymd >= tehai.tekiyokaisiymd -- 受注日/適用開始日
    and temp30.juchuymd <= tehai.tekiyosyuryoymd -- 受注日/適用終了日
    and temp30.juchuymd >= tehai.hinbankaisiymd -- 受注日/品番適用開始日
    and temp30.juchuymd <= tehai.hinbansryoymd -- 受注日/品番適用終了日
    and temp30.juchuymd >= tehai.tehaikaisiymd -- 受注日/手配開始日
    and temp30.juchuymd <= tehai.tehaisryoymd -- 受注日/手配終了日
left outer join
    syukkabin
    on temp30.dlrcd = syukkabin.dlrcd -- 仕向先CD
    and temp30.syubetsu = syukkabin.syubetsu -- オーダー種別
    and iff(temp30.yusokbn = '1', '1', '*') = syukkabin.yusokbn -- 輸送区分
