{% snapshot scd_hinbanseppenjyohosiki_gsps %}

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

select * from {{ ref('stg_hinbanseppenjyohosiki_gsps') }}

{% endsnapshot %}