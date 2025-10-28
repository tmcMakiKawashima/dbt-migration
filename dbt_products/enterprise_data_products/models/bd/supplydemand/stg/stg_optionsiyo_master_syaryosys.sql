with stg_optionsiyo_master_syaryosys as (
    select
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        opt_cd::varchar(3) as opt_cd,
        opt_type::varchar(1) as opt_type,
        ldts,
        row_number() over (
            partition by 
                carnm_cd,spec_no,opt_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8o') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8o') }})
)
select * exclude(aggkey)
from stg_optionsiyo_master_syaryosys
where aggkey = 1