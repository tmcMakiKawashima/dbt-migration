{{
  config(
    materialized='incremental',
    unique_key = ['syasyu_cd', 'kumitate'],
    incremental_strategy = 'merge'
  )
}}

with stg_kumitatename as (
    select
        syasyu::varchar(4) as syasyu_cd,
        kumitate::varchar(4) as kumitate,
        kumimei::varchar(25) as kumimei,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d','raw_cyp01kumimei') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{this}})
    {% endif %}

)
select * from stg_kumitatename

