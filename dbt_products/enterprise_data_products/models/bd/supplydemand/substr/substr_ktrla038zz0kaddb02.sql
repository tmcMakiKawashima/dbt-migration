with substr_ktrla038zz0kaddb02 as (
  select
    substr(raw_data, 1, 6)::varchar(6) as ym,
    substr(raw_data, 7, 2)::varchar(2) as caltimingkbn,
    substr(raw_data, 9, 2)::varchar(2) as shamei,
    substr(raw_data, 11, 2)::varchar(2) as sno,
    substr(raw_data, 13, 3)::varchar(3) as shinq,
    substr(raw_data, 16, 7)::varchar(7) as datarbn_7keta,
    substr(raw_data, 23, 5)::varchar(5) as dlrcd,
    substr(raw_data, 28, 5)::varchar(5) as dlrcd_smksk,
    substr(raw_data, 33, 12)::varchar(12) as odno,
    substr(raw_data, 45, 7)::varchar(7) as kncodewk,
    substr(raw_data, 52, 6)::varchar(6) as seiriyomaxym,
    substr(raw_data, 58, 3)::varchar(3) as fulllank,
    substr(raw_data, 61, 20)::varchar(20) as dummy,
    ldts,
    line_number
  from {{ source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kaddb02')}}
)
select * from substr_ktrla038zz0kaddb02
