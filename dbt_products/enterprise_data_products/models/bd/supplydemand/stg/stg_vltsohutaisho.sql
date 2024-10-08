{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
{% endif %}
"
) }}
with stg_vltsohutaisho as (
select
mtkbn::varchar(1) as mtkbn 
,rtrim(line_id, ' 　')::varchar(2) as line_id 
,rtrim(ymd, ' 　')::varchar(8) as ymd 
,rtrim(skei, ' 　')::varchar(2) as skei 
,rtrim(seisankara, ' 　')::varchar(8) as seisankara 
,rtrim(seisanmade, ' 　')::varchar(8) as seisanmade 
,rtrim(maker, ' 　')::varchar(4) as maker 
,try_to_timestamp_ntz(ldg_time,'yyyymmddhh24missff9')::timestamp_ntz(9) as ldg_time
,ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
line_id,ymd
order by line_number desc
) aggkey    
from {{ref('substr_tsjfa394')}}
where ldts = (select max(ldts) from {{ref('substr_tsjfa394')}})
)
select * exclude(aggkey) from stg_vltsohutaisho
where aggkey = 1