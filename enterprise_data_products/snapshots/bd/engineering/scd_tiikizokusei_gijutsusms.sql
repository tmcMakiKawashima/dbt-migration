{% snapshot scd_tiikizokusei_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    tiikizoku
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_tiikizokusei_gijutsusms') }}
{% endsnapshot %}