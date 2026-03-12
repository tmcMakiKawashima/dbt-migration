{% snapshot scd_0g_reject_vehicle_hostalc %}

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
select * from {{ ref('stg_0g_reject_vehicle_hostalc') }}

{% endsnapshot %}