{% snapshot scd_denchijoho_ptr_kojoiotpf %}
{{
    config(
        unique_key="concat_ws('-',
                    package_id,
                    traceability_id
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_denchijoho_ptr_kojoiotpf') }}
{% endsnapshot %}