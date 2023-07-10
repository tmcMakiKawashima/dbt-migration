{% snapshot scd_dvnp0700 %}

{{
    config(
        unique_key="ORDRKEY ||'-'|| TANSKKEY ||'-'|| JUCHUYMD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvnp0700') }}

{% endsnapshot %}
