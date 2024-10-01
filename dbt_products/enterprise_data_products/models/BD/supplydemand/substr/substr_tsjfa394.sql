with substr_tsjfa394 as (
select
substr(raw_data, 1, 1)::varchar(1) as mtkbn,
substr(raw_data, 2, 2)::varchar(2) as line_id,
substr(raw_data, 4, 8)::varchar(8) as ymd,
substr(raw_data, 12, 2)::varchar(2) as skei,
substr(raw_data, 14, 8)::varchar(8) as seisankara,
substr(raw_data, 22, 8)::varchar(8) as seisanmade,
substr(raw_data, 30, 4)::varchar(4) as maker,
substr(raw_data, -20)::varchar(20) as ldg_time,
ldts,
line_number
from {{ source('snowpipe_db_supplydemand','raw_tsjfa394') }} 
)
select * from substr_tsjfa394