{% snapshot scd_katashiki_syasyuteigi %}
{{
config(
unique_key="concat_ws('-',
send_date,
syasyu_cd,
sno,
syamei,
dom_exp_cd,
model_name_cd,
unit_cd,
katashiki
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_katashiki_syasyuteigi') }}
{% endsnapshot %}
