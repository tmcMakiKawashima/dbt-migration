with stg_fwaku_syaryosys as (
    select
        shamei::varchar(2) as shamei, 
        sno::varchar(2) as sno, 
        bukbn::varchar(1) as bukbn, 
        kncode::varchar(7) as kncode, 
        dlrcd::varchar(5) as dlrcd, 
        firmyy::varchar(4) as firmyy, 
        firmmm::varchar(2) as firmmm, 
        firmjn::varchar(2) as firmjn, 
        hiritu::varchar(3) as hiritu, 
        waku::varchar(5) as waku, 
        jiseki::varchar(5) as jiseki, 
        dummy::varchar(12) as dummy, 
        ldts
    from {{ ref('substr_da39b80') }}
)
select * from stg_fwaku_syaryosys
where ldts = (select max(ldts) from stg_fwaku_syaryosys)