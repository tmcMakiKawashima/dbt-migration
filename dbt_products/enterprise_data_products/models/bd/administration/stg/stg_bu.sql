{{
  config(
    materialized='incremental',
    unique_key = ['bucd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_bu as (
    select
        bucd::varchar(2) as bucd,
        bucdstaymd::varchar(8) as bucdstaymd,
        bucdendymd::varchar(8) as bucdendymd,
        sskbunam1::varchar(30) as sskbunam1,
        sskbunam2::varchar(30) as sskbunam2,
        sskbunam3::varchar(100) as sskbunam3,
        rskbunam::varchar(6) as rskbunam,
        bukhnmrk::varchar(2) as bukhnmrk,
        bmncd::varchar(2) as bmncd,
        buloccd::varchar(3) as buloccd,
        buno::varchar(3) as buno,
        ykinno::varchar(2) as ykinno,
        sbtjinbmn::varchar(2) as sbtjinbmn,
        tysibmnnoa::varchar(2) as tysibmnnoa,
        tysibmnnob::varchar(2) as tysibmnnob,
        tysibmnnoc::varchar(2) as tysibmnnoc,
        tysibmnnod::varchar(2) as tysibmnnod,
        sktsskcdkok::varchar(2) as sktsskcdkok,
        sktsskcdsykk::varchar(2) as sktsskcdsykk,
        sktsskcdido::varchar(2) as sktsskcdido,
        sktsskcdkns::varchar(2) as sktsskcdkns,
        sgsyakyjigcd::varchar(3) as sgsyakyjigcd,
        ltstszgtf::varchar(1) as ltstszgtf,
        ktnjjrgto::varchar(2) as ktnjjrgto,
        ktnjjksinp::varchar(2) as ktnjjksinp,
        ldts,
        row_number() over(partition by bucd
                       order by ldts desc, bucdstaymd desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20056')}}
    where bucdstaymd <= to_varchar(current_date,'yyyymmdd')
    {% if is_incremental() %}
        and to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20056')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_bu where aggkey = 1
