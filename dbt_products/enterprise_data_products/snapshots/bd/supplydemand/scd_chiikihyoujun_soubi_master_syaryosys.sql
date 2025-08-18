{% snapshot scd_chiikihyoujun_soubi_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dlr_cd,
                    sle_model,
                    eqp_clss,
                    eqp_itm)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_chiikihyoujun_soubi_master_syaryosys') }}

{% endsnapshot %}