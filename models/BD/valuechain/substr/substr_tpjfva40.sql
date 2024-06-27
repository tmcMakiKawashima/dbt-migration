with substr_tpjfva40 as (
  select
    substr(raw_data, 2, 4)::varchar(4) as syasyug,
    substr(raw_data, 6, 3)::varchar(3) as syameino,
    substr(raw_data, 9, 8)::varchar(8) as touroku,
    substr(raw_data,17, 8)::varchar(8) as kousin,
    substr(raw_data,25, 7)::varchar(7) as tantou,
    ldts
  from {{ source('snowpipe_db_valuechain', 'raw_tpjfva40')}}
)
select * from substr_tpjfva40