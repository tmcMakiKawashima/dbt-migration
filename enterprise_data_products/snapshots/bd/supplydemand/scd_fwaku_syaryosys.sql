{% snapshot scd_fwaku_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    shamei,
                    sno,
                    bukbn,
                    kncode,
                    dlrcd,
                    firmyy,
                    firmmm,
                    firmjn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_fwaku_syaryosys') }}

{% endsnapshot %}