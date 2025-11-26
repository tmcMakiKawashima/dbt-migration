{% snapshot scd_order_daisu_summary_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    dlrcd,
                    dfsc)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_order_daisu_summary_syaryosys') }}

{% endsnapshot %}