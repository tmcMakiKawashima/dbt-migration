with substr_da34b19 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as sno,
        substr(raw_data, 3, 2)::varchar(2) as shamei,
        substr(raw_data, 5, 5)::varchar(5) as dfsc,
        substr(raw_data, 10, 7)::varchar(7) as kncode,
        substr(raw_data, 17, 4)::varchar(4) as dum,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b19') }}
)
select * from substr_da34b19