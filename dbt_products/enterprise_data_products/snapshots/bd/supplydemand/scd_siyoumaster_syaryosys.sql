{% snapshot scd_siyoumaster_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    sle_model,
                    che_fil_clss,
                    eqp_typ,
                    eqp_cond_cd,
                    set_contno,
                    set_eqp_typ,
                    set_eqp_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_siyoumaster_syaryosys') }}

{% endsnapshot %}