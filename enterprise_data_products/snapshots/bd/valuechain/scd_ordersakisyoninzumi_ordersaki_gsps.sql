{% snapshot scd_ordersakisyoninzumi_ordersaki_gsps %}

{{
    config(
        unique_key="concat_ws('-',
                    hinban,
                    seisankyoku,
                    hosyubas,
                    hantiiki,
                    syusbetu,
                    seppenjun)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_ordersakisyoninzumi_ordersaki_gsps') }}

{% endsnapshot %}