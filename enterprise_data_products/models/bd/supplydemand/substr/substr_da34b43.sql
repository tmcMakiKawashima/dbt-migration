with substr_da34b43 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as dlrcd,
        substr(raw_data, 6, 2)::varchar(2) as shamei,
        substr(raw_data, 8, 2)::varchar(2) as sno,
        substr(raw_data, 10, 3)::varchar(3) as shinq,
        substr(raw_data, 13, 8)::varchar(8) as firmymj,
        substr(raw_data, 21, 5)::varchar(5) as daisu,
        substr(raw_data, 26, 7)::varchar(7) as kncode,
        substr(raw_data, 33, 1)::varchar(1) as jochugeflg,
        substr(raw_data, 34, 1)::varchar(1) as tnyugaiflg,
        substr(raw_data, 35, 5)::varchar(5) as dlrhonbu,
        substr(raw_data, 40, 5)::varchar(5) as gmfarm,
        substr(raw_data, 45, 36)::varchar(36) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b43') }}
)
select * from substr_da34b43