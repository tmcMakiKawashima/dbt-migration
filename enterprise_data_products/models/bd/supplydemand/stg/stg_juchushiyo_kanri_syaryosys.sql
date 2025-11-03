with stg_juchushiyo_kanri_syaryosys as (
    select
        shamei::varchar(2) as shamei,
        sno::varchar(2) as sno,
        dfsc::varchar(5) as dfsc,
        hkata::varchar(20) as hkata,
        gaicd::varchar(4) as gaicd,
        ucd::varchar(4) as ucd,
        tire::varchar(3) as tire,
        hoption::varchar(80) as hoption,
        katacd::varchar(5) as katacd,
        bkata::varchar(20) as bkata,
        ckata::varchar(16) as ckata,
        tecs::varchar(1) as tecs,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by shamei, sno, dfsc
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa36e')}}
    where ldts = (select max(ldts) from {{ref('substr_tsjfa36e')}})
)
select * exclude(aggkey)
from stg_juchushiyo_kanri_syaryosys
where aggkey = 1