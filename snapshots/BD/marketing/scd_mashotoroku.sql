{% snapshot scd_mashotoroku %}

{{
  config(
    unique_key="concat_ws('-',
          tsinseiymd,
          shataino)",

    strategy='timestamp',
    updated_at='ldts',
    invalidate_hard_deletes=True,
  )
}}

select * from {{ ref('stg_mashotoroku') }} -- referenceでファイル名を指定

{% endsnapshot %}
