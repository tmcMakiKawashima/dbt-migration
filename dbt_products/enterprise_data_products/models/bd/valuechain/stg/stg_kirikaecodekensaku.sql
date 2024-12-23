with stg_kirikaecodekensaku as (
    select
        mntkbn::varchar(1) as mntkbn, 
        ctlgcd::varchar(6) as ctlgcd, 
        kiricd::varchar(4) as kiricd, 
        prtren::varchar(3) as prtren, 
        datakbn::varchar(1) as datakbn, 
        frmnok::varchar(20) as frmnok, 
        frmnom::varchar(20) as frmnom, 
        pltno::varchar(20) as pltno, 
        ldts, --B層取込日時
        rank() over (partition by ctlgcd, kiricd, prtren order by ldts desc) aggkey
    from {{ ref('substr_dv2a3704') }}
)
select * exclude(mntkbn, aggkey)
from stg_kirikaecodekensaku
where aggkey = 1 and mntkbn in ('C', 'U')