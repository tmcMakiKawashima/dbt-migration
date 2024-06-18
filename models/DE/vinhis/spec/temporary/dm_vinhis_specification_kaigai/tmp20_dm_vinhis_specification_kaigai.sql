-- データ結合２
with
    tmp10 as (select * from {{ ref('tmp10_dm_vinhis_specification_kaigai') }}),
    kai200 as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレームNo
            wmi, -- WMI
            vds, -- VDS
            mdlyr, -- モデルイヤー
            vin_vds_cd, -- VINチェックディジット
            sketa, -- スペック桁
            skigo -- スペック記号
        from {{ ref('stg_kaigaiseisan200') }} -- 海外生産実績 生産スペック200桁縦
    )
select
    tmp10.*,
    kai200.* exclude (syadai_kt, frmno, wmi, vds, mdlyr, vin_vds_cd)
from tmp10
left outer join kai200
  on tmp10.syadai_kt = kai200.syadai_kt
 and tmp10.frmno = kai200.frmno
 and tmp10.wmi = kai200.wmi
 and tmp10.vds = kai200.vds
 and tmp10.mdlyr = kai200.mdlyr
 and tmp10.vin_vds_cd = kai200.vin_vds_cd