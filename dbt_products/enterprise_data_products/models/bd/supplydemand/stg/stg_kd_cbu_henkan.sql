{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
{% endif %}
"
) }}

with stg_kd_cbu_henkan as (
select 
send_date::varchar(20) as send_date,
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
shimukechi_cd::varchar(4) as shimukechi_cd,
syasyu_cd::varchar(4) as syasyu_cd,
sno::varchar(2) as sno,
syamei::varchar(2) as syamei,
to_number(model_name_cd)::number(38,0) as model_name_cd,
to_number(no_model_m)::number(1,0) as no_model_m,
jpn_areacd::varchar(1) as jpn_areacd,
jpn_area::varchar(10) as jpn_area,
jpn_area_display_name::varchar(255) as jpn_area_display_name,
jpn_country_cd::varchar(3) as jpn_country_cd,
jpn_country::varchar(255) as jpn_country,
jpn_psc::varchar(2) as jpn_psc,
jpn_affiliate_cd::varchar(2) as jpn_affiliate_cd,
jpn_affiliate::varchar(255) as jpn_affiliate,
jpn_affiliate_e::varchar(255) as jpn_affiliate_e,
jpn_plant_cd::varchar(2) as jpn_plant_cd,
jpn_plant::varchar(255) as jpn_plant,
jpn_plant_e::varchar(255) as jpn_plant_e,
jpn_line_cd::varchar(1) as jpn_line_cd,
jpn_line::varchar(255) as jpn_line,
jpn_line_e::varchar(255) as jpn_line_e,
jpn_geoss_line::varchar(5) as jpn_geoss_line,
to_number(jpn_model_name_cd)::number(38,0) as jpn_model_name_cd,
to_number(no_jpn_m)::number(1,0) as no_jpn_m,
jpn_syasyu_cd::varchar(4) as jpn_syasyu_cd,
jpn_sno::varchar(2) as jpn_sno,
jpn_syamei::varchar(2) as jpn_syamei,
to_number(area_sort)::number(38,0) as area_sort,
to_number(line_sort)::number(38,0) as line_sort,
to_number(result_model_sort)::number(38,0) as result_model_sort,
ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
send_date,areacd,country_cd,psc,affiliate_cd,plant_cd,line_cd,geoss_line,shimukechi_cd,syasyu_cd,sno,syamei,jpn_syasyu_cd,jpn_sno,jpn_syamei
order by line_number desc
) aggkey
from {{ source('snowpipe_db_supplydemand','raw_m_convert_kd_cbu') }}
where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_convert_kd_cbu') }})
)
select * exclude(aggkey)
from stg_kd_cbu_henkan
where aggkey = 1
