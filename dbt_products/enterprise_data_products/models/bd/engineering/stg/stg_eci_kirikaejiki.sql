{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','ecikbn'],
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

with stg_eci_kirikaejiki as (
    select
        seppenno::varchar(10) as seppenno, -- 設変No.
        ecikbn::varchar(3) as ecikbn, -- 区分
        kirijikijp::varchar(50) as kirijikijp, -- 切替希望時期日本語
        kirijikien::varchar(100) as kirijikien, -- 切替希望時期英語
        mttime::varchar(16) as mttime, -- MT日時
        _fivetran_synced::timestamp_ntz(9) as ldts -- B層取込日時
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp17ecikirijiki') }}
    where _fivetran_deleted = 'false'
)
select * from stg_eci_kirikaejiki
