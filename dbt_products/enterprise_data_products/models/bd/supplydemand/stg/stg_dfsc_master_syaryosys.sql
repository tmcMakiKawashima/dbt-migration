with stg_dfsc_master_syaryosys as (
    select
        dfsc::varchar(5) as dfsc,
        spec_no::varchar(2) as spec_no,
        carnm_cd::varchar(2) as carnm_cd,
        sle_model::varchar(30) as sle_model,
        bdcol_cd::varchar(3) as bdcol_cd,
        inner_cd::varchar(4) as inner_cd,
        tire_cd::varchar(3) as tire_cd,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by dfsc
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla038zz0kadcb85')}}
    where mtkbn = 'I'
    and ldts = (select max(ldts) from {{ref('substr_ktrla038zz0kadcb85')}})
)
select * exclude(aggkey)
from stg_dfsc_master_syaryosys
where aggkey = 1