{% snapshot scd_7c_erasure_achievements_hostalc %}

{{
    config(
        unique_key="concat_ws('-',
                    pscexlk,
                    plantcode,
                    urn)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_7c_erasure_achievements_hostalc') }}

{% endsnapshot %}