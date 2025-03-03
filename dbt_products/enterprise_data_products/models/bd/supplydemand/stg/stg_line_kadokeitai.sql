{{ config(
materialized='incremental',
incremental_strategy = 'append',
pre_hook = "
{% if is_incremental() %}
delete from {{this}}
{% endif %}
"
) }}

with stg_line_kadokeitai as (
select
mtkbn::varchar(1) as mtkbn
,rtrim(line_id, ' 　')::varchar(2) as line_id
,rtrim(tkkara, ' 　')::varchar(8) as tkkara
,rtrim(tkmade, ' 　')::varchar(8) as tkmade
,rtrim(choku, ' 　')::varchar(2) as choku
,rtrim(nsuu, ' 　')::varchar(2) as nsuu
,rtrim(mtymd, ' 　')::varchar(8) as mtymd
,try_to_timestamp_ntz(ldg_time,'yyyymmddhh24missff9')::timestamp_ntz(9) as ldg_time
,ldts::timestamp_ntz(9) as ldts,
row_number() over (
partition by
line_id,tkkara
order by line_number desc
) aggkey 
from {{ref('substr_tsjfa396')}}
where ldts = (select max(ldts) from {{ref('substr_tsjfa396')}})
)
select * exclude(aggkey) from stg_line_kadokeitai
where aggkey = 1