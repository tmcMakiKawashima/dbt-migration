{% snapshot scd_tagmaster_pixy %}
{{
    config(
        unique_key="tagcd",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_tagmaster_pixy') }}
{% endsnapshot %}
