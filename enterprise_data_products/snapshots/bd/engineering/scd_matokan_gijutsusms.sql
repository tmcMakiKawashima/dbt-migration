{% snapshot scd_matokan_gijutsusms%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu,
                    mato,
                    cl)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_matokan_gijutsusms') }} 

 {% endsnapshot %}