{% snapshot scd_siyoumst_check %}
{{
    config(
        unique_key="concat_ws('-'
       ,segmei
       ,renkey_hkata
       ,renkey_sedai
       ,renkey_psign
       ,renkey_keykbn
       ,renkey_chk
       ,renkey_renban
       ,ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_siyoumst_check') }}
{% endsnapshot %}