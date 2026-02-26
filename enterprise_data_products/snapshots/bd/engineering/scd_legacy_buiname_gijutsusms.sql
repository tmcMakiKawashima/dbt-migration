{% snapshot scd_legacy_buiname_gijutsusms%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu_cd,
                    kumitate,
                    bui)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_legacy_buiname_gijutsusms') }} 

 {% endsnapshot %}