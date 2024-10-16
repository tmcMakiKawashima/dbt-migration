{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
where 
(year,month,jpn_local_div) in (
select 
year,month,jpn_local_div
from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_vehicle_class_group') }}
where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_vehicle_class_group') }})
group by year,month,jpn_local_div
)
{% endif %}
"
) }}

with stg_syameigroup_nippo as (
select 
send_date::varchar(20) as send_date,
ymd::varchar(10) as ymd,
year::varchar(4) as year,
month::varchar(2) as month,
day::varchar(2) as day,
to_number(jpn_local_div)::number(38,0) as jpn_local_div,
jpn_local::varchar(255) as jpn_local,
areacd::varchar(1) as areacd,
area::varchar(10) as area,
area_display_name::varchar(255) as area_display_name,
country_cd::varchar(3) as country_cd,
country::varchar(255) as country,
psc::varchar(2) as psc,
affiliate_cd::varchar(2) as affiliate_cd,
affiliate::varchar(255) as affiliate,
affiliate_e::varchar(255) as affiliate_e,
plant_cd::varchar(2) as plant_cd,
plant::varchar(255) as plant,
plant_e::varchar(255) as plant_e,
line_cd::varchar(1) as line_cd,
line::varchar(255) as line,
line_e::varchar(255) as line_e,
geoss_line::varchar(5) as geoss_line,
op_type_cd::varchar(1) as op_type_cd,
company::varchar(255) as company,
to_number(shift_cd)::number(38,0) as shift_cd,
daily_report_car_grcd::varchar(10) as daily_report_car_grcd,
daily_report_car_gr::varchar(255) as daily_report_car_gr,
to_number(vol_plan)::number(38,0) as vol_plan,
to_number(vol_result)::number(38,0) as vol_result,
to_number(vol_diff)::number(38,0) as vol_diff,
to_number(vol_final)::number(38,0) as vol_final,
to_number(accum_plan)::number(38,0) as accum_plan,
to_number(accum_result)::number(38,0) as accum_result,
to_number(accum_diff)::number(38,0) as accum_diff,
to_number(accum_inspection)::number(38,0) as accum_inspection,
to_number(accum_result_minus_inspe)::number(38,0) as accum_result_minus_inspe,
to_number(accum_stock)::number(38,0) as accum_stock,
to_number(takt_master,9,2)::number(9,2) as takt_master,
to_number(pcd_confirmed)::number(38,0) as pcd_confirmed,
to_number(no_recieve)::number(38,0) as no_recieve,
to_number(oem)::number(38,0) as oem,
to_number(area_sort)::number(38,0) as area_sort,
to_number(line_sort)::number(38,0) as line_sort,
to_number(d_rep_car_sort)::number(38,0) as d_rep_car_sort,
ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
send_date,ymd,jpn_local_div,areacd,country_cd,psc,affiliate_cd,plant_cd,line_cd,daily_report_car_grcd
order by line_number desc
) aggkey
from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_vehicle_class_group') }}
where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_t_daily_prod_vehicle_class_group') }})
)
select * exclude(aggkey)
from stg_syameigroup_nippo
where aggkey = 1
