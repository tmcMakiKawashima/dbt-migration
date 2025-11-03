{% snapshot scd_jutyuu_atop %}

{{
    config(
        unique_key="concat_ws('-',
                    jhinban)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jutyuu_atop') }}

{% endsnapshot %}