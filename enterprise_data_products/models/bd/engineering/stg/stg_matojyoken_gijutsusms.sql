with
    stg_matojyoken_gijutsusms as (
        select
            syasyu::varchar(4) as syasyu,
            mato::varchar(7) as mato,
            oyamato::varchar(7) as oyamato,
            komato::varchar(7) as komato,
            clkara::varchar(3) as clkara,
            clmade::varchar(3) as clmade,
            _fivetran_synced::timestamp_ntz as ldts --timestamp型
        from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cy727jyoken') }}
        where _fivetran_deleted = 'false'
    )
select *
from stg_matojyoken_gijutsusms
