{% snapshot scd_cam2148_jyukyujyoho %}

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

select * from {{ ref('stg_cam2148_jyukyujyoho') }}

{% endsnapshot %}