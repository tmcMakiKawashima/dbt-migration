{% snapshot scd_optsobisaimoku %}
{{
    config(
        unique_key="concat_ws('-',
                    syasyu_cd,
                    ctg_cd,
                    chg_no,
                    shamei,
                    cnl_cd,
                    eqp_mgr_id,
                    eqp_cd,
                    eqp_dtl_cd
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_optsobisaimoku') }}
{% endsnapshot %}