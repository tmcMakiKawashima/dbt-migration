{% snapshot scd_syokutakupart %}

{{
    config(
        unique_key="stptkbncd",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syokutakupart') }}

{% endsnapshot %}
