{% snapshot scd_farmwaku_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlr_cd,
                    carnm_cd,
                    spec_no,
                    obj_ym_jun,
                    funcdtl_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_farmwaku_syaryosys') }}

{% endsnapshot %}