{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
{% endif %}
"
) }}

with stg_chiiki as (
select 
send_date::varchar(20) as send_date,
areacd::varchar(1) as areacd,
area::varchar(10) as area,
area_display_name::varchar(255) as area_display_name,
to_number(area_display_flg,11,0)::number(11,0) as area_display_flg,
to_number(area_sort,11,0)::number(11,0) as area_sort,
ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
send_date,areacd
order by line_number desc
) aggkey
from {{ source('snowpipe_db_supplydemand','raw_m_area') }}
where ldts = (select max(ldts) from {{ source('snowpipe_db_supplydemand','raw_m_area') }})
)
select * exclude(aggkey)
from stg_chiiki
where aggkey = 1
