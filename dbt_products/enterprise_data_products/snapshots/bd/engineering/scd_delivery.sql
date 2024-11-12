{% snapshot scd_delivery %}
{{
    config(
        unique_key="concat_ws('-',
                    delivery_id
                    )",

        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_delivery') }}
{% endsnapshot %}