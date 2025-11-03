with substr_tsjfa36b as (
    select
        substr(raw_data, 1, 2)::varchar(2) as shamei,
        substr(raw_data, 3, 2)::varchar(2) as sno,
        substr(raw_data, 5, 5)::varchar(5) as dlrcd,
        substr(raw_data, 10, 5)::varchar(5) as dummy1,
        substr(raw_data, 15, 5)::varchar(5) as dfsc,
        substr(raw_data, 20, 7)::varchar(7) as dummy2,
        substr(raw_data, 27, 5)::varchar(5) as oddaisu,
        substr(raw_data, 32, 5)::varchar(5) as kndaisu,
        substr(raw_data, 37, 5)::varchar(5) as hidaisu,
        substr(raw_data, 42, 5)::varchar(5) as codaisu,
        substr(raw_data, 47, 12)::varchar(12) as odno,
        substr(raw_data, 59, 8)::varchar(8) as kndate,
        substr(raw_data, 67, 8)::varchar(8) as hydate,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36b')}}
)
select * from substr_tsjfa36b