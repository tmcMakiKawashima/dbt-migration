{% snapshot scd_hostalc_1w_vehicle_specification %}

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

select * from {{ ref('stg_hostalc_1w_vehicle_specification') }}

{% endsnapshot %}