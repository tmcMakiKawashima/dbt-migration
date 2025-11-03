with stg_hanbaiten_toriatukai_syasyu_master_syaryosys as (
    select
        dlr_cd::varchar(5) as dlr_cd,
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        post_class::varchar(1) as post_class,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by dlr_cd, carnm_cd, spec_no
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla038zz0kadcb80')}}
    where mtkbn = 'I'
    and ldts = (select max(ldts) from {{ref('substr_ktrla038zz0kadcb80')}})
)
select * exclude(aggkey)
from stg_hanbaiten_toriatukai_syasyu_master_syaryosys
where aggkey = 1