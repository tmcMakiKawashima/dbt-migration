{% snapshot scd_kokunaikatashiki_nippo %}
{{
config(
unique_key="concat_ws('-',
send_date,
ymd,
areacd,
country_cd,
psc,
affiliate_cd,
plant_cd,
line_cd,
geoss_line,
daily_report_car_grcd,
id,
syasyu_cd,
sno,
syamei,
model_name_cd,
unit_cd,
dom_exp_cd,
katashiki,
oem
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_kokunaikatashiki_nippo') }}
{% endsnapshot %}
