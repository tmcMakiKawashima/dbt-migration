{% snapshot scd_oem_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    cdno,
                    idln,
                    idmm,
                    iddd,
                    idren,
                    tskbn,
                    sno,
                    ktcd,
                    odt,
                    smkcd,
                    dfsc,
                    frkbn,
                    mdlyr,
                    kjcd,
                    wmi,
                    vds,
                    mkrln,
                    smkbn,
                    smkms,
                    stkh,
                    frno,
                    ipkbn,
                    kyy,
                    kmm,
                    kdd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=True,
    )
}}

select * from {{ ref('stg_oem_syaryosys') }}

{% endsnapshot %}