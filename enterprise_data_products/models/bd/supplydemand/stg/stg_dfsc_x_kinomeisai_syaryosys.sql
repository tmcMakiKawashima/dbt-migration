with stg_dfsc_x_kinomeisai_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        dfsc::varchar(5) as dfsc,
        kncode::varchar(7) as kncode,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shamei, sno, dfsc, kncode
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa36g')}}
    where ldts = (select max(ldts) from {{ref('substr_tsjfa36g')}})
)
select * exclude(aggkey)
from stg_dfsc_x_kinomeisai_syaryosys
where aggkey = 1