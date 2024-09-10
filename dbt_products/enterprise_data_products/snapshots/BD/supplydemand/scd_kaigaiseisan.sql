{% snapshot scd_kaigaiseisan %}

{{
    config(
        unique_key="concat_ws('-',
                    frmno,
                    wmi,
                    vds,
                    mdlyr,
                    vin_vds_cd)",
                    
        strategy='timestamp',
        updated_at='updatetime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_kaigaiseisan') }}

{% endsnapshot %}