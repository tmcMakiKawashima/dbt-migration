{{
  config(
    materialized='incremental',
    unique_key = ['employee_cd','h2ytstayr','h2ytstamon','h2ytstadt','h2staampmflg','h2ytseqno'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_kyumurigyo_sk as (
    select
        emplid::varchar(7) as employee_cd,
        h2ytstayr::varchar(4) as h2ytstayr,
        h2ytstamon::varchar(2) as h2ytstamon,
        h2ytstadt::varchar(2) as h2ytstadt,
        h2staampmflg::varchar(1) as h2staampmflg,
        h2ytseqno::number(4,0) as h2ytseqno,
        h2ytendyr::varchar(4) as h2ytendyr,
        h2ytendmon::varchar(2) as h2ytendmon,
        h2ytenddt::varchar(2) as h2ytenddt,
        h2endampmflg::varchar(1) as h2endampmflg,
        h2statim::varchar(4) as h2statim,
        h2edtim::varchar(4) as h2edtim,
        h2nenkyu::number(3,1) as h2nenkyu,
        h2kntsnconcd::varchar(4) as h2kntsnconcd,
        h2sncclflg::varchar(1) as h2sncclflg,
        h2bikost::varchar(2) as h2bikost,
        h2kntsnreason::varchar(254) as h2kntsnreason,
        h2entymd::varchar(8) as h2entymd,
        ldts,
        row_number() over(partition by employee_cd,h2ytstayr,h2ytstamon,h2ytstadt,h2staampmflg,h2ytseqno
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20058')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kyumurigyo_sk where aggkey = 1
