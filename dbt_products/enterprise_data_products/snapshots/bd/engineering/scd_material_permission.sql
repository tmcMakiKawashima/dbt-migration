{% snapshot scd_material_permission %}
{{
    config(
        unique_key="concat_ws('-',
                    permission_id
                    )",

        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_material_permission') }}
{% endsnapshot %}