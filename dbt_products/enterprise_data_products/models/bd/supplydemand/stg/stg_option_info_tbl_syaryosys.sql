with stg_option_info_tbl_syaryosys as (
    select
        sle_model::varchar(30) as sle_model,
        bdcol_cd::varchar(3) as bdcol_cd,
        inner_cd::varchar(4) as inner_cd,
        opt_cd::varchar(3) as opt_cd,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by sle_model, bdcol_cd, inner_cd, opt_cd
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_ktrla038zz0kadcb84')}}
    where mtkbn = 'I' and ldts = (select max(ldts) from {{ref('substr_ktrla038zz0kadcb84')}})
)
select * exclude(aggkey)
from stg_option_info_tbl_syaryosys
where aggkey = 1