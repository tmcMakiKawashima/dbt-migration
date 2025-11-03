with substr_hostalc_8s_dkae02072301 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as pscexlk,
    substr(raw_data, 2, 1)::varchar(1) as plantcode,
    substr(raw_data, 3, 2)::varchar(2) as idline,
    substr(raw_data, 5, 2)::varchar(2) as tp,
    substr(raw_data, 7, 1)::varchar(1) as hostgalctp,
    substr(raw_data, 8, 8)::varchar(8) as physseqno,
    substr(raw_data, 16, 1)::varchar(1) as dataastmt,
    substr(raw_data, 17, 8)::varchar(8) as psdatepdt,
    substr(raw_data, 25, 1)::varchar(1) as psshfpdt,
    substr(raw_data, 26, 4)::varchar(4) as pstmpdt,
    substr(raw_data, 30, 8)::varchar(8) as psdatendt,
    substr(raw_data, 38, 10)::varchar(10) as urn,
    substr(raw_data, 48, 1)::varchar(1) as line,
    substr(raw_data, 49, 8)::varchar(8) as lodate,
    substr(raw_data, 57, 1)::varchar(1) as odrtype,
    substr(raw_data, 58, 2)::varchar(2) as vehcategorycode,
    substr(raw_data, 60, 14)::varchar(14) as updateymdel14dg,
    ldts
  from {{source('snowpipe_db_supplydemand', 'raw_hostalc_8s_dkae02072301')}}
)

select * from substr_hostalc_8s_dkae02072301