{{
  config(
    materialized='incremental',
    unique_key = ['skkcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_shikaku as (
    select
        skkcd::varchar(2) as skkcd,
        skktkkbncd::varchar(1) as skktkkbncd,
        skknam::varchar(16) as skknam,
        rskskknam::varchar(8) as rskskknam,
        skkno::varchar(2) as skkno,
        ldts,
        row_number() over(partition by skkcd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20066')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20066')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_shikaku where aggkey = 1
