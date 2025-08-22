{% snapshot scd_accept_test %}
{{
    config(
        unique_key="concat_ws('-',
                    accept_test_id
                    )",

        strategy='timestamp',
        updated_at='updated_at',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_accept_test') }}
{% endsnapshot %}