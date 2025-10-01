{% snapshot scd_denchijoho_trm_kojoiotpf %}
{{
    config(
        unique_key="concat_ws('-',
                    traceability_id,
                    module_id
                    )",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_denchijoho_trm_kojoiotpf') }}
{% endsnapshot %}