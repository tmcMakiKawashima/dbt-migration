{% snapshot scd_DVNP0700 %}

{{
    config(
        unique_key="ORDRKEY ||'-'|| TANSKKEY",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_DVNP0700') }}

{% endsnapshot %}
