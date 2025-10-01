{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','jigyoutai'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
-- 洗い替えであるため、pre_hookで全件削除を行う。

with stg_eci_seppenkan as (
    select
        jigyoutai::varchar(2) as jigyoutai, -- 生産事業体
        seppenno::varchar(10) as seppenno, -- 設変No.
        torokutime::varchar(16) as torokutime, -- 登録生認日時
        mttime::varchar(16) as mttime, -- MT日時
        _fivetran_synced::timestamp_ntz(9) as ldts -- B層取込日時
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp05seppenkan') }}
    where _fivetran_deleted = 'false'
)
select * from stg_eci_seppenkan
