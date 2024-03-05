with substr_ktrla01ezz0ka20001 as (
    select
        substr(raw_data, 2, 4)::varchar(4) as syasyu,
        substr(raw_data, 6, 3)::varchar(3) as siyoudai5,
        substr(raw_data, 9, 2)::varchar(2) as siyousai5,
        substr(raw_data, 11, 3)::varchar(3) as sketa,
        substr(raw_data, 14, 1)::varchar(1) as skigo,
        substr(raw_data, 15, 25)::varchar(25) as smeikanji,
        substr(raw_data, 40, 25)::varchar(25) as smeikana,
        substr(raw_data, 65, 25)::varchar(25) as smeieiji,
        substr(raw_data, 90, 1)::varchar(1) as mtflg,
        substr(raw_data, 91, 9)::varchar(9) as sijikara,
        substr(raw_data, 100, 3)::varchar(3) as tutisyokara,
        substr(raw_data, 103, 2)::varchar(2) as tutisufkata,
        substr(raw_data, 105, 14)::varchar(14) as mtdate,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_ktrla01ezz0ka20001') }}
)
select * from substr_ktrla01ezz0ka20001    
        