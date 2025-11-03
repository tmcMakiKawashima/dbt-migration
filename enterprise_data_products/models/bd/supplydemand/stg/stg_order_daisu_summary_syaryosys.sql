with stg_order_daisu_summary_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        dlrcd::varchar(5) as dlrcd,
        dfsc::varchar(5) as dfsc,
        oddaisu::number(5) as oddaisu,
        kndaisu::number(5) as kndaisu,
        hidaisu::number(5) as hidaisu,
        codaisu::number(5) as codaisu,
        odno::varchar(12) as odno,
        kndate::varchar(8) as kndate,
        hydate::varchar(8) as hydate,
        ldts,
        row_number() over (
            partition by 
                shamei,sno,dlrcd,dfsc
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_tsjfa36b') }}
        where ldts = (select max(ldts) from {{ ref('substr_tsjfa36b') }})
)
select * exclude(aggkey)
from stg_order_daisu_summary_syaryosys
where aggkey = 1