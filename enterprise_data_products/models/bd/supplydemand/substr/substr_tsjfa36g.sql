with substr_tsjfa36g as (
    select
        substr(raw_data, 3, 2)::varchar(2) as shamei,
        substr(raw_data, 1, 2)::varchar(2) as sno,
        substr(raw_data, 5, 5)::varchar(5) as dfsc,
        substr(raw_data, 10, 7)::varchar(7) as kncode,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36g')}}
)
select * from substr_tsjfa36g