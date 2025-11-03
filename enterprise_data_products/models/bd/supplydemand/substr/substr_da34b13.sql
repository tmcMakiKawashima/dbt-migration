with substr_da34b13 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as dlrcd,
        substr(raw_data, 6, 12)::varchar(12) as odno,
        substr(raw_data, 18, 8)::varchar(8) as odrjuri,
        substr(raw_data, 26, 5)::varchar(5) as dlrcd2,
        substr(raw_data, 31, 10)::varchar(10) as chumon,
        substr(raw_data, 41, 8)::varchar(8) as jyucyubi,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b13') }}
)
select * from substr_da34b13