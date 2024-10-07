-- データ結合４
with
    tmp30 as (select * from {{ ref('tmp30_dm_vinhis_specification_kokunai') }}),
    spec as (
        select
            syasyu, -- 車種コード
            sketa, -- スペック桁
            skigo, -- スペック記号
            trim(shiyosai) as shiyosai, -- 細目コード
            smeikana as sai_kana_name, -- スペック名称カナ
            smeieiji as sai_eiji_name, -- スペック名称英字
        from {{ ref('stg_specname') }} -- スペック名称
        where skigo <> ' '
    )
select
    tmp30.*,
    spec.* exclude (syasyu, sketa, skigo)
from tmp30
left outer join spec
  on tmp30.syasyu_cd = spec.syasyu
 and tmp30.sketa = spec.sketa
 and tmp30.skigo = spec.skigo