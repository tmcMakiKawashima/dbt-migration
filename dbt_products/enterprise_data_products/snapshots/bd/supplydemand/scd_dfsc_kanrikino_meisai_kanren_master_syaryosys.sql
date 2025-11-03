{% snapshot scd_dfsc_kanrikino_meisai_kanren_master_syaryosys %}

{{
    config(
        unique_key="concat_ws('-',
                    dfsc,
                    funcdtl_cd)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_dfsc_kanrikino_meisai_kanren_master_syaryosys') }}

{% endsnapshot %}