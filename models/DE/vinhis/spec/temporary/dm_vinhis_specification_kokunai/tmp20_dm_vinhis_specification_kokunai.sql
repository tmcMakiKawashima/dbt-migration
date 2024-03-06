-- データ結合２
with
    tmp10 as (select * from {{ ref("tmp10_dm_vinhis_specification_kokunai") }}),
    koku200 as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレームNo
            sketa as sketa_cd, -- スペック桁
            skigo as skigo_cd -- スペック記号
        from {{ ref("stg_kokunaiseisan200") }} -- 国内生産実績 生産スペック200桁縦
    )
select
    tmp10.*,
    koku200.* exclude (syadai_kt, frmno)
from tmp10
left outer join koku200
  on tmp10.syadai_kt = koku200.syadai_kt
 and tmp10.frmno = koku200.frmno