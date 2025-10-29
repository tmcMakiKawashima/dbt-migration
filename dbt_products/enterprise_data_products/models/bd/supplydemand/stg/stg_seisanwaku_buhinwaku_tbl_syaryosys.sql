with stg_seisanwaku_buhinwaku_tbl_syaryosys as (
    select
        spec_no::varchar(2) as spec_no,
        carnm_cd::varchar(2) as carnm_cd,
        funcdtl_cd::varchar(7) as funcdtl_cd,
        lineoff_beto_ymd::varchar(8) as lineoff_beto_ymd,
        eptcapa_cnt::number(5) as eptcapa_cnt,
        odr_rslt_cnt::number(5) as odr_rslt_cnt,
        std_cnt::number(5) as std_cnt,
        uprlmt_cnt::number(5) as uprlmt_cnt,
        ldts,
        row_number() over (
            partition by 
                spec_no,carnm_cd,funcdtl_cd,lineoff_beto_ymd
            order by ldts desc,line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8f') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8f') }})
)
select * exclude(aggkey)
from stg_seisanwaku_buhinwaku_tbl_syaryosys
where aggkey = 1