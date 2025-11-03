{{
  config(
    materialized='incremental',
    unique_key = ['employee_cd','h2gtjkntym','h2knmtimcd'],
    incremental_strategy = 'append',
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
}}

with stg_kintai_monthly as (
    select
        emplid::varchar(7) as employee_cd,
        h2gtjkntym::varchar(6) as h2gtjkntym,
        h2knmtimcd::varchar(1) as h2knmtimcd,
        h2kyuynis::number(2,0) as h2kyuynis,
        h2sknis::number(3,1) as h2sknis,
        h2kyskan::number(2,0) as h2kyskan,
        h2kystm::number(5,0) as h2kystm,
        h2frksyknis::number(2,0) as h2frksyknis,
        h2frksktm::number(5,0) as h2frksktm,
        h2nenkyu::number(3,1) as h2nenkyu,
        h2nkytm::number(5,0) as h2nkytm,
        h2tky100::number(2,0) as h2tky100,
        h2tky100tm::number(5,0) as h2tky100tm,
        h2tky90::number(2,0) as h2tky90,
        h2tky0::number(2,0) as h2tky0,
        h2sybkknnis::number(2,0) as h2sybkknnis,
        h2jikkknnis::number(2,0) as h2jikkknnis,
        h2mdnkknnis::number(2,0) as h2mdnkknnis,
        h2flexfscnt::number(2,0) as h2flexfscnt,
        h2flexfstm::number(5,0) as h2flexfstm,
        h2kntnsykcnt::number(2,0) as h2kntnsykcnt,
        h2kntnsyktm::number(5,0) as h2kntnsyktm,
        h2kyuytkkstirgykan::number(2,0) as h2kyuytkkstirgykan,
        h2kyuytkkstirgytm::number(5,0) as h2kyuytkkstirgytm,
        h2tkkstirgykan::number(2,0) as h2tkkstirgykan,
        h2tkkstirgytm::number(5,0) as h2tkkstirgytm,
        h2bsirgycnt::number(2,0) as h2bsirgycnt,
        h2bsirgytm::number(5,0) as h2bsirgytm,
        h2chknmtm::number(5,0) as h2chknmtm,
        h2snykntm::number(5,0) as h2snykntm,
        h2tkwrmtm::number(5,0) as h2tkwrmtm,
        h2utmsistm::number(5,0) as h2utmsistm,
        h2jsknm125tm::number(5,0) as h2jsknm125tm,
        h2jsknm175tm::number(5,0) as h2jsknm175tm,
        h2jsknm25tm::number(5,0) as h2jsknm25tm,
        h2jsknm35tm::number(5,0) as h2jsknm35tm,
        h2ksadgstltm::number(5,0) as h2ksadgstltm,
        h2ptjitm::number(5,0) as h2ptjitm,
        h2ptnkytm::number(5,0) as h2ptnkytm,
        h2pttky100tm::number(5,0) as h2pttky100tm,
        h2pttky90tm::number(5,0) as h2pttky90tm,
        h2pttky0tm::number(5,0) as h2pttky0tm,
        h2acttyokntm100p::number(5,0) as h2acttyokntm100p,
        h2htrsytrodtm::number(5,0) as h2htrsytrodtm,
        h2sourodtm::number(5,0) as h2sourodtm,
        h2sytrodtm::number(5,0) as h2sytrodtm,
        h2sytnrod::number(5,0) as h2sytnrod,
        h2sytgsnykntm::number(5,0) as h2sytgsnykntm,
        h2brkykytm::number(5,0) as h2brkykytm,
        h2linzntm::number(5,0) as h2linzntm,
        h2jynbtm::number(5,0) as h2jynbtm,
        h2atshmtstm::number(5,0) as h2atshmtstm,
        h2qctm::number(5,0) as h2qctm,
        h2ittm::number(5,0) as h2ittm,
        ldts,
        row_number() over(partition by employee_cd,h2gtjkntym,h2knmtimcd
                       order by ldts desc, line_number desc) as aggkey
    from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20060')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20060')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_kintai_monthly where aggkey = 1
