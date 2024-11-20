{% snapshot scd_material_criteria %}

{{
    config(
        unique_key="concat_ws('-',
                    criteria_id)",

        strategy='timestamp',
        updated_at='update_at',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_material_criteria') }}

{% endsnapshot %}