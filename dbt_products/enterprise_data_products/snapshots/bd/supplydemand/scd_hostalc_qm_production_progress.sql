{% snapshot scd_hostalc_qm_production_progress %}

{{
  config(
    unique_key="concat_ws('-',
          pscexlk,
          plantcode,
          line,
          tp,
          idline,
          ndate,
          shift)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_hostalc_qm_production_progress') }}

{% endsnapshot %}