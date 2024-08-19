{% snapshot scd_tbdaiml %}

{{
    config(
        unique_key="concat_ws('-',
                    kyouhan,
                    hassin,
                    usercd,
                    kaisya,
                    tchumon,
                    hinban,
                    mekakb,
                    jznjusin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbdaiml') }}

{% endsnapshot %}