{% snapshot scd_vltsohutaisho %}
{{
    config(
        unique_key="concat_ws('-',
                    line_id,
                    ymd
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_vltsohutaisho') }}
{% endsnapshot %}