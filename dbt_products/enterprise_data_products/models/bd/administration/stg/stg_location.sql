{{
  config(
    materialized='incremental',
    unique_key = ['loccd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_location as (
    select
        loccd::varchar(3) as loccd,
        locnam::varchar(40) as locnam,
        rsk3locnam::varchar(6) as rsk3locnam,
        rsk1locnam::varchar(2) as rsk1locnam,
        chikicd::varchar(3) as chikicd,
        sykjtakbn::varchar(1) as sykjtakbn,
        tstetflg::varchar(1) as tstetflg,
        tdfkcd::varchar(2) as tdfkcd,
        knicd::varchar(3) as knicd,
        kytjjcd::varchar(2) as kytjjcd,
        ldts,
        row_number() over(partition by loccd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20043')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_location where aggkey = 1
