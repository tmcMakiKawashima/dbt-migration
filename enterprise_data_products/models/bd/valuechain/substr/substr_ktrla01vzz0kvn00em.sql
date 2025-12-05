with substr_ktrla01vzz0kvn00em as (
  select
    substr(raw_data, 1, 20)::varchar(20) as hinban,
    substr(raw_data, 21, 1)::varchar(1) as kaknoukbn,
    substr(raw_data, 22, 1)::varchar(1) as zaikomssign,
    substr(raw_data, 23, 7)::varchar(7) as zaikosu,        
    substr(raw_data, 30, 1)::varchar(1) as jcukzmssign,
    substr(raw_data, 31, 7)::varchar(7) as jknsu,          
    substr(raw_data, 38, 9)::varchar(9) as ksyuzsu,
    substr(raw_data, 47, 1)::varchar(1) as tknkruimssign,
    substr(raw_data, 48, 9)::varchar(9) as tknkruisu,      
    substr(raw_data, 57, 1)::varchar(1) as tkskruimssign,
    substr(raw_data, 58, 9)::varchar(9) as tkskruisu,      
    substr(raw_data, 67, 1)::varchar(1) as nsksutmssign,
    substr(raw_data, 68, 7)::varchar(7) as nsksutsu,       
    substr(raw_data, 75, 1)::varchar(1) as snttsmssign,
    substr(raw_data, 76, 7)::varchar(7) as snttssu,        
    substr(raw_data, 83, 1)::varchar(1) as torsaimssign,
    substr(raw_data, 84, 7)::varchar(7) as torsaisu,       
    substr(raw_data, 91, 1)::varchar(1) as kpksutmssign,
    substr(raw_data, 92, 7)::varchar(7) as kpksutsu,       
    substr(raw_data, 99, 1)::varchar(1) as skdmssign,
    substr(raw_data, 100, 7)::varchar(7) as skdsu,         
    substr(raw_data, 107, 1)::varchar(1) as jcukztsruimsign,
    substr(raw_data, 108, 7)::varchar(7) as jcukztsruisu,  
    substr(raw_data, 115, 16)::varchar(16) as mtuserid,
    substr(raw_data, 131, 26)::varchar(26) as mttime,
    substr(raw_data, 157, 24)::varchar(24) as filler,
    ldts,
    line_number
  from {{ source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvn00em')}}
)
select * from substr_ktrla01vzz0kvn00em