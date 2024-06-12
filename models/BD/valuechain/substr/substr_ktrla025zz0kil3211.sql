with substr_ktrla025zz0kil3211 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as M001,
        substr(raw_data, 6, 3)::varchar(3) as M002,
        substr(raw_data, 9, 20)::varchar(20) as M003,
        substr(raw_data, 29, 6)::varchar(6) as M004,
        substr(raw_data, 35, 6)::varchar(6) as M005,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3211') }}
)
select * from substr_ktrla025zz0kil3211
