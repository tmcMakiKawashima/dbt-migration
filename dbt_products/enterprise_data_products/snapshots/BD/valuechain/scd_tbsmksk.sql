{% snapshot scd_tbsmksk %}

{{
    config(
        unique_key="concat_ws('-', 
                    id, 
                    kyouhan, 
                    kyoten,
                    yobi)",

        strategy='check',
        check_cols=['sishacd',
                    'tsiwakecd1',
                    'tsiwakecd2',
                    'filler'],
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_tbsmksk') }}

{% endsnapshot %}