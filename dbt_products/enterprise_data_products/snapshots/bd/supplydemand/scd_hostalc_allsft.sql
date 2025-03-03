{% snapshot scd_hostalc_allsft %}

{{
  config(
    unique_key="concat_ws('-',
          psc,
          plantcode,
          lodate,
          idno)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_hostalc_allsft') }}

{% endsnapshot %}