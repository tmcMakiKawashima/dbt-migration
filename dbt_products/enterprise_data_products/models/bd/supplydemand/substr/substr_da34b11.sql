with substr_da34b11 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as dlrcd,
        substr(raw_data, 6, 10)::varchar(10) as chumon,
        substr(raw_data, 16, 8)::varchar(8) as jyucyubi,
        substr(raw_data, 24, 8)::varchar(8) as kndate,
        substr(raw_data, 32, 5)::varchar(5) as dfsc,
        substr(raw_data, 37, 5)::varchar(5) as odjun,
        substr(raw_data, 42, 8)::varchar(8) as farmgroup,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b11') }}
)
select * from substr_da34b11