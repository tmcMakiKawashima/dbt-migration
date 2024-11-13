{% snapshot scd_syokusyu %}

{{
    config(
        unique_key="sykscd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syokusyu') }}

{% endsnapshot %}
