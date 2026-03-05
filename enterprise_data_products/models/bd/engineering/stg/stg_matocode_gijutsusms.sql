with stg_matocode_gijutsusms as (
    select
        syasyu::varchar(4) as syasyu,
        mato::varchar(7) as mato,
        sekkei::varchar(5) as sekkei,
         kumitate::varchar(4) as  kumitate,
        bui::varchar(2) as bui,
        tanto::varchar(10) as tanto,
        tousai::varchar(4) as tousai,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cy727matocode') }}
    where _fivetran_deleted = 'false'
)
select *
from stg_matocode_gijutsusms