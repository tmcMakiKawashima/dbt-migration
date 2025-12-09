with substr_ktrla01xzz0kv200va as (
    select
        substr(raw_data, 5, 1)::varchar(1) as mtkbn,
        substr(raw_data, 6, 6)::varchar(6) as pnc1,
        substr(raw_data, 12, 2)::varchar(2) as langua,
        substr(raw_data, 14, 60)::varchar(60) as pncmei,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla01xzz0kv200va') }}
)
select * from substr_ktrla01xzz0kv200va