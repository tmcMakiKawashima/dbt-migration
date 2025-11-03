with substr_hostalc_1k_dkae06047201 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as pscexlk,
    substr(raw_data, 2, 1)::varchar(1) as plantcode,
    substr(raw_data, 3, 1)::varchar(1) as line,
    substr(raw_data, 4, 2)::varchar(2) as tp,
    substr(raw_data, 6, 2)::varchar(2) as idline,
    substr(raw_data, 8, 8)::varchar(8) as ndate,
    substr(raw_data, 16, 1)::varchar(1) as shift,
    substr(raw_data, 17, 4)::varchar(4) as ppbodies,
    substr(raw_data, 21, 1)::varchar(1) as actpliniflg,
    substr(raw_data, 22, 4)::varchar(4) as actplbodies,
    substr(raw_data, 26, 4)::varchar(4) as pactbodies,
    substr(raw_data, 30, 8)::varchar(8) as progdate,
    substr(raw_data, 38, 1)::varchar(1) as progsh,
    substr(raw_data, 39, 4)::varchar(4) as progbodies,
    substr(raw_data, 43, 1)::varchar(1) as entflg,
    substr(raw_data, 44, 20)::varchar(20) as creauser,
    substr(raw_data, 64, 12)::varchar(12) as creadateeln12d,
    substr(raw_data, 76, 12)::varchar(12) as updateymdeln12d,
    ldts
  from {{source('snowpipe_db_supplydemand', 'raw_hostalc_1k_dkae06047201')}}
)

select * from substr_hostalc_1k_dkae06047201