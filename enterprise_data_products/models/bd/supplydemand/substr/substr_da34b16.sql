with substr_da34b16 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as dlrcd,
        substr(raw_data, 6, 10)::varchar(10) as chumon,
        substr(raw_data, 16, 20)::varchar(20) as hkata,
        substr(raw_data, 36, 2)::varchar(2) as syamei,
        substr(raw_data, 38, 1)::varchar(1) as skkubun,
        substr(raw_data, 39, 1)::varchar(1) as errbunrui,
        substr(raw_data, 40, 1)::varchar(1) as kkbn,
        substr(raw_data, 41, 20)::varchar(20) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b16') }}
)
select * from substr_da34b16