{% snapshot scd_categorymaster_pixy %}
{{
    config(
        unique_key="categorycd",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_categorymaster_pixy') }}
{% endsnapshot %}
