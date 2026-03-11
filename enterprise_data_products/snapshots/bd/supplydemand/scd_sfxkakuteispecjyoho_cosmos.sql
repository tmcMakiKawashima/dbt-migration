{% snapshot scd_sfxkakuteispecjyoho_cosmos %}

{{
  config(
    unique_key="concat_ws('-',
          r_prod_month,
          r_edno,
          r_spec_keta)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_sfxkakuteispecjyoho_cosmos') }}

{% endsnapshot %}