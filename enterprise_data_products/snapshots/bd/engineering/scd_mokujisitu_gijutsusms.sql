{% snapshot scd_mokujisitu_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    jigyoutai,
                    syasyu32,
                    syasyu,
                    kumitate,
                    bui,
                    kata,
                    torokujunk
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_mokujisitu_gijutsusms') }}
{% endsnapshot %}