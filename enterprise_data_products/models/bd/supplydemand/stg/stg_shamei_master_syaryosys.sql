with stg_shamei_master_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        skshameimei::varchar(20) as skshameimei,
        ldts,
        row_number() over (
            partition by 
                shamei
            order by ldts desc, line_number desc
        ) aggkey
        from {{ ref('substr_tsjfa36c') }}
        where rtrim(sno, ' 　') = '' and ldts = (select max(ldts) from {{ ref('substr_tsjfa36c') }})
)
select * exclude(aggkey)
from stg_shamei_master_syaryosys
where aggkey = 1