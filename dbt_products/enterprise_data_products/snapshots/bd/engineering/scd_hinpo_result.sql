{% snapshot scd_hinpo_result %}
{{
    config(
        unique_key="concat_ws('-',
            quality_result_id)",
            
        strategy='timestamp',
        updated_at='created_at',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hinpo_result') }}
{% endsnapshot %}