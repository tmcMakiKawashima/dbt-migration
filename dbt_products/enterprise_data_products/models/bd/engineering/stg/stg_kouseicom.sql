{{ 
  config(
    materialized='incremental',
    unique_key = ['jigyoutai','syasyu','siyoubui','oyahin','gc','kohin','comkbn','torokujunk'],
    incremental_strategy = 'merge'
  )
 }}

with stg_kouseicom as (
    select
        jigyoutai::varchar(2) as jigyoutai, --なし
        syasyu::varchar(4) as syasyu,  --なし
        siyoubui::varchar(10) as siyoubui,  --なし
        oyahin::varchar(10) as oyahin,  --なし
        rtrim(gc,' 　')::varchar(2) as gc,  --右ブランク
        kohin::varchar(10) as kohin,  --なし
        comkbn::varchar(2) as comkbn,  --なし
        rtrim(com,' 　')::varchar(100) as com,  --右ブランク
        torokujunk::varchar(9) as torokujunk,  --なし
        torokujunm::varchar(9) as torokujunm,  --なし
        mttime::varchar(16) as mttime,  --なし
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp03kouseicom') }}
     where _fivetran_deleted = 'false'

{% if is_incremental() %}
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * from stg_kouseicom