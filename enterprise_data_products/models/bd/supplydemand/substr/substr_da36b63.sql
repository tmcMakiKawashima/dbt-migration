with substr_da36b63 as (
    select
        substr(raw_data, 1, 4)::varchar(4) as maker,
        substr(raw_data, 5, 2)::varchar(2) as idline,
        substr(raw_data, 7, 2)::varchar(2) as idshu,
        substr(raw_data, 9, 4)::varchar(4) as kline,
        substr(raw_data, 13, 8)::varchar(8) as toymd,
        substr(raw_data, 21, 8)::varchar(8) as meymd,
        substr(raw_data, 29, 12)::varchar(12) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da36b63') }}
)
select * from substr_da36b63