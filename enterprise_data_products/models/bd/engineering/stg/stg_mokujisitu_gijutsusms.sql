{{ config(
      materialized='incremental',
      unique_key = ['jigyoutai','syasyu32','syasyu','kumitate','bui','kata','torokujunk'],
      incremental_strategy = 'merge'
  )
 }}

with stg_mokujisitu_gijutsusms as (
    select
        jigyoutai::varchar(2) as jigyoutai, --なし
        syasyu32::varchar(2) as syasyu32, --なし
        syasyu::varchar(4) as syasyu, --なし
        kumitate::varchar(4) as kumitate, --なし
        bui::varchar(2) as bui, --なし
        kata::varchar(20) as kata, --なし
        sekkei::varchar(5) as sekkei, --なし
        torokujunk::varchar(9) as torokujunk, --なし
        torokujunm::varchar(9) as torokujunm, --なし
        mttime::varchar(16) as mttime, --なし
        'sms-gijyutsu'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp02mokujisitu') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_mokujisitu_gijutsusms