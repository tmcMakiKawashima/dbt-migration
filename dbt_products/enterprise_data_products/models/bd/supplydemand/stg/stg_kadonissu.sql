{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
{% endif %}
"
) }}

with stg_kadonissu as (
select 
send_date::varchar(20) as send_date,
to_number(jpn_local_div)::number(38,0) as jpn_local_div,
jpn_local::varchar(255) as jpn_local,
areacd::varchar(1) as areacd,
area::varchar(10) as area,
area_display_name::varchar(255) as area_display_name,
country_cd::varchar(3) as country_cd,
country::varchar(255) as country,
psc::varchar(2) as psc,
affiliate_cd::varchar(2) as affiliate_cd,
affiliate_e::varchar(255) as affiliate_e,
plant_cd::varchar(2) as plant_cd,
plant_e::varchar(255) as plant_e,
line_cd::varchar(1) as line_cd,
line_e::varchar(255) as line_e,
geoss_line::varchar(5) as geoss_line,
year::varchar(4) as year,
month::varchar(7) as month,
to_number(working_days,6,2)::number(6,2) as working_days,
to_number(area_sort)::number(38,0) as area_sort,
to_number(line_sort)::number(38,0) as line_sort,
ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
send_date,jpn_local_div,areacd,country_cd,psc,affiliate_cd,plant_cd,line_cd,year,month
order by line_number desc
) aggkey
from {{ source('snowpipe_db_supplydemand','raw_m_working_days') }}
where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_working_days') }})
)
select * exclude(aggkey)
from stg_kadonissu
where aggkey = 1
