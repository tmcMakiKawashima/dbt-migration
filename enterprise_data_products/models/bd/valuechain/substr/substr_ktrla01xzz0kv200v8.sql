with substr_ktrla01xzz0kv200v8 as (
    select
        substr(raw_data, 5, 1)::varchar(1) as mtkbn,
        substr(raw_data, 10, 6)::varchar(6) as catalg,
        substr(raw_data, 6, 4)::varchar(4) as syasyu,
        substr(raw_data, 16, 5)::varchar(5) as katapno,
        substr(raw_data, 21, 3)::varchar(3) as katano,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla01xzz0kv200v8') }}
)
select * from substr_ktrla01xzz0kv200v8