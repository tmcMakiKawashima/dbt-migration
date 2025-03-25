with stg_katashikipattern as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(ctlgcd,' 　')::varchar(6) as ctlgcd, 
        rtrim(epckataptno,' 　')::varchar(6) as epckataptno, 
        rtrim(katano,' 　')::varchar(3) as katano, -- 右blank
        ldts, --B層取込日時
        line_number,
        rank() over (partition by ctlgcd, epckataptno, katano order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_dv2a3633') }}
)
select * exclude(aggkey, line_number, mntkbn)
from stg_katashikipattern
where aggkey = 1 and mntkbn in ('C', 'U')