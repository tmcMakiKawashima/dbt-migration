{% snapshot scd_hinban %}
{{
    config(
        unique_key="concat_ws('-',
                    hinban
                    )",

        strategy='timestamp',
        updated_at='torokutime',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hinban') }}
{% endsnapshot %}