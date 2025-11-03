{% snapshot scd_sethinlineupmaster_pixy %}
{{
    config(
        unique_key="tuikocd",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_sethinlineupmaster_pixy') }}
{% endsnapshot %}
