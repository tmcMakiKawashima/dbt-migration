{% snapshot scd_dfsc_option_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dfsc,
                    opt_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_dfsc_option_master_syaryosys') }}

{% endsnapshot %}