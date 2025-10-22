{{ config(
      materialized='incremental',
      unique_key = ['jigyoutai','syasyu','kumitate','bui','torokujun'],
      incremental_strategy = 'merge'
  )
 }}

with stg_mokujibuijun_gijutsusms as (
    select
        jigyoutai::varchar(2) as jigyoutai, --なし
        syasyu::varchar(4) as syasyu, --なし
        kumitate::varchar(4) as kumitate, --なし
        bui::varchar(2) as bui, --なし
        torokujun::varchar(9) as torokujun, --なし
        seppenno::varchar(10) as seppenno, --なし
        kohenno::varchar(10) as kohenno, --なし
        sijino::varchar(9) as sijino, --なし
        syurui::varchar(1) as syurui, --なし
        mttime::varchar(16) as mttime, --なし
        'Gijyutu-sms'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp02mokujibuijun') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_mokujibuijun_gijutsusms