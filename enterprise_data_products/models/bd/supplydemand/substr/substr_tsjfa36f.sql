with substr_tsjfa36f as (
    select
        substr(raw_data, 3, 2)::varchar(2) as shamei,
        substr(raw_data, 1, 2)::varchar(2) as sno,
        substr(raw_data, 5, 1)::varchar(1) as kbn,
        substr(raw_data, 12, 7)::varchar(7) as kncode,
        substr(raw_data, 6, 5)::varchar(5) as knmsortjun,
        substr(raw_data, 11, 1)::varchar(1) as tecs,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36f')}}
)
select * from substr_tsjfa36f