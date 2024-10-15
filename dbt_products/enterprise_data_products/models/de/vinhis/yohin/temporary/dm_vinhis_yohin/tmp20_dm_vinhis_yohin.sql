with
    tmp10_dm_vinhis_yohin as (
        select * from {{ ref('tmp10_dm_vinhis_yohin') }}
    ),
    stg_kokunaiseisan as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレーム連番
            syasyu_cd, -- 車種コード
            haisya_kt -- 配車型式
        from {{ ref('stg_kokunaiseisan') }} -- 国内生産実績
    )
select
    tmp10_dm_vinhis_yohin.*,
    stg_kokunaiseisan.syasyu_cd,
    stg_kokunaiseisan.haisya_kt
from tmp10_dm_vinhis_yohin
left outer join stg_kokunaiseisan
  on tmp10_dm_vinhis_yohin.syadai_kt = stg_kokunaiseisan.syadai_kt
 and tmp10_dm_vinhis_yohin.frmno = stg_kokunaiseisan.frmno