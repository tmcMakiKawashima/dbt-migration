{{
  config(
    materialized='incremental',
    unique_key = ['stptkbncd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_syokutakupart as (
    select
        stptkbncd::varchar(2) as stptkbncd,
        stptkbnnam::varchar(20) as stptkbnnam,
        stptkbncdcmt::varchar(100) as stptkbncdcmt,
        ldts,
        row_number() over(partition by stptkbncd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20065')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syokutakupart where aggkey = 1
