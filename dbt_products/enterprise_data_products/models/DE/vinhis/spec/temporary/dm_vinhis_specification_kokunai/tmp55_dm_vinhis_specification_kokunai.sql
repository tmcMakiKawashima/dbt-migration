-- データ結合５５
with
    tmp50 as (select * from {{ ref('tmp50_dm_vinhis_specification_kokunai') }}),
    syaryo_index as (
        select
            frame_cls, -- フレーム区分
            frame_no, -- フレームNo
            sales_katashiki -- 販売型式
        from {{source('vinhis_db_iqas','raw_dm_e010index')}} -- 車両INDEX
    )
select
    tmp50.* exclude(hkata), 
    -- tmp50の販売型式がNULLの場合、車両INDEXの販売型式を選択する
    coalesce(tmp50.hkata, syaryo_index.sales_katashiki) as hkata
from tmp50
left outer join syaryo_index
  on rtrim(tmp50.syadai_kt) = syaryo_index.frame_cls
 and tmp50.frmno = syaryo_index.frame_no