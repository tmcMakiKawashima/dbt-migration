{% snapshot scd_kyoku_hokyusms %}

{{
    config(
        unique_key='kyokucd',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kyoku_hokyusms') }}

{% endsnapshot %}