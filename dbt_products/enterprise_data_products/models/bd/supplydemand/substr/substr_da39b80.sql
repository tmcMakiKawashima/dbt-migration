with substr_da39b80 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as shamei,
        substr(raw_data, 3, 2)::varchar(2) as sno,
        substr(raw_data, 5, 1)::varchar(1) as bukbn,
        substr(raw_data, 6, 7)::varchar(7) as kncode,
        substr(raw_data, 13, 5)::varchar(5) as dlrcd,
        substr(raw_data, 18, 4)::varchar(4) as firmyy,
        substr(raw_data, 22, 2)::varchar(2) as firmmm,
        substr(raw_data, 24, 2)::varchar(2) as firmjn,
        substr(raw_data, 26, 3)::varchar(3) as hiritu,
        substr(raw_data, 29, 5)::varchar(5) as waku,
        substr(raw_data, 34, 5)::varchar(5) as jiseki,
        substr(raw_data, 39, 12)::varchar(12) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da39b80') }}
)
select * from substr_da39b80