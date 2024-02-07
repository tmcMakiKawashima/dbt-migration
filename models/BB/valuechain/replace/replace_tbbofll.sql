with substr_tbbofll as (
    select
      replace(raw_data, '／', '  ') as raw_data,
      ldts
    from {{ source('snowpipe_db_valuechain', 'raw_tbbofll') }}
)
select * from substr_tbbofll
