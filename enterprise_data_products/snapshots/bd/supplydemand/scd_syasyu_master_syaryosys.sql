{% snapshot scd_syasyu_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    carnm_cd,
                    spec_no)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_syasyu_master_syaryosys') }}

{% endsnapshot %}