{{
  config(
    materialized='incremental',
    unique_key = ['employee_cd','idorekstaymd','syozoku_cd_honrai'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_ido_history as (
    select
        jcd::varchar(7) as employee_cd,
        idorekstaymd::varchar(8) as idorekstaymd,
        hriszcd::varchar(5) as syozoku_cd_honrai,
        htsskbunam1::varchar(30) as htsskbunam1,
        htsskstknam::varchar(30) as htsskstknam,
        sykicd::varchar(3) as sykicd,
        htrsksykinam::varchar(12) as htrsksykinam,
        slkbncd::varchar(1) as slkbncd,
        hriszkmuf::varchar(1) as hriszkmuf,
        knmendymd::varchar(8) as knmendymd,
        idokbncd::varchar(1) as idokbncd,
        idoriycd::varchar(3) as idoriycd,
        nowbnycd::varchar(3) as nowbnycd,
        hribnycd::varchar(3) as hribnycd,
        gymkbncd::varchar(2) as gymkbncd,
        kaisyacd::varchar(5) as kaisyacd,
        mdrflg::varchar(1) as mdrflg,
        hriszhnkf::varchar(1) as hriszhnkf,
        sykihnkf::varchar(1) as sykihnkf,
        slkbncdhnkf::varchar(1) as slkbncdhnkf,
        gymkbncdhnkf::varchar(1) as gymkbncdhnkf,
        kaisyacdhnkf::varchar(1) as kaisyacdhnkf,
        gbustaym::varchar(6) as gbustaym,
        gstkstaym::varchar(6) as gstkstaym,
        gkkrgstaym::varchar(6) as gkkrgstaym,
        gkmstaym::varchar(6) as gkmstaym,
        gnupuid::varchar(7) as gnupuid,
        gnuphztm::varchar(26) as gnuphztm,
        gnuppgm::varchar(8) as gnuppgm,
        ldts,
        row_number() over(partition by employee_cd,idorekstaymd,syozoku_cd_honrai
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20042')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20042')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_ido_history where aggkey = 1
