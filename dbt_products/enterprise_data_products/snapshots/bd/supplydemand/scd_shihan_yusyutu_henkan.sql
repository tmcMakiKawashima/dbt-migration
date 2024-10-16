{% snapshot scd_shihan_yusyutu_henkan %}
{{
config(
unique_key="concat_ws('-',
send_date,
syasyu_cd,
sno,
syamei
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_shihan_yusyutu_henkan') }}
{% endsnapshot %}
