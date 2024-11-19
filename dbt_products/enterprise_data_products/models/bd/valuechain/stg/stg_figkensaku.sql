with stg_figkensaku as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        rtrim(hinban,' 　')::varchar(12) as hinban, -- 右blank
        pnc::varchar(6) as pnc,
        figno::varchar(4) as figno,
        ldts, --B層取込日時
        line_number,
        rank() over (partition by ctlgcd, hinban, pnc, figno order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a353c') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_figkensaku
where aggkey = 1 and mntkbn in ('C', 'U')