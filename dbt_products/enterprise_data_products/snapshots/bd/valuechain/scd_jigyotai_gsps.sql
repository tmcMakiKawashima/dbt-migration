{% snapshot scd_jigyotai_gsps %}

{{
    config(
        unique_key='jtai',
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jigyotai_gsps') }}

{% endsnapshot %}