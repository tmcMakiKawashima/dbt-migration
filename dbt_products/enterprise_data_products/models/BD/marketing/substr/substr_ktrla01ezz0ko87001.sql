with substr_ktrla01ezz0ko87001 as (
  select
    substr(raw_data, 1, 8)::varchar(8) as tsinseiymd,
    substr(raw_data, 9, 32)::varchar(32) as shataino,
    substr(raw_data, 41, 2)::varchar(2) as gyomucd,
    substr(raw_data, 43, 3)::varchar(3) as jikenshameicd,
    substr(raw_data, 46, 1)::varchar(1) as syaryojhkbn,
    ldts
  from {{source('snowpipe_db_marketing', 'raw_ktrla01ezz0ko87001')}}
)
 
select * from substr_ktrla01ezz0ko87001