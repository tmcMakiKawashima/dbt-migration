with stg_chiikihyoujun_soubi_master_syaryosys as (
    select
        dlr_cd::varchar(5) as dlr_cd,
        sle_model::varchar(30) as sle_model,
        eqp_clss::varchar(1) as eqp_clss,
        eqp_itm::varchar(4) as eqp_itm,
        ldts,
        row_number() over (
            partition by 
                dlr_cd,sle_model,eqp_clss,eqp_itm
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8c') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8c') }})
)
select * exclude(aggkey)
from stg_chiikihyoujun_soubi_master_syaryosys
where aggkey = 1