{% snapshot scd_tbnokjs %}

{{
    config(
        unique_key="concat_ws('-', 
                    kyouhan,
                    usercd,
                    hinban,
                    mkbn,
                    nyukkten,
                    concat(left(chumon, 1), right(chumon, 3)),
                    jchuymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbnokjs') }}

{% endsnapshot %}
