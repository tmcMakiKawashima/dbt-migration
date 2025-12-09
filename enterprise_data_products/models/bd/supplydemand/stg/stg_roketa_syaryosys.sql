with stg_roketa_syaryosys as (
    select
        syoribi::varchar(8) as syoribi, 
        stime::varchar(9) as stime, 
        taisyo::varchar(7) as taisyo, 
        dlrcd::varchar(5) as dlrcd, 
        shamei::varchar(2) as shamei, 
        sno::varchar(2) as sno, 
        bukbn::varchar(1) as bukbn, 
        kncode::varchar(7) as kncode, 
        jojukbn::varchar(1) as jojukbn, 
        aitecd::varchar(5) as aitecd, 
        daisu::varchar(4) as daisu, 
        skbn::varchar(1) as skbn, 
        dummy::varchar(8) as dummy, 
        ldts
    from {{ ref('substr_da39b81') }}
)
select * from stg_roketa_syaryosys
where ldts = (select max(ldts) from stg_roketa_syaryosys)