{% snapshot scd_cvn06dodrshiji %}

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

select * from {{ ref('stg_cvn06dodrshiji') }}

{% endsnapshot %}
