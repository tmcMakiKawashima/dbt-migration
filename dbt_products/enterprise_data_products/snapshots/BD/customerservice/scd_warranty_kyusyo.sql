{% snapshot scd_warranty_kyusyo %}

{{
    config(
        unique_key="concat_ws('-',
                    settle_date_y,
                    settle_date_m,
                    dealer_code,
                    twc_no,
                    frmkbn,
                    frmno,
                    wmi,
                    vds,
                    vis,
                    cmp_suppli_code,
                    cmp_settle_date_y,
                    cmp_settle_date_m)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_warranty_kyusyo') }}

{% endsnapshot %}
