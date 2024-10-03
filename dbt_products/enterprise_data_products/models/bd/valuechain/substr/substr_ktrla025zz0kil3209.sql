with substr_ktrla025zz0kil3209 as (
    select
        substr(raw_data, 1, 3)::varchar(3) as r001,
        substr(raw_data, 4, 2)::varchar(2) as r002,
        substr(raw_data, 6, 20)::varchar(20) as r003,
        substr(raw_data, 26, 26)::varchar(26) as r004,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3209') }}
)
select * from substr_ktrla025zz0kil3209
