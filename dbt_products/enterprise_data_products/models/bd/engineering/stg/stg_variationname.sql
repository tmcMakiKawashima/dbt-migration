{{
  config(
    materialized='incremental',
    unique_key = ['syasyu_cd', 'kumitate', 'bui', 'vari'],
    incremental_strategy = 'merge'
  )
}}

with stg_variationname as (
    select
        syasyu::varchar(4) as syasyu_cd,
        kumitate::varchar(4) as kumitate,
        bui::varchar(2) as bui,
        vari::varchar(2) as vari,
        varimei::varchar(25) as varimei,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d','raw_cyp01varimei') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{this}})
    {% endif %}

)
select * from stg_variationname