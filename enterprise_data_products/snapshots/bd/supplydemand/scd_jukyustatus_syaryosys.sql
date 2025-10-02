{% snapshot scd_jukyustatus_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    chumon,
                    jyuhasei,
                    simuke,
                    odno,
                    ojyy,
                    frmkbn,
                    frmno)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_jukyustatus_syaryosys') }}

{% endsnapshot %}