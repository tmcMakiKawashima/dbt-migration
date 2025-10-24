{{ config(
      materialized='incremental',
      unique_key = ['jigyoutai','syasyu','siyoubui','torokujunk'],
      incremental_strategy = 'merge'
  )
 }}

with stg_honsisitu_gijutsusms as (
    select
        jigyoutai::varchar(2) as jigyoutai, --なし
        syasyu::varchar(4) as syasyu, --なし
        siyoubui::varchar(10) as siyoubui, --なし
        sekkei::varchar(5) as sekkei, --なし
        torokujunk::varchar(9) as torokujunk, --なし
        torokujunm::varchar(9) as torokujunm, --なし
        mttime::varchar(16) as mttime, --なし
        'sms-gijyutsu'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp03honsisitu') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_honsisitu_gijutsusms