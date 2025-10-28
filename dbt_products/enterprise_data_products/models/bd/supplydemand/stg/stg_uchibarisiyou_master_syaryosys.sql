with stg_uchibarisiyou_master_syaryosys as (
    select
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        inner_cd::varchar(4) as inner_cd,
        ldts,
        row_number() over (
            partition by 
                carnm_cd,spec_no,inner_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8n') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8n') }})
)
select * exclude(aggkey)
from stg_uchibarisiyou_master_syaryosys
where aggkey = 1