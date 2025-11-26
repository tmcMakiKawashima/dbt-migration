{% snapshot scd_grade_info_tbl_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    sle_model)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_grade_info_tbl_syaryosys') }}

{% endsnapshot %}