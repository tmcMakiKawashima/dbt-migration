with substr_ktrla025zz0kil3205 as (
    select
        substr(raw_data, 2, 9)::varchar(9) as r001,
        substr(raw_data, 11, 4)::varchar(4) as r002,
        substr(raw_data, 15, 8)::varchar(8) as r003,
        substr(raw_data, 23, 1)::varchar(1) as r004,
        substr(raw_data, 24, 2)::varchar(2) as r005,
        substr(raw_data, 26, 2)::varchar(2) as r006,
        substr(raw_data, 28, 12)::varchar(12) as r007,
        substr(raw_data, 40, 1)::varchar(1) as r008,
        substr(raw_data, 41, 50)::varchar(50) as r009,
        substr(raw_data, 1, 1)::varchar(1) as delflg,
        ldts,
        row_number
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3205') }}
)
select * from substr_ktrla025zz0kil3205