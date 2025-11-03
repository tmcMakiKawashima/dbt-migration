with substr_hostalc_1k_dkae02072402 as (
  select
    substr(raw_data, 1, 1)::varchar(1) as pscexlk,
    substr(raw_data, 2, 1)::varchar(1) as plantcode,
    substr(raw_data, 3, 10)::varchar(10) as urn,
    substr(raw_data, 13, 5)::varchar(5) as dfsc,
    substr(raw_data, 18, 2)::varchar(2) as sno,
    substr(raw_data, 20, 2)::varchar(2) as idline,
    substr(raw_data, 22, 20)::varchar(20) as ctlkata,
    substr(raw_data, 42, 4)::varchar(4) as intcode,
    substr(raw_data, 46, 4)::varchar(4) as extcode,
    substr(raw_data, 50, 200)::varchar(200) as spec,
    substr(raw_data, 250, 4)::varchar(4) as carfamily,
    substr(raw_data, 254, 5)::varchar(5) as destcode,
    substr(raw_data, 259, 2)::varchar(2) as carname,
    substr(raw_data, 261, 1)::varchar(1) as figure,
    substr(raw_data, 262, 1)::varchar(1) as unittype,
    substr(raw_data, 263, 2)::varchar(2) as equipmentline,
    substr(raw_data, 265, 1)::varchar(1) as scndasmvtp,
    substr(raw_data, 266, 8)::varchar(8) as lodate,
    substr(raw_data, 274, 1)::varchar(1) as offopttype,
    substr(raw_data, 275, 1)::varchar(1) as importduty,
    substr(raw_data, 276, 1)::varchar(1) as discsign,
    substr(raw_data, 277, 1)::varchar(1) as ordcycl,
    substr(raw_data, 278, 1)::varchar(1) as odrtype,
    substr(raw_data, 279, 2)::varchar(2) as vehcategorycode,
    substr(raw_data, 281, 14)::varchar(14) as updateymdel14dg,
    ldts
  from {{source('snowpipe_db_supplydemand', 'raw_hostalc_1k_dkae02072402')}}
)

select * from substr_hostalc_1k_dkae02072402