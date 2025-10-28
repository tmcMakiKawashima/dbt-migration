{% snapshot scd_hanbaiten_toriatukai_syasyu_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlr_cd,
                    carnm_cd,
                    spec_no)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_hanbaiten_toriatukai_syasyu_master_syaryosys') }}

{% endsnapshot %}