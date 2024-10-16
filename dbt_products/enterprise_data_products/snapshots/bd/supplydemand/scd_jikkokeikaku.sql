{% snapshot scd_jikkokeikaku %}
{{
config(
unique_key="concat_ws('-',
send_date,
ym,
jpn_local_div,
areacd,
country_cd,
psc,
affiliate_cd,
plant_cd,
line_cd,
iff(geoss_line is null, '', geoss_line),
iff(shimukechi_cd is null, '', shimukechi_cd),
id,
syasyu_cd,
iff(daily_report_car_grcd is null, '', daily_report_car_grcd),
sno,
syamei,
model_name_cd,
unit_cd,
dom_exp_cd,
iff(update_reason is null, '', update_reason),
pcd_confirmed,
iff(employee_cd is null, '', employee_cd)
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_jikkokeikaku') }}
{% endsnapshot %}
