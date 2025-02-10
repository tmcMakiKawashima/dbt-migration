with substr_hostalc_1w_dkae02072401 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as pscexlk,
    substr(raw_data, 2, 1)::varchar(1) as plantcode,
    substr(raw_data, 3, 2)::varchar(2) as idline,
    substr(raw_data, 5, 10)::varchar(10) as urn,
    substr(raw_data, 15, 8)::varchar(8) as lodate,
    substr(raw_data, 23, 1)::varchar(1) as odrtype,
    substr(raw_data, 24, 2)::varchar(2) as vehcategorycode,
    substr(raw_data, 26, 14)::varchar(14) as updateymdel14dg,
    ldts
  from {{source('snowpipe_db_supplydemand', 'raw_hostalc_1w_dkae02072401')}}
)

select * from substr_hostalc_1w_dkae02072401