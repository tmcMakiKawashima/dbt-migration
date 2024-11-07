{% snapshot scd_shitsuka %}

{{
    config(
        unique_key="stkcd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_shitsuka') }}

{% endsnapshot %}
