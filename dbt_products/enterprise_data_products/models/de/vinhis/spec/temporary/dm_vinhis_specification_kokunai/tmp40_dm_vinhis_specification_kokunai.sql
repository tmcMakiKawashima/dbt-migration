-- データ結合４
with
    tmp30 as (select * from {{ ref('tmp30_dm_vinhis_specification_kokunai') }}),
    spec as (
        select * from (
            select
                syasyu, -- 車種コード
                shiyodai, -- 大分類コード
                sketa, -- スペック桁
                skigo, -- スペック記号
                trim(shiyosai) as shiyosai, -- 細目コード
                smeikana as sai_kana_name, -- スペック名称カナ
                smeieiji as sai_eiji_name, -- スペック名称英字
                row_number() over(
                    partition by syasyu, shiyodai, sketa, skigo, shiyosai, sai_kana_name, sai_eiji_name
                    order by ldts) as aggkey
            from {{ ref('stg_specname') }} -- スペック名称
            where skigo <> ' '
        )
        -- 先頭１レコード抽出条件
        where aggkey = 1
    )
select
    tmp30.*,
    spec.* exclude (syasyu, shiyodai, sketa, skigo, aggkey)
from tmp30
left outer join spec
  on tmp30.syasyu_cd = spec.syasyu
 and tmp30.shiyodai = spec.shiyodai
 and tmp30.sketa = spec.sketa
 and tmp30.skigo = spec.skigo