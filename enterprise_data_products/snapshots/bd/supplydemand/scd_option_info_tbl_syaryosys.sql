{% snapshot scd_option_info_tbl_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    sle_model,
                    bdcol_cd,
                    inner_cd,
                    opt_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_option_info_tbl_syaryosys') }}

{% endsnapshot %}