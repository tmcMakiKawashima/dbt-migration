with stg_daisu_month_syaryosys as (
    select
        dlrcd::varchar(5) as dlrcd, 
        shamei::varchar(2) as shamei, 
        sno::varchar(2) as sno, 
        shinq::varchar(3) as shinq, 
        firmymj::varchar(8) as firmymj, 
        daisu::varchar(5) as daisu, 
        kncode::varchar(7) as kncode, 
        jochugeflg::varchar(1) as jochugeflg, 
        tnyugaiflg::varchar(1) as tnyugaiflg, 
        dlrhonbu::varchar(5) as dlrhonbu, 
        gmfarm::varchar(5) as gmfarm, 
        dummy::varchar(36) as dummy, 
        ldts
    from {{ ref('substr_da34b43') }}
)
select * from stg_daisu_month_syaryosys
where ldts = (select max(ldts) from stg_daisu_month_syaryosys)