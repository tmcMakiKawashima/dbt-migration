{% snapshot scd_blkmei %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu,
                    blkcode
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_blkmei') }}
{% endsnapshot %}