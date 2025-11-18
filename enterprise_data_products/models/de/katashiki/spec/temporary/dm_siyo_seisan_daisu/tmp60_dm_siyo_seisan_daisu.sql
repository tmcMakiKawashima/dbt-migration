with mss as (
    select
        sno,     -- 仕様書NO
        syasyu,  -- 車種コード
        row_number() over(
            partition by sno
            order by mtdate desc
        ) as rnk
    from {{source('supplydemand_db_public','raw_stg_syasyu_siyousho')}}
  {% raw %}
    --from {{ref('stg_syasyu_siyousho')}}
  {% endraw %}
), ssua as (
    select
        carfamily as carfamily, -- 車種コード
        lodate as lodate, -- ラインオフ計画日
        spec as spec, -- スペック
        intcode as intcode, -- 内張コード
        extcode as extcode, -- 外鈑色コード
        destcode as destcode, -- 仕向地コード
        plantcode as plantcode, -- 工場コード
        pscexlk as pscexlk, -- PSC(外部連携用)
        idline as idline, -- アイデントライン
        ctlkata as ctlkata, -- コントロール型式
        sno as sno -- 仕様書NO
    from {{source('supplydemand_db_public','raw_stg_union_all_vehicle_specification_alc')}}
  {% raw %}
    --from {{ref('stg_union_all_vehicle_specification_alc')}}
  {% endraw %}
)
select
    coalesce(nullif(ssua.carfamily , ''), mss.syasyu) as syasyu,
    ssua.* exclude(carfamily)
from ssua
left join mss
on (
    ssua.sno = mss.sno
and mss.rnk = 1
)