{% snapshot scd_legacy_mokuji_gijutsusms%}

{{
    config( 
        unique_key="concat_ws('-',
                    jigyoutai,
                    syasyu32,
                    syasyu,
                    kumitate,
                    bui,
                    kata,
                    torokujunk,
                    sakuseikbn,
                    sekkei,
                    sochaku,
                    hikisiyo)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_legacy_mokuji_gijutsusms') }}

 {% endsnapshot %}