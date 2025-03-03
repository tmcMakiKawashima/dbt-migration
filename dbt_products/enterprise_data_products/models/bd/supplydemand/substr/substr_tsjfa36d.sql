with substr_tsjfa36d as (
select
substr(raw_data, 131, 2)::varchar(2) as sno,
substr(raw_data, 133, 2)::varchar(2) as syamei,
substr(raw_data, 135, 8)::varchar(8) as ktai,
substr(raw_data, 143, 8)::varchar(8) as seisankara,
substr(raw_data, 151, 8)::varchar(8) as seisanmade,
substr(raw_data, 159, 2)::varchar(2) as kaktei,
substr(raw_data, -20)::varchar(20) as ldg_time,
ldts,
line_number
from {{ source('snowpipe_db_supplydemand','raw_tsjfa36d') }} 
)
select * from substr_tsjfa36d