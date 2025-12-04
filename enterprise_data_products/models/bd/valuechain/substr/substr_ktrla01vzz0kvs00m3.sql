with substr_ktrla01vzz0kvs00m3 as (
  select
    substr(raw_data, 1, 20)::varchar(20) as seisnkokumei,
    substr(raw_data, 21, 1)::varchar(1) as seisnkm1keta,
    substr(raw_data, 22, 3)::varchar(3) as isocd,
    substr(raw_data, 25, 16)::varchar(16) as mtuserid,
    substr(raw_data, 41, 26)::varchar(26) as mttime,
    substr(raw_data, 67, 14)::varchar(14) as filler,
    ldts,
    line_number
  from {{ source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvs00m3')}}
)
select * from substr_ktrla01vzz0kvs00m3