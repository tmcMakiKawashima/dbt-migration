{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','ecikbn','syasyu','tekiyo'],
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

with stg_eci_meihen as (
    select
        seppenno::varchar(10) as seppenno, -- 設変No.
        ecikbn::varchar(3) as ecikbn, -- 区分
        syasyu::varchar(4) as syasyu, -- 車種ユニットコード
        tekiyo::varchar(10) as tekiyo, -- 適用範囲
        meisyo::varchar(40) as meisyo, -- 名称
        mttime::varchar(16) as mttime, -- MT日時
        _fivetran_synced::timestamp_ntz(9) as ldts -- B層取込日時
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp17ecimeihen') }}
    where _fivetran_deleted = 'false'
)
select * from stg_eci_meihen