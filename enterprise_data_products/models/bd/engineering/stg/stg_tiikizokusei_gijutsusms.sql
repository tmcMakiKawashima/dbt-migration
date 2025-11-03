{{ config(
      materialized='incremental',
      unique_key = ['tiikizoku'],
      incremental_strategy = 'merge'
  )
 }}

with stg_tiikizokusei_gijutsusms as (
    select
        tiikizoku::varchar(1) as tiikizoku, --なし
        tiikimeijp::varchar(10) as tiikimeijp, --なし
        tiikimeien::varchar(20) as tiikimeien, --なし
        torokuymd::varchar(8) as torokuymd, --なし
        haisiymd::varchar(8) as haisiymd, --なし
        mttime::varchar(16) as mttime, --なし
        'sms-koutei'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp26tiikizoku') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_tiikizokusei_gijutsusms