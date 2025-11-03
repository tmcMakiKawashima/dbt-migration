{% snapshot scd_material_controlband %}

{{
    config(
        unique_key="concat_ws('-',
                    control_band_id)",

        strategy='timestamp',
        updated_at='update_at',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_material_controlband') }}

{% endsnapshot %}