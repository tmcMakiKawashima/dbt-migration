{% snapshot scd_syozoku %}

{{
    config(
        unique_key="szcd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syozoku') }}

{% endsnapshot %}
