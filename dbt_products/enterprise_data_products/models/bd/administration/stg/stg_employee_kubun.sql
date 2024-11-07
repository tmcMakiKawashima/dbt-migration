{{
  config(
    materialized='incremental',
    unique_key = ['jigkbncd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_employee_kubun as (
    select
        jigkbncd::varchar(1) as jigkbncd,
        jigkbnnam::varchar(40) as jigkbnnam,
        ldts,
        row_number() over(partition by jigkbncd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20046')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_employee_kubun where aggkey = 1
