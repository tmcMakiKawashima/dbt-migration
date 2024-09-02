-- データ結合２
with
    tmp10 as (
        select * from {{ref('tmp10_dm_vinhis_specification_oem')}}
    ),
    oem200 as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレームNO
            sketa, -- スペック桁
            skigo, -- スペック記号
        from {{ref('stg_oemseisan200')}} -- 仕入実績生産スペック200桁縦
    )
select
    tmp10.*,
    oem200.sketa,
    oem200.skigo
from tmp10
left outer join oem200
    on tmp10.syadai_kt = oem200.syadai_kt
    and tmp10.frmno = oem200.frmno