{% snapshot scd_warranty_koukanhinban %}

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
                    seq_no_parts)",

        strategy='timestamp',
        updated_at='mttime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_warranty_koukanhinban') }}

{% endsnapshot %}