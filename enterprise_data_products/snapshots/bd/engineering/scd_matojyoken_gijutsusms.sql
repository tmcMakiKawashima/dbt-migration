{% snapshot scd_matojyoken_gijutsusms%}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu,
                    mato,
                    oyamato,
                    komato,
                    clkara)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_matojyoken_gijutsusms') }} 

 {% endsnapshot %}