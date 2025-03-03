with
    tmp20_dm_vinhis_yohin as ( select * from {{ ref('tmp20_dm_vinhis_yohin') }}),
    stg_yohinsotyakureki as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレームNO
            cdyouhinban -- 用品品番コード
        from {{ ref('stg_yohinsotyakureki') }} -- 用品装着歴
    )
    select
    tmp20_dm_vinhis_yohin.*,
    stg_yohinsotyakureki.* exclude (syadai_kt, frmno)
from tmp20_dm_vinhis_yohin
left outer join stg_yohinsotyakureki
  on tmp20_dm_vinhis_yohin.syadai_kt = stg_yohinsotyakureki.syadai_kt
 and tmp20_dm_vinhis_yohin.frmno = stg_yohinsotyakureki.frmno
