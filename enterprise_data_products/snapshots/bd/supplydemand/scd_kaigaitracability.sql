{% snapshot scd_kaigaitracability %}

{{
    config(
        unique_key="concat_ws('-',
                    syadai_kt,
                    frmno,
                    wmi,
                    vds,
                    mdlyr,
                    vin_vds_cd,
                    lok_y,
                    msgno)",

        strategy='timestamp',
        updated_at='updatetime',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kaigaitracability') }}

{% endsnapshot %}