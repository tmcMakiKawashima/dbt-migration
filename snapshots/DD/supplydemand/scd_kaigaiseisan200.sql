{% snapshot scd_kaigaiseisan200 %}

{{
    config(
        unique_key="concat_ws('-',
                    syadai_kt,
                    frmno,
                    wmi,
                    vds,
                    mdlyr,
                    vin_vds_cd,
                    sketa)",
                    
        strategy='timestamp',
        updated_at='updatetime',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_kaigaiseisan200') }}

{% endsnapshot %}