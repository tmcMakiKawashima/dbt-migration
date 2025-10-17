{% snapshot scd_hostalc_vm_virtual_line %}

{{
  config(
    unique_key="concat_ws('-',
          pscexlk,
          plantcode,
          tp,
          urn,
          line)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_hostalc_vm_virtual_line') }}

{% endsnapshot %}