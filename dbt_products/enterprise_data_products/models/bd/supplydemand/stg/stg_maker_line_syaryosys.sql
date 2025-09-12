with stg_maker_line_syaryosys as (
    select
        maker::varchar(4) as maker, 
        idline::varchar(2) as idline, 
        idshu::varchar(2) as idshu, 
        kline::varchar(4) as kline, 
        toymd::varchar(8) as toymd, 
        meymd::varchar(8) as meymd, 
        dummy::varchar(12) as dummy, 
        ldts
    from {{ ref('substr_da36b63') }}
)
select * from stg_maker_line_syaryosys
where ldts = (select max(ldts) from stg_maker_line_syaryosys)