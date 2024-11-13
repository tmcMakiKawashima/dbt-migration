{% snapshot scd_syokui %}

{{
    config(
        unique_key="sykicd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syokui') }}

{% endsnapshot %}
