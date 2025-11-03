with stg_order_db_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd,
        odno::varchar(12) as odno,
        jrdate::varchar(8) as jrdate,
        kndate::varchar(8) as kndate,
        kydate::varchar(8) as kydate,
        hydate::varchar(8) as hydate,
        tydate::varchar(8) as tydate,
        nsdate::varchar(8) as nsdate,
        frsign::varchar(1) as frsign,
        nfuyo::varchar(1) as nfuyo,
        ukecd::varchar(1) as ukecd,
        kfsign::varchar(1) as kfsign,
        vltsofu::varchar(1) as vltsofu,
        wax::varchar(1) as wax,
        zaikosk::varchar(5) as zaikosk,
        yusosk1::varchar(8) as yusosk1,
        bukbn::varchar(1) as bukbn,
        nhsign::varchar(1) as nhsign,
        rtrim(shamei, ' 　')::varchar(2) as shamei,
        sno::varchar(2) as sno,
        ojyy::varchar(4) as ojyy,
        kubn::varchar(1) as kubn,
        yusosk2::varchar(8) as yusosk2,
        tonoki::varchar(8) as tonoki,
        jifuri::varchar(1) as jifuri,
        tokcd::varchar(1) as tokcd,
        kmaker::varchar(5) as kmaker,
        hassou::varchar(1) as hassou,
        seikyu::varchar(5) as seikyu,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by dlrcd, odno, jrdate, shamei, sno
            order by ldts desc, line_number desc
        ) aggkey
    from {{ref('substr_tsjfa36a')}}
    where ldts = (select max(ldts) from {{ref('substr_tsjfa36a')}})
    and rtrim(shamei, ' 　') <> ''
)
select * exclude(aggkey)
from stg_order_db_syaryosys
where aggkey = 1