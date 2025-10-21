{% snapshot scd_tikisyasyu_gsps %}
{{
    config(
        unique_key="concat_ws('-',
                    donyutiiki,
                    syasyu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_tikisyasyu_gsps') }}

{% endsnapshot %}