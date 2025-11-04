with stg_gaihanshoku_master_syaryosys as (
    select
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        bdcol_cd::varchar(3) as bdcol_cd,
        ldts,
        row_number() over (
            partition by 
                carnm_cd,spec_no,bdcol_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8m') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8m') }})
)
select * exclude(aggkey)
from stg_gaihanshoku_master_syaryosys
where aggkey = 1