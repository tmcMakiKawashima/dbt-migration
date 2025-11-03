{% snapshot scd_daitaiordersakiroot_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    daiohin,
                    daiohinsbetu,
                    hantiiki,
                    syusbetu,
                    orderjtai1,
                    orderjtai2,
                    orderjtai3,
                    orderjtai4,
                    orderjtai5)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_daitaiordersakiroot_gsps') }}

{% endsnapshot %}