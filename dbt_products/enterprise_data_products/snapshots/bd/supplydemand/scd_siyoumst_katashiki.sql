{% snapshot scd_siyoumst_katashiki %}
{{
    config(
        unique_key="concat_ws('-'
       ,segmei
       ,renkey_hkata
       ,renkey_sedai
       ,ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_siyoumst_katashiki') }}
{% endsnapshot %}