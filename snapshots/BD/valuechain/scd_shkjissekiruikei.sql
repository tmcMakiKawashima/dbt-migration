{% snapshot scd_shkjissekiruikei %}

{{
    config(
        unique_key="concat_ws('-', 
                    lpcl, 
                    cyc_sno, 
                    tkod_dt)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
        snowflake_warehouse='DBT_WH',
    )
}}

select * from {{ ref('stg_shkjissekiruikei') }}

{% endsnapshot %}
