{% snapshot scd_ykiken%}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    syusbetu,
                    seppenjun)",
        
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_ykiken') }}

{% endsnapshot %}