{{ config(
      materialized='incremental',
      unique_key = ['seppenno','siryono','syasyu','syurui','maker','koumoku','minor','bunsi','bunbo'],
      incremental_strategy = 'merge'
  )
 }}

with stg_syutudenpyotbl_kouteisms as (
    select
        seppenno::varchar(10) as seppenno, --なし
        siryono::varchar(9) as siryono, --なし
        syasyu::varchar(4) as syasyu, --なし
        syurui::varchar(2) as syurui, --なし
        maker::varchar(2) as maker, --なし
        koumoku::varchar(17) as koumoku, --なし
        minor::varchar(2) as minor, --なし
        bunsi::varchar(7) as bunsi, --なし
        bunbo::varchar(5) as bunbo, --なし
        tokua0maisu::varchar(3) as tokua0maisu, --なし
        zsize::varchar(2) as zsize, --なし
        gmaisu::varchar(5) as gmaisu, --なし
        waeikbn::varchar(1) as xwaeikbn, --なし
        gojitu::varchar(1) as gojitu, --なし
        hakkositu::varchar(5) as hakkositu, --なし
        motoseppenno::varchar(10) as motoseppenno, --なし
        motosiryono::varchar(9) as motosiryono, --なし
        edsiryono::varchar(10) as edsiryono, --なし
        edsyubetu::varchar(2) as edsyubetu, --なし
        hokyukbn::varchar(1) as hokyukbn, --なし
        mttime::varchar(16) as mttime, --なし
        'SMS-ROUTE'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_koutei_sms_dxpfy2d', 'raw_cym31syutudenpyo') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_syutudenpyotbl_kouteisms