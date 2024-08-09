{% snapshot scd_dvnp6490 %}

{{
    config(
        unique_key="ORDRKEY ||'-'|| JURRSYMD ||'-'|| TANSKKEY",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * From {{ ref('stg_dvnp6490') }}

{% endsnapshot %}