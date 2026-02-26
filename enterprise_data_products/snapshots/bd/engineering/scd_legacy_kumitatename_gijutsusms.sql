{% snapshot scd_legacy_kumitatename_gijutsusms%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu_cd,
                    kumitate)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_legacy_kumitatename_gijutsusms') }}

 {% endsnapshot %}