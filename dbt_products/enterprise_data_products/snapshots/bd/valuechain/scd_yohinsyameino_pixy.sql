{% snapshot scd_yohinsyameino_pixy %}
{{
    config(
        unique_key= "syameino",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_yohinsyameino_pixy') }}
{% endsnapshot %}