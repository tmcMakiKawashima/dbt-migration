{% snapshot scd_kunizokusei_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    kunizoku
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kunizokusei_gijutsusms') }}
{% endsnapshot %}