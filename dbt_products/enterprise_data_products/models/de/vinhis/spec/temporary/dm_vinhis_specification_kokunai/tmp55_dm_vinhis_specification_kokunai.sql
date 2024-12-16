-- データ結合５５
with
    tmp50 as (select * from {{ ref('tmp50_dm_vinhis_specification_kokunai') }}),
    syaryo_index as (
        select
            syadai_kt, -- フレーム区分
            frmno, -- フレームNo
            hanbai_kt -- 販売型式
        from {{ref('stg_syaryoindex')}} -- 車両INDEX
    )
select
    tmp50.* exclude(hkata), 
    -- tmp50の販売型式がNULLの場合、車両INDEXの販売型式を選択する
    coalesce(tmp50.hkata, syaryo_index.hanbai_kt) as hkata
from tmp50
left outer join syaryo_index
  on tmp50.syadai_kt = syaryo_index.syadai_kt
 and tmp50.frmno = syaryo_index.frmno