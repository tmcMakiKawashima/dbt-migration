with substr_tsjfa490 as(
select
substr(raw_data, 1, 1)::varchar(1) as mtkbn,
substr(raw_data, 2, 2)::varchar(2) as sno,
substr(raw_data, 4, 2)::varchar(2) as syamei,
substr(raw_data, 6, 8)::varchar(8) as ktai,
substr(raw_data, 14, 8)::varchar(8) as seisankara,
substr(raw_data, 22, 8)::varchar(8) as seisanmade,
substr(raw_data, 30, 2)::varchar(2) as kaktei,
substr(raw_data, 32, 1)::varchar(1) as mtflg,
substr(raw_data, -20)::varchar(20) as ldg_time,
ldts,
line_number
from {{ source('snowpipe_db_supplydemand','raw_tsjfa490') }} 
)
select * from substr_tsjfa490