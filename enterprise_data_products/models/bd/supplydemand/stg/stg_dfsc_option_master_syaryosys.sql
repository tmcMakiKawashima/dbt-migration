with stg_dfsc_option_master_syaryosys as (
    select
        dfsc::varchar(5) as dfsc,
        opt_cd::varchar(3) as opt_cd,
        cstmers_std_clss::varchar(1) as cstmers_std_clss,
        ldts,
        row_number() over (
            partition by 
                dfsc,opt_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb87') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb87') }})
)
select * exclude(aggkey)
from stg_dfsc_option_master_syaryosys
where aggkey = 1