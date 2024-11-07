{% snapshot scd_bu %}

{{
    config(
        unique_key="bucd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_bu') }}

{% endsnapshot %}
