{% snapshot scd_order_db_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    odno,
                    jrdate,
                    shamei,
                    sno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_order_db_syaryosys') }}

{% endsnapshot %}