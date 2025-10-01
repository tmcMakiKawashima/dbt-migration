{% snapshot scd_siyoumst_generate %}
{{
    config(
        unique_key="concat_ws('-'
       ,segmei
       ,renkey_hkata
       ,renkey_sedai
       ,renkey_keykbn
       ,renkey_keykmk
       ,ldts)",

        strategy='timestamp',
        updated_at='ldts',
        invalidate_hard_deletes=true,
    )
}}
select * from {{ ref('stg_siyoumst_generate') }}
{% endsnapshot %}