{% snapshot scd_shinsyameisai %}
{{
    config(
        unique_key="concat_ws('-',
                    dlrcd,
                    cuno)",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_shinsyameisai') }}
{% endsnapshot %}