with substr_ktrla01vzz0kvs00m2 as (
  select
    substr(raw_data, 1, 20)::varchar(20) as jhinban,
    substr(raw_data, 21, 1)::varchar(1) as siyouhenk,
    substr(raw_data, 22, 1)::varchar(1) as gohuzis,
    substr(raw_data, 23, 1)::varchar(1) as gomizis,
    substr(raw_data, 24, 1)::varchar(1) as noservkbn,
    substr(raw_data, 25, 1)::varchar(1) as tkbtjuchutyusi,
    substr(raw_data, 26, 1)::varchar(1) as seskhuka,
    substr(raw_data, 27, 3)::varchar(3) as tanchk,
    substr(raw_data, 30, 1)::varchar(1) as ctlgmskbn,
    substr(raw_data, 31, 1)::varchar(1) as hanbaityusi,
    substr(raw_data, 32, 1)::varchar(1) as anznyo,
    substr(raw_data, 33, 1)::varchar(1) as wariyoflg,
    substr(raw_data, 34, 1)::varchar(1) as kgigntsyukka,
    substr(raw_data, 35, 8)::varchar(8) as kgignt,
    substr(raw_data, 43, 1)::varchar(1) as tkskbn,
    substr(raw_data, 44, 16)::varchar(16) as mtuserid,
    substr(raw_data, 60, 26)::varchar(26) as mttime,
    ldts,
    line_number
  from {{ source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvs00m2')}}
)
select * from substr_ktrla01vzz0kvs00m2