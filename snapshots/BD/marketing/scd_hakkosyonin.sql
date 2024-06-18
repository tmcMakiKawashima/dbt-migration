{% snapshot scd_hakkosyonin %}

{{
    config(
        unique_key="hanbaino",
                    
        strategy='timestamp',
        updated_at='dt_kosin',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_hakkosyonin') }}

{% endsnapshot %}