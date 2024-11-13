{% snapshot scd_syagaisya %}

{{
    config(
        unique_key="syagai_cd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syagaisya') }}

{% endsnapshot %}
