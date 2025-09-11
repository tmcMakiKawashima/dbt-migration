{% snapshot scd_kouseicom %}
{{
    config(
        unique_key="concat_ws('-',
                    jigyoutai,
                    syasyu,
                    siyoubui,
                    oyahin,
                    gc,
                    kohin,
                    comkbn,
                    torokujunk)",
        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_kouseicom') }}
{% endsnapshot %}