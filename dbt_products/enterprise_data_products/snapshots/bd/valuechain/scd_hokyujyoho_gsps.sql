{% snapshot scd_hokyujyoho_gsps %}

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

select * from {{ ref('stg_hokyujyoho_gsps') }}

{% endsnapshot %}