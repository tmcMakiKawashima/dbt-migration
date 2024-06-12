with substr_ktrla025zz0kil3202 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as delflg,
        substr(raw_data, 2, 3)::varchar(3) as R001,
        substr(raw_data, 5, 20)::varchar(20) as R002,
        substr(raw_data, 25, 8)::varchar(8) as R003,
        substr(raw_data, 33, 5)::varchar(5) as R004,
        substr(raw_data, 38, 8)::varchar(8) as R005,
        substr(raw_data, 46, 3)::varchar(3) as R006,
        substr(raw_data, 49, 3)::varchar(3) as R007,
        substr(raw_data, 52, 1)::varchar(1) as R008,
        substr(raw_data, 53, 8)::varchar(8) as R009,
        substr(raw_data, 61, 8)::varchar(8) as R010,
        substr(raw_data, 69, 6)::varchar(6) as R011,
        substr(raw_data, 75, 7)::varchar(7) as R012,
        substr(raw_data, 82, 7)::varchar(7) as R013,
        substr(raw_data, 89, 7)::varchar(7) as R014,
        substr(raw_data, 96, 7)::varchar(7) as R015,
        substr(raw_data, 103, 7)::varchar(7) as R016,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3202') }}
)
select * from substr_ktrla025zz0kil3202