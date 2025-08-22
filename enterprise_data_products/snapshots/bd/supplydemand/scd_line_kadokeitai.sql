{% snapshot scd_line_kadokeitai %}
{{
    config(
        unique_key="concat_ws('-',
                    line_id,
                    tkkara
                    )",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_line_kadokeitai') }}
{% endsnapshot %}