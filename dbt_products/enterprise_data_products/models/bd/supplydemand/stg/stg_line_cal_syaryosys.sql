with stg_line_cal_syaryosys as (
    select
        nen::varchar(4) as nen, 
        tuki::varchar(2) as tuki, 
        kline::varchar(4) as kline, 
        kadobi1::varchar(31) as kadobi1, 
        meymd1::varchar(8) as meymd1, 
        kadobi2::varchar(31) as kadobi2, 
        meymd2::varchar(8) as meymd2, 
        toymd::varchar(8) as toymd, 
        dummy::varchar(24) as dummy, 
        ldts
    from {{ ref('substr_da36b52') }}
)
select * from stg_line_cal_syaryosys
where ldts = (select max(ldts) from stg_line_cal_syaryosys)