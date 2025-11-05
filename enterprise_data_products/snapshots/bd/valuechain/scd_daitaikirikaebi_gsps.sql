{% snapshot scd_daitaikirikaebi_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    daiohin,
                    orderjtai,
                    hantiiki,
                    syusbetu)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_daitaikirikaebi_gsps') }}

{% endsnapshot %}