with stg_order_kakuteibi_tbl_syaryosys as (
    select
        spec_no::varchar(2) as spec_no,
        carnm_cd::varchar(2) as carnm_cd,
        odr_dcson_ymd::varchar(8) as odr_dcson_ymd,
        odr_obj_ymd_from::varchar(8) as odr_obj_ymd_from,
        odr_obj_ymd_to::varchar(8) as odr_obj_ymd_to,
        ldts,
        row_number() over (
            partition by 
                spec_no,carnm_cd,odr_dcson_ymd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8k') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8k') }})
)
select * exclude(aggkey)
from stg_order_kakuteibi_tbl_syaryosys
where aggkey = 1