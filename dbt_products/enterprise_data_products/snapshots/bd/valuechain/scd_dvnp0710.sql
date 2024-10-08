{% snapshot scd_dvnp0710 %}

{{
    config(
        unique_key="concat_ws('-',
                    ordrkey,
                    jurrsymd,
                    tanskkey)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_dvnp0710') }}

{% endsnapshot %}
