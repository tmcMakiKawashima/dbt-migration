{% snapshot scd_material %}

{{
    config(
        unique_key="concat_ws('-',
                    material_id)",

        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_material') }}

{% endsnapshot %}