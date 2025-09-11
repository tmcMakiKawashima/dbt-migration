{% snapshot scd_hostalc_allsfvam %}

{{
  config(
    unique_key="concat_ws('-',
          psc,
          plantcode,
          idno,
          lodate)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_hostalc_allsfvam') }}

{% endsnapshot %}