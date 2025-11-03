{% snapshot scd_hanbaiseiyaku_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlr_cd,
                    sle_model)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hanbaiseiyaku_master_syaryosys') }}

{% endsnapshot %}