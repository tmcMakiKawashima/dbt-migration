{{ config(
      materialized='incremental',
      unique_key = ['seppenno','siryono'],
      incremental_strategy = 'merge'
  )
 }}

with stg_seppenst_gijutsusms as (
    select
        seppenno::varchar(10) as seppenno, --なし
        siryono::varchar(9) as siryono, --なし
        tantoseikan::varchar(2) as tantoseikan, --なし
        syonintime::varchar(14) as syonintime, --なし
        denouttime::varchar(14) as denouttime, --なし
        scantime::varchar(14) as scantime, --なし
        accepttm::varchar(14) as accepttm, --なし
        uktukekbn::varchar(1) as uktukekbn, --なし
        ktsttaikbn::varchar(1) as ktsttaikbn, --なし
        kirisijikbn::varchar(1) as kirisijikbn, --なし
        konintime::varchar(14) as konintime, --なし
        kirinintime::varchar(14) as kirinintime, --なし
        seinintime::varchar(14) as seinintime, --なし
        tyonintime::varchar(14) as tyonintime, --なし
        umukbn05ji::varchar(1) as umukbn05ji, --なし
        mttime::varchar(16) as mttime, --なし
        'SMS-ROUTE'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cym60seppenst') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_seppenst_gijutsusms