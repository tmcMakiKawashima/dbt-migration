with stg_kinomeisai_code_meisho_master_syaryosys as (
    select
        kncode::varchar(7) as kncode,
        sknmmei::varchar(60) as sknmmei,
        knmsortjun::number(1) as knmsortjun,
        creymd::varchar(8) as creymd,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by kncode
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla01dzz0kalc015')}}
    where ldts = (select max(ldts) from {{ref('substr_ktrla01dzz0kalc015')}})
)
select * exclude(aggkey)
from stg_kinomeisai_code_meisho_master_syaryosys
where aggkey = 1