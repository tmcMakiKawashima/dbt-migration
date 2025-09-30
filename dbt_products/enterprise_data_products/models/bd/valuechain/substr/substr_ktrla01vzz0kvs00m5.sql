with substr_ktrla01vzz0kvs00m5 as (
  select
    substr(raw_data, 1, 20)::varchar(20) as shinban,
    substr(raw_data, 21, 1)::varchar(1) as kaknoukbn,
    substr(raw_data, 22, 8)::varchar(8) as situryog8,
    substr(raw_data, 30, 10)::varchar(10) as yoseki3,
    substr(raw_data, 40, 2)::varchar(2) as yosekss,
    substr(raw_data, 42, 4)::varchar(4) as sizel,
    substr(raw_data, 46, 4)::varchar(4) as sizew,
    substr(raw_data, 50, 4)::varchar(4) as sizeh,
    substr(raw_data, 54, 5)::varchar(5) as ssnjuryo,
    substr(raw_data, 59, 8)::varchar(8) as tekiyokaisiymd,
    substr(raw_data, 67, 8)::varchar(8) as tekiyosyuryoymd,
    substr(raw_data, 75, 16)::varchar(16) as mtuserid,
    substr(raw_data, 91, 26)::varchar(26) as mttime,
    substr(raw_data, 117, 4)::varchar(4) as filler,
    ldts,
    line_number
  from {{ source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvs00m5')}}
)
select * from substr_ktrla01vzz0kvs00m5