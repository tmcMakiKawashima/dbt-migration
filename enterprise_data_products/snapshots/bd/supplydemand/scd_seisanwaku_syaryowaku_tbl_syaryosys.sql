{% snapshot scd_seisanwaku_syaryowaku_tbl_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    spec_no,
                    carnm_cd,
                    lineoff_beto_ymd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_seisanwaku_syaryowaku_tbl_syaryosys') }}

{% endsnapshot %}