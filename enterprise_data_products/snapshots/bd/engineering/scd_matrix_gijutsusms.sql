{% snapshot scd_matrix_gijutsusms %}

{{
    config( 
        unique_key="concat_ws('-',
                    syasyu,
                    mato,
                    submato,
                    vari,
                    clkara,
                    kumikekka)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_matrix_gijutsusms') }}
{% endsnapshot %}