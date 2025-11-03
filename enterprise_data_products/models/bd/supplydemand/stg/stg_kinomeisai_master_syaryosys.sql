with stg_kinomeisai_master_syaryosys as (
    select
        kncode::varchar(7) as kncode,
        sknmmei::varchar(20) as sknmmei,
        egymmei::varchar(20) as egymmei,
        sakusei_ymd::varchar(8) as sakusei_ymd,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by kncode
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa36i')}}
    where ldts = (select max(ldts) from {{ref('substr_tsjfa36i')}})
)
select * exclude(aggkey)
from stg_kinomeisai_master_syaryosys
where aggkey = 1