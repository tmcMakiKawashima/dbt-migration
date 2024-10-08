{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
{% endif %}
"
) }}
with stg_orderkakutei_shihan as (
select
sno::varchar(2) as sno
,rtrim(syamei, ' 　')::varchar(2) as syamei
,rtrim(ktai, ' 　')::varchar(8) as ktai
,rtrim(seisankara, ' 　')::varchar(8) as seisankara
,rtrim(seisanmade, ' 　')::varchar(8) as seisanmade
,rtrim(kaktei, ' 　')::varchar(2) as kaktei
,try_to_timestamp_ntz(ldg_time,'yyyymmddhh24missff9')::timestamp_ntz(9) as ldg_time
,ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
sno,syamei,ktai
order by line_number desc
) aggkey 
from {{ref('substr_tsjfa36d')}}
where ldts = (select max(ldts) from {{ref('substr_tsjfa36d')}})
)
select * exclude(aggkey) from stg_orderkakutei_shihan
where aggkey = 1