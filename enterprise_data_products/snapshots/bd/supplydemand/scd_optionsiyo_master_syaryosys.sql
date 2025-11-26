{% snapshot scd_optionsiyo_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    carnm_cd,
                    spec_no,
                    opt_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_optionsiyo_master_syaryosys') }}

{% endsnapshot %}