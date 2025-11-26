{% snapshot scd_gaihanshoku_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    carnm_cd,
                    spec_no,
                    bdcol_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_gaihanshoku_master_syaryosys') }}

{% endsnapshot %}