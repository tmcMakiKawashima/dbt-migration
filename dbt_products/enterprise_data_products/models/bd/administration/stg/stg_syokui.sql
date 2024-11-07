{{
  config(
    materialized='incremental',
    unique_key = ['sykicd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_syokui as (
    select
        sykicd::varchar(3) as sykicd,
        sykinam::varchar(32) as sykinam,
        rsksykinam::varchar(12) as rsksykinam,
        mnstkbncd::varchar(1) as mnstkbncd,
        ldts,
        row_number() over(partition by sykicd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20067')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_syokui where aggkey = 1
