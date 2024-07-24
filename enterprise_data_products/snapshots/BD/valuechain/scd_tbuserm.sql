{% snapshot scd_tbuserm %}

{{
    config(
        unique_key="KYOUHAN ||'-'|| USRCOD",

        strategy='timestamp',
        updated_at='LDTS',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbuserm') }}

{% endsnapshot %}
