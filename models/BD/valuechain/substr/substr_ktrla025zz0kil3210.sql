with substr_ktrla025zz0kil3210 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as hanbaitencd,
        substr(raw_data, 6, 5)::varchar(5) as hanbaitenname,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3210') }}
)
select * from substr_ktrla025zz0kil3210
