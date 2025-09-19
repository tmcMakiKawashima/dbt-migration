{% snapshot scd_hostalc_2u_erasure_achievements %}

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

select * from {{ ref('stg_hostalc_2u_erasure_achievements') }}

{% endsnapshot %}