with stg_knm_nrksortjun_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        kncode::varchar(7) as kncode,
        knmsortjun::number(5,0) as knmsortjun,
        tecs::varchar(1) as tecs,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shamei, sno, kncode
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa36f')}}
    where kbn = '1'
    and ldts = (select max(ldts) from {{ref('substr_tsjfa36f')}})
)
select * exclude(aggkey)
from stg_knm_nrksortjun_syaryosys
where aggkey = 1