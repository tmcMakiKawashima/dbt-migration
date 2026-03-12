{% snapshot scd_union_all_vehicle_specification_alc %}

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

select * from {{ ref('stg_union_all_vehicle_specification_alc') }}

{% endsnapshot %}
