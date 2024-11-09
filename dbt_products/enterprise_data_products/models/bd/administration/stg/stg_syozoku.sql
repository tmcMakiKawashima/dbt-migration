{{
  config(
    materialized='incremental',
    unique_key = ['szcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_syozoku as (
    select
        szcd::varchar(5) as szcd,
        szstaymd::varchar(8) as szstaymd,
        szendymd::varchar(8) as szendymd,
        bucd::varchar(2) as bucd,
        stkcd::varchar(3) as stkcd,
        kkrgcd::varchar(4) as kkrgcd,
        kmcd::varchar(5) as kmcd,
        ltstszgtf::varchar(1) as ltstszgtf,
        ldts,
        row_number() over(partition by szcd
                       order by ldts desc, szstaymd desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20087')}}
    where szstaymd <= to_varchar(current_date,'yyyymmdd')
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20087')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syozoku where aggkey = 1
