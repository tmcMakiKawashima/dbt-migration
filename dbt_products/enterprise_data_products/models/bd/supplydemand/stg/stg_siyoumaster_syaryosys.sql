with stg_siyoumaster_syaryosys as (
    select
        sle_model::varchar(30) as sle_model,
        che_fil_clss::varchar(1) as che_fil_clss,
        eqp_typ::varchar(1) as eqp_typ,
        eqp_cond_cd::varchar(5) as eqp_cond_cd,
        set_contno::varchar(2) as set_contno,
        set_eqp_typ::varchar(1) as set_eqp_typ,
        set_eqp_cd::varchar(4) as set_eqp_cd,
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        ctl_model::varchar(20) as ctl_model,
        one_set_clss::varchar(1) as one_set_clss,
        ldts,
        row_number() over (
            partition by 
                sle_model,che_fil_clss,eqp_typ,eqp_cond_cd,set_contno,set_eqp_typ,set_eqp_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb88') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb88') }})
)
select * exclude(aggkey)
from stg_siyoumaster_syaryosys
where aggkey = 1