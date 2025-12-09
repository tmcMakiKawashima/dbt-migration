with stg_hanbaiseiyaku_master_syaryosys as (
    select
        dlr_cd::varchar(5) as dlr_cd,
        sle_model::varchar(30) as sle_model,
        ldts,
        row_number() over (
            partition by 
                dlr_cd,sle_model
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8b') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8b') }})
)
select * exclude(aggkey)
from stg_hanbaiseiyaku_master_syaryosys
where aggkey = 1