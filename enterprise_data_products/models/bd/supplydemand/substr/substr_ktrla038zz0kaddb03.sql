with substr_ktrla038zz0kaddb03 as (
  select
    substr(raw_data, 1, 6)::varchar(6) as ym,
    substr(raw_data, 7, 2)::varchar(2) as caltimingkbn,
    substr(raw_data, 9, 2)::varchar(2) as shamei,
    substr(raw_data, 11, 2)::varchar(2) as sno,
    substr(raw_data, 13, 3)::varchar(3) as shinq,
    substr(raw_data, 16, 6)::varchar(6) as nijsym,
    substr(raw_data, 22, 7)::varchar(7) as kncode,
    substr(raw_data, 29, 5)::varchar(5) as seinasidai,
    substr(raw_data, 34, 5)::varchar(5) as seinasidaihi,
    substr(raw_data, 39, 5)::varchar(5) as sdai,
    substr(raw_data, 44, 5)::varchar(5) as seiaridai,
    substr(raw_data, 49, 5)::varchar(5) as seiaridaihi,
    substr(raw_data, 54, 3)::varchar(3) as fulllank,
    substr(raw_data, 57, 24)::varchar(24) as dummy,
    ldts,
    line_number
  from {{ source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kaddb03')}}
)
select * from substr_ktrla038zz0kaddb03