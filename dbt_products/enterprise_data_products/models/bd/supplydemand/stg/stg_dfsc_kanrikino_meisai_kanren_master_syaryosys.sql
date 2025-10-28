with stg_dfsc_kanrikino_meisai_kanren_master_syaryosys as (
    select
        dfsc::varchar(5) as dfsc,
        funcdtl_cd::varchar(7) as funcdtl_cd,
        ldts,
        row_number() over (
            partition by 
                dfsc,funcdtl_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb86') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb86') }})
)
select * exclude(aggkey)
from stg_dfsc_kanrikino_meisai_kanren_master_syaryosys
where aggkey = 1