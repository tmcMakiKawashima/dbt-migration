{% snapshot scd_tbchznl %}

{{
    config(
        unique_key="concat_ws('-', 
                    kyouhan, 
                    hinban, 
                    mkbn, 
                    nyukkten, 
                    chumon, 
                    makercd, 
                    hchuymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbchznl') }}

{% endsnapshot %}
