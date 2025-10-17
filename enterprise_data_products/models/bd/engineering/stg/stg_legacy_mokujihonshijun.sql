{{ config(
      materialized='incremental',
      unique_key = ['jigyoutai','syasyu_cd','seppenno','torokujun'],
      incremental_strategy = 'merge'
  )
 }}


with stg_legacy_mokujihonshijun as (
    select
        jigyoutai::varchar(2) as jigyoutai, --なし
        syasyu::varchar(4) as syasyu_cd, --なし
        seppenno::varchar(10) as seppenno, --なし
        torokujun::varchar(9) as torokujun, --なし
        mttime::varchar(16) as mttime, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyl15junkanri') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select coalesce(max(ldts), '1970-01-01 00:00:00.000') from {{ this }})
  {% endif %}
)
select * from stg_legacy_mokujihonshijun