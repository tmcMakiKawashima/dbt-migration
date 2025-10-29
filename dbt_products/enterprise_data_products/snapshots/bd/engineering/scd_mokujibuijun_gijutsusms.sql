{% snapshot scd_mokujibuijun_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    jigyoutai,
                    syasyu,
                    kumitate,
                    bui,
                    torokujun
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_mokujibuijun_gijutsusms') }}
{% endsnapshot %}