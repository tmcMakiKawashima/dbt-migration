with substr_tbsmksk_noki as (
    select
        substr(raw_data, 1, 3)::varchar(3) as id,
        substr(raw_data, 4, 5)::varchar(5) as kyouhan,
        substr(raw_data, 9, 2)::varchar(2) as nyukkten,
        substr(raw_data, 11, 5)::varchar(5) as makercd,
        substr(raw_data, 16, 1)::varchar(1) as ktenkbn,
        substr(raw_data, 17, 1)::varchar(1) as ptnno,
        substr(raw_data, 18, 8)::varchar(8) as yobi,
        substr(raw_data, 26, 2)::varchar(2) as nokismkskcd,
        substr(raw_data, 28, 1)::varchar(1) as hikizaikbn,
        substr(raw_data, 29, 8)::varchar(8) as deletedate,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_tbsmksk_noki') }}
)
select * from substr_tbsmksk_noki