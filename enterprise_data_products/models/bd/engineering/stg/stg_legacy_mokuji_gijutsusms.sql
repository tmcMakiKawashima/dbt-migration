{{
    config (
        materialized = 'incremental',
        unique_key = ['jigyoutai', 'syasyu32', 'syasyu', 'kumitate', 'bui', 'kata', 'torokujunk', 'sakuseikbn', 'sekkei', 'sochaku', 'hikisiyo'],
        incremental_strategy = 'merge'
    )
}}

with stg_legacy_mokuji_gijutsusms as (
    select
        jigyoutai::varchar(2) as jigyoutai,
        syasyu32::varchar(2) as syasyu32,
        syasyu::varchar(4) as syasyu,
        kumitate::varchar(4) as kumitate,
        bui::varchar(2) as bui,
        kata::varchar(20) as kata,
        sochaku::varchar(1) as sochaku,
        vari::varchar(2) as vari,
        sakuseikbn::varchar(2) as sakuseikbn,
        sekkei::varchar(5) as sekkei,
        torokujunk::varchar(9) as torokujunk,
        torokujunm::varchar(9) as torokujunm,
        tck::varchar(8) as tck,
        tcm::varchar(8) as tcm,
        mttime::varchar(16) as mttime,
        hikisiyo::varchar(200) as hikisiyo,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyl15mokuji') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select *
from stg_legacy_mokuji_gijutsusms