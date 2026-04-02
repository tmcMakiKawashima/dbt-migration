with
    stg_trimcolor_gijutsusms as (
        select
            syasyu::varchar(4) as syasyu,
            trimclr::varchar(2) as trimclr,
            trimmei::varchar(25) as trimmei,
            kihon1::varchar(6) as kihon1,
            kihon2::varchar(6) as kihon2,
            _fivetran_synced::timestamp_ntz as ldts --timestamp型
        from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cy603trimcolor') }}
        where _fivetran_deleted = 'false'
    )
select *
from stg_trimcolor_gijutsusms
