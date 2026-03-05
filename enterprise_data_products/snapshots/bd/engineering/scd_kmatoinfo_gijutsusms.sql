{% snapshot scd_kmatoinfo_gijutsusms%}

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

select * from {{ ref('stg_kmatoinfo_gijutsusms') }} 

 {% endsnapshot %}