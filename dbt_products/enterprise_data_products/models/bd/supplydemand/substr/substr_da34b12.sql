with substr_da34b12 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as dlrcd,
        substr(raw_data, 6, 12)::varchar(12) as odno,
        substr(raw_data, 18, 8)::varchar(8) as odrjuri,
        substr(raw_data, 26, 8)::varchar(8) as kndate,
        substr(raw_data, 34, 5)::varchar(5) as dfsc,
        substr(raw_data, 39, 5)::varchar(5) as odjun,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b12') }}
)
select * from substr_da34b12