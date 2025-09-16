{% snapshot scd_seppenst_gijutsusms %}
{{
    config(
        unique_key="concat_ws('-',
                    seppenno,
                    siryono
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_seppenst_gijutsusms') }}
{% endsnapshot %}