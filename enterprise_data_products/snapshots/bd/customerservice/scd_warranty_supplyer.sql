{% snapshot scd_warranty_supplyer %}
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
                    suppli_code_ovs)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_warranty_supplyer') }}
{% endsnapshot %}