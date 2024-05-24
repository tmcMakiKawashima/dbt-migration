{% snapshot scd_hanbaitenmaster %}

{{
    config(
        unique_key="hanbaitencd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_hanbaitenmaster') }}

{% endsnapshot %}
