{% snapshot scd_maker_result %}
{{
    config(
        unique_key="concat_ws('-',
                    maker_result_id
                    )",

        strategy='timestamp',
        updated_at='created_at',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_maker_result') }}
{% endsnapshot %}