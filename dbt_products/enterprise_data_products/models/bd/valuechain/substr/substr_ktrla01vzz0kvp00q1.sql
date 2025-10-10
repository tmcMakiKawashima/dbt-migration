with substr_ktrla01vzz0kvp00q1 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as ctlydataid,
    substr(raw_data, 2, 2)::varchar(2) as ctlyreckbn,
    substr(raw_data, 12, 1)::varchar(1) as mntkbn,
    substr(raw_data, 13, 20)::varchar(20) as hinban,
    substr(raw_data, 33, 1)::varchar(1) as zaihikbn,
    substr(raw_data, 34, 3)::varchar(3) as nonult3,
    substr(raw_data, 4, 8)::varchar(8) as sakuseiymd,
    substr(raw_data, 37, 164)::varchar(164) as filler,
    ldts,
    line_number
  from {{ source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvp00q1')}}
)
select * from substr_ktrla01vzz0kvp00q1