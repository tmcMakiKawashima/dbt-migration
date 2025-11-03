{{ config(
      materialized='incremental',
      unique_key = ['jtaizoku'],
      incremental_strategy = 'merge'
  )
 }}

with stg_jtaizokusei_gijutsusms as (
    select
        jtaizoku::varchar(2) as jtaizoku, --なし
        jtaifgo::varchar(2) as jtaifgo, --なし
        kunizoku::varchar(3) as kunizoku, --なし
        jtmeijp::varchar(10) as jtmeijp, --なし
        jtrykjp::varchar(5) as jtrykjp, --なし
        jtmeien::varchar(20) as jtmeien, --なし
        jtryken::varchar(10) as jtryken, --なし
        ktsetgyomflg::varchar(1) as ktsetgyomflg, --なし
        tktsetflg::varchar(1) as tktsetflg, --なし
        bmkbn::varchar(1) as bmkbn, --なし
        torokuymd::varchar(8) as torokuymd, --なし
        haisiymd::varchar(8) as haisiymd, --なし
        mttime::varchar(16) as mttime, --なし
        'sms-koutei'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp26jtaizoku') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_jtaizokusei_gijutsusms