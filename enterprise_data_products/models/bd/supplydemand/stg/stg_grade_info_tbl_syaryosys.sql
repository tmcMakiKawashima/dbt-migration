with stg_grade_info_tbl_syaryosys as (
    select
        sle_model::varchar(30) as sle_model,
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        capacity::varchar(2) as capacity,
        eng_disp::varchar(5) as eng_disp,
        fuel_cd::varchar(2) as fuel_cd,
        eng_model::varchar(9) as eng_model,
        tire_cd::varchar(3) as tire_cd,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by sle_model
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla038zz0kadcb82')}}
    where mtkbn = 'I'
    and ldts = (select max(ldts) from {{ref('substr_ktrla038zz0kadcb82')}})
)
select * exclude(aggkey)
from stg_grade_info_tbl_syaryosys
where aggkey = 1