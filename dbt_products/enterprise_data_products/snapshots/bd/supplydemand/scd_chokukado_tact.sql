{% snapshot scd_chokukado_tact %}
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
tc_from,
tc_to
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_chokukado_tact') }}
{% endsnapshot %}
