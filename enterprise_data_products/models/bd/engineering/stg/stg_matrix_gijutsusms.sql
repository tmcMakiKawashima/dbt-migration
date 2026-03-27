with
    stg_matrix_gijutsusms as (
        select
            syasyu::varchar(4) as syasyu_cd,
            mato::varchar(7) as mato,
            submato::varchar(7) as submato,
            vari::varchar(4) as vari,
            clkara::varchar(3) as clkara,
            clmade::varchar(3) as clmade,
            kumikekka::varchar(1089) as kumikekka,
            _fivetran_synced::timestamp_ntz as ldts --timestamp型

        from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cy727matrix') }}
        where
            _fivetran_deleted = 'false'
    )
select * from stg_matrix_gijutsusms
