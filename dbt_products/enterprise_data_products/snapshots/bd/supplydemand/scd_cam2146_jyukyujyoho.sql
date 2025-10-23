{% snapshot scd_cam2146_jyukyujyoho %}

{{
  config(
    unique_key="concat_ws('-',
          r_prod_month,
          r_edno)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=true,
  )
}}

select * from {{ ref('stg_cam2146_jyukyujyoho') }}

{% endsnapshot %}