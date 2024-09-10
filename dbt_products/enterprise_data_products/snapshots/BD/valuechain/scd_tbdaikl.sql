{% snapshot scd_tbdaikl %}

{{
    config(
        unique_key="concat_ws('-',
                    kyouhan,
                    hassin,
                    usercd,
                    kaisya,
                    tchumon,
                    jznjusin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbdaikl') }}

{% endsnapshot %}