{{
  config(
    materialized='incremental',
    unique_key = ['employee_cd','h2ym'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_kintai_daily as (
    select
        emplid::varchar(7) as employee_cd,
        h2ym::varchar(6) as h2ym,
        h2gmjtltszcd::varchar(5) as h2gmjtltszcd,
        h2trkmtd::varchar(1) as h2trkmtd,
        h2trkmtdini::varchar(1) as h2trkmtdini,
        h2gtjknterrflg::varchar(1) as h2gtjknterrflg,
        h2kntkakuteiflg::varchar(1) as h2kntkakuteiflg,
        h2gtjknttsiflg::varchar(1) as h2gtjknttsiflg,
        h2mkzgysijtm::number(5,0) as h2mkzgysijtm,
        h2knmtimcd::varchar(1) as h2knmtimcd,
        h2shtrodnis::number(2,0) as h2shtrodnis,
        h2sknis::number(2,0) as h2sknis,
        h2kyskan::number(3,1) as h2kyskan,
        h2kystm::number(5,0) as h2kystm,
        h2frksyknis::number(2,0) as h2frksyknis,
        h2frksktm::number(5,0) as h2frksktm,
        h2nenkyu::number(3,1) as h2nenkyu,
        h2tky0::number(2,0) as h2tky0,
        h2sybkknnis::number(2,0) as h2sybkknnis,
        h2tkkstirgykan::number(2,0) as h2tkkstirgykan,
        h2tkkstirgytm::number(5,0) as h2tkkstirgytm,
        h2znyttm::number(5,0) as h2znyttm,
        h2actzntm::number(5,0) as h2actzntm,
        h2snykntm::number(5,0) as h2snykntm,
        h2sytgsnykntm::number(5,0) as h2sytgsnykntm,
        h2htrsytrodtm::number(5,0) as h2htrsytrodtm,
        h2sourodtm::number(5,0) as h2sourodtm,
        h2sytrodtm::number(5,0) as h2sytrodtm,
        h2sytnrod::number(5,0) as h2sytnrod,
        h2hakenmotoknmtm::number(5,0) as h2hakenmotoknmtm,
        h2hakenmotozantm::number(5,0) as h2hakenmotozantm,
        h2brktmmky::number(5,0) as h2brktmmky,
        h2linzntm::number(5,0) as h2linzntm,
        h2jynbtm::number(5,0) as h2jynbtm,
        h2atshmtstm::number(5,0) as h2atshmtstm,
        h2qctm::number(5,0) as h2qctm,
        h2ittm::number(5,0) as h2ittm,
        h2bikost::varchar(2) as h2bikost,
        h2sgyosts::varchar(1) as h2sgyosts,
        h2gmtkknf::varchar(1) as h2gmtkknf,
        h2gtjinpymd::varchar(8) as h2gtjinpymd,
        h2gtjinptim::varchar(4) as h2gtjinptim,
        h2gtjinpjcd::varchar(7) as h2gtjinpjcd,
        h2gmsynflg::varchar(1) as h2gmsynflg,
        h2gtjsynymd::varchar(8) as h2gtjsynymd,
        h2gtjsyntim::varchar(4) as h2gtjsyntim,
        h2gtjsynhnrjcd::varchar(7) as h2gtjsynhnrjcd,
        h2gtjsynhnrszcd::varchar(5) as h2gtjsynhnrszcd,
        h2gtjsynjcd::varchar(7) as h2gtjsynjcd,
        h2gtjsynszcd::varchar(5) as h2gtjsynszcd,
        ldts,
        row_number() over(partition by employee_cd,h2ym
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20061')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20070')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kintai_daily where aggkey = 1
