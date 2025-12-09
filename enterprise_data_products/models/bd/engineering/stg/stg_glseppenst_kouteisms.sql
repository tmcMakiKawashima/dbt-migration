{{ config(
      materialized='incremental',
      unique_key = ['seppenno','siryono'],
      incremental_strategy = 'merge'
  )
 }}

with stg_glseppenst_kouteisms as (
    select
        seppenno::varchar(10) as seppenno, --なし
        siryono::varchar(9) as siryono, --なし
        alltseinintim::varchar(14) as alltseinintim, --なし
        allttyonintime::varchar(14) as allttyonintime, --なし
        alltlckekka::varchar(1) as alltlckekka, --なし
        hokyukouseitim::varchar(14) as hokyukouseitim, --なし
        hokyukubuntim::varchar(14) as hokyukubuntim, --なし
        hokyukouteitim::varchar(14) as hokyukouteitim, --なし
        allhonintim::varchar(14) as allhonintim, --なし
        mttime::varchar(16) as mttime, --なし
        'SMS-ROUTE'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_koutei_sms_dxpfy2d', 'raw_cym60glseppenst') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_glseppenst_kouteisms