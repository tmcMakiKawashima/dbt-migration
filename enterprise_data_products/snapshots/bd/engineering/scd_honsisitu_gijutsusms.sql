{% snapshot scd_honsisitu_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    jigyoutai,
                    syasyu,
                    siyoubui,
                    torokujunk
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_honsisitu_gijutsusms') }}
{% endsnapshot %}