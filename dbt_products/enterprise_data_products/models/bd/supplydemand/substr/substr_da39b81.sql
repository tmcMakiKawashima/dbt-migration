with substr_da39b81 as (
    select
        substr(raw_data, 1, 8)::varchar(8) as syoribi,
        substr(raw_data, 9, 9)::varchar(9) as stime,
        substr(raw_data, 18, 7)::varchar(7) as taisyo,
        substr(raw_data, 25, 5)::varchar(5) as dlrcd,
        substr(raw_data, 30, 2)::varchar(2) as shamei,
        substr(raw_data, 32, 2)::varchar(2) as sno,
        substr(raw_data, 34, 1)::varchar(1) as bukbn,
        substr(raw_data, 35, 7)::varchar(7) as kncode,
        substr(raw_data, 42, 1)::varchar(1) as jojukbn,
        substr(raw_data, 43, 5)::varchar(5) as aitecd,
        substr(raw_data, 48, 4)::varchar(4) as daisu,
        substr(raw_data, 52, 1)::varchar(1) as skbn,
        substr(raw_data, 53, 8)::varchar(8) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da39b81') }}
)
select * from substr_da39b81