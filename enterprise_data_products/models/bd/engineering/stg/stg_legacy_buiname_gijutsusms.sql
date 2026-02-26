{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}

with stg_legacy_buiname_gijutsusms as (
    select
        syasyu::varchar(4) as syasyu_cd,
        kumitate::varchar(4) as kumitate,
        bui::varchar(4) as bui,
        buimei::varchar(25) as buimei,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyl15buimei') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select *
from stg_legacy_buiname_gijutsusms