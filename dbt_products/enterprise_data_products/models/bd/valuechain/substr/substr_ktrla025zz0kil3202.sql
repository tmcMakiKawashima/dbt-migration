with substr_ktrla025zz0kil3202 as (
    select
        substr(raw_data, 2, 3)::varchar(3) as r001,
        substr(raw_data, 5, 20)::varchar(20) as r002,
        substr(raw_data, 25, 8)::varchar(8) as r003,
        substr(raw_data, 33, 5)::varchar(5) as r004,
        substr(raw_data, 38, 8)::varchar(8) as r005,
        substr(raw_data, 46, 3)::varchar(3) as r006,
        substr(raw_data, 49, 3)::varchar(3) as r007,
        substr(raw_data, 52, 1)::varchar(1) as r008,
        substr(raw_data, 53, 8)::varchar(8) as r009,
        substr(raw_data, 61, 8)::varchar(8) as r010,
        substr(raw_data, 69, 6)::varchar(6) as r011,
        substr(raw_data, 75, 7)::varchar(7) as r012,
        substr(raw_data, 82, 7)::varchar(7) as r013,
        substr(raw_data, 89, 7)::varchar(7) as r014,
        substr(raw_data, 96, 7)::varchar(7) as r015,
        substr(raw_data, 103, 7)::varchar(7) as r016,
        substr(raw_data, 1, 1)::varchar(1) as delflg,
        ldts,
        row_number
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3202') }}
)
select * from substr_ktrla025zz0kil3202