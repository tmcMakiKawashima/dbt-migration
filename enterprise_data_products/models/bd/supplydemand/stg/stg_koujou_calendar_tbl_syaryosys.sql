with stg_koujou_calendar_tbl_syaryosys as (
    select
        ymd::varchar(8) as ymd,
        ope_flg::varchar(1) as ope_flg,
        ldts,
        row_number() over (
            partition by 
                ymd
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_ktrla038zz0kadcb8j') }}
        where mtkbn = 'I' and ldts = (select max(ldts) from {{ ref('substr_ktrla038zz0kadcb8j') }})
)
select * exclude(aggkey)
from stg_koujou_calendar_tbl_syaryosys
where aggkey = 1