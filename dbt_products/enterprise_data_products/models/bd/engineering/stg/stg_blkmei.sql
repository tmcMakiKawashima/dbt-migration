{{ config(
      materialized='incremental',
      unique_key = ['syasyu','blkcode'],
      incremental_strategy = 'merge'
  )
 }}


with stg_blkmei as (
    select
        syasyu::varchar(4) as syasyu, --なし
        blkcode::varchar(10) as blkcode, --なし
        blkmei::varchar(40) as blkmei, --なし
        mttime::varchar(16) as mttime, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp01blkmei') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_blkmei