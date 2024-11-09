{{
  config(
    materialized='incremental',
    unique_key = ['bmncd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_bumon as (
    select
        bmncd::varchar(2) as bmncd,
        bmnstaymd::varchar(8) as bmnstaymd,
        bmnendymd::varchar(8) as bmnendymd,
        bmnnam::varchar(30) as bmnnam,
        rskbmnnam::varchar(6) as rskbmnnam,
        bmnno::varchar(2) as bmnno,
        ldts,
        row_number() over(partition by bmncd
                       order by ldts desc, bmnstaymd desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20055')}}
    where bmnstaymd <= to_varchar(current_date,'yyyymmdd')
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20055')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_bumon where aggkey = 1
