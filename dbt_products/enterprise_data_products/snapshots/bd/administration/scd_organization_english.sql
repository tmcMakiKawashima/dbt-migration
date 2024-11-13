{% snapshot scd_organization_english %}

{{
    config(
        unique_key="concat_ws('-',
                    bucd,
                    stkcd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_organization_english') }}

{% endsnapshot %}
