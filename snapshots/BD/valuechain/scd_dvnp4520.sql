{% snapshot scd_dvnp4520 %}

{{
    config(
        unique_key="JUSINNO ||'-'|| RENBAN2 ||'-'|| SHINBAN ||'-'|| JUCHUYMD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_dvnp4520') }}

{% endsnapshot %}
