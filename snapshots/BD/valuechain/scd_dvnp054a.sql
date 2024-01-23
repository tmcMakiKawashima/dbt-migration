{% snapshot scd_dvnp054a %}

{{
    config(
        unique_key="dlrcd",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvnp054a') }}

{% endsnapshot %}
