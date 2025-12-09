{% snapshot scd_hinbansyasyu_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    syasyu,
                    syusbetu)",
            
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_hinbansyasyu_gsps') }}

{% endsnapshot %}