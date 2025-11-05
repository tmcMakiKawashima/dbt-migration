with substr_da36b52 as (
    select
        substr(raw_data, 1, 4)::varchar(4) as nen,
        substr(raw_data, 5, 2)::varchar(2) as tuki,
        substr(raw_data, 7, 4)::varchar(4) as kline,
        substr(raw_data, 11, 31)::varchar(31) as kadobi1,
        substr(raw_data, 42, 8)::varchar(8) as meymd1,
        substr(raw_data, 50, 31)::varchar(31) as kadobi2,
        substr(raw_data, 81, 8)::varchar(8) as meymd2,
        substr(raw_data, 89, 8)::varchar(8) as toymd,
        substr(raw_data, 97, 24)::varchar(24) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da36b52') }}
)
select * from substr_da36b52