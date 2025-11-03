{% snapshot scd_kanrikino_meisaihikiate_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    spec_no,carnm_cd,
                    funcdtl_cd,
                    ctl_model,
                    bdcol_cd,
                    inner_cd,
                    eqp_cond1,
                    eqp_cond2,
                    eqp_cond3,
                    eqp_cond4,
                    eqp_cond5,
                    eqp_cond6,
                    eqp_cond7,
                    eqp_cond8,
                    tire_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kanrikino_meisaihikiate_master_syaryosys') }}

{% endsnapshot %}