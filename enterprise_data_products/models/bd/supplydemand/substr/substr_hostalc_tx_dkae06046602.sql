with substr_hostalc_tx_dkae06046602 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as pscexlk,
    substr(raw_data, 2, 1)::varchar(1) as plantcode,
    substr(raw_data, 3, 10)::varchar(10) as urn,
    substr(raw_data, 13, 1)::varchar(1) as odrtype,
    substr(raw_data, 14, 2)::varchar(2) as vehcategorycode,
    substr(raw_data, 16, 14)::varchar(14) as updateymdel14dg,
    ldts
  from {{source('snowpipe_db_supplydemand', 'raw_hostalc_tx_dkae06046602')}}
)

select * from substr_hostalc_tx_dkae06046602