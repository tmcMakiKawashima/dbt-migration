with substr_da34b18 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as shamei,
        substr(raw_data, 3, 2)::varchar(2) as sno,
        substr(raw_data, 5, 6)::varchar(6) as nengetu,
        substr(raw_data, 11, 7)::varchar(7) as kncode,
        substr(raw_data, 18, 1)::varchar(1) as wkbn,
        substr(raw_data, 19, 1)::varchar(1) as ksign,
        substr(raw_data, 20, 9)::varchar(9) as dsyubetum,
        substr(raw_data, 29, 5)::varchar(5) as tdaisu,
        substr(raw_data, 34, 7)::varchar(7) as dummy,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da34b18') }}
)
select * from substr_da34b18