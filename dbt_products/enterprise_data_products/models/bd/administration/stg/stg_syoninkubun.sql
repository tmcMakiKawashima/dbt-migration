{{
  config(
    materialized='incremental',
    unique_key = ['sykicd','slkbncd','synrnkcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_syoninkubun as (
    select
        sykicd::varchar(3) as sykicd,
        slkbncd::varchar(1) as slkbncd,
        synrnkcd::varchar(1) as synrnkcd,
        ldts,
        row_number() over(partition by sykicd,slkbncd,synrnkcd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20068')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syoninkubun where aggkey = 1
