{% snapshot scd_kudo %}

{{
    config(
        unique_key="concat_ws('-',
                    send_date,
                    syasyu_cd,
                    sno,
                    syamei,
                    dom_exp_cd,
                    iff(model_name_cd is null, '', model_name_cd::varchar),
                    iff(unit_cd is null, '', unit_cd::varchar),
                    katashiki,
                    powertrain_cd,
                    iff(powertrain_sms is null, '', powertrain_sms)
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}

select * from {{ ref('stg_kudo') }}

{% endsnapshot %}
