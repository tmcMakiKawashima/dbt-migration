with substr_ktrla01xzz0kv200v7 as (
    select
        substr(raw_data, 5, 1)::varchar(1) as mtkbn,
        substr(raw_data, 6, 6)::varchar(6) as catalg,
        substr(raw_data, 12, 5)::varchar(5) as katahyono,
        substr(raw_data, 17, 5)::varchar(5) as katapno,
        substr(raw_data, 22, 6)::varchar(6) as hyognkara,
        substr(raw_data, 28, 6)::varchar(6) as hyognmade,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla01xzz0kv200v7') }}
)
select * from substr_ktrla01xzz0kv200v7