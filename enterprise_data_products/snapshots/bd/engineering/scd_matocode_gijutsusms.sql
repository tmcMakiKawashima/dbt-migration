{% snapshot scd_matocode_gijutsusms%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu,
                    mato)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_matocode_gijutsusms') }} 

 {% endsnapshot %}