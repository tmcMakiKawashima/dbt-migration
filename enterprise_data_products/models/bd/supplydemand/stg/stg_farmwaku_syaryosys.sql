with stg_farmwaku_syaryosys as (
    select
        dlr_cd::varchar(5) as dlr_cd,
        carnm_cd::varchar(2) as carnm_cd,
        spec_no::varchar(2) as spec_no,
        obj_ym_jun::varchar(8) as obj_ym_jun,
        funcdtl_cd::varchar(7) as funcdtl_cd,
        odr_capa_cnt::number(5) as odr_capa_cnt,
        odr_rslt_cnt::number(5) as odr_rslt_cnt,
        eptcapa_cnt::number(5) as eptcapa_cnt,
        thirds_use_flg::varchar(1) as thirds_use_flg,
        inodr_exc_flg::varchar(1) as inodr_exc_flg,
        shinq_kbn::varchar(3) as shinq_kbn,
        ldts,
        row_number() over (
            partition by 
                dlr_cd,carnm_cd,spec_no,obj_ym_jun,funcdtl_cd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8r') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8r') }})
)
select * exclude(aggkey)
from stg_farmwaku_syaryosys
where aggkey = 1