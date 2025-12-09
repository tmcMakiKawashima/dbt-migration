{% snapshot scd_order_kakuteibi_tbl_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    spec_no,
                    carnm_cd,
                    odr_dcson_ymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_order_kakuteibi_tbl_syaryosys') }}

{% endsnapshot %}