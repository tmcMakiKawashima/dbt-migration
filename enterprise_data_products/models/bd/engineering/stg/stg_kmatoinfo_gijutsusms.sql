with
    stg_kmatoinfo_gijutsusms as (
        select
            syasyu::varchar(4) as syasyu,
            mato::varchar(7) as mato,
            motomato::varchar(7) as motomato,
            motocl::varchar(3) as motocl,
            kihaisino::varchar(10) as kihaisino,
            seppenno::varchar(10) as seppenno,
            _fivetran_synced::timestamp_ntz as ldts --timestamp型
        from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cy727kmatoinfo') }}
        where _fivetran_deleted = 'false'
    )
select *
from stg_kmatoinfo_gijutsusms
