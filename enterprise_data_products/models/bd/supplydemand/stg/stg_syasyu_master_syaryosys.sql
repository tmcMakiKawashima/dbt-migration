with stg_syasyu_master_syaryosys as (
    select
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        day_sesn_clss::varchar(1) as day_sesn_clss,
        slecar_flg::varchar(1) as slecar_flg,
        apitdt_prpt_obj_flg::varchar(1) as apitdt_prpt_obj_flg,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by carnm_cd, spec_no
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla038zz0kadcb81')}}
    where mtkbn = 'I'
    and ldts = (select max(ldts) from {{ref('substr_ktrla038zz0kadcb81')}})
)
select * exclude(aggkey)
from stg_syasyu_master_syaryosys
where aggkey = 1