{% snapshot scd_line_nippo_tokki %}
{{
config(
unique_key="concat_ws('-',
send_date,
ymd,
jpn_local_div,
areacd,
country_cd,
psc,
affiliate_cd,
plant_cd,
line_cd,
item_cd,
iff(shift_cd is null, '', shift_cd),
iff(process_cd is null, '', process_cd::varchar),
iff(reason_div_cd is null, '', reason_div_cd::varchar),
iff(reason_div1_cd is null, '', reason_div1_cd::varchar),
iff(reason_div2_cd is null, '', reason_div2_cd::varchar),
iff(stop_t is null, '', stop_t::varchar),
iff(ot is null, '', ot::varchar),
iff(memo is null, '', memo::varchar)
)",
strategy='timestamp',
updated_at='ldts',
invalidate_hard_deletes=true,
)
}}
select * from {{ ref('stg_line_nippo_tokki') }}
{% endsnapshot %}
