{% snapshot scd_bumon %}

{{
    config(
        unique_key="bmncd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_bumon') }}

{% endsnapshot %}
