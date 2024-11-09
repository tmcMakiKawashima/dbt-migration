{{
  config(
    materialized='incremental',
    unique_key = ['stkcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_shitsuka as (
    select
        stkcd::varchar(3) as stkcd,
        stkcdstaymd::varchar(8) as stkcdstaymd,
        stkcdendymd::varchar(8) as stkcdendymd,
        sskstknam::varchar(30) as sskstknam,
        rskstknam::varchar(6) as rskstknam,
        skhnmrk::varchar(2) as skhnmrk,
        stkloccd::varchar(3) as stkloccd,
        stkno::varchar(2) as stkno,
        stkkbncd::varchar(1) as stkkbncd,
        ltstszgtf::varchar(1) as ltstszgtf,
        ldts,
        row_number() over(partition by stkcd
                       order by ldts desc, stkcdstaymd desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20034')}}
    where stkcdstaymd <= to_varchar(current_date,'yyyymmdd')
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20034')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_shitsuka where aggkey = 1
