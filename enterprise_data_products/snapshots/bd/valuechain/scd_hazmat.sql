{% snapshot scd_hazmat %}

{{
    config(
        unique_key="concat_ws('-',
                    haz)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hazmat') }}

{% endsnapshot %}