{% snapshot scd_hinbanjyohohinmei_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    hinbansbetu,
                    syusbetu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinbanjyohohinmei_gsps') }}

{% endsnapshot %}