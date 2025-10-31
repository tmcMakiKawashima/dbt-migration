{% snapshot scd_hostalc_na_sfl %}

{{
  config(
    unique_key="concat_ws('-',
          psc,
          plantcode,
          lodate,
          idno,
          msgno)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_hostalc_na_sfl') }}

{% endsnapshot %}