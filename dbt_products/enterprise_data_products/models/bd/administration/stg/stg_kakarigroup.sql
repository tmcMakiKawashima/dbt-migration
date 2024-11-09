{{
  config(
    materialized='incremental',
    unique_key = ['kkrgcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_kakarigroup as (
    select
        kkrgcd::varchar(4) as kkrgcd,
        kkrgcdstaymd::varchar(8) as kkrgcdstaymd,
        kkrgcdendymd::varchar(8) as kkrgcdendymd,
        sskkkrgnam::varchar(30) as sskkkrgnam,
        rskkrgnam::varchar(6) as rskkrgnam,
        kkrgloccd::varchar(3) as kkrgloccd,
        kkrgno::varchar(2) as kkrgno,
        kkrgkbncd::varchar(1) as kkrgkbncd,
        ltstszgtf::varchar(1) as ltstszgtf,
        ldts,
        row_number() over(partition by kkrgcd
                       order by ldts desc, kkrgcdstaymd desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20036')}}
    where kkrgcdstaymd <= to_varchar(current_date,'yyyymmdd')
    {% if is_incremental() %}
        and to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20036')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kakarigroup where aggkey = 1
