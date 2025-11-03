{% snapshot scd_jtaizokusei_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    jtaizoku
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_jtaizokusei_gijutsusms') }}
{% endsnapshot %}