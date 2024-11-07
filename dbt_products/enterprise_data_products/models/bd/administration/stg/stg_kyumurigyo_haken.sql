{{
  config(
    materialized='incremental',
    unique_key = ['syagai_cd','h2ym','h2dt','h2kntsncnt'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_kyumurigyo_haken as (
    select
        emplid::varchar(7) as syagai_cd,
        h2ym::varchar(6) as h2ym,
        h2dt::varchar(2) as h2dt,
        h2kntsncnt::number(4,0) as h2kntsncnt,
        h2staampmflg::varchar(1) as h2staampmflg,
        h2edym::varchar(6) as h2edym,
        h2eddt::varchar(2) as h2eddt,
        h2endampmflg::varchar(1) as h2endampmflg,
        h2nenkyu::number(3,1) as h2nenkyu,
        h2kntsnconcd::varchar(4) as h2kntsnconcd,
        h2sncclflg::varchar(1) as h2sncclflg,
        h2kntsnreason::varchar(254) as h2kntsnreason,
        h2snymd::varchar(8) as h2snymd,
        h2synst::varchar(1) as h2synst,
        h2synjcd::varchar(7) as h2synjcd,
        h2synymd::varchar(8) as h2synymd,
        h2bikost::varchar(2) as h2bikost,
        ldts,
        row_number() over(partition by syagai_cd,h2ym,h2dt,h2kntsncnt
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20059')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kyumurigyo_haken where aggkey = 1
