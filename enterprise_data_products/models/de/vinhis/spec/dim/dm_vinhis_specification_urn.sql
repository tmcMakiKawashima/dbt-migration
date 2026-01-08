{{ 
  config(
    materialized = 'incremental',
    incremental_strategy = 'append',
    pre_hook = "
      {% if is_incremental() %}
      {% endif %}
    "
  )
 }}
with tmp20 as (
    select
        coalesce(syasyu,'') as syasyu,              -- 車種コード
        coalesce(kata,'') as kata,                  -- 配車型式
        coalesce(spec,'') as spec,                  -- スペック
        coalesce(intcode,'') as intcode,            -- 内張コード
        int_cd_iromei,                              -- 内張色名
        coalesce(extcode,'') as extcode,            -- 外鈑色コード
        ext_cd_iromei,                              -- 外版色名
        coalesce(destcode,'') as dest_cd,           -- 仕向地コード
        r_country_name,                             -- 国名
        coalesce(plantcode,'') as plantcode,        -- 工場コード
        coalesce(enginekata,'') as enginekata,      -- エンジン型式
        coalesce(pscexlk,'') as pscexlk,            -- PSC(外部連携用)
        coalesce(idline,'') as idline,              -- アイデントライン
        coalesce(sk_y,'') as sk_y,                  -- 終検日年
        coalesce(sk_m,'') as sk_m                   -- 終検日月
    from {{ref('tmp20_dm_vinhis_specification_urn')}}
), tmpx1 as (
    select
        syasyu,                                     -- 車種コード
        kata,                                       -- 配車型式
        spec,                                       -- スペック
        spec200_siyou,                              -- SPEC対応4桁仕様
        intcode,                                    -- 内張コード
        int_cd_iromei,                              -- 内張色名
        extcode,                                    -- 外鈑色コード
        ext_cd_iromei,                              -- 外版色名
        dest_cd,                                    -- 仕向地コード
        r_country_name,                             -- 国名
        plantcode,                                  -- 工場コード
        enginekata,                                 -- エンジン型式
        pscexlk,                                    -- PSC(外部連携用)
        idline,                                     -- アイデントライン
        sk_y,                                       -- 終検日年
        sk_m                                        -- 終検日月
    from {{ref('tmpX1_dm_vinhis_specification_urn')}}
)
select
    tmp20.*,                                        -- tmp20の項目すべて
    tmpx1.spec200_siyou                             -- SPEC対応4桁仕様
from tmp20
left join tmpx1
on (
    tmp20.syasyu = tmpx1.syasyu
    and tmp20.kata = tmpx1.kata
    and tmp20.spec = tmpx1.spec
    and tmp20.intcode = tmpx1.intcode
    and tmp20.extcode = tmpx1.extcode
    and tmp20.dest_cd = tmpx1.dest_cd
    and tmp20.plantcode = tmpx1.plantcode
    and tmp20.enginekata = tmpx1.enginekata
    and tmp20.pscexlk = tmpx1.pscexlk
    and tmp20.idline = tmpx1.idline
    and tmp20.sk_y = tmpx1.sk_y
    and tmp20.sk_m = tmpx1.sk_m
)