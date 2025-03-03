{{
  config(
    materialized='incremental',
    unique_key = ['sykscd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_syokusyu as (
    select
        sykscd::varchar(2) as sykscd,
        syksnam::varchar(20) as syksnam,
        ldts,
        row_number() over(partition by sykscd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20064')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20064')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syokusyu where aggkey = 1
