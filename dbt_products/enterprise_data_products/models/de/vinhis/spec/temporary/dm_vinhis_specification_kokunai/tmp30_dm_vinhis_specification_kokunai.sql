-- データ結合３
with
    tmp20 as (select * from {{ ref('tmp20_dm_vinhis_specification_kokunai') }}),
    spec as (
        select * from (
            select
                syasyu, -- 車種コード
                sketa, -- スペック桁
                shiyodai, -- 大分類コード
                smeikanji, -- スペック名称漢字
                smeikana as dai_kana_name, -- スペック名称カナ
                smeieiji as dai_eiji_name, -- スペック名称英字
                row_number() over(
                    partition by syasyu, sketa, shiyodai, smeikanji, dai_kana_name, dai_eiji_name
                    order by ldts) as aggkey
            from {{ ref('stg_specname') }} -- スペック名称
            where skigo = ' '
        )
        -- 先頭１レコード抽出条件
        where aggkey = 1
    )
select
    tmp20.*,
    spec.* exclude (syasyu, sketa, aggkey)
from tmp20
left outer join spec
  on tmp20.syasyu_cd = spec.syasyu
 and tmp20.sketa = spec.sketa