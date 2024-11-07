{% snapshot scd_kakarigroup %}

{{
    config(
        unique_key="kkrgcd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kakarigroup') }}

{% endsnapshot %}
