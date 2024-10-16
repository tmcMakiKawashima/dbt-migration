{% snapshot scd_linekado_calender %}
{{
config(
unique_key="concat_ws('-',
send_date,
jpn_local_div,
areacd,
country_cd,
psc,
affiliate_cd,
plant_cd,
line_cd,
year,
month,
day
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_linekado_calender') }}
{% endsnapshot %}
