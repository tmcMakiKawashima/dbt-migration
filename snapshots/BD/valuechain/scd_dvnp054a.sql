{% snapshot scd_dvnp054a %}

{{
    config(
        unique_key="DLRCD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvnp054a') }}

{% endsnapshot %}
