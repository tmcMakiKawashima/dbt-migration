{{ config(
      materialized='incremental',
      unique_key = ['kunizoku'],
      incremental_strategy = 'merge'
  )
 }}

with stg_kunizokusei_gijutsusms as (
    select
        kunizoku::varchar(3) as kunizoku, --なし
        tiikizoku::varchar(1) as tiikizoku, --なし
        kunimeijp::varchar(10) as kunimeijp, --なし
        kunimeien::varchar(20) as kunimeien, --なし
        torokuymd::varchar(8) as torokuymd, --なし
        haisiymd::varchar(8) as haisiymd, --なし
        mttime::varchar(16) as mttime, --なし
        'sms-koutei'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp26kunizoku') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_kunizokusei_gijutsusms