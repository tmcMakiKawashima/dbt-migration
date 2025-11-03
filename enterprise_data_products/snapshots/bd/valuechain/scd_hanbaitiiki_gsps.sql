{% snapshot scd_hanbaitiiki_gsps %}

{{
    config(
        unique_key='donyutiiki',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hanbaitiiki_gsps') }}

{% endsnapshot %}