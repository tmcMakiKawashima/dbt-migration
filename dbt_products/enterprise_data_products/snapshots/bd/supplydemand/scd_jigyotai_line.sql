{% snapshot scd_jigyotai_line %}
{{
config(
unique_key="concat_ws('-',
send_date,
jpn_local_div,
areacd,
iff(country_cd is null, '', country_cd),
iff(psc is null, '', psc),
affiliate_cd,
plant_cd,
line_cd,
geoss_line,
shimukechi_cd,
tc_from,
tc_to
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_jigyotai_line') }}
{% endsnapshot %}
