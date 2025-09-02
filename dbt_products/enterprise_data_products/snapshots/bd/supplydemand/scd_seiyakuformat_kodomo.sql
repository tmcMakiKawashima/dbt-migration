{% snapshot scd_seiyakuformat_kodomo %}
{{
    config(
        unique_key="concat_ws('-',
                    company_member,
                    getudo,
                    restrictionname,
                    line,
                    model,
                    dom_exp,
                    unit,
                    body_type,
                    ss,
                    subseriescode,
                    yyyymm
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_seiyakuformat_kodomo') }}
{% endsnapshot %}