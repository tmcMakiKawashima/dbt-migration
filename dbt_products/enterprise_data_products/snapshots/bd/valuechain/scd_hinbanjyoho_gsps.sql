{% snapshot scd_hinbanjyoho_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    syusbetu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinbanjyoho_gsps') }}

{% endsnapshot %}