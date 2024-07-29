-- データ結合３
with
    tmp20 as (
        select * from {{ref('tmp20_dm_vinhis_specification_oem')}}
    ),
    spec as (
        select
            syasyu, -- 車種コード
            sketa, -- スペック桁
            shiyodai, -- 大分類コード
            smeikanji, -- スペック名称漢字
            smeikana, -- スペック名称カナ
            smeieiji, -- スペック名称英字
        from {{ref('stg_specname')}} -- スペック名称
        where skigo = ' '
    )
select
    tmp20.*,
    spec.shiyodai,
    spec.smeikanji,
    spec.smeikana,
    spec.smeieiji
from tmp20
left outer join spec
    on tmp20.syasyu_cd = spec.syasyu
    and tmp20.sketa = spec.sketa