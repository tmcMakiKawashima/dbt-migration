{% snapshot scd_dvnp0700 %}

{{
    config(
        unique_key="concat_ws('-',
                    ordrkey,
                    tanskkey,
                    juchuymd)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_dvnp0700') }}

{% endsnapshot %}
