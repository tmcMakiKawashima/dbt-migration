with substr_tsjfa396 as (
select
substr(raw_data, 1, 1)::varchar(1) as mtkbn,
substr(raw_data, 2, 2)::varchar(2) as line_id,
substr(raw_data, 4, 8)::varchar(8) as tkkara,
substr(raw_data, 12, 8)::varchar(8) as tkmade,
substr(raw_data, 20, 2)::varchar(2) as choku,
substr(raw_data, 22, 2)::varchar(2) as nsuu,
substr(raw_data, 24, 8)::varchar(8) as mtymd,
substr(raw_data, -20)::varchar(20) as ldg_time,
ldts,
line_number
from {{ source('snowpipe_db_supplydemand','raw_tsjfa396') }} 
)
select * from substr_tsjfa396