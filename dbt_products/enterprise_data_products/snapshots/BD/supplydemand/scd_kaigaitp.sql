{% snapshot scd_kaigaitp %}

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
                    pline,
                    tp,
                    pretp_kbn,
                    pass)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_kaigaitp') }}

{% endsnapshot %}