{% snapshot scd_hostalc_allsfh %}

{{
  config(
    unique_key="concat_ws('-',
          psc,
          plantcode,
          lodate,
          idno,
          line,
          tp,
          prsnttptype,
          times)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_hostalc_allsfh') }}

{% endsnapshot %}