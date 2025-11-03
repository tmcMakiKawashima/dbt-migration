with substr_ktrla01vzz0kvp00q7 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as mntkbn,
    substr(raw_data, 2, 20)::varchar(20) as hinban,
    substr(raw_data, 22, 7)::varchar(7) as dlrcd,
    substr(raw_data, 29, 1)::varchar(1) as odrzok,
    substr(raw_data, 30, 1)::varchar(1) as keikakuodrkbn,
    substr(raw_data, 31, 8)::varchar(8) as odrno,
    substr(raw_data, 39, 1)::varchar(1) as yusokbn,
    substr(raw_data, 40, 8)::varchar(8) as juchuymd,
    substr(raw_data, 48, 7)::varchar(7) as juchusu7,
    substr(raw_data, 55, 5)::varchar(5) as hind5,
    substr(raw_data, 60, 141)::varchar(141) as filler,
    ldts,
    line_number
  from {{ source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvp00q7')}}
)
select * from substr_ktrla01vzz0kvp00q7