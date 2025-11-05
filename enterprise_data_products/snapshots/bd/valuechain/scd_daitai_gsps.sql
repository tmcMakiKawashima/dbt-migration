{% snapshot scd_daitai_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    daiohin,
                    syusbetu,
                    seppenjun,
                    dainhin)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_daitai_gsps') }}

{% endsnapshot %}