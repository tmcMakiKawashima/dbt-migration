with stg_matokan_gijutsusms as (
    select
        syasyu::varchar(4) as syasyu,
        mato::varchar(7) as mato,
        cl::varchar(3) as cl,
        seppenno::varchar(10) as seppenno,
        sjno::varchar(9) as sjno,
        state::varchar(1) as state,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cy727matokan') }}
    where _fivetran_deleted = 'false'
)
select *
from stg_matokan_gijutsusms