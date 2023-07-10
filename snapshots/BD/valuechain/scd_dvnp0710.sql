{% snapshot scd_dvnp0710 %}

{{
    config(
        unique_key="ORDRKEY ||'-'|| JURRSYMD ||'-'|| TANSKKEY",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvnp0710') }}

{% endsnapshot %}
