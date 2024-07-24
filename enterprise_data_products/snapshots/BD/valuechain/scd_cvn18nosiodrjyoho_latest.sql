{% snapshot scd_cvn18nosiodrjyoho_latest %}

{{
    config(
        unique_key="concat_ws('-', 
                    ordrkey, 
                    juchuymd)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_cvn18nosiodrjyoho_latest') }}

{% endsnapshot %}
