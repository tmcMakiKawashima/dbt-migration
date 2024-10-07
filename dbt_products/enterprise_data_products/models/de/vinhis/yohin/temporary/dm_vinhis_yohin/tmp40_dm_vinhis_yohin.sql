with
    tmp30 as (
        select * from {{ ref('tmp30_dm_vinhis_yohin') }}
    ),
    stg_goguchisyasyucd as (
        select
            syasyu_cd, -- 車種コード
            yohinsyamei -- 用品車名No
        from {{ ref('stg_goguchisyasyucd') }} -- 号口車種コード
    )
select
    tmp30.*,
    stg_goguchisyasyucd.yohinsyamei

from tmp30
left outer join stg_goguchisyasyucd
on tmp30.syasyu_cd = stg_goguchisyasyucd.syasyu_cd