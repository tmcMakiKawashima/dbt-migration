-- データ結合３
with
    tmp20 as (select * from {{ ref("tmp20_dm_vinhis_specification_kaigai") }}),
    spec as (
        select
            syasyu, -- 車種コード
            sketa, -- スペック桁
            shiyodai as daibun_cd, -- 大分類コード
            smeikanji as dai_kanji_name, -- スペック名称漢字
            smeikana as dai_kana_name, -- スペック名称カナ
            smeieiji as dai_eiji_name -- スペック名称英字
        from {{ ref("stg_specname") }} -- スペック名称
        where skigo = ' '
    )
select
    tmp20.*,
    spec.* exclude (syasyu, sketa)
from tmp20
left outer join spec
  on tmp20.syasyu_cd = spec.syasyu
 and tmp20.sketa_cd = spec.sketa