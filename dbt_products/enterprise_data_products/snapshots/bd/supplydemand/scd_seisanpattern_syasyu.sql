{% snapshot scd_seisanpattern_syasyu %}
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
geoss_line,
shimukechi_cd,
id,
syasyu_cd,
sno,
syamei,
dom_exp_cd,
model_name_cd,
unit_cd,
packing_tc_from,
packing_tc_to,
tc_from,
tc_to,
result_only_tc_from
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_seisanpattern_syasyu') }}
{% endsnapshot %}
