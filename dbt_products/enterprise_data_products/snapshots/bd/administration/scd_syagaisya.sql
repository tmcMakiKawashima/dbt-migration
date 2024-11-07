{% snapshot scd_syagaisya %}

{{
    config(
        unique_key="	r_syagaiid",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_syagaisya') }}

{% endsnapshot %}
