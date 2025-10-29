{% snapshot scd_uchibarisiyou_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    carnm_cd,
                    spec_no,
                    inner_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_uchibarisiyou_master_syaryosys') }}

{% endsnapshot %}